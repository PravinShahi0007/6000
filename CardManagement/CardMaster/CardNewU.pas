unit CardNewU;
(***************************************************************
  "new" card (Gemplus GemClub 1K)
***************************************************************)

interface

uses
  Windows, SysUtils, strUtils, Classes, ExtCtrls, WinScard, CardAPIU, Des, lbProc, lbCipher;
{$RANGECHECKs OFF}   // confusion in WinSCard between longint/cardinal/uint32 for results
type
  ECardIO = class(Exception)
    Constructor Create(Sw1, Sw2: byte); reintroduce; overload;
    Constructor Create(Res: integer); reintroduce; overload;
  end;

  ECardTamper = class(Exception)
    Constructor Create(s: string); reintroduce;
  end;

  TCardResponse = record
    RawData: array[0 .. 127] of byte;
    Length: DWord;
    procedure Clear;
    function Sw1: byte;
    function Sw2: byte;
    procedure getData(var Res: TBytes);
    function Data: TBytes;
    function AsWord: LongWord;
  end;

type
  tCardBase = class
  private
    FResponse: TCardResponse;
    function ReadString(Address: byte; ByteCount: integer): ansiString;
    procedure WriteBytes(Address: byte; ABytePtr: pByte; nBytes: integer = 4);
  protected
    Procedure SendCommand(Cla, Ins: byte; p1, p2: byte; Le: byte; pData: pByte =nil);
    procedure WriteWord(Address: byte; Value: LongWord);
    procedure WriteString(Address: byte; Value: ansiString; nBytes: integer);
    function ReadWord(Address: byte): LongWord;
  public
    constructor Create;
    destructor Destroy; override;
    procedure FormatCard(Ident: ansiString; AChargeScheme: TChargeType); virtual;
    procedure LoadMetres(ASerialNumber: integer; IssuedTO: ansiString; Metres: integer;  AIssueDate,AExpiryDate: TDateTime); virtual;
    function ChargeScheme: TChargeType; virtual;  // [ccGreen, ccRed, ccNoCharge]
  end;

  TCardClubMemo = class(tCardBase)
  private const
    MAP_MFG = $00;
    MAP_SIGNATURE = $01;       // 'SCSTRUSS' / 'SCSPANEL'
    MAP_UID = $03;             // random integer - not used
    MAP_ISSSUERBits = $04;     // high byte ISSSUER/USER Flag. Low byyte=card type
    MAP_ACCESS = $05;          //
    MAP_CSC0 = $06;
    MAP_CTC1 = $08;
    MAP_BAL1 = $0C;
    // user area #1 16 words (64 bytes) ---------------------------------
    MAP_USER1 = $10;        // 4 Words (16 Bytes) Encrypted Balance & CSC
    //-------------------------------------------------------------------
    MAP_CTC2 = $20;
    MAP_BAL2 = $24;
    // user area #2 16 words (64 bytes) ---------------------------------
    MAP_ISSUEDTO     = $28; // 4 words (16 Bytes)
                            // 7 words spare
    MAP_EXPIRYDATE   = $33;  // 1 Word
    MAP_SERIAL       = $34; // 1 Word
    MAP_METRESISSUED = $35; // 1 Word
    MAP_ISSUEDATE    = $36; // 1 Word
    MAP_ISSUETIME    = $37; // 1 Word
    //-------------------------------------------------------------------
    MAP_CSC1 = $38;
    MAP_CSC2 = $3A;
    ACCESSCONDITION = $00;
    // actual keys are key constant xor key_key)
    key_EkeySeed1: DWord = $BFF0E868; // see EKey() for actual key
    key_EkeySeed2: DWord = $8DB3E7CE;
    key_csc1: DWord = $6541C233;
  private
    FIssuerByte: byte;
    FChargeScheme: TChargeType;
    function getIssueDate: TDateTime;
    function getMetres: integer;
    procedure setMetres(AValue: integer);
    function key_key: DWord; inline;
    procedure ValidateMetres(AValue: integer);
    function EKey: TKey128; inline;
    procedure VerifyCSC(CSCID: byte; AValue: DWord);
    function  getExpiryDate: TDateTime;
 {$ifdef CARDMASTER}
  private
    // avoid generating code for these methods except for in-house uses
  const
    key_csc0: DWord = $A4742928;
    key_csc2: DWord = $86C5F539;
    function isKnownSignature: boolean;
    procedure setIssueDate(ADate: TDateTime);
    procedure setExpiryDate(ADate: TDateTime);
  public
    procedure FormatCard(Signature: ansiString; AChargeScheme: TChargeType); override;
    procedure LoadMetres(ASerialNumber: integer; IssuedTO: ansiString; AMetres: integer; AIssueDate,AExpiryDate: TDateTime); override;
    procedure AddInfo(ALines: tStrings);
 {$endif}
  public
    constructor Create;
    procedure Refresh;
    function isUserMode: boolean; virtual;
    function Signature: ansiString;
    function SerialNumber: DWord;
    function IssuedTO: ansiString;
    function MetresIssued: integer;
    property Metres: integer read getMetres write setMetres;
    property IssueDate: TDateTime read getIssueDate;
    property ExpiryDate: TDateTime read  getExpiryDate  {$ifdef CARDMASTER} write setExpiryDate {$ENDIF};
    function ChargeScheme: TChargeType; override;
    function CheckCardOK(const ASignature: ansiString): boolean;
    function isUnlimitedMetres: boolean;
  end;

