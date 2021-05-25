unit IJPSojetU;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, WinUtils, strUtils,
  Dialogs, ScotRFTypes, IJPBaseU, ScktComp, virtualMachineU, ExtCtrls;

type
  TResponse =(rspNone, rspTimeout, rspOK, rspError);

  TSojet = class(TInkJetB)
    ClientSocket1: TClientSocket;
    ClientSocket2: TClientSocket;
    StatusTimer: TTimer;
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure StatusTimerTimer(Sender: TObject);

    procedure ClientSocket2Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket2Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket2Error(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket2Disconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
  private
    FSerialNumber: uint32;
    FResponse: TResponse;
    FResponseErrorCode: uint32;
    FQryStatusCmd: array [0 .. 5] of uint32;
    FInkRemPC1,FInkRemPC2: double;
    FTick: integer;
    FResponsePending: boolean;

    procedure SojetStop;
    procedure SojetSendCmd(ACommand: uint32); //sends general command (IP 16888 - command port)
    procedure SojetQryStatus; //sends query status command on socket 2 (IP 17000 - enquiry port)
    procedure SojetWaitForResponse(AMilliSeconds: Cardinal=2000);
    procedure SojetSendEyeCmd(ACommand, AMode: uint32);
    function  SojetResponseAsString: string;
    procedure SojetDynamicDataPrint2(AText: Ansistring);
    procedure SojetSendBuf(var Buffer; Count: integer);
    procedure CheckStatus;
  protected
    procedure SojetSetPrintDelay(v1, v2, v3, v4: uint32); // unused
    procedure SojetGetPrintDelay; // unused
    procedure SojetStartPrintCmd;

  public
    FSocketError: string;
    constructor Create(AOwner: TComponent); override;
    function ConnectToIJP: boolean; override;
    procedure CloseConnections; override;
    function Connected: boolean; override;
    procedure StartPrint(AText: Ansistring; APrintSpaceRemaining: double); override;
    procedure SojetCancelPrintBuffer;
    procedure TriggerPrint; override;
    procedure InitSojetPrinter;
  end;

implementation

uses Usettings;
{$R *.dfm}

var Cmd: array [0 .. 100] of uint32;
  RecvBuffer: array[0 .. 299] of uint32;

const
  messageName: Ansistring = 'MSG\'#0;
  SCS: Ansistring = 'SCS'#0;
  SOC: uint32 = $30434F53;
  EOC: uint32 = $30434F45;
  L1 = 5;
  L2 = 4;
  POLLINTERVAL=20;
  POLLTIMEOUT=5;
type
  TSojetInkStatusRec = packed record
    CartridgeNo: UInt32;
    CustNo: UInt32;
    InkType: UInt32;
    InkCapacity: UInt32;
    PartNo: UInt64;
    InkStatus: UInt32;
    PrintNo: UInt32;
    RemainInk: UInt32;
    RemainInkPrint: UInt32;
    DotSize1: UInt32;
    DotSize2: UInt32;
//    fill2: UInt32;
    function InkRemPC: double;
    function InkUsedPC: double;
  end;

  TSojetStatusRec = packed record
    SOC: UInt32;
    ChkSum: UInt32;
    SerNum: UInt32;
    LEN: UInt32;
    Cmd: UInt32;
    // 'Base Of Dev Status'
    IntfStatus: UInt32;
    EncStatus: UInt32;
    PhotoStatus: UInt32;
    EthernetStatus: UInt32;
    InkStatus: UInt32;
    SystemStatus: UInt32;
    UVStatus: UInt32;

    Ink: array[0 .. 3] of TSojetInkStatusRec;
  end;

function SojetChkSum(ACmd: array of uint32): uint32;
var i, LEN: uint32;
begin
{$R-}
{$OVERFLOWCHECKS OFF}
  result := 0;
{ must be called AFTER setting length (CMD[3]) and BEFORE inserting EOC.
  checksum uses length and assumes zero padding to multiple of 4 bytes
}
  LEN := (ACmd[3]+3) div 4; // round up
  for i := 2 to LEN + 3 do
    result := result + ACmd[i];
{$R+}
{$OVERFLOWCHECKS ON}
end;

constructor TSojet.Create(AOwner: TComponent);
begin
  inherited;
end;

//procedure TSojet.logRawResponse;
//var i: integer;
//
//begin
//  TDebug.log('TSojet response');
//  for i:=0 to 1 do
//  begin
//    TDebug.log('Print head #%d',[i+1]);
//    with Status.Ink[i] do
//    begin
//    TDebug.log('CartridgeNo %d',[CartridgeNo]);
//    TDebug.log('CustNo %d',[CustNo]);
//    TDebug.log('InkType %d',[InkType]);
//    TDebug.log('InkCapacity %d',[InkCapacity]);
//    TDebug.log('PartNo %d',[PartNo]);
//    TDebug.log('InkStatus %d',[InkStatus]);
//    TDebug.log('PrintNo %d',[PrintNo]);
//    TDebug.log('RemainInk %d',[RemainInk]);
//    TDebug.log('RemainInkPrint %d',[RemainInkPrint]);
//
//
//    TDebug.log('DotSize1 %d %x',[DotSize1,DotSize1]);
//    TDebug.log('DotSize2 %d %x',[DotSize2,DotSize2]);
//    TDebug.log('InkUsedPC %f',[InkUsedPC]);
//    TDebug.log('InkRemPC %f',[InkRemPC]);
//    TDebug.log('  ');
//    end;
//
//  end;
//
//
//end;

procedure TSojet.StatusTimerTimer(Sender: TObject);
begin
// tick interval = 1 second
  inc(FTick);

  if (FTick>=POLLTIMEOUT) and
    FResponsePending then
  begin
     // Timeout;
    IJPTrace('  Sojet Timer Timeout');
    FTick:=0;
    FResponsePending:=false; // singleshot timer
    setLight(tsRed);
    CloseConnections;
  end;
  if FTick>=POLLINTERVAL then
  begin
    CheckStatus;
  end;
end;

procedure TSojet.CheckStatus;
begin
  if ClientSocket2.Active then
  begin
    FTick:=0;
    FResponsePending:=true;
    IJPTrace('  Sojet Check Status (ACTIVE)');
    setLight (tsAmber);
    SojetQryStatus; // get Sojet status every 20 secs to maintain connection
  end
  else
  begin
    setLight(tsRed);
  end;
end;

function TSojet.SojetResponseAsString: string;
begin
  case FResponse of
    rspNone: result := 'pending';
    rspTimeout: result := 'timeout';
    rspOK: result := 'OK';
    rspError: result := format('Error %x',[FResponseErrorCode]);
  end;
end;

procedure TSojet.ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  IJPTrace('  ClientSocket1 Error'+ inttostr(ErrorCode));
  setLight( tsRed);
  FSocketError := 'Connect error  ' + inttostr(ErrorCode);
  setStatus(1, FSocketError);
  ErrorCode := 0; // inhibit application exception
end;

procedure TSojet.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
var rlen1: Integer;
  Cmd: uint32;
begin
  FillChar(RecvBuffer, sizeof(RecvBuffer), 0);
  rlen1 := ClientSocket1.Socket.ReceiveBuf(RecvBuffer, sizeof(RecvBuffer));

  FResponse := rspOK;
  FResponseErrorCode := 0;
//  ods('Socket1Read %d %x %x %x',[rlen1, RecvBuffer[4], RecvBuffer[5], RecvBuffer[6]]);

  if RecvBuffer[4]= $00000081 then
  begin
    FResponse := rspError;
    FResponseErrorCode := RecvBuffer[6];
    Cmd := RecvBuffer[5];
  end
  else
    Cmd := RecvBuffer[4];

  if Cmd = $1200000D then // elec eye mode
    ods('elec eye mode Response %x',[RecvBuffer[5]]);

  if Cmd = $1200000E then // elec eye signal
    ods('elec eye signal Response %x',[RecvBuffer[5]]);

  if verbose > 0 then
    ShowCmdBuffer(@RecvBuffer, rlen1, 'Sckt 1 : Response');
  setStatus (1, SojetResponseAsString);
end;

procedure TSojet.ClientSocket2Connect(Sender: TObject; Socket: TCustomWinSocket);
begin
   IJPTrace('Socket2 Connected');
   setStatus(2,'Connected');
   FTick := POLLINTERVAL - 1;      // 1st query in 1 second
   StatusTimer.enabled := true;    //need to enq prtr every 20 secs to avoid IP tunnel dropout
end;

procedure TSojet.ClientSocket2Disconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  IJPTrace('Sckt 2: DISCONNECT');
  setStatus(2,'Disconnected');
  setLight( tsOff);
end;

procedure TSojet.ClientSocket2Error(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  setLight( tsRed);
  FSocketError := 'Connect error2 ' + inttostr(ErrorCode);
  IJPTrace(FSocketError);
  setStatus(2, FSocketError);
  ErrorCode := 0; // inhibit application exception
end;

procedure TSojet.ClientSocket2Read(Sender: TObject; Socket: TCustomWinSocket);
var
  r2Length: Integer;
  RcvBuf2: array[0 .. 1023] of byte; // client socket 2  (actual response  473 bytes)
  Status:TSojetStatusRec absolute  RcvBuf2;
begin
  FillChar(RcvBuf2, sizeof(RcvBuf2), 0);
  r2Length := ClientSocket2.Socket.ReceiveBuf(RcvBuf2, sizeof(RcvBuf2));
  IJPTrace(' ClientSocket2Read '+inttostr(r2Length));

  if r2Length > 0 then
  begin
    FResponsePending := false;
    setLight(tsOK); // assume OK
    FInkRemPC1 := Status.Ink[0].InkRemPC;
    FInkRemPC2 := Status.Ink[1].InkRemPC;
    setInk(FInkRemPC1, FInkRemPC2);
  end;
end;

procedure TSojet.CloseConnections;
begin
  If not Assigned(ClientSocket1) then
    Exit;
  IJPTrace(' CloseConnections');
  FResponsePending := False;
  StatusTimer.enabled := False;
  if ClientSocket1.Active then
  begin
    try
      SojetStop;
      SojetWaitForResponse;
    except

    end;
    ClientSocket1.Active := false; //Close IP sockets
    ClientSocket2.Active := false;
  end;
  inherited;
end;

function TSojet.Connected: boolean;
begin
  Result := False;
  if Assigned(ClientSocket1) then
    Result := ClientSocket1.Active;
end;

function TSojet.ConnectToIJP: boolean;
begin
  if not Assigned(ClientSocket1) or not Assigned(ClientSocket2) then
    Exit;
  FSerialNumber := strtoint(G_Settings.inkprinter_inkserial); // Sojet prtr serial number
  IJPTrace('TSojet.ConnectToIJP '+inttostr(FSerialNumber));
  FResponsePending := False;
  FTick:=0;
  ClientSocket1.Port := 16888; // command port
  ClientSocket1.Host := trim(G_Settings.inkprinter_inkIP);
  ClientSocket2.Port := 17000; // enquiry port
  ClientSocket2.Host := trim(G_Settings.inkprinter_inkIP);

{ making the Sojet connection consists of the following sequence of event-triggerd steps
  1. Open conection #1
  2. Socket1Connected ==> open connection #2
  3. Socket2Connected ==> start timer
  4. timer tick ==> status query when tick reaches POLLINTERVAL
}

  ClientSocket1.Active := true;   // open command port
  result := ClientSocket1.Active;
end;


procedure TSojet.ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
begin
  IJPTrace('ClientSocket1 Connected');
  setStatus(1, 'Connected');

  ClientSocket2.Active := true;    // open query-status port
end;

procedure TSojet.ClientSocket1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  IJPTrace('ClientSocket1 Disconnected');
  inherited;
  setStatus(1, 'Disconnect');
end;

procedure TSojet.InitSojetPrinter;
begin
  IJPTrace('InitSojetPrinter');
  SojetStartPrintCmd;
  SojetWaitForResponse(20000);
  SojetCancelPrintBuffer;
  SojetWaitForResponse;
  SojetSendEyeCmd($1200000D, 1); // 'Electric Eye Mode'
  SojetWaitForResponse;
  //  SojetSetPrintDelay(31,31,0,0);
  //  SojetWaitForResponse(10000);
  //  SojetGetPrintDelay;
  //  SojetWaitForResponse(10000);
  setStatus(1, 'Ready');
  IJPTrace('InitSojetPrinter READY');

end;


procedure TSojet.StartPrint(AText: Ansistring; APrintSpaceRemaining: double);
begin
  IJPTrace(' Sojet StartPrint '+AText);
  setStatus(3,AText); // item  text
  if ClientSocket1.Active then
  begin
    SojetDynamicDataPrint2(AText);
    SojetWaitForResponse;
  end else
    setStatus(1, 'No Connection');
end;

procedure TSojet.SojetSendBuf(var Buffer; Count: integer);
begin
  if ClientSocket1.Active then
  begin
    FResponse := rspNone;
{$POINTERMATH ON}
    if verbose > 0 then
      ShowCmdBuffer(pByte(@Buffer), Count, format('Send %d cmd=%X',[Count, (pUInt(@Buffer)+4)^]));

    ClientSocket1.Socket.SendBuf(Buffer, count);
  end else
    FResponse := rspError;
end;

procedure TSojet.SojetSendCmd(ACommand: uint32); //Command send to SoJet command port
begin
  FillChar(Cmd, sizeof(Cmd), 0);
  Cmd[0] := SOC;
  Cmd[1] := $FFFFFFFF; // chksum (to come)
  Cmd[2] := FSerialNumber;
  Cmd[3] := 4; //command length - always 4 bytes
  Cmd[4] := ACommand;
  Cmd[5] := EOC;
  Cmd[1] := SojetChkSum(Cmd);

  SojetSendBuf(Cmd, 24);
end;

procedure TSojet.SojetQryStatus; //Command send to SoJet enquiry port
begin
  IJPTrace('  SojetQryStatus');
  if FQryStatusCmd[0]= 0 then
  begin
    FQryStatusCmd[0] := SOC;
    FQryStatusCmd[1] := $FFFFFFFF; // chksum (to come)
    FQryStatusCmd[2] := FSerialNumber;
    FQryStatusCmd[3] := 4; //command length - always 4 bytes
    FQryStatusCmd[4] := $10000001; // command
    FQryStatusCmd[5] := EOC;
    FQryStatusCmd[1] := SojetChkSum(FQryStatusCmd);
  end;

  //  if verbose > 0 then
  //    ShowCmdBuffer(@QryStatusCmd, 24, 'Socket 2: QryStatusCmd');

  ClientSocket2.Socket.SendBuf(FQryStatusCmd, 24);
end;

procedure TSojet.SojetCancelPrintBuffer;
begin
  IJPTrace(' Sojet SojetCancelPrintBuffer');
  if ClientSocket1.Active then
  begin
    FillChar(Cmd, sizeof(Cmd), 0);
    Cmd[0] := SOC;
    Cmd[1] := $FFFFFFFF; // chksum (to come)
    Cmd[2] := FSerialNumber;
    Cmd[3] := 12; // LEN
    Cmd[4] := $1200000F; // command
    Cmd[5] := 1; // mode=cancel all
    Cmd[6] := 0; // index
    Cmd[7] := EOC;
    Cmd[1] := SojetChkSum(Cmd);
    SojetSendBuf(Cmd, 32);
    SojetWaitForResponse;
  end;
end;

procedure TSojet.SojetSendEyeCmd(ACommand, AMode: uint32);
begin
  IJPTrace(' Sojet Send Eye Command');

  FillChar(Cmd, sizeof(Cmd), 0);
  Cmd[0]:= SOC;
  Cmd[1]:= $FFFFFFFF; // chksum (to come)
  Cmd[2]:= FSerialNumber;
  Cmd[3]:= 8; // LEN
  Cmd[4]:= ACommand;
  Cmd[5]:= AMode;
  Cmd[1]:= SojetChkSum(Cmd);
  Cmd[6]:= EOC;
  SojetSendBuf(Cmd, 28);
end;

function RoundUp4(N: integer): integer;

begin
  result := N;
  case N Mod 4 of
    1: exit(N + 3);
    2: exit(N + 2);
    3: exit(N + 1);
  end;
end;

procedure TSojet.SojetDynamicDataPrint2(AText: Ansistring);
//Dynamic data send to SoJet
var
  p: pByte;
begin
  FillChar(Cmd, sizeof(Cmd), 0);

  Cmd[0]:= SOC;
  Cmd[1]:= $FFFFFFFF; // chksum (to come)
  Cmd[2]:= FSerialNumber;
  Cmd[3]:= length(AText)+41; // LEN
  Cmd[4]:= $12000007; // Dynamic Data Printing
  // DATA PACK
  Cmd[5]:= 0; // Reserved
  Cmd[6]:= length(AText)+ 13;  //total length of dynamic data
  Cmd[7]:= 0; // Pack Index
  Cmd[8]:= 1; // Total Pack Number
  Cmd[9]:= 1; // object number
  Cmd[10]:= length(AText)+13; // total length of dynamic data
  // DataBuff
  Cmd[11]:= length(AText)+1; // length of 1st dynamic data
  Cmd[12]:= 1; // DataCurPoint1
  Cmd[13]:= 0; // type 0:string

  p :=@Cmd[14];

  Move(AText[1], p^, length(AText)+1); // message text plus null

  p := p + length(AText)+1;

  Cmd[1]:= SojetChkSum(Cmd);

  pLongword(p)^:= EOC;

  SojetSendBuf(Cmd , length(AText)+ 61)
end;


procedure TSojet.SojetStartPrintCmd;
//SoJet Start printing - message names = SCS
begin
  FillChar(Cmd, sizeof(Cmd), 0);
  Cmd[0]:= SOC;
  Cmd[1]:= $FFFFFFFF; // chksum (to come)
  Cmd[2]:= FSerialNumber;
  Cmd[3]:= 40; // LEN
  Cmd[4]:= $12000004; // Command -  Start Print
  // data pack
  Cmd[5]:= 4; // length of message name including end null
  Cmd[6]:= 0; // reserved
  Cmd[7]:= 0; // reserved
  Cmd[8]:= 0; // reserved
  Cmd[9]:= 0; // delay
  Cmd[10]:= 0; // ' curvalue'
  Cmd[11]:= 0; // 'repeat time'
  Cmd[12]:= 0; // ' counter reset'
  Move(SCS[1], Cmd[13], 4);

  Cmd[1]:= SojetChkSum(Cmd);
  Cmd[14]:= EOC;

  SojetSendBuf(Cmd, 60)
end;

procedure TSojet.SojetStop;
begin
  SojetSendCmd($12000006);
end;

procedure TSojet.SojetWaitForResponse(AMilliSeconds: Cardinal);
var t0: Cardinal;
begin
  t0 := getTickcount;
  while FResponse = rspNone do
  begin
    application.processmessages;
    sleep(50);
    if getTickcount > t0 + AMilliSeconds then
    begin
      FResponse := rspTimeout;
      raise ETimeout.Create('Sojet timeout');
    end;
  end;
end;

procedure TSojet.TriggerPrint;
begin
  IJPTrace('TSojet.TriggerPrint ');
  if ClientSocket1.Active then
  begin
    SojetSendEyeCmd($1200000E, 0); // 'Electric Eye Signal'
  end;
end;

procedure TSojet.SojetSetPrintDelay(v1, v2, v3, v4: uint32);
var
  p0, p: pByte;
  messageName: string[20];
  SCS: string[20];
begin
  FillChar(Cmd, sizeof(Cmd), 0);
  p0 :=@Cmd[4];

  Cmd[0]:= SOC;
  Cmd[1]:= $FFFFFFFF; // chksum (to come)
  Cmd[2]:= FSerialNumber;
  Cmd[3]:= $FFFFFFFF; // LEN
  Cmd[4]:= $12000001;
  Cmd[5]:= L1; //Filefolderpathsize
  Cmd[6]:= L2; // messaage name size
  Cmd[7]:= v1;
  Cmd[8]:= v2;
  Cmd[9]:= v3;
  Cmd[10]:= v4;
  p :=@Cmd[11];
  Move(messageName[1], p^, L1);
  p := p + L1;
  Move(SCS[1], p^, L2);
  p := p + L2;

  while ((p - p0) mod 4 <> 0) do // padding
    inc(p);

  Cmd[3]:=(p - p0); // LEN
  Cmd[1]:= SojetChkSum(Cmd);
  pLongword(p)^:= EOC;

  SojetSendBuf(Cmd, Cmd[3]+ 20);
end;

procedure TSojet.SojetGetPrintDelay;
var
  p0, p: pByte;

begin
  FResponse := rspNone;
  FillChar(Cmd, sizeof(Cmd), 0);

  p0 :=@Cmd[4]; // start for LEN calculation

  Cmd[0]:= SOC;
  Cmd[1]:= $FFFFFFFF; // chksum (to come)
  Cmd[2]:= FSerialNumber;
  Cmd[3]:= $FFFFFFFF; // LEN
  Cmd[4]:= $12000002;
  Cmd[5]:= L1; //Filefolderpathsize
  Cmd[6]:= L2; // messaage name size
  Cmd[7]:= 0;
  Cmd[8]:= 0;
  Cmd[9]:= 0;
  Cmd[10]:= 0;
  p :=@Cmd[11];
  Move(messageName[1], p^, L1);
  p := p + L1;
  Move(SCS[1], p^, L2);
  p := p + L2;

//  while ((p - p0) mod 4 <> 0) do // padding
//    inc(p);

  Cmd[3]:=(p - p0); // LEN
  Cmd[1]:= SojetChkSum(Cmd);
  pLongword(p)^:= EOC;

  SojetSendBuf(Cmd, Cmd[3]+ 20);
end;

{ TSojetInkStatusRec }

function TSojetInkStatusRec.InkRemPC: double;
begin
  result :=  RemainInk /    InkCapacity ; // ink rem (mil x 100) / capacity (ml
end;

function TSojetInkStatusRec.InkUsedPC: double;
begin
  result := 100 - InkRemPC;
end;

end.
