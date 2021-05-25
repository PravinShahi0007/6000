unit RollformerU;

interface

uses
  SysUtils, Controls, Classes, forms, scotRFTypes, generics.Collections, IniFiles,
  strUtils, dialogs, VaClasses, VaComm, ExtCtrls, WinUtils, ManufactureU, VirtualMachineU,
  Mint, MintControls5626Lib_TLB, cardAPIU, CardAdapterU, FrameDataU, versionU;

type
  TCounter = class(TObject)
  private
    opCode      : TOperationProcess;
    FMintNumber : TMintValue;
    FLongName   : String;
    FIniKey     : AnsiString;
    FValue      : Longint;
    function GetLimitExceeded: boolean;
    function GetOpLimit : LongInt;
    procedure SetOpLimit(anInteger : Integer);
  public
    constructor Create(AOpcode: TOperationProcess; IniKey: AnsiString; ALongName: string; AMintParam: TMintValue);
    procedure IncValue;
    property LimitExceeded : Boolean read GetLimitExceeded;
    property Value         : Longint read FValue write FValue;
    property MintNumber    : TMintValue read FMintNumber write FMintNumber;
    property LongName      : String read FLongName write FLongName;
    property OpLimit       : Longint read GetOpLimit write SetOpLimit;
  end;

type
  TRollformer = class(TDataModule)
    Timer1:   TTimer;
    Timer4:   TTimer;
    VaComm1:  TVaComm;
    procedure Timer1Timer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure VaComm1RxChar(Sender: TObject; Count: Integer);
    procedure Timer4Timer(Sender: TObject);
  private
    FCounters:    TObjectList<TCounter>;
    FIsBoxWeb:    Boolean;
    FConnected:   TConnectionState;
    FNewProtocol: Boolean;
    FSessionID:   Integer;
    FSerialHash:  UInt16;
    FTick:        Cardinal;
    FTick4:       Cardinal;
    FReSends:     Cardinal;
    FCommErrors:  Cardinal;
    FCommData:    String;
    Copid:        AnsiString;
    FMintSerialNumber:  AnsiString;
    FMachineChargeType: TChargeType;
    Movernding:         Single;
    function GetNewProtocol : Boolean;
    function GetCounter(AOpcode: TOperationProcess): TCounter;
    function IncCopID: string;
    function ChargeTypeDecoded(EncCC: UInt16): TChargeType;
    function ChargeTypeEncoded(CC: TChargeType): UInt16;
    procedure FetchMintSerialNumber;
    procedure MakeHashFromSerialNumber;
    procedure SetBoxWeb(const Value: Boolean);
    function ConnectToFlexPlusDrive: Boolean;
    function ConnectToMintDrive: Boolean;
    function ROMVersionOK: Boolean;
    function MintMove(d: Single): Boolean;
    procedure CheckSessionID;
    procedure SetSessionID;
  public
    MintController1: TMintController;
    MintController2: TMintController;
    MintVersion:     AnsiString;
    stopnow:         Boolean;
    pcfactive:       Boolean;
    encPcm:          Single;
    PowerPercent:    Double;
    MachineDetail:   String;
    ConnectInfo:     String;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure IncCounter(AOpcode: TOperationProcess);
    function  CounterExceeded: boolean;
    procedure ReadMachineCounters;
    procedure ReadCountersFromIni(AInifile: TIniFile);
    procedure SaveCountersToIni(AInifile: TIniFile);
    procedure SetChargeType(CC: TChargeType);
    procedure ReadMachineChargeType;
    function  GetMintString(AValueID: TMintValue): string;
    procedure StartTimer;
    procedure StopTimer;

    function  ReadCommsArray(canum: ansiString; dps: boolean): boolean;
    procedure SendMintCommand(Cmd: string);
    function  WriteCommsArray(canum, datas: string): boolean;
    function  SendCommand(Cmd: ansiString; mess: boolean): boolean;
    procedure CommsArrayWaitForZero(canum: ansiString);
    procedure SendVirtualCommand(Cmd: string);
    procedure Calibrate(AEncPulsePerCm: Double);
    procedure SetPrecamber(Item: TEntityItem);
    function  CommandCompleted: boolean;
    function  ReadMachineFirmware: string;
    function  ReadMintVersion: boolean;
    procedure SetMintValue(AValueID: TMintValue; AValue: Double);
    function  GetMintValue(AValueID: TMintValue): Double;
    procedure SetMintString(AValueID: TMintValue; AValue: string);
    function  OpenComm1: boolean;
    function  doConnectToDrive: boolean;
    function  ConnectToDrive: boolean;
    procedure DisConnect;
    function  MoveMotor(d: Double): boolean;
    function  CheckConnection: boolean;
    procedure MakeLength(ALength: Double; ACutFirst: boolean); deprecated;

    procedure FPunch;   //flange punch
    procedure LPunch;   //lip punch
    procedure Cope;     //cope edge
    procedure Notch;    //notch web
    procedure Swage;    //swage ends
    procedure Service1; //small service1 hole
    procedure Service2; //large service1 hole
    procedure Flat;     //flatten flange
    procedure EndBearingNotch;     // Extra cut for end bearing
    procedure Cutter;   //cut

    property Boxweb: boolean read FisBoxweb write setBoxWeb;
    property Connected: TConnectionState read FConnected;
    property MachineChargeType: TChargeType read FMachineChargeType;
    property MintSerialNumber: ansiString read FMintSerialNumber;
    property Tick: Cardinal read FTick;
    property NewProtocol: boolean read GetNewProtocol;
    property CommData: string read FCommData write FCommData;
    property Counters[opCode: TOperationProcess]: TCounter read GetCounter;

  end;

var
  Rollformer: TRollformer;

  ReceivedStrings : AnsiString;

  errcount: integer;  // set; never used

implementation

{$R *.dfm}

uses
  pause, Usettings, PauseRequest, Logging, globalU, DateUtils, Registry, Com_Exception
  , JSON, UnitRemoteDBClass;

const

  COMM_SESSIONID = 36;

    VALUETIMEOUT =  8; //Interval 200 Timer1
      OP_TIMEOUT = 30; //Interval 200 Timer1
     MOVETIMEOUT = 450;//Interval 200 Timer1

     FLEXTIMEOUT = 10; //Interval 500 Timer4

var
  dummy: single;

function CtrlKeyDown: Boolean;
var
  Shift: TShiftState;
begin
  Shift := KeyboardStateToShiftState;
  Result := ssCtrl in Shift;
end;

{ TRollformer }