implementation

{ tCardBase }

constructor tCardBase.Create;
begin
  inherited Create;
  if (CardApi.hContext <> 0) and (CardApi.CardState = csCard) then
    try
      SCardConnectW(CardApi.hContext, @CardApi.FReader[1], SCARD_SHARE_SHARED, SCARD_PROTOCOL_T0 or SCARD_PROTOCOL_T1, CardApi.hCard, @CardApi.dwActProtocol);
    except
    end;
end;

destructor tCardBase.Destroy;
begin
  assert(CardApi<>nil,'internal error - object finalization'); // card api must be freed after clients
  if (CardApi.hContext <> 0) and (CardApi.hCard <> 0) then
    SCardDisconnect(CardApi.hCard, SCARD_LEAVE_CARD);
  CardApi.hCard := 0;
  inherited;
end;

function tCardBase.ChargeScheme: TChargeType;
begin
  result := ccGreen;
end;

procedure tCardBase.FormatCard(Ident: ansiString; AChargeScheme: TChargeType);
begin
  raise Exception.Create('FormatCard - unknown card type');
end;

procedure tCardBase.LoadMetres(ASerialNumber: integer; IssuedTO: ansiString; Metres: integer; AIssueDate,AExpiryDate: TDateTime);
begin
  raise Exception.Create('LoadMetres: Unknown card');
end;

function tCardBase.ReadWord(Address: byte): LongWord;
begin
  SendCommand($80, $BE, $00, Address, $04);
  result := FResponse.AsWord;
end;

procedure tCardBase.WriteString(Address: byte; Value: ansiString; nBytes: integer);
begin
  While Length(Value) < nBytes do
    Value := Value + #00;
  WriteBytes(Address,@Value[1], nBytes);
end;

function tCardBase.ReadString(Address: byte; ByteCount: integer): ansiString;
var
  x: DWord;
  Bytes: array[0 .. 3] of ansichar absolute x;
  WordCount, i, j: integer;
begin
  result := '';
  WordCount := ByteCount div 4;
  for i := 0 to pred(WordCount) do
  begin
    x := ReadWord(Address + i);
    for j := 0 to 3 do
      if Bytes[j]<> #0 then
        result := result + Bytes[j];
  end;
end;

procedure tCardBase.WriteWord(Address: byte; Value: LongWord);
begin
  SendCommand($80, $DE, $00, Address, 4, @Value);
end;

procedure tCardBase.WriteBytes(Address: byte; ABytePtr: pByte; nBytes: integer);
begin
  while nBytes > 0 do
  begin
    WriteWord(Address, pdword(ABytePtr)^);
    dec(nBytes, 4);
    inc(ABytePtr, 4);
    inc(Address);
  end;
end;

{ TCardClubMemo }

constructor TCardClubMemo.Create;
begin
  Randomize;
  inherited;
  Refresh;
end;

procedure TCardClubMemo.Refresh;
begin
  FIssuerByte :=0;
  FChargeScheme:=ccGreen;

  if (CardApi.hContext <> 0) and (CardApi.CardState = csCard) then
  begin
    FIssuerByte := ReadWord(MAP_ISSSUERBits) SHR 24; // only want high byte
    FChargeScheme := TChargeType(ReadWord(MAP_ACCESS) and $FF); // only want low byte
  end;

