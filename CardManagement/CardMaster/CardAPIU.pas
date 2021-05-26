unit CardAPIU;
(***************************************************************
 WINSCARD wrapper
   - select reader from reader list
   - poll reader state and generate OnStateChange event
   - Save card ATR for card-type identification
***************************************************************)
interface

uses
  SysUtils, Classes, ExtCtrls, WinScard, windows;
{$RANGECHECKs OFF}   // confusion in WinSCard between longint/cardinal/uint32 for results
type
  TAPIState =(csUnknown, csNoReader, csReaderErr, csCard, csNoCard);

const APIStates: Array[TAPIState] of string = ('Unknown State', 'No Card Reader', 'Reader Error', 'Card Inserted', 'No Card');

///////////////////////////////////////////////////////////////////////////////
//  Protocol Flag definitions
///////////////////////////////////////////////////////////////////////////////
Const SCARD_PROTOCOL_UNDEFINED    =$00000000;  // There is no active protocol.
Const SCARD_PROTOCOL_T0           =$00000001;  // T=0 is the active protocol.
Const SCARD_PROTOCOL_T1           =$00000002;  // T=1 is the active protocol.
Const SCARD_PROTOCOL_RAW          =$00010000;  // Raw is the active protocol.
Const SCARD_PROTOCOL_DEFAULT      =$80000000;  // Use implicit PTS.

Const SCARD_NO_READERS     = $8010002E;
type
  APIException = class(Exception)
  end;

  TCardApi = class(TDataModule)
    Timer1: TTimer;
    procedure Timer1Tick(Sender: TObject);
  public
    hContext: SCARDCONTEXT;
    hCard: Longint;
    dwActProtocol    : UInt32;
    procedure RefreshCardState;
  private
    FOnStateChange: TNotifyEvent;
    FState: TAPIState;
    ReturnCode: uint32;
    procedure setOnStateChange(const Value: TNotifyEvent);
  public
    FReaderList: tStringList;
    FReader: String;
    ATR :array[1..36] of byte;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Initialise;
    property OnStateChange: TNotifyEvent write setOnStateChange;
    property CardState: TAPIState read FState;
    function CardStateStr: string;
    function Reconnect(AInitialization: LongInt): LongInt;
  end;

var
  CardApi: TCardApi;

implementation
 {$R *.dfm}
uses math, WinUtils;
{ TCardApi }


procedure CheckSuccess(RC: uint32);
begin
  if RC <> 0 then
    raise APIException.Create('API Error ' + IntToHex(RC, 2)+ 'x');
end;

procedure ParseReaderList(var List: tStringList; Buffer: PChar; BuffLen: integer);
var
  I    : Integer;
  sReader : String;
begin
  I := 0;
  while (Buffer[I] <> #0) do begin
    sReader := '';
    while (Buffer[I] <> #0) do begin
      sReader := sReader + Buffer[I];
      inc(I);
    end; // while loop
    if Not sReader.StartsWith('Windows Hello') then
      List.Add(sReader);
    inc(I);
  end; // while loop
end;

constructor TCardApi.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FReaderList := tStringList.Create;
end;

destructor TCardApi.Destroy;
begin
  CardApi:=nil; // clear the singleton
  Timer1.Enabled:=false;
  if hContext<>0 then
    SCardReleaseContext(hContext);
  hContext:=0;
  FReaderList.Free;
  inherited;
end;

procedure TCardApi.Initialise;
Const
  MAX_BUFFER_LEN = 1023;
var
  BufferLen: LongInt;
  Buffer: array [0 .. MAX_BUFFER_LEN] of Char;
begin
  // 1. Establish context and obtain hContext handle
  try
    if hContext = 0 then
    begin
      ReturnCode := SCardEstablishContext(SCARD_SCOPE_USER, nil, nil, @hContext);
      CheckSuccess(ReturnCode);

      // 2. List PC/SC card readers installed in the system
      BufferLen := MAX_BUFFER_LEN;
      ReturnCode := SCardListReadersW(hContext, nil, @Buffer[0], BufferLen);
      if ReturnCode=SCARD_SCOPE_USER  then
      begin
        ParseReaderList(FReaderList, Buffer, BufferLen);
        if FReaderList.Count > 0 then
          FReader:=RawByteString(FReaderList[0]);
      end;
    end;
  except
     on e: exception do
       FState := csReaderErr;
  end;
end;

procedure TCardApi.setOnStateChange(const Value: TNotifyEvent);
begin
  FOnStateChange := Value;
  Timer1.Enabled := False;
  if assigned(Value) then
  begin
    Timer1Tick(Self);  // let's see some action
    Timer1.Enabled := True;
  end;
end;

procedure TCardApi.Timer1Tick(Sender: TObject);
var
  PriorState: TAPIState;
begin
  PriorState := FState;
  RefreshCardState;
  timer1.enabled:=false;
  try
    if assigned(FOnStateChange) and (FState <> PriorState) then
      FOnStateChange(self);
  finally
    timer1.enabled:=true;
  end;
end;

procedure TCardApi.RefreshCardState;
var
  RdrState: array[0..99] of SCARD_READERSTATEW;
begin
  fillChar(RdrState, sizeof(RdrState), 0);
  fillChar(ATR, sizeof(ATR), 0);

  if FReaderList.count = 1 then
  begin
    RdrState[0].szReader := @FReader[1];
    ReturnCode := SCardGetStatusChangeW(hContext, 0, @RdrState, 1);
    if ReturnCode = 0 then
    begin
      if (RdrState[0].dwEventState and SCARD_STATE_PRESENT) <> 0 then
      begin
        FState := csCard;
        Move(RdrState[0].rgbATR , ATR, min(RdrState[0].cbATR, sizeof(ATR)));
      end  else
        FState := csNoCard
    end
    else
      FState := csReaderErr
  end else
  if FState <> csReaderErr then
    FState := csNoReader; // or multiple readers

  if (hContext <> 0) and (FState = csCard) then
    SCardConnectW(hContext, @FReader[1], SCARD_SHARE_SHARED, SCARD_PROTOCOL_T0 or SCARD_PROTOCOL_T1, hCard, @dwActProtocol)
  else
    hCard := 0;
end;

function TCardApi.Reconnect(AInitialization: LongInt): LongInt;
begin
  result := -1;
  if (hContext <> 0) and (CardState = csCard) then
    result:=SCardReConnect( hCard,
                        SCARD_SHARE_SHARED,
                        SCARD_PROTOCOL_T0 or SCARD_PROTOCOL_T1,
                        AInitialization,
                        @dwActProtocol);
end;

function TCardApi.CardStateStr: string;
Const SCARD_NO_READERS    = $8010002E;    //  Cannot find a smart card reader

begin
  result := APIStates[FState];
  if (ReturnCode <> 0) and
     (ReturnCode <> SCARD_NO_READERS) then
    result := Result + ' ('+ IntToHex(ReturnCode,2)+'x)';
end;

initialization

finalization
  freeandnil(cardAPI);   // if application-owned, cardAPI is nil and nothing happens here
end.
