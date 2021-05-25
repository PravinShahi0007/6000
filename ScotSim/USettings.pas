unit USettings;

{
Settings form
}

interface

uses
  Windows, Messages, SysUtils,
  Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls,
  Buttons, ExtCtrls, ComCtrls,
  IniFiles;

type
  TFormSettings = class(TForm)
    btnOK: TBitBtn;
    pgc: TPageControl;
    tabTrusses: TTabSheet;
    tabPanels: TTabSheet;
    Label4: TLabel;
    lblCopeSize: TLabel;
    lblJointGap: TLabel;
    lblHoleDist: TLabel;
    lblCopeTol: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    lblFileExt: TLabel;
    Label10: TLabel;
    lblLipHoleHeight: TLabel;
    lblFlgHoleHeight: TLabel;
    Label2: TLabel;
    NotchSizeEdit: TEdit;
    CopeSizeEdit: TEdit;
    JointGapEdit: TEdit;
    HoleDistanceEdit: TEdit;
    CopeTolEdit: TEdit;
    chkMinimiseLengths: TCheckBox;
    txtGauge: TEdit;
    txtLipSize: TEdit;
    chkShortenBottomHorzItems: TCheckBox;
    chkRequire2PtWebWeb: TCheckBox;
    btnScotTrussSettings: TBitBtn;
    LipHoleHeightEdit: TEdit;
    FlangeHoleHeightEdit: TEdit;
    txtTrussHoleSize: TEdit;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    txtFrameHoleHeight: TEdit;
    txtPanelHoleSize: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape17: TShape;
    Shape16: TShape;
    Label6: TLabel;
    txtFlattenSize: TEdit;
    Label11: TLabel;
    txtPanelNotchSize: TEdit;
    Label12: TLabel;
    txtServiceHoleLen: TEdit;
    Label13: TLabel;
    txtPlumbingHoleLen: TEdit;
    Label14: TLabel;
    txtPanelLipSize: TEdit;
    txtPanelSwageLength: TEdit;
    lblPanelJointGap: TLabel;
    txtPanelJointGap: TEdit;
    Label17: TLabel;
    txtVertJointGap: TEdit;
    txtPanelHoleDist: TEdit;
    lblPanelHoleDist: TLabel;
    chkPanelUseSwage: TCheckBox;
    Label7: TLabel;
    txtCutWidth: TEdit;
    Label8: TLabel;
    txtFlatNotchTol: TEdit;
    chkIgnoreDuplicateOps: TCheckBox;
    chkIgnoreHoleDistErrors: TCheckBox;
    btnScotRFTrussSettings: TBitBtn;
    btnScotRFPanelSettings: TBitBtn;
    chkVirtualMitre: TCheckBox;
    lblHoleAuto: TLabel;
    btnFont: TButton;
    BalloonHint1: TBalloonHint;
    txtFrameHole2Height: TEdit;
    chkUseBoxWebbing: TCheckBox;
    txtBoxWebHeight: TEdit;
    Label15: TLabel;
    chkTrussUseSwage: TCheckBox;
    txtTrussSwageLength: TEdit;
    chkEndLoadCut: TCheckBox;
    txtEndLoadCut: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure txtGaugeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnScotTrussSettingsClick(Sender: TObject);
    procedure chkPanelUseSwageClick(Sender: TObject);
    procedure btnScotRFPanelSettingsClick(Sender: TObject);
    procedure chkTrussUseSwageClick(Sender: TObject);
  private
    FCurrentSettingsFile: string;     { Private declarations }
    procedure LoadValues;
    procedure LoadHints;
    procedure GetScotRFImperialSettings(AIniFile: TIniFile);
    procedure GetScotRFMetricSettings(AIniFile: TIniFile);
    procedure SetCurrentSettingsFile(const Value: string);

    property CurrentSettingsFile: string read FCurrentSettingsFile write SetCurrentSettingsFile;
  public      { Public declarations }

  end;

var
  FormSettings: TFormSettings;

implementation

uses GlobalU,
     AdjustForJointsU,  //for setting HoleSize
     mainU, UnitsU, UpdateFormU, TranslateU;             //MainU for setting RectWidth

