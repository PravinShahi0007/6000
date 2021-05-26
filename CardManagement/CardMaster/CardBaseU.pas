unit CardBaseU;

interface

uses
  Windows, SysUtils, strUtils, Classes, ExtCtrls, WinScard, CardAPIU, Des, lbProc, lbCipher;
{$RANGECHECKs OFF}   // confusion in WinSCard between longint/cardinal/uint32 for results
const
  GemClub1K:   array[0..11] of Byte = ($3B, $68 ,$00, $00, $80, $66, $A2, $06, $02, $01, $32, $0E);//	original Gemplus GemClub 1K
  GemClubMemo: array[0..3]  of byte = ($3B, $02, $53, $01);                                        //  Gemclub Memo
  SLE4442:     array[0..5]  of Byte = ($3B, $04, $A2, $13, $10, $91) ;                             //	PM2P Chipkarte SLE 4442 (never used)
  Acos3:       array[0..4]  of byte = ($3B, $BE, $11, $00, $00);

type
  TChargeType =(ccGreen = ord('G'), ccRed = ord('R'), ccNoCharge = ord('N'));

type
  ECard = class(Exception)
  end;
  ECardIO = class(ECard)
    Constructor Create(Sw1, Sw2: byte; Txt:string=''); reintroduce; overload;
    Constructor Create(Res: integer); reintroduce; overload;
  end;

  ECardSecuity = class(ECard)
  end;

  ECardTamper = class(ECardSecuity)
    Constructor Create(s: string); reintroduce;
  end;

  ECardKey = class(ECardSecuity)
  end;

  TCardResponse = record
    RawData: array[0 .. 255] of byte;
    Length: DWord;
    procedure Clear;
    function Sw1: byte;
    function Sw2: byte;
    procedure getData(var Res: TBytes);
    function Data: TBytes;
    function AsWord: LongWord;
    procedure copyData(AData: pByte);
  end;

type
  tCardBase = class
  private
  protected
    FResponse: TCardResponse;
    FCardName: string;
    function ReadString(Address: byte; ByteCount: integer): ansiString;
    procedure WriteBytes(Address: byte; ABytePtr: pByte; nBytes: integer = 4);
    Procedure SendCommand(Cla, Ins: byte; p1, p2: byte; Le: byte; pData: pByte =nil);
    procedure WriteWord(Address: byte; Value: LongWord);
    procedure WriteString(Address: byte; Value: ansiString; nBytes: integer);
    function ReadWord(Address: byte): LongWord;
    class procedure CheckResponse(const Sw1, Sw2: Byte); static;

    function getIssueDate: TDateTime; virtual;abstract;
    function  getExpiryDate: TDateTime; virtual;abstract;
    function getMetres: integer;  virtual;abstract;
    procedure setMetres(AValue: integer); virtual;abstract;
    function getChargeScheme: TChargeType; virtual;
  public
    class function Construct(ATR: pByte): tCardBase; static; // class factory
    class function ChargeSchemeStr(AChargeScheme: TChargeType): String; static;
    constructor Create(AName: string); virtual;
    destructor Destroy; override;
    property CardName: string read FCardName;
    function CheckCardOK(const ASignature: ansiString): boolean;
    procedure AddInfo(ALines: tStrings); virtual;
    function ChargeScheme: TChargeType; virtual;  // [ccGreen, ccRed, ccNoCharge]
    function canFormat: boolean; virtual;
    function canLoad:boolean; virtual;
    function isUnlimitedMetres: boolean;
    property Metres: integer read getMetres write setMetres;
    {$IFDEF CARDMASTER}
    procedure LoadMetres(ASerialNumber: integer; IssuedTO: ansiString; AChargeScheme: TChargeType; AMetres: integer; AExpiryDate: TDateTime); virtual; abstract;
    procedure FormatCard(AProduct: ansiString); virtual;abstract;
    {$ENDIF}

    function SerialNumber: DWord; virtual;abstract;
    function IssuedTO: ansiString; virtual;abstract;
    function Signature: ansiString; virtual;abstract;   { TODO : rename as product }
    function MetresIssued: integer; virtual;abstract;
    property IssueDate: TDateTime read getIssueDate;
    property ExpiryDate: TDateTime read  getExpiryDate;
  end;

  TCardGemPlusOneK = class(tCardBase)     // original card-type
  (* this card is recognised but no operations are available.
     unable to read card type (truss/panel) without key
  *)

  end;


