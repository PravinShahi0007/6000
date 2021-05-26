unit CardAcos3U;

interface

uses
  Forms, Windows, system.ansistrings, SysUtils, strUtils, Classes, Dialogs, ExtCtrls, WinScard, CardAPIU, Des, lbProc, lbCipher,
  CardAcos3ConfigU, winUtils,  cardBaseU;
{$DEFINE USE_TRIPLEDES}
{$A-} // allignment off

type
  TCmd=packed record
    Cla, Ins, p1, p2, L: byte;
    constructor Create(ACla, AIns, Ap1, Ap2, AL: byte);
    procedure copyTo(var ADest);
  end;

  TSecureMessage= class
  public
    DataLength: Integer;
    Mac: TDESBlock;
    cmd_data: array [0..255] of byte;
    mac_Data: array [0..255] of byte;
    constructor CreateW(ACmd: TCmd; AData: pByte; ALen: byte; IV: TDESBlock; AKey: TKey128);
    constructor CreateR(ACmd: TCmd; ALen: byte; IV: TDESBlock; AKey: TKey128);
  end;

  TSession= class
  type
    TAUTH_Data=packed record
      EncRc_Kt        : TDESBlock; // = ENC(Rndc,Kt)
      FRandomDesBlock : TDESBlock;
    end;

    TSequence=packed record
      case Integer of
        0: (IV: TDESBlock);
    end;
  private
    function RandomBlock: TDESBlock; inline;
    function Reverse(AKey: TKey128): TKey128; inline;
    function concat(A, B: TDESBlock): TKey128; inline;
    procedure IncSequenceNumber;
  protected
    AUTH_Data : TAUTH_Data;
    SEQ_Data  : TSequence;
    RNDc      : TDESBlock;
    Kc        : TKey128;
    Kt        : TKey128;
    KS        : TKey128;

    constructor Create(ARandomDesBlock: TDESBlock; AKc, AKt: TKey128);
    procedure VerifyResponse(AResp: TDESBlock);
  end;


type
  TCardACOS3 = class(tCardBase) // ACOS-3
{$ALIGN 8}
  protected
    // cached records
    MCU_Data: MCU_Rec;
    MFG_DATA: MFG_Rec;
    PF_DATA: PF_Rec;
    IdentityData: TIdentityRec;
    ControlData: TControlRec;
    SCSData: TSCSDataRec;

  protected
    FSelectIX: Byte;
    FSelectedFileInfo: TFilespec;
    Session: TSession;
    function StageName: string;
    procedure Refresh;
    procedure SubmitCode(KeyID: uint8; Key: pByte);
    function CreateSecureMessage(ACmd: TCmd; Data: pByte; ALen: byte): TSecureMessage;
    procedure SelectFile(AFileID: UInt16);
    procedure ReadRecords(ARec, ALen: byte; Data: pByte; nRec: UInt16=1);
    procedure ReadRecord(ARec, ALen: byte; Data: pByte);
    procedure WriteRecord(ARecNo, ALen: byte; Data: pByte);
    procedure WriteSCSData;
    function UserMode: Boolean;
    function Stage: byte;
  public
    constructor Create(AName: string); override;
    function canFormat: boolean; override;
    function canLoad: boolean; override;
    procedure StartSession;
    function Signature: ansiString; override;
    function SerialNumber: DWord; override;
    function IssuedTO: ansiString; override;
    function MetresIssued: integer; override;
    function ChargeScheme: TChargeType; override;

    function getIssueDate: TDateTime; override;
    function getExpiryDate: TDateTime; override;
    function getMetres: integer;  override;
    procedure setMetres(AValue: integer); override;
    procedure AddMetres(N: Integer; AExpDate: TDateTime); // for future
    {$IFDEF CARDMASTER}
  public
    // these methods require the IssuerCode and are available only in CardMaster
    procedure PresentIssuerCode;
    procedure FormatCard(AProduct: ansiString); override;
    procedure LoadMetres(ASerialNumber: integer; IssuedTO: ansiString; AChargeScheme: TChargeType;
                                    AMetres: integer; AExpiryDate: TDateTime); override;
    procedure AddInfo(ALines: tStrings); override;
  private
    procedure InitSCSFiles(AProduct: ansiString);
    procedure MakeFiles;
  protected
    procedure ClearCard;   // unused
    {$ENDIF}

  end;
{$A-}

var UseDes3: boolean;

implementation