const
  TSTRUCTURE_SECTION = 'tstructure';
  PSTRUCTURE_SECTION = 'pstructure';
  TRUSS_PROFILE_SECTION = 'trussprofile';
  TRUSSRF_SECTION = 'trussrf';
  PANEL_PROFILE_SECTION = 'panelprofile';
  PANELRF_SECTION = 'panelrf';

{$R *.dfm}

procedure TFormSettings.SetCurrentSettingsFile(const Value: string);
begin
  FCurrentSettingsFile := Value;
  Caption := 'Settings';
  if (Value <> '') then
    Caption := format('%s - %s', [Caption, ExtractFileName(Value)]);
end;

procedure TFormSettings.LoadValues;
begin
  CurrentSettingsFile := ScotRFSettingsFile;

  txtTrussHoleSize.Text := FloatToStr(TrussHoleSize);
  JointGapEdit.Text := FloatToStr(TrussJointGap);
  txtPanelJointGap.Text := FloatToStr(PanelJointGap);
  txtVertJointGap.Text := FloatToStr(VertJointGap);

  LipHoleHeightEdit.Text := FloatToStr(LipHolePos);
  FlangeHoleHeightEdit.Text := FloatToStr(FlgHolePos);
  txtFrameHoleHeight.Text := FloatToStr(FrameHolePos);
  txtFrameHole2Height.Text := FloatToStr(FrameHolePos2);
                          //HoleDistanceEdit.Text := FloatToStr(MinEndDist);  //moved to the Show event
  HoleDistanceEdit.Text := format('%.3f', [TrussHoleDist]);
  txtPanelHoleDist.Text := format('%.3f', [PanelHoleDist]);
  txtPanelHoleSize.Text := FloatToStr(PanelHoleSize);  //format('%.3f', [PanelHoleSize]);
  //These are not for DLL
  chkEndLoadCut.Checked := bEndLoadCut;
  txtEndLoadCut.Text := FloatToStr(EndLoadCutSize);
  chkTrussUseSwage.Checked := bTrussUseSwage;
  txtTrussSwageLength.Text := FloatToStr(TrussSwageSize);
  chkPanelUseSwage.Checked := bPanelUseSwage;
  chkTrussUseSwage.Checked := bTrussUseSwage;
  txtPanelSwageLength.Text := FloatToStr(PanelSwageSize);
  NotchSizeEdit.Text := FloatToStr(TrussNotchSize);
  txtPanelNotchSize.Text := FloatToStr(PanelNotchSize);
  CopeSizeEdit.Text := FloatToStr(TrussCopeSize);
  txtFlattenSize.Text := FloatToStr(PanelFlatSize);
  txtCutWidth.Text := FloatToStr(CutWidth);

  CopeTolEdit.Text := FloatToStr(TrussCopeNotchTol);
  txtFlatNotchTol.Text := FloatToStr(PanelFlatNotchTol);
  chkMinimiseLengths.Checked := bMinimiseLengths;
  //chkUSJointing.Checked := bUSJointing;
  txtGauge.Text := Gauge;
  txtLipSize.Text := FloatToStr(TrussLipSize);
  txtPanelLipSize.Text := FloatToStr(PanelLipSize);
  //chkShortenBottomHorzItems.Checked := bShortenBottomHorzItems;
  chkRequire2PtWebWeb.Checked := bRequire2PtWebToWeb;

  chkIgnoreDuplicateOps.Checked := bIgnoreDuplicateOps;
  chkIgnoreHoleDistErrors.Checked := bIgnoreMinEndDistErrors;
  chkVirtualMitre.Checked := bVirtualMitre;

  chkUseBoxWebbing.Checked := bUseBoxWebbing;
  txtBoxWebHeight.Text := FloatToStr(BoxWebHeight);

  if bFrames then
    pgc.ActivePage := tabPanels
  else
    pgc.ActivePage := tabTrusses;

  HoleSize := TrussHoleSize / 2;
  if bFrames then
    HoleSize := PanelHoleSize / 2;
end;

procedure TFormSettings.LoadHints;
begin
  JointGapEdit.Hint := lblJointGap.Hint;
  lblPanelJointGap.Hint := lblJointGap.Hint;
  txtPanelJointGap.Hint := lblJointGap.Hint;

  HoleDistanceEdit.Hint := lblHoleDist.Hint;
  lblPanelHoleDist.Hint := lblHoleDist.Hint;
  txtPanelHoleDist.Hint := lblHoleDist.Hint;
