unit MainU;

// Database information
//
//    DMDesignJob         := TDMDesignJob.Create(nil);
//
//    FormScotTruss.RollFormerID := IntToStr(DMRollFormer.RollFormerID);
//    DMJOBDETAIL         := TDMJOBDETAIL.Create(nil);
//    DMEXPORTJOB         := TDMEXPORTJOB.Create(nil);
//    DMEXPORTEP2FILE     := TDMEXPORTEP2FILE.Create(nil);
//    DMEXPORTFRAME       := TDMEXPORTFRAME.Create(nil);
//    DMEXPORTFRAMEENTITY := TDMEXPORTFRAMEENTITY.Create(nil);
//
//
//    DMDesignJob.ResetFilter (IntToStr(DMRollFormer.RollFormerID));


interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, ButtonU, IJPMasterU,
  Dialogs, Menus, ComCtrls, StdCtrls, ExtCtrls, Buttons, ImgList, Graphics,
  FrameDataU, FramePrintU, ItemTypeSelectionU, TranslateU, jpeg, ScotRFTypes, ActnList,
  strUtils, ijpStatusU, System.Actions, System.ImageList, Math, coil, Vcl.Themes
  , UnitServiceManager, UnitServiceStatus, UnitDMRollFormer, UnitRemoteDBClass;