function Encrypt(const Data: pByte; const desKey: TKey128): TDESBlock;
var
 Context1: TDESContext;
 Context3: TTripleDESContext;
 desKey1: TKey64 absolute desKey;
begin
  Move(Data^, result, 8);
  if UseDes3 then
  begin
    InitEncryptTripleDES(desKey, Context3, true);
    EncryptTripleDES(Context3, result);
  end else
  begin
    InitEncryptDES(desKey1, Context1, true);
    EncryptDES(Context1, result);
  end;
end;

function EncryptKey(const Data: TAcosKey; const desKey: TKey128): TDESBlock;
begin
  result := Encrypt(@Data, desKey);
end;

function CBC_MAC(Data: pByte; ALength: Integer; IV: TDESBlock; const des3Key: TKey128): TDESBlock;
var
  NBlocks     : Integer;
  Prev        : TDESBlock;
  Block       : TDESBlock;
  N           : Integer;
  ContextDesL : TDESContext;
  Context3Des : TTripleDESContext;
  DeskeyL     : TKey64; // 3-Des left
begin
  Assert(ALength mod 8 = 0, 'Length for MAC');
  move(des3Key,DesKeyL,8);
  NBlocks := ALength div 8;
  InitEncrypttripleDES(des3Key, Context3Des,true);
  InitEncryptDES(DeskeyL, ContextDesL,true);
  Prev := IV;
  for N := 0 to NBlocks-1 do
  begin
    Move(Data^, Block, 8);
    { non-standard CBC_MAC consistent with ACOS 3 implementation
      Retail Mac Standard uses Triple Des on final block only }
    If UseDes3 then
      EncryptTripleDESCBC(Context3Des, Prev, { var } Block)// Triple DES
    else
      EncryptDESCBC(ContextDesL, Prev, { var } Block); // Single DES
    Prev := Block;
    Data := Data+8;
  end;
  result := Block;
end;

procedure EncryptCBC(Source, Dest: pByte; ALength: Integer; IV: TDESBlock; const Deskey: TKey128; AEncrypt: boolean);
var
  NBlocks : Integer;
  Prev    : TDESBlock;
  Block   : TDESBlock;
  N       : Integer;
 Context1 : TDESContext;
 Context3 : TTripleDESContext;
 desKey1  : TKey64 absolute desKey;
begin
  Assert(ALength mod 8 = 0, 'Length for CBC');
  NBlocks := ALength div 8;
  if UseDes3 then
    InitEncryptTripleDES(desKey, Context3, AEncrypt)
  else
    InitEncryptDES(desKey1, Context1, AEncrypt);

  Prev := IV;
  for N := 0 to pred(NBlocks) do
  begin
    Move(Source^, Block, 8);
   if UseDes3 then
     EncryptTripleDESCBC(Context3, Prev, { var } Block)
   else
     EncryptDESCBC(Context1, Prev, { var } Block);

    Move(Block, Dest^, 8);
    if AEncrypt then
      Prev := Block // this block (encrypted)
    else
      Move(Source^, Prev, 8); // this block (encrypted)

    Source := Source+8;
    Dest := Dest+8;
  end;
end;

function AnsiArrayToAnsiString(ACharArray: array of ansichar; N: integer): ansiString;
var
  I: Integer;
  c: AnsiChar;
begin
  result := '';
  for i:=0 to N-1 do
  begin
    c := ACharArray[i];
    if c=#0 then
      break;
    result := result+c;
  end;
end;

{ TCardACOS3 }

constructor TCardACOS3.Create(AName: string);
begin
  Randomize;
  inherited;
  try
    Refresh;
  except
     ; // ignore
  end;
  FCardName := format('%s-%dk', [AName, MCU_Data.Capacity]);
end;

function TCardACOS3.canLoad: boolean;
begin
  result := PF_DATA.nFiles>0;
end;

procedure TCardACOS3.SubmitCode(KeyID: uint8; Key: pByte);
begin
  SendCommand($80, $20, KeyID, 0, KEYLEN, Key); // submit key
end;

function TCardACOS3.UserMode: Boolean;
begin
  result := Stage=0;
end;

function TCardACOS3.canFormat: boolean;
begin
  result := (Stage in [1, 2]);
end;

function TCardACOS3.Stage: byte;
begin
  result := CardApi.ATR[5+12];     // T12 in documentation
end;