end;

procedure TFormSettings.FormCreate(Sender: TObject);
begin
  LoadValues;
  LoadHints;

  TranslateForm(Self);
end;

procedure TFormSettings.txtGaugeChange(Sender: TObject);
var
  s: string;
begin
  Gauge := txtGauge.Text;
  if Gauge = '' then
    s := 'TXT'  // 'TXF'
  else
    s := 'TX' + Gauge;
  lblFileExt.Caption := s;
end;

procedure TFormSettings.FormShow(Sender: TObject);
begin
  txtGaugeChange(Sender);
  HoleDistanceEdit.Text := format('%.3f', [TrussHoleDist]);
  txtPanelHoleDist.Text := format('%.3f', [PanelHoleDist]);

  lblHoleAuto.Caption := format('Joining version: %s, HoleAuto: %s', [JOINING_VERSION, HoleAutoJoinAdjustStr]);
  lblHoleAuto.Visible := frmMain.actHoleAutoCoords.Enabled;
end;

procedure ReadImperialFloatFromIniString(AIniFile: TIniFile; ASection, AKey: string; var AVar: Double);
var
  f: Double;
  bError: Bool;
  s: string;
begin
  s := AIniFile.ReadString(ASection, AKey, '');
  f := ImperialStrToMM(s, bError);
  if not bError then
    AVar := f;
end;

procedure TFormSettings.btnScotTrussSettingsClick(Sender: TObject);
const
  CONNECTIONS_SECTION = 'Connections';
  PROFILE_SECTION = 'Profile';
  RF_SECTION = 'RF';
var
  ODlg: TOpenDialog;
  AIniFile: TIniFile;
  //bMetric: Bool;
  //Diff: Double;