end;
procedure tCardBase.SendCommand(Cla, Ins, p1, p2, Le: byte; pData: pByte);
var
  Res: integer;
  ioRequest: SCARD_IO_REQUEST;
  SendBuff: array [0 .. 63] of byte;
  SendLen: integer;
begin
  ioRequest.dwProtocol := CardApi.dwActProtocol;
  ioRequest.dbPciLength := sizeof(SCARD_IO_REQUEST);
  fillChar(SendBuff, sizeof(SendBuff), 0);
  FResponse.Clear;
  SendBuff[0] := Cla;
  SendBuff[1] := Ins;
  SendBuff[2] := p1;
  SendBuff[3] := p2;
  SendBuff[4] := Le;
  SendLen := 5;
  if pData <>nil then
  begin
    SendBuff[5] := pData[0];
    SendBuff[6] := pData[1];
    SendBuff[7] := pData[2];
    SendBuff[8] := pData[3];
    SendLen := 9;
  end;
  Res := SCardTransmit(CardApi.hCard, @ioRequest, @SendBuff, SendLen, Nil, @FResponse.RawData, @FResponse.Length);

  if Res <> 0 then
  begin
    raise ECardIO.Create(Res);
  end;
  if (FResponse.Sw1 = $61) then
    exit; // 'sw2' bytes available for getResponse
  if (FResponse.Sw1 <> $90) or (FResponse.Sw2 <> 0) then
    raise ECardIO.Create(FResponse.Sw1, FResponse.Sw2);
end;

procedure TCardClubMemo.VerifyCSC(CSCID: byte; AValue: DWord);
var p2: byte;
begin
  case CSCID of
    0: p2 := $07;
    1: p2 := $39;
    2: p2 := $3B;
  else
    raise Exception.Create('Verify - no such CSC ID')
  end;
  SendCommand($80, $20, $00, p2, 4, @AValue);
end;

{$ifdef CARDMASTER}
procedure TCardClubMemo.FormatCard(Signature: ansiString; AChargeScheme: TChargeType);
var
  Bytes: array[0 .. 3] of byte;
begin
  if isUserMode then
  begin
    // reformat only for debugging
    VerifyCSC(0, key_csc0 xor key_key);
    VerifyCSC(1, key_csc1 xor key_key);
    VerifyCSC(2, key_csc2 xor key_key);
  end
  else
  begin
    VerifyCSC(0, $AAAAAAAA);
    WriteString(MAP_SIGNATURE, Signature, 8);
    WriteWord(MAP_UID, Random(-1));
  end;

  WriteWord(MAP_CSC1, key_csc1 xor key_key); // write CSC1 requires CSC0
  WriteWord(MAP_CSC2, key_csc2 xor key_key);
  VerifyCSC(1, key_csc1 xor key_key); // clear ctc
  VerifyCSC(2, key_csc2 xor key_key);

  WriteWord(MAP_CSC0, key_csc0 xor key_key);
  WriteString(MAP_ISSUEDTO, 'newcard', 32);
  Metres := 0; // property - set metres and encrypted metres

  // write access conditions
  Bytes[3] := ACCESSCONDITION; // $00
  Bytes[2] := $00;
  Bytes[1] := $00;
  Bytes[0] := ord(AChargeScheme);
  WriteBytes(MAP_ACCESS, @Bytes);

  // write IssuerBits
  Bytes[3] := $80; //   UserMode
  Bytes[2] := $00;
  Bytes[1] := $00;
  Bytes[0] := $00;
  WriteBytes(MAP_ISSSUERBits, @Bytes);
end;

procedure TCardClubMemo.LoadMetres(ASerialNumber: integer; IssuedTO: ansiString; AMetres: integer;
                                   AIssueDate,AExpiryDate: TDateTime);
begin
  if not isUserMode then
    raise Exception.Create('card is un-formatted');
  if not isKnownSignature then
    raise Exception.Create('invalid card signature');
  VerifyCSC(0, key_csc0 xor key_key);
  VerifyCSC(2, key_csc2 xor key_key);
  WriteWord(MAP_SERIAL, ASerialNumber);
  WriteString(MAP_ISSUEDTO, IssuedTO, 16);
  WriteWord(MAP_METRESISSUED, AMetres);
  setIssueDate(AIssueDate);
  setExpiryDate(AExpiryDate);
  Metres := AMetres; // after metres-issued update
end;

function TCardClubMemo.isKnownSignature: boolean;
begin
  result := sametext(Signature, 'SCSPANEL') or sametext(Signature, 'SCSTRUSS');