constructor TRollformer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMachineChargeType := ccGreen;
  FCounters := TObjectList<TCounter>.Create;
{$IFDEF TRUSS}
  FCounters.add(TCounter.Create(opCut,             'TGCW',  'Cut',          mintCountCut));
  FCounters.add(TCounter.Create(opCopsFlats,       'TCCW',  'Cope',         mintCountService));
  FCounters.add(TCounter.Create(opNotches,         'TNCW',  'Notch',        mintCountNotch));
  FCounters.add(TCounter.Create(opLipHole,         'TLPCW', 'Lip Punch',    mintCountLipPunch));
  FCounters.add(TCounter.Create(opFlangeHole,      'TFPCW', 'Flange Punch', mintCountFlangePunch));
{$ELSE}
  FCounters.add(TCounter.Create(opCut,             'PGCW',  'Cut',          mintCountCut));
  FCounters.add(TCounter.Create(opService1s,       'PSCW',  'Service',      mintCountService));
  FCounters.add(TCounter.Create(opService2s,       'PS2CW', 'Service #2',   mintCountService2));
  FCounters.add(TCounter.Create(opNotches,         'PNCW',  'Notch',        mintCountNotch));
  FCounters.add(TCounter.Create(opLipHole,         'PLPCW', 'Lip Punch',    mintCountLipPunch));
  if G_Settings.general_machinetype='PANELHD' then
  begin
    FCounters.add(TCounter.Create(opEndBearingNotch, 'PEBCW', 'End Bearing',  mintCountEndBearing));
    FCounters.add(TCounter.Create(opCopsFlats,       'PFPCW', 'Flaten Punch', mintCountFlatenPunch));
  end;
  if not G_Settings.IsSingleRivet then
    FCounters.add(TCounter.Create(opFlangeHole,      'PPCW',  'Flange Punch', mintCountFlangePunch));
{$ENDIF}
end;

procedure TRollformer.DataModuleCreate(Sender: TObject);
begin
  MintController1 := TMintController.Create(self);
  MintController2 := TMintController.Create(self);
  copid := '10';
end;

destructor TRollformer.Destroy;
begin
  MintController1.Free;
  MintController2.Free;
  FreeAndNil(FCounters);
  inherited;
end;

procedure TRollformer.StartTimer;
begin
  Timer1.Enabled := False;
  FTick := 0;
  Timer1.Enabled := True;
end;

procedure TRollformer.StopTimer;
begin
  Timer1.enabled := false;
end;

procedure TRollformer.Timer1Timer(Sender: TObject);
begin
  inc(FTick);
end;


{$REGION 'Values'}

function TRollformer.GetMintValue(AValueID: TMintValue): Double;
var
  s: string;
begin
  try
    s := GetMintString(AValueID);
    Result := StrToFloat(s);
  except
    on e: exception do
      HandleException(e,'TRollformer.GetMintValue',[]);
  end;
end;

procedure TRollformer.setMintValue(AValueID: TMintValue; AValue: Double);
begin
  try
    SetMintString(AValueID, FloatToStr(AValue));
  except
    on e: exception do
      HandleException(e,'TRollformer.setMintValue',[]);
  end;
end;

procedure TRollformer.SetMintString(AValueID: TMintValue; AValue: string);
begin
  if (DriveClass = tdcSim) then
    exit;
  StartTimer;
  try
    try
      WriteCommsArray('13', AValue);
      WriteCommsArray('11', inttostr(ord(AValueID)));
      repeat
        ReadCommsArray('11', False)
      until (commdata = '0') or (FTick>VALUETIMEOUT)
    except
      on e: exception do
        HandleException(e,'TRollformer.setMintString',[]);
    end;
  finally
    StopTimer;
  end;
end;

procedure TRollformer.SetChargeType(CC: TChargeType);
begin
  setMintValue(mintEncChargeType, ChargeTypeEncoded(CC));
end;

function TRollformer.ChargeTypeDecoded(EncCC: uint16): TChargeType;
begin
  Result := ccGreen;
  if EncCC = ChargeTypeEncoded(ccRed) then
    Result := ccRed;
  if EncCC = ChargeTypeEncoded(ccNoCharge) then
    Result := ccNoCharge;
end;

procedure TRollformer.ReadMachineChargeType;
var
  EncCC: uint16;
begin
  FMachineChargeType := ccGreen;
  if FNewProtocol then
  begin
    EncCC := round(strToFloatDef(getMintString(mintEncChargeType), 0)) and $FFFF;
    FMachineChargeType := ChargeTypeDecoded(EncCC);
  end;
end;

function TRollformer.ReadMachineFirmware: string;
var
  n: single;
begin
  Result := '?';
  try
    if IsBaldorDrive then
    begin
      if FNewProtocol then
        n := getMintValue(mintFirmwareRelease)
      else
        n := MintController1.Comms[29]; // dedicated comms[] port
      Result := floattostr(n);
    end;
  except
    on e: exception do
      HandleException(e,'TRollformer.ReadMachineFirmware',[]);
  end;
end;

function TRollformer.getMintString(AValueID: TMintValue):string;
begin
  TVMForm.AddString('getMintString [' + inttostr(ord(AValueID))+']');
  StartTimer;
  try
    try
      WriteCommsArray('12', IntToStr(ord(AValueID)));
      repeat
        Application.ProcessMessages;
        ReadCommsArray('12', False);
        if (FTick > VALUETIMEOUT) then
        begin
           TVMForm.AddString('getMintString Timeout');
           FCommData:='0';
           exit(FCommdata);
        end;
      until (FCommData = '0');
      ReadCommsArray('13', true);
      TVMForm.AddString('getMintString=['+IntToStr(ord(AValueID))+'] =' + commdata);
      Result := commdata;
    except
      on e: exception do
        HandleException(e,'TRollformer.getMintString',[]);
    end;
  finally
    StopTimer;
  end;
end;
{$RANGECHECKS off}

function TRollformer.ChargeTypeEncoded(CC: TChargeType): uint16;
begin
  // Use uint16 for encryption to ensure no loss of precision
  // Mint Comms[] values are type single with 24 bit digit mantissa;
  // this would not guarantee fidelity for 32 bit values
  Result := (FSerialHash * ord(CC)) and $FFFF;
end;

procedure TRollformer.CheckSessionID;
var MachineSessionID: integer;
begin
  if IsBaldorDrive and FNewProtocol and (FSessionID <> 0) then
  begin
    MachineSessionID := round(MintController1.Comms[COMM_SESSIONID]);
    if (FSessionID <> MachineSessionID) then
    begin
      TaskMessageDlg('Sequence Error', 'Restart detected', mtError, [mbOk],0);
      raise ERestart.Create('');
    end;
  end;
end;

procedure TRollformer.MakeHashFromSerialNumber;
var i: Integer;
  function Rot16(x, k: uint16): uint16;
  begin
    Result := (x shl k) or (x shr (16 - k));
  end;

begin
  FSerialHash := 0;
  getMintString(mintSerial);
  for i := 1 to 10 do
  begin
    if i < length(MintSerialNumber) then
      FSerialHash := Rot16(FSerialHash, 3) + ord(FMintSerialNumber[i]);
  end;
end;