begin
  ODlg := TOpenDialog.Create(Application);
  try
    ODlg.InitialDir := ExtractFileDir(ScotTrussSettingsFile);
    ODlg.FileName := ExtractFileName(ScotTrussSettingsFile);
    ODlg.Filter := 'ScotTruss Settings (*.set)|*.set|All Files (*.*)|*.*';
    if ODlg.Execute then
    begin
      ScotTrussSettingsFile := ODlg.FileName;
      CurrentSettingsFile := '';  //ScotTrussSettingsFile;

      AIniFile := TIniFile.Create(ScotTrussSettingsFile);
      try
        {
        bMetric := True;  //default
        if AIniFile.ValueExists('general', 'metric')then
          bMetric := AIniFile.ReadBool('general', 'metric', True)
        else
          if AIniFile.ValueExists('general', 'units')then  //for backward compatibity
            bMetric := SameText(AIniFile.ReadString('general', 'units', 'Metric'), 'Metric');
        if not bMetric then
        }
        if not SameText(AIniFile.ReadString('general', 'units', 'Metric'), 'Metric')then
        begin                               //Imperial
          //MessageDlg('Please choose a metric settings file', mtInformation, [mbOK], 0);
          //exit;
          ReadImperialFloatFromIniString(AIniFile, CONNECTIONS_SECTION, 'ButtGap', TrussJointGap);
          ReadImperialFloatFromIniString(AIniFile, PROFILE_SECTION, 'LipHoleHeight', LipHolePos);

          ReadImperialFloatFromIniString(AIniFile, PROFILE_SECTION, 'FlangeHoleHeight', FlgHolePos);
          {
          Diff := 18;
          ReadImperialFloatFromIniString(AIniFile, PROFILE_SECTION, 'FlangeLipHoleDiff', Diff);
          FlgHolePos := LipHolePos - Diff;
          }
          ReadImperialFloatFromIniString(AIniFile, CONNECTIONS_SECTION, 'HoleDist', TrussHoleDist);
          ReadImperialFloatFromIniString(AIniFile, RF_SECTION, 'NotchSize', TrussNotchSize);
          ReadImperialFloatFromIniString(AIniFile, RF_SECTION, 'CopeSize', TrussCopeSize);
          ReadImperialFloatFromIniString(AIniFile, CONNECTIONS_SECTION, 'Tolerance', TrussCopeNotchTol);
          ReadImperialFloatFromIniString(AIniFile, PROFILE_SECTION, 'LipSize', TrussLipSize);

          //2 other values set elsewhere
          //ReadImperialFloatFromIniString(CONNECTIONS_SECTION, 'Radius', HoleSize);
          ReadImperialFloatFromIniString(AIniFile, PROFILE_SECTION, 'ProfileHeight', RectWidth);
        end
        else with AIniFile do begin
          TrussJointGap := ReadFloat(CONNECTIONS_SECTION, 'ButtGap', TrussJointGap);
          LipHolePos := ReadFloat(PROFILE_SECTION, 'LipHoleHeight', LipHolePos);
          FlgHolePos := ReadFloat(PROFILE_SECTION, 'FlangeHoleHeight', FlgHolePos);
          {
          Diff := ReadFloat(PROFILE_SECTION, 'FlangeLipHoleDiff', 18);
          FlgHolePos := LipHolePos - Diff;
          }
          TrussHoleDist := ReadFloat(CONNECTIONS_SECTION, 'HoleDist', TrussHoleDist);
          TrussNotchSize := ReadFloat(RF_SECTION, 'NotchSize', TrussNotchSize);
          TrussCopeSize := ReadFloat(RF_SECTION, 'CopeSize', TrussCopeSize);
          TrussCopeNotchTol := ReadFloat(CONNECTIONS_SECTION, 'Tolerance', TrussCopeNotchTol);
          TrussLipSize := ReadFloat(PROFILE_SECTION, 'LipSize', TrussLipSize);

          //2 other values set elsewhere
          //HoleSize := ReadFloat(CONNECTIONS_SECTION, 'Radius', HoleSize);
          TrussRectWidth := ReadFloat(PROFILE_SECTION, 'ProfileHeight', RectWidth);
          RectWidth := TrussRectWidth;
        end;
        //Bool and String don't depend on Metric / Imperial
        with AIniFile do
        begin
          //HoleSize := ReadFloat(CONNECTIONS_SECTION, 'Radius', HoleSize);  //this seems to always be metric in the *.set file
          TrussHoleSize := ReadFloat(CONNECTIONS_SECTION, 'Radius', TrussHoleSize);
          txtTrussHoleSize.Text := FloatToStr(TrussHoleSize); // * 2);

          bMinimiseLengths := ReadBool(CONNECTIONS_SECTION, 'Minimize', bMinimiseLengths);
          Gauge := ReadString(PROFILE_SECTION, 'Gauge', Gauge);    //or RF_SECTION ???
          //bShortenBottomHorzItems := ReadBool(CONNECTIONS_SECTION, 'MinimizeBC', bShortenBottomHorzItems);
          bRequire2PtWebToWeb := ReadBool(CONNECTIONS_SECTION, 'Web2Web', bRequire2PtWebToWeb);
        end;

        LoadValues;  //update the controls with the new values
        txtGaugeChange(Sender);
        //HoleDistanceEdit.Text := format('%.3f', [TrussHoleDist]);
        pgc.ActivePage := tabTrusses;
      finally
        AIniFile.Free;
      end;
    end;
  finally
    ODlg.Free;
  end;
end;

procedure TFormSettings.chkPanelUseSwageClick(Sender: TObject);
begin
  txtPanelSwageLength.Enabled := chkPanelUseSwage.Checked;
end;

procedure TFormSettings.chkTrussUseSwageClick(Sender: TObject);
begin
  txtTrussSwageLength.Enabled := chkTrussUseSwage.Checked;
end;

procedure TFormSettings.GetScotRFImperialSettings(AIniFile: TIniFile);
var
  Diff, fHoleDiff: Double;