type
  TMainForm = class(TForm)
    Image1: TImage;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    N1: TMenuItem;
    miMachine: TMenuItem;
    miRollformerSetup: TMenuItem;
    miLoad: TMenuItem;
    Frames1: TMenuItem;
    Select1: TMenuItem;
    Print1: TMenuItem;
    Verify1: TMenuItem;
    Help1: TMenuItem;
    miDocumentation: TMenuItem;
    miUpdates: TMenuItem;
    miAbout: TMenuItem;
    uxVersion: TLabel;
    Image3: TImage;
    PrintDialog: TPrintDialog;
    Include1: TMenuItem;
    miManual: TMenuItem;
    miItem: TMenuItem;
    Settings: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    miCalibration: TMenuItem;
    OpenFile_Truss: TOpenDialog;
    OpenFile_Panel: TOpenDialog;
    OpenFile_Process: TOpenDialog;
    miExportSimcut: TMenuItem;
    MaterialsSummary1: TMenuItem;
    N3: TMenuItem;
    miBoxRF: TMenuItem;
    miBoxRFCalibration: TMenuItem;
    miBoxRFLoad: TMenuItem;
    miBoxRFManualOp: TMenuItem;
    PanelImage: TImage;
    TrussImage: TImage;
    ActionList1: TActionList;
    actClose: TAction;
    actSelect: TAction;
    actRun: TAction;
    actLoad: TAction;
    actCalibrate: TAction;
    actSettings: TAction;
    actVerify: TAction;
    ImageList32: TImageList;
    miPreview: TMenuItem;
    Settings1: TMenuItem;
    actLength: TAction;
    actRunProcessFile: TAction;
    miRollformerStatus: TMenuItem;
    Panel2: TPanel;
    InkjetStatus1: TInkjetStatus;
    uxSelect: TSpeedButton;
    uxRun: TSpeedButton;
    uxLoadSteel: TSpeedButton;
    uxCalibrate: TSpeedButton;
    uxLength: TSpeedButton;
    uxRunProcFile: TSpeedButton;
    uxExit: TSpeedButton;
    PanelCardInfo: TPanel;
    uxCardID: TLabel;
    PanelRollFormerInfo: TPanel;
    uxRollformerStatus: TLabel;
    uxRollformerID: TLabel;
    uxCardInfo: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    LabelRFCaption: TLabel;
    uxDayTotal: TLabel;
    uxCardLight: TImage;
    uxRollformerLight: TImage;
    PollRollformer: TTimer;
    StatusBarMain: TStatusBar;
    ActionLoadEP2Files: TAction;
    Menu_SettingSaveAs: TMenuItem;
    LabelRFOPLimit: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bnSelectFramesClick(Sender: TObject);
    procedure bnRunClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actCloseClick(Sender: TObject);
    procedure bnPrintClick(Sender: TObject);
    procedure bnSettingsClick(Sender: TObject);
    procedure bnVerifyClick(Sender: TObject);
    procedure miItemClick(Sender: TObject);
    procedure miManualClick(Sender: TObject);
    procedure bnCalibrateClick(Sender: TObject);
    procedure miUpdatesClick(Sender: TObject);
    procedure miDocumentationClick(Sender: TObject);
    procedure OpenProcessFile1Click(Sender: TObject);
    procedure miExportSimcutClick(Sender: TObject);
    procedure File1Click(Sender: TObject);
    procedure miBOMClick(Sender: TObject);
    procedure Include1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure miLoadClick(Sender: TObject);
    procedure bnLoadSteelClick(Sender: TObject);
    procedure miPreviewClick(Sender: TObject);
    procedure uxRunMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miBoxRFLoadClick(Sender: TObject);
    procedure miBoxRFManualOpClick(Sender: TObject);
    procedure actLengthExecute(Sender: TObject);
    procedure miRFSetupClick(Sender: TObject);
    procedure miRFStatusClick(Sender: TObject);
    procedure PollRollformerTimer(Sender: TObject);
    procedure Menu_SettingSaveAsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FDefaultStyleName : String;
    function SimCutExportEnabled: boolean;
    function GetIsServerConnected: boolean;
    procedure StartQ(bAutoStart: boolean = false);
    procedure CardStateChange(Sender: TObject);
    function getStatusLightBmp(const Value: TStatusLight): TBitMap;
    procedure UpdateRFStatusOnScreen;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  public
    FSimcutEnabled: boolean;
    procedure GetCardInfo;
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure MainInitialise(Sender: TObject);
    procedure ResetDatabase(Sender: TObject);

    procedure RunProcessFile(aSL: TStrings);overload;
    procedure RunProcessFile(AFile: string);overload;
    procedure RunProcessFile(AFile: string; aFrameSelection : TFrameSelection);overload;

    class function ManualsFolder: string; static;
    class function SCSFolder: string; static;
    function CheckCard(bShowMessage: boolean = True): boolean;
    function CheckFramesWithMessage: boolean;
    function CheckConnectionWithMessage: boolean;
    procedure UpdateScreenButtons(Sender: TObject);
    Property IsServerConnected: boolean read GetIsServerConnected;
  end;

var
  MainForm: TMainForm;

implementation

uses
  WinUtils, CardAdapterU, Usettings, LoadSteelU, items, TrussManual, Panelmanual,
  BoM, UnitScotTruss, calibrate, Logging, UpdateFormU, GlobalU, Units,
  PreviewU, spdUnit, mintStatus, ShellApi, printers, VirtualMachineU,
  Mk2ErrorsFormU, CardAPIU, RollformerU, LengthForm, mintsettings,
  Registry, UnitJobSelection,
  UnitDMDesignJob, UnitDMJOBDETAIL, DateUtils, IniFiles, UnitDMLoadEP2Files,
  UnitDMEXPORTJOB, UnitDMEXPORTEP2FILE, UnitDMEXPORTFRAME,
  UnitDMEXPORTFRAMEENTITY, UnitDMRFDateInfo, SplashScreenU,
  UnitDMItemProduction, UnitLocalDBClass, UnitDisplayDataset;
{$R *.dfm}

function TMainForm.GetIsServerConnected: boolean;
begin
  If not Assigned(DMScotServer) then
    DMScotServer := TRemoteDB.Create;
  Result := TRemoteDB(DMScotServer).DMRemoteDB.SCSServerConnected;
  If Result then
    DMSCOTRFID  := TDMRollFormer.Create(nil);