function TCardACOS3.StageName: string;
begin
  case Stage of
    0:   Result := 'User';
    1:   Result := 'Manufacturer';
    2:   Result := 'Personalisation';
    else Result := 'Invalid ' + inttohex(Stage, 2);
  end;
end;

procedure TCardACOS3.AddMetres(N: Integer; AExpDate: TDateTime);
var
  newDataRec: TSCSDataRec;
  NextRecID: uint32;
  EncK: TDesBlock;
begin
// add metres to current metres-remaining
// store in new data record (to avoid exceeding write cycle limit on eprom cells)
// update control record to point at new record.
  fillchar(newDataRec, sizeof(newDataRec), 0);
  NextRecID := (ControlData.CurrentRec + 31 ) mod 100; // select a new 'random' record position

  newDataRec.LastUpdate := SCSConfig.GetIssuerInfo;
  newDataRec.WriteCount := 1;
  newDataRec.PrevRec := ControlData.CurrentRec;
  newDataRec.MetresIssued := N;
  newDataRec.MetresBfwd := SCSData.MetresRemaining ;
  newDataRec.MetresRemaining := newDataRec.MetresBfwd+N;
  newDataRec.Expiry := Trunc(AExpDate);

  SelectFile(FILE_DATA);
  WriteRecord( NextRecID, sizeof(newDataRec), @newDataRec);

  EncK := EncryptKey(SCSConfig.AcosKey[KEYREC_AC1], Session.KS);
  SubmitCode(KEY_AC1, @EncK);
  SelectFile(FILE_CONTROL);
  ControlData.CurrentRec := NextRecID;
  WriteRecord(0, sizeof(ControlData), @ControlData);

  SelectFile(FILE_DATA);
  ReadRecord( NextRecID, sizeof(SCSData), @SCSData);  // read back new data
end;

function TCardACOS3.Signature: ansiString;
begin
  result := AnsiArrayToAnsiString(IdentityData.Product, sizeof(IdentityData.Product));
end;

function TCardACOS3.SerialNumber: DWord;
begin
  result := IdentityData.SerialNumber;
end;

procedure TCardACOS3.setMetres(AValue: integer);
begin
  SCSData.MetresRemaining := AValue;
  WriteSCSData;
end;

function TCardACOS3.IssuedTO: ansiString;
begin
  result := AnsiArrayToAnsiString(IdentityData.IssuedTo, sizeof(IdentityData.IssuedTo));
end;

function TCardACOS3.MetresIssued: integer;
begin
   result := SCSData.MetresIssued;
end;

function TCardACOS3.getExpiryDate: TDateTime;
begin
  result := SCSData.Expiry;
end;

function TCardACOS3.getIssueDate: TDateTime;
begin
  result := TimeStampToDateTime(ControlData.Issuer.TimeStamp);
end;

function TCardACOS3.getMetres: integer;
begin
  result := SCSData.MetresRemaining
end;

function TCardACOS3.ChargeScheme: TChargeType;
begin
  result := IdentityData.ChargeScheme;
end;

procedure TSession.IncSequenceNumber;
begin
{$OVERFLOWCHECKS OFF}
  Inc(SEQ_Data.IV[7]);
  if (SEQ_Data.IV[7]=$00) then
    Inc(SEQ_Data.IV[6]);
//  main.Memo1 .lines.Add(format('CMDSEQ=%s',[MemToHex(@SEQ_Data.IV,8)]));
{$OVERFLOWCHECKS ON}
end;

function TCardACOS3.CreateSecureMessage(ACmd: TCmd; Data: pByte; ALen: byte): TSecureMessage;
begin
  Session.IncSequenceNumber;
  if Data<>nil then
    result := TSecureMessage.CreateW(ACmd, Data, ALen, Session.SEQ_Data.IV, Session.KS) // Write
  else
    result := TSecureMessage.CreateR(ACmd, ALen, Session.SEQ_Data.IV, Session.KS) // Read
end;

procedure TCardACOS3.WriteSCSData;
begin
  if FSelectedFileInfo.ID <> FILE_DATA then
    SelectFile(FILE_DATA);
  assert (sizeof(TSCSDataRec)= FSelectedFileInfo.RecLen);
  inc(SCSData.WriteCount);
  WriteRecord(ControlData.CurrentRec, sizeof(SCSData), @SCSData);
end;

procedure TCardACOS3.StartSession;
var
  AuthResponse : TDESBlock;
  aRandomDes   : TDESBlock;