begin
  with AIniFile do
  begin
    if (not bFrames)then
    begin         //Truss Settings
      {try
        TrussJointGap := ReadFloat(TSTRUCTURE_SECTION, 'ButtGap', TrussJointGap);
        TrussHoleDist := ReadFloat(TSTRUCTURE_SECTION, 'HoleDist', TrussHoleDist);
        TrussCopeNotchTol := ReadFloat(TSTRUCTURE_SECTION, 'Tolerance', TrussCopeNotchTol);
        LipHolePos := ReadFloat(TRUSS_PROFILE_SECTION, 'LipHoleHeight', LipHolePos);
        if ValueExists(TRUSS_PROFILE_SECTION, 'FlangeLipHoleDiff')then
        begin
          Diff := ReadFloat(TRUSS_PROFILE_SECTION, 'FlangeLipHoleDiff', 18);
          FlgHolePos := LipHolePos - Diff;
        end
        else //for backward compatibity
          FlgHolePos := ReadFloat(TRUSS_PROFILE_SECTION, 'FlangeHoleHeight', FlgHolePos);
        TrussLipSize := ReadFloat(TRUSS_PROFILE_SECTION, 'LipSize', TrussLipSize);
        TrussHoleSize:= ReadFloat(TRUSS_PROFILE_SECTION, 'HoleSize', TrussHoleSize);
        TrussRectWidth := ReadFloat(TRUSS_PROFILE_SECTION, 'ProfileHeight', RectWidth);
        RectWidth := TrussRectWidth;
        TrussNotchSize := ReadFloat(TRUSSRF_SECTION, 'NotchSize', TrussNotchSize);
        TrussCopeSize := ReadFloat(TRUSSRF_SECTION, 'CopeSize', TrussCopeSize);
        CutWidth := ReadFloat(TRUSSRF_SECTION, 'CutWidth', CutWidth);
      except }  //assume all rfs is in imperial
        ReadImperialFloatFromIniString(AIniFile, TSTRUCTURE_SECTION, 'ButtGap', TrussJointGap);
        ReadImperialFloatFromIniString(AIniFile, TSTRUCTURE_SECTION, 'HoleDist', TrussHoleDist);
        ReadImperialFloatFromIniString(AIniFile, TSTRUCTURE_SECTION, 'Tolerance', TrussCopeNotchTol);
        ReadImperialFloatFromIniString(AIniFile, TRUSS_PROFILE_SECTION, 'LipHoleHeight', LipHolePos);
        if ValueExists(TRUSS_PROFILE_SECTION, 'FlangeLipHoleDiff')then
        begin
          ReadImperialFloatFromIniString(AIniFile, TRUSS_PROFILE_SECTION, 'FlangeLipHoleDiff', Diff);
          FlgHolePos := LipHolePos - Diff;
        end
        else //for backward compatibity
          ReadImperialFloatFromIniString(AIniFile, TRUSS_PROFILE_SECTION, 'FlangeHoleHeight', FlgHolePos);
        ReadImperialFloatFromIniString(AIniFile, TRUSS_PROFILE_SECTION, 'LipSize', TrussLipSize);
        ReadImperialFloatFromIniString(AIniFile, TRUSS_PROFILE_SECTION, 'HoleSize', TrussHoleSize);
        ReadImperialFloatFromIniString(AIniFile, TRUSS_PROFILE_SECTION, 'ProfileHeight', RectWidth);
        ReadImperialFloatFromIniString(AIniFile, TRUSSRF_SECTION, 'NotchSize', TrussNotchSize);
        ReadImperialFloatFromIniString(AIniFile, TRUSSRF_SECTION, 'CopeSize', TrussCopeSize);
        ReadImperialFloatFromIniString(AIniFile, TRUSSRF_SECTION, 'CutWidth', CutWidth);
        ReadImperialFloatFromIniString(AIniFile, TRUSSRF_SECTION, 'SwageSize', TrussSwageSize);
        bTrussUseSwage := TrussSwageSize<>0;
      //end;
    end
    else begin    //Panel Settings
      ReadImperialFloatFromIniString(AIniFile, PSTRUCTURE_SECTION, 'JointGap', PanelJointGap);
      ReadImperialFloatFromIniString(AIniFile, PSTRUCTURE_SECTION, 'VerticalGap', VertJointGap);
      ReadImperialFloatFromIniString(AIniFile, PSTRUCTURE_SECTION, 'MinHoleDist', PanelHoleDist);

      ReadImperialFloatFromIniString(AIniFile, PANELRF_SECTION, 'CutWidth', CutWidth);
      ReadImperialFloatFromIniString(AIniFile, PANELRF_SECTION, 'FlatSize', PanelFlatSize);
      ReadImperialFloatFromIniString(AIniFile, PANELRF_SECTION, 'NotchSize', PanelNotchSize);
      ReadImperialFloatFromIniString(AIniFile, PANELRF_SECTION, 'SwageSize', PanelSwageSize);
      ReadImperialFloatFromIniString(AIniFile, PANELRF_SECTION, 'NotchTol', PanelFlatNotchTol);
      ReadImperialFloatFromIniString(AIniFile, PANELRF_SECTION, 'EndBrgNotchSize', EndLoadCutSize);
      bEndLoadCut := EndLoadCutSize<>0;

      ReadImperialFloatFromIniString(AIniFile, PANEL_PROFILE_SECTION, 'LipSize', PanelLipSize);
      ReadImperialFloatFromIniString(AIniFile, PANEL_PROFILE_SECTION, 'HoleHeight', FrameHolePos);
      //ReadImperialFloatFromIniString(AIniFile, PANEL_PROFILE_SECTION, 'HoleMHeight', FrameHolePos2);
      ReadImperialFloatFromIniString(AIniFile, PANELRF_SECTION, 'HoleM2DiffVert', fHoleDiff);
      FrameHolePos2:= FrameHolePos - fHoleDiff;
      ReadImperialFloatFromIniString(AIniFile, PANEL_PROFILE_SECTION, 'HoleSize', PanelHoleSize);
      ReadImperialFloatFromIniString(AIniFile, PANEL_PROFILE_SECTION, 'ProfileHeight', RectWidth);
    end;
  end;