implementation

uses cardGemMemoU, CardAcos3U;

class function tCardBase.ChargeSchemeStr(AChargeScheme: TChargeType): String;
begin
  case AChargeScheme of
    ccGreen:    result := 'Standard';
    ccRed:      result := 'RED (High Rate)';
    ccNoCharge: result := 'GOLD (Zero Rate)'
    else
      result := 'Invalid ' + inttohex(ord(AChargeScheme), 2);
  end;
end;

{ tCardBase }

constructor tCardBase.Create(AName: string);
begin
  inherited Create;
  FCardName:=AName;
end;

destructor tCardBase.Destroy;
begin
  inherited;
end;

function tCardBase.getChargeScheme: TChargeType;
begin
  result := ccGreen;
end;

class function tCardBase.Construct(ATR: pByte): tCardBase;
begin
  Result := nil;
{$WARNINGs OFF} // abstract methods
  // these card are recognised but not implemented
  if CompareMem( ATR , @SLE4442[0], sizeof(SLE4442)) then
      exit (tCardBase.Create ('PM2P Chipkarte SLE 4442'));
  if CompareMem( ATR , @GemClub1K[0], sizeof(GemClub1K)) then
      exit (TCardGemPlusOneK.Create('Gemplus GemClub 1K'));
  if CompareMem( ATR , @GemClubMemo[0], sizeof(GemClubMemo)) then
      exit (TCardClubMemo.Create('GemClub-Memo'));
{$WARNINGS ON}
  if CompareMem( ATR , @ACOS3[0], sizeof(ACOS3)) then
      exit (TCardACOS3.Create('Acos-3'));
end;


function tCardBase.CheckCardOK(const ASignature: ansiString): boolean;
begin
  result :=  (CardApi.CardState = csCard) and
              not canFormat and
              ansiSameText(ASignature, Signature);
end;

procedure tCardBase.AddInfo(ALines: tStrings);
begin

end;

function tCardBase.canFormat: boolean;
begin
  Result := false;
end;

function tCardBase.canLoad: boolean;
begin
  Result := false;
end;

function tCardBase.ChargeScheme: TChargeType;
begin
  result := ccGreen;
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

class procedure tCardBase.CheckResponse(const Sw1,Sw2: Byte);
begin
  if (Sw1 = $61) then
    exit; // 'sw2' bytes available for getResponse
  if (Sw1 = $91) then
    exit; // Success ACOS select file
  if (Sw1 <> $90) or (Sw2 <> 0) then
    raise ECardIO.Create(Sw1, Sw2);
end;

procedure tCardBase.SendCommand(Cla, Ins, p1, p2, Le: byte; pData: pByte);
var
  Res: integer;
  ioRequest: SCARD_IO_REQUEST;
  SendBuff: array [0 .. 255] of byte;
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
  if (Le>0) and (pData <>nil) then
  begin
    Move(pData^, SendBuff[5],  Le);
    SendLen:= SendLen + Le;
  end;

  Res := SCardTransmit(CardApi.hCard, @ioRequest, @SendBuff, SendLen, Nil, @FResponse.RawData, @FResponse.Length);

  if Res <> 0 then
    raise ECardIO.Create(Res);
  CheckResponse( FResponse.Sw1,FResponse.Sw2);
end;

function tCardBase.isUnlimitedMetres: boolean;
begin
  Result := ChargeScheme = ccNoCharge;
end;


{ ECardIO }

constructor ECardIO.Create(Sw1, Sw2: byte; Txt:string);
begin
  inherited Create('Card Error ' + txt+ ' '+ inttohex(Sw1, 2)+ ' ' + inttohex(Sw2, 2));
end;

constructor ECardIO.Create(Res: integer);
begin
  inherited Create('Card Error ' + inttohex(Res, 8) + SysErrorMessage(Res));
end;

{ TCardResponse }

function TCardResponse.AsWord: LongWord;
var
  p: PLongWord;
begin
  p := @RawData;
  result := p^;
end;

procedure TCardResponse.Clear;
begin
  fillChar(RawData, sizeof(RawData), 0);
  Length := sizeof(RawData);
end;

procedure TCardResponse.copyData(AData: pByte);
begin
  Move(RawData[0], AData^ , Self.Length - 2);
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