begin
  FreeAndNil(Session);
  SendCommand($80, $84, 0, 0, KEYLEN); // start session

  FResponse.CopyData(@aRandomDes);
  Session := TSession.Create(aRandomDes, SCSConfig.Kc, SCSConfig.Kt );
  SendCommand($80, $82, 0, 0, 16, @Session.AUTH_Data); // Authenticate
  SendCommand($80, $C0, 0, 0, 8); // get response

  FResponse.CopyData(@AuthResponse);
  Session.VerifyResponse(AuthResponse);
end;

procedure TCardACOS3.WriteRecord(ARecNo, ALen: byte; Data: pByte);
var
  SecureMessaging: boolean;
  SM: TSecureMessage;
  Cmd: TCmd;
begin
  assert(ALen>0);
  SecureMessaging:=(FSelectedFileInfo.AccessFlags and SM_WRITE) <> 0;
  if SecureMessaging then  // ref. 4.4 Secure Messaging
  begin
    if Session=nil then
      raise ECardSecuity.Create('Session Required');
    if (ALen mod 8<>0) then // padding not implemented
      raise ECardIO.Create('Length');
    Cmd := TCmd.Create($8C, $D2, ARecNo, 0, ALen);
    SM := CreateSecureMessage(Cmd, Data, ALen);
    try
      SendCommand($8C, $D2, ARecNo, 0, SM.DataLength, @SM.cmd_data[0]); // write one record with secure messaging
      Session.IncSequenceNumber;
      assert(FResponse.SW1=$61);
      SendCommand($80, $C0, 0, 0, FResponse.SW2); // get response
      // response length is 10 + 2 status bytes:  SW2 returns 10 & GetResponse() expects 10
      // get SW1,SW2 from response. ref. 4.4.8.1 ISO_OUT
      // option to Check response MAC
      CheckResponse( FResponse.RawData[2],FResponse.RawData[3]);
    finally
      SM.Free;
    end;
  end else
    SendCommand($80, $D2, ARecNo, 0, ALen, Data); // write one record
end;

procedure TCardACOS3.ReadRecord(ARec, ALen: byte; Data: pByte);
var
  SM: TSecureMessage;
  Cmd: TCmd;
  L87,  Pi: UInt8;
  DecodedData: array [0..255] of byte;
  SecureMessaging: boolean;
begin
  assert(ALen>0);
  SecureMessaging:=(FSelectedFileInfo.AccessFlags and SM_READ) <> 0;
  if SecureMessaging then // ref. 4.4 Secure Messaging
  begin
    if Session=nil then
      raise ECardSecuity.Create('Session Required');
    if (ALen mod 8<>0) then // padding not implemented
      raise ECardSecuity.Create('Length');

    fillchar(DecodedData, 255, 0);
    Cmd := TCmd.Create($8C, $B2, ARec, 0 {p2}, ALen);
    SM := CreateSecureMessage(Cmd, nil, ALen);
    try
      SendCommand($8C, $B2, ARec, 0, SM.DataLength, @SM.cmd_data[0]); // read one record with secure messaging
      Session.IncSequenceNumber;

      assert(FResponse.SW1=$61);
      SendCommand($80, $C0, 0, 0, FResponse.SW2); // get response
      // get SW1,SW2 from response ref. 4.4.8.2 ISO_IN
      // option to Check response MAC
      L87:=FResponse.RawData[1];
      Pi:=FResponse.RawData[2];
      Assert(Pi=0); // no padding support
      CheckResponse( FResponse.RawData[L87+4],FResponse.RawData[L87+5]);
      EncryptCBC(@FResponse.RawData[3], @DecodedData[0], L87-1, Session.SEQ_Data.IV, Session.KS ,false{ Decrypt});
      Move(DecodedData[0], Data^, ALen);
    finally
      SM.Free;
    end;
  end else
  begin
    SendCommand($80, $B2, ARec, 0 {p2}, ALen); // read one record
    Move(FResponse.RawData, Data^, ALen);
  end;
end;

procedure TCardACOS3.ReadRecords(ARec, ALen: byte; Data: pByte; nRec: UInt16=1);
var N: UInt16;
begin
  for N := 0 to pred(nRec) do
  begin
    SendCommand($80, $B2, ARec+N, 0, ALen); // read one record
    FResponse.copyData(Data);
    Inc(Data, ALen);
  end;
end;