procedure TRollformer.FetchMintSerialNumber;
var i, n: Integer;
begin
  FMintSerialNumber := '';
  if isBaldorDrive then
  begin
    FSerialHash := 0;
    getMintString(mintSerial); // 1st char: full result in comms[13].. comms[22]
    for i := 1 to 10 do
    begin
      n := round(MintController1.Comms[12 + i]) and $FF;
      if ansiChar(n) in ['0' .. '9', 'A' .. 'Z', 'a' .. 'z', '.'] then
        FMintSerialNumber := FMintSerialNumber + ansiChar(n);
    end;
  end;
end;
{$RANGECHECKS on}

function TRollformer.ReadMintVersion: boolean;
// Returns Mint version (PVersion) from RF
// also read EncPCm
var
  Version  : Double;
  sMajor   : Integer;
  sMinor   : Integer;
  sRelease : Integer;
begin
  try
    Result := False;
    MintVersion:='';
    Application.ProcessMessages;
    Randomize;
    Version := GetMintValue(mintPVersion);
    if Version=0  then
    begin
      raise EConnectError.Create('no response (version)');
    end;
    MintVersion := Format('%5.1f', [Version]);
    EncPcm := getMintValue(mintEncPCm);
    FetchMintSerialNumber;
    FNewProtocol := length(FMintSerialNumber)> 5;
    if FNewProtocol then
    begin
      MakeHashFromSerialNumber;
      //GetVersionNumbers(sMajor, sMinor, sRelease);                            //Steven GetVerInfo give empty
      sMajor :=5;
      sMinor :=1;
      sRelease := 1;
      SetMintValue(mintRFVersion, sMajor + sMinor / 10);
      ReadMachineChargeType;
    end;

    TVMForm.AddString('ReadMintVersion '+floattostr(version));
    Result := true;
  except
    on e: exception do
      HandleException(e,'TRollformer.ReadMintVersion',[]);
  end;
end;
{$ENDREGION}
{$REGION 'Operations'}

function TRollformer.CheckConnection: boolean;
begin
  try
     if (Connected=tcConnected) and
        (DriveClass in [ tdcMint,tdcFlex]) then
       dummy:=MintController1.Comms[ord(mintPVersion)];
  except
    on e: exception do
    begin
      tvmForm.addstring(e.classname + ' ' + e.message);
      FConnected := tcNone;
    end;
  end;
  result := (Connected=tcConnected) ;
end;

function TRollformer.MoveMotor(d: Double): boolean;
// *Sends command to move the RF d:real mm, returns false if the move failed
var
  ts: string;
  di: Integer;
begin
  if (DriveClass = tdcSim) then
     exit(true);

  str(d: 7: 2, ts);
  stopnow := false;
  application.processmessages;
  Result := true;
  case DriveClass of
    tdcMint:
      begin
        CheckSessionID;
        if d > 0 then
          Result := MintMove(d);
      end;
    tdcFlex:
      begin { Legacy Flex drive - keep track of position rounding to improve accuracy in Flex }
        di := round(d + movernding);
        movernding := d + movernding - di;
        if SendCommand('MM' + inttostr(di) + '#', true) then
          Result := CommandCompleted
        else
          Result := false;
      end;
     tdcVirtual:
        begin
          if ctrlKeyDown then Raise ENoSteel.Create('NOSTEEL');
          Result := true;
          if d > 0 then
              SendVirtualCommand(floattostr(d));
        end;
    tdcSim:;
  end;
end;

procedure TRollformer.MakeLength(ALength: Double; ACutFirst: boolean);
//*Move set length & cut material
var
  MoveDistance: Double;
begin
  Check(CardAdapter.CheckCardOK and CardAdapter.HasCredit, 'Smartcard Error');
  if ACutFirst then
    Cutter;
  if ALength > 0 then
  begin
    MoveDistance := ALength + CutWidth;
    if MoveMotor(MoveDistance) then
      Cutter;
    CardAdapter.DeductMM(MoveDistance, true);  // MakeLength
  end;
end;

function TRollformer.ROMVersionOK: boolean;
// *Gets a valid ROM version from legacy BL1600 Bd. (Flex+ drives only)
var
  ts: string;
  ROMVersion: Integer;
begin
  Result := false;
  if SendCommand('RV#', false) then
    if CommandCompleted then
    begin
      ts := copy(ReceivedStrings, 2, length(ReceivedStrings) - 2);
      ROMVersion := strToIntDef(ts, 0);
      Result := ROMVersion >= 27;
    end;
end;

procedure TRollformer.SendVirtualCommand(Cmd: string);
begin
   TVMForm.AddString(Cmd);
end;

procedure TRollformer.Cutter;
// *Sends Guillotine command to RF
// *Selects command for Mint or legacy drives, and has optional pause
begin
  Application.ProcessMessages;
  Rollformer.IncCounter(opCut);
  case DriveClass of
    tdcMint:    SendMintCommand('Cut');
    tdcFlex:    SendCommand('CC#', true);
    tdcVirtual: SendVirtualCommand('Cut');
    tdcSim:;
  end;
  if StrToFloat(G_Settings.general_oppause) > 0 then
  begin
    StartTimer;
    repeat
      Application.ProcessMessages;
    until FTick >= 10*StrToFloat(G_Settings.general_oppause);
    StopTimer;
  end;
end;

procedure TRollformer.Notch;
begin
  Application.ProcessMessages;
  incCounter(opNotches);
  case DriveClass of
    tdcMint:    SendMintCommand('Notch');
    tdcFlex:    SendCommand('NN#', true);
    tdcVirtual: SendVirtualCommand('Notch');
    tdcSim:;
  end;
  if (not bframes) and (G_Settings.trussrf_dblnotch) and (DriveClass = tdcMint) then
    SendMintCommand('Notch');
  if strtofloat(G_Settings.general_oppause) > 0 then
  begin
    StartTimer;
    repeat
      application.processmessages
    until FTick >= 10*strtofloat(G_Settings.general_oppause);
    StopTimer;
  end;
end;

procedure TRollformer.FPunch;
begin
  Application.ProcessMessages;
  incCounter(opFlangeHole);
  case DriveClass of
    tdcMint:    SendMintCommand('FlangePunch');
    tdcFlex:    SendCommand('HH#', true);
    tdcVirtual: SendVirtualCommand('FlangePunch');
    tdcSim:;
  end;
end;

procedure TRollformer.LPunch;
begin
  Application.ProcessMessages;
  incCounter(opLipHole);
  case DriveClass of
    tdcMint:    SendMintCommand('LipPunch');
    tdcFlex:    SendCommand('HH#', true);
    tdcVirtual: SendVirtualCommand('LipPunch');
    tdcSim:;
  end;
end;

procedure TRollformer.Cope;
begin
  Application.ProcessMessages;
  incCounter(opCopsFlats);
  case DriveClass of
    tdcMint:    SendMintCommand('Cope');
    tdcFlex:    SendCommand('FF#', true);
    tdcVirtual: SendVirtualCommand('Cope');
    tdcSim:;
  end;
end;

procedure TRollformer.Flat;
begin
  Application.ProcessMessages;
  incCounter(opCopsFlats);
  case DriveClass of
    tdcMint:    SendMintCommand('Flat');
    tdcFlex:    SendCommand('FF#', true);
    tdcVirtual: SendVirtualCommand('Flat');
    tdcSim:;
  end;