end;


procedure TMainForm.bnSettingsClick(Sender: TObject);
begin
  if FormSettings.ShowModal = mrOK then
  begin
    ShellExecute(Handle, nil, PChar(Application.ExeName), nil, nil, SW_SHOWNORMAL);
    Close;
  end;
end;

procedure TMainForm.bnVerifyClick(Sender: TObject);
var
  msg: string;
begin
  if CheckFramesWithMessage then
  begin
    msg := format('%d frames checked.',[FrameToProduce.FrameCount]);
    if FrameToProduce.ProcessFrames then
      messageDlg(msg, mtInformation, [mbOK], 0);
  end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  if not visible and not FormScotTruss.visible then
    Show;
end;

procedure TMainForm.GetCardInfo;
begin
  CheckCard(false);
end;

function TMainForm.getStatusLightBmp(const Value: TStatusLight): TBitMap;
begin
  Result :=inkjetStatus1.getStatusLightBmp(Value);                              // status frame owns the image list
end;

Function TMainForm.CheckCard(bShowMessage: boolean): boolean;
var
  msg: String;
  OK:  Boolean;
  Bmp: TBitmap;
begin
  msg := '';
  uxCardInfo.caption := '----';
  OK := CardAdapter.CheckCardOK;
  if cardAPI.CardState <> csCard then
    msg := cardAPI.CardStateStr
  else if not OK then
    msg := 'Invalid Card' // panel/truss mismatch ?
  else if not CardAdapter.hasCredit then
    msg := 'Card is '+ CardAdapter.NoCreditMessage
  else if (Rollformer.Connected=tcConnected) and not CardAdapter.CheckCardChargeType(Rollformer.MachineChargeType) then
    msg := format('%s card not valid for %s machine', [CardAdapter.ChargeSchemeStr, ChargeSchemeStr(Rollformer.MachineChargeType)]);

  CurrentCARDNUMBER := CardAdapter.CardID;
  uxCardID.caption := 'Card ID  ' + CurrentCARDNUMBER; // name + serial number
  FormScotTruss.lbCardID.caption := CurrentCARDNUMBER; // name + serial number

  GREMAINMETERS := CardInformation.Metres;

  if OK and CardAdapter.isUnlimited then
    FormScotTruss.Label13.caption := 'Card Total';
  FormScotTruss.updateCardInfoPanel;
  if msg = '' then
  begin
    if G_Settings.general_imperial then
      uxCardInfo.caption := FormScotTruss.Label13.caption + ' ' + inttostr(trunc(GREMAINMETERS*fratio)) +'  Ft'
    else
      uxCardInfo.caption := FormScotTruss.Label13.caption + ' ' + inttostr(trunc(GREMAINMETERS)) +'  M'
  end
  else
    uxCardInfo.caption := msg;
  if OK then
    Bmp := getStatusLightBmp(tsOK)
  else
    Bmp := getStatusLightBmp(tsRed);
  try
    uxCardLight.Picture.Bitmap.assign(Bmp);
  finally
    Bmp.free;
  end;

  LabelRFOPLimit.Visible := (DriveClass<>tdcSim) and G_Settings.general_warning and RollFormer.CounterExceeded;

  result := (msg = '') or (DriveClass = tdcSim);
  if bShowMessage and not result then
    TaskMessageDlg('Card Error', msg, mtWarning, [mbOK], 0);
end;

function TMainForm.CheckFramesWithMessage: boolean;
begin
  result := (FrameToProduce.FrameCount > 0);
  if not result then
    NoFramesMessage;
end;

function TMainForm.CheckConnectionWithMessage: boolean;
begin
  if DriveClass = tdcSim then
  begin
    NotInSimMessage;
    exit(false);
  end;

  result := (Rollformer.Connected = tcConnected);
  if not result then
    NoConnectionMessage;
end;