procedure TCardACOS3.Refresh;
var EncK: TDESBLOCK;
begin
  if (CardApi.hContext <> 0) and (CardApi.CardState = csCard) then
  begin
    FillChar(PF_DATA,      SizeOf(PF_DATA), 0);
    FillChar(MCU_Data,     SizeOf(MCU_Data),  0);
    FillChar(MFG_DATA,     SizeOf(MFG_DATA),  0);
    FillChar(IdentityData, SizeOf(IdentityData),0);
    FillChar(ControlData,  SizeOf(ControlData),0);
    FillChar(SCSData,      SizeOf(SCSData),0);

    // read Personalization File first to get security bits
    SelectFile(FILE_PERS);
    ReadRecords(0, 4, @PF_DATA, 3); // read three 4-byte records
    UseDes3:=(PF_Data.OptionsRegister and $02) <> $00;

    SelectFile(FILE_MCU_ID);         // MCU_ID File
    ReadRecords(0, 8, @MCU_Data, 2); // read two 8-byte records

    SelectFile(FILE_MFG);           // Manufacture File
    ReadRecords(0, 8, @MFG_DATA, 2);// read two 8-byte records

    if (PF_Data.NFiles >0) and UserMode then
    begin
      StartSession;
      SelectFile(FILE_IDENTITY);
      ReadRecord(0, SizeOf(IdentityData), @IdentityData);
      SelectFile(FILE_CONTROL);
      ReadRecord(0, SizeOf(ControlData), @ControlData);

      EncK := EncryptKey(SCSConfig.AcosKey[KEYREC_AC2], Session.KS);
      SubmitCode(KEY_AC2, @EncK);
      SelectFile(FILE_DATA);
      ReadRecord(ControlData.CurrentRec, SizeOf(SCSData), @SCSData);
    end;
  end;
end;

function SysFile(AFileID: UInt16): boolean;
begin
    result :=(AFileID and $ff)=$ff ;
end;

procedure TCardACOS3.SelectFile(AFileID: UInt16);
begin
  FillChar( FSelectedFileInfo, SizeOf(FSelectedFileInfo),0);
  SendCommand($80, $A4, 0, 0, 02, @AFileID);     // Select the target file

  if SysFile(AFileID) then
  begin
    // all 00x ==> no SM, record file
    // other values not set for system files
    FSelectedFileInfo.ID := AFileID;
  end else
  begin
    // read the file descriptor for the selected file
    FSelectIX := FResponse.sw2;
    SelectFile(FILE_FIILEDEF);
    ReadRecord(FSelectIX, Sizeof(TFileSpec), @FSelectedFileInfo);
    assert(FSelectedFileInfo.ID  = AFileID);
    // re-select the target file
    SendCommand($80, $A4, 0, 0, 02, @AFileID);
  end;
end;

{$IFDEF CARDMASTER}
procedure TCardACOS3.PresentIssuerCode;
var
  IC: string[9];
  PlainKey: TACosKey;
  EncK: TDESBlock  ;
begin
  if Stage in [1,2] then  // not formatted
  begin
    IC := ansiString('ACOSTEST');
    SubmitCode(KEY_IC, @IC[1]);
  end else
  if (PF_DATA.SecurityRegister and $80 )= 0 then // unencrypted
  begin
    PlainKey := SCSConfig.AcosKey[KEYREC_IC];
    SubmitCode(KEY_IC, @PlainKey);
  end else
  begin
    if session=nil then
      startSession;
    EncK := EncryptKey(SCSConfig.AcosKey[KEYREC_IC], Session.KS);
//    main.Memo1.Lines.Add('PresentIssuerCode encrypted' );
    SubmitCode(KEY_IC, @EncK);
  end;
end;

procedure TCardACOS3.FormatCard(AProduct: ansiString);
var
  KeyID: TKEY_RECID;
  procedure WriteKey(AKeyID: TKEY_RECID);
  var key: TAcosKey;
  begin
    key :=  SCSConfig.AcosKey[AKeyID];
    WriteRecord(ord(AKeyID), KEYLEN, @Key);
  end;
begin
// STEP NUMBERS: ref. 7.0 Card Personalisation

// STEP 2
  PresentIssuerCode;
// STEP 3
  SelectFile(FILE_MFG); // MFG File
  ReadRecord(0, 8, @MFG_DATA); // read first 8-byte record (file is 2 records of 8 bytes

  if not MFG_DATA.MFG_Bit then
  begin
   MFG_DATA.MFG_Bit := True;     // mfg fuse, 0-based records
   WriteRecord(0, 8, @MFG_DATA); // re-write record
  end;