end;

procedure TCardClubMemo.setIssueDate(ADate: TDateTime);
var ts: TTimestamp;
begin
  ts := DateTimeToTimestamp(ADate);
  WriteWord(MAP_ISSUETIME, ts.Time);
  WriteWord(MAP_ISSUEDATE, ts.Date);
end;

procedure TCardClubMemo.setExpiryDate(ADate: TDateTime);
var ts: TTimestamp;
begin
  ts := DateTimeToTimestamp(ADate);
  WriteWord(MAP_EXPIRYDATE, ts.Date);
end;

procedure TCardClubMemo.AddInfo(ALines: tStrings);
begin
  if not isUserMode then
  begin
    ALines.Add('UNFORMATTED');
  end;

  if isUserMode then
  begin
    ALines.Add(Signature);
    ALines.Add(IssuedTO);
    ALines.Add('Serial Number     ' + intToStr(SerialNumber));
    ALines.Add('Charge Type       ' + ChargeSchemeStr(ChargeScheme));
    if isUnlimitedMetres then
    begin
      ALines.Add('Metres run        ' + floatToStr(abs(Metres)));
    end else
    begin
      ALines.Add('Metres issued     ' + floatToStr(MetresIssued));
      ALines.Add('Metres remaining  ' + floatToStr(Metres));
    end;

    ALines.Add('Issue Date        ' + FormatDateTime('dd mmm yyyy hh:mm', IssueDate));
    if isUnlimitedMetres and (ExpiryDate<>0)then
      ALines.Add('Expiry Date       ' + FormatDateTime('dd mmm yyyy', ExpiryDate));
    ALines.Add(format('Transaction Count %d',[ReadWord(MAP_CTC1)]));
  end;

  if (ReadWord($07)<> 0) or (ReadWord($39)<> 0) or (ReadWord($3B)<> 0) then
  begin
    ALines.Add('SECURITY KEY - FAILED ACCESS COUNTERS');
    ALines.Add(format('Rat 0: %x',[ReadWord($07)]));
    ALines.Add(format('Rat 1: %x',[ReadWord($39)]));
    ALines.Add(format('Rat 2: %x',[ReadWord($3B)]));
  end;
end;
{$endif}

function TCardClubMemo.Signature: ansiString;
begin
  result := ReadString(MAP_SIGNATURE, 8) // 1st 2 words of issuer area
end;

function TCardClubMemo.getIssueDate: TDateTime;
var ts: TTimestamp;
begin
  result := 0;
  ts.Time := ReadWord(MAP_ISSUETIME);
  ts.Date := ReadWord(MAP_ISSUEDATE);
  if ts.Date <> 0 then
    result := TimeStampToDateTime(ts);
end;

function TCardClubMemo.getExpiryDate : TDateTime;
var ts: TTimestamp;
begin
  result := 0;
  ts.Time := 0;
  ts.Date := ReadWord(MAP_EXPIRYDATE);
  if ts.Date <> 0 then
    result := TimeStampToDateTime(ts);
end;

function TCardClubMemo.IssuedTO: ansiString;
begin
  result := ReadString(MAP_ISSUEDTO, 32);
end;

function TCardClubMemo.key_key: DWord;
begin
  // xor with keys to get card keys
  // avoids storing actual keys in .exe
  // (cannot be a constant or will be elminated by the optimiser)
  result := $F248560C;;
end;

function TCardClubMemo.isUserMode: boolean;
begin
  result := (FIssuerByte = $80);
end;

function TCardClubMemo.isUnlimitedMetres: boolean;
begin
  Result := FChargeScheme = ccNoCharge;
end;

function TCardClubMemo.MetresIssued: integer;
begin
  result := ReadWord(MAP_METRESISSUED);
end;

function TCardClubMemo.getMetres: integer;
begin
  result := ReadWord(MAP_BAL1);
  if result > 0 then
    ValidateMetres(result);
end;

procedure TCardClubMemo.ValidateMetres(AValue: integer);
var
  CTC, EncryptedCTC, EncryptedBal: integer;
  inStream, outStream: tmemoryStream;
  Words: Array[0 .. 3] of DWord;