function TMainForm.SimCutExportEnabled: boolean;
var
  ts: string;
  i: Integer;
begin
  if FSimcutEnabled then
    exit(True);
  ts := InputBox('Simcut Password', 'Code :', '');
  for i := 1 to length(ts) do
    ts[i] := chr(ord(ts[i]) xor 31);
  FSimcutEnabled := ts = 'lvr|jk'; // Pwd = simcut
  result := FSimcutEnabled;
end;

procedure TMainForm.miExportSimcutClick(Sender: TObject);
begin
  if CheckFramesWithMessage then
  begin
    if not SimCutExportEnabled then
      exit;
    FormScotTruss.BuildQueueFromFrameSelection(FrameToProduce, TypeSelectform.isItemTypeSelected);
    FrameToProduce.SaveEntities;
  end;
end;

procedure TMainForm.bnRunClick(Sender: TObject);
begin
  if not CheckFramesWithMessage then
    Exit;
  FormScotTruss.BuildQueueFromFrameSelection(FrameToProduce, TypeSelectform.isItemTypeSelected);
  if (DriveClass = tdcSim) then
  begin
    StartQ(True);
  end
  else
  if CheckCard then
  begin
    StartQ(True);
  end;
  FrameToProduce.ResetSelectedFrames;
end;

procedure TMainForm.uxRunMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ssCtrl in Shift then
    miPreviewClick(Sender);
end;

class function TMainForm.ManualsFolder: string;
begin
{$IFDEF PANEL}
  result := SCSFolder + '\Design\Manuals'
{$ELSE}
  result := SCSFolder + '\Design\Manuals'
{$ENDIF}
end;

procedure TMainForm.Menu_SettingSaveAsClick(Sender: TObject);
var
  saveDialog : TSaveDialog;
begin
  saveDialog := TSaveDialog.Create(self);
  try
    saveDialog.Title := 'Save RFS setting File to other location';

    saveDialog.FileName := G_Settings.RFSSettingFile;
    if G_Settings.RFSSettingFile='' then
      saveDialog.InitialDir := GetCurrentDir
    else
      saveDialog.initialdir := extractfilepath(G_Settings.RFSSettingFile);
    saveDialog.Filter := 'RFS Settings File|*.rfs';
    saveDialog.DefaultExt := 'rfs';
    saveDialog.FilterIndex := 1;
    if saveDialog.Execute then
    begin
      CopyFile(PChar(G_Settings.RFSSettingFile), PChar(saveDialog.FileName), true);
    end;
  finally
    saveDialog.Free;
  end;
end;

procedure TMainForm.bnSelectFramesClick(Sender: TObject);
begin
  if NOT assigned(DMDesignJob) then
  begin
    DMDesignJob     := TDMDesignJob.Create(Self);
    DMLoadEP2Files  := TDMLoadEP2Files.Create(Self);
  end
  else
    DMDesignJob.RefreshData(nil);
  FrameToProduce.ResetSelectedFrames;
  TFormJobSelection.SelectFramesToProduce;
end;

procedure TMainForm.WMDropFiles(var Msg: TWMDropFiles);
var
  FileName: String;
  N: integer;