// STEP 4 & 9 & 13
  SelectFile(FILE_PERS); // Personalization File  ref. 3.3.3


  if (PF_DATA.P_Status and $80) = $00 then
  begin
    PF_DATA.P_Status := $80;
    PF_DATA.NFiles := TAcosConfig.NFiles;
    PF_DATA.SecurityRegister := $7E;    // all keys encrypted - NOT IC
    {$IFDEF USE_TRIPLEDES}
      PF_DATA.OptionsRegister  := $02;   // 3-DES
      UseDes3:=true;
    {$ELSE}
      PF_DATA.OptionsRegister  := $00;   // 1-DES
      UseDes3 := false;
    {$ENDIF}
    WriteRecord(0, 4, @PF_DATA.Data[0]); // write Personalisation file
  end;
// STEP 12
   SelectFile(FILE_SECURITY);
   for KeyID:= low(TKEY_RECID) to high(TKEY_RECID) do
     if not (KeyID in [ KEYREC_RETRY_CNT, KEYREC_RETRY_SCN, KEYREC_RNDSEED])  then // skip these
     begin
       WriteKey(KeyID);
     end;




// STEP 5
   CardApi.Reconnect(SCARD_RESET_CARD);
   CardAPI.RefreshCardState; // after format, refresh ATR to get correct state

// STEP 6
    PresentIssuerCode;

// STEP 7
    MakeFiles;     // write file definition blocks with security attributes

// STEP 8 - NOT NOW

// STEPS 10,11 n/a

// STEP 13 see #4

// STEP 14
   CardApi.Reconnect(SCARD_RESET_CARD);

// STEP 8 - RE-ESTABLISH KEYS

  startsession;
  InitSCSFiles(AProduct);
end;

procedure TCardACOS3.LoadMetres(ASerialNumber: integer; IssuedTO: ansiString; AChargeScheme: TChargeType;
                                   AMetres: integer; AExpiryDate: TDateTime);
var EncK: TDESBLOCK;
begin
  if canFormat then
    raise Exception.Create('Card not Formatted card signature');

  PresentIssuerCode;
  EncK := EncryptKey(SCSConfig.AcosKey[KEYREC_AC1], Session.KS);
  SubmitCode(KEY_AC1, @EncK);
  EncK := EncryptKey(SCSConfig.AcosKey[KEYREC_AC2], Session.KS);
  SubmitCode(KEY_AC2, @EncK);


  SelectFile(FILE_IDENTITY);
//  System.AnsiStrings.StrPLCopy(@IdentityData.Product, 'SCSTRUSS', sizeof(IdentityData.Product));   // 'SCSTRUSS' / 'SCSPANEL'


  IdentityData.SerialNumber := ASerialNumber;
  IdentityData.Issuer := SCSConfig.GetIssuerInfo;
  IdentityData.ChargeScheme := AChargeScheme;
  IdentityData.Schema := CURRENTSCHEMA ;
  System.AnsiStrings.StrPLCopy(@IdentityData.IssuedTo, IssuedTO, sizeof(IdentityData.IssuedTo));
  WriteRecord(0, sizeof(TIdentityRec), @IdentityData);

  SelectFile(FILE_CONTROL);
  ControlData.Issuer := SCSConfig.GetIssuerInfo;
  WriteRecord(0, sizeof(ControlData), @ControlData);

  SCSData.LastUpdate := SCSConfig.GetIssuerInfo;
  SCSData.MetresBfwd := 0;
  SCSData.MetresIssued := AMetres;
  SCSData.MetresRemaining := AMetres;
  SCSData.Expiry := trunc(AExpiryDate);
  WriteSCSData;
end;

procedure TCardACOS3.AddInfo(ALines: tStrings);
begin
  inherited;
  ALines.Add('STAGE '+StageName);
  ALines.Add(format('Record # = %d', [ControlData.CurrentRec]));
//  ALines.Add(format('NFILES = %d', [PF_Data.NFiles]));

  if  PF_Data.NFiles>0 then
  begin
    ALines.Add(Signature);
    if IssuedTO<>'' then
    begin
      ALines.Add(IssuedTO );
      ALines.Add(ChargeSchemeStr(IdentityData.ChargeScheme));
    end;
    if ControlData.Issuer.TimeStamp.Date <> 0 then
    begin
      ALines.Add('Issue Date = ' + FormatDateTime('dd mmm yyyy hh:mm', IssueDate));
      ALines.Add('Last update = ' + formatDateTime('dd/mm/yyy hhhh:mm', TimeStampToDateTime(SCSData.LastUpdate.TimeStamp)));
    end;
    if isUnlimitedMetres then
    begin
      ALines.Add('Metres run = ' + floatToStr(abs(Metres)));
      ALines.Add('expires = '+formatDateTime('dd/mm/yyyy', SCSData.Expiry));
    end
    else
      ALines.Add('metres = '+inttostr(SCSData.MetresRemaining));
  end;