end;

procedure TFormSettings.GetScotRFMetricSettings(AIniFile: TIniFile);
var
  Diff: Double;
begin
  with AIniFile do
  begin
    //if Pos('truss', Lowercase(ExtractFileName(AIniFile.FileName))) > 0 then
    //if (not bFrames)then
    if pgc.ActivePageIndex = 0 then
    begin         //Truss Settings
      TrussJointGap := ReadFloat(TSTRUCTURE_SECTION, 'ButtGap', TrussJointGap);
      TrussHoleDist := ReadFloat(TSTRUCTURE_SECTION, 'HoleDist', TrussHoleDist);
      TrussCopeNotchTol := ReadFloat(TSTRUCTURE_SECTION, 'Tolerance', TrussCopeNotchTol);

      LipHolePos := ReadFloat(TRUSS_PROFILE_SECTION, 'LipHoleHeight', LipHolePos);
      //FlgHolePos := ReadFloat(TRUSS_PROFILE_SECTION, 'FlangeHoleHeight', FlgHolePos);
      if ValueExists(TRUSS_PROFILE_SECTION, 'FlangeLipHoleDiff')then
      begin
        Diff := ReadFloat(TRUSS_PROFILE_SECTION, 'FlangeLipHoleDiff', 18);
        FlgHolePos := LipHolePos - Diff;
      end
      else //for backward compatibity
        FlgHolePos := ReadFloat(TRUSS_PROFILE_SECTION, 'FlangeHoleHeight', FlgHolePos);

      TrussLipSize := ReadFloat(TRUSS_PROFILE_SECTION, 'LipSize', TrussLipSize);
      TrussHoleSize:= ReadFloat(TRUSS_PROFILE_SECTION, 'HoleSize', TrussHoleSize);
      TrussRectWidth := ReadFloat(TRUSS_PROFILE_SECTION, 'ProfileHeight', RectWidth);
      RectWidth := TrussRectWidth;

      TrussNotchSize := ReadFloat(TRUSSRF_SECTION, 'NotchSize', TrussNotchSize);
      TrussCopeSize := ReadFloat(TRUSSRF_SECTION, 'CopeSize', TrussCopeSize);
      CutWidth := ReadFloat(TRUSSRF_SECTION, 'CutWidth', CutWidth);   //??? Use this or the PANELRF one ???
      TrussSwageSize := ReadFloat(TRUSSRF_SECTION, 'SwageSize', TrussSwageSize);
      bTrussUseSwage := TrussSwageSize<>0;

    end
    else begin    //Panel Settings
      PanelJointGap := ReadFloat(PSTRUCTURE_SECTION, 'JointGap', PanelJointGap);
      VertJointGap := ReadFloat(PSTRUCTURE_SECTION, 'VerticalGap', VertJointGap);
      PanelHoleDist:= ReadFloat(PSTRUCTURE_SECTION, 'MinHoleDist', PanelHoleDist);

      CutWidth := ReadFloat(PANELRF_SECTION, 'CutWidth', CutWidth);   //??? duplicated var setting ???
      PanelFlatSize := ReadFloat(PANELRF_SECTION, 'FlatSize', PanelFlatSize);
      PanelNotchSize:= ReadFloat(PANELRF_SECTION, 'NotchSize', PanelNotchSize);
      PanelSwageSize := ReadFloat(PANELRF_SECTION, 'SwageSize', PanelSwageSize);
      PanelFlatNotchTol := ReadFloat(PANELRF_SECTION, 'NotchTol', PanelFlatNotchTol);
      EndLoadCutSize := ReadFloat(PANELRF_SECTION, 'EndBrgNotchSize', EndLoadCutSize);
      bEndLoadCut := EndLoadCutSize<>0;

      PanelLipSize := ReadFloat(PANEL_PROFILE_SECTION, 'LipSize', PanelLipSize);
      FrameHolePos := ReadFloat(PANEL_PROFILE_SECTION, 'HoleHeight', FrameHolePos);
      //FrameHolePos2:= ReadFloat(PANEL_PROFILE_SECTION, 'HoleMHeight', FrameHolePos2);
      FrameHolePos2:= FrameHolePos - ReadFloat(PANELRF_SECTION, 'HoleM2DiffVert', FrameHolePos2);
      PanelHoleSize:= ReadFloat(PANEL_PROFILE_SECTION, 'HoleSize', PanelHoleSize);
      PanelRectWidth := ReadFloat(PANEL_PROFILE_SECTION, 'ProfileHeight', RectWidth);
      RectWidth := PanelRectWidth;
    end;
  end;