begin
  if not isUnlimitedMetres and
     (AValue > MetresIssued) then
    raise ECardTamper.Create('I'); // metres exceeds value issued
  CTC := ReadWord(MAP_CTC1);
  Words[0] := ReadWord(MAP_USER1);
  Words[1] := ReadWord(MAP_USER1 + 1);
  Words[2] := ReadWord(MAP_USER1 + 2);
  Words[3] := ReadWord(MAP_USER1 + 3);

  inStream := tmemoryStream.Create;
  outStream := tmemoryStream.Create;
  try
    // compare balance and CTC to decrypted saved values
    inStream.Write(Words[0], 16);
    inStream.position := 0;
    TripleDESEncryptStream(inStream, outStream, EKey, false{decrypt});
    outStream.position := 0;
    if outStream.size <> 8 then
      raise ECardTamper.Create('E'); // encryption / decryption issue
    outStream.read(EncryptedBal, 4);
    outStream.read(EncryptedCTC, 4);
    if EncryptedBal <> AValue then
      raise ECardTamper.Create('B'); // balance mis-match
    if CTC <> EncryptedCTC then
      raise ECardTamper.Create('C'); // CTC mis-match
  finally
    inStream.free;
    outStream.free;
  end;
end;

function TCardClubMemo.EKey: TKey128;
var Seed: array[0 .. 2] of DWord;
begin
  Seed[0] := key_EkeySeed1 xor key_key;
  Seed[1] := key_EkeySeed2 xor key_key;
  Seed[2] := SerialNumber xor key_key;
  HashLMD(result, sizeof(result), Seed, 12);
end;

procedure TCardClubMemo.setMetres(AValue: integer);
var
  CTC1: DWord;
  inStream, outStream: tmemoryStream;
begin
  // Balance 1 - plain value in card balance 1
  VerifyCSC(1, key_csc1 xor key_key);
  WriteWord(MAP_BAL1, AValue); // Bal1 - word1
  WriteWord(MAP_BAL1 + 2, not AValue); // Bal1 - word2 (must write: not used)
  CTC1 := ReadWord(MAP_CTC1);

  inStream := tmemoryStream.Create;
  outStream := tmemoryStream.Create;
  try
    // store encrypted balance and ctc in user area 1
    inStream.Write(AValue, 4);
    inStream.Write(CTC1, 4);
    inStream.position := 0;
    TripleDESEncryptStream(inStream, outStream, EKey, True{encrypt}); // 8 bytes in, 16 bytes out
    outStream.position := 0;
    WriteBytes(MAP_USER1, outStream.Memory, outStream.size);
  finally
    inStream.free;
    outStream.free;
  end;
end;

Function TCardClubMemo.SerialNumber: DWord;
begin
  result := ReadWord(MAP_SERIAL);
end;

function TCardClubMemo.ChargeScheme: TChargeType;
begin
  result := FChargeScheme;
end;

function TCardClubMemo.CheckCardOK(const ASignature: ansiString): boolean;
begin
  try
    if (FIssuerByte=0) and (CardApi.hContext <> 0) and (CardApi.CardState = csCard) then
    begin
      FIssuerByte := ReadWord(MAP_ISSSUERBits) SHR 24; // only want high byte
      FChargeScheme := TChargeType(ReadWord(MAP_ACCESS) and $FF); // only want low byte
    end;
    result := isUserMode and ansiSameText(ASignature, Signature);
  except
    result := false;
  end;
end;

{ ECardIO }

constructor ECardIO.Create(Sw1, Sw2: byte);
begin
  inherited Create('Card Error ' + inttohex(Sw1, 2)+ ' ' + inttohex(Sw2, 2));
end;

constructor ECardIO.Create(Res: integer);
begin
  inherited Create('Card Error ' + inttohex(Res, 8));
end;

{ TCardResponse }

function TCardResponse.AsWord: LongWord;
var p: PLongWord;
begin
  p := @RawData;
  result := p^;
end;

procedure TCardResponse.Clear;
begin
  fillChar(RawData, sizeof(RawData), 0);
  Length := sizeof(RawData);
end;

procedure TCardResponse.getData(var Res: TBytes);
begin
  setLength(Res, Self.Length - 2);
  Move(RawData[0], Res[0], Self.Length - 2);
end;

function TCardResponse.Data: TBytes;
begin
  getData(result);
end;

function TCardResponse.Sw1: byte;
begin
  result := RawData[Length - 2];
end;

function TCardResponse.Sw2: byte;
begin
  result := RawData[Length - 1];
end;

{ ECardTamper }

constructor ECardTamper.Create(s: string);
begin
  inherited Create('inconsistent card data ' + s);
end;

end.
