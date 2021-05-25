unit mainU;

{
 ScotSim main form
}

interface

uses
  Windows, Messages, SysUtils,
  Classes, Graphics,
  Controls, Forms,
  Dialogs,
  OpenGL,
  cOpenGL,
  GlobalU, ComCtrls, Menus,
  //FindHole_TLB,
  HoleAuto_TLB,
  Variants, ComObj,
  StdCtrls, Buttons, ExtCtrls,
  ShellAPI,
  ToolWin, ImgList,
  ActnList,
  ActnMan, ActnCtrls,
  ActnMenus,
  RibbonActnMenus, Ribbon, RibbonLunaStyleActnCtrls,
  ScreenTips, RibbonActnCtrls;

type
  TfrmMain = class(TForm)
    OpenGL1: TOpenGL;
    pnlHelp: TPanel;
    memHelp: TMemo;
    btnOK: TBitBtn;
    pnlOrientation: TPanel;
    Bevel1: TBevel;
    Image1: TImage;
    Label1: TLabel;
    Bevel2: TBevel;
    Label2: TLabel;
    radHelpText: TRadioButton;
    radOrientation: TRadioButton;
    radShortcutKeys: TRadioButton;
    memShortcutKeys: TMemo;
    Ribbon1: TRibbon;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    RibbonPage1: TRibbonPage;
    rgVersion: TRibbonGroup;
    ilSmall: TImageList;
    ilLarge: TImageList;
    rgDebug: TRibbonGroup;
    rgEditing: TRibbonGroup;
    rgOptions: TRibbonGroup;
    imgHelpIcon: TImage;
    rgAdjust: TRibbonGroup;
    actMgr: TActionManager;
    actNew: TAction;
    actOpen: TAction;
    actSaveAs: TAction;
    actSaveAsImperial: TAction;
    actSaveSimData: TAction;
    actExit: TAction;
    actSettings: TAction;
    actFont: TAction;
    actHoleAutoCoords: TAction;
    actShowHolePts: TAction;
    actSnapping: TAction;
    actAngleSnapping: TAction;
    actShowGrid: TAction;
    actShowLip: TAction;
    actHideAdjustedItem: TAction;
    actShowDebugCircle: TAction;
    actHelp: TAction;
    actCheckForUpdate: TAction;
    actAbout: TAction;
    actDraw: TAction;
    actEdit: TAction;
    actLock: TAction;
    actSetRectWidth: TAction;
    actFindItem: TAction;
    actRects: TAction;
    actAdjustForJoints: TAction;
    actMRUAction: TAction;
    ilLargeDis: TImageList;
    ilSmallDis: TImageList;
    RibbonQuickAccessToolbar1: TRibbonQuickAccessToolbar;
    TipsMgr: TScreenTipsManager;
    actBold: TAction;
    actUpdateScotSteel: TAction;
    actMakeHorz: TAction;
    actMakeParallel: TAction;
    actMeasure: TAction;
    actShowAddOpForm: TAction;
    Button1: TButton;
    actShowNotches: TAction;
    actShowCopes: TAction;
    actShowSwages: TAction;
    actShowFlattenedLip: TAction;
    Button2: TButton;
    btnAngle: TButton;
    actUndo: TAction;
    actRedo: TAction;
    cboHoleToUse: TRibbonComboBox;
    actHoleToUse: TAction;
    actShowHolePositions: TAction;
    actHideErrorDialog: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure btnOKClick(Sender: TObject);
    procedure radHelpTextClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actNewExecute(Sender: TObject);
    procedure actSaveAsExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actSaveSimDataExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actSettingsExecute(Sender: TObject);
    procedure actFontExecute(Sender: TObject);
    procedure actHoleAutoCoordsExecute(Sender: TObject);
    procedure actShowHolePtsExecute(Sender: TObject);
    procedure actSnappingExecute(Sender: TObject);
    procedure actAngleSnappingExecute(Sender: TObject);
    procedure actShowGridExecute(Sender: TObject);
    procedure actShowLipExecute(Sender: TObject);
    procedure actShowDebugCircleExecute(Sender: TObject);
    procedure actSetRectWidthExecute(Sender: TObject);
    procedure actHideAdjustedItemExecute(Sender: TObject);
    procedure actFindItemExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actCheckForUpdateExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actLockExecute(Sender: TObject);
    procedure actDrawExecute(Sender: TObject);
    procedure actAdjustForJointsExecute(Sender: TObject);
    procedure Ribbon1RecentItemClick(Sender: TObject; FileName: string; Index: Integer);
    function FormHelp(Command: Word; Data: Integer; var CallHelp: Boolean): Boolean;
    procedure actMRUActionExecute(Sender: TObject);
    procedure Ribbon1TabChange(Sender: TObject; const NewIndex, OldIndex: Integer; var AllowChange: Boolean);
    procedure actBoldExecute(Sender: TObject);
    procedure actUpdateScotSteelExecute(Sender: TObject);
    procedure actMakeHorzExecute(Sender: TObject);
    procedure actMakeParallelExecute(Sender: TObject);
    procedure actMeasureExecute(Sender: TObject);
    procedure actShowAddOpFormExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure actShowNotchesExecute(Sender: TObject);
    procedure actShowFlattenedLipExecute(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnAngleClick(Sender: TObject);
    procedure actUndoExecute(Sender: TObject);
    procedure actRedoExecute(Sender: TObject);
    procedure cboHoleToUseChange(Sender: TObject);
    procedure actHideErrorDialogExecute(Sender: TObject);
  private { Private declarations }
    procedure ZoomIn(Speed: Single);
    procedure ZoomOut(Speed: Single);
    procedure DisplayTrussRect(Idx: Word);
    procedure DisplayTrussRects;
    function GetItemAt(X, Y: Integer): Word;
    procedure ShowRectPropertiesForm(Idx, X, Y: Integer);
    procedure DisplayEntities;
    procedure DisplayItemOps(Idx: Word);
    procedure DisplayEntity(Idx: Word);
    procedure GetEntityPointsFromTrussRects;
    procedure OpenTrussData(AFileName: TFileName);
    procedure DisplayEntityItem(Idx: Word);
    procedure CompleteTrussItemRect(Idx: Word);
    //procedure AddTrussRect(ARect: RectType; ReverseOrder: Bool);
    //procedure DisplayAngle;
    //procedure DisplayGrid;
    procedure ReadIni;
    procedure WriteIni;
    procedure DisplayEntityNotchesAndCopes(Idx: Word);
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure SetEditsHint;
    procedure AddToMRU(AFileName: TFileName; bTopItem: Bool = True);
    procedure AppMenuPopup(Sender: TObject; Item: TCustomActionControl);
    procedure CentreTheHelpPanel;
    procedure LoadActionHints;
    function GetTotalTrussRectsLength: Double;
    function GetTotalEntityLength: Double;
  public { Public declarations }
    procedure DefaultHandler(var Message); override;
  end;

  TTrussRects = record
    ItemName: array[1 .. MAX_ITEMS]of string[10]; //MaxLength of txtName in RectPropertiesForm is 10 too
    Item: array[1 .. MAX_ITEMS]of RectType;
    iType: array[1 .. MAX_ITEMS]of string[5];
    OpCount: array[1 .. MAX_ITEMS]of Word;
    Op: array[1 .. MAX_ITEMS, 1 .. MAX_OPS]of OpType;
    bNonRFItem: array[1 .. MAX_ITEMS]of Boolean; //Hide the generated EntityRecType
  end;

procedure DeleteItem(nItem: Word);

const
  OPTIONS_SETTINGS = 'Options';
  RIBBON_SETTINGS = 'Ribbon';
  RECT_HEIGHTS = 52;
  MM_IN_AN_INCH = 25.4;

var
  frmMain: TfrmMain;
  CurrentItem: Word = 1;
  bDllIsInitialised: Bool = False;
  HoleFinder: IHoleFinder2;
  TrussRects: TTrussRects;
  IniFileName: TFileName; //AnsiString;
  RectWidth: Double = RECT_HEIGHTS;
  TrussRectWidth: Double = RECT_HEIGHTS;
  PanelRectWidth: Double = 38;
  EditWidth: Double = RECT_HEIGHTS;
  TrussHoleSize: Double = 10; //radii, not Diameters, was 19, then  20
  PanelHoleSize: Double = 5.1;
  TrussJointGap: Double = 3;
  PanelJointGap: Double = 3;
  TrussLipSize: Double = 6;
  PanelLipSize: Double = 6;
  TrussNotchSize: Double = 21;
  PanelNotchSize: Double = 50;
  TrussCopeSize: Double = 21;
  PanelFlatSize: Double = 50;
  TrussHoleDist: Double = 15;
  PanelHoleDist: Double = 10;
  TrussCopeNotchTol: Double = 10;
  PanelFlatNotchTol: Double = 10;
  bIgnoreDuplicateOps: Bool = False;

implementation

uses
  UtilsU,
  RectPropertiesForm, USettings,
  Entityunit, AdjustForJointsU, OGLTextU,
  IniFiles, AboutU, HoleAutoFormU,
  ErrorsFormU,
  ZLib,
  DCPBlowfish, DCPSha1, strUtils,
  UnitsU, AddOpFormU, TranslateU, UndoU;

const
  SCALE_FACTOR = 1.1; //was 1.05
  PICK_BUFFER_SIZE = MAX_ITEMS;
  SETTINGS_SECTION = 'Settings';
  PANELS_SECTION = 'Panels';
  MENU_OPTIONS = 'Menu Settings';
  //OPTIONS_SETTINGS = 'Options';
  FONT_SECTION = 'Font';
  NAME_PREFIX = 'Item ';
  CSV_FILE_EXT = '.csv';
  ENCRYPTED_PANEL_FILE_EXT = 'ep2'; //was 'epf';
  RECTS_EDIT_HINT = '%s edits to the current items';
  EDITS_MSG = 'This item can''t be %s while the Lock button is down';

  SWAGE_COLOR = clBlue;
  HOLE_COLOR = clBlue; //clBlack;

  MAX_MRU_ITEMS = 30; //more than enough items to populate the Recent Items menu
  //but some extras in case some of the files get deleted or renamed
  APP_TITLE = 'ScotSim';
  MAX_CR_RATIOS = 200;

  SNAP_DIST = 25; //Magic No for SnapDist

type
  TViewport = packed record
    Left, Bottom, Width, Height: GLInt;
  end;

  TOGLMatrix = array[0 .. 15] of Double;
  ViewModeType = (vmEdit, vmAdjust);

  TMeasureLine = record
    Pt: array[1 .. 2]of Point2D;
    HitIdx: array[1 .. 2]of Word;
    TextArea: RectType;
  end;

  CrRatioRec = record
    ID: Word;
    Pt: array[1 .. 2]of Point2D;
    CrRatio: Double;
    JointOk: Boolean;
  end;

var
  bDrawing: Bool = False;
  bEditing: Bool = True;
  EditItem: Word = 0;
  MinEditNumber: Integer =-1;
  EditTip: TipType;
  MovingScenePt: Point2D;
  CentrePt: Point2D =(X: 0; Y: 0);
  EditPt: Point2D;
  PickBuffer: array[1 .. MAX_ITEMS] of GLuint;
  DataFile: TFileName;

  bUseFlangeSide: Bool = True;
  bSnap: Bool = True;
  bAngleSnap: Bool = True;
  bShowGrid: Bool = True;
  bShowLip: Bool = False;
  bShowFlattenedLip: Bool = False;
  DebugPt: Point2D;
  DebugPtDefined: Bool = False;

  DynEntity: array of EntityRecType;
  OrientationDesc: array[otLeft .. otDown]of string=('Left', 'Right', 'Up', 'Down');

  DebugCirclePt: array[1 .. MAX_ITEMS]of Point2D;

  HiddenIdx: Integer = 0;
  SLMultiTrussErrors: TStringList;
  CSVFileName: TFileName = '';
  CSVStringList: TStringList;
  CSVTrussQuantity: Integer = 1;
  LastFilterIndex: Integer = 1; //remember the last Filter chosen
  CSVGauge: string= '';

  ViewMode: ViewModeType = vmEdit;
  MRUActions: array of TAction;
  LineThick: glFloat = 1;
  WM_USR_MESSAGE: DWORD = 0;
  bMakingParallel: Bool = False;
  bMeasuring: Bool = False;
  MeasureLine: TMeasureLine;

  MaxPanelSize: Integer = 500;

  CrRatios: array[1 .. MAX_CR_RATIOS]of CrRatioRec;

{$R *.dfm}

  //* Initialize settings
procedure InitDLL;
begin
  with FormSettings do
  begin
    LipHolePos := StrToFloat(LipHoleHeightEdit.Text);
    FlgHolePos := StrToFloat(FlangeHoleHeightEdit.Text);
    FrameHolePos := StrToFloat(txtFrameHoleHeight.Text);
    FrameHolePos2 := StrToFloat(txtFrameHole2Height.Text);
    TrussHoleDist := StrToFloat(HoleDistanceEdit.Text);
    PanelHoleDist := StrToFloat(txtPanelHoleDist.Text);
    //bUSJointing := chkUSJointing.Checked;
    //These are not for DLL
    bMinimiseLengths := chkMinimiseLengths.Checked;
    // ......... bShortenBottomHorzItems is always false now ......
    //bShortenBottomHorzItems := chkShortenBottomHorzItems.Checked;
    // ............................................................
    bRequire2PtWebToWeb := chkRequire2PtWebWeb.Checked;
    //if txtTrussHoleSize.Text <> '' then
    //if txtTrussHoleSize.Modified then
    TrussHoleSize := StrToFloat(txtTrussHoleSize.Text);
    //if txtPanelHoleSize.Text <> '' then
    //if txtPanelHoleSize.Modified then
    PanelHoleSize := StrToFloat(txtPanelHoleSize.Text);
    bTrussUseSwage := chkTrussUseSwage.Checked;
    TrussSwageSize := StrToFloat(txtTrussSwageLength.Text);
    bPanelUseSwage := chkPanelUseSwage.Checked;
    PanelSwageSize := StrToFloat(txtPanelSwageLength.Text);
    bEndLoadCut := chkEndLoadCut.Checked;
    EndLoadCutSize := StrToFloat(txtEndLoadCut.Text);
    bIgnoreDuplicateOps := chkIgnoreDuplicateOps.Checked;
    bIgnoreMinEndDistErrors := chkIgnoreHoleDistErrors.Checked;
    bVirtualMitre := chkVirtualMitre.Checked;

    bUseBoxWebbing := chkUseBoxWebbing.Checked;
    BoxWebHeight := StrToFloat(txtBoxWebHeight.Text);

    TrussJointGap := StrToFloat(JointGapEdit.Text);
    PanelJointGap := StrToFloat(txtPanelJointGap.Text);
    TrussLipSize := StrToFloat(txtLipSize.Text);
    PanelLipSize := StrToFloat(txtPanelLipSize.Text);
    TrussNotchSize := StrToFloat(NotchSizeEdit.Text);
    PanelNotchSize := StrToFloat(txtPanelNotchSize.Text);
    TrussCopeSize := StrToFloat(CopeSizeEdit.Text);
    PanelFlatSize := StrToFloat(txtFlattenSize.Text);
    TrussCopeNotchTol := StrToFloat(CopeTolEdit.Text);
    PanelFlatNotchTol := StrToFloat(txtFlatNotchTol.Text);
    CutWidth := StrToFloat(txtCutWidth.Text);

    HoleSize := TrussHoleSize / 2;
    JointGap := TrussJointGap;
    bFrames := pgc.ActivePageIndex = 1;
    LipSize := TrussLipSize;
    NotchSize := TrussNotchSize;
    CopeSize := TrussCopeSize;
    MinEndDist := TrussHoleDist;
    CopeNotchTol := TrussCopeNotchTol;
    frmMain.AppMenuPopup(nil, nil); //enable actions
    RectWidth := TrussRectWidth;

    if bFrames then
    begin
      HoleSize := PanelHoleSize / 2;
      JointGap := PanelJointGap;
      LipSize := PanelLipSize;
      NotchSize := PanelNotchSize;
      CopeSize := PanelFlatSize;
      MinEndDist := PanelHoleDist;
      CopeNotchTol := PanelFlatNotchTol;
      RectWidth := PanelRectWidth;
      //frmMain.actShowCopes.Caption := 'Show Flats';    //doesn't change the checkbox
    end;
    //else
    // frmMain.actShowCopes.Caption := 'Show Copes';

    frmMain.rgDebug.Refresh;
    VertJointGap := StrToFloat(txtVertJointGap.Text);
    MinEndDist := MinEndDist + HoleSize; //change it to steel past the end of the hole, v.190
  end;
  frmMain.WriteIni;
  if HoleFinder <> nil then
  begin
    try
      //HoleFinder.InitJoining(JointGap, MinEndDist, FlgHolePos, LipHolePos);
      //HoleFinder.ShortBottomHorz := FormSettings.chkShortenBottomHorzItems.Checked;
      //HoleFinder.SettingsFile := PChar('C:\Users\Bruce\Documents\SCS\ScotSim\ScotSim_256\ScotSim.ini');   //C:\Program Files\SCS\ScotSim\
      HoleFinder.SettingsFile := PChar(IniFileName);
    except
      on E: EOleSysError do
      begin
        MessageDlg(E.Message, mtError,[mbOK], 0);
        exit;
      end;
      else
        MessageDlg('Could not initialise the HoleFinder object.', mtInformation,[mbOK], 0);
        exit;
    end;
  end;
  bDllIsInitialised := True;
end;

//* Convert a screen coord to a 2D point
procedure GetWorldCoords(X, Y: Double; var w: Point2D);
var //CutDown 2D version of the original, from OGL v239
  Viewport: TViewport;
  MvMatrix, ProjMatrix: TOGLMatrix;
  Realy: Double;
  wz: Double;
begin
  glGetIntegerV(GL_VIEWPORT, @Viewport);
  glGetDoubleV(GL_MODELVIEW_MATRIX, @MvMatrix);
  glGetDoubleV(GL_PROJECTION_MATRIX, @ProjMatrix);
  Realy := Viewport.Height - Y;

  gluUnProject(X, Realy, 0, @MvMatrix, @ProjMatrix, @Viewport, w.X, w.Y, wz);

  w.X := w.X * Scale; w.Y := w.Y * Scale;
end;

//* Convert the screen centre coord to a 2D point
function ViewportCentreAsWorldPt: Point2D;
var
  scrPt0: Point2D;
  Viewport: TViewport;
begin
  glGetIntegerV(GL_VIEWPORT, @Viewport);
  scrPt0.X := Viewport.Width / 2; scrPt0.Y := Viewport.Height / 2;
  GetWorldCoords(scrPt0.X, scrPt0.Y, Result);
end;

//* Move the point to the centre of the screen
procedure CentrePointInViewport(AlignPt: Point2D);
var
  Pt0: Point2D;
  dX, dY: Double;
begin
  Pt0 := ViewportCentreAsWorldPt;
  dX := (Pt0.X - AlignPt.X)/ Scale;
  dY := (Pt0.Y - AlignPt.Y)/ Scale;
  glTranslated(dX, dY, 0);
end;

//* Save the Rects to a data file
procedure SaveTrussDataToFile(AFileName: TFileName; bMetric: Bool);
var
  i: Word;
  j: Byte;
  SL: TStringList;
  sTrussName: string[10];
  sX, sY: string;
  X, Y: Double;
begin
  SL := TStringList.Create;
  try
    sTrussName := RawByteString(ExtractFileName(ChangeFileExt(AFileName, '')));
    for i := 1 to pred(CurrentItem)do
    begin
      if i = 1 then
      begin
        if bMetric then //end dist only used for trusses
        begin
          SL.Add('mm');
          //SL.Add( FloatToStr(MinEndDist) );
          SL.Add(FloatToStr(TrussHoleDist))
        end
        else begin
          SL.Add('inches');
          //SL.Add( FloatToStr(MinEndDist / MM_IN_AN_INCH) );
          SL.Add(FloatToStr(TrussHoleDist / MM_IN_AN_INCH));
        end;
      end;
      SL.Add(sTrussName);
      if CSVTrussQuantity = 0 then
        CSVTrussQuantity := 1;
      if i = 1 then
        SL.Add(IntToStr(CSVTrussQuantity)); //('1');
      //SL.Add(NAME_PREFIX + IntToStr(i));
      if TrussRects.bNonRFItem[i] then
        SL.Add(HIDDEN_ITEM_CHAR + TrussRects.ItemName[i])
      else
        SL.Add(TrussRects.ItemName[i]);
      SL.Add(TrussRects.iType[i]); //   sWEB  sCHORD
      for j := 1 to 4 do
      begin
        X := TrussRects.Item[i].Pt[j].X;
        Y := TrussRects.Item[i].Pt[j].Y;
        if not bMetric then
        begin
          X := X / MM_IN_AN_INCH; Y := Y / MM_IN_AN_INCH;
        end;
        sX := #9 + FloatToStr(X);
        sY := #9 + FloatToStr(Y);
        SL.Add(sX);
        SL.Add(sY);
      end;
    end;
    //Operations, put them at the end
    for i := 1 to pred(CurrentItem)do
    begin
      for j := 1 to TrussRects.OpCount[i] do
        if (TrussRects.Op[i, j].Kind > okNone)then
        begin
          SL.Add(sTrussName);
          SL.Add(TrussRects.ItemName[i]);
          if TrussRects.Op[i, j].Kind in [okLipHole, okFlgHole] then
            SL.Add('Insert')
          else
            SL.Add(OpToString(TrussRects.Op[i, j]));
          X := TrussRects.Op[i, j].p.X;
          Y := TrussRects.Op[i, j].p.Y;
          if not bMetric then
          begin
            X := X / MM_IN_AN_INCH; Y := Y / MM_IN_AN_INCH;
          end;
          sX := #9 + FloatToStr(X);
          sY := #9 + FloatToStr(Y);
          SL.Add(sX);
          SL.Add(sY);
        end;
    end;
    SL.SaveToFile(AFileName);
  finally
    SL.Free;
  end;
end;

//* Return the index of the TrussRect with the name s
function ItemIndexFromString(s: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  if s = '' then
    exit;
  if CharInSet(s[1], ['0' .. '9'])then
  begin
    Result := StrToInt(s);
    exit;
  end;
  for i := 1 to MAX_ITEMS do // High(TrussRects.ItemName)do
    if SameText(s, TrussRects.ItemName[i])then
    begin
      Result := i;
      exit;
    end;
end;

//* Move TrussRects.Item[Idx] to the centre of the screen
procedure CentreItemInWidow(Idx: Integer);
var
  p: Point2D;
begin
  p := MidPoint2D(TrussRects.Item[Idx].Pt[1], TrussRects.Item[Idx].Pt[3]);
  CentrePointInViewport(p);
  CentrePt := p;
end;

//* Clean up the dynamic array
procedure ClearDynEntity;
begin
  SetLength(DynEntity, 0); DynEntity := nil;
end;

//* Zoom routines
//* Speed determines the extent of the zoom,
//* 1 = normal, 1.5 = faster (happens when Ctrl is pressed as well)
//* CentrePt is moved to the screen cntre after the zoom
procedure TfrmMain.ZoomIn(Speed: Single);
begin
  Scale := Scale / (SCALE_FACTOR * Speed);
  CentrePointInViewport(CentrePt);
  Paint;
end;

procedure TfrmMain.ZoomOut(Speed: Single);
begin
  Scale := Scale * SCALE_FACTOR * Speed;
  CentrePointInViewport(CentrePt);
  Paint;
end;

//* Save settings to the INI file
procedure TfrmMain.WriteIni;
//const
//  STEEL_DESIGNER_TEMP_FILENAME = '~t~e~m~p.txt';
var
  //bIsSDTempFile: Bool;
  i: Integer;
begin
  if IniFileName = '' then
    exit;
  with TIniFile.Create(IniFileName)do
  begin
    try
      //bIsSDTempFile := ExtractFileName(DataFile) = STEEL_DESIGNER_TEMP_FILENAME;
      //Settings Form
      WriteFloat(SETTINGS_SECTION, 'JointGap', TrussJointGap);
      WriteFloat(SETTINGS_SECTION, 'LipHolePos', LipHolePos);
      WriteFloat(SETTINGS_SECTION, 'FlgHolePos', FlgHolePos);
      WriteFloat(SETTINGS_SECTION, 'FrameHolePos', FrameHolePos);
      WriteFloat(SETTINGS_SECTION, 'FrameHolePos2', FrameHolePos2);
      //if (not bIsSDTempFile) then
      WriteBool(SETTINGS_SECTION, 'Frames', bFrames);
      WriteFloat(SETTINGS_SECTION, 'MinEndDist', TrussHoleDist);

      WriteFloat(SETTINGS_SECTION, 'NotchSize', TrussNotchSize);
      WriteFloat(SETTINGS_SECTION, 'CopeSize', TrussCopeSize);
      WriteFloat(SETTINGS_SECTION, 'CopeNotchTol', TrussCopeNotchTol);
      WriteBool(SETTINGS_SECTION, 'Minimise', bMinimiseLengths);
      //WriteBool(SETTINGS_SECTION, 'USJointing', bUSJointing);
      WriteFloat(SETTINGS_SECTION, 'LipSize', TrussLipSize);
      WriteFloat(SETTINGS_SECTION, 'HoleSize', TrussHoleSize);

      WriteBool(SETTINGS_SECTION, 'Swage', bTrussUseSwage);
      WriteFloat(SETTINGS_SECTION, 'TrussSwageSize', TrussSwageSize);

      //Panel settings
      WriteFloat(PANELS_SECTION, 'HoleSize', PanelHoleSize);
      WriteFloat(PANELS_SECTION, 'JointGap', PanelJointGap);
      WriteFloat(PANELS_SECTION, 'VertJointGap', VertJointGap);
      WriteFloat(PANELS_SECTION, 'LipSize', PanelLipSize);
      WriteFloat(PANELS_SECTION, 'NotchSize', PanelNotchSize);
      WriteFloat(PANELS_SECTION, 'FlatSize', PanelFlatSize);
      WriteFloat(PANELS_SECTION, 'CutWidth', CutWidth);
      WriteFloat(PANELS_SECTION, 'MinEndDist', PanelHoleDist);
      WriteFloat(PANELS_SECTION, 'FlatNotchTol', PanelFlatNotchTol);
      WriteBool(PANELS_SECTION, 'Swage', bPanelUseSwage);
      WriteFloat(PANELS_SECTION, 'Swage Size', PanelSwageSize);
      WriteBool(PANELS_SECTION, 'EndLoadCut', bEndLoadCut);
      WriteFloat(PANELS_SECTION, 'EndLoadCutSize', EndLoadCutSize);

      WriteBool(SETTINGS_SECTION, 'IgnoreDuplicateOps', bIgnoreDuplicateOps);
      WriteBool(SETTINGS_SECTION, 'IgnoreMinEndDistErrors', bIgnoreMinEndDistErrors);
      WriteBool(SETTINGS_SECTION, 'VirtualMitre', bVirtualMitre);

      WriteBool(SETTINGS_SECTION, 'UseBoxWebbing', bUseBoxWebbing);
      WriteFloat(SETTINGS_SECTION, 'BoxWebbingHeight', BoxWebHeight);

      //Menu Settings
      //WriteFloat(MENU_OPTIONS, 'HoleSize', HoleSize);
      WriteBool(MENU_OPTIONS, 'ShowHoleFound', actShowHolePts.Checked);
      WriteBool(MENU_OPTIONS, 'Snap', bSnap);
      WriteBool(MENU_OPTIONS, 'AngleSnap', bAngleSnap);
      WriteBool(MENU_OPTIONS, 'ShowGrid', bShowGrid);
      WriteBool(MENU_OPTIONS, 'ShowLip', bShowLip);
      WriteBool(MENU_OPTIONS, 'ShowFlattenedLip', bShowFlattenedLip);
      WriteBool(MENU_OPTIONS, 'BoldLines', actBold.Checked);
      WriteBool(MENU_OPTIONS, 'ShowHolePositions', actShowHolePositions.Checked);

      //if (not bIsSDTempFile) then
      WriteString(OPTIONS_SETTINGS, 'DataFile', DataFile);
      WriteFloat(OPTIONS_SETTINGS, 'RectWidths', RectWidth);
      WriteString(OPTIONS_SETTINGS, 'Gauge', Gauge);
      //WriteBool(OPTIONS_SETTINGS, 'Shorten Bottom Horz Items', bShortenBottomHorzItems);
      WriteBool(OPTIONS_SETTINGS, '2 Point Web-Web Joins', bRequire2PtWebToWeb);

      //Font
      WriteString(FONT_SECTION, 'Face', FontFace);
      WriteInteger(FONT_SECTION, 'Height', FontHeight);
      WriteInteger(FONT_SECTION, 'Weight', FontWeight);
      WriteBool(FONT_SECTION, 'Italic', FontItalic);

      WriteString(OPTIONS_SETTINGS, 'ScotTrussSettings', ScotTrussSettingsFile);
      WriteString(OPTIONS_SETTINGS, 'ScotRFSettings', ScotRFSettingsFile);

      WriteBool(OPTIONS_SETTINGS, 'Maximised', (WindowState = wsMaximized));
      if WindowState = wsNormal then
      begin
        WriteInteger(OPTIONS_SETTINGS, 'Left', Left);
        WriteInteger(OPTIONS_SETTINGS, 'Top', Top);
        WriteInteger(OPTIONS_SETTINGS, 'Width', Width);
        WriteInteger(OPTIONS_SETTINGS, 'Height', Height);
      end;

      //Ribbon
      WriteBool(RIBBON_SETTINGS, 'Minimised', Ribbon1.Minimized);
      WriteInteger(RIBBON_SETTINGS, 'QA position', ord(Ribbon1.QuickAccessToolbar.Position));
      EraseSection('Recent');
      with Ribbon1.ApplicationMenu.Menu.RecentItems do
        for i := 0 to pred(Count)do
          WriteString('Recent', IntToStr(i), Items[i].Hint);
      //Show Notches, Copes/Flats and Swages
      WriteBool(OPTIONS_SETTINGS, 'Notches', actShowNotches.Checked);
      WriteBool(OPTIONS_SETTINGS, 'Copes', actShowCopes.Checked);
      WriteBool(OPTIONS_SETTINGS, 'Swages', actShowSwages.Checked);
    finally
      Free;
    end;
  end;
end;

//* Load settings from the INI file
procedure TfrmMain.ReadIni;
var
  L, T, w, H, i: Integer;
  s: string;
begin
  with TIniFile.Create(IniFileName)do
  begin
    try
      //Settings Form
      bFrames := ReadBool(SETTINGS_SECTION, 'Frames', bFrames);
      TrussJointGap := ReadFloat(SETTINGS_SECTION, 'JointGap', TrussJointGap);
      LipHolePos := ReadFloat(SETTINGS_SECTION, 'LipHolePos', LipHolePos);
      FlgHolePos := ReadFloat(SETTINGS_SECTION, 'FlgHolePos', FlgHolePos);
      FrameHolePos := ReadFloat(SETTINGS_SECTION, 'FrameHolePos', FrameHolePos);
      FrameHolePos2 := ReadFloat(SETTINGS_SECTION, 'FrameHolePos2', FrameHolePos2);
      TrussHoleDist := ReadFloat(SETTINGS_SECTION, 'MinEndDist', TrussHoleDist);

      TrussNotchSize := ReadFloat(SETTINGS_SECTION, 'NotchSize', TrussNotchSize);
      TrussCopeSize := ReadFloat(SETTINGS_SECTION, 'CopeSize', TrussCopeSize);
      TrussCopeNotchTol := ReadFloat(SETTINGS_SECTION, 'CopeNotchTol', TrussCopeNotchTol);
      bMinimiseLengths := ReadBool(SETTINGS_SECTION, 'Minimise', bMinimiseLengths);
      //bUSJointing := ReadBool(SETTINGS_SECTION, 'USJointing', bUSJointing);
      TrussLipSize := ReadFloat(SETTINGS_SECTION, 'LipSize', TrussLipSize);
      TrussHoleSize := ReadFloat(SETTINGS_SECTION, 'HoleSize', TrussHoleSize);

      bTrussUseSwage := ReadBool(SETTINGS_SECTION, 'Swage', bTrussUseSwage);
      TrussSwageSize := ReadFloat(SETTINGS_SECTION, 'TrussSwageSize', TrussSwageSize);

      //Panel settings
      PanelHoleSize := ReadFloat(PANELS_SECTION, 'HoleSize', PanelHoleSize);
      PanelJointGap := ReadFloat(PANELS_SECTION, 'JointGap', PanelJointGap);
      PanelLipSize := ReadFloat(PANELS_SECTION, 'LipSize', PanelLipSize);
      VertJointGap := ReadFloat(PANELS_SECTION, 'VertJointGap', VertJointGap);
      PanelNotchSize := ReadFloat(PANELS_SECTION, 'NotchSize', PanelNotchSize);
      PanelFlatSize := ReadFloat(PANELS_SECTION, 'FlatSize', PanelFlatSize);
      PanelFlatNotchTol := ReadFloat(PANELS_SECTION, 'FlatNotchTol', PanelFlatNotchTol);
      CutWidth := ReadFloat(PANELS_SECTION, 'CutWidth', CutWidth);
      PanelHoleDist := ReadFloat(PANELS_SECTION, 'MinEndDist', PanelHoleDist);
      bPanelUseSwage := ReadBool(PANELS_SECTION, 'Swage', bPanelUseSwage);
      PanelSwageSize := ReadFloat(PANELS_SECTION, 'Swage Size', PanelSwageSize);
      bEndLoadCut := ReadBool(PANELS_SECTION, 'EndLoadCut', bEndLoadCut);
      EndLoadCutSize := ReadFloat(PANELS_SECTION, 'EndLoadCutWidth', EndLoadCutSize);

      bIgnoreDuplicateOps := ReadBool(SETTINGS_SECTION, 'IgnoreDuplicateOps', False);
      bIgnoreMinEndDistErrors := ReadBool(SETTINGS_SECTION, 'IgnoreMinEndDistErrors', False);
      bVirtualMitre := ReadBool(SETTINGS_SECTION, 'VirtualMitre', bVirtualMitre);

      bUseBoxWebbing := ReadBool(SETTINGS_SECTION, 'UseBoxWebbing', bUseBoxWebbing);
      BoxWebHeight := ReadFloat(SETTINGS_SECTION, 'BoxWebbingHeight', BoxWebHeight);

      //Menu Settings
      HoleSize := TrussHoleSize / 2;
      JointGap := TrussJointGap;
      LipSize := TrussLipSize;
      NotchSize := TrussNotchSize;
      CopeSize := TrussCopeSize;
      MinEndDist := TrussHoleDist;
      CopeNotchTol := TrussCopeNotchTol;
      if bFrames then
      begin
        HoleSize := PanelHoleSize / 2;
        JointGap := PanelJointGap;
        LipSize := PanelLipSize;
        NotchSize := PanelNotchSize;
        CopeSize := PanelFlatSize;
        MinEndDist := PanelHoleDist;
        CopeNotchTol := PanelFlatNotchTol;
        actShowCopes.Caption := TranslateStr('Show Flats') + ' '
      end
      else
        actShowCopes.Caption := TranslateStr('Show Copes') + ' ';

      actShowHolePts.Checked := ReadBool(MENU_OPTIONS, 'ShowHoleFound', False);
      bSnap := ReadBool(MENU_OPTIONS, 'Snap', bSnap);
      actSnapping.Checked := bSnap;
      bAngleSnap := ReadBool(MENU_OPTIONS, 'AngleSnap', bAngleSnap);
      actAngleSnapping.Checked := bAngleSnap;
      bShowGrid := ReadBool(MENU_OPTIONS, 'ShowGrid', bShowGrid);
      actShowGrid.Checked := bShowGrid;
      bShowLip := ReadBool(MENU_OPTIONS, 'ShowLip', bShowLip);
      actShowLip.Checked := bShowLip;
      bShowFlattenedLip := ReadBool(MENU_OPTIONS, 'ShowFlattenedLip', bShowFlattenedLip);
      actShowFlattenedLip.Checked := bShowFlattenedLip;
      actBold.Checked := ReadBool(MENU_OPTIONS, 'BoldLines', False);
      actBoldExecute(nil);
      actShowHolePositions.Checked := ReadBool(MENU_OPTIONS, 'ShowHolePositions', actShowHolePositions.Checked);

      DataFile := ReadString(OPTIONS_SETTINGS, 'DataFile', ExtractFilePath(ParamStr((0))));
      TrussRectWidth := ReadFloat(OPTIONS_SETTINGS, 'RectWidths', RECT_HEIGHTS);
      PanelRectWidth := ReadFloat(OPTIONS_SETTINGS, 'PanelRectWidths', PanelRectWidth);
      RectWidth := TrussRectWidth;
      if bFrames then
        RectWidth := PanelRectWidth;
      Gauge := ReadString(OPTIONS_SETTINGS, 'Gauge', '');
      // ......... bShortenBottomHorzItems is always false now ......
      //bShortenBottomHorzItems := False;  //its default is false in GlobalU, this ensures it, var removed v.480
      //bShortenBottomHorzItems := ReadBool(OPTIONS_SETTINGS, 'Shorten Bottom Horz Items', bShortenBottomHorzItems);
      // ............................................................
      bRequire2PtWebToWeb := ReadBool(OPTIONS_SETTINGS, '2 Point Web-Web Joins', bRequire2PtWebToWeb);
      //Font
      FontFace := ReadString(FONT_SECTION, 'Face', FontFace);
      FontHeight := ReadInteger(FONT_SECTION, 'Height', FontHeight);
      FontWeight := ReadInteger(FONT_SECTION, 'Weight', FontWeight);
      FontItalic := ReadBool(FONT_SECTION, 'Italic', FontItalic);

      ScotTrussSettingsFile := ReadString(OPTIONS_SETTINGS, 'ScotTrussSettings', '');
      ScotRFSettingsFile := ReadString(OPTIONS_SETTINGS, 'ScotRFSettings', '');

      if not ReadBool(OPTIONS_SETTINGS, 'Maximised', False)then
      begin
        w := ReadInteger(OPTIONS_SETTINGS, 'Width', Width);
        if w < Constraints.MinWidth then
          w := Constraints.MinWidth;
        H := ReadInteger(OPTIONS_SETTINGS, 'Height', Height);
        if H < Constraints.MinHeight then
          H := Constraints.MinHeight;
        L := ReadInteger(OPTIONS_SETTINGS, 'Left', (Screen.Width - w)div 2);
        if (L + w < 0)or(L >= Screen.Width)then
          L := (Screen.Width - w)div 2;
        T := ReadInteger(OPTIONS_SETTINGS, 'Top', (Screen.Height - H)div 2);
        if (T + H < 0)or(T >= Screen.Height)then
          T := (Screen.Height - H)div 2;
        SetBounds(L, T, w, H);
      end
      else
        WindowState := wsMaximized;

      //Ribbon
      Ribbon1.Minimized := ReadBool(RIBBON_SETTINGS, 'Minimised', False);
      Ribbon1.QuickAccessToolbar.Position := TQuickAccessToolbar.TQATPosition(ReadInteger(RIBBON_SETTINGS, 'QA position', ord(qpBottom)));
      i := 0;
      repeat
        s := ReadString('Recent', IntToStr(i), '');
        if (s <> '')and(FileExists(s))then
          AddToMRU(s, False);
        inc(i);
      until s = '';
      //Show Notches, Copes/Flats and Swages
      actShowNotches.Checked := ReadBool(OPTIONS_SETTINGS, 'Notches', True);
      actShowCopes.Checked := ReadBool(OPTIONS_SETTINGS, 'Copes', True);
      actShowSwages.Checked := ReadBool(OPTIONS_SETTINGS, 'Swages', True);
    finally
      Free;
    end;
  end;
end;

procedure TfrmMain.Ribbon1RecentItemClick(Sender: TObject; FileName: string; Index: Integer);
begin
  //OpenTrussData(FileName);
  if Ribbon1.ApplicationMenu.Menu.RecentItems[Index] <> nil then
    OpenTrussData(Ribbon1.ApplicationMenu.Menu.RecentItems[Index].Hint);
end;

procedure TfrmMain.Ribbon1TabChange(Sender: TObject; const NewIndex,
  OldIndex: Integer; var AllowChange: Boolean);
begin
  AppMenuPopup(nil, nil);
end;

//* Routine to handle windows drop files message
procedure TfrmMain.WMDropFiles(var Msg: TWMDropFiles);
var
  cFileName: array[0 .. pred(MAX_PATH)]of Char;
begin
  try
    DragQueryFile(Msg.Drop, 0, cFileName, MAX_PATH);
    OpenTrussData(cFileName);
  finally
    DragFinish(Msg.Drop);
  end;
end;

//* Set locked or unlocked hint
procedure TfrmMain.SetEditsHint;
var
  s: string;
  i: Integer;
begin
  s := 'Prevent';
  if actLock.Checked then
    s := 'Allow';
  actLock.Hint := format(RECTS_EDIT_HINT, [s]);

  for i := 0 to pred(TipsMgr.ScreenTips.Count)do
    if TipsMgr.ScreenTips[i].Action = actLock then
    begin
      TipsMgr.ScreenTips[i].Description.Text := actLock.Hint;
      break;
    end;
end;

//* Look for blank hints in the Actions, and load their caption as a hint
procedure TfrmMain.LoadActionHints;
var
  i: Integer;
begin
  for i := 0 to pred(ComponentCount)do
    if (Components[i] is TAction)then
      with (Components[i] as TAction)do
        if Hint = '' then
          Hint := Caption;
end;

//* Enable actions if there's at least one rect
procedure TfrmMain.AppMenuPopup(Sender: TObject; Item: TCustomActionControl);
begin
  actSaveAs.Enabled := (CurrentItem > 1); //and(not bFrames);
  actSaveAsImperial.Enabled := (CurrentItem > 1); //and(not bFrames);
  actSaveSimData.Enabled := (CurrentItem > 1)and(Length(DynEntity) > 0);

  //* Hide HoleAuto items if we're in Panels,
  //* Disable the Find menu item if there are no rects
  actFindItem.Enabled := (CurrentItem > 1);
  actShowHolePts.Visible := not bFrames;
  actHoleAutoCoords.Enabled := not bFrames;
//  actShowSwages.Enabled := bFrames;        // trusses now can also have swages
end;

procedure TfrmMain.CentreTheHelpPanel;
begin
  pnlHelp.Left := (ClientWidth - pnlHelp.Width) div 2;
  pnlHelp.Top := (ClientHeight - pnlHelp.Height + Ribbon1.Height) div 2;
end;

procedure ConvertBitmapToGrayscale(const Bitmap: TBitmap);
type
  PPixelRec = ^TPixelRec;
  TPixelRec = packed record
    b: Byte;
    g: Byte;
    r: Byte;
    Reserved: Byte;
  end;
const
  FACTOR = 3; //the larger the paler the gray image
var
  X: Integer;
  Y: Integer;
  p: PPixelRec;
  Gray: Byte;
begin
  Bitmap.PixelFormat := pf32Bit;
  for Y := 0 to (Bitmap.Height - 1) do
  begin
    p := Bitmap.ScanLine[Y];
    for X := 0 to (Bitmap.Width - 1) do
    begin
      Gray := Round(0.30 * p.r + 0.59 * p.g + 0.11 * p.b);
      Gray := (Gray + pred(FACTOR) * 255)div FACTOR; //Gray := Gray div 8 * 7;

      p.r := Gray;
      p.g := Gray;
      p.b := Gray;
      inc(p);
    end;
  end;
end;

procedure CreateGreyImages(Src, Tgt: TImageList);
var
  i: Integer;
  BMP: TBitmap;
begin
  BMP := TBitmap.Create;
  try
    BMP.Width := Src.Width * Src.Count;
    BMP.Height := Src.Height;
    BMP.TransparentColor := clWhite;
    BMP.Transparent := True;
    //BMP.Canvas.Brush.Color := clWhite;
    BMP.Canvas.FillRect(BMP.Canvas.ClipRect);

    for i := 0 to pred(Src.Count) do
      Src.Draw(BMP.Canvas, i * Src.Width, 0, i);

    ConvertBitmapToGrayscale(BMP);
    Tgt.AddMasked(BMP, clWhite);
  finally
    BMP.Free;
  end;
end;

//* Look for TrussSim in its default folder, and if it exists replace it with this
procedure UpdateTrussSim;
var
  sTrussSimFile, sTWX0SimFile, sSimFileName: string;
begin
  sSimFileName := ParamStr(0);

  sTrussSimFile := 'c:\twx0\TrussSim.exe';
  if FileExists(sTrussSimFile) then
    CopyFile(PChar(sSimFileName), PChar(sTrussSimFile), False);

  sTWX0SimFile := 'c:\twx0\' + ExtractFileName(sSimFileName);
  if FileExists(sTWX0SimFile) then
    CopyFile(PChar(sSimFileName), PChar(sTWX0SimFile), False);
end;

// from
//  http://qc.embarcadero.com/wc/qcmain.aspx?d=3730
{
 procedure DisableProcessWindowsGhosting;
 var
 DisableProcessWindowsGhostingProc: procedure;
 begin
 DisableProcessWindowsGhostingProc := GetProcAddress(GetModuleHandle('user32.dll'), 'DisableProcessWindowsGhosting');
 if Assigned(DisableProcessWindowsGhostingProc) then
 DisableProcessWindowsGhostingProc;
 end;                                             }

//* Replaces the TLight component
procedure ApplyLight;
const
  A012 = 1;
  D012 = 0;//0.001;
var
  FAmbient, FDiffuse{, FSpecular}: array[0 .. 3]of GLfloat; //red,green,blue,alpha
begin
  glEnable(GL_LIGHT0);

  FAmbient[0] := A012;
  FAmbient[1] := A012;
  FAmbient[2] := A012;
  FAmbient[3] := 1.0;
  FDiffuse[0] := D012;
  FDiffuse[1] := D012;
  FDiffuse[2] := D012;
  FDiffuse[3] := 1.0;
  //FSpecular[0] := 0;  FSpecular[1] := 0;  FSpecular[2] := 0;  FSpecular[3] := 0;
  glLightfv(GL_LIGHT0, GL_AMBIENT, @FAmbient);
  glLightfv(GL_LIGHT0, GL_DIFFUSE, @FDiffuse);
  //glLightfv(GL_LIGHT0, GL_SPECULAR,@FSpecular);
end;

//* Init calls, including OpenGL, the INI file, the COM DLL and Drag-Drop handling
procedure TfrmMain.FormCreate(Sender: TObject);
var
  ICO: TIcon;
  i, j, k: Integer;
  SL: TStringList;
  s: string;
begin
  //ReportMemoryLeaksOnShutdown := True;
  Application.OnException := nil; //override cOpenGL's event

  {
   if (Win32Platform = VER_PLATFORM_WIN32_NT)
   and(Win32MajorVersion = 5)//then  //Windows 2000 and XP
   and(Win32MinorVersion = 0)then    //Windows 2000
   DisableProcessWindowsGhosting;        }

  Application.Title := APP_TITLE;
  Caption := APP_TITLE;
  Ribbon1.Caption := Caption;

  glLightModeli(GL_LIGHT_MODEL_LOCAL_VIEWER, Integer(GL_TRUE));
  glShadeModel(GL_FLAT); //performance tip, red book p679
  ApplyLight;

  //ApplyLight;
  //glEnable(GL_COLOR_MATERIAL);
  //AntiAlias
  glEnable(GL_LINE_SMOOTH);
  glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
  glEnable(GL_POINT_SMOOTH);
  glHint(GL_POINT_SMOOTH_HINT, GL_NICEST);
  glEnable(GL_POLYGON_SMOOTH);
  glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  //DataFile := ExtractFilePath( ParamStr(0) ) + 'Truss.txf';

  IniFileName := ChangeFileExt(ParamStr(0), '.ini');
  ReadIni;
  SetEditsHint;
  LoadActionHints;

  Create2DFont;

  //HoleFinder := THoleFinder.Create(Application);
  try
    HoleFinder := CreateComObject(CLASS_HoleFinder) as IHoleFinder2;
  except
    HoleFinder := nil;
    actShowHolePts.Checked := False;
    actShowHolePts.Enabled := False;
    actHoleAutoCoords.Enabled := False;
    //raise;
  end;

  ICO := TIcon.Create;
  try
    ICO.Width := ilSmall.Width;
    ICO.Height := ilSmall.Height;
    ilSmall.GetIcon(actHelp.ImageIndex, ICO);
    imgHelpIcon.Picture.Assign(ICO);
  finally
    ICO.Free;
  end;

  CreateGreyImages(ilSmall, ilSmallDis);
  CreateGreyImages(ilLarge, ilLargeDis);

  //Ribbon1.Minimized := True;
  //Ribbon1.QuickAccessToolbar.Position := qpBottom;
  Ribbon1.ApplicationMenu.Menu.OnPopup := AppMenuPopup;

  DragAcceptFiles(Handle, True);

  TranslateForm(Self);
  for i := 0 to pred(TipsMgr.ScreenTips.Count) do
    with TipsMgr.ScreenTips.Items[i] do
    begin
      Header := TranslateStr(Header);
      if Description.Count < 2 then
        Description.Text := TranslateStr(Trim(Description.Text))
      else begin
        s := '';
        for j := 0 to pred(Description.Count) do
          if Trim(Description[j]) <> '' then
            s := s + TranslateStr(Trim(Description[j])) + #13#10;
        Description.Text := Trim(s);
      end;
    end;

  SL := TStringList.Create;
  try
    SL.Text := Label1.Caption;
    Label1.Caption := '';
    for i := 0 to pred(SL.Count) do
      if Trim(SL[i]) <> '' then
        Label1.Caption := Label1.Caption + TranslateStr(Trim(SL[i])) + #13#10;
    Label1.Caption := Trim(Label1.Caption);
  finally
    SL.Free;
  end;

  //Ribbon menu items with no action
  for i := 0 to pred(actMgr.ActionBars.Count) do
    for j := 0 to pred(actMgr.ActionBars[i].Items.Count) do
      for k := 0 to pred(actMgr.ActionBars[i].Items[j].Items.Count) do
        with actMgr.ActionBars[i].Items[j].Items[k]do
          if (Action = nil)and(Caption <> '-') then
          begin
            s := StripHotkey(Caption);
            if not SameText(s, Caption) then
              Caption := s;
            Caption := TranslateStr(Caption);
          end;
  //Not sure why this fixes Show Copes on the Debug Ribbon Group
  //rgDebug.Items[5].Caption := TranslateStr(rgDebug.Items[5].Caption) + ' ';
  if PixelsPerInch > 96 then //patch a delphi ribbon issue with text on big buttons and long captions
  begin
    rgEditing.Items[8].Caption := 'Update';
    rgAdjust.Items[0].Caption := 'Rectangles';
    rgAdjust.Items[1].Caption := 'Joints';
  end;

  UpdateTrussSim;
end;

  //* Mouse wheel events, trigger the zoom
procedure TfrmMain.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  Speed: Single;
begin
  Speed := 1;
  if (ssCtrl in Shift)then
    Speed := 1.5;
  ZoomIn(Speed);
end;

procedure TfrmMain.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
var
  Speed: Single;
begin
  Speed := 1;
  if (ssCtrl in Shift)then
    Speed := 1.5;
  ZoomOut(Speed);
end;

procedure TfrmMain.FormResize(Sender: TObject);
var
  Ratio: Double;
begin
  glViewport(0, 0, ClientWidth, ClientHeight);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
  Ratio := ClientWidth / ClientHeight;
  glOrtho(-Ratio, Ratio, -1, 1, 1,-1);

  CentrePointInViewport(CentrePt);

  CentreTheHelpPanel;

  Paint;
end;

//* Display Routine for the lip line of TrussRects.Item[Idx]
procedure DisplayLipLine(Idx: Word);
var
  Line, L2: LineType2D;
  ARect: RectType;
  i: Byte;
  V: Vector2D;
begin
  if not(bShowLip or (bShowFlattenedLip and bFrames)) then
    exit;

  case ViewMode of
    vmEdit: ARect := TrussRects.Item[Idx];
    vmAdjust: for i := 1 to 4 do
        ARect.Pt[i] := DynEntity[pred(Idx)].Pt[i];
  end;

  with ARect do
  begin
    V := Vector2DFrom2DPoints(Pt[4], Pt[1]);
    //Actual Lip
    if bShowLip then
    begin
      Line.Pt[1] := Point2DFromParametricEquation(Pt[4], V, LipSize);
      Line.Pt[2] := Point2DFromParametricEquation(Pt[3], V, LipSize);
    end;
    //Flattened Lip
    if (bShowFlattenedLip and bFrames) then
    begin
      L2.Pt[1] := Point2DFromParametricEquation(Pt[4], V, -LipSize);
      L2.Pt[2] := Point2DFromParametricEquation(Pt[3], V, -LipSize);
    end;
  end;

  SetOGLColor(clGray);
  if bShowLip then
    Draw2DLine(Line);
  if (bShowFlattenedLip and bFrames) then
    Draw2DLine(L2);
end;

//* Display Routine for TrussRects.Item[Idx]
procedure TfrmMain.DisplayTrussRect(Idx: Word);
var
  i: Byte;
  n: Word;
  s: AnsiString;
  sOp: string;
  p: Point2D;
  V: Vector2D;
begin
  {if Idx < CurrentItem then
   glLoadName(Idx);  }
  with TrussRects.Item[Idx] do
  begin
    s := TrussRects.ItemName[Idx];
    if s <> '' then
    begin
      // quarter way point
      p := MidPoint2D(Pt[1], Pt[2]);
      p := MidPoint2D(p, Pt[1]);
      //offset from the edge
      V := Vector2DFrom2DPoints(Pt[4], Pt[1]);
      p := Point2DFromParametricEquation(p, V, 20);
      Write2DFont(s, 0, 0, 0, p.X, p.Y, 0);
    end;
    //glLineWidth(2);
    SetOGLColor(1, 0, 0);
    Draw2DLine(Pt[1], Pt[2]);

    SetOGLColor(0, 0, 0);
    //glLineWidth(1);
    glBegin(GL_LINE_STRIP);
    for i := 2 to 4 do
      glVertex4d(Pt[i].X, Pt[i].Y, 0, Scale);
    glVertex4d(Pt[1].X, Pt[1].Y, 0, Scale);
    glEnd;

    DisplayLipLine(Idx);

    //glEnable(GL_BLEND);
    //glBlendFunc(GL_SRC_ALPHA,  GL_ONE_MINUS_SRC_ALPHA);
    glDepthMask(GL_FALSE);
    if (Idx <> EditItem){or(not bEditing)}then
    begin
      SetOGLColor(0.75, 0.75, 0.75);
      if SameText(TrussRects.iType[Idx], sBOX_WEB_2)
      or SameText(TrussRects.iType[Idx], sBOX_HEEL_2) then
        SetOGLColor(0.85, 0.85, 0.75);
    end
    else
      SetOGLColor(0.75, 0.75, 1);
    if Idx < MinEditNumber then //locked
      SetOGLColor(1, 0.6, 0.6);
    CADQuad(Pt);
    glDepthMask(GL_TRUE);
    //glDisable(GL_BLEND);

    //Added Ops
    SetOGLColor(1, 0, 0);
    for n := 1 to TrussRects.OpCount[Idx] do
    if (TrussRects.Op[Idx, n].Kind <> ok2Rivet) then  // standard no special display
    begin
      Draw2DCircleWithCross(TrussRects.Op[Idx, n].p, 3);
      sOp := OpToString(TrussRects.Op[Idx, n]);
      p := TrussRects.Op[Idx, n].p;
      case TrussRects.Op[Idx, n].Kind of
        okCon1: p.Y := p.Y + 90;
        okTek .. okTek4,
        {ok2Rivet} ok4Rivet .. ok2Rivet4Tek: p.Y := p.Y + 70;
        okBrA .. okBrC: p.Y := p.Y - 50;
      else p.Y := p.Y + 10;
      end;
      Write2DFont(sOp, 255, 0, 0, p.X, p.Y, 0);
    end;
  end; //with TrussRects.Item[Idx] do
end;

//* Display routine for all the TrussRects
procedure TfrmMain.DisplayTrussRects;
var
  i: Word;
  s: string;
  Len: Double;
  p: Point2D;
begin
  for i := 1 to CurrentItem do
  begin
    if i < CurrentItem then
      glLoadName(i)
    else
      glLoadName(0);

    if (bDrawing) or (i < CurrentItem) then
      with TrussRects.Item[i]do
      begin
        DisplayTrussRect(i);
        p := MidPoint2D(Pt[1], Pt[3]);
        Len := LineLength2D(Pt[1], Pt[2]);
        s := format('%.0f', [Len]);
        Write2DFont(s, 0, 0, 128, p.X, p.Y, 0);
      end;
  end;
end;

//* Debug routine
// based on DistFromEnd1
// could use a copy of FlangeCoordFromPos, or HoleCoordFromPos
function FlgPointFromEnd1Dist(Idx: Word; ADist: Double): Point2D;
var
  mid14, mid23, p0: Point2D;
  V: Vector2D;
begin
  with DynEntity[pred(Idx)]do
  begin
    //Choose the line closest to the left, or bottom if Vertical as the End1Line
    //and set Pos from there
    mid14 := MidPoint2D(Pt[1], Pt[4]); mid23 := MidPoint2D(Pt[2], Pt[3]);
    p0 := Pt[1];
    V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
    if (Round(Pt[2].X - Pt[1].X) <> 0)then
    begin
      if mid23.X < mid14.X then
      begin
        p0 := Pt[2]; V := ScaleVector2D(V, -1);
      end;
    end
    else begin
      if mid23.Y < mid14.Y then
      begin
        p0 := Pt[2]; V := ScaleVector2D(V, -1);
      end;
    end;
  end;
  Result := Point2DFromParametricEquation(p0, V, ADist);
end;

function LipPointFromEnd1Dist(Idx: Word; ADist: Double): Point2D;
var
  mid14, mid23, p0: Point2D;
  V: Vector2D;
begin
  with DynEntity[pred(Idx)]do
  begin
    //Choose the line closest to the left, or bottom if Vertical as the End1Line
    //and set Pos from there
    mid14 := MidPoint2D(Pt[1], Pt[4]); mid23 := MidPoint2D(Pt[2], Pt[3]);
    p0 := Pt[4];
    V := Vector2DFrom2DPoints(Pt[4], Pt[3]);
    if (Round(Pt[2].X - Pt[1].X) <> 0)then
    begin
      if mid23.X < mid14.X then
      begin
        p0 := Pt[3]; V := ScaleVector2D(V, -1);
      end;
    end
    else begin
      if mid23.Y < mid14.Y then
      begin
        p0 := Pt[3]; V := ScaleVector2D(V, -1);
      end;
    end;
  end;
  Result := Point2DFromParametricEquation(p0, V, ADist);
end;

//* Display routine for the notches and copes (or flats if bFrames = True) of DynEntity[pred(Idx)]
procedure TfrmMain.DisplayEntityNotchesAndCopes(Idx: Word);
var
  i, j: Word;
  p, p1, p2: Point2D;
  d, d1, d2: Double;
  V: Vector2D;
begin
  if (Idx = 0)or(Idx > Length(DynEntity))then
    exit;
  if DynEntity[pred(Idx)].bNonRF then
    exit;
  with DynEntity[pred(Idx)] do
  begin
    V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
    glBegin(GL_LINES);
    //Notches
    SetOGLColor(0, 1, 0);
    //glLineWidth(2);
    if actShowNotches.Checked then
    begin
      if not PointIsOrigin(Notch[1]) then
      begin
        p := Point2DFromParametricEquation(Pt[1], V, -(CutWidth + NOTCH_START_TOL));
        glVertex4d(p.X, p.Y, 0, Scale);
        glVertex4d(Notch[1].X, Notch[1].Y, 0, Scale);
      end;
      if not PointIsOrigin(Notch[2]) then
      begin
        p := Point2DFromParametricEquation(Pt[2], V, CutWidth + NOTCH_START_TOL);
        glVertex4d(p.X, p.Y, 0, Scale);
        glVertex4d(Notch[2].X, Notch[2].Y, 0, Scale);
      end;
      //Added Notches, note - there's no check for the PosNotch array that gets added to
      for j := 1 to OpCount do
        if Op[j].Kind = okNotch then
        begin
          d := abs(PerpDistance(Pt[1], Pt[4], Op[j].p)); //dist to 14 end
          d1 := d - (NotchSize / 2);
          d2 := d1 + NotchSize;
          if d1 < 0 then //Don't allow cope beyond either end
            d1 := 0;
          if d2 > Len then
            d2 := Len;
          p1 := Point2DFromParametricEquation(Pt[1], V, d1);
          p2 := Point2DFromParametricEquation(Pt[1], V, d2);
          glVertex4d(p1.X, p1.Y, 0, Scale);
          glVertex4d(p2.X, p2.Y, 0, Scale);
        end;
    end;
    //Copes
    if actShowCopes.Checked then
    begin
      SetOGLColor(1, 0, 1);
      //glLineWidth(1);
      //Was previously used, but Cope[] doesn't represent where the actual copes go...
      //... PosCope[] is used.
      {if not PointIsOrigin(Cope[1]) then
       begin
       glVertex4d(Pt[4].x, Pt[4].y, 0, Scale);
       //p := Point2DFromParametricEquation(Pt[4], V, -(CutWidth + NOTCH_START_TOL));
       //glVertex4d(p.x, p.y, 0, Scale);
       glVertex4d(Cope[1].x, Cope[1].y, 0, Scale);
       end;
       if not PointIsOrigin(Cope[2]) then
       begin
       glVertex4d(Pt[3].x, Pt[3].y, 0, Scale);
       //p := Point2DFromParametricEquation(Pt[3], V, CutWidth + NOTCH_START_TOL);
       //glVertex4d(p.x, p.y, 0, Scale);
       glVertex4d(Cope[2].x , Cope[2].y, 0, Scale);
       end;      }
      for i := 1 to High(PosCope)do
        if PosCope[i] > 0 then
        begin
          p := LipPointFromEnd1Dist(Idx, PosCope[i]);
          p := Point2DFromParametricEquation(p, V, CopeSize / 2);
          glVertex4d(p.X, p.Y, 0, Scale);
          p := Point2DFromParametricEquation(p, V, -CopeSize);
          glVertex4d(p.X, p.Y, 0, Scale);
        end
        else break;
      //Added Copes, note - there's no check for the PosCope array that gets added to
      for j := 1 to OpCount do
        if Op[j].Kind = okCope then
        begin
          //V := Vector2DFrom2DPoints(Pt[4], Pt[3]);
          d := abs(PerpDistance(Pt[1], Pt[4], Op[j].p)); //dist to 14 end
          d1 := d - (CopeSize / 2);
          d2 := d1 + CopeSize;
          if d1 < 0 then //Don't allow cope beyond either end
            d1 := 0;
          if d2 > Len then
            d2 := Len;
          p1 := Point2DFromParametricEquation(Pt[4], V, d1);
          p2 := Point2DFromParametricEquation(Pt[4], V, d2);
          glVertex4d(p1.X, p1.Y, 0, Scale);
          glVertex4d(p2.X, p2.Y, 0, Scale);
        end;
    end; //if actShowNotches.Checked then
    glEnd; //glBegin(GL_LINES);

    //debug code to show the actual notch centres
    //SetOGLColor(0,0,0.5);
    //glPointSize(LineThick + 3);  //glPointSize(3);
    //glBegin(GL_POINTS);
    if actShowNotches.Checked then
      for i := 1 to High(PosNotch)do
        if PosNotch[i] > 0 then
        begin
          SetOGLColor(0, 0, 0.5);
          p := FlgPointFromEnd1Dist(Idx, PosNotch[i]);
          DrawPoint(p); //glVertex4d(p.x, p.y, 0, Scale);
          Draw2DCircle(p, 2, 6);
          //ends of the notch
          SetOGLColor(0, 1, 0);
          p := Point2DFromParametricEquation(p, V, NotchSize / 2);
          DrawPoint(p); //glVertex4d(p.x, p.y, 0, Scale);
          p := Point2DFromParametricEquation(p, V, -NotchSize);
          DrawPoint(p); //glVertex4d(p.x, p.y, 0, Scale);
        end
          else break;
    //Debug
    //glVertex4d(Notch[1].x, Notch[1].y, 0, Scale);  glVertex4d(Notch[2].x, Notch[2].y, 0, Scale);
    if actShowCopes.Checked then
      for i := 1 to High(PosCope)do
        if PosCope[i] > 0 then
        begin
          SetOGLColor(0, 0, 0.5);
          p := LipPointFromEnd1Dist(Idx, PosCope[i]);
          DrawPoint(p); //glVertex4d(p.x, p.y, 0, Scale);
          Draw2DCircle(p, 2, 6);
          //ends of the cope
          SetOGLColor(1, 0, 1);
          p := Point2DFromParametricEquation(p, V, CopeSize / 2);
          DrawPoint(p); //glVertex4d(p.x, p.y, 0, Scale);
          p := Point2DFromParametricEquation(p, V, -CopeSize);
          DrawPoint(p); //glVertex4d(p.x, p.y, 0, Scale);
        end
        else break;
    //Debug
    //glVertex4d(Cope[1].x, Cope[1].y, 0, Scale);  glVertex4d(Cope[2].x, Cope[2].y, 0, Scale);
    //glEnd;

    {SetOGLColor(0.5,0,0);
     if not PointIsOrigin(Cope[1])then
     Draw2DCircle(Cope[1], 3);
     //glVertex4d(Cope[1].x, Cope[1].y, 0, Scale);
     if not PointIsOrigin(Cope[2])then
     Draw2DCircle(Cope[2], 3);
     //glVertex4d(Cope[2].x, Cope[2].y, 0, Scale);  }
  end;
end;

procedure DisplayEntityHoles(Idx: Word);
var
  i: Word;
  p: Point2D;
  s: string;
begin
  with DynEntity[pred(Idx)] do
  begin
    SetOGLColor(HOLE_COLOR);
    i := 1;
    while not PointIsOrigin(FHoles[i])do
    begin
      p := HoleCoordFromPos(DynEntity[pred(Idx)], PosFHoles[i], True);
      if not PointsAreSame(p, FHoles[i])then //possibly never used now, after RemoveFlangeHole and RemoveLipHole, v.234
      begin
        SetOGLColor(HOLE_COLOR);
        Draw2DCircleWithCross(p, HoleSize - 1, 36);
        SetOGLColor(1, 0, 0);
        Draw2DCircleWithCross(FHoles[i], HoleSize - 1, 36);
        s := format('%.2fmm', [LineLength2D(p, FHoles[i])]);
        Write2DFont(s, 0, 0, 0, p.X, p.Y - 20, 0);
      end
      else
        Draw2DCircle(p, HoleSize, 36);
      inc(i);
    end;
    i := 1;
    while not PointIsOrigin(LHoles[i])do
    begin
      p := HoleCoordFromPos(DynEntity[pred(Idx)], PosLHoles[i], False);
      if not PointsAreSame(p, LHoles[i])then //possibly never used now, after RemoveFlangeHole and RemoveLipHole, v.234
      begin
        SetOGLColor(HOLE_COLOR);
        Draw2DCircleWithCross(p, HoleSize - 1, 36);
        SetOGLColor(1, 0, 0);
        Draw2DCircleWithCross(LHoles[i], HoleSize - 1, 36);
        s := format('%.2fmm', [LineLength2D(p, LHoles[i])]);
        Write2DFont(s, 0, 0, 0, p.X, p.Y - 20, 0);
      end
      else
        Draw2DCircle(p, HoleSize, 36);
      inc(i);
    end;
  end;
end;

procedure TfrmMain.DisplayItemOps(Idx: Word);
const
  SQUARE_SIZE = 35;
  Y_OFF = -80;
  SLOT_LEN = 15;
var
  j: Word;
  p, q, p2, q2: Point2D;
  s: string;
  f: Single;
  V: Vector2D;
  OpY: Double;
begin
  with DynEntity[pred(Idx)] do
  begin
    for j := 1 to OpCount do
    begin
      SetOGLColor(0, 0, 0);
      case Op[j].Kind of
      okCon1,
      okTek,
      okTek2,
      okTek4,
      {ok2Rivet,} ok4Rivet, ok2Rivet2Tek, ok2Rivet4Tek:  // not ok2Rivet it is standard
        begin
            //if Op[j].Kind = okTek then
            //  SetOGLColor(255,0,0);
            glLineWidth(2);
            Draw2DCircleWithCross(Op[j].p, 50, 36);
            if not actBold.Checked then
              glLineWidth(1);
            s := OpToString(Op[j]);
            OpY := Op[j].p.Y + 70;
            case Op[j].Kind of
              okCon1:       OpY := OpY + 20;
              //ok2Rivet4Tek: OpY := OpY - 20;
            end;
            Write2DFont(s, 0, 0, 0, Op[j].p.X, OpY, 0);
        end;
      okScr: begin
            s := IntToStr(Op[j].Num);
            if s <> '0' then //not an added rivet hole
              Write2DFont(s, 0, 0, 255, Op[j].p.X, Op[j].p.Y, 0);
          end;
      okScb: begin
            s := IntToStr(Op[j].Num) + 'B'; //y-displacement is a magic number
            Write2DFont(s, 0, 0, 255, Op[j].p.X, Op[j].p.Y + 20, 0);
          end;
      okBrA: begin
            DrawSquare(Op[j].p, 0, 128, 0, SQUARE_SIZE);
            s := IntToStr(Op[j].Num);
            Write2DFont(s, 0, 128, 0, Op[j].p.X, Op[j].p.Y + Y_OFF, 0);
          end;
      okBrB: begin
            DrawSquare(Op[j].p, 0, 0, 255, SQUARE_SIZE);
            s := IntToStr(Op[j].Num);
            Write2DFont(s, 0, 0, 255, Op[j].p.X, Op[j].p.Y + Y_OFF, 0);
          end;
      okBrC: begin
            DrawSquare(Op[j].p, 255, 0, 0, SQUARE_SIZE);
            s := IntToStr(Op[j].Num);
            Write2DFont(s, 255, 0, 0, Op[j].p.X, Op[j].p.Y + Y_OFF, 0);
          end;
      okBrace: begin
            DrawSquare(Op[j].p, 0, 0, 0, SQUARE_SIZE);
            {s := 'Brace';
             Write2DFont(s, 0,0,255, Op[j].p.x, Op[j].p.y + Y_OFF, 0); }
          end;
      okPC: begin
            f := Op[j].Num / 1000;
            s := format('PC %.3f', [f]); //y-displacement is a magic number
            Write2DFont(s, 0, 0, 255, Op[j].p.X, Op[j].p.Y - 40, 0);
          end;
      okServ1: begin
            SetOGLColor(0.75, 0.25, 0.75);
            Draw2DCircleWithCross(Op[j].p, 12.5, 36); //small service hole 25
          end;
      okServ2: begin
            SetOGLColor(0.75, 0.25, 0.75);
            Draw2DCircleWithCross(Op[j].p, 30, 36); //large    60, 90
          end;
      okSwage: if actShowSwages.Checked then
          begin
            SetOGLColor(0, 0, 1);
            {                   glPointSize(3);
              glBegin(GL_POINTS);
              glVertex4d(Op[j].p.x , Op[j].p.y, 0, Scale);
              glEnd;   }
            Draw2DCircleWithCross(Op[j].p, 3, 36);
            V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
            p := Point2DFromParametricEquation(Op[j].p, V, SwageSize / 2);
            q := Point2DFromParametricEquation(Op[j].p, V, -SwageSize / 2);
            Draw2DLine(p, q);
          end;
      okSlot:                // for bEndLoadCut
        begin
            SetOGLColor(0, 0.5, 0); //green
            Draw2DCircleWithCross(Op[j].p, 3);
            V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
            p := Point2DFromParametricEquation(Op[j].p, V,  EndLoadCutSize / 2);  //15); // was 8mm x 30mm
            q := Point2DFromParametricEquation(Op[j].p, V, -EndLoadCutSize / 2);  //-15);
            Draw2DLine(p, q);

            V := Vector2DFrom2DPoints(Pt[1], Pt[4]);
            p2 := Point2DFromParametricEquation(p, V, SLOT_LEN);
            q2 := Point2DFromParametricEquation(q, V, SLOT_LEN);
            Draw2DLines([p, p2, q, q2, p2, q2]);
        end;
      // okEndLoadCut:  //  using okSlot

      end;
    end;
  end;
end;

//* Display routine for DynEntity[pred(Idx)]
procedure TfrmMain.DisplayEntity(Idx: Word);
var
  i: Word;
begin
  if (Idx = 0)or(Idx > Length(DynEntity))then
    exit;
  if DynEntity[pred(Idx)].bNonRF then
    exit;
  glLoadName(Idx);
  with DynEntity[pred(Idx)] do
  begin
    DisplayItemOps(Idx);
    DisplayLipLine(Idx);
    //debug
    { SetOGLColor(0,1,0);
      glLineWidth(2);
      Draw2DLine(debugPunch[1], debugPunch[2]);    }
    //debug
    {glPointSize( 0.2 / Scale );
     //glPointSize(1);
     glBegin(GL_POINTS);
     for i:=1 to 1 do//4 do
     begin
     case i of
     1: SetOGLColor(0,0,0);
     2: SetOGLColor(1,0,0);
     3: SetOGLColor(0,1,0);
     4: SetOGLColor(0,0,1);
     end;
     glVertex4D(Pt[i].x , Pt[i].y, 0, Scale);
     //glVertex4D(debugPunch[i].x , debugPunch[i].y, 0, Scale);
     end;
     glEnd;           }

    SetOGLColor(1, 0, 0);
    //glLineWidth(2);
    Draw2DLine(Pt[1], Pt[2]);
    glBegin(GL_LINE_STRIP);
    SetOGLColor(0, 0, 0);
    //glLineWidth(1);
    for i := 2 to 4 do
      glVertex4d(Pt[i].X, Pt[i].Y, 0, Scale);
    glVertex4d(Pt[1].X, Pt[1].Y, 0, Scale);
    glEnd;

    //glEnable(GL_BLEND);
    //glBlendFunc(GL_SRC_ALPHA,  GL_ONE_MINUS_SRC_ALPHA);
    glDepthMask(GL_FALSE);
    SetOGLColor(0.75, 0.75, 0.75);
    //debug code
    //if bIsFacingItem then
    //  glColor4f(0, 0.25, 0, 0.8);
    //
    if SameText(iType, sBOX_WEB_2)
    or SameText(iType, sBOX_HEEL_2) then
      SetOGLColor(0.85, 0.85, 0.75);
    if Idx < MinEditNumber then //locked
      SetOGLColor(1, 0.6, 0.6);
    CADQuad(Pt);
    glDepthMask(GL_TRUE);
    //glDisable(GL_BLEND);

    {
     SetOGLColor(0,0,1);
     i:=1;
     while not PointIsOrigin(FHoles[i])do
     begin
     Draw2DCircle(FHoles[i], HoleSize, 36);
     inc(i);
     end;
     i:=1;
     while not PointIsOrigin(LHoles[i])do
     begin
     Draw2DCircle(LHoles[i], HoleSize, 36);
     inc(i);
     end;   }

    DisplayEntityHoles(Idx);

    {Debug
     Draw2DStippledLine(Notch[1], Notch[2], 1,0,0);
     Draw2DStippledLine(Cope[1], Cope[2], 1,0,0);   }
  end;
end;

//* Display routine for all the DynEntity array
procedure TfrmMain.DisplayEntities;
var
  i: Word;
begin
  if (Length(DynEntity) = 0)then
    exit;
  //Call first to get Notches and Copes Displayed last
  for i := 1 to pred(CurrentItem)do
    if i <> HiddenIdx then
      DisplayEntityNotchesAndCopes(i);
  //Display the rest of the Entity, including holes
  for i := 1 to pred(CurrentItem)do
    if i <> HiddenIdx then
      DisplayEntity(i);
end;

procedure TfrmMain.DefaultHandler(var Message);
{const
 NUM_CHARS = 7;  }
var
  i: Cardinal;
  //c: array [0..pred(NUM_CHARS)]of WideChar;
  //s: string;
begin
  try
    if TMessage(Message).Msg = WM_USR_MESSAGE then
    begin
      i := TMessage(Message).WParam; //WParam is actually an Integer, i is declared as a Cardinal to stop the Compiler complaining
      //GetWindowText(i, @c, succ(NUM_CHARS));      or use: GetWindowTextA with AnsiChar
      //s := c;
      //ShowMessage(s);
      if (i <> Handle)then //and(not SameText(s, 'ScotSim')) then //not a msg to self
      begin
        case TMessage(Message).LParam of
          1000: actUpdateScotSteel.Enabled := True; //Hello from ScotSteel
          {begin
           actUpdateScotSteel.Enabled := True;  //Hello from ScotSteel
           actUpdateIdentical.Enabled := True;
           actSetPanelSize.Enabled := True;
           end; }
          1001: actUpdateScotSteel.Enabled := False; //Bye from ScotSteel
          {begin
           actUpdateScotSteel.Enabled := False;  //Bye from ScotSteel
           actUpdateIdentical.Enabled := False;
           actSetPanelSize.Enabled := False;
           end; }
        end;
        Paint;
      end;
      //ReplyMessage(0);
      TMessage(Message).Result := 1; //indicate the message was processed
    end
    else
      inherited DefaultHandler(Message);
  except

  end;
end;

//* Display the angle of the currently drawn Rect
procedure DisplayAngle(Idx: Word);
var
  mid14, p, TextPt: Point2D;
  Angle: Extended;
  s: string;
begin
  if (Idx < 1)or(Idx > CurrentItem) then
    exit;

  with TrussRects.Item[Idx]do
  begin
    mid14 := MidPoint2D(Pt[1], Pt[4]);
    p := mid14; p.X := p.X + 200;
    TextPt := p; TextPt.X := TextPt.X + 40;
    Draw2DStippledLine(mid14, p, 0, 0, 0);
    Angle := LineDirectionRadians(Pt[1], Pt[2]) * 180 / pi;
    s := format('%.0fº',[Angle]);
    Write2DFont(s, 0, 0, 0, TextPt.X, TextPt.Y, 0);
  end;
end;

//* Display the background grid, currently 1 metre squares
procedure DisplayGrid;
const
  GRID_SIZE = 1000;
  Num = 25;
var
  p, pLo, pHi: Point2D;
  i: Byte;
  SideLen: Double;
begin
  if CurrentItem < 2 then
    exit;
  p := CentrePt;

  glDisable(GL_DEPTH_TEST);
  glLineWidth(1);
  SetOGLColor(0.7, 0.7, 0.7);
  glBegin(GL_LINES);

  SideLen := Num * GRID_SIZE;
  pLo.X := p.X - SideLen; pLo.Y := p.Y - SideLen;
  pHi.X := p.X + SideLen; pHi.Y := p.Y + SideLen;
  for i := 0 to (Num * 2) do
  begin
    glVertex4d(pLo.X + GRID_SIZE * i, pLo.Y, 0, Scale);
    glVertex4d(pLo.X + GRID_SIZE * i, pHi.Y, 0, Scale);

    glVertex4d(pLo.X, pLo.Y + GRID_SIZE * i, 0, Scale);
    glVertex4d(pHi.X + GRID_SIZE, pLo.Y + GRID_SIZE * i, 0, Scale);
  end;
  glVertex4d(pHi.X + GRID_SIZE, pLo.Y, 0, Scale);
  glVertex4d(pHi.X + GRID_SIZE, pHi.Y, 0, Scale);

  glEnd;
  glEnable(GL_DEPTH_TEST);
end;

//* Find where the COM DLL finds its points
procedure MakeDebugCircles;
var
  i, j, k, n: Word;
  p: Point2D;
  T: array[1 .. 2]of TTrapezium;
  V: array[1 .. 2]of OleVariant;
  vP: OleVariant;
begin
  if not bDllIsInitialised then
    exit; //InitDLL;
  if HoleFinder = nil then //should already be caught by bDllIsInitialised
    exit;

  Screen.Cursor := crHourGlass;
  try
    k := 1;
    FillChar(DebugCirclePt, SizeOf(DebugCirclePt), 0);
    for i := 1 to CurrentItem - 2 do
      for j := succ(i) to pred(CurrentItem) do
      begin
        T[1] := TTrapezium(TrussRects.Item[i].Pt); T[2] := TTrapezium(TrussRects.Item[j].Pt);
        for n := 1 to 2 do
          with T[n] do
          V[n] := VarArrayOf([Pt[1].x, Pt[1].y,
                              Pt[2].x, Pt[2].y,
                              Pt[3].x, Pt[3].y,
                              Pt[4].x, Pt[4].y,
                              0,0,0,0,
                              0,0,0,0]);
        if (HoleFinder.Find(V[1], V[2], vP) = RESULT_OK)then
        begin
          p.X := vP[0]; p.Y := vP[1];
          if (not PointIsOrigin(p)) then
          begin
            DebugCirclePt[k] := p;
            inc(k);
          end;
        end;
      end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

//* Display the COM DLL points
procedure DisplayDebugCircles;
var
  i: Word;
begin
  SetOGLColor(0, 0.5, 0);
  for i := 1 to MAX_ITEMS do
    if not PointIsOrigin(DebugCirclePt[i])then
      Draw2DCircle(DebugCirclePt[i], HoleSize / 2, 6)
    else
      break;
end;

procedure DisplayMeasurement;
var
  d: Double;
  s: string;
begin
  if MeasureLine.HitIdx[1]= 0 then
    exit;

  d := LineLength2D(MeasureLine.Pt[1], MeasureLine.Pt[2]);
  if Round(d) = 0 then
    exit;
  if PointIsOrigin(MeasureLine.Pt[2]) then
    exit;

  s := format('%.0f', [d]);
  CADArrowWithText(MeasureLine.Pt[1], MeasureLine.Pt[2], s, clRed);
  MeasureLine.TextArea := TextRectAtPoint(s, MidPoint2D(MeasureLine.Pt[1], MeasureLine.Pt[2]));
  //Debug
  //DrawRectangle(MeasureLine.TextArea.Pt, 255,0,0);
end;

procedure DisplayCrRatios;
var
  i: Word;
  AColor: TColor;
begin
  if (CrRatios[1].ID = 0) then
    exit;

  glLineWidth(5);

  i := 1;
  while (i <= MAX_CR_RATIOS)and(CrRatios[i].ID > 0) do
  begin
    AColor := clSilver; //silver hides
    with CrRatios[i]do
    begin
      if (CrRatio > 1)or(not JointOk) then //fail
        AColor := clWebFirebrick
      else if (CrRatio > 0.7) then //high
        AColor := clWebDarkOrange //clWebOrangeRed; was too close to clWebFirebrick               //clWebOrange
      else if (CrRatio > 0.3) then //pass
        AColor := clWebGold //clYellow
      else if (CrRatio >= 0) then //very low
        AColor := clGreen; //ScotSteel has clWebMediumSeaGreen, but that looks too pale here
    end;
    if AColor <> clSilver then //no point in drawing it
      Draw2DLine(CrRatios[i].Pt[1], CrRatios[i].Pt[2], AColor);
    inc(i);
  end;
end;

procedure DisplayPunchHoles;
var
  n: Integer;
  j: Byte;
begin
  for n := 0 to High(Clusters) do
  begin
    for j := 1 to 4 do
    begin
      case j of
        1: SetOGLColor(0.5, 0, 0);
        2: SetOGLColor(0, 0.5, 0);
        3: SetOGLColor(0, 0, 0.5);
        4: SetOGLColor(0.5, 0.5, 0);
      end;
      Draw2DCircleWithCross(Clusters[n].Pt[j], HoleSize / 2);
    end;
  end;

  {
   if (Length(DynEntity) = 2)then
   begin
   //    SetOGLColor(0.5, 0, 0);
   for j:=1 to 4 do
   begin
   case j of
   1: SetOGLColor(0.5, 0, 0);
   2: SetOGLColor(0, 0.5, 0);
   3: SetOGLColor(0, 0, 0.5);
   4: SetOGLColor(0.5, 0.5, 0);
   end;
   Draw2DCircleWithCross(Punch[j], HoleSize/2);
   end;
   if (ViewMode = vmEdit) then   //already shown in DisplayEntity in vmAdjust
   for j:=1 to 2 do
   DisplayEntityHoles(j);
   end;  }
end;

//* Refresh the OpenGL display buffer
procedure TfrmMain.FormPaint(Sender: TObject);
var
  errorCode: GLenum;
begin
  //glViewport(0, 0, ClientWidth, ClientHeight);

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  if bShowGrid then
    DisplayGrid;
  glLineWidth(LineThick);
  case ViewMode of
    vmEdit: begin
        DisplayTrussRects;
        if bDrawing then
          DisplayAngle(CurrentItem)
              else
                if (EditItem > 0) then
          DisplayAngle(EditItem);
        DisplayMeasurement;
      end;
    vmAdjust: begin
        DisplayEntities;
        if actShowHolePts.Checked and (not bFrames) then
          DisplayDebugCircles;
      end;
  end;
  DisplayCrRatios;

  if DebugPtDefined then
  begin
    SetOGLColor(0, 0.5, 0);
    Draw2DCircle(DebugPt, HoleSize, 36);
  end;

  if (actShowHolePositions.Checked)then
    DisplayPunchHoles;

  {
   with DebugLine do
   begin
   //Draw2DStippledLine(Pt[1], Pt[2], 0.5,0,0);
   glLineWidth( 1 );
   glBegin(GL_LINES);
   SetOGLColor(0.5, 0, 0);
   glVertex4d(Pt[1].x, Pt[1].y, 0, Scale);
   glVertex4d(Pt[2].x, Pt[2].y, 0, Scale);
   glEnd;
   end;    }

  try
    OpenGL1.Swap;
except;
    errorCode := glGetError;
    if errorCode <> GL_NO_ERROR then
      raise Exception.Create('OpenGL Error: ' + gluErrorUnicodeStringEXT(errorCode));
  end;
end;

//* Return the closest Rect end its distance from point p
function FindNearestTrussRectTip(p: Point2D; var RectIdx: Word; var TipIdx: Byte): Double;
var
  i: Word;
  j: Byte;
  d: Double;
begin
  RectIdx := 0; TipIdx := 0;
  Result := BIG_DUMMY;
  for i := 1 to pred(CurrentItem) do
    with TrussRects.Item[i]do
    begin
      for j := 1 to 4 do
      begin
        d := LineLength2D(p, Pt[j]);
        if d < Result then
        begin
          Result := d;
          RectIdx := i; TipIdx := j;
        end;
      end;
    end;
end;

//* Show the about form
procedure TfrmMain.actAboutExecute(Sender: TObject);
begin
  with TfrmAbout.Create(Application) do
  begin
    try
      //SetCursorPos(Screen.Width div 2, Screen.Height div 2);  //mouse to Screen centre
      SetCursorPos(Self.Left + Self.Width div 2, Self.Top + Self.Height div 2); // middle of the form
      ShowModal;
    finally
      Free;
    end;
  end;
end;

  //- - - - - - Debug - - - - -
  {
   function EntityIsBoxWebDouble(AEntityRec: EntityRecType): Boolean;
   begin
   Result := bUseBoxWebbing
   and (SameText(AEntityRec.iType, sBOX_WEB_2)
   or SameText(AEntityRec.iType, sBOX_HEEL_2));
   end;

   //* Assumes AEntity is a static array
   procedure CreateAdditionalBoxWebItems(var AEntity: array of EntityRecType; NumEntities: Word);
   var
   i, Num: Integer;
   begin
   if bFrames or not bUseBoxWebbing then
   exit;

   Num := NumEntities;
   for i:=Low(AEntity) to pred(NumEntities) do
   if EntityIsBoxWebDouble(AEntity[i]) then
   begin
   AEntity[Num] := AEntity[i];
   inc(Num);
   end;
   end;

   var
   TrussEntity: array[1..800] of EntityRecType;

   procedure DynToFixedArray;
   var
   i: Integer;
   begin
   for i:=Low(DynEntity) to High(DynEntity) do
   TrussEntity[succ(i)] := DynEntity[i];
   end;

   procedure FixedToDynArray;
   var
   Count, i: Integer;
   begin
   Count:=0;
   while TrussEntity[succ(Count)].iType <> '' do
   inc(Count);
   SetLength(DynEntity, Count);
   for i:=0 to pred(Count) do
   DynEntity[i] := TrussEntity[succ(i)];
   end;
  }
  //- - - - - - Debug End - - - - -

procedure TfrmMain.actAdjustForJointsExecute(Sender: TObject);
var
  nErrNum: Integer;
begin
  ViewMode := vmEdit;
  if actAdjustForJoints.Checked then
    ViewMode := vmAdjust;

  if (ViewMode <> vmEdit)then
    bDrawing := False;
  //ActionToolBar1.Visible := (ViewMode = vmEdit);

  actDraw.Enabled := actRects.Checked; //vmEdit
  actEdit.Enabled := actRects.Checked;
  actSaveSimData.Enabled := actAdjustForJoints.Checked; //vmAdjust

  if actAdjustForJoints.Checked then
  begin
    if (CurrentItem > 1) then
    begin
      {if not bDllIsInitialised then
       InitDLL;    }
      if bDllIsInitialised and actShowHolePts.Checked and (not bFrames) then
        //Needs to go before ProcessTrusses, or the Entity is changed
        MakeDebugCircles;
      GetEntityPointsFromTrussRects; //Raw rect data
      nErrNum := ProcessTruss(DynEntity, Length(DynEntity));
      //Debug
      {
       DynToFixedArray;
       CreateAdditionalBoxWebItems(TrussEntity, Length(DynEntity));
       FixedToDynArray;
       }
      if not actHideErrorDialog.Checked then
        ShowErrorInformation(nErrNum);
      //ShowMessage(IntToStr(TotalRivets) + ' rivets');    //bolts for trusses
    end;
  end;
  Paint;
end;

//* Toggle Angle Snap setting
procedure TfrmMain.actAngleSnappingExecute(Sender: TObject);
begin
  bAngleSnap := actAngleSnapping.Checked;
end;

procedure TfrmMain.actBoldExecute(Sender: TObject);
begin
  LineThick := 1;
  if actBold.Checked then
    LineThick := 2;
  glPointSize(LineThick + 3);
end;

//* Display the web update form
procedure TfrmMain.actCheckForUpdateExecute(Sender: TObject);
begin
  ShowUpdateForm;
end;

procedure TfrmMain.actDrawExecute(Sender: TObject);
begin
  //
end;

procedure TfrmMain.actEditExecute(Sender: TObject);
begin
  EditItem := 0;
  actEdit.Checked := Sender = actEdit; //the AutoCheck and GroupIndex don't work for these buttons
  actDraw.Checked := Sender = actDraw;
end;

procedure TfrmMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actSaveAsExecute(Sender: TObject);
begin
  with TSaveDialog.Create(Application)do
  begin
    try
      Options := Options + [ofOverwritePrompt];
      DefaultExt := 'txt'; //'txf';
      if (Gauge <> '')and(not bFrames)then
        DefaultExt := 'tx' + Gauge;
      Filter := 'Truss Export Files (*.tx*)|*.tx*';
      InitialDir := ExtractFilePath(DataFile);
      FileName := ExtractFileName(DataFile);
      Title := 'Export Imperial Truss Data';
      if Sender = actSaveAs then
        Title := 'Export Metric Truss Data';
      if Execute then
      begin
        SaveTrussDataToFile(FileName, (Sender = actSaveAs));
        DataFile := FileName;
        Caption := format('%s - %s', [APP_TITLE, ExtractFileName(FileName)]);
        Application.Title := Caption;
        Ribbon1.DocumentName := FileName;
        AddToMRU(FileName);
      end;
    finally
      Free;
    end;
  end;
end;

//* Show a Find dialog
procedure TfrmMain.actFindItemExecute(Sender: TObject);
const
  sPROMPT = 'Please enter the Name or Number of the item to find';
var
  s: string;
  Idx: Integer;
begin
  s := '';
  if InputQuery('Find', sPROMPT, s)then
  begin
    Idx := ItemIndexFromString(s);
    if Idx > 0 then
      CentreItemInWidow(Idx);
    Paint;
  end;
end;

//* Show the Font form
procedure TfrmMain.actFontExecute(Sender: TObject);
begin
  ShowFontSettingsForm;
end;

//* Show the Help panel
procedure TfrmMain.actHelpExecute(Sender: TObject);
begin
  pnlHelp.Visible := True;
end;

//* Hide an item
procedure TfrmMain.actHideAdjustedItemExecute(Sender: TObject);
const
MSG = 'Please enter the index of the item to hide'
    + #13#10
    + '0 to show all';
var
  s: string;
begin
  s := IntToStr(HiddenIdx);
  if InputQuery('Hide Item', Msg, s)then
    HiddenIdx := StrToInt(s);
end;

procedure TfrmMain.actHideErrorDialogExecute(Sender: TObject);
begin
  // so Action is enabled
end;

//* Show the HoleAuto form
procedure TfrmMain.actHoleAutoCoordsExecute(Sender: TObject);
begin
  if ViewMode = vmAdjust then
    Hide; //displays holes in the but the tempEntity has the Entity var changed
  try
    with TfrmHoleAuto.Create(Application)do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;

    if ViewMode = vmAdjust then
      actAdjustForJointsExecute(nil); //put the original Entity data back in
  finally
    Show;
  end;
end;

//* Import menu item event handler
procedure TfrmMain.actOpenExecute(Sender: TObject);
const
TRUSS_FILES_FILTER = 'All Supported Files|*.tx*;*.' + ENCRYPTED_PANEL_FILE_EXT
                   + '|Truss Export & US Data (*.tx*)|*.tx*'
                   + '|Truss Export Files (*.txf)|*.txf'
                   + '|US Data (*.tx*)|*.tx*'
                   + '|Scot-RF Panel Files (*.' + ENCRYPTED_PANEL_FILE_EXT + ')|*.' + ENCRYPTED_PANEL_FILE_EXT
                   + '|All Files|*.*';
begin
  with TOpenDialog.Create(Application)do
  begin
    try
      //DefaultExt := 'txf';
      Filter := TRUSS_FILES_FILTER;
      FilterIndex := LastFilterIndex;
      InitialDir := ExtractFilePath(DataFile);
      FileName := ExtractFileName(DataFile);
      Title := 'Import Truss Data';
      if Execute then
        OpenTrussData(FileName);
      LastFilterIndex := FilterIndex;
    finally
      Free;
    end;
  end;
end;

procedure TfrmMain.actMakeHorzExecute(Sender: TObject);
var
  d: Double;
  bUp: Bool;
begin
  if EditItem = 0 then
    exit;
  SaveUndo('Make Horizontal');
  with TrussRects.Item[EditItem]do
  begin
    bUp := Pt[4].Y > Pt[1].Y;
    d := LineLength2D(Pt[1], Pt[4]);
    if (not bUp) then
      d := -d;

    if EditTip = tt14 then
      Pt[2].Y := Pt[1].Y
    else
      Pt[1].Y := Pt[2].Y;

    Pt[4].X := Pt[1].X; Pt[4].Y := Pt[1].Y + d;
    Pt[3].X := Pt[2].X; Pt[3].Y := Pt[2].Y + d;
  end;

  Paint;
end;

procedure TfrmMain.actMakeParallelExecute(Sender: TObject);
begin
  bMakingParallel := True;
end;

procedure TfrmMain.actMeasureExecute(Sender: TObject);
begin
  //actMeasure.Checked := not actMeasure.Checked;
  bMeasuring := actMeasure.Checked;
  FillChar(MeasureLine, SizeOf(MeasureLine), 0);
end;

procedure TfrmMain.actMRUActionExecute(Sender: TObject);
begin
  //ShowMessage(Sender.ClassName);
  OpenTrussData((Sender as TAction).Hint);
end;

//* Toggle Allow/Prevent changes to Rects
procedure TfrmMain.actLockExecute(Sender: TObject);
begin
  if actLock.Checked then
  begin //lock the current items - stop edits
    actLock.ImageIndex := 14;
    MinEditNumber := CurrentItem;
    actLock.Caption := 'Unlock';
  end
  else begin
    actLock.ImageIndex := 13;
    MinEditNumber := -1;
    actLock.Caption := 'Lock';
  end;
  SetEditsHint;
  Paint;
end;

//* Clean up and start a new set of rects
procedure TfrmMain.actNewExecute(Sender: TObject);
begin
  InitUndoAndRedo;
  ClearClusters;
  FillChar(TrussRects, SizeOf(TrussRects), 0);
  FillChar(CrRatios, SizeOf(CrRatios), 0);
  //FillChar(Entity, SizeOf(Entity), 0);
  ClearDynEntity;
  FillChar(DebugCirclePt, SizeOf(DebugCirclePt), 0);
  CurrentItem := 1;
  Caption := APP_TITLE;
  Ribbon1.DocumentName := '';
  actRects.Checked := True;
  actFindItem.Enabled := False;

  CSVTrussQuantity := 1;
  CSVGauge := '';
  MinEditNumber := -1;
  CentrePt := THE_ORIGIN;
  CentrePointInViewport(CentrePt);

  DataFile := '';
  EditItem := 0;
  if (Sender <> nil) then //not when opening a file
  begin
    actEdit.Checked := False;
    actDraw.Checked := True;
  end;
  ViewMode := vmEdit;
  actAdjustForJointsExecute(nil);

  Paint;
end;

type
  EntityInfoType = (eitPosNotch, eitPosCope, eitPosLHoles, eitPosFHoles);

function EntityPosString(Idx: Integer; AType: EntityInfoType; var ACount: Integer; bOtherEnd: Bool = False): string;
//-----------------------------
  procedure AddResult(Dist: Double);
  const
    DELIM = ', ';
    FORMAT_STR = '%.1f';
  var
    s: string;
  begin
    if bOtherEnd then
      Dist := DynEntity[Idx].Len - Dist;
    s := format(FORMAT_STR, [Dist]);
    if Result <> '' then
      s := DELIM + s;
    Result := Result + s;
    inc(ACount);
  end;
//-----------------------------
var
  i: Integer;
begin
  Result := '';
  i := 1;
  with DynEntity[Idx]do
    case AType of
      eitPosNotch: while (PosNotch[i] > 0)and(i < High(PosNotch))do
        begin
          AddResult(PosNotch[i]);
          inc(i);
        end;
      eitPosCope: while (PosCope[i] > 0)and(i < High(PosCope))do
        begin
          AddResult(PosCope[i]);
          inc(i);
        end;
      eitPosLHoles: while (PosLHoles[i] > 0)and(i < High(PosLHoles))do
        begin
          AddResult(PosLHoles[i]);
          inc(i);
        end;
      eitPosFHoles: while (PosFHoles[i] > 0)and(i < High(PosFHoles))do
        begin
          AddResult(PosFHoles[i]);
          inc(i);
        end;
    end;
end;

function GetSwageString(Idx: Integer; bOtherEnd: Bool = False): string;
var
  AFloatArray: array of Double;
  //-----------------------------------
  procedure AddToFloatArray(f: Double);
  var
    Num: Integer;
  begin
    Num := Length(AFloatArray);
    SetLength(AFloatArray, succ(Num));
    if bOtherEnd then
      f := DynEntity[Idx].Len - f;
    AFloatArray[Num] := f;
  end;
//-----------------------------------
var
  i: Integer;
begin
  Result := '';

  with DynEntity[Idx] do
    for i := 1 to OpCount do
      if Op[i].Kind = okSwage then
        AddToFloatArray(Op[i].Pos);

  if Length(AFloatArray) = 0 then
    exit;
  QuickSort(AFloatArray);
  for i := 0 to High(AFloatArray)do
  begin
    Result := Result + format('%.1f', [AFloatArray[i]]);
    if i < High(AFloatArray)then
      Result := Result + ', ';
  end;
  SetLength(AFloatArray, 0); AFloatArray := nil; //clean up
end;

//* Export SimData
procedure SaveSimData(AFileName: TFileName);
var
  i, nOps: Integer;
  SL: TStringList;
  s: string;
begin
  SL := TStringList.Create;
  try
    if DataFile <> '' then
      SL.Add(ExtractFileName(ChangeFileExt(DataFile, '')));
    SL.Add('-----------------');
    nOps := 0;
    for i := 0 to High(DynEntity) do
    begin
      with DynEntity[i]do
      begin
        s := 'Item ' + IntToStr(succ(i));
        if (s <> Item) then
          s := s + '(' + Item + ')';
        s := s + ' details';
        SL.Add(s);
        //SL.Add( format('Item %d (%s) details', [succ(i), Item]) );
        SL.Add(format('Length = %.0f', [Len]));

        SL.Add('Notches: ' + EntityPosString(i, eitPosNotch, nOps));
        if bFrames then
          SL.Add('Flats: ' + EntityPosString(i, eitPosCope, nOps))
        else
          SL.Add('Copes: ' + EntityPosString(i, eitPosCope, nOps));

        SL.Add('Swages: ' + GetSwageString(i));

        SL.Add('Lip holes: ' + EntityPosString(i, eitPosLHoles, nOps));
        //if bFrames then
        //  SL.Add('Holes: ' + EntityPosString(i, eitPosFHoles, nOps))
        //else
        SL.Add('Flg holes: ' + EntityPosString(i, eitPosFHoles, nOps));
      end;
      SL.Add('-----------------');
    end;
    SL.Insert(1, 'Operations: ' + IntToStr(nOps));
    SL.SaveToFile(AFileName);
  finally
    SL.Free;
  end;
end;

procedure TfrmMain.actSaveSimDataExecute(Sender: TObject);
begin
  with TSaveDialog.Create(Application)do
  begin
    try
      Options := Options + [ofOverwritePrompt];
      DefaultExt := TXT_EXT;
      Filter := TEXT_FILES_FILTER;
      InitialDir := ExtractFilePath(DataFile);
      FileName := ChangeFileExt(ExtractFileName(DataFile), '.' + TXT_EXT); //txt
      Title := 'Save Sim Data';
      if Execute then
        SaveSimData(FileName);
    finally
      Free;
    end;
  end;
end;

//* Change the width of the next drawn rects
procedure TfrmMain.actSetRectWidthExecute(Sender: TObject);
var
  sValue, s: string;
begin
  sValue := FloatToStr(TrussRectWidth);
  s := 'Truss';
  if bFrames then
  begin
    sValue := FloatToStr(TrussRectWidth);
    s := 'Panel';
  end;
  if InputQuery('Rectangle Width', 'Enter a width for drawing the ' + s + ' rectangles', sValue)then
  begin
    TrussRectWidth := StrToFloat(sValue);
    if bFrames then
      PanelRectWidth := StrToFloat(sValue);
  end;
  RectWidth := TrussRectWidth;
  if bFrames then
    RectWidth := PanelRectWidth;
end;

//* Show the Settings Form
procedure TfrmMain.actSettingsExecute(Sender: TObject);
begin
  if FormSettings.ShowModal = mrOK then
    InitDLL;

  //actShowCopes.Caption doesn't change the checkbox caption without the space
  if bFrames then
    actShowCopes.Caption := TranslateStr('Show Flats') + ' ' //or use... rgDebug.Items[5].Caption := 'Show Flats'
  else
    actShowCopes.Caption := TranslateStr('Show Copes') + ' '; //or use... rgDebug.Items[5].Caption := 'Show Copes';

  actShowAddOpForm.Enabled := (EditItem > 0)and (not bFrames);
  actAdjustForJointsExecute(Sender);
end;

function PointFromOpAndDist(Idx: Word; AKind: TOpKind; Dist: Double): Point2D;
var
  V12, V14: Vector2D;
begin
  with TrussRects.Item[Idx] do
  begin
    V12 := Vector2DFrom2DPoints(Pt[1], Pt[2]);
    //V14 := Vector2DFrom2DPoints(Pt[1], Pt[4]);
    case AKind of
      {okNone:  ;
       okCT:    ;
       okIns:   ; }
      okCope:     Result := Point2DFromParametricEquation(Pt[4], V12, Dist);
      okNotch,
      okServ1,
      okServ2,
      okSwage,
      okSlot:     Result := Point2DFromParametricEquation(Pt[1], V12, Dist);
      okLipHole:  begin
                    V14 := Vector2DFrom2DPoints(Pt[1], Pt[4]);
                    Result := Point2DFromParametricEquation(Pt[1], V14, LipHolePos);
                    Result := Point2DFromParametricEquation(Result, V12, Dist);
                  end;
      okFlgHole:  begin
                    V14 := Vector2DFrom2DPoints(Pt[1], Pt[4]);
                    Result := Point2DFromParametricEquation(Pt[1], V14, FlgHolePos);
                    Result := Point2DFromParametricEquation(Result, V12, Dist);
                  end;
      {okCon1:  ;
       okScr:   ;
       okScb:   ;
       okBrA:   ;
       okBrB:   ;
       okBrC:   ;
       okBrace: ;
       okPC:    ;
       okServ1: ;
       okServ2: ;
       okSwage: ;
       okSlot:  ;}
    else begin
        Result := Point2DFromParametricEquation(MidPoint2D(Pt[1], Pt[4]), V12, Dist);
      end;
    end;
  end;
end;

procedure AddOpToSelectedRect(AKind: TOpKind; Dist: Double);
var
  p: Point2D;
begin
  if EditItem = 0 then
    exit;
  if TrussRects.OpCount[EditItem] >= MAX_OPS then
    exit;
  with TrussRects do
  begin
    inc(OpCount[EditItem]);
    p := PointFromOpAndDist(EditItem, AKind, Dist);
    Op[EditItem, OpCount[EditItem]].p := p;
    Op[EditItem, OpCount[EditItem]].Kind := AKind;
    //only needed for swages? and these get calculated in AdjustForJointsU
    //here so that added ops move when a rect is moved
    Op[EditItem, OpCount[EditItem]].Pos := Dist;
  end;
end;

//* Dialog for user to select an operation to add to the selected item
procedure TfrmMain.actShowAddOpFormExecute(Sender: TObject);
var
  AForm: TfrmAddOperation;
  d: Double;
  AOp: TOpKind;
  i: Integer;
  AItem: TListItem;
begin
  AForm := TfrmAddOperation.Create(Application);
  with AForm do
  begin
    try
      with TrussRects.Item[EditItem]do
        d := abs(PerpDistance(Pt[1], Pt[4], EditPt));
      txtDistance.Text := format('%f', [d]);
      for i := 1 to TrussRects.OpCount[EditItem] do
      begin
        AItem := lvOperations.Items.Add;
        AItem.Caption := OpToString(TrussRects.Op[EditItem, i]);
        with TrussRects.Item[EditItem]do
          d := abs(PerpDistance(Pt[1], Pt[4], TrussRects.Op[EditItem, i].p));
        AItem.SubItems.Add(format('%f', [d]));
      end;
      btnOK.Enabled := False;
      if ShowModal = mrOK then
      begin
        SaveUndo('Add Operation');
        TrussRects.OpCount[EditItem] := 0;
        for i := 1 to MAX_OPS do
          FillChar(TrussRects.Op[EditItem, i], SizeOf(TrussRects.Op[EditItem, i]), 0);
        for i := 0 to pred(lvOperations.Items.Count) do
        begin
          AOp := StringToOpType(lvOperations.Items[i].Caption);
          d := StrToFloat(lvOperations.Items[i].SubItems[0]);
          AddOpToSelectedRect(AOp, d);
        end;
      end;
    finally
      Free;
    end;
  end;
end;

//* Get user input for the display of a circle at the user's X,Y
procedure TfrmMain.actShowDebugCircleExecute(Sender: TObject);
var
  sX, sY: string;
begin
  if DebugPtDefined then
  begin
    sX := format('%.0f', [DebugPt.X]);
    sY := format('%.0f', [DebugPt.Y]);
  end;
  DebugPtDefined := False;
  if InputQuery('Debug Circle', 'Enter X value', sX) then
    if InputQuery('Debug Circle', 'Enter Y value', sY) then
    begin
      DebugPt.X := StrToFloat(sX);
      DebugPt.Y := StrToFloat(sY);
      DebugPtDefined := True;
    end;
  Paint;
end;

//* Toggle the Grid Display
procedure TfrmMain.actShowGridExecute(Sender: TObject);
begin
  bShowGrid := actShowGrid.Checked;
end;

procedure TfrmMain.actShowHolePtsExecute(Sender: TObject);
begin
  actAdjustForJointsExecute(Sender);
end;

//* Togggle the lip line display
procedure TfrmMain.actShowLipExecute(Sender: TObject);
begin
  bShowLip := actShowLip.Checked;
end;

procedure TfrmMain.actShowFlattenedLipExecute(Sender: TObject);
begin
  bShowFlattenedLip := actShowFlattenedLip.Checked;
end;

procedure TfrmMain.actShowNotchesExecute(Sender: TObject);
begin
  Paint;
end;

//* Toggle Snap setting
procedure TfrmMain.actSnappingExecute(Sender: TObject);
begin
  bSnap := actSnapping.Checked;
end;

function GetTempFolder: string;
var
  TempDir: array[0 .. MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, @TempDir);
  Result := StrPas(TempDir);
end;

procedure TfrmMain.actUndoExecute(Sender: TObject);
begin
  DoUndo;
end;

procedure TfrmMain.actRedoExecute(Sender: TObject);
begin
  DoRedo;
end;

procedure TfrmMain.actUpdateScotSteelExecute(Sender: TObject);
var
  sFileName: string;
begin
  sFileName := GetTempFolder + 'Temp.txt';
  SaveTrussDataToFile(sFileName, True);
  if WM_USR_MESSAGE <> 0 then //tell SDes the update is ready
    SendNotifyMessage(HWND_BROADCAST, WM_USR_MESSAGE, Handle, 1);

  //PostMessage(HWND_BROADCAST, WM_USR_MESSAGE, Handle, 1);  //tell SDes the update is ready
end;

function MRUExists(AHint: string; var Idx: Integer): Boolean;
var
  i: Integer;
begin
  Idx := -1;
  Result := False;
  with frmMain.Ribbon1.ApplicationMenu.Menu do
  begin
    for i := pred(RecentItems.Count)downto 0 do
      if SameText(RecentItems[i].Hint, AHint)then
      begin
        Idx := i;
        Result := True;
        break;
      end;
  end;
end;

procedure TfrmMain.AddToMRU(AFileName: TFileName; bTopItem: Bool = True);
//------------------------------------------------
  procedure RemoveRecentItemByIndex(nItem: Integer);
  begin
    with Ribbon1.ApplicationMenu.Menu do
    begin
      RecentItems[nItem].Action.Free;
      RecentItems[nItem].Action := nil;
      RecentItems.Delete(nItem);
    end;
  end;
//------------------------------------------------
var
  Num: Integer;
  AItem: TOptionItem;
  Idx: Integer;
begin
  Num := Length(MRUActions);
  if (Num >= MAX_MRU_ITEMS)and(not bTopItem) then
    //if Ribbon1.ApplicationMenu.Menu.RecentItems.Count > MAX_MRU_ITEMS then
    exit;
  if not FileExists(AFileName)then
    exit;

  if MRUExists(AFileName, Idx)then
  begin
    if not bTopItem then
      exit
    else
      RemoveRecentItemByIndex(Idx);
  end
  else
    if bTopItem and (Num >= MAX_MRU_ITEMS)then  //(Num > 0)then
      RemoveRecentItemByIndex(pred(Num));

  Num := Ribbon1.ApplicationMenu.Menu.RecentItems.Count;
  SetLength(MRUActions, succ(Num));
  MRUActions[Num] := TAction.Create(Application);
  MRUActions[Num].OnExecute := actMRUActionExecute;
  MRUActions[Num].Caption := ExtractFileName(AFileName);
  MRUActions[Num].Hint := AFileName;
  MRUActions[Num].ImageIndex := 17;

  if bTopItem then
    AItem := Ribbon1.ApplicationMenu.Menu.RecentItems.Insert(0)
  else
    AItem := Ribbon1.ApplicationMenu.Menu.RecentItems.Add;
  AItem.Action := MRUActions[Num];
end;

procedure AddTrussRect(ARect: RectType; ReverseOrder: Bool);
var
  Dist2, Dist3, dX, dY: Double;
  RectIdx, RectIdx3: Word;
  TipIdx, TipIdx3: Byte;
  Intercept: Point2D;
  RectLine, NewLine: LineType2D;
  SnapTo2, SnapTo3: Bool;
begin
  SaveUndo('Add Item');
  //Look to Snap tips together
  Dist2 := FindNearestTrussRectTip(ARect.Pt[2], RectIdx, TipIdx);
  Dist3 := FindNearestTrussRectTip(ARect.Pt[3], RectIdx3, TipIdx3);
  SnapTo2 := False; SnapTo3 := False;
  if (not frmMain.actLock.Checked)and bSnap then
    if (Dist2 < SNAP_DIST)or(Dist3 < SNAP_DIST)then
    begin
      SnapTo2 := Dist2 < Dist3; SnapTo3 := not SnapTo2;
    end;
  if (SnapTo2 or SnapTo3) then
  begin
    if SnapTo3 then
    begin
      RectIdx := RectIdx3; TipIdx := TipIdx3;
    end;
    RectLine.Pt[1] := TrussRects.Item[RectIdx].Pt[1];
    RectLine.Pt[2] := TrussRects.Item[RectIdx].Pt[2];
    if (TipIdx = 3)or(TipIdx = 4)then
    begin
      RectLine.Pt[1] := TrussRects.Item[RectIdx].Pt[4];
      RectLine.Pt[2] := TrussRects.Item[RectIdx].Pt[3];
    end;
    NewLine.Pt[1] := ARect.Pt[1]; NewLine.Pt[2] := ARect.Pt[2];
    if SnapTo3 then
    begin
      NewLine.Pt[1] := ARect.Pt[4]; NewLine.Pt[2] := ARect.Pt[3];
    end;
    if FindIntercept(RectLine, NewLine, Intercept)then
    begin
      dX := Intercept.X - NewLine.Pt[2].X; dY := Intercept.Y - NewLine.Pt[2].Y;
      if SnapTo2 then
      begin
        ARect.Pt[2] := Intercept;
        ARect.Pt[3].X := ARect.Pt[3].X + dX; ARect.Pt[3].Y := ARect.Pt[3].Y + dY;
      end
      else begin
        ARect.Pt[3] := Intercept;
        ARect.Pt[2].X := ARect.Pt[2].X + dX; ARect.Pt[2].Y := ARect.Pt[2].Y + dY;
      end;
      with TrussRects.Item[RectIdx] do
      begin
        dX := Intercept.X - Pt[TipIdx].X;
        dY := Intercept.Y - Pt[TipIdx].Y;
        case TipIdx of
          1: begin
              Pt[4].X := Pt[4].X + dX; Pt[4].Y := Pt[4].Y + dY;
            end;
          2: begin
              Pt[3].X := Pt[3].X + dX; Pt[3].Y := Pt[3].Y + dY;
            end;
          3: begin
              Pt[2].X := Pt[2].X + dX; Pt[2].Y := Pt[2].Y + dY;
            end;
          4: begin
              Pt[1].X := Pt[1].X + dX; Pt[1].Y := Pt[1].Y + dY;
            end;
        end;
      end;
      TrussRects.Item[RectIdx].Pt[TipIdx] := Intercept;
    end;
  end;

  with TrussRects.Item[CurrentItem] do
  begin
    Pt[1] := ARect.Pt[2];
    Pt[2] := ARect.Pt[1];
    Pt[3] := ARect.Pt[4];
    Pt[4] := ARect.Pt[3];
    if ReverseOrder then
    begin
      Pt[4] := ARect.Pt[1];
      Pt[1] := ARect.Pt[4];
      Pt[3] := ARect.Pt[2];
      Pt[2] := ARect.Pt[3];
    end;
    TrussRects.iType[CurrentItem]:= sWEB;
    TrussRects.ItemName[CurrentItem] := RawByteString(NAME_PREFIX + IntToStr(CurrentItem));
  end;

  inc(CurrentItem);
  if CurrentItem > MAX_ITEMS then
    CurrentItem := 1;
end;

//* Snap routines for drawing a new rect
procedure SnapStartToNearestTrussRect(SnapPt: Point2D);
var
  i: Word;
  j: Byte;
  d, smallestDist: Double;
  p, NewPt: Point2D;
begin
  if (not bSnap) then
    exit;
  //Try for an End Point first
  smallestDist := BIG_DUMMY;
  for i := 1 to pred(CurrentItem) do
    with TrussRects.Item[i]do
    begin
      for j := 1 to 4 do
      begin
        d := LineLength2D(SnapPt, Pt[j]);
        if d < smallestDist then
        begin
          smallestDist := d;
          NewPt := Pt[j];
        end;
      end;
    end;
  if smallestDist > SNAP_DIST then
  begin
    smallestDist := BIG_DUMMY;
    for i := 1 to pred(CurrentItem) do
      with TrussRects.Item[i]do
      begin
        p := ClosestPtOn2DLine(Pt[1], Pt[2], SnapPt);
        if PointOnLine(Pt[1], Pt[2], p, 1) then
        begin
          d := LineLength2D(SnapPt, p);
          if d < smallestDist then
          begin
            smallestDist := d;
            NewPt := p;
          end;
        end;

        p := ClosestPtOn2DLine(Pt[3], Pt[4], SnapPt);
        if PointOnLine(Pt[3], Pt[4], p, 1) then
        begin
          d := LineLength2D(SnapPt, p);
          if d < smallestDist then
          begin
            smallestDist := d;
            NewPt := p;
          end;
        end;
      end;
  end;
  if smallestDist < SNAP_DIST then
  begin
    if bUseFlangeSide then
      TrussRects.Item[CurrentItem].Pt[1] := NewPt
    else
      TrussRects.Item[CurrentItem].Pt[4] := NewPt;
  end;
end;

procedure SnapEndToNearestTrussRect;
var
  ALine, Edge12, Edge34: LineType2D;
  Intercept, NewPt: Point2D;
  i: Word;
  smallestDist, d, dX, dY: Double;
begin
  if (not bSnap)and(not bAngleSnap) then
    exit;
  with TrussRects.Item[CurrentItem]do
  begin
    ALine.Pt[1] := Pt[1]; ALine.Pt[2] := Pt[2];
    if not bUseFlangeSide then
    begin
      ALine.Pt[1] := Pt[4]; ALine.Pt[2] := Pt[3];
    end;
  end;
  if bAngleSnap then
    Snap2ndPtToAngle(ALine.Pt[1], ALine.Pt[2], 5);
  NewPt := ALine.Pt[2]; //if no snap pt found, use the SnapAngle

  //Look for a snap point on the existing rects
  smallestDist := SNAP_DIST;
  if (not bSnap) then
    smallestDist := 0;
  for i := 1 to pred(CurrentItem) do
    with TrussRects.Item[i]do
    begin
      Edge12.Pt[1] := Pt[1]; Edge12.Pt[2] := Pt[2];
      if FindIntercept(ALine, Edge12, Intercept)then
      begin
        d := LineLength2D(Intercept, ALine.Pt[2]);
        if d < smallestDist then
        begin
          smallestDist := d;
          NewPt := Intercept;
        end;
      end;
      Edge34.Pt[1] := Pt[4]; Edge34.Pt[2] := Pt[3];
      if FindIntercept(ALine, Edge34, Intercept)then
      begin
        d := LineLength2D(Intercept, ALine.Pt[2]);
        if d < smallestDist then
        begin
          smallestDist := d;
          NewPt := Intercept;
        end;
      end;
    end;

  with TrussRects.Item[CurrentItem]do
  begin
    dX := NewPt.X - ALine.Pt[2].X; dY := NewPt.Y - ALine.Pt[2].Y;
    if bUseFlangeSide then
    begin
      Pt[2] := NewPt;
      Pt[3].X := Pt[3].X + dX; Pt[3].Y := Pt[3].Y + dY;
    end
    else begin
      Pt[3] := NewPt;
      Pt[2].X := Pt[2].X + dX; Pt[2].Y := Pt[2].Y + dY;
    end;
  end;
end;

procedure SnapEditItemToNearestTrussRect;
var
  ALine, Edge12, Edge34: LineType2D;
  Intercept, OldPt, NewPt: Point2D;
  i: Word;
  smallestDist, d, dX, dY: Double;
  Dirn: Extended;
begin
  if (not bSnap) then
    exit;

  with TrussRects.Item[EditItem]do
  begin
    ALine.Pt[1] := Pt[1]; ALine.Pt[2] := Pt[2];
    OldPt := Pt[1];
    if EditTip = tt23 then
      OldPt := Pt[2];
  end;
  NewPt := OldPt;

  //Look for a snap point on the existing rects
  smallestDist := SNAP_DIST;
  for i := 1 to pred(CurrentItem) do
    if (i <> EditItem) then
      with TrussRects.Item[i]do
      begin
        Edge12.Pt[1] := Pt[1]; Edge12.Pt[2] := Pt[2];
        if FindIntercept(ALine, Edge12, Intercept)then
        begin
          d := LineLength2D(Intercept, OldPt);
          if d < smallestDist then
          begin
            smallestDist := d;
            NewPt := Intercept;
          end;
        end;
        Edge34.Pt[1] := Pt[4]; Edge34.Pt[2] := Pt[3];
        if FindIntercept(ALine, Edge34, Intercept)then
        begin
          d := LineLength2D(Intercept, OldPt);
          if d < smallestDist then
          begin
            smallestDist := d;
            NewPt := Intercept;
          end;
        end;
      end;

  with TrussRects.Item[EditItem]do
  begin
    if EditTip = tt14 then
      Pt[1] := NewPt
    else
      Pt[2] := NewPt;

    Dirn := LineDirectionRadians(Pt[1], Pt[2]);
    dX := RectWidth * Sin(Dirn); dY := RectWidth * -Cos(Dirn);
    Pt[4].X := Pt[1].X + dX; Pt[4].Y := Pt[1].Y + dY;
    Pt[3].X := Pt[2].X + dX; Pt[3].Y := Pt[2].Y + dY;
  end;
end;

function NearestRectCorner(p: Point2D; var ItemHit: Word): Point2D;
var
  smallestDist, d: Double;
  i: Word;
  j: Byte;
begin
  ItemHit := 0;
  Result := p;
  smallestDist := BIG_DUMMY;
  for i := 1 to pred(CurrentItem) do
    with TrussRects.Item[i]do
    begin
      for j := 1 to 4 do
      begin
        d := LineLength2D(p, Pt[j]);
        if d < smallestDist then
        begin
          smallestDist := d;
          Result := Pt[j];
          ItemHit := i;
        end;
      end;
    end;
end;

function RectIsVertical(Idx: Word): Bool;
begin
  with TrussRects.Item[Idx] do
    Result := abs(Pt[1].X - Pt[2].X) <= 1;
end;

function RectIsHorizontal(Idx: Word): Bool;
begin
  with TrussRects.Item[Idx] do
    Result := abs(Pt[1].Y - Pt[2].Y) <= 1;
end;

//* Make TrussRects.Item[Idx1] parallel to TrussRects.Item[Idx2]
procedure MakeRectParallel(Idx1, Idx2: Word);
var
  V12, V14: Vector2D;
  w, L: Double;
  p: array[1 .. 4]of Point2D;
  i: Byte;
begin
  if (Idx1 = 0)or(Idx2 = 0) then
    exit;
  SaveUndo('Make Parallel');
  with TrussRects.Item[Idx2] do
  begin
    V12 := Vector2DFrom2DPoints(Pt[1], Pt[2]);
    V14 := Vector2DFrom2DPoints(Pt[1], Pt[4]);
  end;
  with TrussRects.Item[Idx1] do
  begin
    L := LineLength2D(Pt[1], Pt[2]);
    w := LineLength2D(Pt[1], Pt[4]);

    if EditTip = tt14 then
    begin
      p[1] := Pt[1];
      p[2] := Point2DFromParametricEquation(p[1], V12, L);
    end
    else begin
      p[2] := Pt[2];
      p[1] := Point2DFromParametricEquation(p[2], V12, -L);
    end;
    p[3] := Point2DFromParametricEquation(p[2], V14, w);
    p[4] := Point2DFromParametricEquation(p[1], V14, w);

    for i := 1 to 4 do
      Pt[i] := p[i];
  end;
end;

procedure ToggleDrawingState(p: Point2D; Shift: TShiftState);
begin
  bDrawing := not bDrawing;
  if bDrawing then
  begin
    bUseFlangeSide := not(ssCtrl in Shift);
    SnapStartToNearestTrussRect(p);
  end
  else begin
    SnapEndToNearestTrussRect;
    AddTrussRect(TrussRects.Item[CurrentItem], ssAlt in Shift);
  end;
end;

function ShowTranslateMeasureLineDialog(Idx: Word): Bool;
var
  j: Byte;
  V: Vector2D;
  d: Double;
  sDist: string;
  tempIdx: Word;
begin
  Result := False;
  if Idx = 0 then
    exit;

  sDist := '0';
  Result := InputQuery('Distance', 'Enter a new distance', sDist);
  if not Result then
    exit;

  SaveUndo('Translate Item');
  with MeasureLine do
  begin
    //d := LineLength2D(Pt[1], Pt[2]);
    d := LineLength2D(Pt[1], Pt[2]) - StrToFloat(sDist);
    if (Idx = HitIdx[2])and(Idx <> HitIdx[1]) then
    begin
      SwapPoints(Pt[1], Pt[2]);
      tempIdx := HitIdx[1];
      HitIdx[1] := HitIdx[2];
      HitIdx[2] := tempIdx;
    end;
    V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
    TranslatePoint(V, d, Pt[1]);
    if Round(StrToFloat(sDist))= 0 then
    begin
      FillChar(MeasureLine, SizeOf(MeasureLine), 0);
      frmMain.actMeasure.Checked := False;
      bMeasuring := False;
    end;
  end;
  for j := 1 to 4 do
    with TrussRects.Item[Idx]do
      TranslatePoint(V, d, Pt[j]);
end;

//* Delete TrussRects.Item[nItem]
procedure DeleteItem(nItem: Word);
var
  i, j, NumOps: Word;
begin
  if (nItem = 0)or(nItem > CurrentItem) then
    exit;
  SaveUndo('Delete');
  FillChar(TrussRects.Item[CurrentItem], SizeOf(TrussRects.Item[CurrentItem]), 0);
  //Recalculate the number of ops
  NumOps := 0;
  for i := 1 to pred(nItem)do
    for j := 1 to MAX_OPS do
      if TrussRects.Op[i, j].Kind <> okNone then
        inc(NumOps);

  for i := nItem to pred(CurrentItem)do
  begin
    TrussRects.Item[i] := TrussRects.Item[succ(i)];
    if Pos(NAME_PREFIX, TrussRects.ItemName[succ(i)]) = 0 then
      TrussRects.ItemName[i] := TrussRects.ItemName[succ(i)]
    else
      TrussRects.ItemName[i] := RawByteString(NAME_PREFIX + IntToStr(i));
    TrussRects.iType[i] := TrussRects.iType[succ(i)];
    for j := 1 to MAX_OPS do
    begin
      TrussRects.Op[i, j] := TrussRects.Op[succ(i), j];
      if TrussRects.Op[i, j].Kind <> okNone then
        inc(NumOps);
    end;
    TrussRects.OpCount[nItem] := NumOps;
  end;
  dec(CurrentItem);
  TrussRects.ItemName[CurrentItem] := '';
  FillChar(TrussRects.Item[CurrentItem], SizeOf(TrussRects.Item[CurrentItem]), 0);
  EditItem := 0;
end;

//* Mouse Down event handler
procedure TfrmMain.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p, SnapPt: Point2D;
  Idx, nItem, ItemHit: Word;
begin
  try
    case Button of
      mbMiddle: begin
          GetWorldCoords(X, Y, p);
          if Scale <> 0 then
          begin
            MovingScenePt.X := p.X / Scale;
            MovingScenePt.Y := p.Y / Scale;
          end;
        end;
      mbRight: begin
          Idx := GetItemAt(X, Y);
          if Idx > 0 then
          begin
            case ViewMode of
              vmEdit: ShowRectPropertiesForm(Idx, X, Y);
              vmAdjust: DisplayEntityItem(Idx);
            end;
          end;
        end;
    else begin
        if ViewMode <> vmEdit then
          exit;

        GetWorldCoords(X, Y, p);
        if actDraw.Checked then
          ToggleDrawingState(p, Shift)
        else begin //not actDraw.Checked
          if bMeasuring then
          begin
            SnapPt := NearestRectCorner(p, ItemHit);
            if ItemHit > 0 then
            begin
              if MeasureLine.HitIdx[1]= 0 then
              begin
                MeasureLine.Pt[1] := SnapPt;
                MeasureLine.HitIdx[1] := ItemHit;
              end
              else begin
                MeasureLine.Pt[2] := SnapPt;
                MeasureLine.HitIdx[2] := ItemHit;
                bMeasuring := False;
              end;
            end;
          end;
          if (MeasureLine.HitIdx[2]> 0)and(EditItem > 0)and(IsInRect(MeasureLine.TextArea, p)) then
            ShowTranslateMeasureLineDialog(EditItem);
          nItem := GetItemAt(X, Y);
          if actLock.Checked and(nItem <> 0)and(nItem < MinEditNumber)then
          begin
            bEditing := False;
            MessageDlg(format(EDITS_MSG, ['edited']), mtInformation, [mbOK], 0);
            exit;
          end;

          if (actEdit.Checked)and(nItem <> 0)and(nItem >= MinEditNumber)and(ssAlt in Shift)then
          begin
            DeleteItem(nItem);
            exit;
          end;

          if bMakingParallel then
          begin
            MakeRectParallel(EditItem, nItem);
            EditItem := 0;
            bEditing := False;
            bMakingParallel := False;
            exit;
          end;

          bEditing := (EditItem = nItem)and(not bEditing)and(not actMeasure.Checked);
          EditItem := nItem;
          if EditItem = 0 then
          begin
            bEditing := False; bMakingParallel := False;
          end
          else begin
            with TrussRects.Item[EditItem] do //Set rect
              EditWidth := abs(PerpDistance(Pt[1], Pt[2], MidPoint2D(Pt[3], Pt[4])));
            EditPt := p;
            EditTip := tt14;
            with TrussRects.Item[EditItem]do
              if LineLength2D(MidPoint2D(Pt[2], Pt[3]), p)< LineLength2D(MidPoint2D(Pt[1], Pt[4]), p)then
                EditTip := tt23;
            if bEditing then
              SaveUndo('Edit');
          end;
        end; //not actDraw.Checked
      end; // case else
    end;
  finally
    actFindItem.Enabled := (CurrentItem > 1);
    actMakeHorz.Enabled := (EditItem > 0)and(not RectIsVertical(EditItem))and(not RectIsHorizontal(EditItem));
    actMakeParallel.Enabled := (EditItem > 0);
    actShowAddOpForm.Enabled := (EditItem > 0)and (not bFrames);

    Paint;
  end;
end;

//* Mouse Move event handler
procedure TfrmMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  p, ClosePt: Point2D;
  dX, dY: Double;
  i: Byte;
  n: Integer;
  V: Vector2D;
begin
  GetWorldCoords(X, Y, p);
  bUseFlangeSide := not(ssCtrl in Shift);
  if bDrawing then
  begin
    if ViewMode = vmEdit then
    begin
      if actDraw.Checked then
      begin
        if bUseFlangeSide then
          TrussRects.Item[CurrentItem].Pt[2] := p
        else
          TrussRects.Item[CurrentItem].Pt[3] := p;
        SnapEndToNearestTrussRect;
        CompleteTrussItemRect(CurrentItem);
      end;
    end;
  end
  else begin
    if actDraw.Checked then
    begin
      if (ViewMode = vmEdit) then
        for i := 1 to 4 do
          TrussRects.Item[CurrentItem].Pt[i] := p;
    end
    else begin
      if (MeasureLine.HitIdx[1]> 0) and (MeasureLine.HitIdx[2]= 0) then
        MeasureLine.Pt[2] := p;
      if (bEditing)and(EditItem > 0) then
        with TrussRects.Item[EditItem] do
        begin
          ClosePt := ClosestPtOn2DLine(Pt[3], Pt[4], Pt[1]);
          V := Vector2DFrom2DPoints(Pt[1], ClosePt);

          dX := p.X - EditPt.X; dY := p.Y - EditPt.Y;
          if EditTip = tt14 then
          begin
            Pt[1].X := Pt[1].X + dX; Pt[1].Y := Pt[1].Y + dY;
            //Pt[4].x := Pt[4].x + dX;  Pt[4].y := Pt[4].y + dY;
            if bAngleSnap then
              Snap2ndPtToAngle(Pt[2], Pt[1], 5);
            if bSnap then
              SnapEditItemToNearestTrussRect;
            EditPt := Pt[1];
          end
          else begin
            Pt[2].X := Pt[2].X + dX; Pt[2].Y := Pt[2].Y + dY;
            //Pt[3].x := Pt[3].x + dX;  Pt[3].y := Pt[3].y + dY;
            if bAngleSnap then
              Snap2ndPtToAngle(Pt[1], Pt[2], 5);
            if bSnap then
              SnapEditItemToNearestTrussRect;
            EditPt := Pt[2];
          end;

          Pt[4] := Point2DFromParametricEquation(Pt[1], V, EditWidth);
          Pt[3] := Point2DFromParametricEquation(Pt[2], V, EditWidth);
          for n := 1 to TrussRects.OpCount[EditItem] do
            with TrussRects.Op[EditItem, n]do
            begin
              //p.x := p.x + dX;    p.y := p.y + dY;   //doesn't work
              p := PointFromOpAndDist(EditItem, Kind, Pos);
            end;
        end;
    end;
  end;

  //Middle Mouse btn Translation
  if ssMiddle in Shift then
  begin
    if Scale <> 0 then
    begin
      dX := (MovingScenePt.X - p.X / Scale);
      dY := (MovingScenePt.Y - p.Y / Scale);
      glTranslated(-dX, -dY, 0);
    end;
    CentrePt := ViewportCentreAsWorldPt;
  end;

  Paint;
end;

//* Make the 2nd end of TrussRects.Item[Idx]
procedure TfrmMain.CompleteTrussItemRect(Idx: Word);
var
  Dirn: Extended;
  dX, dY: Double;
begin
  with TrussRects.Item[Idx]do
  begin
    if bUseFlangeSide then
    begin
      Dirn := LineDirectionRadians(Pt[1], Pt[2]);
      dX := RectWidth * Sin(Dirn); dY := RectWidth * -Cos(Dirn);
      Pt[4].X := Pt[1].X + dX; Pt[4].Y := Pt[1].Y + dY;
      Pt[3].X := Pt[2].X + dX; Pt[3].Y := Pt[2].Y + dY;
    end
    else begin
      Dirn := LineDirectionRadians(Pt[4], Pt[3]);
      dX := -RectWidth * Sin(Dirn); dY := -RectWidth * -Cos(Dirn);
      Pt[1].X := Pt[4].X + dX; Pt[1].Y := Pt[4].Y + dY;
      Pt[2].X := Pt[3].X + dX; Pt[2].Y := Pt[3].Y + dY;
    end;
  end;
end;

  {
   function OleEntityFromEntity: OleVariant;
   var
   V, vPt, vFHoles, vLHoles, vNotch, vCope, vPosFHoles, vPosLHoles, vPosNotch, vPosCope: Variant;
   i, n: Word;
   j: Byte;
   begin
   n := pred(CurrentItem);
   V := VarArrayCreate([0,16, 1,n], varVariant);
   for i:=1 to n do
   with Entity[i] do
   begin
   V[0,i] := Truss;
   V[1,i] := Item;
   V[2,i] := iType;
   V[3,i] := ID;
   vPt := VarArrayCreate([0,3,0,1],varDouble);
   for j:=0 to 3 do
   begin
   vPt[j,0] := Pt[succ(j)].x;
   vPt[j,1] := Pt[succ(j)].y;
   end;
   V[4,i] := vPt;
   V[5,i] := Len;
   V[6,i] := Web;
   V[7,i] := Col;
   vFHoles := VarArrayCreate([0,99,0,1], varDouble);
   for j:=0 to 99 do
   begin
   vFHoles[j,0] := FHoles[succ(j)].x;
   vFHoles[j,1] := FHoles[succ(j)].y;
   end;
   V[8,i] := vFHoles;
   vLHoles := VarArrayCreate([0,99,0,1], varDouble);
   for j:=0 to 99 do
   begin
   vLHoles[j,0] := LHoles[succ(j)].x;
   vLHoles[j,1] := LHoles[succ(j)].y;
   end;
   V[9,i] := vLHoles;

   vNotch := VarArrayCreate([0,1,0,1], varDouble);
   for j:=0 to 1 do
   begin
   vNotch[j,0] := Notch[succ(j)].x;
   vNotch[j,1] := Notch[succ(j)].y;
   end;
   V[10,i] := vNotch;

   vCope := VarArrayCreate([0,1,0,1], varDouble);
   for j:=0 to 1 do
   begin
   vCope[j,0] := Cope[succ(j)].x;
   vCope[j,1] := Cope[succ(j)].y;
   end;
   V[11,i] := vCope;

   vPosFHoles := VarArrayCreate([0,99], varDouble);
   for j:=0 to 99 do
   vPosFHoles[j] := PosFHoles[succ(j)];
   V[12,i] := vPosFHoles;

   vPosLHoles := VarArrayCreate([0,99], varDouble);
   for j:=0 to 99 do
   vPosLHoles[j] := PosLHoles[succ(j)];
   V[13,i] := vPosLHoles;

   vPosNotch := VarArrayCreate([0,19], varDouble);
   for j:=0 to 19 do
   vPosNotch[j] := PosNotch[succ(j)];
   V[14,i] := vPosNotch;

   vPosCope := VarArrayCreate([0,19], varDouble);
   for j:=0 to 19 do
   vPosCope[j] := PosCope[succ(j)];
   V[15,i] := vPosCope;

   V[16,i] := Orientation;
   end;

   Result := OleVariant(V);
   end;
   }
  {
   procedure EntityFromOleEntity(E: OleVariant);
   var
   V: Variant;
   i: Integer;
   j: Byte;
   nItems: Word;
   begin
   nItems := pred(CurrentItem);
   FillChar(Entity, SizeOf(Entity),0);
   V := VarArrayCreate([0,16,1,nItems], varVariant);
   V := E;
   for i:=1 to nItems do
   with Entity[i] do
   begin
   Truss       := V[0,i];
   Item        := V[1,i];
   iType       := V[2,i];
   ID          := V[3,i];
   for j:=0 to 3 do
   begin
   //if j=0 then
   //ShowMessage(format('%s',[VarToStr(V[4,i][j,0])]));
   Pt[succ(j)].x := V[4,i][j,0];
   Pt[succ(j)].y := V[4,i][j,1];
   end;

   Len         := V[5,i];
   Web         := V[6,i];
   Col         := V[7,i];
   for j:=0 to 99 do
   begin
   FHoles[succ(j)].x := V[8,i][j,0];
   FHoles[succ(j)].y := V[8,i][j,1];
   end;
   for j:=0 to 99 do
   begin
   LHoles[succ(j)].x := V[9,i][j,0];
   LHoles[succ(j)].y := V[9,i][j,1];
   end;
   for j:=0 to 1 do
   begin
   Notch[succ(j)].x := V[10,i][j,0];
   Notch[succ(j)].y := V[10,i][j,1];
   end;
   for j:=0 to 1 do
   begin
   Cope[succ(j)].x := V[11,i][j,0];
   Cope[succ(j)].y := V[11,i][j,1];
   end;
   for j:=0 to 99 do
   PosFHoles[succ(j)] := V[12,i][j];
   //vPosLHoles := VarArrayCreate([0,99], varDouble);
   //vPosLHoles := V[13,i];
   for j:=0 to 99 do
   PosLHoles[succ(j)] := V[13,i][j];
   //vPosNotch := VarArrayCreate([0,19], varDouble);
   //vPosNotch := V[14,i];
   for j:=0 to 19 do
   PosNotch[succ(j)] := V[14,i][j];
   //vPosCope := VarArrayCreate([0,19], varDouble);
   //vPosCope := V[15,i];
   for j:=0 to 19 do
   PosCope[succ(j)] := V[15,i][j];
   Orientation := V[16,i];
   end;
   end;
  }

//* OpenGL selection routine
function TfrmMain.GetItemAt(X, Y: Integer): Word;
type
  PHit = ^THit;
  THit = packed record
    iCount, iNear, iFar: GLuint;
    Names: array[1 .. PICK_BUFFER_SIZE - 3] of GLuint;
  end;
var
  Viewport: TViewport;
  ProjMatrix: TOGLMatrix;
  i, HitIdx, NumHits: GLuint;
  aHit: PHit;
  ItemIdx: Word;
begin
  Result := 0;
  //Initialize
  glSelectBuffer(PICK_BUFFER_SIZE, @PickBuffer);

  //Selection
  glGetDoubleV(GL_PROJECTION_MATRIX, @ProjMatrix);
  glRenderMode(GL_SELECT);
  glInitNames;
  glPushName(0);
  glMatrixMode(GL_PROJECTION);
  glPushMatrix;
  glLoadIdentity;
  glGetIntegerV(GL_VIEWPORT, @Viewport);
  gluPickMatrix(X, Viewport.Height - Y, 5, 5, @Viewport);

  //Load the current Proj Matrix and Repaint to get hits
  glMultMatrixd(@ProjMatrix);
  FormPaint(nil);

  //Selection Done
  glMatrixMode(GL_PROJECTION);
  glPopMatrix;
  NumHits := glRenderMode(GL_RENDER);
  if NumHits > 0 then
  begin
    HitIdx := 1;
    aHit := @PickBuffer[HitIdx];
    for i := 1 to aHit^.iCount do
    begin
      ItemIdx := aHit^.Names[i];
      if (ItemIdx > 0) then
      begin
        Result := ItemIdx;
        break;
      end;
    end;
  end;

  glMatrixMode(GL_MODELVIEW); //return to normal rendering
end;

function TfrmMain.GetTotalTrussRectsLength: Double;
var
  i: Word;
begin
  Result := 0;
  for i := 1 to pred(CurrentItem)do
    with TrussRects.Item[i] do
      Result := Result + LineLength2D(Pt[1], Pt[2]);
end;

//* Init and open the RectProperties form
procedure TfrmMain.ShowRectPropertiesForm(Idx, X, Y: Integer);
var
  b: Bool;
  p: Point2D;
  TipClicked: TipType;
  V: Vector2D;
  L: Double;
  q: array[1 .. 4]of Point2D;
  AModalResult: TModalResult;
begin
  with TfrmRectProperties.Create(Application)do
  begin
    try
      Tag := Idx;
      gpRectInfo.Caption := format('Rect %d', [Idx]);
      with TrussRects.Item[Idx] do
      begin
        SetTextboxValues(Pt);
        GetTextboxValues(q);

        b := (Idx >= MinEditNumber); //disable locked items
        txtX1.Enabled := b;
        txtX2.Enabled := b;
        txtX3.Enabled := b;
        txtX4.Enabled := b;
        txtY1.Enabled := b;
        txtY2.Enabled := b;
        txtY3.Enabled := b;
        txtY4.Enabled := b;

        chkWeb.Checked := SameText(TrussRects.iType[Idx], sWEB)
                       or SameText(TrussRects.iType[Idx], sWEB2)
                       or SameText(TrussRects.iType[Idx], sBOX_WEB_2);
        chkMulti.Checked := SameText(TrussRects.iType[Idx], sCHORD2)
                         or SameText(TrussRects.iType[Idx], sWEB2);
        chkMulti.Enabled := bFrames and RectIsVertical(Idx);
        txtName.Text := TrussRects.ItemName[Idx];
        txtLength.Text := format('%.2f', [LineLength2D(Pt[1], Pt[2])]);
        lblTotalLength.Caption := format('Total Length: %.0f', [GetTotalTrussRectsLength]);
        GetWorldCoords(X, Y, p);
        TipClicked := tt14;
        if LineLength2D(p, MidPoint2D(Pt[2], Pt[3])) < LineLength2D(p, MidPoint2D(Pt[1], Pt[4])) then
          TipClicked := tt23;
        chkHideItem.Checked := TrussRects.bNonRFItem[Idx];
        AModalResult := ShowModal;
        case AModalResult of
          mrOK: begin
              SaveUndo('Property Change');
              //Modified added, because otherwise there's a rounding error
              if (txtX1.Modified)and(txtX1.Text <> '') then Pt[1].X := StrToFloat(txtX1.Text);
              if (txtX2.Modified)and(txtX2.Text <> '') then Pt[2].X := StrToFloat(txtX2.Text);
              if (txtX3.Modified)and(txtX3.Text <> '') then Pt[3].X := StrToFloat(txtX3.Text);
              if (txtX4.Modified)and(txtX4.Text <> '') then Pt[4].X := StrToFloat(txtX4.Text);
              if (txtY1.Modified)and(txtY1.Text <> '') then Pt[1].Y := StrToFloat(txtY1.Text);
              if (txtY2.Modified)and(txtY2.Text <> '') then Pt[2].Y := StrToFloat(txtY2.Text);
              if (txtY3.Modified)and(txtY3.Text <> '') then Pt[3].Y := StrToFloat(txtY3.Text);
              if (txtY4.Modified)and(txtY4.Text <> '') then Pt[4].Y := StrToFloat(txtY4.Text);

              if chkWeb.Checked then
              begin
                TrussRects.iType[Idx] := sWEB;
                if chkMulti.Checked then
                  TrussRects.iType[Idx] := sWEB2;
              end
              else begin
                TrussRects.iType[Idx] := sCHORD;
                if chkMulti.Checked then
                  TrussRects.iType[Idx] := sCHORD2;
              end;
              TrussRects.ItemName[Idx] := RawByteString(txtName.Text);
              if (txtLength.Modified)and(txtLength.Text <> '') then
              begin
                V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
                L := StrToFloat(txtLength.Text);
                if TipClicked = tt14 then
                begin
                  Pt[1] := Point2DFromParametricEquation(Pt[2], V, -L);
                  Pt[4] := Point2DFromParametricEquation(Pt[3], V, -L);
                end
                else begin
                  Pt[2] := Point2DFromParametricEquation(Pt[1], V, L);
                  Pt[3] := Point2DFromParametricEquation(Pt[4], V, L);
                end;
              end;
              TrussRects.bNonRFItem[Idx] := chkHideItem.Checked;
            end;
          mrIgnore: exit; //deleted
        else begin
            SetTextboxValues(q);
            GetTextboxValues(Pt);
          end;
        end;
      end; //with TrussRects.Item[Idx] do
    finally
      Free;
    end;
  end;
end;

procedure TfrmMain.btnAngleClick(Sender: TObject);
{const
 sPROMPT = 'Angle for Hole 1';
 sCAPTION = 'Please enter the maximum angle apart to force a hole 1 choice';
 var
 sAngle: string;    }
begin
  {  sAngle := FloatToStr(MaxAngleApart);
    if InputQuery(sPROMPT, sCAPTION, sAngle) then
    MaxAngleApart := StrToFloat(sAngle);

    if actAdjustForJoints.Checked then
    actAdjustForJointsExecute(nil);           }
end;

//* Close the Help panel
procedure TfrmMain.btnOKClick(Sender: TObject);
begin
  pnlHelp.Visible := False;
end;

//* Makes all items the same width
procedure TfrmMain.Button1Click(Sender: TObject);
var
  i: Integer;
  V: Vector2D;
  sWidth: string;
  w: Double;
begin
  sWidth := FloatToStr(TrussRectWidth);
  if not InputQuery('New Width', 'Please enter a new width for all items', sWidth) then
    exit;
  if sWidth = '' then
    exit;
  w := StrToFloat(sWidth);

  for i := 1 to CurrentItem do
    with TrussRects.Item[i]do
    begin
      V := Vector2DFrom2DPoints(Pt[1], Pt[4]);
      Pt[3] := Point2DFromParametricEquation(Pt[2], V, w);
      Pt[4] := Point2DFromParametricEquation(Pt[1], V, w);
    end;
end;

  {
   procedure SnapItemToTopChord(Idx: Word);
   const
   TOL = 1;
   var
   i: Word;
   L: LineType;
   bFound, bEnd1: Bool;
   p, Intercept: Point2D;
   V: Vector2D;
   d: Double;
   begin
   if (Idx < 1) then
   exit;
   //Choose the higher end
   bEnd1 := True;
   p := TrussRects.Item[Idx].Pt[1];
   if TrussRects.Item[Idx].Pt[2].y > p.y then
   begin
   bEnd1 := False;
   p := TrussRects.Item[Idx].Pt[2];
   end;

   bFound := False;
   for i := 1 to CurrentItem do
   if (SameText(TrussRects.iType[i], sCHORD)or SameText(TrussRects.iType[i], sCHORD2))
   and(Between(p.x, TrussRects.Item[i].Pt[1].x, TrussRects.Item[i].Pt[2].x, TOL))then
   begin               //Top Chord found above the item's high end
   L.Pt[1] := TrussRects.Item[i].Pt[1];
   L.Pt[2] := TrussRects.Item[i].Pt[2];
   bFound := True;
   break;
   end;
   if not bFound then
   exit;

   if not FindIntercept(TrussRects.Item[Idx].Pt[1], TrussRects.Item[Idx].Pt[2], L.Pt[1], L.Pt[2], Intercept)then
   exit;
   if not Between(Intercept.x, L.Pt[1].x, L.Pt[2].x, TOL)then
   exit;

   with TrussRects.Item[Idx]do
   begin
   V := Vector2DFrom2DPoints(Pt[1], Pt[4]);
   d := LineLength2D(Pt[1], Pt[4]);
   end;

   if bEnd1 then
   begin
   TrussRects.Item[Idx].Pt[1] := Intercept;
   TrussRects.Item[Idx].Pt[4] := Point2DFromParametricEquation(Intercept, V, d);
   end
   else begin
   TrussRects.Item[Idx].Pt[2] := Intercept;
   TrussRects.Item[Idx].Pt[3] := Point2DFromParametricEquation(Intercept, V, d);
   end;
   end;
  }

  {
   procedure FlipItem(TopLine, BottomLine: LineType; Idx: Word);
   var
   L: LineType;
   Intercept: Point2D;
   W, XOff, YOff: Double;
   bDown: Bool;
   begin
   with TrussRects.Item[Idx] do
   begin
   W := LineLength2D(Pt[1], Pt[4]);
   bDown := Pt[1].y > Pt[4].y;
   end;

   L.Pt[1] := TrussRects.Item[Idx].Pt[1];
   L.Pt[2].x := L.Pt[1].x;
   L.Pt[2].y := L.Pt[1].y + 1000;
   if FindIntercept(TopLine, L, Intercept) then
   TrussRects.Item[Idx].Pt[1] := Intercept;

   L.Pt[1] := TrussRects.Item[Idx].Pt[2];
   L.Pt[2].x := L.Pt[1].x;
   L.Pt[2].y := L.Pt[1].y + 1000;
   if FindIntercept(TopLine, L, Intercept) then
   TrussRects.Item[Idx].Pt[2] := Intercept;

   with TrussRects.Item[Idx]do
   begin
   GetOffSets(Pt[1], Pt[2], W, XOff, YOff);
   Pt[4].x := Pt[1].x + XOff;  Pt[4].y := Pt[1].y + YOff;
   Pt[3].x := Pt[2].x - XOff;  Pt[3].y := Pt[2].y - YOff;
   end;
   end;        }

  {
   procedure FlipItem(TopLine, BottomLine: LineType; Idx: Word);
   var
   L: LineType;
   MidPt, Intercept, q: Point2D;
   Angle: Extended;
   V1, V2: Vector2D;
   i: Byte;
   begin
   q := TrussRects.Item[Idx].Pt[1];
   if TrussRects.Item[Idx].Pt[2].y < TrussRects.Item[Idx].Pt[1].y then
   q := TrussRects.Item[Idx].Pt[2];

   L.Pt[1] := q;
   L.Pt[2].x := L.Pt[1].x;
   L.Pt[2].y := L.Pt[1].y + 1000;
   if not FindIntercept(TopLine, L, Intercept) then
   exit;

   with TrussRects.Item[Idx]do
   MidPt := MidPoint2D(Pt[1], Pt[2]);
   V1 := Vector2DFrom2DPoints(MidPt, L.Pt[1]);
   V2 := Vector2DFrom2DPoints(MidPt, Intercept);
   //TrussRects.Item[Idx].Pt[1] := Intercept;

   Angle := AngleBetweenVectors(V1, V2, True);

   for i := 1 to 4 do
   RotateAboutPoint(TrussRects.Item[Idx].Pt[i], MidPt, Angle, True);
   end;

   //* Look for top and bottom chords for p
   function FindTopAndBottomLines(var TopLine, BottomLine: LineType; p: Point2D): Bool;
   const
   TOL=1;
   var
   i: Word;
   bFound1: Bool;
   begin
   Result := False;

   bFound1 := False;
   for i := 1 to CurrentItem do
   if (SameText(TrussRects.iType[i], sCHORD)or SameText(TrussRects.iType[i], sCHORD2))
   and(Between(p.x, TrussRects.Item[i].Pt[1].x, TrussRects.Item[i].Pt[2].x, TOL))then
   begin               //Top Chord found above the item's high end
   if bFound1 then
   begin
   TopLine.Pt[1] := TrussRects.Item[i].Pt[1];
   TopLine.Pt[2] := TrussRects.Item[i].Pt[2];
   end
   else begin
   BottomLine.Pt[1] := TrussRects.Item[i].Pt[1];
   BottomLine.Pt[2] := TrussRects.Item[i].Pt[2];
   Result := True;
   break;
   end;
   end;
   //rough check to see it's the right way round
   if MidPoint2D(TopLine).y < MidPoint2D(BottomLine).y then
   begin     //assume they have opposite orientations
   SwapPoints(TopLine.Pt[1], BottomLine.Pt[2]);
   SwapPoints(TopLine.Pt[2], BottomLine.Pt[1]);
   end;
   end;

   //* Flip all web items
   procedure TfrmMain.Button2Click(Sender: TObject);
   var
   i: Word;
   TopLine, BottomLine: LineType;
   p: Point2D;
   begin
   for i := 1 to CurrentItem do
   if (SameText(TrussRects.iType[i], sWEB)or SameText(TrussRects.iType[i], sWEB2))then
   begin
   with TrussRects.Item[i] do
   p := MidPoint2D(Pt[1], Pt[2]);
   if FindTopAndBottomLines(TopLine, BottomLine, p)then
   FlipItem(TopLine, BottomLine, i);
   end;
   Paint;
   end;             }

  {  //second attempt
    procedure TfrmMain.Button2Click(Sender: TObject);
    var
    i: Word;
    begin
    for i := 1 to CurrentItem do
    if (SameText(TrussRects.iType[i], sWEB)or SameText(TrussRects.iType[i], sWEB2))then
    begin
    TiltItemPoints(TrussRects.Item[i].Pt);
    SnapItemToTopChord(i);
    end;
    Paint;
    end;
  }

//1st attempt
procedure TfrmMain.Button2Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to CurrentItem do
    if (SameText(TrussRects.iType[i], sWEB)or SameText(TrussRects.iType[i], sWEB2))then
      TiltItemPoints(TrussRects.Item[i].Pt);
  Paint;
end;

procedure TfrmMain.cboHoleToUseChange(Sender: TObject);
var
  n: Integer;
begin
  nForcedHoleIdx := 0;
  if not actHoleToUse.Enabled then // cboHoleToUse is also not Visible
    exit;

  n := cboHoleToUse.Items.IndexOf(cboHoleToUse.Text);
  if n in [1 .. 4] then
    nForcedHoleIdx := n;

  actAdjustForJointsExecute(nil);
end;

//* Convert the Rects into Entity items
procedure TfrmMain.GetEntityPointsFromTrussRects;
var
  i, n: Word;
  j: Byte;
begin
  ClearDynEntity;
  SetLength(DynEntity, pred(CurrentItem));
  for i := 1 to pred(CurrentItem)do
  begin
    DynEntity[pred(i)].Item := TrussRects.ItemName[i];
    for j := 1 to 4 do
      DynEntity[pred(i)].Pt[j] := TrussRects.Item[i].Pt[j];
    DynEntity[pred(i)].iType := TrussRects.iType[i];
    DynEntity[pred(i)].OpCount := TrussRects.OpCount[i];
    for n := 1 to TrussRects.OpCount[i] do
    begin
      DynEntity[pred(i)].Op[n] := TrussRects.Op[i, n];
      case TrussRects.Op[i, n].Kind of
        okLipHole,
        okFlgHole: DynEntity[pred(i)].Op[n].Kind := okIns;
      end;
    end;
    DynEntity[pred(i)].bNonRF := TrussRects.bNonRFItem[i];
  end;
end;

//* Find the middle of all the Rects and move that to the screen centre
procedure CentreTrussInWindow;
var
  mid13, p: Point2D;
  i, nItems: Word;
begin
  nItems := pred(CurrentItem);
  if nItems = 0 then
    exit;
  p := THE_ORIGIN;
  for i := 1 to nItems do
    with TrussRects.Item[i] do
    begin
      mid13 := MidPoint2D(Pt[1], Pt[3]);
      p.X := p.X + mid13.X; p.Y := p.Y + mid13.Y;
    end;
  p.X := p.X / nItems; p.Y := p.Y / nItems;
  CentrePointInViewport(p);
  CentrePt := p;
end;

//* Return the index of the item with the ItemName
function TrussRectIndexFromItemName(AName: string): Word;
var
  i: Word;
begin
  Result := 0;
  for i := 1 to CurrentItem do
    with TrussRects do
    begin
      if SameText(AName, ItemName[i]) then
      begin
        Result := i;
        exit;
      end;
    end;
end;

//* Save and cleanup the stringlist that stores the CSV data
procedure SaveAndFreeCSVList;
begin
  CSVStringList.SaveToFile(CSVFileName);
  CSVStringList.Free;
  CSVStringList := nil;
end;

//* Return the width, height and length of the entity
//* Used when getting the CSV data
procedure GetEntityWidthHeightLength(var w, H, L: Double);
var
  i: Integer;
  j: Byte;
  LoX, LoY, HiX, HiY: Double;
begin
  w := 0; H := 0; L := 0;
  LoX := BIG_DUMMY; LoY := BIG_DUMMY;
  HiX := -BIG_DUMMY; HiY := -BIG_DUMMY;
  for i := 0 to High(DynEntity)do
  begin
    for j := 1 to 4 do
    begin
      if DynEntity[i].Pt[j].X < LoX then
        LoX := DynEntity[i].Pt[j].X;
      if DynEntity[i].Pt[j].Y < LoY then
        LoY := DynEntity[i].Pt[j].Y;
      if DynEntity[i].Pt[j].X > HiX then
        HiX := DynEntity[i].Pt[j].X;
      if DynEntity[i].Pt[j].Y > HiY then
        HiY := DynEntity[i].Pt[j].Y;
    end;
    L := L + DynEntity[i].Len;
  end;
  if (LoX <> BIG_DUMMY)
  and(LoY <> BIG_DUMMY)
  and(HiX <> -BIG_DUMMY)
  and(HiY <> -BIG_DUMMY)then
  begin
    w := HiX - LoX; H := HiY - LoY;
  end;
end;

//* convert a file extension string to a gauge string
//* e.g. ".txt18" returns "18"
function GaugeFromFileName: string;
var
  sExt: string;
begin
  Result := '';
  sExt := ChangeFileExt(CSVFileName, ''); //remove the .csv
  sExt := ExtractFileExt(sExt);
  if(SameText(sExt, '.tx18'))
  or(SameText(sExt, '.tx20'))
  or(SameText(sExt, '.tx22'))
  or(SameText(sExt, '.tx24'))then
    Result := copy(sExt, 4, 2);
end;

//* Return the number of each op in the entity
//* Used when getting the CSV data
procedure GetOpsCount(var nCT, nIns, nCon1, nTek, nScr, nScb, nBrA, nBrB, nBrC, nBrace: Integer);
var
  i: Integer;
  j: Byte;
begin
  nCT := 0; nIns := 0; nCon1 := 0; nScr := 0; nScb := 0; nBrA := 0; nBrB := 0; nBrC := 0; nBrace := 0;
  for i := 0 to High(DynEntity)do
  begin
    for j := 1 to DynEntity[i].OpCount do
      case DynEntity[i].Op[j].Kind of
        okCT: inc(nCT);
        okIns: inc(nIns);
        okCon1: inc(nCon1);
        okTek: inc(nTek); // v.482 was , 2
        okTek2: inc(nTek, 2); // v.482 was , 4
        okTek4: inc(nTek, 4); // v.482 was , 8
        okScr: inc(nScr, DynEntity[i].Op[j].Num);
        okScb: inc(nScb);
        okBrA: inc(nBrA);
        okBrB: inc(nBrB);
        okBrC: inc(nBrC);
        okBrace: inc(nBrace);
      end;
  end;
end;

//* Add the CSV data to the stringlist
//* calls ProcessTruss
procedure GetCSVDataFromEntity(bMultiTruss: Bool; {ErrNum: Integer;} ATrussName: string);
var
  s: string;
  w, H, L: Double;
  //nErrNum: Integer;
  nCT, nIns, nCon1, nTek, nScr, nScb, nBrA, nBrB, nBrC, nBrace: Integer;
begin
  if CSVFileName = '' then
    exit;
  {  //........from Steel Designer..........
    if not HasImperialSettings then
    Writeln(csv, 'Desc,No. Items,Group,Width,Height,Total Length,Area(m²),Weight(kg),Gauge,Thick,Rivets,Sm Service,Lrg Service,Item Weight(kg),Plates,LHeaders,Strapping,Bracing,Bucking,Elements ..')
    else
    Writeln(csv, 'Desc,No. Items,Group,Width,Height,Total Length,Area(ft²),Weight(lb),Gauge,Thick,Rivets,Sm Service,Lrg Service,Item Weight(kg),Plates,LHeaders,Strapping,Bracing,Bucking,Elements ..');
    }
  //Desc,No. Items,Gauge,Width,Height,Length,Total Length,Rivets,Total Rivets,CT,Ins,Con1,nTek,Scr,Scb,BrA,BrB,BrC,Brace
  //Bolts for trusses
  //nRivets := ErrNum;
  if (not bMultiTruss) then
  begin
    frmMain.GetEntityPointsFromTrussRects; //Raw rect data, already done if multitruus
    {nErrNum :=} ProcessTruss(DynEntity, Length(DynEntity));
  end;
  s := ATrussName; //desc
  s := format('%s,%d', [s, Length(DynEntity)]); //no. items
  if CSVGauge <> '' then
    s := format('%s,%s', [s, CSVGauge])
  else //gauge
    s := format('%s,%s', [s, GaugeFromFileName]);
  GetEntityWidthHeightLength(w, H, L);
  s := format('%s,%.0f', [s, w]); //width
  s := format('%s,%.0f', [s, H]); //height
  s := format('%s,%.0f', [s, L]); //Length
  s := format('%s,%.0f', [s, L * CSVTrussQuantity]);//Total Length
  //s := s + ',';
  //s := s + IntToStr(TotalRivets) + ',';          //Rivets, or Bolts for trusses
  s := format('%s,%d', [s, TotalRivets]);
  s := format('%s,%d', [s, TotalRivets * CSVTrussQuantity]); //Total Rivets
  {if nRivets > 0 then
   s := s + IntToStr(nRivets)
   else
   s := s + 'joint error';  }
  GetOpsCount(nCT, nIns, nCon1, nTek, nScr, nScb, nBrA, nBrB, nBrC, nBrace);
  s := format('%d,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d'
    , [CSVTrussQuantity, s, nCT, nIns, nCon1, nTek, nScr + nScb, nBrA, nBrB, nBrC, nBrace]); //Screws etc

  CSVStringList.Add(s);
end;

procedure AnalyseTruss(sName: string);
var
  ErrNum: Integer;
begin
  frmMain.GetEntityPointsFromTrussRects; //Raw rect data
  ErrNum := ProcessTruss(DynEntity, Length(DynEntity));
  GetCSVDataFromEntity(True, {ErrNum,} sName);
  if CSVFileName <> '' then
    exit;

  //ShowErrorInformation(nRivets);

  SLMultiTrussErrors.Add(format('---------- %s analysis ----------', [sName]));

  //Errors are have a -ve number, RESULT_ADDED_NOTCH_ERR is the lowest so far
  if (ErrNum >= 0)or(ErrNum < RESULT_ADDED_NOTCH_ERR) then
  begin
    SLMultiTrussErrors.Add('No errors found');
    SLMultiTrussErrors.Add('');
    exit;
  end;
  SLMultiTrussErrors.AddStrings(SLErrorItems);
  SLMultiTrussErrors.Add('');
end;

//* Open the errors form to show the result of the last ProcessTruss call
//* Won't happen if a CSV is being created
procedure ShowMultiTrussErrors;
begin
  if CSVFileName <> '' then
    exit;
  with TfrmErrors.Create(Application)do
  begin
    try
      Caption := 'Analysis of Trusses';
      lblErrorDesc.Caption := 'Error List';
      memErrors.Lines.Assign(SLMultiTrussErrors);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

//* Returns True if the filename has an EPF extension (*.EP2)
function HasEPFFileExtension(AFileName: TFileName): Bool;
begin
  Result := SameText(ExtractFileExt(AFileName), '.' + ENCRYPTED_PANEL_FILE_EXT);
end;

function HasTxNNFileExtension(AFileName: TFileName): Bool;
var
  sExt: string;
begin
  sExt := ExtractFileExt(AFileName);
  Result := StartsText('.tx', sExt) and not SameText('.txt', sExt);
end;

//* Gets a hash from a real number, the hash is a fomatted date-time string
//* otherwise the application changes the word to the word at the user's locale
function LocaleStrFromFloat(f: Double): AnsiString;
const
  HASH_FORMAT_STR = 'dmmyyyyhnnssddddzzza/p';
var
  AFormatSettings: TFormatSettings;
begin
  GetLocaleFormatSettings($1409, AFormatSettings); //use NZ as the LocaleID
  Result := RawByteString(FormatDateTime(HASH_FORMAT_STR, f, AFormatSettings));
end;

//* Decrypt the EPF file
procedure LoadEPFFileStrings(AFileName: TFileName; AStrings: TStrings);
var
  fs: TFileStream;
  Cipher: TDCP_blowfish;
  ms: TMemoryStream;
  ds: TDecompressionStream;
  s: AnsiString;
  N: integer;
begin
  Cipher := TDCP_blowfish.Create(nil);
  try
    //Cipher.InitStr( LocaleStrFromFloat(1.1414), TDCP_sha1 );    //epf files
    Cipher.InitStr(LocaleStrFromFloat(2.718), TDCP_sha1);
    AFileName := ChangeFileExt(AFileName, '.' + ENCRYPTED_PANEL_FILE_EXT);
    fs := TFileStream.Create(AFileName, fmOpenRead);
    try
      ms := TMemoryStream.Create;
      ds := TDecompressionStream.Create(ms);
      try
        Cipher.DecryptStream(fs, ms, fs.Size);
        Cipher.Burn;
        ds.Seek(0, soFromEnd);
        N := ds.Position;
        SetLength(s, N);
        ds.Position := 0;
        ds.Read(PAnsiChar(s)^, N);
      finally
        ds.Free;
        ms.Free;
      end;
      AStrings.Text := s;
    finally
      fs.Free;
    end;
  finally
    Cipher.Free;
  end;
end;

//* Open a file and read the data into the TrussRects array
//* IdentifierFromString
//* to
//* AddOtherRectPtFromStrings
//* are local routines that help in the OpenTrussData procedure
procedure TfrmMain.OpenTrussData(AFileName: TFileName);
type
  IdentifierType = (itNone, itChord, itWeb, itCT, itInsert, itCope, itNotch
                 , itCon1, itTek, itTek2, itTek4
                 , itScr, itScb
                 , itBrA, itBrB, itBrC, itBrace, itPC, itS1, itS2
                 , itSwage, itSlot
                 , itBChord, itHeel //2 types for ScotSteel trusses
                 , itGauge          //for SCSDesign CSV truss gauges, Design truss gauges use the file extension
                 , it2Rivet, it4Rivet, it2Rivet2Tek, it2Rivet4Tek); // new for C-Section trusses
  {--------------------------------------------------------------}
  function IdentifierFromString(s: string): IdentifierType;
  begin
    Result := itNone;
    s := Trim(s);
    if SameText(s, sCHORD)then begin Result := itChord; exit; end;
    if SameText(s, sCHORD2)then begin Result := itChord; exit; end;
    if SameText(s, sWEB)then begin Result := itWeb; exit; end;
    if SameText(s, sWEB2)then begin Result := itWeb; exit; end;
    if SameText(s, 'Heel')then begin Result := itHeel; exit; end; //5 types for ScotSteel trusses
    if SameText(s, 'BC')then begin Result := itBChord; exit; end;
    if SameText(s, sBOX_WEB_2)then begin Result := itWeb; exit; end;
    if SameText(s, sBOX_HEEL_2)then begin Result := itHeel; exit; end;
    //if SameText(s, 'WebBr')then begin Result:=itWeb; exit; end;
    if SameText(s, 'CT')then begin Result := itCT; exit; end;
    if SameText(s, 'Insert')then begin Result := itInsert; exit; end;
    if SameText(s, 'Cope')then begin Result := itCope; exit; end;
    if SameText(s, 'Notch')then begin Result := itNotch; exit; end;
    if SameText(s, 'Con1')then begin Result := itCon1; exit; end;
    if SameText(s, 'Tek')then begin Result := itTek; exit; end;
    if SameText(s, 'Tek 2')then begin Result := itTek2; exit; end;
    if SameText(s, 'Tek 4')then begin Result := itTek4; exit; end;
    if SameText(s, 'Scr02')then begin Result := itScb; exit; end; //TP changed this from 'Scb'
    if SameText(s, 'Gauge')then begin Result := itGauge; exit; end;

    // C-Section ops
    if SameText(s, '2R')then begin Result := it2Rivet; exit; end;
    if SameText(s, '4R')then begin Result := it4Rivet; exit; end;
    if SameText(s, '2R+2T')then begin Result := it2Rivet2Tek; exit; end;
    if SameText(s, '2R+4T')then begin Result := it2Rivet4Tek; exit; end;

    if SameText(s, 'Brace')then begin Result := itBrace; exit; end;
    if SameText(s, 'Swage')then begin Result := itSwage; exit; end;

    s := copy(s, 1, 4);
    if SameText(s, 'Slot')then begin Result := itSlot; exit; end;

    s := copy(s, 1, 3);
    if SameText(s, 'Scr')then begin Result := itScr; exit; end;
    if SameText(s, 'Scb')then begin Result := itScb; exit; end;

    s := copy(s, 1, 2);
    if SameText(s, 'BA')then begin Result := itBrA; exit; end;
    if SameText(s, 'BB')then begin Result := itBrB; exit; end;
    if SameText(s, 'BC')then begin Result := itBrC; exit; end;
    if SameText(s, 'PC')then begin Result := itPC; exit; end;
    if SameText(s, 'S1')then begin Result := itS1; exit; end;
    if SameText(s, 'S2')then Result := itS2;
  end;
{--------------------------------------------------------------}
var
  isInInches: Bool;
  SL: TStringList;
  nOpsOverflow: Integer;
  {--------------------------------------------------------------}
  procedure AddRectPtsFromStrings(AItemName: string; FromIdx: Integer);
  var
    i: Integer;
    j: Byte;
    fX, fY: Double;
  begin
    inc(CurrentItem);
    TrussRects.bNonRFItem[CurrentItem] := (AItemName[1] = HIDDEN_ITEM_CHAR);
    if (AItemName[1] = HIDDEN_ITEM_CHAR)then //hides the tildes
      AItemName := copy(AItemName, 2, pred(Length(AItemName)));
    TrussRects.ItemName[CurrentItem] := RawByteString(AItemName);

    j := 1;
    i := FromIdx;
    while i < FromIdx + 7 do
    begin
      fX := StrToFloat(SL[i]);
      fY := StrToFloat(SL[succ(i)]);
      if isInInches then
      begin
        fX := fX * MM_IN_AN_INCH; fY := fY * MM_IN_AN_INCH;
      end;
      TrussRects.Item[CurrentItem].Pt[j].X := fX;
      TrussRects.Item[CurrentItem].Pt[j].Y := fY;
      inc(i, 2);
      inc(j);
    end;
    with TrussRects.Item[CurrentItem]do //don't allow very short items
      if LineLength2D(Pt[1], Pt[2]) < 5 then //  5 ???
      begin
        FillChar(TrussRects.Item[CurrentItem], SizeOf(TrussRects.Item[CurrentItem]), 0);
        dec(CurrentItem);
      end;
  end;
  function StrToScrNum(s: string; nChars: Byte): Word;
  var
    L: Integer;
  begin
    Result := 0;
    L := Length(s);
    if L > nChars then
      Result := StrToInt(copy(s, succ(nChars), L - nChars));
  end;
  function StrToPCNum(s: string): Word;
  var
    L: Integer;
  begin
    Result := 0;
    L := Length(s);
    if L > 2 then
      Result := Trunc(StrToFloat(copy(s, 3, L - 2)) * 1000);
  end;
  function OpExists(ItemIdx: Integer; AKind: TOpKind; X, Y: Double): Bool;
  const
    TOL = 1;
  var
    j: Integer;
  begin
    Result := False;
    for j := 1 to MAX_OPS do
      if (TrussRects.Op[ItemIdx, j].Kind = AKind)
      and(abs(TrussRects.Op[ItemIdx, j].p.X - X)< TOL)
      and(abs(TrussRects.Op[ItemIdx, j].p.Y - Y)< TOL)then
      begin
        Result := True;
        exit;
      end;
  end;
  function IdentifierToOpKind(AnID: IdentifierType): TOpKind;
  begin
    Result := okNone;
    case AnID of
      itCT: Result := okCT;
      itInsert: Result := okIns;
      itCope: Result := okCope;
      itNotch: Result := okNotch;
      itCon1: Result := okCon1;
      itTek: Result := okTek;
      itTek2: Result := okTek2;
      itTek4: Result := okTek4;
      itScr: Result := okScr;
      itScb: Result := okScb;
      itBrA: Result := okBrA;
      itBrB: Result := okBrB;
      itBrC: Result := okBrC;
      itBrace: Result := okBrace;
      itPC: Result := okPC;
      itS1: Result := okServ1;
      itS2: Result := okServ2;
      itSwage: Result := okSwage;
      itSlot: Result := okSlot;
      it2Rivet: Result := ok2Rivet;
      it4Rivet: Result := ok4Rivet;
      it2Rivet2Tek: Result := ok2Rivet2Tek;
      it2Rivet4Tek: Result := ok2Rivet4Tek;
    end;
  end;
  procedure AddOtherRectPtFromStrings(AItemName: string; FromIdx: Integer; AnID: IdentifierType);
  const
    DUP_MSG = 'Operation already exists: '#13#10
            + #9'%s'#13#10
            + #9'%s'#13#10
            + #9'(X, Y) = (%s, %s)';
  var
    fX, fY, d: Double;
    Idx: Integer;
    AKind: TOpKind;
  begin
    Idx := TrussRectIndexFromItemName(AItemName);
    if Idx = 0 then
      exit;

    if TrussRects.OpCount[Idx] >= MAX_OPS then
    begin
      inc(nOpsOverflow);
      exit;
    end;

    fX := StrToFloat(SL[FromIdx]);
    fY := StrToFloat(SL[succ(FromIdx)]);
    if isInInches then
    begin
      fX := fX * MM_IN_AN_INCH; fY := fY * MM_IN_AN_INCH;
    end;
    AKind := IdentifierToOpKind(AnID);
    if (not bIgnoreDuplicateOps)then //only check if the Ignore flag is off
      if OpExists(Idx, AKind, fX, fY)then
      begin
        MessageDlg(format(DUP_MSG,[AItemName, SL[pred(FromIdx)], SL[FromIdx], SL[succ(FromIdx)]])
                  , mtInformation, [mbOK], 0);
        exit;
      end;
    with TrussRects do
    begin
      inc(OpCount[Idx]);
      Op[Idx, OpCount[Idx]].p.X := fX;
      Op[Idx, OpCount[Idx]].p.Y := fY;
      Op[Idx, OpCount[Idx]].Kind := AKind;
      case AKind of
        okScr,
        okScb: Op[Idx, OpCount[Idx]].Num := StrToScrNum(SL[pred(FromIdx)], 3);
        okBrA,
        okBrB,
        okBrC: Op[Idx, OpCount[Idx]].Num := StrToScrNum(SL[pred(FromIdx)], 2);
        okPC: Op[Idx, OpCount[Idx]].Num := StrToPCNum(SL[pred(FromIdx)]);
        okIns:
          begin
            d := abs(PerpDistance(Item[Idx].Pt[1], Item[Idx].Pt[2], Op[Idx, OpCount[Idx]].p));
            Op[Idx, OpCount[Idx]].Kind := okLipHole;
            if abs(d - FlgHolePos) < abs(d - LipHolePos) then
              Op[Idx, OpCount[Idx]].Kind := okFlgHole;
          end;
      end;
      //not required in AdjustForJoints
      //here so that added ops move when a rect is moved
      Op[Idx, OpCount[Idx]].Pos := abs(PerpDistance(Item[Idx].Pt[1], Item[Idx].Pt[4], Op[Idx, OpCount[Idx]].p));
    end; //with
  end;
  procedure SetProperty(const APropertyString: string);
  var
    i: integer;
    key, value: string;
  begin
    i:=pos(':',APropertyString);
    if i>0 then
    begin
      key:=copy(APropertyString,1,i-1);
      value:=copy(APropertyString,i+1,99);
      if SameText('$Steel', key) then
        CSVGauge:=value;
      if SameText('$Type', key) then
        FrameType := value;
      if SameText('$C_SECTION', key) then
        bFrames := StrToBool(Value);
    end;
  end;
{--------------------------------------------------------------}
const
  MAX_OPS_MSG = 'Too many operations!'#13#10
              + 'The maximum is %d, the data has %d';
  sMSG = 'An unknown identifier: "%s" was found.'#13#10#13#10
       + 'Some data may not have been read from:'#13#10
       + '%s';
var
  i: Integer;
  s1stTrussName, sTrussName, sItemName, sDelim: string;
  Identifier: IdentifierType;
begin
  actNewExecute(nil);
  FillChar(CrRatios, SizeOf(CrRatios), 0);
  if not FileExists(AFileName)then
    exit;

  DataFile := AFileName;
  if ParamCount = 0 then
    AddToMRU(AFileName);
  Caption := format('%s - %s', [APP_TITLE, ExtractFileName(AFileName)]);
  Application.Title := Caption;

  ClearDynEntity;
  MinEditNumber := -1;
  actRects.Checked := True;
  ViewMode := vmEdit;
  SL := TStringList.Create;
  try
    FillChar(TrussRects, SizeOf(TrussRects), 0);
    CurrentItem := 0;
    if HasEPFFileExtension(AFileName)then
    begin
      LoadEPFFileStrings(AFileName, SL);
      bFrames := True;
      FormSettings.pgc.ActivePage := FormSettings.tabPanels;
    end
    else begin
      if HasTxNNFileExtension(AFileName)then
      begin
        bFrames := False;
        FormSettings.pgc.ActivePage := FormSettings.tabTrusses;
      end;
      SL.LoadFromFile(AFileName);
    end;
    for i := 0 to pred(SL.Count)do //remove the whitespace
      SL[i] := Trim(SL[i]);
    while (SL.Count > 0) and StartsText('$', SL[0]) do
    begin
      SetProperty(SL[0]);
      SL.Delete(0);
    end;
    if SL.Count < 14 then //min for 1 item
      exit;
    isInInches := SameText(SL[0], 'inches');
    sDelim := SL[0]; //for .txNN files which have multiple trusses separated by 'mm' or 'inches'

    {   MinEndDist := StrToFloat(SL[1]);
      if isInInches then
      MinEndDist := MinEndDist * MM_IN_AN_INCH;
      if (not bFrames) then
      TrussHoleDist := MinEndDist;      }
    {else
     PanelHoleDist := MinEndDist;     }
    //ignore the MinEndDist string for frames
    TrussHoleDist := StrToFloat(SL[1]);
    if isInInches then
      TrussHoleDist := TrussHoleDist * MM_IN_AN_INCH;
    if (not bFrames)then
      MinEndDist := TrussHoleDist + HoleSize;

    SLMultiTrussErrors := TStringList.Create;
    try
      CSVTrussQuantity := StrToInt(SL[3]);
      SL.Delete(3); //number of trusses (only show one, analyse otherwise)
      SL.Delete(1); //remove MinEndDist
      SL.Delete(0); //'inches' the units identifier

      s1stTrussName := SL[0];
      i := 0; nOpsOverflow := 0;
      while i < SL.Count do
      begin
        sTrussName := SL[i]; //v84
        if sTrussName = '' then
          break;
        if (sTrussName = sDelim) then
        begin
          inc(CurrentItem);
          AnalyseTruss(s1stTrussName);
          SL.Delete(i); //delete the 'mm' or 'inches'
          TrussHoleDist := StrToFloat(SL[i]);
          if isInInches then
            TrussHoleDist := TrussHoleDist * MM_IN_AN_INCH;
          if (not bFrames)then
            MinEndDist := TrussHoleDist + HoleSize;
          SL.Delete(i); //delete the MinEnd dist
          sTrussName := SL[i]; //new TrussName
          s1stTrussName := sTrussName;
          SL.Delete(i); //delete TrussName
          CSVTrussQuantity := StrToInt(SL[i]); //get the next count

          FillChar(TrussRects, SizeOf(TrussRects), 0);
          CurrentItem := 0;
          nOpsOverflow := 0;
        end;
        if not SameText(sTrussName, s1stTrussName) then
        begin
          inc(CurrentItem); //v137
          AnalyseTruss(s1stTrussName);
          SL.Delete(i);
          SL.Delete(i);
          sTrussName := SL[i];
          s1stTrussName := sTrussName;
          SL.Delete(succ(i));
          FillChar(TrussRects, SizeOf(TrussRects), 0);
          CurrentItem := 0;
          nOpsOverflow := 0;
          //break;
        end;
        sItemName := SL[succ(i)];
        Identifier := IdentifierFromString(SL[i + 2]);
        case Identifier of
          itNone:
            begin
              TaskMessageDlg('Unknown identifier', format(sMSG, [SL[i + 2], AFileName]), mtWarning, [mbOK], 0);
              break;
            end;
          itChord,
          itBChord,
          itHeel,
          itWeb:
            begin
              AddRectPtsFromStrings(sItemName, i + 3);
              TrussRects.iType[CurrentItem] := RawByteString(Trim(SL[i + 2]));
              inc(i, 11);
            end;
          {itChord,
           itBChord,
           itHeel:   begin
           AddRectPtsFromStrings(sItemName, i+3);
           TrussRects.iType[CurrentItem] := sCHORD;
           inc(i, 11);
           end;
           itWeb:    begin
           AddRectPtsFromStrings(sItemName, i+3);
           TrussRects.iType[CurrentItem] := sWEB;
           inc(i, 11);
           end;      }
          itCT,
          itInsert,
          itCope,
          itNotch,
          itCon1,
          itTek, itTek2, itTek4,
          itScr,
          itScb,
          itBrA,
          itBrB,
          itBrC,
          itBrace,
          itPC,
          itS1,
          itS2,
          itSwage,
          itSlot,
          it2Rivet, it4Rivet, it2Rivet2Tek, it2Rivet4Tek:
            begin
              //if TrussRects.OpCount < MAX_OPS then
              AddOtherRectPtFromStrings(sItemName, i + 3, Identifier);
              //else
              //  inc(nOpsOverflow);
              inc(i, 5);
            end;
          itGauge:
            begin
              CSVGauge := SL[i + 3];
              inc(i, 4);
            end;
        end;
      end;
      inc(CurrentItem);
      CentreTrussInWindow;
      //AddToMRU(AFileName);
      Ribbon1.DocumentName := AFileName;
      Paint;
    finally
      if (SLMultiTrussErrors <> nil) then
      begin
        if SLMultiTrussErrors.Count > 0 then
        begin
          AnalyseTruss(s1stTrussName);
          ShowMultiTrussErrors;
        end;
        SLMultiTrussErrors.Free;
        SLMultiTrussErrors := nil;
      end;
    end;
  finally
    if CurrentItem = 0 then
      CurrentItem := 1;
    SL.Free;
  end;

  if (CSVFileName <> '')then
  begin
    GetCSVDataFromEntity(False, {0,} s1stTrussName);
    SaveAndFreeCSVList;
  end;

  actFindItem.Enabled := (CurrentItem > 1);
  //ActionToolBar1.Visible := True;
  if nOpsOverflow > 0 then
    MessageDlg(format(MAX_OPS_MSG, [MAX_OPS, MAX_OPS + nOpsOverflow]), mtError, [mbOK], 0);
end;

//* Common event handler for the radio buttons in the help panel
//* Determines which help is shown
procedure TfrmMain.radHelpTextClick(Sender: TObject);
begin
  memHelp.Visible := radHelpText.Checked;
  pnlOrientation.Visible := radOrientation.Checked;
  memShortcutKeys.Visible := radShortcutKeys.Checked;
end;

function TfrmMain.GetTotalEntityLength: Double;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to High(DynEntity)do
    with DynEntity[i] do
      Result := Result + LineLength2D(Pt[1], Pt[2]);  //or use: + Len;
end;

//* Open the Entity properties form
procedure TfrmMain.DisplayEntityItem(Idx: Word);
const
  FORMAT_STR = '%.1f';
var
  nOps1, nOps2: Integer;
  L,delta: Double;
begin
  with DynEntity[pred(Idx)], EntityForm do
  begin
    nOps1 := 0; nOps2 := 0;
    txtTruss.Text := '';
    if DataFile <> '' then
      txtTruss.Text := ExtractFileName(ChangeFileExt(DataFile, ''));
    txtItemIndex.Text := IntToStr(Idx);
    txtLength.Text := format(FORMAT_STR, [Len]);
    L := GetTotalEntityLength;
    delta := L - GetTotalTrussRectsLength;
    lblTotalLength.Caption := format('Total Length: %.0f (%.0f change)', [L, delta]);

    memInfo.Clear;
    memInfo.Lines.Add('Notches: ' + EntityPosString(pred(Idx), eitPosNotch, nOps1));

    memInfo.Lines.Add('');
    if bFrames then
      memInfo.Lines.Add('Flats: ' + EntityPosString(pred(Idx), eitPosCope, nOps1))
    else
      memInfo.Lines.Add('Copes: ' + EntityPosString(pred(Idx), eitPosCope, nOps1));

    memInfo.Lines.Add('');
                 // //memInfo.Lines.Add('End Swages: ' + EntityPosString(pred(Idx), eitSwage, nOps1))
    memInfo.Lines.Add('Swages: ' + GetSwageString(pred(Idx)));

    memInfo.Lines.Add('');
    if (not bFrames)then
    begin
      memInfo.Lines.Add('Lip holes: ' + EntityPosString(pred(Idx), eitPosLHoles, nOps1));
      memInfo.Lines.Add('');
      memInfo.Lines.Add('Flg holes: ' + EntityPosString(pred(Idx), eitPosFHoles, nOps1));
    end
    else begin
      memInfo.Lines.Add('Flg holes: ' + EntityPosString(pred(Idx), eitPosLHoles, nOps1)); //wrong way round for MultiHole
      memInfo.Lines.Add('');
      memInfo.Lines.Add('Lip holes: ' + EntityPosString(pred(Idx), eitPosFHoles, nOps1));
    end;

    memInfo.Lines.Add('');

    //memInfo2 the distances from the other end
    memInfo2.Clear;
    memInfo2.Lines.Add('Notches: ' + EntityPosString(pred(Idx), eitPosNotch, nOps2, True));

    memInfo2.Lines.Add('');
    if bFrames then
      memInfo2.Lines.Add('Flats: ' + EntityPosString(pred(Idx), eitPosCope, nOps2, True))
    else
      memInfo2.Lines.Add('Copes: ' + EntityPosString(pred(Idx), eitPosCope, nOps2, True));

    memInfo2.Lines.Add('');
                  // //memInfo2.Lines.Add('End Swages: ' + EntityPosString(pred(Idx), eitSwage, nOps2, True))
    memInfo2.Lines.Add('Swages: ' + GetSwageString(pred(Idx), True));

    memInfo2.Lines.Add('');
    if (not bFrames)then
    begin
      memInfo2.Lines.Add('Lip holes: ' + EntityPosString(pred(Idx), eitPosLHoles, nOps2, True));
      memInfo2.Lines.Add('');
      memInfo2.Lines.Add('Flg holes: ' + EntityPosString(pred(Idx), eitPosFHoles, nOps2, True));
    end
    else begin
      memInfo2.Lines.Add('Flg holes: ' + EntityPosString(pred(Idx), eitPosLHoles, nOps2, True)); //wrong way round for MultiHole
      memInfo2.Lines.Add('');
      memInfo2.Lines.Add('Lip holes: ' + EntityPosString(pred(Idx), eitPosFHoles, nOps2, True));
    end;

    memInfo2.Lines.Add('');

    lblWeb.Caption := iType;
    lblOrientation.Caption := format('Orientation: %s', [OrientationDesc[Orientation]]);
    lblProfile.Caption := format('Profile: %.1f', [LineLength2D(Pt[1], Pt[4])]);
    lblOperations.Caption := 'Operations: ' + IntToStr(nOps1); // or nOps2, they are both the same
  end;
  EntityForm.Caption := format('Item %d details (%s)', [Idx, DynEntity[pred(Idx)].Item]);
  EntityForm.ShowModal;
end;

//* Key Down event handler
procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  SCROLL_DELTA = 100;
  sTITLE = 'Delete Item';
  sCAPTION = 'Please enter the item number to delete';
  sDELETED = 'deleted';
var
  s: string;
  n: Word;
begin
  case Key of
    VK_DELETE: if CurrentItem > 1 then
      begin
        if (not(ssCtrl in Shift)) then
        begin
          if EditItem > 0 then
            DeleteItem(EditItem)
          else
            if CurrentItem <= MinEditNumber then
              MessageDlg(format(EDITS_MSG, [sDELETED]), mtInformation, [mbOK], 0)
          else
            DeleteItem(CurrentItem);
        end
        else begin //Ctrl + DEL
          s := InputBox(sTITLE, sCAPTION, IntToStr(pred(CurrentItem)));
          if s <> '' then
          begin
            n := StrToInt(s);
            if n <= MinEditNumber then
            begin
              MessageDlg(format(EDITS_MSG, [sDELETED]), mtInformation, [mbOK], 0);
              exit;
            end;
            if (n > 0)and(n < CurrentItem)then
              DeleteItem(n);
          end;
        end;
      end;
    VK_ESCAPE: begin
        if pnlHelp.Visible then
          pnlHelp.Visible := False
        else
          bDrawing := False;
      end;
    //Zoom
    VK_ADD, VK_PRIOR: ZoomIn(1);
    VK_SUBTRACT, VK_NEXT: ZoomOut(1);
    //Scroll Keys
    VK_UP,
    VK_NUMPAD8, ord('8'): begin
                            glTranslated(0, SCROLL_DELTA, 0);
                            CentrePt := ViewportCentreAsWorldPt;
                          end;
    VK_DOWN,
    VK_NUMPAD2, ord('2'): begin
                            glTranslated(0, -SCROLL_DELTA, 0);
                            CentrePt := ViewportCentreAsWorldPt;
                          end;
    VK_LEFT,
    VK_NUMPAD4, ord('4'): begin
                            glTranslated(-SCROLL_DELTA, 0, 0);
                            CentrePt := ViewportCentreAsWorldPt;
                          end;
    VK_RIGHT,
    VK_NUMPAD6, ord('6'): begin
                            glTranslated(SCROLL_DELTA, 0, 0);
                            CentrePt := ViewportCentreAsWorldPt;
                          end;
  end;
  actFindItem.Enabled := (CurrentItem > 1);
  Paint;
end;

//* Cleanup the COM DLL object
procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  HoleFinder := nil;
end;

function TfrmMain.FormHelp(Command: Word; Data: Integer; var CallHelp: Boolean): Boolean;
begin
  CallHelp := False;
  //actHelpExecute(nil);
  Result := True; //False;
end;

procedure LoadCrRatiosFromFile(sFileName: string);
var
  i: Word;
  //MinX, MinY, MaxX, MaxY: Double;
begin
  FillChar(CrRatios, SizeOf(CrRatios), 0);
  if not FileExists(sFileName) then
    exit;

  {MinX := BIG_DUMMY;   MinY := BIG_DUMMY;
   MaxX := -BIG_DUMMY;  MaxY := -BIG_DUMMY;   }
  with TIniFile.Create(sFileName)do
  begin
    try
      i := 1;
      while SectionExists(IntToStr(i)) do
      begin
        CrRatios[i].ID := i;
        CrRatios[i].Pt[1].X := ReadFloat(IntToStr(i), 'x1', 0);
        CrRatios[i].Pt[1].Y := ReadFloat(IntToStr(i), 'y1', 0);
        CrRatios[i].Pt[2].X := ReadFloat(IntToStr(i), 'x2', 0);
        CrRatios[i].Pt[2].Y := ReadFloat(IntToStr(i), 'y2', 0);
        CrRatios[i].CrRatio := ReadFloat(IntToStr(i), 'CrRatio', -1);
        CrRatios[i].JointOk := ReadBool(IntToStr(i), 'JointOK', True);
        {
         if CrRatios[i].Pt[1].x < MinX then
         MinX := CrRatios[i].Pt[1].x;
         if CrRatios[i].Pt[1].y < MinY then
         MinY := CrRatios[i].Pt[1].y;

         if CrRatios[i].Pt[2].x < MinX then
         MinX := CrRatios[i].Pt[2].x;
         if CrRatios[i].Pt[2].y < MinY then
         MinY := CrRatios[i].Pt[2].y;

         if CrRatios[i].Pt[1].x > MaxX then
         MaxX := CrRatios[i].Pt[1].x;
         if CrRatios[i].Pt[1].y > MaxY then
         MaxY := CrRatios[i].Pt[1].y;

         if CrRatios[i].Pt[2].x > MaxX then
         MaxX := CrRatios[i].Pt[2].x;
         if CrRatios[i].Pt[2].y > MaxY then
         MaxY := CrRatios[i].Pt[2].y;              }

        inc(i);
      end;
    finally
      Free;
    end;
  end;

  //centre in the window
  {CentrePt.x := (MinX + MaxX) / 2;
   CentrePt.y := (MinY + MaxY) / 2;
   CentrePointInViewport(CentrePt);    }
end;

//* Init the COM DLL and respond to the command line parameters
procedure TfrmMain.FormShow(Sender: TObject);
const
  CSV_STR = 'Quantity,Desc,No. Items,Gauge,Width,Height,Length,Total Length,'
  //+ 'Bolts,Total Bolts,CT,Ins,Spacers,Screw,Screw 2,Brg A,Brg B,Brg C,Brace';
  + 'Bolts,Total Bolts,CT,Ins,Spacers,Teks,Screws,Brg A,Brg B,Brg C,Brace';
var
  sFileName, sCrRatioFile: TFileName;
  //i: Integer;
begin
  InitDLL;

  //Parameter
  //"C:\Documents and Settings\Bruce\My Documents\Delphi 6 Projects\TrussSim\141_Dev\Trusses\Test 1_Trusses\MachineData_Test 1_Trusses\MachineData_Test 1_Trusses.TX24" /CSV
  //"C:\Users\Bruce\Documents\SCS\ScotSteel\Current\~t~e~m~p.txt" /frame
  if (ParamCount > 0)then
  begin
    //    "C:\Documents and Settings\Bruce\My Documents\Delphi 6 Projects\TrussSim\RFTests\OneFrame.txt" /frame

    if FindCmdLineSwitch('frame')then
    begin
      bFrames := True;
      FormSettings.pgc.ActivePage := FormSettings.tabPanels;
    end;
    if FindCmdLineSwitch('truss')then
    begin
      bFrames := False;
      FormSettings.pgc.ActivePage := FormSettings.tabTrusses;
    end;

    //replaced with FindCmdLineSwitch above
    {for i:=1 to ParamCount do
     begin
     if SameText(ParamStr(i), '/frame')then
     begin
     bFrames := True;
     FormSettings.pgc.ActivePage := FormSettings.tabPanels;
     break;
     end;
     if SameText(ParamStr(i), '/truss')then
     begin
     bFrames := False;
     FormSettings.pgc.ActivePage := FormSettings.tabTrusses;
     break;
     end;
     end;      }

    sFileName := ParamStr(1);
    if FileExists(sFileName) then
    begin
      if HasEPFFileExtension(sFileName)then
      begin
        bFrames := True;
        FormSettings.pgc.ActivePage := FormSettings.tabPanels;
      end;
      //for i:=2 to ParamCount do
      //  if SameText(ParamStr(i), '/csv')then
      if FindCmdLineSwitch('csv')then
      begin
        //CSVFileName := ChangeFileExt(sFileName, CSV_FILE_EXT);
        CSVFileName := sFileName + CSV_FILE_EXT;
        CSVStringList := TStringList.Create;
        CSVStringList.Add(CSV_STR);
        //break;
      end;
      if CSVFileName <> '' then
        SetBounds(Screen.Width, Screen.Height, 1, 1); //off screen
      InitDLL;

      OpenTrussData(sFileName);

      sCrRatioFile := ChangeFileExt(sFileName, '.CrRatio');
      LoadCrRatiosFromFile(sCrRatioFile);
    end;
  end;
  if CSVFileName <> '' then
    Close;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  WriteIni;
end;


initialization
  //if ParamCount > 0 then
  WM_USR_MESSAGE := RegisterWindowMessage('ScotSteel ScotSim Message');
  if WM_USR_MESSAGE = 0 then
    RaiseLastOSError;

finalization
  ClearDynEntity;

END.