end;

procedure TRollformer.EndBearingNotch;
begin
  Application.ProcessMessages;
  incCounter(opEndBearingNotch);
  case DriveClass of
    tdcMint: SendMintCommand('EndBrgNotch');
    tdcFlex: ; // not supported
    tdcVirtual: SendVirtualCommand('EndBrgNotch');
    tdcSim:;
  end;
end;

procedure TRollformer.Swage; { swage ends }
begin
  Application.ProcessMessages;
  case DriveClass of
    tdcMint:    SendMintCommand('Swage');
    tdcFlex: ;
    tdcVirtual: SendVirtualCommand('Swage');
    tdcSim: ;
  end;
end;

procedure TRollformer.Timer4Timer(Sender: TObject);
begin
  inc(FTick4);
  TVMForm.addString(' Timer4 TOCK '+inttostr(FTick4));
end;

procedure TRollformer.Service1;
begin
  Application.ProcessMessages;
  incCounter(opService1s);
  case DriveClass of
    tdcMint: SendMintCommand('Service1');
    tdcFlex: SendCommand('SS#', true);
    tdcVirtual: SendVirtualCommand('Service1');
    tdcSim:;
  end;
end;

procedure TRollformer.Service2;
begin
  Application.ProcessMessages;
  incCounter(opService2s);
  case DriveClass of
    tdcMint: SendMintCommand('Service2');
    tdcFlex: SendCommand('SS#', true);
    tdcVirtual: SendVirtualCommand('Service2');
    tdcSim:;
  end;
end;

procedure TRollformer.setBoxWeb(const Value: boolean);
begin
{$IFDEF PANEL}
  FisBoxweb := False;
{$ELSE}
  FisBoxweb := Value and G_Settings.general_BoxRF;
{$ENDIF}
end;

procedure TRollformer.Calibrate(AEncPulsePerCm: Double);
begin
  case DriveClass of
    tdcMint:
      begin
        setMintValue(mintEncPCm, AEncPulsePerCm);
        If MintVersion >= '630' then
          setMintValue(mintEncPCmBkup, AEncPulsePerCm);
      end;
    tdcFlex:
      begin
        SendCommand(trim(Format('LL%6.4f#',[AEncPulsePerCm])), true) { no wait };
      end;
    tdcVirtual: SendVirtualCommand(Format('Calibrate %6.4f',[AEncPulsePerCm]));
    tdcSim:;
  end;
end;
{$ENDREGION}
{$REGION 'Comms'}

procedure TRollformer.DisConnect;
begin
  FConnected := tcNone;
end;

function TRollformer.ConnectToDrive: boolean;
const
  BOXWEB_IP = '192.168.100.2';