begin
  try
    setlength(Filename,MAX_PATH);
    N:=DragQueryFile(Msg.Drop, 0, @FileName[1], MAX_PATH);
    setlength(Filename,N);
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TMainForm.File1Click(Sender: TObject);
begin
  miExportSimcut.visible := FSimcutEnabled;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FrameToProduce);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  if Assigned(TStyleManager.ActiveStyle) then
    FDefaultStyleName := TStyleManager.ActiveStyle.Name;

  if Assigned(TStyleManager.ActiveStyle) and (TStyleManager.ActiveStyle.Name<>'Windows') then
  begin
    TStyleManager.TrySetStyle('Windows');
  end
  else
  begin
    TStyleManager.TrySetStyle(FDefaultStyleName);
  end;


  with TRegIniFile.Create( REGISTRY_NAME ) do
  try
    Site_ID        := ReadString('ScotRF', 'SiteID', '1');
    SiteName       := ReadString('ScotRF', 'SiteName', 'ScotSite');
    StatusbarMain.Panels[0].Text:= Format('Scot Server : %s', [ReadString('RemoteServer', 'Server', 'Localhost')]);
    StatusbarMain.Panels[1].Text:= Format('RFS File : %s', [G_Settings.RFSSettingFile]);
  finally
    Free
  end;
  UpdateScreenButtons(nil);
  FrameToProduce      := TFrameSelection.Create;
  uxVersion.caption := 'Version ' + SplashScreenU.GetFileVersion(Application.ExeName);
  PanelImage.visible := bFrames;
  TrussImage.visible :=Not bFrames;
  clientwidth := Image1.Width;
  uxLoadSteel.Action := actLoad;
  uxCalibrate.Action := actCalibrate;
  uxLength.Action := actLength;
  uxRunProcFile.Action := actRunProcessFile;
  uxExit.Action := actClose;
  FSimcutEnabled := True; // for now ...
  TranslateForm(self);
  InkJetMaster.StatusFrame1 := InkjetStatus1;
  CardInformation := TCardInfomation.Create;
  if G_Settings.general_MachineName<>'' then
  begin
    MainInitialise(nil);
  end
  else
  begin
    ShowMessage('Set Machine Name First and Restart the Program');
  end;
  if G_Settings.general_IsConnectToServer then
  begin
    If IsServerConnected then
    begin

    end;
  end
  else
  begin
    DMScotServer := TLocalDB.Create;
    DMSCOTRFID  := TDMRollFormer.Create(nil);
  end;

  FRFDateInfo         := TRFDateInfo.Create;
  DMRFDateInfo := TDMRFDateInfo.Create(Self);
  DMRFDateInfo.ResetFilter;
  if G_Settings.general_imperial then
    uxDayTotal.caption := 'Day Total   ' + inttostr(trunc(DMRFDateInfo.DayTotalMeters * fratio)) +' Ft'
  else
    uxDayTotal.caption := 'Day Total   ' + inttostr(trunc(DMRFDateInfo.DayTotalMeters)) +' M';
  FJobDetail          := TJOBDETAIL.Create;

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(DMDesignJob);
  FreeAndNil(FJobDetail);
  FreeAndNil(DMJOBDETAIL);
  FreeAndNil(CardInformation);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  TypeSelectform.bnOKClick(nil);
end;

procedure TMainForm.CardStateChange(Sender: TObject);
begin
  CardAdapter.CloseReader;
  CardAdapter.OpenReader;
  GetCardInfo;
end;

procedure TMainForm.MainInitialise(Sender: TObject);
begin
  DragAcceptFiles(Handle, True);
  G_Settings.OnSettingsChange := ResetDatabase;
  Rollformer := TRollformer.Create(Self);
  if (Rollformer.Connected <> tcConnected) and Not (DriveClass = tdcSim) then
  begin
    Rollformer.ConnectToDrive;
  end;
  IF Not((DriveClass=tdcVirtual)or(DriveClass=tdcSim)) and (Rollformer.Connected=tcConnected) then
    Rollformer.ReadMachineCounters;
  FormScotTruss := TFormScotTruss.Create(Application);
  cardAPI.OnStateChange := CardStateChange;
  CardStateChange(nil);
  if (DriveClass = tdcSim) or (DriveClass = tdcVirtual) or (InkJetMaster.PrinterType = IJPNone) then
    InkJetMaster.IJPEnabled := false
  else
    InkJetMaster.IJPEnabled := True;
  if Rollformer.MachineChargeType=ccGreen then
    uxRollformerID.caption := G_Settings.general_drive
  else
    uxRollformerID.caption := G_Settings.general_drive + ' ' + ChargeSchemeStr(Rollformer.MachineChargeType);

  InkJetMaster.PrinterType := TInkjetType(G_Settings.inkprinter_Type);
  InkJetMaster.IJPEnabled := Not ((DriveClass = tdcSim) or (DriveClass=tdcVirtual) or (InkJetMaster.PrinterType = IJPNone));
  Caption := Format('%s,   Rollformer: %s', [Appname,G_Settings.general_MachineName]);
  If G_Settings.general_IsConnectToServer then
    StatusbarMain.Panels[1].Text:= Format('%s connected to server : %s', [G_Settings.general_MachineName, G_Settings.general_Server])
  else
    StatusbarMain.Panels[1].Text:= Format('%s is a standalone machine', [G_Settings.general_MachineName]);
  UpdateRFStatusOnScreen;
