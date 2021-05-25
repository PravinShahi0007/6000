unit ScotRFTypes;

interface

uses
  System.JSON, System.Classes, SysUtils, Generics.Collections, CardAPIU, Graphics, IniFiles,
  Registry, Data.FireDACJSONReflect, FireDAC.Comp.Client;

type

  IDataConn = Interface(IInterface)
    function GetRFDateInfo( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetRollFormer( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetAudit      ( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetRFOperation( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetJob        ( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetJobTRANSFER( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetJOBDETAIL  ( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2File    ( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2FileWithoutBlob( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetFRAME      ( aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetFRAMEEP2FILEID( aSiteID    : SmallInt;
                            aEP2FILEID : Integer;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetFRAMEENTITY( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetFRAMEENTITYFrameID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            aFrameID   : Integer;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetItemProduction( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetItemProductionFrameID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            aFrameID   : Integer;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetItemProductionROLLFORMERID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
   function GetEP2FileJobID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            aJobID     : Integer;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2FileBLOB(anEP2FILEID: Integer;
                            var aDataSet   : TFDMemTable): Boolean;

    function GetJobFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2FinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetFrameFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetJobTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2TotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetFrameTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetNewAutoID(gen_fields_id: string): Integer;
    procedure DeleteAJob(aJobID : Integer);
    function TheJobAlreadyLoaded(aJobName : String) : Integer;
    function GetEP2AssignInfo(var aDataSet : TFDMemTable; const aJobID : Integer ): Boolean;

    procedure ApplyUpdates( aTableName: String; var aDataSet : TFDMemTable );
    function IsDashboard : Boolean;
  End;

  TRollFormerStatus =(rfIdle, rfRunning, rfPause, rfSimulation, rfNotConnected);

  TRFType =(rfPanel, rfTruss);

  TMachineType=( mtPanel
                ,mtPanelHD
                ,mtTruss
                ,mt75mmTruss);

//  sMachineType: array[TMachineType] of string = ('PANEL','PANELHD','50MMTRUSS','75MMTRUSS');

  TInkjetType = (ijpNone,dod2002, sx32, videojet, sojet);
  TStatusLight = (tsRed, tsAmber, tsOff, tsOK);
  TStatusInfoProc=reference  to procedure(aLine: int8; AText: string );
  TStatusLightProc=reference to procedure(ALight: TStatusLight );
  TStatusInkProc=reference   to procedure(v1,v2: double  );

  ETimeout=class (exception);
  EUnknownDrive = class(exception);
  ENoSteel = class(exception);
  ERestart = class(exception);
  EConnectError = class(exception);
  ESessionID=class(exception);
  EIJPSetupError = class(exception)
    Constructor Create(ACommand,AResponse: string); reintroduce;
  end;


  TRFEventType =( rfetMoveMotor      //0
                , rfetToolOp         //1
                , rfetItemStart      //2
                , rfetItemFinish     //3
                , rfetFrameStart     //4
                , rfetFrameFinish    //5
                , rfetJobStart       //6
                , rfetJobFinish      //7
                , rfetJobDetail      //8
                , rfetCARD           //9
                , rfetCardNo         //10
                , rfetSettingChange  //11
                , rfetMachineStop    //12
                , rfetPreCamber      //13
                , rfetMachineStart   //14
                , rfetPause          //15
                , rfetSelectFrame);  //16

  TOperationProcess = (
                        opCut        //0
                      , opLipHole    //1
                      , opFlangeHole //2
                      , opCopsFlats  //3
                      , opNotches    //4
                      , opSwage      //5
                      , opService1s  //6
                      , opService2s  //7
                      , opPrint      //8
                      , opEndBearingNotch  //9
                      );

  TDrive = (  tdMint
            , tdMint2
            , tdMint2_5225Plus
            , tdMotiFlexE100_Mint
            , tdMotiFlexE100_IP_Mint
            , tdFlexE150
            , tdFlexE190
            , tdMotiFlexE180
            , tdFlexPlus
            , tdVirtual);

//Mint
//Mint II
//Mint II 5225+
//MotiFlex e100 Mint
//MotiFlex e100 IP Mint
//MicroFlex E150 IP
//MicroFlex E190 IP
//MotiFlex e180 IP
//Flex+
//VIRTUAL

  TDriveSet = set of TDrive;

  TDriveClass = ( tdcMint
                , tdcFlex
                , tdcVirtual
                , tdcSim );

  TConnectionState =(tcNone, tcConnected, tcFailed);

  TMintValue = (
    mintEncPCm             =  1,
    mintEncPCmBkup         =  2,
    motRPM                 =  3,
    motACC                 =  4,
    mintCountService       =  5,
    mintCountCut           =  6,
    mintCountNotch         =  7,
    mintCountLipPunch      =  8,
    mintLifeCounter        =  9,
    mintPVersion           = 10,

    MintCountService2      = 17,
    mintCutTo              = 21,                                                //
    mintHoleTo             = 22,                                                //
    mintNotchTo            = 23,                                                //
    mintServiceToFlat      = 24,                                                //
    mintService2ToFlat     = 25,                                                //
    mintSwageToFlat        = 26,                                                //
    mintCutWidth           = 27,                                                //
    mintFlatSize           = 28,                                                //
    mintNotchSize          = 29,                                                //
    mintSwageToolLen       = 30,                                                //
    mintHoleHeight         = 31,                                                //

{$IFDEF Panel}
    mintRFTemp             = 11,
    tempCompFlag           = 12,
    mintCountFlangePunch   = 16,
{$ELSE}
    mintRFTemp             = 15,
    tempCompFlag           = 14,
    mintCountFlangePunch   = 11,
{$Endif}
    mintEndBrgNotchToFlat  = 32,
    mintEndBrgNotchSize    = 33,
    mintPanelOrTruss       = 40,
    mintSerial             = 41,
    mintRFVersion          = 42,
    mintFirmwareRelease    = 43,
    mintEncChargeType      = 44,
    mintCountEndBearing    = 45,
    mintCountFlatenPunch   = 46);

  TCardValidForRFStatus =(crNone,crValid,crInvalid);

  TCardInfomation = Class(TObject)
  Private
    Function GetExpiryDate : TDateTime;
    Function GetNoCreditMessage : String;
    Function GetHasCredit : Boolean;
    Function GetIsUnlimited : Boolean;
    Function GetChargeSchemeStr : String;
    Function GetChargeScheme : TChargeType;
    Function GetCardID : String;
    Function GetIssuedTO : String;
    Function GetMetresOnCard : Integer;
    Function GetMetres : Integer;

    Function GetCardStateStr : String;
    Function GetCardState : TAPIState;
    Function GetCardName : String;
    Function GetStatusLight : TStatusLight;
    Function GetCardValidForRF : TCardValidForRFStatus;
  Public
    property ExpiryDate : TDateTime Read GetExpiryDate;
    property NoCreditMessage : String Read GetNoCreditMessage;
    property HasCredit : Boolean Read GetHasCredit;
    property IsUnlimited : Boolean Read GetIsUnlimited;
    property ChargeSchemeStr : String Read GetChargeSchemeStr;
    property CardID : String Read GetCardID;
    property IssuedTO : String Read GetIssuedTO;
    property MetresOnCard : Integer Read GetMetresOnCard;
    property Metres : Integer Read GetMetres;
    property CardStateStr : String Read GetCardStateStr;
	  property CardState : TAPIState Read GetCardState;
	  property CardName : String Read GetCardName;
    property StatusLight : TStatusLight read GetStatusLight;
    property CardValidForRF : TCardValidForRFStatus Read GetCardValidForRF;
  End;

  TRFSettings = Class(TObject)
  private
    FScotRF_RFS_File  : TIniFile;
    FScotRF_Old_INI   : TMemInifile;
    FScotRF_Registry  : TRegIniFile;
    FOnSettingsChange : TNotifyEvent;
    Function GetIsSingleRivet : Boolean;
    Function GetCounter_TrussCut                : Integer;
    Function GetCounter_TrussCope               : Integer;
    Function GetCounter_TrussNotch              : Integer;
    Function GetCounter_TrussLipPunch           : Integer;
    Function GetCounter_TrussFlangePunch        : Integer;
    Function GetCounter_PanelCut                : Integer;
    Function GetCounter_PanelService1s          : Integer;
    Function GetCounter_PanelService2s          : Integer;
    Function GetCounter_PanelNotches            : Integer;
    Function GetCounter_PanelLipPunch           : Integer;
    Function GetCounter_PanelFlangePunch        : Integer;
    Function GetCounter_PanelFlatenPunch        : Integer;
    Function GetCounter_PanelEndingBearingNotch : Integer;

    Procedure SetCounter_TrussCut(anInteger : Integer);
    Procedure SetCounter_TrussCope(anInteger : Integer);
    Procedure SetCounter_TrussNotch(anInteger : Integer);
    Procedure SetCounter_TrussLipPunch(anInteger : Integer);
    Procedure SetCounter_TrussFlangePunch(anInteger : Integer);
    Procedure SetCounter_PanelCut(anInteger : Integer);
    Procedure SetCounter_PanelService1s(anInteger : Integer);
    Procedure SetCounter_PanelService2s(anInteger : Integer);
    Procedure SetCounter_PanelNotches(anInteger : Integer);
    Procedure SetCounter_PanelLipPunch(anInteger : Integer);
    Procedure SetCounter_PanelFlangePunch(anInteger : Integer);
    Procedure SetCounter_PanelFlatenPunch(anInteger : Integer);
    Procedure SetCounter_PanelEndingBearingNotch(anInteger : Integer);
  public
    {general}
    RFSSettingFile         : String;
    Logging_JobDetails     : Boolean;
    Logging_LogPauseReason : Boolean;
    Logging_AuditDetails   : Boolean;
    Logging_LogToolOps     : Boolean;
    Mainform_Maximized     : Boolean;
    RollFormerDrive        : TDrive;
    general_machinetype    : String;
    general_fontsize       : String;
    general_sim            : boolean;
    general_metric         : boolean;
    general_imperial       : boolean;
    general_itemno         : boolean;
    general_drive          : String;
    general_warning        : boolean;
    general_comport        : String;
    general_com2port       : String;
    general_removeframes   : boolean;
    general_pause          : boolean;
    general_rectangles     : boolean;
    general_chordweb       : boolean;
    general_baudrate       : String;
    general_oppause        : String;
    general_label          : boolean;
    general_BoxRF          : boolean;
    general_SiteID         : String;
    general_SiteName       : String;
    general_RollFormerID   : String;
    general_Server         : String;
    general_IsConnectToServer : Boolean;
    general_Port              : String;

    general_MachineID      : String;
    general_MachineName    : String;
    general_IsMicroMM      : Boolean;
    {truss rollformer}
//    if (MachineType=mt75mmTruss) then
//    begin
    trussrf_chordweb     : Boolean;
    trussrf_CutToNotch   : String;
    trussrf_CopeToNotch  : String;
    trussrf_SwageToNotch75 : String;
    trussrf_LipHoleToNotch : String;
    trussrf_SwageSize75  : String;
    trussrf_FlangeHoleToLipHole75 : String;
//    end;
//    if (MachineType=mtTruss) then
//    begin
    trussrf_c2fhole : String;
    trussrf_cope2fhole : String;
    trussrf_n2fhole : String;
    trussrf_lhole2fhole : String;
//    end;
    trussrf_notchsize : String;
    trussrf_copesize : String;
    trussrf_cutwidth : String;
    trussrf_precamber : String;
    trussrf_autopc : Boolean;
    trussrf_dblnotch : Boolean;
    {box rollformer}
    boxrf_boxc2hole : String;
    boxrf_boxcutwidth : String;
    {panel rollformer}
    panelrf_cut2flat          : String;
    panelrf_hole2flat         : String;
    panelrf_holeM2diffhorz    : String;
    panelrf_holeM2diffvert    : String;
    panelrf_notch2flat        : String;
    panelrf_service2flat      : String;
    panelrf_service22flat     : String;
    panelrf_EndBrgNotchToFlat : String;
    panelrf_EndBrgNotchSize   : String;
    panelrf_swage2flat        : String;
    panelrf_cutwidth          : String;
    panelrf_flatsize          : String;
    panelrf_notchsize         : String;
    panelrf_swagesize         : String;
    panelrf_notchtol          : String;
    panelrf_precamber         : String;
    panelrf_mholeheight       : String;
    {truss profile}
    trussprofile_lipholeheight     : String;
    trussprofile_flangelipholediff : String;
    trussprofile_gauge             : String;
    trussprofile_profileheight     : String;
    trussprofile_lipsize           : String;
    trussprofile_holesize          : String;
    {panel profile}
    panelprofile_lipsize : String;
    panelprofile_holeheight : String;
    panelprofile_holeMheight : String;
    panelprofile_holesize : String;
    panelprofile_profileheight : String;
    {truss structure}
    tstructure_buttgap : String;
    tstructure_holedist : String;
    tstructure_tolerance : String;
    tstructure_minimize : Boolean;
    tstructure_specialcons : Boolean;
    tstructure_minimizeBC : Boolean;
    tstructure_web2web : Boolean;
    tstructure_screws : Boolean;
    {panel structure}
    Pstructure_service2 : Boolean;
    Pstructure_jointgap : String;
    Pstructure_verticalgap: String;
    Pstructure_minholedist: String;
    Pstructure_designorder : Boolean;
    Pstructure_swage : Boolean;
    Pstructure_showservice : Boolean;
    Pstructure_ignoremindistance : Boolean;
    Pstructure_virtualmitre : Boolean;
    {miscellaneous}
    misc_power : Boolean;
    misc_current: String;
    misc_comms : Boolean;
    misc_USAjoint : Boolean;
    {inkjet printer}
    inkprinter_Device      : String;
    inkprinter_Type        : Integer;
    inkprinter_frmcode     : Boolean;
    inkprinter_idescr      : Boolean;
    inkprinter_chrlen      : String;
    inkprinter_headpos     : String;
    inkprinter_job         : String;
    inkprinter_logo        : String;
    inkprinter_logoOn      : Boolean;
    inkprinter_inkbaudrate : String;
    inkprinter_inkIP       : String;
    inkprinter_inkserial   : String;
    printer_prtradius      : String;
    printer_fontsize       : String;
    printer_bearingsize    : String;
    printer_braces         : Boolean;
    printer_labels         : Integer;
    printer_service        : Boolean;
    printer_orientation    : Integer;
    printer_multiprt       : Boolean;
    printer_websize        : Boolean;
    printer_prtfilepath    : Boolean;
    printer_orientcolour   : Boolean;
    {label printing}
    label_job     : String;
    label_font    : String;
    label_printer : String;

    constructor Create;overload;
    constructor Create(aRFSFilename : String);overload;
    destructor  Destroy();override;
    procedure SaveSettings;
    procedure SetGlobalJointvalues;
    procedure LoadRFS( );
    {Counters}
    property  Counter_TrussCut                : Integer read GetCounter_TrussCut write SetCounter_TrussCut;
    property  Counter_TrussCope               : Integer read GetCounter_TrussCope write SetCounter_TrussCope;
    property  Counter_TrussNotch              : Integer read GetCounter_TrussNotch write SetCounter_TrussNotch;
    property  Counter_TrussLipPunch           : Integer read GetCounter_TrussLipPunch write SetCounter_TrussLipPunch;
    property  Counter_TrussFlangePunch        : Integer read GetCounter_TrussFlangePunch write SetCounter_TrussFlangePunch;
    property  Counter_PanelCut                : Integer read GetCounter_PanelCut write SetCounter_PanelCut;
    property  Counter_PanelService1s          : Integer read GetCounter_PanelService1s write SetCounter_PanelService1s;
    property  Counter_PanelService2s          : Integer read GetCounter_PanelService2s write SetCounter_PanelService2s;
    property  Counter_PanelNotches            : Integer read GetCounter_PanelNotches write SetCounter_PanelNotches;
    property  Counter_PanelLipPunch           : Integer read GetCounter_PanelLipPunch write SetCounter_PanelLipPunch;
    property  Counter_PanelFlangePunch        : Integer read GetCounter_PanelFlangePunch write SetCounter_PanelFlangePunch;
    property  Counter_PanelFlatenPunch        : Integer read GetCounter_PanelFlatenPunch write SetCounter_PanelFlatenPunch;
    property  Counter_PanelEndingBearingNotch : Integer read GetCounter_PanelEndingBearingNotch write SetCounter_PanelEndingBearingNotch;

    property  OnSettingsChange : TNotifyEvent read FOnSettingsChange    write FOnSettingsChange;
    property IsSingleRivet : Boolean read GetIsSingleRivet;
  End;

  TMaterial = class(TObject)
  private
    FMetres     : Double;
    FConnectors : Integer;
    FSpacers    : Integer;
    FTEKScrews  : Integer;
  public
    Property Metres     : Double   read FMetres     write FMetres;
    Property Connectors : Integer  read FConnectors write FConnectors; // Rivet or Bolt
    Property Spacers    : Integer  read FSpacers    write FSpacers;
    Property TEKScrews  : Integer  read FTEKScrews  write FTEKScrews;
    procedure Reset;
  end;

const

  RFDriveNames: Array[TDrive] of string = ('Mint'
                                          ,'Mint II'
                                          ,'Mint II 5225+'
                                          ,'MotiFlex e100 Mint'
                                          ,'MotiFlex e100 IP Mint'
                                          ,'MicroFlex E150 IP'
                                          ,'MicroFlex E190 IP'
                                          ,'MotiFlex e180 IP'
                                          ,'Flex+'
                                          ,'VIRTUAL');

  REGISTRY_NAME = 'Software\ScotPackage';

  DashboardChannelName = 'ChannelNameForDashboard';
  JobLiveChannelName   = 'ChannelNameForJobLive';

  sMachineType: array[TMachineType] of string = ('PANEL','PANELHD','50MMTRUSS','75MMTRUSS');
  WM_USER   = $0400;
  WM_STARTQ = WM_User + 50;
  minprtlength = 380;
  oppause = false;
  TestScriptFile = 'ScotRF Test Script.txt';
  fratio = 3.2808; // 1000/(2.54*12);
  com1 = $3F8; //default serial port 1
  com2 = $2F8; //default serial port 2
  irqcom1 = 4; //default IRQ com1
  irqcom2 = 3; //default IRQ com2
  //Ascii code characters
  eot = 4;
  ack = 6;
  nak = 21;
  stx = 2;
  etx = 3;
  enq = 5;
  lf = ansichar(10);
  esc = ansichar(27);
  notchoverhang = 12;
  dblpunchid = '16';
  plumbingid = '17';
  QEOF=MAXINT;
  ID_RUNPROCESS=100;

  StatusHint: array[TStatusLight] of string=('Error','Busy','Disconnected','Connected');
  strInkjetType:array[TInkjetType] of string = ('None','dod2002', 'sx32', 'videojet', 'Sojet');
  BaldorDrives: TDriveSet = [ tdMint2_5225Plus
                            , tdMotiFlexE100_Mint
                            , tdMotiFlexE100_IP_Mint
                            , tdFlexE150
                            , tdFlexE190
                            , tdMotiFlexE180];
{$IFDEF Panel}
  {$MESSAGE HINT 'ScotRF Version 5 Panel'}
  AppName = 'ScotRF - Panel';
  ProcessFileFilter = 'Panel Process files|*.txt';
{$ELSE}
  {$MESSAGE HINT 'ScotRF Version 5  Truss'}
  AppName = 'ScotRF - Truss';
  ProcessFileFilter = 'Truss Process files|*.txt|Box web process files|*.bwt';
{$ENDIF}

var
  CardInformation : TCardInfomation;
  CurrentCARDNUMBER : String;
  GREMAINMETERS     : Double;

  G_Settings : TRFSettings;
  G_Material : TMaterial;

  DMScotServer: IDataConn;

function  ProcessName(AProcess: TOperationProcess): string;
procedure NotInSimMessage;
Procedure NoFramesMessage;
Procedure NotForVMMessage;
Procedure NoConnectionMessage;

implementation

uses
  Dialogs, CardAdapterU, RollformerU, GlobalU, StrUtils, UnitDMRollFormer, units;

Procedure NotInSimMessage;
begin
  TaskMessageDlg('Simulation Mode', 'Function not available.', mtWarning, [mbOk],0);
end;

Procedure NotForVMMessage;
begin
  TaskMessageDlg('Virtual Drive', 'Function not available.', mtWarning, [mbOk],0);
end;

Procedure NoFramesMessage;
begin
  if (Win32MajorVersion >= 6) then
    TaskMessageDlg('No Frames Selected', '', mtWarning, [mbOk],0)
  else
    MessageDlg('No Frames Selected', mtWarning,[mbOK],0);
end;

Procedure NoConnectionMessage;
begin
  if (Win32MajorVersion >= 6) then
    TaskMessageDlg('Rollformer not connected', '', mtWarning, [mbOk],0)
  else
    MessageDlg('Rollformer not connected', mtWarning,[mbOK],0);
end;

function ProcessName(AProcess: TOperationProcess): string;
begin
  Result := '';
  if AProcess= opNotches         then result := 'Notch';
  if AProcess= opLipHole         then result := 'LPunch';
  if AProcess= opFlangeHole      then result := 'FPunch';
  if AProcess= opSwage           then result := 'Swage';
  if AProcess= opPrint           then result := 'triggerPrint';
  if AProcess= opCut             then result := 'Cut';
{$IFDEF PANEL}
  if AProcess= opCopsFlats       then result := 'Flat';
  if AProcess= opService1s       then result := 'Service 1';
  if AProcess= opService2s       then result := 'Service 2';
  if AProcess= opEndBearingNotch then result := 'End Bearing Notch';
{$ELSE}
  if AProcess= opCopsFlats       then result := 'Cope';
{$ENDIF}
end;

{ EIJPSetupError }
constructor EIJPSetupError.Create(ACommand, AResponse: string);
begin
  inherited Create(ACommand+#10+AResponse);
end;

Function TCardInfomation.GetExpiryDate : TDateTime;
begin
  result := CardAdapter.ExpiryDate;
end;

Function TCardInfomation.GetNoCreditMessage : String;
begin
  result := CardAdapter.NoCreditMessage;
end;

Function TCardInfomation.GetHasCredit : Boolean;
begin
  result := CardAdapter.HasCredit;
end;

Function TCardInfomation.GetIsUnlimited : Boolean;
begin
  result := CardAdapter.IsUnlimited;
end;

Function TCardInfomation.GetChargeSchemeStr : String;
begin
  result := CardAdapter.ChargeSchemeStr;
end;

Function TCardInfomation.GetChargeScheme : TChargeType;
begin
  result := CardAdapter.ChargeScheme;
end;

Function TCardInfomation.GetCardID : String;
begin
  result := CardAdapter.CardID;
end;

Function TCardInfomation.GetIssuedTO : String;
begin
  result := CardAdapter.IssuedTO;
end;

Function TCardInfomation.GetMetresOnCard : Integer;
begin
  result := CardAdapter.MetresOnCard;
end;

Function TCardInfomation.GetMetres : Integer;
begin
  result := CardAdapter.Metres;
end;

Function TCardInfomation.GetCardStateStr : String;
begin
  result := CardApi.CardStateStr;
end;

Function TCardInfomation.GetCardState : TAPIState;
begin
  result := CardApi.CardState;
end;

Function TCardInfomation.GetCardName : String;
begin
  result := CardApi.CardName;
end;

function TCardInfomation.GetStatusLight : TStatusLight;
begin
  if CardAdapter.CheckCardOK then
    result := tsOK
  else
    result := tsRED
end;

Function TCardInfomation.GetCardValidForRF : TCardValidForRFStatus;
begin
  if (Rollformer.Connected=tcConnected) then
  begin
    If not CardAdapter.CheckCardChargeType(Rollformer.MachineChargeType) then
    begin
      Result := crInvalid;
      TaskMessageDlg('Card Error'
                    , Format('%s Card not valid for %s ', [ChargeSchemeStr, Rollformer.ConnectInfo])
                    , mtWarning
                    , [mbOK]
                    , 0 );
    end
    else
    begin
      Result := crValid;
    end;
  end
  else
    Result := crNone;
end;

destructor  TRFSettings.Destroy();
begin
  FreeAndNil(FScotRF_RFS_File);
  FreeAndNil(FScotRF_Old_INI);
  FreeAndNil(FScotRF_Registry);
  inherited;
end;

constructor TRFSettings.Create(aRFSFilename : String);
begin
  FScotRF_Old_INI := TMemInifile.create('ScotRF.ini');
  FScotRF_Registry := TRegIniFile.Create( REGISTRY_NAME );
  with FScotRF_Registry do
  begin
    RFSSettingFile         := aRFSFilename;
    Logging_JobDetails     :=   ReadBool('Logging',  'JobDetails',     FScotRF_Old_INI.ReadBool('Logging', 'JobDetails', False));
    Logging_LogPauseReason :=   ReadBool('Logging',  'LogPauseReason', FScotRF_Old_INI.ReadBool('Logging', 'LogPauseReason', false));
    Logging_AuditDetails   :=   ReadBool('Logging',  'AuditDetails',   False);
    Logging_LogToolOps     :=   ReadBool('Logging',  'LogToolOps',     FScotRF_Old_INI.ReadBool('Logging', 'LogToolOps', false));
    Mainform_Maximized     :=   Readbool('Mainform', 'Maximized',      FScotRF_Old_INI.ReadBool('Mainform', 'Maximized', false ));
    general_SiteID         := ReadString('ScotRF',   'SiteID',         '1');
    general_SiteName       := ReadString('ScotRF',   'SiteName',       'ScotSite');
    general_Server         := ReadString('RemoteServer', 'Server',     '127.0.0.1');
    general_Port           := ReadString('RemoteServer', 'Port',       '211');
    general_IsConnectToServer :=ReadBool('RemoteServer', 'IsConnectToServer',  False);
  end;
  FScotRF_RFS_File := TIniFile.create(RFSSettingFile);
  LoadRFS();
end;

constructor TRFSettings.Create;
begin
  FScotRF_Old_INI := TMemInifile.create('ScotRF.ini');
  FScotRF_Registry := TRegIniFile.Create( REGISTRY_NAME );
  with FScotRF_Registry do
  begin
{$IFDEF PANEL}
    RFSSettingFile         := ReadString('SETTINGS', 'PANELSETFILE',   FScotRF_Old_INI.ReadString('SETTINGS', 'SETFILE', ''));
{$ELSE}
    RFSSettingFile         := ReadString('SETTINGS', 'TRUSSSETFILE',   FScotRF_Old_INI.ReadString('SETTINGS', 'SETFILE', ''));
{$ENDIF}
    Logging_JobDetails     :=   ReadBool('Logging',  'JobDetails',     FScotRF_Old_INI.ReadBool('Logging', 'JobDetails', true));
    Logging_LogPauseReason :=   ReadBool('Logging',  'LogPauseReason', FScotRF_Old_INI.ReadBool('Logging', 'LogPauseReason', false));
    Logging_AuditDetails   :=   ReadBool('Logging',  'AuditDetails',   False);
    Logging_LogToolOps     :=   ReadBool('Logging',  'LogToolOps',     FScotRF_Old_INI.ReadBool('Logging', 'LogToolOps', false));
    Mainform_Maximized     :=   Readbool('Mainform', 'Maximized',      FScotRF_Old_INI.ReadBool('Mainform', 'Maximized', false ));
    general_SiteID         := ReadString('ScotRF',   'SiteID',         '1');
    general_SiteName       := ReadString('ScotRF',   'SiteName',       'ScotSite');
    general_Server         := ReadString('RemoteServer', 'Server',     '127.0.0.1');
    general_Port           := ReadString('RemoteServer', 'Port',       '211');
    general_IsConnectToServer :=ReadBool('RemoteServer', 'IsConnectToServer',  False);
  end;
  FScotRF_RFS_File := TIniFile.create(RFSSettingFile);
  LoadRFS();
end;

procedure TRFSettings.LoadRFS();
begin
  with FScotRF_RFS_File do
  begin
    {general}
    general_machinetype       := ReadString('general', 'machinetype', '');
    general_fontsize          := ReadString('general', 'fontsize', '10');
    general_sim               := ReadBool('general', 'sim', false);
    general_metric            := ReadBool('general', 'metric', true); // default to metric if not found
    general_imperial          := Not general_metric;
    general_itemno            := ReadBool('general', 'itemno', true);   // unused
    general_drive             := ReadString('general', 'drive', 'Mint II');
    RollFormerDrive           := TDrive( AnsiIndexStr( general_drive, RFDriveNames ));
    general_warning           := ReadBool('general', 'warning', false);
    general_comport           := ReadString('general', 'comport', 'COM1');
    general_removeframes      := ReadBool('general', 'removeframes', false);
    general_com2port          := ReadString('general', 'com2port', 'COM2');
    general_pause             := ReadBool('general', 'pause', false);
    general_rectangles        := ReadBool('general', 'rectangles', false);
    general_baudrate          := ReadString('general', 'baudrate', '57600');
    general_oppause           := ReadString('general', 'oppause', '0');
    general_label             := ReadBool('general', 'label', false);
    general_BoxRF             := ReadBool('general', 'BoxRF', false);
    general_MachineID         := ReadString('general', 'MachineID', '');
    general_MachineName       := ReadString('general', 'MachineName', '');
    general_IsMicroMM         := ReadBool('general', 'IsMicroMM', False);

    {truss rollformer}
    trussrf_chordweb          := ReadBool('trussrf', 'chordweb', false);
    // 3" Truss
    begin
      trussrf_CutToNotch            := ReadString('trussrf', 'CutToNotch',    '0');
      trussrf_CopeToNotch           := ReadString('trussrf', 'CopeToNotch',   '0');
      trussrf_LipHoleToNotch        := ReadString('trussrf', 'LHoleToNotch',  '0');
      trussrf_SwageToNotch75        := ReadString('trussrf', 'SwageToNotch',  '4822');
      trussrf_FlangeHoleToLipHole75 := ReadString('trussrf', 'lhole2fhole75', '65');
      trussrf_SwageSize75           := ReadString('trussrf', 'SwageSize75',   '0');
    end;
    // 2" Truss
    begin
      trussrf_c2fhole         := ReadString('trussrf', 'c2fhole', '0');
      trussrf_cope2fhole      := ReadString('trussrf', 'cope2fhole', '0');
      trussrf_n2fhole         := ReadString('trussrf', 'n2fhole', '0');
      trussrf_lhole2fhole     := ReadString('trussrf', 'lhole2fhole', '0');
    end;
    trussrf_notchsize         := ReadString('trussrf', 'notchsize', '0');
    trussrf_copesize          := ReadString('trussrf', 'copesize', '0');
    trussrf_cutwidth          := ReadString('trussrf', 'cutwidth', '5');
    trussrf_precamber         := ReadString('trussrf', 'precamber', '0');
    trussrf_autopc            := ReadBool('trussrf', 'autopc', false);
    trussrf_dblnotch          := ReadBool('trussrf', 'dblnotch', false);
    {box rollformer}
    boxrf_boxc2hole           := ReadString('boxrf', 'boxc2hole', '0');
    boxrf_boxcutwidth         := ReadString('boxrf', 'boxcutwidth', '5');
    {panel rollformer}
    panelrf_cut2flat          := ReadString('panelrf', 'cut2flat', '0');
    panelrf_hole2flat         := ReadString('panelrf', 'hole2flat', '0');
    panelrf_holeM2diffhorz    := ReadString('panelrf', 'holeM2diffhorz', '0');
    panelrf_holeM2diffvert    := ReadString('panelrf', 'holeM2diffvert', '0');
    panelrf_notch2flat        := ReadString('panelrf', 'notch2flat', '0');
    panelrf_service2flat      := ReadString('panelrf', 'service2flat', '0');
    panelrf_service22flat     := ReadString('panelrf', 'service22flat', '0');
    panelrf_EndBrgNotchToFlat := ReadString('panelrf', 'EndBrgNotchToFlat', '0');
    panelrf_EndBrgNotchSize   := ReadString('panelrf', 'EndBrgNotchSize', '0');
    panelrf_swage2flat        := ReadString('panelrf', 'swage2flat', '0');
    panelrf_cutwidth          := ReadString('panelrf', 'cutwidth', '0');
    panelrf_flatsize          := ReadString('panelrf', 'flatsize', '0');
    panelrf_notchsize         := ReadString('panelrf', 'notchsize', '0');
    panelrf_swagesize         := ReadString('panelrf', 'swagesize', '0');
    panelrf_notchtol          := ReadString('panelrf', 'notchtol', '10');
    panelrf_precamber         := ReadString('panelrf', 'precamber', '0');
    panelrf_mholeheight       := ReadString('panelrf', 'mholeheight', '0');
    {truss profile}
    trussprofile_lipholeheight     := ReadString('trussprofile', 'lipholeheight', '0');
    trussprofile_flangelipholediff := ReadString('trussprofile', 'flangelipholediff', '0');
    trussprofile_gauge             := ReadString('trussprofile', 'gauge', '0');
    trussprofile_profileheight     := ReadString('trussprofile', 'profileheight', '0');
    trussprofile_lipsize           := ReadString('trussprofile', 'lipsize', '0');
    trussprofile_holesize          := ReadString('trussprofile', 'holesize', '0');
    {panel profile}
    panelprofile_lipsize           := ReadString('panelprofile', 'lipsize', '0');
    panelprofile_holeheight        := ReadString('panelprofile', 'holeheight', '0');
    panelprofile_holesize          := ReadString('panelprofile', 'holesize', '0');
    panelprofile_profileheight     := ReadString('panelprofile', 'profileheight', '0');
    {truss structure}
    tstructure_buttgap             := ReadString('tstructure', 'buttgap', '0');
    tstructure_holedist            := ReadString('tstructure', 'holedist', '0');
    tstructure_tolerance           := ReadString('tstructure', 'tolerance', '0');
    tstructure_minimize            := ReadBool('tstructure', 'minimize', false);
    tstructure_specialcons         := ReadBool('tstructure', 'specialcons', false);
    tstructure_minimizeBC          := ReadBool('tstructure', 'minimizeBC', false);
    tstructure_web2web             := ReadBool('tstructure', 'web2web', false);
    tstructure_screws              := ReadBool('tstructure', 'screws', false);
    {panel structure}
    // stud service hole memo lines
    Pstructure_service2            := ReadBool('Pstructure', 'service2', false);
    Pstructure_jointgap            := ReadString('Pstructure', 'jointgap', '5');
    Pstructure_verticalgap         := ReadString('Pstructure', 'verticalgap', '5');
    Pstructure_minholedist         := ReadString('Pstructure', 'minholedist', '5');
    Pstructure_swage               := ReadBool('Pstructure', 'swage', false);
    Pstructure_designorder         := ReadBool('Pstructure', 'designorder', false);
    Pstructure_showservice         := ReadBool('Pstructure', 'showservice', false);
    Pstructure_ignoremindistance   := ReadBool('Pstructure', 'ignoremindistance', false);
    Pstructure_virtualmitre        := ReadBool('Pstructure', 'virtualmitre', false);
    {inkjet printer}
    inkprinter_Type                := ReadInteger('inkprinter', 'Type', 0);
    inkprinter_Device              := ReadString('inkprinter', 'Device', '');
    inkprinter_frmcode             := ReadBool('inkprinter', 'frmcode', false);
    inkprinter_idescr              := ReadBool('inkprinter', 'idescr', false);
    inkprinter_chrlen              := ReadString('inkprinter', 'chrlen', '0');
    inkprinter_headpos             := ReadString('inkprinter', 'headpos', '0');
    inkprinter_job                 := ReadString('inkprinter', 'job', '');
    inkprinter_logo                := ReadString('inkprinter', 'logo', '');
    inkprinter_logoOn              := ReadBool('inkprinter', 'logoOn', false);
    inkprinter_inkbaudrate         := ReadString('inkprinter', 'inkbaudrate', '9600');
    inkprinter_inkIP               := ReadString('inkprinter', 'inkIP', '192.168.1.9');
    inkprinter_inkserial           := ReadString('inkprinter', 'inkserial', '201115');
    printer_prtradius              := ReadString('printer', 'prtradius', '25');
    printer_fontsize               := ReadString('printer', 'fontsize', '10');
    printer_bearingsize            := ReadString('printer', 'bearingsize', '10');
    printer_braces                 := ReadBool('printer', 'braces', false);
    printer_labels                 := ReadInteger('printer', 'labels', 0);
    printer_service                := ReadBool('printer', 'service', false);
    printer_orientation            := ReadInteger('printer', 'orientation', 0);
    printer_multiprt               := ReadBool('printer', 'multiprt', false);
    printer_websize                := ReadBool('printer', 'websize', false);
    printer_prtfilepath            := ReadBool('printer', 'prtfilepath', false);
    printer_orientcolour           := ReadBool('printer', 'orientcolour', false);
    {miscellaneous}
    misc_power    := ReadBool('misc', 'power', false);
    misc_current  := ReadString('misc', 'current', '15');
    misc_comms    := ReadBool('misc', 'comms', false);
    misc_USAjoint := ReadBool('misc', 'USAjoint', false);
    label_job     := ReadString('label', 'job', '');
    label_font    := ReadString('label', 'font', '15');
    label_printer := ReadString('label', 'printer', '');
  end;
end;

Function TRFSettings.GetIsSingleRivet : Boolean;
begin
  result := (panelrf_holeM2diffhorz = '0') and (panelrf_holeM2diffvert = '0');
end;

Function TRFSettings.GetCounter_TrussCut                : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'TGCW',  10000);
end;
Function TRFSettings.GetCounter_TrussCope               : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'TCCW',  10000);
end;
Function TRFSettings.GetCounter_TrussNotch              : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'TNCW',  10000);
end;
Function TRFSettings.GetCounter_TrussLipPunch           : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'TLPCW', 10000);
end;
Function TRFSettings.GetCounter_TrussFlangePunch        : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'TFPCW', 10000);
end;
Function TRFSettings.GetCounter_PanelCut                : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'PGCW',  10000);
end;
Function TRFSettings.GetCounter_PanelService1s          : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'PSCW',  10000);
end;
Function TRFSettings.GetCounter_PanelService2s          : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'PS2CW', 10000);
end;
Function TRFSettings.GetCounter_PanelNotches            : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'PNCW',  10000);
end;
Function TRFSettings.GetCounter_PanelLipPunch           : Integer;
begin
  REsult := FScotRF_RFS_File.ReadInteger('Counter', 'PLPCW', 10000);
end;
Function TRFSettings.GetCounter_PanelFlangePunch        : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'PPCW',  10000);
end;
Function TRFSettings.GetCounter_PanelFlatenPunch        : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'PFPCW', 10000);
end;
Function TRFSettings.GetCounter_PanelEndingBearingNotch : Integer;
begin
  Result := FScotRF_RFS_File.ReadInteger('Counter', 'PEBCW', 10000);
end;

Procedure TRFSettings.SetCounter_TrussCut(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'TGCW',  anInteger);
end;
Procedure TRFSettings.SetCounter_TrussCope(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'TCCW',  anInteger);
end;
Procedure TRFSettings.SetCounter_TrussNotch(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'TNCW',  anInteger);
end;
Procedure TRFSettings.SetCounter_TrussLipPunch(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'TLPCW', anInteger);
end;
Procedure TRFSettings.SetCounter_TrussFlangePunch(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'TFPCW', anInteger);
end;
Procedure TRFSettings.SetCounter_PanelCut(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'PGCW',  anInteger);
end;
Procedure TRFSettings.SetCounter_PanelService1s(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'PSCW',  anInteger);
end;
Procedure TRFSettings.SetCounter_PanelService2s(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'PS2CW', anInteger);
end;
Procedure TRFSettings.SetCounter_PanelNotches(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'PNCW',  anInteger);
end;
Procedure TRFSettings.SetCounter_PanelLipPunch(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'PLPCW', anInteger);
end;
Procedure TRFSettings.SetCounter_PanelFlangePunch(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'PPCW',  anInteger);
end;
Procedure TRFSettings.SetCounter_PanelFlatenPunch(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'PFPCW', anInteger);
end;
Procedure TRFSettings.SetCounter_PanelEndingBearingNotch(anInteger : Integer);
begin
  FScotRF_RFS_File.WriteInteger('Counter', 'PEBCW', anInteger);
end;

procedure TRFSettings.SaveSettings;
begin
  with FScotRF_Registry do
  begin
{$IFDEF PANEL}
    WriteString('SETTINGS', 'PANELSETFILE',   RFSSettingFile);
{$ELSE}
    WriteString('SETTINGS', 'TRUSSSETFILE',   RFSSettingFile);
{$ENDIF}
    WriteString('SETTINGS', 'SETFILE',        RFSSettingFile);
    WriteBool  ('Logging',  'JobDetails',     Logging_JobDetails);
    WriteBool  ('Logging',  'LogPauseReason', Logging_LogPauseReason);
    WriteBool  ('Logging',  'AuditDetails',   Logging_AuditDetails);
    WriteBool  ('Logging',  'LogToolOps',     Logging_LogToolOps);
    WriteBool  ('Mainform', 'Maximized',      Mainform_Maximized );
    WriteString('ScotRF', 'SiteID',           general_SiteID);
    WriteString('ScotRF', 'SiteName',         general_SiteName);
    WriteString('ScotRF', 'RollFormerID',     general_RollFormerID);
    WriteString('RemoteServer', 'Server',     general_Server);
    WriteBool('RemoteServer', 'IsConnectToServer', general_IsConnectToServer);
    WriteString('RemoteServer', 'Port',       general_Port);
  end;

  with FScotRF_RFS_File do
  begin
    {general}
    writestring('general', 'machinetype', general_machinetype);
    writestring('general', 'fontsize', general_fontsize);
    writebool('general', 'sim', general_sim );
    writebool('general', 'metric', general_metric);
    writebool('general', 'imperial', Not general_metric);
    writebool('general', 'itemno', general_itemno);
    writestring('general', 'drive', general_drive);
    writebool('general', 'warning', general_warning);
    writestring('general', 'comport', general_comport);
    writestring('general', 'com2port', general_com2port);
    writebool('general', 'removeframes', general_removeframes);
    writebool('general', 'pause', general_pause);
    writebool('general', 'rectangles', general_rectangles);
    writebool('general', 'chordweb', general_chordweb);

    writestring('general', 'baudrate', general_baudrate);
    writestring('general', 'oppause', general_oppause);
    writebool('general', 'label', general_label);
    writebool('general', 'BoxRF', general_BoxRF);

    writestring('general', 'MachineID', general_MachineID);
    writestring('general', 'MachineName', general_MachineName);

    {truss rollformer}
    writebool('trussrf', 'chordweb', trussrf_chordweb);

    writestring('trussrf', 'CutToNotch',    trussrf_CutToNotch);
    writestring('trussrf', 'CopeToNotch',   trussrf_CopeToNotch);
    writestring('trussrf', 'LHoleToNotch',  trussrf_LipHoleToNotch);
    writestring('trussrf', 'SwageToNotch',  trussrf_SwageToNotch75);
    writestring('trussrf', 'lhole2fhole75', trussrf_FlangeHoleToLipHole75);
    writestring('trussrf', 'SwageSize75',   trussrf_SwageSize75);


    writestring('trussrf', 'c2fhole',      trussrf_c2fhole);
    writestring('trussrf', 'cope2fhole',   trussrf_cope2fhole);
    writestring('trussrf', 'n2fhole',      trussrf_n2fhole);
    writestring('trussrf', 'lhole2fhole',  trussrf_lhole2fhole);

    writestring('trussrf', 'notchsize', trussrf_notchsize);
    writestring('trussrf', 'copesize', trussrf_copesize);
    writestring('trussrf', 'cutwidth', trussrf_cutwidth);
    writestring('trussrf', 'precamber', trussrf_precamber);
    writebool('trussrf', 'autopc', trussrf_autopc);
    writebool('trussrf', 'dblnotch', trussrf_dblnotch);

    {box rollformer}
    writestring('boxrf', 'boxc2hole', boxrf_boxc2hole);
    writestring('boxrf', 'boxcutwidth', boxrf_boxcutwidth);

    {panel rollformer}
    writestring('panelrf', 'cut2flat', panelrf_cut2flat);
    writestring('panelrf', 'hole2flat', panelrf_hole2flat);
    writestring('panelrf', 'holeM2diffhorz', panelrf_holeM2diffhorz);
    writestring('panelrf', 'holeM2diffvert', panelrf_holeM2diffvert);
    writestring('panelrf', 'notch2flat', panelrf_notch2flat);
    writestring('panelrf', 'service2flat', panelrf_service2flat);
    writestring('panelrf', 'service22flat', panelrf_service22flat);
    writestring('panelrf', 'EndBrgNotchToFlat', panelrf_EndBrgNotchToFlat);
    writestring('panelrf', 'EndBrgNotchSize', panelrf_EndBrgNotchSize);
    writestring('panelrf', 'swage2flat', panelrf_swage2flat);
    writestring('panelrf', 'cutwidth', panelrf_cutwidth);
    writestring('panelrf', 'flatsize', panelrf_flatsize);
    writestring('panelrf', 'notchsize', panelrf_notchsize);
    writestring('panelrf', 'swagesize', panelrf_swagesize);
    writestring('panelrf', 'notchtol', panelrf_notchtol);
    writestring('panelrf', 'precamber', panelrf_precamber);
    writestring('panelrf', 'mholeheight', panelrf_mholeheight);

    {truss profile}

    writestring('trussprofile', 'lipholeheight', trussprofile_lipholeheight);
    writestring('trussprofile', 'flangelipholediff', trussprofile_flangelipholediff);
    writestring('trussprofile', 'gauge', trussprofile_gauge);
    writestring('trussprofile', 'profileheight', trussprofile_profileheight);
    writestring('trussprofile', 'lipsize', trussprofile_lipsize);
    writestring('trussprofile', 'holesize', trussprofile_holesize);

    {panel profile}
    writestring('panelprofile', 'lipsize', panelprofile_lipsize);
    writestring('panelprofile', 'holeheight', panelprofile_holeheight);
    writestring('panelprofile', 'holeMheight', panelprofile_holeMheight);
    writestring('panelprofile', 'holesize', panelprofile_holesize);
    writestring('panelprofile', 'profileheight', panelprofile_profileheight);

    {truss structure}
    writestring('tstructure', 'buttgap', tstructure_buttgap);
    writestring('tstructure', 'holedist', tstructure_holedist);
    writestring('tstructure', 'tolerance', tstructure_tolerance);
    writebool('tstructure', 'minimize', tstructure_minimize);
    writebool('tstructure', 'specialcons', tstructure_specialcons);
    writebool('tstructure', 'minimizeBC', tstructure_minimizeBC);
    writebool('tstructure', 'web2web', tstructure_web2web);
    writebool('tstructure', 'screws', tstructure_screws);
    {panel structure}
    writebool('Pstructure', 'service2', Pstructure_service2);
    writestring('Pstructure', 'jointgap', Pstructure_jointgap);
    writestring('Pstructure', 'verticalgap', Pstructure_verticalgap);
    writestring('Pstructure', 'minholedist', Pstructure_minholedist);
    writebool('Pstructure', 'swage', Pstructure_swage);
    writebool('Pstructure', 'showservice', Pstructure_showservice);
    writebool('Pstructure', 'ignoremindistance', Pstructure_ignoremindistance);
    writebool('Pstructure', 'virtualmitre', Pstructure_virtualmitre);
    {inkjet printer}
    writeString('inkprinter', 'Device', inkprinter_Device);
    writeinteger('inkprinter', 'Type', inkprinter_Type);
    writebool('inkprinter', 'frmcode', inkprinter_frmcode);
    writebool('inkprinter', 'idescr', inkprinter_idescr);
    writestring('inkprinter', 'chrlen', inkprinter_chrlen);
    writestring('inkprinter', 'headpos', inkprinter_headpos);
    writestring('inkprinter', 'job', inkprinter_job);
    writestring('inkprinter', 'logo', inkprinter_logo);
    writebool('inkprinter', 'logoOn', inkprinter_logoOn);
    writestring('inkprinter', 'inkbaudrate', inkprinter_inkbaudrate);
    writestring('inkprinter', 'inkIP', inkprinter_inkIP);
    writestring('inkprinter', 'inkserial', inkprinter_inkserial);
    {printer}
    writestring('printer', 'fontsize', printer_fontsize);
    writestring('printer', 'prtradius', printer_prtradius);
    writestring('printer', 'bearingsize', printer_bearingsize);
    writebool('printer', 'braces', printer_braces);
    writeinteger('printer', 'labels', printer_labels);
    writebool('printer', 'service', printer_service);
    writeinteger('printer', 'orientation', printer_orientation);
    writebool('printer', 'multiprt', printer_multiprt);
    writebool('printer', 'websize', printer_websize);
    writebool('printer', 'prtfilepath', printer_prtfilepath);
    writebool('printer', 'orientcolour', printer_orientcolour);
    {miscellaneous}
    writebool('misc', 'power', misc_power);
    writestring('misc', 'current', misc_current);
    writebool('misc', 'comms', misc_comms);
    writebool('misc', 'USAjoint', misc_USAjoint);
    {label printing}
    writestring('label', 'job', label_job);
    writestring('label', 'font', label_font);
    writestring('label', 'printer', label_printer);


  end;
end;

procedure TRFSettings.SetGlobalJointvalues;
// *Sets global joint analysis values from settings, before calling Joint processing
begin
  try
{$IFDEF TRUSS}
    jointgap            := strtofloat(ToolUnitsIn(G_Settings.tstructure_buttgap));
    lipholepos          := strtofloat(ToolUnitsIn(G_Settings.trussprofile_lipholeheight));
    flgholepos          := lipholepos - strtofloat(ToolUnitsIn(G_Settings.trussprofile_flangelipholediff));
    TrussSwageSize      := strtofloat(ToolUnitsIn(G_Settings.trussrf_SwageSize75));
    bTrussUseSwage      := (general_machinetype='75MMTRUSS') and (TrussSwageSize<>0);
    minenddist          := strtofloat(ToolUnitsIn(G_Settings.tstructure_holedist));
    notchsize           := strtofloat(ToolUnitsIn(G_Settings.trussrf_notchsize));
    copesize            := strtofloat(ToolUnitsIn(G_Settings.trussrf_copesize));
    copenotchtol        := strtofloat(ToolUnitsIn(G_Settings.tstructure_tolerance));
    lipsize             := strtofloat(ToolUnitsIn(G_Settings.trussprofile_lipsize));
    bMinimiseLengths    := G_Settings.tstructure_minimize;
    bRequire2PtWebToWeb := G_Settings.tstructure_web2web;
    cutwidth            := strtofloat(ToolUnitsIn(G_Settings.trussrf_cutwidth));
//    HoleSize            := strtofloat(ToolUnitsIn(G_Settings.trussprofile_holesize)) / 2;
    bIgnoreMinEndDistErrors := false;
    vertjointgap := jointgap;
{$ELSE}
    jointgap            := strtofloat(ToolUnitsIn(G_Settings.Pstructure_jointgap));
    vertjointgap        := strtofloat(ToolUnitsIn(G_Settings.Pstructure_verticalgap));
    frameholepos        := strtofloat(ToolUnitsIn(G_Settings.panelrf_mholeheight));
    lipholepos          := frameholepos;
    frameholepos2       := lipholepos - strtofloat(ToolUnitsIn(G_Settings.panelrf_holeM2diffvert));
    flgholepos          := frameholepos2;

    minenddist          := strtofloat(ToolUnitsIn(G_Settings.Pstructure_minholedist));
    notchsize           := strtofloat(ToolUnitsIn(G_Settings.panelrf_notchsize));
    PanelSwagesize      := strtofloat(ToolUnitsIn(G_Settings.panelrf_swagesize));
    bPanelUseSwage      := G_Settings.Pstructure_swage;
    copesize            := strtofloat(ToolUnitsIn(G_Settings.panelrf_flatsize));
    // flat size
    copenotchtol        := strtofloat(ToolUnitsIn(G_Settings.panelrf_notchtol)); ;
    lipsize             := strtofloat(ToolUnitsIn(G_Settings.panelprofile_lipsize));
    cutwidth            := strtofloat(ToolUnitsIn(G_Settings.panelrf_cutwidth));
//    HoleSize            := strtofloat(ToolUnitsIn(G_Settings.panelprofile_holesize)) / 2;
    bMinimiseLengths    := false;
    bRequire2PtWebToWeb := false;
    bIgnoreMinEndDistErrors := G_Settings.Pstructure_ignoremindistance;
    bVirtualMitre := G_Settings.Pstructure_virtualmitre;
    EndLoadCutSize :=strtofloat(ToolUnitsIn(G_Settings.panelrf_EndBrgNotchSize)) ;
    bEndLoadCut := (EndLoadCutSize<>0) and (general_machinetype='PANELHD');
{$ENDIF}
  except
    MessageDlg('Error - Invalid value in machine settings', mtInformation, [mbOK], 0);
  end;
//  minenddist := minenddist + HoleSize; // Added 05/08 to match ScotSim
end;

procedure TMaterial.Reset;
begin
  FMetres     := 0;
  FConnectors := 0;
  FSpacers    := 0;
  FTEKScrews  := 0;
end;

initialization
  G_Settings   := TRFSettings.Create;
  G_Material   := TMaterial.Create;

finalization
  FreeAndNil(G_Settings);
  FreeAndNil(G_Material);
end.