end;

procedure TCardACOS3.InitSCSFiles(AProduct: ansiString);
var
  EncK: TDESBLOCK;
begin
  FillChar(IdentityData, SizeOf(IdentityData),0);
  FillChar(ControlData,  SizeOf(ControlData),0);
  FillChar(SCSData,      SizeOf(SCSData),0);

  PresentIssuerCode;                        // is this neded?
  EncK := EncryptKey(SCSConfig.AcosKey[KEYREC_AC1], Session.KS);
  SubmitCode(KEY_AC1, @EncK);
  EncK := EncryptKey(SCSConfig.AcosKey[KEYREC_AC2], Session.KS);
  SubmitCode(KEY_AC2, @EncK);

  SelectFile(FILE_IDENTITY);
  assert (sizeof(TIdentityRec)=FSelectedFileInfo.RecLen);
  IdentityData.Issuer := SCSConfig.GetIssuerInfo;
  IdentityData.Schema := CURRENTSCHEMA;
  System.AnsiStrings.StrPLCopy(@IdentityData.Product, AProduct, sizeof(IdentityData.Product));   // 'SCSTRUSS' / 'SCSPANEL'
  WriteRecord(0, sizeof(TIdentityRec), @IdentityData);

  SelectFile(FILE_CONTROL);
  assert (sizeof(TControlRec)= FSelectedFileInfo.RecLen);
  ControlData.Issuer := SCSConfig.GetIssuerInfo;
  ControlData.CurrentRec:=0;
  WriteRecord(0, sizeof(ControlData), @ControlData);

  SelectFile(FILE_DATA);
  Assert (SizeOf(TSCSDataRec)= FSelectedFileInfo.RecLen);
  SCSData.LastUpdate := SCSConfig.GetIssuerInfo;
  SCSData.WriteCount := 1;
  WriteRecord(0, SizeOf(SCSData), @SCSData);
end;

procedure TCardACOS3.MakeFiles;
begin
  SelectFile(FILE_FIILEDEF);
  for var i := 0 to pred(SCSConfig.NFiles) do
     WriteRecord(i, Sizeof(TFileSpec), @SCSConfig.FileSpec[i]);
end;

procedure TCardACOS3.ClearCard;
begin
  PresentIssuerCode;
  SendCommand($80, $30, 0, 0, 0);
  Refresh; // updated cached records
end;
{$ENDIF}

{ TSecureMessage}

constructor TSecureMessage.CreateW(ACmd: TCmd; AData: pByte; ALen: byte; IV: TDESBlock; AKey: TKey128);
var
  i: Integer;
  P3, L87: byte;
  EncodedData: array [0..255] of byte;
begin
  fillchar(EncodedData, 255, 0);
  if (ALen mod 8<>0) then // padding not implemented
    raise ECardSecuity.Create('Length');
  L87 := ALen+1;
  P3 := 3 + ALen+2 + 4;

  EncryptCBC(AData, @EncodedData[0], ALen, IV, AKey, true);

  mac_Data[0] := $89; // mac-data tag
  mac_Data[1] := $04; // cla/ins/p1/p2
  ACmd.copyTo(mac_Data[2]); // 4 bytes of command
  mac_Data[6] := $87; // encoded-data tag
  mac_Data[7] := L87; // encoded-data length + 1
  mac_Data[8] := $00; // Pi
  Move(EncodedData, mac_Data[9], ALen);
  i := 9+ALen;
  mac_Data[i] := $80; // 1st padding byte (others are $00)
  i := (i+7) AND $F8; // round up to multiple of 8

  Mac := CBC_MAC(@mac_Data[0], i, IV, AKey);

  cmd_data[0] := $87; // encoded-data tag
  cmd_data[1] := L87; // encoded-data length + 1
  cmd_data[2] := $00; // Pi
  Move(EncodedData, cmd_data[3], ALen);
  i := 3+ALen;
  cmd_data[i] := $8E; // MAC tag
  Inc(i);
  cmd_data[i] := $04; // MAC length
  Inc(i);
  Move(Mac[0], cmd_data[i], 4); // 1st 4 bytes only
  Inc(i, 4);
  Assert(i=P3);

  DataLength := i;