end;

//* used by btnScotRFPanelSettings and btnScotRFTrussSettings
procedure TFormSettings.btnScotRFPanelSettingsClick(Sender: TObject);
var
  ODlg: TOpenDialog;
  AIniFile: TIniFile;
  s: string;
  bMetric: Bool;
begin
  ODlg := TOpenDialog.Create(Application);
  try
    ODlg.InitialDir := ExtractFileDir(ScotRFSettingsFile);
    ODlg.FileName := ExtractFileName(ScotRFSettingsFile);
    s := 'Truss';
    bFrames := False;
    if (pgc.ActivePage = tabPanels) then
    begin
      s := 'Panel';
      bFrames := True;
    end;
    ODlg.Filter := format('ScotRF-%s Settings (*.rfs)|*.rfs|All Files (*.*)|*.*', [s]);
    ODlg.Title := format('Import ScotRF-%s Settings', [s]);
    if ODlg.Execute then
    begin
      ScotRFSettingsFile := ODlg.FileName;
      CurrentSettingsFile := ScotRFSettingsFile;

      AIniFile := TIniFile.Create(ScotRFSettingsFile);
      try
        bMetric := True;  //default
        if AIniFile.ValueExists('general', 'metric')then
          bMetric := AIniFile.ReadBool('general', 'metric', True)
        else
          if AIniFile.ValueExists('general', 'units')then  //for backward compatibity
            bMetric := SameText(AIniFile.ReadString('general', 'units', 'Metric'), 'Metric');

        if not bMetric then
          GetScotRFImperialSettings(AIniFile)
        else
          GetScotRFMetricSettings(AIniFile);

        //Bool and String don't depend on Metric / Imperial
        with AIniFile do
        begin
          if bFrames then
          begin
            bPanelUseSwage := ReadBool(PSTRUCTURE_SECTION, 'Swage', bPanelUseSwage);
            bIgnoreMinEndDistErrors := ReadBool(PSTRUCTURE_SECTION, 'IgnoreMinDistance', bIgnoreMinEndDistErrors);
          end
          else begin
            bMinimiseLengths := ReadBool(TSTRUCTURE_SECTION, 'Minimize', bMinimiseLengths);
            //bShortenBottomHorzItems := ReadBool(TSTRUCTURE_SECTION, 'MinimizeBC', bShortenBottomHorzItems);
            bRequire2PtWebToWeb := ReadBool(TSTRUCTURE_SECTION, 'Web2Web', bRequire2PtWebToWeb);
            Gauge := ReadString(TRUSS_PROFILE_SECTION, 'Gauge', Gauge);
          end;
        end;

        LoadValues;  //update the controls with the new values
        txtGaugeChange(Sender);
      finally
        AIniFile.Free;
      end;
    end;
  finally
    ODlg.Free;
  end;
end;

END.