end;


procedure TMainForm.UpdateRFStatusOnScreen;
var Bmp: tBitMap;
begin
  Bmp:=nil;
  try
   if (DriveClass = tdcSim) then
    begin
      uxRollformerStatus.caption := 'Simulation Mode';
      Bmp := getStatusLightBmp(tsAmber)
    end
    else
    begin
      GetCardInfo;
      if Rollformer.Connected = tcConnected then
      begin
        uxRollformerStatus.caption := 'Rollformer Connected';
        Bmp := getStatusLightBmp(tsOK);
      end  else
      begin
        uxRollformerStatus.caption := 'No Rollformer Connection';
        Bmp := getStatusLightBmp(tsRed)
      end;
    end;
    uxRollformerLight.Picture.Bitmap.assign(Bmp);

  finally
    Bmp.free;
  end;
end;

procedure TMainForm.UpdateScreenButtons(Sender: TObject);
begin
    uxSelect.Action  := actSelect;
    uxRun.Action     := actRun;
    uxSelect.Enabled := True;
    uxRun.Enabled    := True;
end;

procedure TMainForm.Include1Click(Sender: TObject);
begin
  TypeSelectform.showmodal;
end;

procedure TMainForm.miBOMClick(Sender: TObject);
begin
  if FrameToProduce.FrameCount > 0 then
  begin
    TFormBoM.Exec();
  end
  else
    NoFramesMessage;
end;

class function TMainForm.SCSFolder: string;
const
  CSIDL_PROGRAM_FILESX86 = $002A; // from Windows
begin
  result := GetSpecialFolderPath(CSIDL_PROGRAM_FILESX86)+ '\SCS\';
end;


procedure TMainForm.miDocumentationClick(Sender: TObject);
begin
  if not DirectoryExists(ManualsFolder) then
    forcedirectories(ManualsFolder);
  ShellExecute(Handle, 'Open', PChar(ManualsFolder), '', '', SW_NORMAL);
end;

procedure TMainForm.miItemClick(Sender: TObject);
var
  res: Integer;
begin
  res := itemform.showmodal;
  case res of
    ID_RUNPROCESS:
      begin
        RunProcessFile(itemform.Memo1.lines);
      end;
  end;
end;

procedure TMainForm.miLoadClick(Sender: TObject);
begin
  TDlgLoad.Exec(false)
end;

procedure TMainForm.bnLoadSteelClick(Sender: TObject);
begin
  if CheckConnectionWithMessage then
    TDlgLoad.Exec(false);
end;

procedure TMainForm.miBoxRFLoadClick(Sender: TObject);
begin
  if Rollformer.Connected <> tcConnected then // should really check box drive
    Rollformer.ConnectToDrive;
  if Rollformer.Connected = tcConnected then
    TDlgLoad.Exec(True);
end;

procedure TMainForm.miBoxRFManualOpClick(Sender: TObject);
begin
  TTrussManualForm.Exec(True);
end;