begin
  FConnected := tcNone;
  FMachineChargeType := ccGreen;
  assert((DriveClass <> tdcSim), 'sim mode');

  screen.cursor := crHourGlass;
  try
    try
      if not doConnectToDrive then
        exit(False);
      case G_Settings.RollFormerDrive of
        tdFlexPlus: ;
        tdVirtual:  begin
                      FMachineChargeType := ccGreen;
                      MintVersion:='456';
                      FMintSerialNumber:='A0123456789';
                    end
      else
      begin
        if not ReadMintVersion then
          Exit(False)
      end;
      end;
    except
      on e: EConnectError do
      begin
        screen.cursor := crdefault;
        ConnectInfo := E.message;
        FConnected := tcFailed;
        exit(False);
      end;
    end;
  finally
    screen.cursor := crdefault;
  end;

  if G_Settings.general_BoxRF then
  try
    MintController2.SetEthernetControllerLink(BOXWEB_IP); // Dual Box RF only
  except
    on e: EConnectError do
    begin
      MessageDlg('Unable to connect to Box Web Rollformer'#10 + 'IP=' + BOXWEB_IP + #10 + e.message, mterror, [mbOK], 0);
      FConnected := tcFailed;
      exit(false);
    end;
  end;
  FConnected := tcConnected;
  Result := true;
end;

function TRollformer.doConnectToDrive: boolean;
var
  comports: string;
begin
  TVMForm.AddString('doConnectToDrive');
  FCommErrors := 0;
  case G_Settings.RollFormerDrive of
    // BaldorDrives:
    tdMint2_5225Plus:
      begin
        comports := G_Settings.general_comport;
        MintController1.SetMintDrive2Link(1, strtoint(copy(comports, 4, 2)), strtoint(G_Settings.general_baudrate), true);
      end;
    tdMotiFlexE100_IP_Mint:
      MintController1.SetEthernetControllerLink('192.168.100.1');
    tdFlexE150:
      MintController1.SetEthernetControllerLink('192.168.0.1');
    tdFlexE190:
      MintController1.SetEthernetControllerLink('192.168.0.4');
    tdMotiFlexE180:
      MintController1.SetEthernetControllerLink('192.168.0.2');
    tdMotiFlexE100_Mint:
      MintController1.SetUSBControllerLink(3); //USB comms
    tdMint, tdMint2:
      ConnectToMintDrive;
    tdFlexPlus:
      if not ConnectToFlexPlusDrive then
        exit(false);
    tdVirtual: exit(True);
  end;
  if not(G_Settings.RollFormerDrive in [tdMint, tdMint2, tdFlexPlus]) then
    if not MintController1.DeviceOpen then
      exit(false);
  if not(G_Settings.RollFormerDrive in [tdMint, tdMint2, tdFlexPlus]) and
     FNewProtocol then
    SetSessionID;

  TVMForm.AddString('doConnectToDrive OK');
  Result := true;
end;

procedure TRollformer.SetSessionID;
var NewSessionID: integer;
begin
// create a random session key and save in the the mint
// if it changes, the mint dive has been restarted
// magnitude limited to avoid possible rounding in mint floating number format
  NewSessionID := $100000 or Random($FFFFF);

  FSessionID := NewSessionID;
  MintController1.Comms[COMM_SESSIONID]:=NewSessionID;
  TVMForm.AddString('SetSessionID '+IntToHex(NewSessionID,8));
end;

function TRollformer.ConnectToMintDrive: boolean;
begin
  assert(DriveClass = tdcMint);
  assert(not IsBaldorDrive);
  Result := false;
  if OpenComm1 then
  begin
    If G_Settings.general_baudrate = '19200' then
      VaComm1.baudrate := TVabaudrate(br19200)
    else if G_Settings.general_baudrate = '9600' then
      VaComm1.baudrate := TVabaudrate(br9600)
    else
      VaComm1.baudrate := TVabaudrate(br57600);
    try
      VaComm1.purgeread;
      Result := true;
    except
      on e: exception do
        HandleException(e,'TRollformer.ConnectToMintDrive',[]);
    end;
  end;
end;

function TRollformer.ConnectToFlexPlusDrive: boolean;
var ts1, ts2: string;
begin
  assert(G_Settings.RollFormerDrive = tdFlexPlus); // 'Flex+'
  Result := false;
  VaComm1.baudrate := TVabaudrate(br9600); // Flex & Flex+
  if OpenComm1  and
     ROMVersionOK then   //ROMVersionOK is check for legacy BL1600 ROM chip version
  begin
    ts1 := '';
    ts2 := '';
    SendCommand('RS#', true);
    FTick4:=0;
    Timer4.enabled:=true;
    repeat
      application.processmessages
    until FTick4 > 3;
    if SendCommand('RM#', true) and CommandCompleted then
    begin
      if pos('Normal', ReceivedStrings) > 0 then
        ts2 := 'Normal';
      if pos('Idle', ReceivedStrings) > 0 then
        ts2 := 'Idle';
      if pos(':', ReceivedStrings) > 5 then
        ts1 := copy(ReceivedStrings, pos(':', ReceivedStrings) - 6, 5)
      else
        ts1 := '?';
      MachineDetail:= ts1 + ':' + ts2;
    end;
    result := true;
    Timer4.enabled:=False;
  end;
end;

function TRollformer.WriteCommsArray(canum, datas: string): boolean;
// * Low level write to comms code to Mint Controllers
var
  td: array [1 .. 100] of byte;
  i: Integer;
  chksum: byte;
  tds, nodes, canums: ansiString;
begin
  result := true;
  if IsBaldorDrive then // Use VaComm1 serial port
  begin // Mint II, e100 baldor Comms with ActiveX component
    try
      if FisBoxweb then
        MintController2.Comms[strtoint(canum)] := strtofloat(datas)
      else
        MintController1.Comms[strtoint(canum)] := strtofloat(datas);
      except
        on e: exception do
          HandleException(e,'TRollformer.WriteCommsArray',[]);
      end;
  end else
  begin
    if G_Settings.RollFormerDrive = tdMint2 then
      nodes := '1'
    else
      nodes := '0';
    td[1] := eot;
    td[2] := ord(nodes[1]); { Mint II = '1', Mint = '0' }
    td[3] := td[2];
    td[4] := stx;
    if length(canum) = 0 then
      canums := '00'
    else if length(canum) = 1 then
      canums := '0' + canum
    else
      canums := canum;
    td[5] := ord(canums[1]);
    td[6] := ord(canums[2]);
    for i := 1 to length(datas) do
      td[6 + i] := ord(datas[i]);
    td[6 + length(datas) + 1] := etx;
    chksum := td[5];
    for i := 6 to 6 + length(datas) + 1 do
      chksum := chksum xor td[i];
    td[6 + length(datas) + 2] := chksum;
    tds := '';
    for i := 1 to 6 + length(datas) + 2 do
      tds := tds + ansiChar(td[i]);
    ReceivedStrings := '';
    VaComm1.WriteBuf(tds[1], length(tds));
    FTick4:=0;
    Timer4.Enabled:=true;
    repeat
      application.processmessages
    until (pos(ansiChar(ack), ReceivedStrings) <> 0) or (pos(ansiChar(nak), ReceivedStrings) <> 0) or (FTick4 > 2);
    Timer4.Enabled := False;
    Result := (pos(ansiChar(ack), ReceivedStrings) <> 0);
  end;

  if not Result then
    inc(errcount);
end;

function TRollformer.ReadCommsArray(canum: ansiString; dps: boolean): boolean;
// * Reads Comm Array from baldor drive using legacy or MintController code
// * dps:boolean is flag for decimal or whole numbers retrieved
var
  td: array [1 .. 100] of byte;
  i, j, k, p: Integer;
  tds, nodes, canums: ansiString;
  ts: string;
begin
  FCommData := '';
  if not IsBaldorDrive then // Use VaComm1 serial port
  begin
    if G_Settings.RollFormerDrive = tdMint2 then
      nodes := '1'
    else
      nodes := '0';
    td[1] := eot;
    td[2] := ord(nodes[1]); { Mint II = '1' Mint = '0' }
    td[3] := td[2];
    td[4] := stx;
    if length(canum) = 0 then
      canums := '00'
    else if length(canum) = 1 then
      canums := '0' + canum
    else
      canums := canum;
    td[5] := ord(canums[1]);
    td[6] := ord(canums[2]);
    td[7] := enq;
    tds := '';
    for i := 1 to 7 do
      tds := tds + ansiChar(td[i]);
    ReceivedStrings := '';
    VaComm1.WriteBuf(tds[1], length(tds));
    FTick4:=0;
    Timer4.Enabled:=true;
    repeat
      application.processmessages;
      sleep(40)
    until (pos(ansiChar(etx), ReceivedStrings) <> 0) or (pos(ansiChar(nak), ReceivedStrings) <> 0) or (FTick4 > 4);
    k := pos(ansiChar(stx), ReceivedStrings);
    j := pos(ansiChar(etx), ReceivedStrings);
    if j > 0 then // wait for checksum byte
      repeat
        application.processmessages;
      until (length(ReceivedStrings) = j + 1) or (FTick4 > 4);
    Result := (k <> 0) and (j <> 0) and (FTick4<=4);
    Timer4.Enabled:=false;

    if Result then
    begin
      ts := '';
      for i := k + 3 to j - 1 do
        ts := ts + ReceivedStrings[i];
      // Remove dps for firmware > 5225
      if not dps then
      begin
        p := pos('.', ts);
        if p > 0 then
          ts := copy(ts, 1, p - 1);
      end;
      FCommData := ts;
    end;
  end
  else
  begin // Mint II baldor Comms ActiveX component
    Result := true;
    try
      if FisBoxweb then
        ts := floattostr(MintController2.Comms[strtoint(trim(canum))])
      else
        ts := floattostr(MintController1.Comms[strtoint(trim(canum))]);

      if not dps then
      begin
        p := pos('.', ts);
        if p > 0 then
          ts := copy(ts, 1, p - 1);
      end;
      FCommData := ts;
    except
      On e: Exception do
      begin
        raise;
        //          if formsettings.CommsMessageCBox.Checked then
        //            MessageBox(0, PChar(e.Message), 'Comms Read Error', MB_OK);
        //          result := false;
      end;
    end;
  end;
  if not Result then
    inc(errcount);
end;

function TRollformer.IncCopID: string;
// *Increments cop (current operation) ID string
var
  ti: Integer;
begin
  try
    ti := strtoint(copid) + 1;
  except
    ti := 1;
  end;
  if ti = 999 then
    ti := 10;
  Result := inttostr(ti);
end;

function TRollformer.MintMove(d: single): boolean;
// *Sends command to move Mint drives d:real mm
// *Writes distance into 2 comms array locations : 5 and 35 for error checking
// *Sets comm array 4 as flag to start move.
// *Move times out after 450 ticks of timer1
// *Updates production file, if activated
// *Uses Copid Current operation ID, to ensure no comms errros
// *Reads drive current & updates Power meter if active (Mint II) only
label start;
var
  reply, opid, ts, sTemp: string;
  PauseReason: string;
  aJSONObject : TJSONObject;

begin
  if G_Settings.general_IsMicroMM then
    d := d*1000; //convert mm to um

start :

  if G_Settings.general_IsMicroMM then
    Str(d: 10: 4, ts)
  else
    Str(d:  7: 2, ts);

//  showmessage('Move = '+ ts + ' um');
  WriteCommsArray('5', ts);
  WriteCommsArray('35', ts); { resend move as chk }
  StartTimer;
  repeat
    FTick:=0;
    copid := IncCopID;
    if MintVersion >= '104' then
      WriteCommsArray('30', copid);
    WriteCommsArray('4', '1');
    repeat
      application.processmessages;
      Sleep(10);
      ReadCommsArray('4', false);
      reply := commdata;
    until (commdata = '0') or
          (commdata >= '2')
           or (FTick > MOVETIMEOUT);

{ pause and read again: when 'no steel' occurs Mint first posts
    '0' (= operation complete) and then posts '6'(=no steel).
   After '6'  the reply code (99) is required to un-freeze the mint; if this is missed,
   the Mint stay locked in a loop
}
    sleep(10);
    ReadCommsArray('4', false);


    if commdata = '0' then
    begin
      if MintVersion >= '104' then
        ReadCommsArray('31', false)
      else
        FCommData := copid;
    end;
    opid := commdata;
  until (reply >= '2') or ((FTick <= MOVETIMEOUT) and (opid = copid)) or (FTick > MOVETIMEOUT);
  StopTimer;
  if reply = '3' then
  begin
    if FisBoxweb then
      showmessage('WARNING - Excess Box web slippage')
    else
      showmessage('WARNING - Excess slippage');
  end;
  if reply = '2' then { RF has been paused }
  begin
    FRFDateInfo.StartPause := now;
    aJSONObject := TJSONObject.Create;
    aJSONObject.AddPair(TJSONPair.Create('EventID', IntToStr(Ord(rfetPause))));
    aJSONObject.AddPair(TJSONPair.Create('RollformerID', IntToStr(FRFDateInfo.ROLLFORMERID) ));
    aJSONObject.AddPair(TJSONPair.Create('JobID',        ''));
    aJSONObject.AddPair(TJSONPair.Create('JobName',      ''));
    aJSONObject.AddPair(TJSONPair.Create('EP2FILEID',    ''));
    aJSONObject.AddPair(TJSONPair.Create('EP2FILE',      ''));
    aJSONObject.AddPair(TJSONPair.Create('FRAMEID',      ''));
    aJSONObject.AddPair(TJSONPair.Create('FrameName',    ''));
    aJSONObject.AddPair(TJSONPair.Create('ItemName',     ''));
    aJSONObject.AddPair(TJSONPair.Create('DayMeters',    ''));
    if G_Settings.general_IsConnectToServer then
    begin
      TRemoteDB(DMScotServer).DMRemoteDB.ServerClient.BroadcastToChannel(DashboardChannelName, aJSONObject);
      TRemoteDB(DMScotServer).DMRemoteDB.ServerClient.BroadcastToChannel(JobLiveChannelName, aJSONObject);
    end;
    PauseForm.Show;
    { wait until comms array 4 = 0 to indicate continue processing }
    repeat
      application.processmessages;
      ReadCommsArray('4', false);
    until (commdata = '0');
    PauseForm.Hide;
    EventAudit(rfetPause, Format('Duration=%d', [SecondsBetween(Now, FRFDateInfo.StartPause)]));
  end
  else if reply = '5' then { drive error }
  begin
    if FisBoxweb then
      MessageDlg('Box web Drive Error', mterror, [mbOK], 0)
    else
      MessageDlg('Drive Error', mterror, [mbOK], 0);
    Result := false;
    system.exit;
  end
  else if reply = '6' then { Error - No steel detected }
  begin
    if FisBoxweb then
      MessageDlg('WARNING - NO Steel detected in Box Web RF', mterror, [mbOK], 0)
    else
      MessageDlg('WARNING - NO Steel detected', mterror, [mbOK], 0);

    WriteCommsArray('4', '99'); // release the mint Pause

    raise ENoSteel.Create('WARNING - NO Steel detected');
    (*
     WriteCommsArray('4', '99');
     DlgLoad.showmodal; { unit9 }
     //result := false;
     CloseReader;
     ReaderClosed:=true; //not used ...
     showmessage('ScotRF will terminate now');
     application.terminate; // Exit program
     *)
    //system.exit;
  end;
  if FisBoxweb then
    sTemp := 'WARNING - Box web Move NOT completed'
  else
    sTemp := 'WARNING - Move NOT completed';
  if (FTick > 90) and (MessageDlg(sTemp, mtwarning, [mbRetry, mbOK], 0) = mrRetry) then
  begin
    inc(FCommErrors);
    goto start;
  end; { try again if user selects }
  Result := true;
   if G_Settings.misc_power then { update Power Meter if active }
   begin
     ReadCommsArray('32', true);
     try
       PowerPercent := strtofloat(commdata) * 100 / strtofloat(G_Settings.misc_current);
     except
       PowerPercent:=0;
     end;
   end;
end;

procedure TRollformer.SendMintCommand(Cmd: string);
// * Sends and receives all commands from Mint and Mint II and e100 controllers
// * Uses bFrames to select Panel (bframes=true) or truss RFs
var
  comid, mver, reply, opid, sTemp: string;
begin
  CheckSessionID;
  sTemp := ifThen(FisBoxweb, 'Box Web RF', 'RF');
  mver := MintVersion;
  FReSends := 0;
  reply := ''; { Mintversion is the mnt/mex prog version string }
  if (Cmd = 'Cut') or (Cmd = 'Notch') then
  begin
    if Cmd = 'Cut' then
      comid := '6'
    else if bframes then
      comid := '7'
    else
      comid := '8';
    repeat { send cut cmd, but try twice if timed out- could be jamned ? }
      copid := IncCopID;
      reply := '';
      if (mver >= '104') then
        WriteCommsArray('30', copid);
      WriteCommsArray(comid, '1');
      inc(FReSends);

      StartTimer;//Steven
      repeat // wait until completed or timed out
        ReadCommsArray(comid, false);
      until (commdata <> '1') or (FTick > 65);
      reply := commdata;
      StopTimer;//Steven

      if (FTick > 65) and (reply <> '2') then
        inc(FCommErrors);

      if reply = '0' then
      begin
        if mver >= '104' then
          ReadCommsArray('31', false)
        else
          FCommData := copid;
      end;
      opid := commdata;
    until (reply >= '2') or (reply = '0') or (FReSends = 2) or ((FTick <= 65) and (opid = copid));
    if reply = '5' then // Error has occurred, display Mint drive status window
    begin
      MessageDlg('Drive Error', mterror, [mbOK], 0);
      system.exit;
    end
    else if reply = '2' then
      MessageDlg('WARNING - Double ' + Cmd + ' attempted on ' + sTemp, mtwarning, [mbOK], 0)
    else if FReSends = 2 then
      MessageDlg('WARNING - Incomplete ' + Cmd + ' on ' + sTemp, mtwarning, [mbOK], 0);
  end
  else // Send commands other than Cut & Notch, these functions only try once.
  begin
    if bframes then // panels : slightly different operation ids between truss & panel RFs
    begin
      // showmessage('Panel mint op');
      if (Cmd = 'Punch') or (Cmd = 'FlangePunch') then
        comid := '8'
      else if (Cmd = 'LipPunch') then
        comid := dblpunchid // extra punch fired from service2 tool
      else if (Cmd = 'Flat') or (Cmd = 'Cope') then
        comid := '9'
      else if Cmd = 'Service1' then
        comid := '15'
      else if Cmd = 'Service2' then
        comid := plumbingid // 16 -> 17 Mar 2012
      else if Cmd = 'Swage' then
        comid := '10'
      else if Cmd = 'EndBrgNotch' then
        comid := '23'
      else
        comid := '';
    end
    else // trusses : comid is the command id number
    begin
      if Cmd = 'Cope' then
        comid := '7'
      else if Cmd = 'LipPunch' then
        comid := '9'
      else if Cmd = 'FlangePunch' then
        comid := '10'
      else if Cmd = 'Swage' then
        comid := '24'
      else
        comid := '';
    end;
    repeat
      copid := IncCopID;
      if (mver >= '104') then
        WriteCommsArray('30', copid);
      WriteCommsArray(comid, '1');
      inc(FReSends);
      StartTimer;  //Steven
      repeat // wait for completion or timeout
        ReadCommsArray(comid, false);
      until (commdata = '0') or (FTick > OP_TIMEOUT);
      StopTimer;   //Steven
      if (commdata = '0') then
      begin
        if (mver >= '104') then
          ReadCommsArray('31', false)
        else
          FCommData := copid;
      end;
    until (FReSends = 2) or (commdata = copid);
    if FReSends = 2 then
      inc(FCommErrors);
    if (commdata <> copid) then
      MessageDlg('WARNING -' + sTemp + '  Incomplete ' + Cmd, mtwarning, [mbOK], 0);
  end;
end;

procedure TRollformer.CommsArrayWaitForZero(canum: ansiString);
begin;
  StartTimer;
  while true do
  begin
    ReadCommsArray(canum, False);
    if FTick > VALUETIMEOUT then
      raise ETimeout.Create('timeout port '+canum+ '  ' +commdata);

    if (commdata = '0') then
      break;
    application.processmessages;
    sleep(40);
  end;
  StopTimer;
end;

function TRollformer.SendCommand(Cmd: ansiString; mess: boolean): boolean;
// * Send command to Z180 - legacy code, uses std serial driver
var
  PauseReason: string;
begin
  ReceivedStrings := '';
  assert(DriveClass = tdcFlex);
  FTick4 := 0;
  Timer4.enabled := true;
  try
    VaComm1.WriteBuf(Cmd[1], length(Cmd));
    repeat
      application.processmessages;
    until (pos('*', ReceivedStrings) <> 0) or (pos('!', ReceivedStrings) <> 0)or (pos(':', ReceivedStrings) <> 0)
          or (pos('c', ReceivedStrings) <> 0) or (FTick4 > FLEXTIMEOUT) or stopnow;
  finally
    Timer4.enabled := false
  end;
  if (pos('!', ReceivedStrings) <> 0) then
  begin // rf paused, indicated by responding with a ! chr
    pauseform.show;
    ReceivedStrings := '';
    repeat
      application.processmessages
    until (pos('c', ReceivedStrings) <> 0); // continue chr is a c
    pauseform.Hide;

    { request & log pause reason }
    if G_Settings.Logging_LogPauseReason then
      PauseReason := GetPauseReason
    else
      PauseReason := '';
    FTick4 := 0;
    Timer4.enabled := true;
    ReceivedStrings := '';
    repeat
      application.processmessages;
      if (FTick4 > FLEXTIMEOUT) then
        raise ETimeout.Create(Cmd);
    until (pos('*', ReceivedStrings) <> 0) or stopnow;
    if length(ReceivedStrings) = 0 then
      raise EConnectError.Create('Response empty');
    Result := pos('*', ReceivedStrings) > 0
  end
  else
  begin
    if (FTick4 > FLEXTIMEOUT) and mess then
      messagedlg('Rollformer timeout'#10+ReceivedStrings,mtError,[mbok],0);
    if length(ReceivedStrings) > 0 then
      Result := pos('*', ReceivedStrings) > 0
    else
      raise EConnectError.Create('Response <' + ReceivedStrings + '>');
  end;
end;

function TRollformer.CommandCompleted: boolean;
// *waits for returned # or x chrs from legacy BL1600 Bd. #:OK, x:excess slippage detected.
// *Times out after 300 ticks of timer1
begin
  assert(DriveClass = tdcFlex);
  StartTimer;
  repeat
    application.processmessages
  until (pos('#', ReceivedStrings) <> 0) or (pos('x', ReceivedStrings) <> 0) or (FTick > 300) or stopnow;
  if FTick > 300 then
  begin
    showmessage('Stopped - No completion !');
    stopnow := true;
  end;
  if (pos('x', ReceivedStrings) <> 0) then
  begin
    showmessage('Stopped - Excess slippage !');
    stopnow := true;
  end;
  Result := (pos('#', ReceivedStrings) <> 0);
  StopTimer;
end;

procedure TRollformer.SetPrecamber(Item: TEntityItem);
var
  ID2, ts: string;
  pcfactor, nfactor, cfactor: Double;
  Frame: TSteelFrame;
begin
  assert(G_Settings.trussrf_autopc);
(******************
  PRECAMBER CODE from Pete Gavin
  Function is unclear; Never tested; No test scipt or testing process
*******************)
  pcfactor := 1; cfactor := 1;
  Frame := Item.Frame;
  ID2 := copy(Item.ItemName, 1, 2);
  //If BC (Bottom chord of truss) or PB (bottom plate) of panel, check for precamber setting
  if (ID2 <> 'BC') and (ID2 <> 'PB') and pcfactive then
  begin { restore org. calibration }
    ReceivedStrings := '';
    { Reset RF to original calibration, before being precambered }
    Calibrate(cfactor);
    pcfactive := false;
    { Update production file, if selected }
    EventAudit(rfetPreCamber, 'PreCamber_Reset Ratio=' + floattostr(cfactor));

    //Update screen display of pre-camber % value
    ts := format('%3.2f', [pcfactor]) + ' %';
    //    uxPrecamber.caption := ts;  UI feedback - not here!

  end;

  ReceivedStrings := ''; //clr rcvd string - legacy controller code
  //Set new pre-camber calibration, if this next member is a BC or PB, and precamber is set
  if ((ID2 = 'BC') or (ID2 = 'PB')) and (not pcfactive) then
  begin
    //Get precamber value from SteelMem[] (truss only) if selected, else get from settings
    if (Frame.PreCamber > 0) then
      pcfactor := Frame.PreCamber
    else
    begin
      if not bframes then
        pcfactor := strtofloat(G_Settings.trussrf_precamber)
      else
        pcfactor := strtofloat(G_Settings.panelrf_precamber)
    end;
    //Update display & the RF with the new calibration value for precambering
    if (pcfactor <> 0) then
    begin
      //Display new % precamber value on screen
      ts := format('%3.2f', [pcfactor]) + ' %';
      //   uxPrecamber.caption := ts; UI feedback - not here!
      pcfactive := true;
      if DriveClass = tdcMint then
      begin
        ReceivedStrings := '';
        //Write new RF calibration - pre-cambering works by dynamincally re-calibrating the RF, and then resetting for next item
        WriteCommsArray('12', '1');
        repeat
          ReadCommsArray('12', false)
        until commdata = '0';
        ReadCommsArray('13', true);
        try
          cfactor := strtofloat(commdata);
        except
          showmessage('WARNING - pre-camber error');
        end;
        nfactor := cfactor * (1 - (pcfactor / 100));
        Calibrate(nfactor);
        { Production file update }
        EventAudit(rfetPreCamber, 'PreCamber_Set Ratio=' + floattostr(nfactor));
      end;
    end;
  end;

end;

function TRollformer.OpenComm1: boolean;
begin
  try
    if VaComm1.Active then
      VaComm1.close;
    VaComm1.open; //open VaComm1 serial driver port
    Result := true;
  except
    on e: Exception do
      raise EConnectError.Create(e.message);
  end;
end;

procedure TRollformer.VaComm1RxChar(Sender: TObject; Count: Integer);
// *Rcv chr event for VaComm1 serial port
begin
  ReceivedStrings := ReceivedStrings + VaComm1.ReadText;
end;
{$ENDREGION}
{$REGION 'Counters'}

function TRollformer.GetNewProtocol : Boolean;
begin
  result := length(FMintSerialNumber)> 5
end;

function TRollformer.GetCounter(AOpcode: TOperationProcess): TCounter;
var
  aCounter: TCounter;
begin
  Result := Nil;
  for aCounter in FCounters do
  begin
    if (aCounter.opCode = AOpcode) then
      exit(aCounter);
  end;
end;

function TRollformer.CounterExceeded: boolean;
var
  aCounter: TCounter;
begin
  for aCounter in FCounters do
    if aCounter.LimitExceeded then
      exit(True);
  Result := False;
end;

procedure TRollformer.IncCounter(AOpcode: TOperationProcess);
var
  aCounter: TCounter;
begin
  aCounter := Counters[AOpcode];
  if aCounter=nil then
    Exit;
  aCounter.IncValue;
end;

procedure TRollformer.ReadMachineCounters;
var
  aCounter: TCounter;
begin
  for aCounter in FCounters do
    aCounter.Value := Round(Rollformer.GetMintValue(aCounter.MintNumber));
end;

procedure TRollformer.SaveCountersToIni(AInifile: TIniFile);
var
  aCounter: TCounter;
begin
  for aCounter in FCounters do
    AInifile.writeInteger('counter', aCounter.FIniKey, aCounter.OpLimit);
end;

procedure TRollformer.ReadCountersFromIni(AInifile: TIniFile);
begin
end;

{ TCounter }
constructor TCounter.Create(AOpcode: TOperationProcess; IniKey: AnsiString; ALongName: string; AMintParam: TMintValue);
begin
  opCode      := AOpcode;
  FMintNumber := AMintParam;
  FIniKey     := IniKey;
  FLongName   := ALongName;
end;

procedure TCounter.IncValue;
begin
  Inc(FValue);
end;

function TCounter.GetLimitExceeded: Boolean;
begin
  if (DriveClass<>tdcSim) and (DriveClass<>tdcVirtual) then
    Value := Round(Rollformer.GetMintValue(MintNumber));
  Result := (OpLimit > 0) and (Value > OpLimit)
end;

procedure TCounter.SetOpLimit(anInteger : Integer);
begin
  if FIniKey = 'TGCW' then
    G_Settings.Counter_TrussCut := anInteger
  else
  if FIniKey = 'TCCW' then
    G_Settings.Counter_TrussCope := anInteger
  else
  if FIniKey = 'TNCW' then
    G_Settings.Counter_TrussNotch := anInteger
  else
  if FIniKey = 'TLPCW' then
    G_Settings.Counter_TrussLipPunch := anInteger
  else
  if FIniKey = 'TFPCW' then
    G_Settings.Counter_TrussFlangePunch := anInteger
  else
  if FIniKey = 'PGCW' then
    G_Settings.Counter_PanelCut := anInteger
  else
  if FIniKey = 'PEBCW' then
    G_Settings.Counter_PanelEndingBearingNotch := anInteger
  else
  if FIniKey = 'PSCW' then
    G_Settings.Counter_PanelService1s := anInteger
  else
  if FIniKey = 'PS2CW' then
    G_Settings.Counter_PanelService2s := anInteger
  else
  if FIniKey = 'PNCW' then
    G_Settings.Counter_PanelNotches := anInteger
  else
  if FIniKey = 'PLPCW' then
    G_Settings.Counter_PanelLipPunch := anInteger
  else
  if FIniKey = 'PPCW' then
    G_Settings.Counter_PanelFlangePunch := anInteger
  else
  if FIniKey = 'PFPCW' then
    G_Settings.Counter_PanelFlatenPunch := anInteger;
end;

function TCounter.GetOpLimit : LongInt;
begin
  if FIniKey = 'TGCW' then
    Result     := G_Settings.Counter_TrussCut
  else
  if FIniKey = 'TCCW' then
    Result     := G_Settings.Counter_TrussCope
  else
  if FIniKey = 'TNCW' then
    Result     := G_Settings.Counter_TrussNotch
  else
  if FIniKey = 'TLPCW' then
    Result     := G_Settings.Counter_TrussLipPunch
  else
  if FIniKey = 'TFPCW' then
    Result     := G_Settings.Counter_TrussFlangePunch
  else
  if FIniKey = 'PGCW' then
    Result     := G_Settings.Counter_PanelCut
  else
  if FIniKey = 'PEBCW' then
    Result     := G_Settings.Counter_PanelEndingBearingNotch
  else
  if FIniKey = 'PSCW' then
    Result     := G_Settings.Counter_PanelService1s
  else
  if FIniKey = 'PS2CW' then
    Result     := G_Settings.Counter_PanelService2s
  else
  if FIniKey = 'PNCW' then
    Result     := G_Settings.Counter_PanelNotches
  else
  if FIniKey = 'PLPCW' then
    Result     := G_Settings.Counter_PanelLipPunch
  else
  if FIniKey = 'PPCW' then
    Result     := G_Settings.Counter_PanelFlangePunch
  else
  if FIniKey = 'PFPCW' then
    Result     := G_Settings.Counter_PanelFlatenPunch;
end;

{$ENDREGION}

end.

