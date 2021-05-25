unit Usettings;

{
 ScotRF settings tabbed form
 Allows users to read, edit & save all conficgurable values
 Author - Pete
 Changes display format for panle or Truss versions
}
interface

uses
  Windows, FileCtrl, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, inifiles, WinUtils, serialports, strUtils,
  registry, ScotRFTypes, GlobalU, AdjustForJointsU, ComObj, printers, VersionU, passwordU, CountFrameU,
  Vcl.DBCtrls, UnitDMRFDateInfo, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Winapi.ShlObj;

type
  tToolPanelPos=(tppNone,tppTopLeft,tppTopRight,tppBottomRight, tppBottomLeft);
type
  TFormSettings = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label21: TLabel;
    Drivetype: TComboBox;
    Label27: TLabel;
    framepause: TCheckBox;
    ShowItemNoCBox: TCheckBox;
    Label10: TLabel;
    EditRFComPort: TEdit;
    Label13: TLabel;
    Label2: TLabel;
    trusscutwidthEdit: TEdit;
    Label11: TLabel;
    trussnotchsizeedit: TEdit;
    Label14: TLabel;
    trussprecamberedit: TEdit;
    Label17: TLabel;
    trussjointgap: TEdit;
    WarnCBox: TCheckBox;
    trusscopesizeedit: TEdit;
    Label1: TLabel;
    tabTrussCounters: TTabSheet;
    Label32: TLabel;
    Label33: TLabel;
    SerialBtn: TSpeedButton;
    Label35: TLabel;
    trussHoledistanceedit: TEdit;
    Label19: TLabel;
    trusscopetoledit: TEdit;
    bnReadTrussCounters: TBitBtn;
    OpenDialog1: TOpenDialog;
    bnOpen: TBitBtn;
    settingfile: TEdit;
    bnCancel: TBitBtn;
    trussminimizecbox: TCheckBox;
    RectanglesCBox: TCheckBox;
    trussSpecConCBox: TCheckBox;
    TabSheet6: TTabSheet;
    trussprofileedit: TEdit;
    Label37: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    trussLipsizeEdit: TEdit;
    Label39: TLabel;
    Label36: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Label20: TLabel;
    trussMinimizeBCCBox: TCheckBox;
    Label40: TLabel;
    trussWeb2webCBox: TCheckBox;
    trussScrewsCBox: TCheckBox;
    trussGaugeEdit: TComboBox;
    Memo1: TMemo;
    TabSheet7: TTabSheet;
    Label43: TLabel;
    prtradiusedit: TEdit;
    Label46: TLabel;
    BaudCBox: TComboBox;
    TabSheet8: TTabSheet;
    CommsMessageCBox: TCheckBox;
    TrussAutoPCCBox: TCheckBox;
    Label47: TLabel;
    Label49: TLabel;
    bearingsizeedit: TEdit;
    BraceCBox: TCheckBox;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    Label50: TLabel;
    Label51: TLabel;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Label56: TLabel;
    PanelHoleSize: TEdit;
    PanelLipSize: TEdit;
    SortChordWebCBox: TCheckBox;
    Shape20: TShape;
    Shape21: TShape;
    PanelprofileHeight: TEdit;
    Shape22: TShape;
    Shape18: TShape;
    Shape23: TShape;
    Shape24: TShape;
    Label58: TLabel;
    PowercBox: TCheckBox;
    CurrentEdit: TEdit;
    Label42: TLabel;
    Label67: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    PanelCut2Flat: TEdit;
    PanelHole2Flat: TEdit;
    PanelNotch2Flat: TEdit;
    PanelService2Flat: TEdit;
    PanelService22Flat: TEdit;
    PanelSwage2Flat: TEdit;
    PanelCutWidth: TEdit;
    Label23: TLabel;
    OpPauseEdit: TEdit;
    tabPanelCounters: TTabSheet;
    Label72: TLabel;
    Label73: TLabel;
    TabSheet13: TTabSheet;
    Service2cbox: TCheckBox;
    Label52: TLabel;
    Label53: TLabel;
    lblSwageToolLen: TLabel;
    PanelFlatSize: TEdit;
    PanelNotchSize: TEdit;
    PanelSwageToolLen: TEdit;
    UseSwageCBox: TCheckBox;
    lblPanelJointGap: TLabel;
    Label57: TLabel;
    lblPanelHoleDist: TLabel;
    PanelJointGap: TEdit;
    PanelVertJointGap: TEdit;
    PanelMinHoleDist: TEdit;
    PanelPreCamber: TEdit;
    Label75: TLabel;
    Label45: TLabel;
    DisplayFontSize: TEdit;
    TabSheet4: TTabSheet;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Shape1: TShape;
    Image1: TImage;
    Label85: TLabel;
    Label86: TLabel;
    Com2Port: TEdit;
    Edit2: TEdit;
    SendBtn: TButton;
    SetDefaultsBtn: TBitBtn;
    FlushBtn: TBitBtn;
    FCodecbox: TCheckBox;
    IDescrCBox: TCheckBox;
    chrlength: TEdit;
    headpos: TEdit;
    HelpBtn: TBitBtn;
    editjob: TEdit;
    SetHeadPosBtn: TBitBtn;
    LogoEdit: TEdit;
    LogoCBox: TCheckBox;
    Image2: TImage;
    Image3: TImage;
    PanelNotchTol: TEdit;
    Label87: TLabel;
    PanelShowServicesCBox: TCheckBox;
    PrtServicecBox: TCheckBox;
    MultiPrtCBox: TCheckBox;
    HSLabel: TLabel;
    TrussHoleSizeEdit: TEdit;
    PanelIgnoreHoleDistErrCBox: TCheckBox;
    TabSheet9: TTabSheet;
    VirtualMitreCBox: TCheckBox;
    websizecbox: TCheckBox;
    prtfilepathcbox: TCheckBox;
    ItemLabelRG: TRadioGroup;
    PrinterRG: TRadioGroup;
    LoadToolBtn: TBitBtn;
    SaveToolBtn: TBitBtn;
    Shape27: TShape;
    LoadTrussToolBtn: TBitBtn;
    Shape28: TShape;
    SaveTrussToolBtn: TBitBtn;
    PanelHoleHeight: TEdit;
    Label54: TLabel;
    uxFlangeLipHoleVDiff: TEdit;
    uxLipHoleHeight: TEdit;
    FlangeHgtLabel: TLabel;
    LipHgtLabel: TLabel;
    lbFlangeLipHoleDiff: TLabel;
    lbLipHoleHeight: TLabel;
    PanelHoleHgtLabel: TLabel;
    ColourCBox: TCheckBox;
    RBMetric: TRadioButton;
    RBImperial: TRadioButton;
    Timer2: TTimer;
    Label16: TLabel;
    Label55: TLabel;
    Button1: TButton;
    LabelPrintCBox: TCheckBox;
    tabLabelPrinting: TTabSheet;
    SpeedButton8: TSpeedButton;
    LabelJobEdit: TEdit;
    Label78: TLabel;
    LabelFontEdit: TEdit;
    Label79: TLabel;
    Label90: TLabel;
    labelprinteredit: TEdit;
    Label94: TLabel;
    PanelHoleDiffHorz: TEdit;
    Label95: TLabel;
    PanelHoleDiffHeight: TEdit;
    Shape29: TShape;
    Shape19: TShape;
    USJointCBox: TCheckBox;
    TrussDblNotchCB: TCheckBox;
    InkBtn: TBitBtn;
    CleanBtn: TBitBtn;
    TwinRFCBox: TCheckBox;
    TabBoxRf: TTabSheet;
    LoadBoxToolBtn: TBitBtn;
    SaveBoxToolBtn: TBitBtn;
    Label96: TLabel;
    BoxCutWidthEdit: TEdit;
    BoxCut2holeEdit: TEdit;
    Label97: TLabel;
    Label98: TLabel;
    Label12: TLabel;
    InkBaudDropBox: TComboBox;
    Label99: TLabel;
    InkIPEdit: TEdit;
    Label31: TLabel;
    InkSerialEdit: TEdit;
    GroupBox1: TGroupBox;
    uxPauseReason: TCheckBox;
    uxLogToolOps: TCheckBox;
    bnSave: TBitBtn;
    uxRecordJobDetails: TCheckBox;
    StatusBar1: TStatusBar;
    GroupBox2: TGroupBox;
    BtnPwd1: TButton;
    Button3: TButton;
    RemoveFrmCBox: TCheckBox;
    rgInkPrinter: TRadioGroup;
    bnReadPanelCounters: TBitBtn;
    tabAbout: TTabSheet;
    Label92: TLabel;
    Label3: TLabel;
    uxVersionInfo: TMemo;
    DesignOrderCBox: TCheckBox;
    uxTrussCutCounter: TCounterFrame;
    uxTrussCopeCounter: TCounterFrame;
    uxTrussNotchCounter: TCounterFrame;
    uxTrussLipPunchCounter: TCounterFrame;
    uxTrussFlangePunchCounter: TCounterFrame;
    CounterFrameFlangePunch: TCounterFrame;
    CounterFrameLipPunch: TCounterFrame;
    CounterFrameNotches: TCounterFrame;
    CounterFrameService1s: TCounterFrame;
    CounterFrameCut: TCounterFrame;
    uxSimulationMode: TCheckBox;
    Label4: TLabel;
    fontsizeedit: TEdit;
    uxMachineType: TComboBox;
    Label22: TLabel;
    lbTrussSwageSize: TLabel;
    uxTrussSwageSize: TEdit;
    TrussPanel: TPanel;
    lbTrussCutToLip: TLabel;
    uxTrussCutToLip: TEdit;
    lbTrussCopeToLip: TLabel;
    uxTrussCopeToLip: TEdit;
    lbTrussNotchToLip: TLabel;
    uxTrussNotchToLip: TEdit;
    lbTrussFHtoLipH: TLabel;
    uxTrussFHtoLipH: TEdit;
    Truss75mmPanel: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    uxTrussCutToNotch: TEdit;
    uxTrussCopeToNotch: TEdit;
    uxTrussLipHoleToNotch: TEdit;
    uxTruss3inFHtoLipH: TEdit;
    uxTrussSwageToNotch: TEdit;
    lbTrussSwageTo: TLabel;
    CounterFrameEndingBearingNotch: TCounterFrame;
    PanelHDSettings: TPanel;
    uxPanelEndBrgToFlat: TEdit;
    lbPanelEndBrgToFlat: TLabel;
    uxPanelEndBrgSize: TEdit;
    lbPanelEndBrgSize: TLabel;
    CounterFrameService2s: TCounterFrame;
    Edit_MachineName: TEdit;
    LabelMachineID: TLabel;
    DBGridDateInfo: TDBGrid;
    DataSourceDateInfo: TDataSource;
    CheckBoxAuditDetails: TCheckBox;
    Label_MachineName: TLabel;
    SaveDialog1: TSaveDialog;
    CounterFrameFlatenPunch: TCounterFrame;
    CheckBoxIsConnectToServer: TCheckBox;
    GroupBoxServer: TGroupBox;
    LabelServer: TLabel;
    EditServer: TEdit;
    LabelPort: TLabel;
    EditPort: TEdit;
    procedure SerialBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bnReadTrussCountersClick(Sender: TObject);
    procedure bnOpenClick(Sender: TObject);
    procedure bnSaveClick(Sender: TObject);
    procedure bnCancelClick(Sender: TObject);
    procedure TrussAutoPCCBoxClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LandscapeRBtnClick(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure LoadToolBtnClick(Sender: TObject);
    procedure SaveToolBtnClick(Sender: TObject);
    procedure LoadTrussToolBtnClick(Sender: TObject);
    procedure SaveTrussToolBtnClick(Sender: TObject);
    procedure PanelHoleHeightChange(Sender: TObject);
    procedure uxFlangeLipHoleVDiffChange(Sender: TObject);
    procedure SetDefaultsBtnClick(Sender: TObject);
    procedure SetHeadPosBtnClick(Sender: TObject);
    procedure FlushBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure SendBtnClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure BtnPwd1Click(Sender: TObject);
    procedure BtnPwd2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure InkBtnClick(Sender: TObject);
    procedure CleanBtnClick(Sender: TObject);
    procedure RBsx32Click(Sender: TObject);
    procedure RBDoD2002Click(Sender: TObject);
    procedure LoadBoxToolBtnClick(Sender: TObject);
    procedure SaveBoxToolBtnClick(Sender: TObject);
    procedure RBVideoJetClick(Sender: TObject);
    procedure RBSojetClick(Sender: TObject);
    procedure edMachineIDKeyPress(Sender: TObject; var Key: Char);
    procedure rgInkPrinterClick(Sender: TObject);
    procedure tabAboutShow(Sender: TObject);
    procedure bnReadPanelCountersClick(Sender: TObject);
    procedure uxMachineTypeChange(Sender: TObject);
    procedure TabSheet9Show(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Edit_MachineNameChange(Sender: TObject);
    procedure TwinRFCBoxClick(Sender: TObject);
    procedure CheckBoxIsConnectToServerClick(Sender: TObject);
  private
    Timer2Tick: cardinal;
    procedure  HideAll;
    procedure UpdateCountersOnScreen(ATab: TTabSheet);
    procedure UpdateCountersFromScreen(ATab: TTabSheet);
    function InkJetType: TInkjetType;
    procedure SendIJPCommand(cmd: string; wfr: boolean; AWaitSecs: uInt8=0);
    procedure WaitSecs(t: word);
    procedure setMachineType(AMachineType: string);
  public
    procedure setDrive(AString: string);
    procedure WriteINI;
    procedure ReadINI;
    procedure EnablePwdProtection;
    function HoleAutoJoinAdjustStr: string;
    function GetVerInfo(sApp, sInfo: string): string;
   function MachineType: TMachineType;

  end;

var
  Formsettings     : TFormSettings;

  Site_ID         : String;
  SiteName       : String;

function DriveClass    : TDriveClass;

function IsBaldorDrive : boolean;
function DriveHasTemp  : boolean;

implementation

uses UnitScotTruss, units,  logging, CardAPIU, cardAdapterU, RollformerU, IJPSojetU, ijpMasterU,
  UnitDMRollFormer;
{$R *.dfm}


procedure TFormSettings.EnablePwdProtection;
  procedure setEnabled(AParent: TWincontrol; bSet: boolean);
  var i: integer;
  begin
    for i:=0 to pred(AParent.ControlCount) do
      Aparent.controls[i].enabled:= bSet;
  end;
begin
  //Password A only
  uxMachineType .enabled := pwd1;
  RBMetric.enabled := pwd1; RBImperial.enabled := pwd1;
  BaudCBox.enabled := pwd1;
  Drivetype.enabled := pwd1;
  RemoveFrmCBox.enabled := pwd1;
  EditRFComPort.enabled := pwd1;
  OpPauseEdit.enabled := pwd1;
  PanelCut2Flat.enabled := pwd1;
  PanelHole2Flat.enabled := pwd1;
  PanelNotch2Flat.enabled := pwd1;
  PanelService2Flat.enabled := pwd1;
  PanelService22Flat.enabled := pwd1;
  lbPanelEndBrgToFlat.enabled := pwd1;
  uxPanelEndBrgToFlat.enabled := pwd1;
  uxPanelEndBrgSize.enabled := pwd1;
  lbPanelEndBrgSize.enabled := pwd1;
  PanelSwage2Flat.enabled := pwd1;
  PanelCutWidth.enabled := pwd1;
  PanelFlatSize.enabled := pwd1;
  PanelNotchSize.enabled := pwd1;
  PanelSwageToolLen.enabled := pwd1;
  PanelHoleHeight.enabled := pwd1;
  LoadToolBtn.enabled := pwd1;
  SaveToolBtn.enabled := pwd1;
  PanelNotchTol.enabled := pwd1;
  PanelPreCamber.enabled := pwd1;
  PanelLipSize.enabled := pwd1;
  PanelHoleSize.enabled := pwd1;
  PanelprofileHeight.enabled := pwd1;
  PanelHoleHeight.enabled := pwd1;
  PanelHoleDiffHeight.enabled := pwd1;
  PanelHoleDiffHorz.enabled := pwd1;

  SetEnabled(Truss75mmPanel, pwd1);
  SetEnabled(TrussPanel, pwd1);

  trusscutwidthEdit.enabled := pwd1;
  trussnotchsizeedit.enabled := pwd1;
  trusscopesizeedit.enabled := pwd1;
  uxLipHoleHeight.enabled := pwd1;
  uxFlangeLipHoleVDiff.enabled := pwd1;
  uxTrussSwageSize.enabled := pwd1;
  lbTrussSwageSize.enabled := pwd1;
  LoadTrussToolBtn.enabled := pwd1;
  SaveTrussToolBtn.enabled := pwd1;
  trussprecamberedit.enabled := pwd1;
  TrussAutoPCCBox.enabled := pwd1;
  SortChordWebCBox.enabled := pwd1;
  trussprofileedit.enabled := pwd1;
  TrussHoleSizeEdit.enabled := pwd1;
  trussLipsizeEdit.enabled := pwd1;
  TrussDblNotchCB.enabled := pwd1;
  Label23.enabled := pwd1;
  Label10.enabled := pwd1;
  Label27.enabled := pwd1;
  Label59.enabled := pwd1;
  Label60.enabled := pwd1;
  Label61.enabled := pwd1;
  Label62.enabled := pwd1;
  Label63.enabled := pwd1;
  Label64.enabled := pwd1;
  Label65.enabled := pwd1;
  Label52.enabled := pwd1;
  Label53.enabled := pwd1;
  lblSwageToolLen.enabled := pwd1;
  Label87.enabled := pwd1;
  Label75.enabled := pwd1;
  Label54.enabled := pwd1;
  Label56.enabled := pwd1;
  Label51.enabled := pwd1;
  Label58.enabled := pwd1;
  lbTrussCutToLip.enabled := pwd1;
  lbTrussCopeToLip.enabled := pwd1;
  Label14.enabled := pwd1;
  Label1.enabled := pwd1;
  Label2.enabled := pwd1;
  Label11.enabled := pwd1;
  lbFlangeLipHoleDiff.enabled := pwd1;
  lbLipHoleHeight.enabled := pwd1;
  Label14.enabled := pwd1;
  Label37.enabled := pwd1;
  HSLabel.enabled := pwd1;
  Label39.enabled := pwd1;
  Label17.enabled := pwd1;
  Label35.enabled := pwd1;
  Label94.enabled := pwd1;
  Label95.enabled := pwd1;
  CheckBoxIsConnectToServer.Enabled := pwd1;
  GroupBoxServer.Enabled := pwd1;

  Edit_MachineName.Enabled := pwd1 or (Edit_MachineName.Text='');

  uxRecordJobDetails.enabled := pwd1;
  uxPauseReason.enabled := pwd1;
  uxLogToolOps.enabled := pwd1;
  //Password A or B
  PanelShowServicesCBox.enabled :=(pwd1 or pwd2);
  PanelMinHoleDist.enabled := pwd1 or pwd2;
  PanelJointGap.enabled := pwd1 or pwd2;
  PanelVertJointGap.enabled := pwd1 or pwd2;
  PanelIgnoreHoleDistErrCBox.enabled := pwd1 or pwd2;
  VirtualMitreCBox.enabled := pwd1 or pwd2;
  DesignOrderCBox.enabled := pwd1 or pwd2;
  UseSwageCBox.enabled := pwd1 or pwd2;
  Service2cbox.enabled := pwd1 or pwd2;
  trussjointgap.enabled := pwd1 or pwd2;
  trussHoledistanceedit.enabled := pwd1 or pwd2;
  trusscopetoledit.enabled := pwd1 or pwd2;
  trussminimizecbox.enabled := pwd1 or pwd2;
  trussMinimizeBCCBox.enabled := pwd1 or pwd2;
  trussSpecConCBox.enabled := pwd1 or pwd2;
  trussScrewsCBox.enabled := pwd1 or pwd2;
  trussWeb2webCBox.enabled := pwd1 or pwd2;
  lblPanelHoleDist.enabled := pwd1 or pwd2;
  lblPanelJointGap.enabled := pwd1 or pwd2;
  Label57.enabled := pwd1 or pwd2;
  lbTrussNotchToLip.enabled := pwd1 or pwd2;
  lbTrussFHtoLipH.enabled := pwd1 or pwd2;
  lbTrussSwageTo.enabled := pwd1 or pwd2;
  Label19.enabled := pwd1 or pwd2;
  Label36.enabled := pwd1 or pwd2;

end;

procedure TFormSettings.WriteINI;                                    //steven
begin
  G_Settings.Logging_JobDetails  := uxRecordJobDetails.Checked;
  G_Settings.general_machinetype := sMachineType[machinetype];
  G_Settings.general_fontsize    := DisplayFontSize.text;
  G_Settings.general_sim         := uxSimulationMode.checked;
  G_Settings.general_metric      := RBMetric.checked;
  G_Settings.general_itemno      := ShowItemNoCBox.checked;
  G_Settings.general_drive       := Drivetype.text;
  SetDrive ( G_Settings.general_drive);
  G_Settings.general_warning     := WarnCBox.checked;
  G_Settings.general_comport     := EditRFComPort.text;
  G_Settings.general_com2port    := Com2Port.text;
  G_Settings.general_removeframes:= RemoveFrmCBox.checked;
  G_Settings.general_pause       := framepause.checked;
  G_Settings.Logging_LogPauseReason := uxPauseReason.Checked;
  G_Settings.Logging_AuditDetails := CheckBoxAuditDetails.Checked;

  G_Settings.general_rectangles  := RectanglesCBox.checked;
  G_Settings.general_chordweb    := SortChordWebCBox.checked;
  G_Settings.general_baudrate    := BaudCBox.text;
  G_Settings.general_oppause     := OpPauseEdit.text;
  G_Settings.general_label       := LabelPrintCBox.checked;
  G_Settings.general_BoxRF       := TwinRFCBox.checked;
  If assigned(RollFormer) then
    G_Settings.general_MachineID   := RollFormer.MintSerialNumber;
  G_Settings.general_MachineName := Edit_MachineName.Text;
  G_Settings.general_SiteID     := Site_ID;
  G_Settings.general_SiteName   := SiteName;
  {truss rollformer}
  G_Settings.trussrf_chordweb   := SortChordWebCBox.checked;
  G_Settings.general_IsConnectToServer := CheckBoxIsConnectToServer.Checked;
  G_Settings.general_Server            := EditServer.Text;
  G_Settings.general_Port              := EditPort.Text;

  if (MachineType=mt75mmTruss) then
  begin
    G_Settings.trussrf_CutToNotch          := uxTrussCutToNotch.text;
    G_Settings.trussrf_CopeToNotch         := uxTrussCopeToNotch.text;
    G_Settings.trussrf_SwageToNotch75      := uxTrussSwageToNotch.text;
    G_Settings.trussrf_LipHoleToNotch      := uxTrussLipHoleToNotch.text;
    G_Settings.trussrf_SwageSize75         := uxTrussSwageSize.text;
    G_Settings.trussrf_FlangeHoleToLipHole75 := uxTruss3inFHtoLipH.text;
    G_Settings.trussrf_lhole2fhole           := uxTruss3inFHtoLipH.text;
  end;

  if (MachineType=mtTruss) then
  begin
    G_Settings.trussrf_c2fhole      := uxTrussCutToLip.text;
    G_Settings.trussrf_cope2fhole   := uxTrussCopeToLip.text;
    G_Settings.trussrf_n2fhole      := uxTrussNotchToLip.text;
    G_Settings.trussrf_lhole2fhole  := uxTrussFHtoLipH.text;
  end;

  G_Settings.trussrf_notchsize      := trussnotchsizeedit.text;
  G_Settings.trussrf_copesize       := trusscopesizeedit.text;
  G_Settings.trussrf_cutwidth       := trusscutwidthEdit.text;
  G_Settings.trussrf_precamber      := trussprecamberedit.text;
  G_Settings.trussrf_autopc         := TrussAutoPCCBox.checked;
  G_Settings.trussrf_dblnotch       := TrussDblNotchCB.checked;

  {box rollformer}
  G_Settings.boxrf_boxc2hole        := BoxCut2holeEdit.text;
  G_Settings.boxrf_boxcutwidth      := BoxCutWidthEdit.text;

  {panel rollformer}
  G_Settings.panelrf_cut2flat          := PanelCut2Flat.text;
  G_Settings.panelrf_hole2flat         := PanelHole2Flat.text;
  G_Settings.panelrf_holeM2diffhorz    := PanelHoleDiffHorz.text;
  G_Settings.panelrf_holeM2diffvert    := PanelHoleDiffHeight.text;
  G_Settings.panelrf_notch2flat        := PanelNotch2Flat.text;
  G_Settings.panelrf_service2flat      := PanelService2Flat.text;
  G_Settings.panelrf_service22flat     := PanelService22Flat.text;
  G_Settings.panelrf_EndBrgNotchToFlat := uxPanelEndBrgToFlat.text;
  G_Settings.panelrf_EndBrgNotchSize   := uxPanelEndBrgSize.text;
  G_Settings.panelrf_swage2flat        := PanelSwage2Flat.text;
  G_Settings.panelrf_cutwidth          := PanelCutWidth.text;
  G_Settings.panelrf_flatsize          := PanelFlatSize.text;
  G_Settings.panelrf_notchsize         := PanelNotchSize.text;
  G_Settings.panelrf_swagesize         := PanelSwageToolLen.text;
  G_Settings.panelrf_notchtol          := PanelNotchTol.text;
  G_Settings.panelrf_precamber         := PanelPreCamber.text;
  G_Settings.panelrf_mholeheight       := PanelHoleHeight.text;
  {truss profile}
  G_Settings.trussprofile_lipholeheight:= uxLipHoleHeight.text;
  G_Settings.trussprofile_flangelipholediff:= uxFlangeLipHoleVDiff.text;
  G_Settings.trussprofile_gauge:= trussGaugeEdit.text;
  G_Settings.trussprofile_profileheight:= trussprofileedit.text;
  G_Settings.trussprofile_lipsize:= trussLipsizeEdit.text;
  G_Settings.trussprofile_holesize:= TrussHoleSizeEdit.text;
  {panel profile}
  G_Settings.panelprofile_lipsize:= PanelLipSize.text;
  G_Settings.panelprofile_holeheight:= PanelHoleHeight.text;
  G_Settings.panelprofile_holeMheight:= PanelHoleHeight.text;
  G_Settings.panelprofile_holesize:= PanelHoleSize.text;
  G_Settings.panelprofile_profileheight:= PanelprofileHeight.text;
  {truss structure}
  G_Settings.tstructure_buttgap:= trussjointgap.text;
  G_Settings.tstructure_holedist:= trussHoledistanceedit.text;
  G_Settings.tstructure_tolerance:= trusscopetoledit.text;
  G_Settings.tstructure_minimize:= trussminimizecbox.checked;
  G_Settings.tstructure_specialcons:= trussSpecConCBox.checked;
  G_Settings.tstructure_minimizeBC:= trussMinimizeBCCBox.checked;
  G_Settings.tstructure_web2web:= trussWeb2webCBox.checked;
  G_Settings.tstructure_screws:= trussScrewsCBox.checked;
  {panel structure}
  G_Settings.Pstructure_service2:= Service2cbox.checked;
  G_Settings.Pstructure_jointgap:= PanelJointGap.text;
  G_Settings.Pstructure_verticalgap:= PanelVertJointGap.text;
  G_Settings.Pstructure_minholedist:= PanelMinHoleDist.text;
  G_Settings.Pstructure_swage:= UseSwageCBox.checked;
  G_Settings.Pstructure_showservice:= PanelShowServicesCBox.checked;
  G_Settings.Pstructure_ignoremindistance:= PanelIgnoreHoleDistErrCBox.checked;
  G_Settings.Pstructure_virtualmitre:= VirtualMitreCBox.checked;

  {inkjet printer}

  G_Settings.inkprinter_Type := rgInkPrinter.ItemIndex;

  InkJetMaster.PrinterType := self.InkJetType ;
  G_Settings.inkprinter_Device:= InkJetMaster.PrinterTypeAsString;
  G_Settings.inkprinter_frmcode:= FCodecbox.checked;
  G_Settings.inkprinter_idescr:= IDescrCBox.checked;
  G_Settings.inkprinter_chrlen:= chrlength.text;
  G_Settings.inkprinter_headpos:= headpos.text;
  G_Settings.inkprinter_job:= editjob.text;
  G_Settings.inkprinter_logo:= LogoEdit.text;
  G_Settings.inkprinter_logoOn:= LogoCBox.checked;
  G_Settings.inkprinter_inkbaudrate:= InkBaudDropBox.text;
  G_Settings.inkprinter_inkIP:= InkIPEdit.text;
  G_Settings.inkprinter_inkserial:= InkSerialEdit.text;

  {printer}
  G_Settings.printer_fontsize:= FontSizeEdit.text;
  G_Settings.printer_prtradius:= prtradiusedit.text;
  G_Settings.printer_bearingsize:= bearingsizeedit.text;
  G_Settings.printer_braces:= BraceCBox.checked;
  G_Settings.printer_labels:= ItemLabelRG.itemindex;
  G_Settings.printer_service:= PrtServicecBox.checked;
  G_Settings.printer_orientation:= PrinterRG.itemindex;
  G_Settings.printer_multiprt:= MultiPrtCBox.checked;
  G_Settings.printer_websize:= websizecbox.checked;
  G_Settings.printer_prtfilepath:= prtfilepathcbox.checked;
  G_Settings.printer_orientcolour:= ColourCBox.checked;
  {miscellaneous}
  G_Settings.misc_power:= PowercBox.checked;
  G_Settings.misc_current:= CurrentEdit.text;
  G_Settings.misc_comms:= CommsMessageCBox.checked;
  G_Settings.misc_USAjoint:= USJointCBox.checked;
  {label printing}
  G_Settings.label_job:= LabelJobEdit.text;
  G_Settings.label_font:= LabelFontEdit.text;
  G_Settings.label_printer:= labelprinteredit.text;

  {Counter}
  G_Settings.Counter_TrussCut                := StrToIntDef(uxTrussCutCounter.uxWarning.Text, 10000);
  G_Settings.Counter_TrussCope               := StrToIntDef(uxTrussCopeCounter.uxWarning.Text, 10000);
  G_Settings.Counter_TrussNotch              := StrToIntDef(uxTrussNotchCounter.uxWarning.Text, 10000);
  G_Settings.Counter_TrussLipPunch           := StrToIntDef(uxTrussLipPunchCounter.uxWarning.Text, 10000);
  G_Settings.Counter_TrussFlangePunch        := StrToIntDef(uxTrussFlangePunchCounter.uxWarning.Text, 10000);
  G_Settings.Counter_PanelCut                := StrToIntDef(CounterFrameCut.uxWarning.Text, 10000);
  G_Settings.Counter_PanelService1s          := StrToIntDef(CounterFrameService1s.uxWarning.Text, 10000);
  G_Settings.Counter_PanelService2s          := StrToIntDef(CounterFrameService2s.uxWarning.Text, 10000);
  G_Settings.Counter_PanelNotches            := StrToIntDef(CounterFrameNotches.uxWarning.Text, 10000);
  G_Settings.Counter_PanelLipPunch           := StrToIntDef(CounterFrameLipPunch.uxWarning.Text, 10000);
  G_Settings.Counter_PanelFlangePunch        := StrToIntDef(CounterFrameFlangePunch.uxWarning.Text, 10000);
  G_Settings.Counter_PanelFlatenPunch        := StrToIntDef(CounterFrameFlatenPunch.uxWarning.Text, 10000);
  G_Settings.Counter_PanelEndingBearingNotch := StrToIntDef(CounterFrameEndingBearingNotch.uxWarning.Text, 10000);
end;


function SetPrinter(const PrinterName: String): boolean;
var
  s2: string;
  dum1: PChar;
  xx, qq: integer;
const
  cs1: PChar = 'Windows';
  cs2: PChar = 'Device';
  cs3: PChar = 'Devices';
  cs4: PChar = #0;

begin
  xx := 254;
  GetMem(dum1, xx);
  result := false;
  try
    qq := GetProfileString(cs3, PChar(PrinterName), #0, dum1, xx);
    if (qq > 0) and (trim(strpas(dum1)) <> '') then
    begin
      s2 := PrinterName + ',' + strpas(dum1);
      while GetProfileString(cs1, cs2, cs4, dum1, xx) > 0 do
        WriteProfileString(cs1, cs2, #0);
      WriteProfileString(cs1, cs2, PChar(s2));
      case Win32Platform of
        VER_PLATFORM_WIN32_NT: ;
        // SendMessage( HWND_BROADCAST, WM_WININICHANGE, 0, LongInt(cs1));
        // VER_PLATFORM_WIN32_WINDOWS :
        // SendMessage( HWND_BROADCAST, WM_SETTINGCHANGE, 0, LongInt(cs1));
      end;
      result := true;
    end;
  finally
    FreeMem(dum1);
  end;
end;

procedure TFormSettings.ReadINI;                                     //steven
begin
    {general}
    settingfile.Text := G_Settings.RFSSettingFile;
    SetMachineType(G_Settings.general_machinetype);
    DisplayFontSize.text     := G_Settings.general_fontsize;
    uxSimulationMode.checked := G_Settings.general_sim;
    RBMetric.checked         := G_Settings.general_metric; // default to metric if not found
    RBImperial.checked       := Not G_Settings.general_metric;
    ShowItemNoCBox.checked   := G_Settings.general_itemno;   // unused
    SetDrive ( G_Settings.general_drive);
    WarnCBox.checked         := G_Settings.general_warning;
    EditRFComPort.text       := G_Settings.general_comport;
    RemoveFrmCBox.checked    := G_Settings.general_removeframes;
    Com2Port.text            := G_Settings.general_com2port;
    framepause.checked       := G_Settings.general_pause;
    uxPauseReason.Checked    := G_Settings.Logging_LogPauseReason;
    RectanglesCBox.checked   := G_Settings.general_rectangles;
    BaudCBox.text            := G_Settings.general_baudrate;
    OpPauseEdit.text         := G_Settings.general_oppause;
    LabelPrintCBox.checked   := G_Settings.general_label;
    TwinRFCBox.checked       := G_Settings.general_BoxRF;
    uxRecordJobDetails.Checked   := G_Settings.Logging_JobDetails;
    CheckBoxAuditDetails.Checked := G_Settings.Logging_AuditDetails;

    CheckBoxIsConnectToServer.Checked := G_Settings.general_IsConnectToServer;
    GroupBoxServer.Visible := G_Settings.general_IsConnectToServer;
    EditServer.Text        := G_Settings.general_Server;
    EditPort.Text          := G_Settings.general_Port;

    {truss rollformer}
    SortChordWebCBox.checked := G_Settings.trussrf_chordweb;
    // 3" Truss
    begin
    uxTrussCutToNotch.text     := G_Settings.trussrf_CutToNotch;
    uxTrussCopeToNotch.text    := G_Settings.trussrf_CopeToNotch;
    uxTrussLipHoleToNotch.text := G_Settings.trussrf_LipHoleToNotch;
    uxTrussSwageToNotch.text   := G_Settings.trussrf_SwageToNotch75;
    uxTruss3inFHtoLipH.text    := G_Settings.trussrf_FlangeHoleToLipHole75;
    uxTrussSwageSize.text      := G_Settings.trussrf_SwageSize75;

    end;
    // 2" Truss
    begin
      uxTrussCutToLip.text   := G_Settings.trussrf_c2fhole;
      uxTrussCopeToLip.text  := G_Settings.trussrf_cope2fhole;
      uxTrussNotchToLip.text := G_Settings.trussrf_n2fhole;
      uxTrussFHtoLipH.text   := G_Settings.trussrf_lhole2fhole;
    end;
    trussnotchsizeedit.text := G_Settings.trussrf_notchsize;
    trusscopesizeedit.text  := G_Settings.trussrf_copesize;
    trusscutwidthEdit.text  := G_Settings.trussrf_cutwidth;
    trussprecamberedit.text := G_Settings.trussrf_precamber;
    TrussAutoPCCBox.checked := G_Settings.trussrf_autopc;
    TrussDblNotchCB.checked := G_Settings.trussrf_dblnotch;
    {box rollformer}
    BoxCut2holeEdit.text := G_Settings.boxrf_boxc2hole;
    BoxCutWidthEdit.text := G_Settings.boxrf_boxcutwidth;
    {panel rollformer}
    PanelCut2Flat.text       := G_Settings.panelrf_cut2flat;
    PanelHole2Flat.text      := G_Settings.panelrf_hole2flat;
    PanelHoleDiffHorz.text   := G_Settings.panelrf_holeM2diffhorz;
    PanelHoleDiffHeight.text := G_Settings.panelrf_holeM2diffvert;
    PanelNotch2Flat.text     := G_Settings.panelrf_notch2flat;
    PanelService2Flat.text   := G_Settings.panelrf_service2flat;
    PanelService22Flat.text  := G_Settings.panelrf_service22flat;
    uxPanelEndBrgToFlat.text := G_Settings.panelrf_EndBrgNotchToFlat;
    uxPanelEndBrgSize.text   := G_Settings.panelrf_EndBrgNotchSize;
    PanelSwage2Flat.text     := G_Settings.panelrf_swage2flat;
    PanelCutWidth.text       := G_Settings.panelrf_cutwidth;
    PanelFlatSize.text       := G_Settings.panelrf_flatsize;
    PanelNotchSize.text      := G_Settings.panelrf_notchsize;
    PanelSwageToolLen.text   := G_Settings.panelrf_swagesize;
    PanelNotchTol.text       := G_Settings.panelrf_notchtol;
    PanelPreCamber.text      := G_Settings.panelrf_precamber;
    PanelHoleHeight.text     := G_Settings.panelrf_mholeheight;
    {truss profile}
    uxLipHoleHeight.text      := G_Settings.trussprofile_lipholeheight;
    uxFlangeLipHoleVDiff.text := G_Settings.trussprofile_flangelipholediff;
    trussGaugeEdit.text       := G_Settings.trussprofile_gauge;
    trussprofileedit.text     := G_Settings.trussprofile_profileheight;
    trussLipsizeEdit.text     := G_Settings.trussprofile_lipsize;
    TrussHoleSizeEdit.text    := G_Settings.trussprofile_holesize;
    {panel profile}
    PanelLipSize.text         := G_Settings.panelprofile_lipsize;
    PanelHoleHeight.text      := G_Settings.panelprofile_holeheight;
    PanelHoleSize.text        := G_Settings.panelprofile_holesize;
    PanelprofileHeight.text   := G_Settings.panelprofile_profileheight;
    {truss structure}
    trussjointgap.text          := G_Settings.tstructure_buttgap;
    trussHoledistanceedit.text  := G_Settings.tstructure_holedist;
    trusscopetoledit.text       := G_Settings.tstructure_tolerance;
    trussminimizecbox.checked   := G_Settings.tstructure_minimize;
    trussSpecConCBox.checked    := G_Settings.tstructure_specialcons;
    trussMinimizeBCCBox.checked := G_Settings.tstructure_minimizeBC;
    trussWeb2webCBox.checked    := G_Settings.tstructure_web2web;
    trussScrewsCBox.checked     := G_Settings.tstructure_screws;
    {panel structure}
    // stud service hole memo lines
    Service2cbox.checked               := G_Settings.Pstructure_service2;
    PanelJointGap.text                 := G_Settings.Pstructure_jointgap;
    PanelVertJointGap.text             := G_Settings.Pstructure_verticalgap;
    PanelMinHoleDist.text              := G_Settings.Pstructure_minholedist;
    UseSwageCBox.checked               := G_Settings.Pstructure_swage;
    DesignOrderCBox.checked            := G_Settings.Pstructure_designorder;
     PanelShowServicesCBox.checked     := G_Settings.Pstructure_showservice;
    PanelIgnoreHoleDistErrCBox.checked := G_Settings.Pstructure_ignoremindistance;
    VirtualMitreCBox.checked           := G_Settings.Pstructure_virtualmitre;
    {inkjet printer}
    FCodecbox.checked  := G_Settings.inkprinter_frmcode;
    IDescrCBox.checked := G_Settings.inkprinter_idescr;
    chrlength.text     := G_Settings.inkprinter_chrlen;
    headpos.text       := G_Settings.inkprinter_headpos;
    editjob.text       := G_Settings.inkprinter_job;
    LogoEdit.text      := G_Settings.inkprinter_logo;
    LogoCBox.checked   := G_Settings.inkprinter_logoOn;

    rgInkPrinter.ItemIndex :=ord(G_Settings.inkprinter_Type);

    InkBaudDropBox.text := G_Settings.inkprinter_inkbaudrate;
    InkIPEdit.text      := G_Settings.inkprinter_inkIP;
    InkSerialEdit.text  := G_Settings.inkprinter_inkserial;

    prtradiusedit.text      := G_Settings.printer_prtradius;
    FontSizeEdit.text       := G_Settings.printer_fontsize;
    bearingsizeedit.text    := G_Settings.printer_bearingsize;
    BraceCBox.checked       := G_Settings.printer_braces;
    ItemLabelRG.itemindex   := G_Settings.printer_labels;
    PrtServicecBox.checked  := G_Settings.printer_service;
    PrinterRG.itemindex     := G_Settings.printer_orientation;
    MultiPrtCBox.checked    := G_Settings.printer_multiprt;
    websizecbox.checked     := G_Settings.printer_websize;
    prtfilepathcbox.checked := G_Settings.printer_prtfilepath;
    ColourCBox.checked      := G_Settings.printer_orientcolour;
    {miscellaneous}
    PowercBox.checked        := G_Settings.misc_power;
    CurrentEdit.text         := G_Settings.misc_current;
    CommsMessageCBox.checked := G_Settings.misc_comms;
    USJointCBox.checked      := G_Settings.misc_USAjoint;
    Edit_MachineName.Text    := G_Settings.general_MachineName;
    {label printing}
    LabelJobEdit.text  := G_Settings.label_job;
    LabelFontEdit.text := G_Settings.label_font;
    labelprinteredit.text     := G_Settings.label_printer;
    {update fields}
    PanelHoleHgtLabel.caption := PanelHoleHeight.text;
  {set any globals}
  bRequire2PtWebToWeb := G_Settings.tstructure_web2web;
  bUseBoxwebbing := TwinRFCBox.checked;
  if LabelPrintCBox.checked and (labelprinteredit.text <> '') then
  begin
    if not SetPrinter(pchar(labelprinteredit.text)) then
      showmessage('Label printer not set');
  end;
//  bUSJointing := USJointCBox.checked;
end;

function TFormSettings.InkJetType: TInkjetType;
begin
  result := TInkjetType(rgInkPrinter.ItemIndex);
end;

procedure TFormSettings.rgInkPrinterClick(Sender: TObject);
begin
  case InkjetType of      // selected IJP on settings form
    ijpNone:  HideAll;
    dod2002:  RBDoD2002Click(nil);
    sx32:     RBsx32Click(nil);
    videojet: RBVideoJetClick(nil);
    sojet:    RBSojetClick(nil);
  end;
end;

procedure TFormSettings.RBVideoJetClick(Sender: TObject);
begin
  InkBtn.Visible := false;
  CleanBtn.Visible := false;
  FlushBtn.Visible := false;
  SetDefaultsBtn.Visible := false;
  SetHeadPosBtn.Visible := false;
  Label29.Visible := false;
  Label30.Visible := false;
  Label83.Visible := false;
  Label84.Visible := false;
  Label86.Visible := false;
  LogoEdit.Visible := false;
  Label16.Visible := false;
  chrlength.Visible := false;
  headpos.Visible := false;
  SendBtn.Visible := false;
  Edit2.Visible := false;
  LogoCBox.Visible := false;
  Label99.Visible := false;
  Label31.Visible := false;
  InkIPEdit.Visible := false;
  InkSerialEdit.Visible := false;
  Label28.Visible := true;
  Label12.Visible := true;
  Com2Port.Visible := true;
  InkBaudDropBox.Visible := true;
end;

procedure TFormSettings.RBDoD2002Click(Sender: TObject);
begin
  InkBtn.Visible := true;
  CleanBtn.Visible := true;
  FlushBtn.Visible := true;
  SetDefaultsBtn.Visible := true;
  SetHeadPosBtn.Visible := true;
  Label29.Visible := true;
  Label30.Visible := true;
  Label83.Visible := true;
  Label84.Visible := true;
  Label16.Visible := true;
  chrlength.Visible := true;
  headpos.Visible := true;
  SendBtn.Visible := true;
  Edit2.Visible := true;
  InkBtn.Visible := false;
  CleanBtn.Visible := false;
  Label86.Visible := true;
  LogoEdit.Visible := true;
  LogoCBox.Visible := true;
  Label28.Visible := true;
  Label12.Visible := true;
  Com2Port.Visible := true;
  InkBaudDropBox.Visible := true;
  Label99.Visible := false;
  Label31.Visible := false;
  InkIPEdit.Visible := false;
  InkSerialEdit.Visible := false;
end;

procedure TFormSettings.RBSojetClick(Sender: TObject);
begin
  InkBtn.Visible := false;
  CleanBtn.Visible := false;
  FlushBtn.Visible := false;
  SetDefaultsBtn.Visible := false;
  SetHeadPosBtn.Visible := false;
  Label29.Visible := false;
  Label30.Visible := True;
  Label83.Visible := true;
  Label84.Visible := true;
  Label86.Visible := false;
  LogoEdit.Visible := false;
  Label16.Visible := True;
  chrlength.Visible := True;
  headpos.Visible := true;
  SendBtn.Visible := false;
  Edit2.Visible := false;
  LogoCBox.Visible := false;
  Label28.Visible := false;
  Label12.Visible := false;
  Com2Port.Visible := false;
  InkBaudDropBox.Visible := false;
  Label99.Visible := true;
  Label31.Visible := true;
  InkIPEdit.Visible := true;
  InkSerialEdit.Visible := true;
end;

procedure TFormSettings.HideAll;
begin
  InkBtn.Visible := false;
  CleanBtn.Visible := false;
  FlushBtn.Visible := false;
  SetDefaultsBtn.Visible := false;
  SetHeadPosBtn.Visible := false;
  Label29.Visible := false;
  Label30.Visible := True;
  Label83.Visible := true;
  Label84.Visible := false;
  Label86.Visible := false;
  LogoEdit.Visible := false;
  Label16.Visible := false;
  chrlength.Visible := True;
  headpos.Visible := true;
  SendBtn.Visible := false;
  Edit2.Visible := false;
  LogoCBox.Visible := false;
  Label28.Visible := false;
  Label12.Visible := false;
  Com2Port.Visible := false;
  InkBaudDropBox.Visible := false;
  Label99.Visible := false;
  Label31.Visible := false;
  InkIPEdit.Visible := false;
  InkSerialEdit.Visible := false;
end;

procedure TFormSettings.RBsx32Click(Sender: TObject);
begin
  InkBtn.Visible := true;
  CleanBtn.Visible := true;
  FlushBtn.Visible := true;
  SetDefaultsBtn.Visible := true;
  SetHeadPosBtn.Visible := true;
  Label29.Visible := true;
  Label30.Visible := true;
  Label83.Visible := true;
  Label84.Visible := true;
  Label16.Visible := true;
  chrlength.Visible := true;
  headpos.Visible := true;
  SendBtn.Visible := true;
  Edit2.Visible := true;
  InkBtn.Visible := true;
  CleanBtn.Visible := true;
  Label86.Visible := true;
  LogoEdit.Visible := true;
  LogoCBox.Visible := true;
  Label99.Visible := false;
  Label31.Visible := false;
  InkIPEdit.Visible := false;
  InkSerialEdit.Visible := false;
  Label28.Visible := true;
  Label12.Visible := true;
  Com2Port.Visible := true;
  InkBaudDropBox.Visible := true;
end;

procedure TFormSettings.WaitSecs(t: word);
//* pause for t secs
begin
  Timer2Tick := 0;
  Timer2.enabled := true;
  repeat
    application.processmessages;
  until Timer2Tick >= t;
  Timer2.enabled := false;
end;

procedure TFormSettings.SendIJPCommand(cmd: string; wfr: boolean; AWaitSecs: uInt8);
//* send configuration command to an inkjet printer (NOT for sojet)
begin
  if not InkJetMaster.SendPrintCommand(cmd, wfr) then // ignored for sojet
    raise EIJPSetupError.Create(cmd,  InkJetMaster.status1);
  if AWaitSecs > 0 then
    WaitSecs(AWaitSecs)
end;

procedure TFormSettings.CheckBoxIsConnectToServerClick(Sender: TObject);
begin
  GroupBoxServer.Visible := CheckBoxIsConnectToServer.Checked;
end;

procedure TFormSettings.CleanBtnClick(Sender: TObject);
begin
  SendIJPCommand('CLEANER', true );
end;

procedure TFormSettings.Edit_MachineNameChange(Sender: TObject);
begin
  G_Settings.general_MachineName :=  Edit_MachineName.Text;
end;

procedure TFormSettings.uxFlangeLipHoleVDiffChange(Sender: TObject);
//*Updates a read-only label if Hole height is changed
begin
  try
    FlangeHgtLabel.caption := ToolUnitsOut(floattostr(strtofloat(ToolUnitsIn(uxLipHoleHeight.text)) - strtofloat(ToolUnitsIn(uxFlangeLipHoleVDiff.text))));
  except
    FlangeHgtLabel.caption := '?';
  end;
end;

procedure TFormSettings.FlushBtnClick(Sender: TObject);
begin {flush printer}
  if InkJetMaster.PrinterType = dod2002 then
    SendIJPCommand('F1', true )
  else if InkJetMaster.PrinterType = sx32 then
    SendIJPCommand('FLUSH[0] =300', true );
end;

procedure TFormSettings.SendBtnClick(Sender: TObject);
//*Send the entered command string using a form1 routine
begin
  SendIJPCommand(Edit2.text, true);
end;

procedure TFormSettings.SerialBtnClick(Sender: TObject);
//*Reads registry serial port values
begin
  TPortListForm.Exec;
end;

procedure TFormSettings.SetDefaultsBtnClick(Sender: TObject);
//*Sends initial configuration commands
//*These are stored in non-volitile memory inside the prtr controller.
var
  logowidth: integer;
  ts: string;
begin
  try
    Screen.Cursor := crHourglass;
    if InkJetMaster.PrinterType = dod2002 then
    begin {setup dod2002a controller with default values}
      SendIJPCommand('EM:-', false, 4); {select ack / nak reply}
      SendIJPCommand('SE:+', true); {select speed encoder}
      SendIJPCommand('DS:3000', true);{select dot size}
      SendIJPCommand('RE:75', true); {select horz speed ratio for 5000 ppr}
      SendIJPCommand('SM:00', true);{select buffer for printing}
      SendIJPCommand('NN:1*7', true); {select single print head}
    end
    else if InkjetType = sx32 then
    begin {setup sx32 controller with default values}
      //showmessage('sx32');
      SendIJPCommand('SP CONFIG = 5', true, 1);
      SendIJPCommand('SP DOTSIZE = 150', true, 1);
      SendIJPCommand('SP ENCFACT = 23000', true, 1);
      SendIJPCommand('SP ENCMODE = 1', true, 1) ;
      SendIJPCommand('SP PRINTHT = 30', true, 1);
      SendIJPCommand('SP TILTASP = 3', true, 1);
      SendIJPCommand('SP TRIGEND = 0', true, 1);
      SendIJPCommand('SP TRIGMODE = 0', true, 1);
      SendIJPCommand('SP UPDMODE = 0', true, 1);
      SendIJPCommand('SP PRINTDIR[0] = 1', true, 1);
      SendIJPCommand('ST[0] ="Scottsdale", SIZE = 16', true, 1);

      if LogoCBox.checked then // Configure sx32 for graphics object plus text
      begin // Use Graphics object no. 24
        SendIJPCommand('SG[24] = "' + LogoEdit.text + '", SIZE = 16', true, 1);
        logowidth := length(LogoEdit.text) div 2;
        ts := trim(IntToStr(logowidth));
        SendIJPCommand('SM[0] = ((G[24]@ 0:0),(T[0]@ ' + ts + ':0))', true, 1);
      end
      else // configure sx32 for text object only
      begin
        SendIJPCommand('SM[0] = ((T[0]@ 0:0))', true, 1);
      end;
      SendIJPCommand('SP MSGNUM[0] = 0', true,1);
    end;
    Screen.Cursor := crDefault;
    showmessage(InkJetMaster.PrinterTypeAsString+' Configured OK.')
  except
    on e: exception do
    begin
      Screen.Cursor := crDefault;
      showmessage(InkJetMaster.PrinterTypeAsString+' Configuration Failed.'+e.message)
    end;
  end;
end;

procedure TFormSettings.SetHeadPosBtnClick(Sender: TObject);
//*Sets head position as no of print columns after rcvg printNow command.
//*This allows users to move printing past notches at the start of a member
var ts:string; numcols: real; mm: integer;
begin
  if InkJetMaster.PrinterType = dod2002 then
  begin
    if strtofloat(headpos.text) < 0 then
      SendIJPCommand('D1:1', true) {set prt delay to 1 column}
    else
    begin {set columns for head infront of service. Allow for poss. start notch}
      numcols :=(6 *(strtofloat(headpos.text)))/ strtofloat(chrlength.text);
      ts := trim(IntToStr(trunc(numcols))); {each chr is 5+1 columns}
      SendIJPCommand('D1:' + ts, true); {set prt delay to column}
    end;
  end
  else if InkJetMaster.PrinterType = sx32 then //sx32 - set margin
  begin
    mm := trunc(strtofloat(headpos.text)+ 50);
    ts := trim(IntToStr(mm));
    SendIJPCommand('SP MARGIN[0]= ' + ts, true);
  end;
end;

procedure TFormSettings.uxMachineTypeChange(Sender: TObject);
begin
  // truss settings
  TrussPanel.visible       := (MachineType=mtTruss);
  Truss75mmPanel.Visible   := (MachineType=mt75mmTruss);
  lbTrussSwageSize.Visible := (MachineType=mt75mmTruss);
  uxTrussSwageSize.Visible := (MachineType=mt75mmTruss);
  TwinRFCBox.Visible       := (MachineType=mt75mmTruss);
  TabBoxRf.TabVisible      := (MachineType=mt75mmTruss) and TwinRFCBox.checked;
  // HD panel settings
  if G_Settings.general_machinetype='PANELHD' then
  begin
    PanelHDSettings.visible :=True;
    CounterFrameEndingBearingNotch.Visible := True;
    CounterFrameFlatenPunch.Visible := True;
  end
  else
  begin
    PanelHDSettings.visible := False;
    CounterFrameEndingBearingNotch.Visible := False;
    CounterFrameFlatenPunch.Visible := False;
  end;
  CounterFrameFlangePunch.Visible   := not G_Settings.IsSingleRivet;
end;

procedure TFormSettings.LoadToolBtnClick(Sender: TObject);
//*Load tool settings from Panel RF
begin
{$ifdef Panel}
  if  (driveClass=tdcMint) and
      ((strtofloat(rollformer.Mintversion) >= 724) or ((strtofloat(rollformer.Mintversion) > 420) and
      (strtofloat(rollformer.Mintversion) < 500))) then
    with rollformer do
    begin
      PanelCut2Flat.text := Format('%5.2f',[getMintValue(mintCutTo)]);
      PanelHole2Flat.text   := Format('%5.2f',[getMintValue(mintHoleTo)]);
      PanelNotch2Flat.text := Format('%5.2f',[getMintValue(mintNotchTo)]);
      PanelService2Flat.text :=Format('%5.2f',[getMintValue(mintServiceToFlat)]);
      PanelService22Flat.text :=Format('%5.2f',[getMintValue(mintService2ToFlat)]);
      uxPanelEndBrgToFlat.text :=Format('%5.2f',[getMintValue(mintEndBrgNotchToFlat)]);
      uxPanelEndBrgSize.text :=Format('%5.2f',[getMintValue(mintEndBrgNotchSize)]);
      PanelSwage2Flat.text := Format('%5.2f',[getMintValue(mintSwageToFlat)]);
      PanelCutWidth.text := Format('%5.2f',[getMintValue(mintCutWidth)]);
      PanelFlatSize.text := Format('%5.2f',[getMintValue(mintFlatSize)]);
      PanelNotchSize.text := Format('%5.2f',[getMintValue(mintNotchSize)]);
      PanelSwageToolLen.text := Format('%5.2f',[getMintValue(mintSwageToolLen)]);
      PanelHoleHeight.text := Format('%5.2f',[getMintValue(mintHoleHeight)]);
      MessageBox(0, 'Settings Loaded', '', MB_OK);
    end
    else
      MessageBox(0, 'Tool settings not loaded', 'Warning ..', MB_OK);
{$ENDIF}
end;

procedure TFormSettings.SaveBoxToolBtnClick(Sender: TObject);
begin
  if (driveClass=tdcMint) and (strtofloat(rollformer.Mintversion) >= 635) and (strtofloat(rollformer.Mintversion) < 700) then
    with rollformer do
    begin
      BoxWeb := True;
      WriteCommsArray('13', BoxCut2holeEdit.text); WriteCommsArray('11', '21');
      repeat
        ReadCommsArray('11', false);
      until commdata = '0';
      WriteCommsArray('13', BoxCutWidthEdit.text); WriteCommsArray('11', '27');
      repeat
        ReadCommsArray('11', false);
      until commdata = '0';
      MessageBox(0, 'Settings Saved', '', MB_OK);
      BoxWeb := false;
    end
    else
      MessageBox(0, 'Tool settings not Saved', 'Warning ..', MB_OK);
end;

procedure TFormSettings.SaveToolBtnClick(Sender: TObject);
//*Save tool settings to Panel RF
begin
{$ifdef Panel}
  if  (driveClass=tdcMint) and
      ((strtofloat(rollformer.Mintversion) >= 724) or ((strtofloat(rollformer.Mintversion) > 420) and
      (strtofloat(rollformer.Mintversion) < 500))) then
    with Rollformer do
    begin
      BoxWeb := false;
      setMintString(mintCutTo,                    PanelCut2Flat.text);          // 21
      setMintString(mintHoleTo,                   PanelHole2Flat.text);         // 22
      setMintString(mintNotchTo,                  PanelNotch2Flat.text);        // 23
      setMintString(mintServiceToFlat,            PanelService2Flat.text);      // 24
      setMintString(mintService2ToFlat,           PanelService22Flat.text);     // 25
      setMintString(mintSwageToFlat,              PanelSwage2Flat.text);        // 26
      setMintString(mintCutWidth,                 PanelCutWidth.text);          // 27
      setMintString(mintFlatSize,                 PanelFlatSize.text);          // 28
      setMintString(mintNotchSize,                PanelNotchSize.text);         // 29
      setMintString(mintSwageToolLen,             PanelSwageToolLen.text);      // 30
      setMintString(mintHoleHeight,               PanelHoleHeight.text);        // 31
      setMintString(mintEndBrgNotchToFlat,        uxPanelEndBrgToFlat.text);    // 32
      setMintString(mintEndBrgNotchSize,          uxPanelEndBrgSize.text);      // 33
      MessageBox(0, 'Settings Saved', '', MB_OK);
    end
    else
      MessageBox(0, 'Tool settings not Saved', 'Warning ..', MB_OK);
{$endif}
end;

procedure TFormSettings.SaveTrussToolBtnClick(Sender: TObject);
//*Save Tool settings to Truss RF
begin
{$ifdef Truss}
  if  (driveClass=tdcMint) and
      (strtofloat(rollformer.Mintversion) >= 635) then
    with Rollformer do
    begin
      BoxWeb := false;
      if (MachineType=mt75mmTruss) then   // 3" Truss
      begin
        setMintString(mintCutTo,              uxTrussCutToNotch.text);          // 21
        setMintString(mintHoleTo,             uxTrussCopeToNotch.text);         // 22
        setMintString(mintNotchTo,            uxTrussLipHoleToNotch.text);      // 23
        setMintString(mintServiceToFlat,      uxTruss3inFHtoLipH.text);         // 24
        setMintString(mintSwageToolLen,       uxTrussSwageToNotch.text);        // 30
        setMintString(mintHoleHeight,         uxTrussSwageSize.text);           // 31
      end;
      if (MachineType=mtTruss) then      // 2" Truss
      begin
        setMintString(mintCutTo,                uxTrussCutToLip.text);          // 21
        setMintString(mintHoleTo,               uxTrussCopeToLip.text);         // 22
        setMintString(mintNotchTo,              uxTrussNotchToLip.text);        // 23
        setMintString(mintServiceToFlat,        uxTrussFHtoLipH.text);          // 24
      end;

      setMintString(mintService2ToFlat,         trusscutwidthEdit.text);        // 25
      setMintString(mintSwageToFlat,            trussnotchsizeedit.text);       // 26
      setMintString(mintCutWidth,               trusscopesizeedit.text);        // 27
      setMintString(mintFlatSize,               uxFlangeLipHoleVDiff.text);     // 28
      setMintString(mintNotchSize,              uxLipHoleHeight.text);          // 29
      setMintString(mintHoleHeight,             uxTrussSwageSize.text);         // 31
      MessageBox(0, 'Settings Saved', '', MB_OK);
    end
    else
      MessageBox(0, 'Tool settings not Saved', 'Warning ..', MB_OK);
{$ENDIF}
end;

procedure TFormSettings.LoadTrussToolBtnClick(Sender: TObject);
//*Load tool settings from Truss RF

begin
{$ifdef Truss}
  if (driveClass=tdcMint) and
     (strtofloat(rollformer.Mintversion) >= 635) then
    with rollformer do
    begin
      BoxWeb := false;
      if (MachineType=mt75mmTruss) then
      begin
        uxTrussCutToNotch.text      := Format('%5.2f',[getMintValue(mintCutTo)]);
        uxTrussCopeToNotch.text     := Format('%5.2f',[getMintValue(mintHoleTo)]);
        uxTrussLipHoleToNotch.text  := Format('%5.2f',[getMintValue(mintNotchTo)]);
        uxTrussSwageToNotch.text    := Format('%5.2f',[getMintValue(mintSwageToolLen)]);
        uxTruss3inFHtoLipH.text     := Format('%5.2f',[getMintValue(mintServiceToFlat)]);
        uxTrussSwageSize.text       := Format('%5.2f',[getMintValue(mintHoleHeight)]);
      end;
      if (MachineType=mtTruss) then      // 2" Truss
      begin
        uxTrussCutToLip.text      := Format('%5.2f',[getMintValue(mintCutTo)]);
        uxTrussCopeToLip.text     := Format('%5.2f',[getMintValue(mintHoleTo)]);
        uxTrussNotchToLip.text    := Format('%5.2f',[getMintValue(mintNotchTo)]);
        uxTrussFHtoLipH.text      := Format('%5.2f',[getMintValue(mintServiceToFlat)]);
      end;
      // Shared
      trusscutwidthEdit.text     := Format('%5.2f',[getMintValue(mintService2ToFlat)]);
      trussnotchsizeedit.text    := Format('%5.2f',[getMintValue(mintSwageToFlat)]);
      trusscopesizeedit.text     := Format('%5.2f',[getMintValue(mintCutWidth)]);
      uxFlangeLipHoleVDiff.text   := Format('%5.2f',[getMintValue(mintFlatSize)]);
      uxLipHoleHeight.text       := Format('%5.2f',[getMintValue(mintNotchSize)]);
      MessageBox(0, 'Settings loaded', '', MB_OK);
    end
    else
      MessageBox(0, 'Tool settings not loaded', 'Warning ..', MB_OK);
{$ENDIF}
end;

procedure TFormSettings.FormCreate(Sender: TObject);
//*Change form layout for panels or trusses
//*Enables or disables button etc for pwd protection
const
   sUserMachineType: array[TMachineType] of string =
                     ('Panel','HD (2mm) Panel','50mm (2") Truss','75mm (3") Truss');

begin
//  if sametext(getDomainName,'SCOTTSDALE') then
    DriveType.Items.Add('VIRTUAL'); // must be at the end to match tDrive enum
  PageControl1.ActivePageIndex := 0;
  uxMachineType.Items.Clear;
  tabLabelPrinting.Visible:=false;
  if bFrames then
  begin
    TabSheet2.TabVisible := false; TabSheet10.TabVisible := true;
    TabSheet3.TabVisible := false; TabSheet13.TabVisible := true;
    TabTrussCounters.TabVisible := false; TabPanelCounters.TabVisible := true;
    TabSheet6.TabVisible := false; TabSheet11.TabVisible := true;
    USJointCBox.Visible := false; // USA truss joint option
    TwinRFCBox.Visible := false;
    TabBoxRf.TabVisible := false;
    uxMachineType.AddItem (sUserMachineType[mtPanel], TObject(mtPanel));
    uxMachineType.AddItem (sUserMachineType[mtPanelHD], TObject(mtPanelHD));
    PanelHDSettings.BorderStyle := bsNone;       // border is design-time only
  end
  else
  begin
    TabSheet2.TabVisible := true; TabSheet10.TabVisible := false;
    TabSheet3.TabVisible := true; TabSheet13.TabVisible := false;
    TabTrussCounters.TabVisible := true; TabPanelCounters.TabVisible := false;
    TabSheet6.TabVisible := true; TabSheet11.TabVisible := false;
    USJointCBox.Visible := true;
    TwinRFCBox.Visible := true;
    TabBoxRf.TabVisible := true;
    uxMachineType.AddItem (sUserMachineType[mtTruss], TObject(mtTruss));
    uxMachineType.AddItem (sUserMachineType[mt75mmTruss], TObject(mt75mmTruss));
    Truss75mmPanel.Top := TrussPanel.Top;
    Truss75mmPanel.Left := TrussPanel.Left;
    TrussPanel.BorderStyle := bsNone;        // border is design-time only
    Truss75mmPanel.BorderStyle := bsNone;
  end;
  ReadINI;
  TabBoxRf.TabVisible := (MachineType=mt75mmTruss) and TwinRFCBox.checked;
  if Assigned(Rollformer) then
    Rollformer.VaComm1.devicename := EditRFComPort.text;
  EnablePwdProtection; // Set pwd buttons
  Edit_MachineName.Text := G_Settings.general_MachineName;
end;

procedure TFormSettings.bnReadPanelCountersClick(Sender: TObject);
begin
  Rollformer.ReadMachineCounters;
  UpdateCountersOnScreen(tabPanelCounters);
end;

procedure TFormSettings.bnReadTrussCountersClick(Sender: TObject);
begin
  Rollformer.ReadMachineCounters;
  UpdateCountersOnScreen(tabTrussCounters);
end;

procedure TFormSettings.UpdateCountersOnScreen(ATab: TTabSheet);
var
  aCtrl : TControl;
  I     : Integer;
begin
  For  I:= 0 to pred (ATab.Controlcount)  do
  begin
    aCtrl:=ATab.Controls [i];
    if aCtrl is TCounterFrame then
      TCounterFrame(aCtrl).UpdateUXCounters;
  end;
end;
procedure TFormSettings.UpdateCountersFromScreen(ATab: TTabSheet);
var
  aCtrl : TControl;
  I     : Integer;
begin
  For  I:= 0 to pred (ATab.Controlcount)  do
  begin
    aCtrl:=ATab.Controls [i];
    if aCtrl is TCounterFrame then
      TCounterFrame(aCtrl).UpdateCounters;
  end;
end;

procedure TFormSettings.edMachineIDKeyPress(Sender: TObject; var Key: Char);

begin
  if ansichar(Key) in ['=', '.', '''', '"'] then
    Key := #0;
end;

procedure TFormSettings.LoadBoxToolBtnClick(Sender: TObject);
begin
  if  (driveClass=tdcMint) and
      (strtofloat(rollformer.Mintversion) >= 635) and
      (strtofloat(rollformer.Mintversion) < 700) then
    with rollformer do
    begin
      BoxWeb := true;
      WriteCommsArray('12', '21');
      repeat
        ReadCommsArray('12', false);
      until commdata = '0';
      ReadCommsArray('13', true); BoxCut2holeEdit.text := Format('%5.2f',[strtofloat(commdata)]);
      WriteCommsArray('12', '27');
      repeat
        ReadCommsArray('12', false);
      until commdata = '0';
      ReadCommsArray('13', true); BoxCutWidthEdit.text := Format('%5.2f',[strtofloat(commdata)]);
      MessageBox(0, 'Settings loaded', '', MB_OK);
      BoxWeb := false;
    end
    else
      MessageBox(0, 'Tool settings not loaded', 'Warning ..', MB_OK);
end;

procedure TFormSettings.bnOpenClick(Sender: TObject);
//*Opens & loads new rfs file
begin
  if settingfile.text = '' then
    OpenDialog1.initialdir := extractfilepath(paramstr(0))
  else
    OpenDialog1.initialdir := extractfilepath(settingfile.text);
  if OpenDialog1.Execute then
  begin
    FreeAndNil(G_Settings);
    G_Settings := TRFSettings.Create(OpenDialog1.filename);
    ReadINI;
  end;
  if G_Settings.general_MachineName='' then
  begin
   ShowMessage('Machine Name Required');
   Edit_MachineName.Visible := True;
   Edit_MachineName.Enabled := True;
   Edit_MachineName.SetFocus;
  end
  else
    FormShow(nil);
end;

function GetScotRFDatabaseDirectory: String;
begin
  Result := GetSpecialFolderPath(CSIDL_APPDATA, False);
  if Result[Length(Result)] <> '\' then
    Result := Result + '\';
  Result := Result + ChangeFileExt('Scottsdale\ScotRFBak', '')+ '\';
  if not DirectoryExists(Result) then
    CreateDir(Result);
end;


procedure TFormSettings.bnSaveClick(Sender: TObject);
begin
  modalresult := mrNone;
  if not sametext(bnSave.caption, 'Close') then
  begin
    CopyFile(PChar(G_Settings.RFSSettingFile), PChar(GetScotRFDatabaseDirectory+G_Settings.RFSSettingFile+'.bak'), true);
    WriteINI;
    G_Settings.SaveSettings;
    SaveDialog1.Title := 'Save As';
    SaveDialog1.FileName := G_Settings.RFSSettingFile;
    if G_Settings.RFSSettingFile='' then
      SaveDialog1.InitialDir := GetCurrentDir
    else
      SaveDialog1.initialdir := extractfilepath(G_Settings.RFSSettingFile);
    SaveDialog1.Filter := 'RFS Settings File|*.rfs';
    SaveDialog1.DefaultExt := 'rfs';
    SaveDialog1.FilterIndex := 1;
    if SaveDialog1.Execute then
    begin
      CopyFile(PChar(G_Settings.RFSSettingFile), PChar(SaveDialog1.FileName), true);
      if G_Settings.RFSSettingFile<>SaveDialog1.FileName then
      begin
        DeleteFile(G_Settings.RFSSettingFile);
        CopyFile(PChar(GetScotRFDatabaseDirectory+G_Settings.RFSSettingFile+'.bak'), PChar(G_Settings.RFSSettingFile), true);
        DeleteFile(GetScotRFDatabaseDirectory+G_Settings.RFSSettingFile+'.bak');
        settingfile.text := SaveDialog1.FileName;
        FreeAndNil(G_Settings);
        G_Settings := TRFSettings.Create(SaveDialog1.FileName);
        ReadINI;
        if G_Settings.general_MachineName='' then
        begin
         ShowMessage('Machine Name Required');
         Edit_MachineName.Visible := True;
         Edit_MachineName.Enabled := True;
         Edit_MachineName.SetFocus;
        end
        else
          FormShow(nil);
        G_Settings.SaveSettings;
      end;
    end;
  end;
  modalresult := mrOK;
end;

procedure TFormSettings.bnCancelClick(Sender: TObject);
begin
  ReadINI;
end;

procedure TFormSettings.BtnPwd1Click(Sender: TObject);
begin
  pwd1 := InputPassword('Configuration Password', 'Please enter')  = 'Scot5';
  EnablePwdProtection;
end;

procedure TFormSettings.BtnPwd2Click(Sender: TObject);
begin
  pwd2 := InputPassword('Configuration Password', 'Please enter')  = 'jointing';
  EnablePwdProtection;
end;

procedure TFormSettings.Button1Click(Sender: TObject);
var ts:string;
begin
  ts := HoleAutoJoinAdjustStr;
  if pos('unknown', ts)> 0 then
    ts := '??';
  Button1.caption := Format('Sim version: %s, HoleAuto: %s', [JOINING_VERSION, ts]);
end;

procedure TFormSettings.TrussAutoPCCBoxClick(Sender: TObject);
//*Truss auto pre-camber click event
begin
  trussprecamberedit.enabled :=not TrussAutoPCCBox.checked;
end;

procedure TFormSettings.TwinRFCBoxClick(Sender: TObject);
begin
  TabBoxRf.TabVisible := (MachineType=mt75mmTruss) and TwinRFCBox.checked;
end;

procedure TFormSettings.FormShow(Sender: TObject);
//*On showing this form
begin
  trussprecamberedit.enabled :=not TrussAutoPCCBox.checked;

  if not G_Settings.general_metric then
  begin
    DBGridDateInfo.Columns[2].Title.Caption := 'Origin FT';
    DBGridDateInfo.Columns[3].Title.Caption := 'Remain FT';
    DBGridDateInfo.Columns[6].Title.Caption := 'Feet';
  end
  else
    begin
    DBGridDateInfo.Columns[2].Title.Caption := 'Origin Meters';
    DBGridDateInfo.Columns[3].Title.Caption := 'Remain Meters';
    DBGridDateInfo.Columns[6].Title.Caption := 'Meters';
  end;
  {$ifdef Panel}

  // HD panel settings
  if G_Settings.general_machinetype='PANELHD' then
  begin
    PanelHDSettings.visible :=True;
    CounterFrameFlangePunch.Visible        := True;
  end
  else
  begin
    PanelHDSettings.visible := False;
    CounterFrameFlangePunch.Visible        := False;
  end;
  CounterFrameFlangePunch.Visible        := not G_Settings.IsSingleRivet;

  {$endif}
  DBGridDateInfo.DataSource  := DataSourceDateInfo;
  trussGaugeEdit.text       := G_Settings.trussprofile_gauge;
  If not  Assigned(DMRFDateInfo) then
    exit;

  If not DMRFDateInfo.FDMemTableItems.Active then
    DMRFDateInfo.FDMemTableItems.Open
  else
  begin
    DMRFDateInfo.FDMemTableItems.Close;
    DMRFDateInfo.FDMemTableItems.Open
  end;
  DMRFDateInfo.ResetFilter;
  DataSourceDateInfo.DataSet := DMRFDateInfo.FDMemTableItems;
end;

procedure TFormSettings.HelpBtnClick(Sender: TObject);
begin
  showmessage('DoD2002 and SX32' + chr(10)+ 'Head Position : ' + chr(10)+ 'Head position is distance from the shear blade,' + chr(10)+
    'with head mounted on the front of the machine. Click Set head position if changed.' + chr(10)+ 'Logo : Hexadecimal string (see manual).' + chr(10)
    + 'Send Configuration : ' + chr(10)+ 'Must be selected after changing graphics setting for SX-32 printer.' + chr(10)
    + 'Send command : ' + 'See manual for appropriate printer.' + chr(10) + 'VideoJet' + chr(10)+
    'See manual to set text position & other parameters from keypad');
end;

procedure TFormSettings.SpeedButton8Click(Sender: TObject);
begin
  FormScotTruss.PrintDialog2.Execute;
  labelprinteredit.text := printer.printers[printer.PrinterIndex];
end;

procedure TFormSettings.tabAboutShow(Sender: TObject);
begin
  uxVersionInfo.Clear;
  uxVersionInfo.Lines.add('ScotRF version: ' + GetFileVersion);
  uxVersionInfo.Lines.add('Jointing Version: ' + AdjustForJointsU.JOINING_VERSION);
  uxVersionInfo.Lines.add('Machine S/N: ' + rollformer.MintSerialNumber);

  if (rollformer.MachineChargeType<>ccGreen) or (CardAdapter.ChargeScheme<>ccGreen) then
  begin
    uxVersionInfo.Lines.add('Machine: ' + ChargeSchemeStr(rollformer.MachineChargeType));
    uxVersionInfo.Lines.add('Card: ' + CardAdapter.ChargeSchemeStr);
    if rollformer.
    MachineChargeType=ccNoCharge then
    if CardAdapter.isUnlimited then
      uxVersionInfo.Lines.add('Expiry Date            ' + FormatDateTime('dd mmm yyyy', CardAdapter.ExpiryDate));
  end;
//  uxVersionInfo.Lines.add(TW0Version);  // truss plus
  uxVersionInfo.Lines.add('');
  uxVersionInfo.Lines.add('(C) Copyright Scottsdale Construction Systems Ltd');
  uxVersionInfo.caretPos:=point(1,1);

end;

procedure TFormSettings.PageControl1Change(Sender: TObject);
begin
  If not Assigned(DMRFDateInfo) then
    Exit;
  If G_Settings.general_MachineName='' then
    Exit;
  {$ifdef panel}
    UpdateCountersOnScreen(tabPanelCounters);
    UpdateCountersFromScreen(tabPanelCounters);
  {$else}
    UpdateCountersOnScreen(tabTrussCounters);
    UpdateCountersFromScreen(tabTrussCounters);
  {$endif}
  DMRFDateInfo.GetFDMemTableItems;
end;

procedure TFormSettings.PanelHoleHeightChange(Sender: TObject);
//*Updates a read-only label if Panel Hole height is changed
begin
  PanelHoleHgtLabel.caption := PanelHoleHeight.text;
end;

procedure TFormSettings.TabSheet9Show(Sender: TObject);
begin
  Label_MachineName.Caption := 'Machine Name : ' + G_Settings.general_MachineName;// RollFormer.MintSerialNumber;
end;

procedure TFormSettings.Timer2Timer(Sender: TObject);
begin
  inc(Timer2Tick);
end;

procedure TFormSettings.LandscapeRBtnClick(Sender: TObject);
//*If Landscape selected, only allow 1 frame per page for detailed prints
begin
  if PrinterRG.itemindex = 1 then
    MultiPrtCBox.checked := false;
end;

function TFormSettings.HoleAutoJoinAdjustStr: string;
const
  HOLE_AUTO_KEY = 'CLSID\{A628F289-3E6E-499E-B937-37EECF1D249E}\InprocServer32';
var
  sHoleAuto: string;
begin
  sHoleAuto := GetRegStringValue(HOLE_AUTO_KEY, '');
  result := GetVerInfo(sHoleAuto, 'JoiningVersion');
end;

procedure TFormSettings.InkBtnClick(Sender: TObject);
begin
  SendIJPCommand('INK', true );
end;

function TFormSettings.GetVerInfo(sApp, sInfo: string): string;
const
  FILE_INFO = 'StringFileInfo\140904E4\';
var
  n, Len: DWORD;
  Buf, Value: pchar;
begin
  result := 'unknown';
  if (sApp = '')then
    exit;
  if(not fileexists(sApp))then
  begin
    result := 'not found';
    exit;
  end;
  n := GetFileVersionInfoSize(pchar(sApp), n);
  Buf := AllocMem(n);
  try
    GetFileVersionInfo(pchar(sApp), 0, n, Buf);
    if VerQueryValue(Buf, pchar(FILE_INFO + sInfo), Pointer(Value), Len) then
      result := Value;
  finally
    FreeMem(Buf, n);
  end;
end;

function TFormSettings.MachineType: TMachineType;
var
  Ix: integer;
begin
  ix:=uxMachineType.ItemIndex;
  Result := TMachineType(uxMachineType.items.objects[ix]);
  {$ifdef Panel}
     assert(Result in [mtPanel,mtPanelHD]);
  {$else}
     assert(Result in [ mtTruss,mt75mmTruss]);;
  {$endif}
end;
procedure TFormSettings.setMachineType(AMachineType: string);
var
  Ix: integer;
  ItemMachineType: TMachineType;
begin
  uxMachineType.ItemIndex:=0;
  for ix:=0 to pred(uxMachineType.items.Count) do
  begin
    ItemMachineType := TMachineType(uxMachineType.items.objects[ix]);
    if sametext(AMachineType, sMachineType[ItemMachineType]) then
    begin
      uxMachineType.ItemIndex:=ix;
      break;
    end;
  end;
  uxMachineTypeChange(nil);
end;

procedure TFormSettings.SetDrive(AString: string);
var index: integer;
begin
  index:=driveType.items.indexof(AString);
  if index<0 then
  begin
     Index :=0;
     uxSimulationMode.checked :=true;
  end;
  // keep combo and global syncronised
  G_Settings.RollFormerDrive := TDrive(Index) ;
  driveType.ItemIndex:=Index;
end;

function DriveClass : TDriveClass;
begin
  if G_Settings.general_sim then
    exit(tdcSim);
  if G_Settings.RollFormerDrive in [tdMint
                                  , tdMint2
                                  , tdMint2_5225Plus
                                  , tdMotiFlexE100_Mint
                                  , tdMotiFlexE100_IP_Mint
                                  , tdFlexE150
                                  , tdFlexE190
                                  , tdMotiFlexE180] then
    exit(tdcMint);
  if G_Settings.RollFormerDrive = tdFlexPlus then
    exit(tdcFlex);
  if G_Settings.RollFormerDrive = tdVirtual then
    exit(tdcVirtual);
  raise EUnknownDrive.Create('Type '+G_Settings.general_drive);
end;

function  IsBaldorDrive :boolean;
begin
  result := G_Settings.RollFormerDrive in BaldorDrives;
end;

{$IFDEF Panel}
function DriveHasTemp: boolean;
var
  Version: Double;
begin
  if not (G_Settings.RollFormerDrive in BaldorDrives) then
    Exit (false);
  version:=strtofloatDef(Rollformer.mintVersion,0);
  result := (Version >= 721)
            or ((Version >= 636) and (Version < 700))
            or ((Version >= 421) and (Version < 500)) ;
end;
{$else}
function DriveHasTemp: boolean;
begin
  Result:= True
end;
{$Endif}
END.