procedure TMainForm.miManualClick(Sender: TObject);
begin
{$IFDEF TRUSS}
  if CheckConnectionWithMessage then
    TTrussManualForm.Exec(false);
{$ELSE}
  if CheckConnectionWithMessage then
    TPanelManualForm.Exec;
{$ENDIF}
  GetCardInfo;
end;

procedure TMainForm.miPreviewClick(Sender: TObject);
var
  PreviewForm: TPreviewForm;
begin
  if (FrameToProduce.FrameCount > 0) then
  begin
    begin
      PreviewForm := TPreviewForm.Create(nil, FrameToProduce);
      try
        case PreviewForm.showmodal of
          mrOK:;
          mrRunFrame:
            begin
              FormScotTruss.BuildQueueFromFrameSelection(FrameToProduce, PreviewForm.isSelected);
              StartQ;
            end;
        end {case};
      finally
        PreviewForm.Free;
      end;
    end;
  end
  else
    NoFramesMessage;
end;

procedure TMainForm.miUpdatesClick(Sender: TObject);
begin
  TfrmUpdate.Exec;
end;


procedure TMainForm.RunProcessFile(AFile: string);
var SL: TStringlist;
begin
  SL := tStringlist.Create;
  try
    SL.LoadFromFile(AFile);
    if FormScotTruss.BuildQFromProcessStringsSingle(SL) then
      StartQ;
  finally
    SL.Free
  end;
end;

procedure TMainForm.RunProcessFile(aSL: TStrings);
begin
  try
    if FormScotTruss.BuildQFromProcessStringsSingle(aSL) then
      StartQ;
  finally
  end;
end;

procedure TMainForm.RunProcessFile(AFile: string; aFrameSelection : TFrameSelection);
var
  SL: TStringlist;
begin
  SL := TStringlist.Create;
  try
    SL.LoadFromFile(AFile);
    DMLoadEP2Files.ProcessFile(SL, aFrameSelection);
    FormScotTruss.BuildQueueFromFrameSelection(aFrameSelection, TypeSelectform.isItemTypeSelected);
    if (DriveClass = tdcSim) then
    begin
      StartQ(True);
    end
    else
    if CheckCard then
    begin
      StartQ(True);
    end;
  finally
    SL.Free
  end;
end;

procedure TMainForm.OpenProcessFile1Click(Sender: TObject);
var
  aStringList  : TStringlist;
  aString      : String;
  spaceRemoved : String;
  isFrame      : Boolean;
begin
  FrameToProduce.ResetSelectedFrames;
  if CheckCard and ((DriveClass = tdcSim) or CheckConnectionWithMessage) then
  begin
    OpenFile_Process.Filter :=  ProcessFileFilter; // varies for panel & truss
    if OpenFile_Process.Execute(Handle) then
    begin
      aStringList := TStringlist.Create;
      aStringList.LoadFromFile(OpenFile_Process.FileName);
      try
        aString := aStringList[0];
        spaceRemoved := StringReplace(aString, ' ', '', [rfReplaceAll]);
        if SameText(spaceRemoved, 'inches') and G_Settings.general_metric then
          raise exception.Create('Units do not match .RFS File Settings');
        if SameText(spaceRemoved, 'mm')     and NOT G_Settings.general_metric then
          raise exception.Create('Units do not match .RFS File Settings');
        if (spaceRemoved = 'inches') or (spaceRemoved = 'mm') then
        begin
          RunProcessFile(OpenFile_Process.FileName, FrameToProduce);
        end
        else
        begin
          RunProcessFile(OpenFile_Process.FileName);
        end;
      finally
        FreeAndNil(aStringList);
      end;
    end;
  end;
end;

procedure TMainForm.PollRollformerTimer(Sender: TObject);
var
  was: tConnectionState;
begin
  was:= Rollformer.Connected;
  if (Screen.FocusedForm=self) and
     IsBaldorDrive then
  begin
    try
      Rollformer.CheckConnection;
    except
      on e: exception do
      begin
        StatusbarMain.Panels[1].Text := e.classname;
        Rollformer.DisConnect;
      end;
    end;
  end;
  if was <> Rollformer.Connected then
    UpdateRFStatusOnScreen;