end;

constructor TSecureMessage.CreateR(ACmd: TCmd; ALen: byte; IV: TDESBlock; AKey: TKey128);
var
  i: Integer;
begin
  mac_Data[0] := $89;   // mac-data tag
  mac_Data[1] := $04;   // cla/ins/p1/p2
  ACmd.copyTo(mac_Data[2]); // 4 bytes of command
  mac_Data[6] := $97;  // P3 tag
  mac_Data[7] := $01;  // P3 length
  mac_Data[8] := ALen; // original P3
  mac_Data[9] := $80;  // 1st padding byte (others are $00)
  i := 16;             // round up to multiple of 8

  Mac := CBC_MAC(@mac_Data[0], i, IV, AKey);

  cmd_data[0] := $97; // P3 tag
  cmd_data[1] := $01; // P3 length
  cmd_data[2] := ALen; // original P3
  cmd_data[3] := $8E; // MAC tag
  cmd_data[4] := $04; // MAC length
  Move(Mac[0], cmd_data[5], 4); // 1st 4 bytes only

  DataLength := 9;
end;

{ TSession }

constructor TSession.Create(ARandomDesBlock: TDESBlock; AKc, AKt: TKey128);
var
  KS1  : TDESBlock;
  KS2  : TDESBlock;
  Temp : TDESBlock;
begin
  RNDc := ARandomDesBlock;
  Kc   := AKc;
  Kt   := AKt;
  AUTH_Data.FRandomDesBlock := RandomBlock;

  SEQ_Data.IV[6] := ARandomDesBlock[6]; // copy last 2 bytes for Seq#
  SEQ_Data.IV[7] := ARandomDesBlock[7];
{
  main.Memo1 .lines.Add('TSESSION.CREATE');
  main.Memo1 .lines.Add(format('USE3Des=%s',[TF(usedes3)]));
  main.Memo1 .lines.Add(format('RNDc=%s',[MemToHex(@ARNDc,8)]));
  main.Memo1 .lines.Add(format('RNDt=%s',[MemToHex(@AUTH_Data.RNDt,8)]));
  main.Memo1 .lines.Add(format('SEQ=%s',[MemToHex(@SEQ_Data.IV,8)]));
}
  AUTH_Data.EncRc_Kt := Encrypt(@RNDc, Kt);
  if useDes3 then
  begin
    Temp := Encrypt(@RNDc, Kc);
    KS1 := Encrypt(@Temp, Kt);
    KS2 := Encrypt(@AUTH_Data.FRandomDesBlock, reverse(Kt));
    self.KS := concat(KS1, KS2);
  end
  else
  begin
    Temp := Encrypt(@RNDc, Kc);
    XOrMem(Temp, AUTH_Data.FRandomDesBlock,8);
    KS1 := Encrypt(@Temp, Kt);

    fillchar(KS2,8,0);
    self.KS := concat(KS1, KS2);
  end
end;

function TSession.RandomBlock: TDESBlock;
var
  aNumbers : Array [0..1] of UInt32 absolute result;
begin
  aNumbers[0] := Random(MAXINT);
  aNumbers[1] := Random(MAXINT);
end;

function TSession.reverse(AKey: TKey128): TKey128;
begin
  Move(AKey[0], result[8], 8);
  Move(AKey[8], result[0], 8);
end;

function TSession.concat(A, B: TDESBlock): TKey128;
begin
  Move(A[0], result[0], 8);
  Move(B[0], result[8], 8);
end;

procedure TSession.VerifyResponse(AResp: TDESBlock);
var
  EncRt_Ks : TDESBlock;
begin
  EncRt_Ks := Encrypt(@AUTH_Data.FRandomDesBlock, KS);
  if not CompareMem(@AResp, @EncRt_Ks, 8) then
    raise ECardSecuity.Create('Acos3 Authenticate');
end;

constructor TCmd.Create(ACla, AIns, Ap1, Ap2, AL: byte);
begin
  Cla := ACla;
  Ins := AIns;
  p1 := Ap1;
  p2 := Ap2;
  L := AL;
end;

procedure TCmd.copyTo(var ADest);
begin
  Move(self, ADest, sizeof(self));
end;

end.