end;

procedure TMainForm.StartQ(bAutoStart: boolean);
begin
  PollRollformer.Enabled := False;
  Hide;
  try
    PostMessage(FormScotTruss.Handle, WM_StartQ, ord(bAutoStart), 0);
    FormScotTruss.ShowModal;
  finally
    FormScotTruss.Hide;
    Show;
    if G_Settings.general_imperial then
      uxDayTotal.caption := 'Day Total   ' + inttostr(trunc(DMRFDateInfo.DayTotalMeters * fratio)) +' Ft'
    else
      uxDayTotal.caption := 'Day Total   ' + inttostr(trunc(DMRFDateInfo.DayTotalMeters)) +' M';
    PollRollformer.enabled := True;
    GetCardInfo; // refresh with updated metres
  end;
end;

procedure TMainForm.WMSysCommand(var Message: TWMSysCommand);
begin
  case Message.CmdType of
    SC_CONTEXTHELP:
      begin
        Message.result := 1;
      end;
  else
    inherited;
  end;
end;

procedure TMainForm.bnPrintClick(Sender: TObject);
var
  BMP: tBitmap;
  FramePrinter: TFramePrinter;
  I : integer;
begin
  if (FrameToProduce.FrameCount > 0) then
  begin
    if PrintDialog.Execute(Handle) then
    begin
      Printer.Copies := PrintDialog.Copies;
{$IFDEF USA}
      BMP := Image2.Picture.bitmap;
{$ELSE}
      BMP := Image3.Picture.bitmap;
{$ENDIF}
      FramePrinter := TFramePrinter.Create;
      try
        FramePrinter.PrintFrames(FrameToProduce, BMP);
      finally
        FramePrinter.Free;
      end;
    end;
  end
  else
    NoFramesMessage;
end;

procedure TMainForm.actLengthExecute(Sender: TObject);
begin
    if CheckConnectionWithMessage and CheckCard then
    try
      if TfrmManualLength.Exec then
      begin
        FormScotTruss.BuildQFromManualLengthStrings(frmManualLength.ProcessFile, False);
        StartQ(True);
      end;
    finally
      GetCardInfo;
    end;
end;

procedure TMainForm.bnCalibrateClick(Sender: TObject);
begin
  if CheckConnectionWithMessage and CheckCard then
  begin
    TCalibrateForm.Exec;
    GetCardInfo;
  end;
end;

procedure TMainForm.miRFSetupClick(Sender: TObject);
begin
  if (DriveClass = tdcSim) then
  begin
    NotInSimMessage;
    exit;
  end;

  if CheckConnectionWithMessage then
  begin
    case DriveClass of
      tdcMint    : mintform.showmodal;
      tdcFlex    : TSpeedform.Exec;
      tdcVirtual : NotForVMMessage;
    end;
  end;
end;

procedure TMainForm.miRFStatusClick(Sender: TObject);
var ts1:string; {Get machine status}
begin
  if CheckConnectionWithMessage then
  begin
    case DriveClass of
      tdcMint: TFormMintstatus.Exec('Drive Status'); {Mint drives only}
      tdcFlex:
        begin {Pre-Mint drives (Flex+}
          if Rollformer.SendCommand('RM#', True) and Rollformer.CommandCompleted then
          begin
            ts1 := copy(ReceivedStrings, 2, length(ReceivedStrings)- 2);
            showmessage('Status = ' + ts1);
            ReceivedStrings := '';
          end
          else
            messageDlg('No status response', mtInformation,[mbOK], 0);
        end;
      tdcVirtual: NotForVMMessage;
    end;
  end;
end;

procedure TMainForm.actCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ResetDatabase(Sender: TObject);
begin

end;

end.
