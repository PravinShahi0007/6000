unit UnitScotTruss;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Variants, WinUtils,  ScotRFTypes, FrameDrawU, strUtils,
  StdCtrls, Buttons, ComCtrls, math, menus,  inifiles, units, IJPMasterU,
  VaConst, VaTypes, VaClasses, VaComm, ExtCtrls, VaSystem, VaBuffer, zlib,
  USettings,  Gauges, OleCtrls, GlobalU, Printers, ManufactureU, FrameDataU, jpeg,
  MintControls5626Lib_TLB, ToolWin, {ColorButton,} ImgList,
  ScktComp, BillboardU, GIFImg, ActnMan, ActnCtrls, CardAdapterU, CardAPIU, ijpStatusU, GestureMgr,
  System.ImageList, Datasnap.DSCommon, JSON, DBXJSON, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON;

type

  TFormScotTruss = class(TForm)
    OpencadDlg: TOpenDialog;
    ProcessDlg: TOpenDialog;
    PrintDialog1: TPrintDialog;
    PrintDialog2: TPrintDialog;
    ToolPanel: TPanel;
    bnPause: TSpeedButton;
    bnClose: TSpeedButton;
    InfoPanel: TPanel;
    Gauge1: TGauge;
    Panel2: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    lbProduction: TLabel;
    lbProductionRate: TLabel;
    Label13: TLabel;
    lbCardRemaining: TLabel;
    lbCardID: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    lbMetresToday: TLabel;
    Gauge2: TGauge;
    PanelRFOperation: TPanel;
    LabelRFDriver: TLabel;
    Animate1: TAnimate;
    LabelMotorMovingDistance: TLabel;
    PopupMenu1: TPopupMenu;
    miZPanel: TMenuItem;
    miZPanelNone: TMenuItem;
    miZPanelTR: TMenuItem;
    miZPanelBR: TMenuItem;
    miZPanelBL: TMenuItem;
    Billboard: TBillboard;
    ImageLogoTitle: TImage;
    InkjetStatus1: TInkjetStatus;
    ImageList32: TImageList;
    bnResume: TSpeedButton;
    PaintBox1: TPaintBox;
    uxPrecamber: TLabel;
    Splitter1: TSplitter;
    bnCalibrate: TSpeedButton;
    bnViewPrev: TSpeedButton;
    bnViewNext: TSpeedButton;
    uxSimSpeed: TTrackBar;
    uxSimSpeedIcon: TImage;
    lbFrame: TLabel;
    uxFrame: TLabel;
    LabelConnectorTotal: TLabel;
    LabelOpLimit: TLabel;
    FDMemTableFrame: TFDMemTable;
    FDMemTableFrameFRAMEID: TIntegerField;
    FDMemTableFrameEP2FILEID: TIntegerField;
    FDMemTableFrameJOBID: TIntegerField;
    FDMemTableFramePRODUCEDFRAMES: TSmallintField;
    FDMemTableFrameNUMBEROFFRAMES: TSmallintField;
    FDMemTableFrameSTATUSID: TSmallintField;
    FDMemTableFrameSITEID: TSmallintField;
    FDMemTableFrameROLLFORMERID: TSmallintField;
    procedure FormCreate(Sender: TObject);
    procedure bnCloseClick(Sender: TObject);
    function  SendPrintCommand(cs: AnsiString; wfr: Boolean): boolean;
    procedure bnPauseClick(Sender: TObject);
    procedure bnResumeClick(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure bnViewPrevClick(Sender: TObject);
    procedure bnViewNextClick(Sender: TObject);
    procedure bnCalibrateClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    FRollFormerID          : String;
    FDashBoardCallbackName : String;
    ProductionQueueQ       : TProductionQueue;
    IJPString              : AnsiString;
    StopRequested          : boolean;
    FProductionRate        : Double;
    FTotalProductionLength : Double;
    FTotalRivets           : Integer;
    FPVersion              : AnsiString;
    FItemStartTime         : TDatetime;

    FSelection    : TFrameSelection;  // for view next / prev
    FDisplayFrame : TSteelFrame;      // generally MainQ.CurrentItem.Frame but NOT during Next/Prev view
    FSelectedItem : pEntityRecType;   // item selected by mouse

    procedure GetFrame;
    procedure Pause(APause: boolean);
    procedure Updateprogressbar(ADelta: double);
    procedure IJPPrint(AItem: TItemBase);
    procedure triggerPrint;
    procedure RedrawFrame;

    procedure OnJobStart(Sender: TObject);
    procedure OnFrameStart(Sender: TObject);
    procedure OnItemStart(Sender: TObject);
    procedure OnToolOp(AProcess: TRFOperation);
    function  OnMoveMotor(ADelta: Double): boolean;
    procedure OnItemFinish(Sender: TObject);
    procedure OnFrameFinish(Sender: TObject);
    procedure OnJobFinish(Sender: TObject);

    procedure DisplayItemDetails(AItem: TItemBase);
    procedure PrintLabel(AItem: TEntityItem);
    function IJPPrintLength(s: string): Double;
    function InitForm: boolean;
    function NextFrame: TSteelFrame;
    function PrevFrame: TSteelFrame;
    procedure SetButtons;
    function MaxPrintLength(AItem: TItemBase): Double;
    procedure SimDelay;
    function GetItemColor(AFrame: TSteelFrame; p: pEntityRecType): TColor;
    function GetRollFormerID : String;
  protected // unused / truss only
    function GetScrewStr(Q: TProductionQueue; AItem: TItemBase): string; //scans Steelmem[] of cutptr^.mndx to returns '<<' + screw count
    procedure SetCurrentRF;
  public
    StopNow: boolean;
    Calibrating : boolean;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BuildQueueFromFrameSelection(aFrameToProduce : TFrameSelection;  AAccept : TProcessFilter);
    function  BuildQFromProcessStrings(aFrameSelection : TFrameSelection; aLines: TStrings; AAccept: TProcessFilter): Boolean;overload;
    function  BuildQFromProcessStrings(AStrings: TStrings; bAddOffcut: boolean=True; ACount: integer=1): Boolean;overload;
    function  BuildQFromProcessStringsSingle(AStrings: TStrings; bAddOffcut: boolean=True; ACount: integer=1): Boolean;
    function  BuildQFromManualLengthStrings(AStrings: tStrings; bAddOffcut: boolean=True; ACount: integer=1): boolean; // Process file / strings
    procedure WMStartQ(var Message: TMessage); message WM_STARTQ;
    procedure WMClose(var Message: TWMClose); message WM_CLOSE;
    procedure UpdateProductionDisplay(len: Double; StartTime : TDateTime);
    procedure UpdateCardInfoPanel;
    property  RollFormerID  : String read GetRollFormerID;
  end;

var
  FormScotTruss: TFormScotTruss;

implementation

{$R *.DFM}

uses
  Pause, ItemTypeSelectionU, UpdateFormU, VersionU, coil, rollformerU, Calibrate,
  PauseRequest,   LoadSteelU,
  Logging, IJPOtherU, IJPSojetU, UnitDMRollFormer,
  UnitDMDesignJob, DateUtils, Com_Exception, DataSnap.DSSession,
  UnitDMRFDateInfo, UnitDMLoadEP2Files, UnitDMItemProduction, items, Data.FireDACJSONReflect,
  UnitRemoteDBClass;

constructor TFormScotTruss.Create(AOwner: TComponent);
begin
  inherited;
  bnResume.Left := bnPause.Left;
  ProductionQueueQ := TProductionQueue.Create;
  ProductionQueueQ.OnMove        := OnMoveMotor;
  ProductionQueueQ.OnToolOp      := OnToolOp;
  ProductionQueueQ.OnItemStart   := OnItemStart;
  ProductionQueueQ.OnItemFinish  := OnItemFinish;
  ProductionQueueQ.OnFrameStart  := OnFrameStart;
  ProductionQueueQ.OnFrameFinish := OnFrameFinish;
  ProductionQueueQ.OnJobStart    := OnJobStart;
  ProductionQueueQ.OnJobFinish   := OnJobFinish;
  LabelOpLimit.Visible := (DriveClass<>tdcSim) and G_Settings.general_warning and RollFormer.CounterExceeded;
end;

destructor TFormScotTruss.Destroy;
begin
  ProductionQueueQ.Free;
  inherited;
end;

procedure TFormScotTruss.GetFrame;
begin
  DMScotServer.GetFrame(1, 0, Now,FDMemTableFrame);
end;

function TFormScotTruss.OnMoveMotor(ADelta: Double): boolean;
begin
  SetCurrentRF; // select machine based on MainQ.currentItem
  LabelMotorMovingDistance.Caption :=Format('%s Move %.1f',[IfThen(RollFormer.BoxWeb, 'BOX', '') , ADelta]);

  if DriveClass<>tdcSim then
    EventAudit(rfetMoveMotor,Format('%s Move %.1f',[IfThen(RollFormer.BoxWeb, 'BOX', '') , ADelta]));
  Animate1.play(1, 10, 0);
  try
    Result := Rollformer.MoveMotor(ADelta);
    if Result then
    begin
      if G_Settings.Logging_LogToolOps then
        RecordToolOp(Format('Move,Delta=%0.2f',[ADelta]));
      if (DriveClass = tdcSim) or (DriveClass=tdcVirtual) then
        SimDelay;
      if G_Settings.misc_power then { update Power Meter if active }
      begin
        Gauge2.Progress := trunc(Rollformer.PowerPercent);
        Gauge2.ForeColor := ifthen(Rollformer.PowerPercent>=80,clFuchsia,clNavy);
      end;
    end;
  finally
    LabelMotorMovingDistance.Caption := LabelMotorMovingDistance.caption + '.';
    Animate1.stop;
  end;
  Updateprogressbar(ADelta);
end;

procedure TFormScotTruss.OnToolOp(AProcess: TRFOperation);
begin
  setCurrentRF;
  LabelMotorMovingDistance.caption := ifThen(rollformer.BoxWeb, 'BOX ', '') + ProcessName(AProcess.Process);
  if oppause then
    showmessage('Op pause - ' + LabelMotorMovingDistance.caption);
  with Rollformer do
    case AProcess.Process of
{$IFDEF PANEL}
      opCopsFlats       : Flat;
      opNotches         : Notch;
      opLipHole         : LPunch;
      opFlangeHole      : FPunch;
      opService1s       : Service1;
      opService2s       : Service2;
      opSwage           : Swage;
      opEndBearingNotch : EndBearingNotch;
{$ELSE}
      opCopsFlats       : Cope;
      opNotches         : Notch;
      opLipHole         : LPunch;
      opFlangeHole      : FPunch;
      opSwage           : Swage;
{$ENDIF}
      opCut             : Cutter;
      opPrint           : triggerPrint;
    end;
  LabelMotorMovingDistance.caption := LabelMotorMovingDistance.caption + '.'; // add completed '.' to label
  if DriveClass<>tdcSim then
    EventAudit(rfetToolOp, 'Op=' + ProcessName(AProcess.Process));
end;

procedure TFormScotTruss.OnJobStart(Sender: TObject);
var
  aJSONObject : TJSONObject;
begin
  GetFrame;
  SetButtons;
  FTotalRivets := 0;
  LabelConnectorTotal.Visible := False;
  if DriveClass<>tdcSim then
    EventAudit(rfetJobStart,Format('%s',['JobStart']));
  aJSONObject := TJSONObject.Create;
  aJSONObject.AddPair(TJSONPair.Create('EventID', IntToStr(Ord(rfetJobStart))));
  aJSONObject.AddPair(TJSONPair.Create('RollformerID',   RollFormerID));
  aJSONObject.AddPair(TJSONPair.Create('JobID',          DMDesignJob.FDMemTableEP2FILE.FieldByName('JOBID').AsString));
  DMDesignJob.FDMemTableJOB.FindKey([1,DMDesignJob.FDMemTableEP2FILE.FieldByName('JOBID').AsInteger]);
  aJSONObject.AddPair(TJSONPair.Create('JobName',        DMDesignJob.FDMemTableJOB.FieldByName('Design').AsString));
  aJSONObject.AddPair(TJSONPair.Create('EP2FILEID',      DMDesignJob.FDMemTableEP2FILE.FieldByName('EP2FILEID').AsString));
  aJSONObject.AddPair(TJSONPair.Create('EP2FILE',        DMDesignJob.FDMemTableEP2FILE.FieldByName('EP2FILE').AsString));
  aJSONObject.AddPair(TJSONPair.Create('FRAMEID',        DMDesignJob.FDMemTableFrame.FieldByName('FRAMEID').AsString));
  aJSONObject.AddPair(TJSONPair.Create('FrameName',      DMDesignJob.FDMemTableFrame.FieldByName('FrameName').AsString));
  aJSONObject.AddPair(TJSONPair.Create('ItemName',       'JobStart'));
  aJSONObject.AddPair(TJSONPair.Create('DayMeters',      lbMetresToday.caption));
  if G_Settings.general_IsConnectToServer then
  begin
    TRemoteDB(DMScotServer).DMRemoteDB.ServerClient.BroadcastToChannel(DashboardChannelName, aJSONObject);
    TRemoteDB(DMScotServer).DMRemoteDB.ServerClient.BroadcastToChannel(JobLiveChannelName, aJSONObject);
  end;
end;

procedure TFormScotTruss.OnFrameStart(Sender: TObject);
var
  Item: TItemBase;
begin
  FTotalRivets := FTotalRivets + ProductionQueueQ.CurrentItem.Frame.FConnectionCount;
  Item := ProductionQueueQ.CurrentItem;
  Assert(Assigned(Item));
  if DriveClass<>tdcSim then
    EventAudit(rfetFrameStart, Format('Frame=%s',[Item.TrussName]));
  if (item.Frame<>nil) then
    uxFrame.Caption := format('%d of %d',[ProductionQueueQ.FrameN, ProductionQueueQ.FrameCount]);
  FDisplayFrame := ProductionQueueQ.CurrentItem.Frame;
  RedrawFrame;
end;

procedure TFormScotTruss.OnItemStart(Sender: TObject);
var
  Item: TItemBase;
  aJSONObject : TJSONObject;
begin
  FItemStartTime := Now;
  FSelectedItem:=Nil;
  FDisplayFrame := ProductionQueueQ.CurrentItem.Frame;
  Item := ProductionQueueQ.CurrentItem;
  Assert(Assigned(Item));
  if not (DriveClass = tdcSim) and (Item.JOBID>0) then
  begin
    IJPPrint(Item);
  end;
  if DriveClass<>tdcSim then
    EventAudit(rfetItemStart, Format('Frame=%s, Item=%s, ItemNumber=%d',[Item.TrussName, Item.ItemName, Item.SerialNumber]), 0);
  if Item.Frame=nil then
    uxFrame.Caption := Item.TrussName; // pseudo frame name for offcut and process items
  aJSONObject := TJSONObject.Create;
  aJSONObject.AddPair(TJSONPair.Create('EventID', IntToStr(Ord(rfetItemStart))));
  aJSONObject.AddPair(TJSONPair.Create('RollformerID', RollFormerID));
  aJSONObject.AddPair(TJSONPair.Create('JobID',          DMDesignJob.FDMemTableEP2FILE.FieldByName('JOBID').AsString));
  DMDesignJob.FDMemTableJOB.FindKey([1,DMDesignJob.FDMemTableEP2FILE.FieldByName('JOBID').AsInteger]);
  aJSONObject.AddPair(TJSONPair.Create('JobName',      DMDesignJob.FDMemTableJOB.FieldByName('Design').AsString));
  aJSONObject.AddPair(TJSONPair.Create('EP2FILEID',    DMDesignJob.FDMemTableEP2FILE.FieldByName('EP2FILEID').AsString));
  aJSONObject.AddPair(TJSONPair.Create('EP2FILE',      DMDesignJob.FDMemTableEP2FILE.FieldByName('EP2FILE').AsString));
  aJSONObject.AddPair(TJSONPair.Create('FRAMEID',      DMDesignJob.FDMemTableFrame.FieldByName('FRAMEID').AsString));
  aJSONObject.AddPair(TJSONPair.Create('FrameName',    Item.TrussName));
  aJSONObject.AddPair(TJSONPair.Create('ItemName',     Format('%s %2d %s %5s', [Item.TrussName, Item.SerialNumber, AnsiLeftStr(Item.ItemName,2), UnitsOut(IntToStr(Round(Item.ItemLength)))])));
  aJSONObject.AddPair(TJSONPair.Create('DayMeters',    lbMetresToday.caption));
  if G_Settings.general_IsConnectToServer then
  begin
    TRemoteDB(DMScotServer).DMRemoteDB.ServerClient.BroadcastToChannel(DashboardChannelName, aJSONObject);
    TRemoteDB(DMScotServer).DMRemoteDB.ServerClient.BroadcastToChannel(JobLiveChannelName, aJSONObject);
  end;
  DisplayItemDetails(Item);
  Updateprogressbar(0);
  RedrawFrame;
  if G_Settings.trussrf_autopc and (Item is TEntityItem) and not (DriveClass = tdcSim) then
  begin
    RollFormer.SetPrecamber(Item as TEntityItem);
  end;
end;

procedure TFormScotTruss.OnItemFinish(Sender: TObject);
var
  Item: TItemBase;
  aFDJSONDataSets : TFDJSONDataSets;
  aFDJSONDeltas   : TFDJSONDeltas;
begin
  Item := ProductionQueueQ.CurrentItem;
  if not (DriveClass = tdcSim) then
  begin
    CardAdapter.DeductMM(Item.MaterialLength);
    UpdateCardInfoPanel;
    EventAudit(rfetItemFinish, Format('Frame=%s, Item=%s, Length=%f',[Item.TrussName, Item.ItemName, Item.MaterialLength]), (Item.MaterialLength)/1000);
    if(Item.JOBID>0) then
    begin
      DMItemProduction.AddData(Item);
      IF Item.isLast THEN
      BEGIN
        try
          if FDMemTableFrame.FindKey([1, DMDesignJob.FDMemTableEP2FILE.FieldByName('EP2FILEID').AsInteger, Item.FrameID]) then
          begin
            FDMemTableFrame.Edit;
            FDMemTableFrame.FieldByName('PRODUCEDFRAMES').AsInteger := FDMemTableFrame.FieldByName('PRODUCEDFRAMES').AsInteger + 1;
//            DMDesignJob.ApplyUpdates(aFRAME, FDMemTableFrame);
//            GetFrame;
          end;
        except
          on E: Exception do
            HandleException(e,'TFormScotTruss.OnItemFinish',[]);
        end;
      END;

    end;
  end;
  UpdateProductionDisplay(Item.MaterialLength, FItemStartTime);
end;

procedure TFormScotTruss.OnFrameFinish(Sender: TObject);
var
  Item: TItemBase;
begin
  Item := ProductionQueueQ.CurrentItem;
  Assert(Assigned(Item));
  CardAdapter.DeductMM(0,true);
  if DriveClass<>tdcSim then
  begin
    UpdateCardInfoPanel;
    EventAudit(rfetFrameFinish,Format('Frame%s, Item Material Length %f ',[Item.TrussName, Item.MaterialLength]));
    DMDesignJob.ApplyUpdates(aFRAME, FDMemTableFrame);
    GetFrame;
  end;
  RedrawFrame;
  LabelOpLimit.Visible := (DriveClass<>tdcSim) and G_Settings.general_warning and RollFormer.CounterExceeded;
  if G_Settings.general_label and (Item is TEntityItem) then
    PrintLabel(Item as TEntityItem);
  if G_Settings.general_pause and (Item.Frame <>nil) then
    Pause(true);
end;

procedure TFormScotTruss.OnJobFinish(Sender: TObject);
var
  aJSONObject : TJSONObject;
begin
  LabelConnectorTotal.Visible := True;
  SetButtons;
  if DriveClass<>tdcSim then
    EventAudit(rfetJobFinish, Format('%s',['JobFinish']));
  if bframes then
    LabelConnectorTotal.caption := 'Rivets (approx) ' + inttostr(FTotalRivets*2)
  else
    LabelConnectorTotal.caption := 'Bolts ' + inttostr(ProductionQueueQ.ConnectorTotal);
  aJSONObject := TJSONObject.Create;
  aJSONObject.AddPair(TJSONPair.Create('EventID', IntToStr(Ord(rfetJobFinish))));
  aJSONObject.AddPair(TJSONPair.Create('RollformerID', RollFormerID));
  aJSONObject.AddPair(TJSONPair.Create('JobID',          DMDesignJob.FDMemTableEP2FILE.FieldByName('JOBID').AsString));
  DMDesignJob.FDMemTableJOB.FindKey([1,DMDesignJob.FDMemTableEP2FILE.FieldByName('JOBID').AsInteger]);
  aJSONObject.AddPair(TJSONPair.Create('JobName',      DMDesignJob.FDMemTableJOB.FieldByName('Design').AsString));
  aJSONObject.AddPair(TJSONPair.Create('EP2FILEID',    DMDesignJob.FDMemTableEP2FILE.FieldByName('EP2FILEID').AsString));
  aJSONObject.AddPair(TJSONPair.Create('EP2FILE',      DMDesignJob.FDMemTableEP2FILE.FieldByName('EP2FILE').AsString));
  aJSONObject.AddPair(TJSONPair.Create('FRAMEID',      DMDesignJob.FDMemTableFrame.FieldByName('FRAMEID').AsString));
  aJSONObject.AddPair(TJSONPair.Create('FrameName',    DMDesignJob.FDMemTableFrame.FieldByName('FrameName').AsString));
  aJSONObject.AddPair(TJSONPair.Create('ItemName',     'JobFinish'));
  aJSONObject.AddPair(TJSONPair.Create('DayMeters',    lbMetresToday.caption));
  if G_Settings.general_IsConnectToServer then
  begin
    TRemoteDB(DMScotServer).DMRemoteDB.ServerClient.BroadcastToChannel(DashboardChannelName, aJSONObject);
    TRemoteDB(DMScotServer).DMRemoteDB.ServerClient.BroadcastToChannel(JobLiveChannelName, aJSONObject);
  end;
end;

procedure TFormScotTruss.UpdateProductionDisplay(len: Double; StartTime : TDatetime);
var
  cf: Double;
  Delta: Integer;
  aTimeDifference : Double;
begin
  if G_Settings.general_metric then
    cf := 1
  else
    cf := 3.28084;
  FTotalProductionLength := FTotalProductionLength + (Len/1000);
  lbProduction.caption := FloatToStr(SimpleRoundTo(FTotalProductionLength * cf,-1));
  Delta := millisecondsbetween(Now,StartTime);
  if Delta > 0 then
  begin
    aTimeDifference := (Delta/3600000);
    FProductionRate := (Len/1000)/aTimeDifference;
    lbProductionRate.caption := format('%5.1f',[FProductionRate * cf]);
  end;
  IF (DriveClass = tdcSim) then
    Exit;
  if G_Settings.general_imperial then
    lbMetresToday.caption := FloatToStr(SimpleRoundTo((DMRFDateInfo.DayTotalMeters) * fratio, 0)) +' Ft'
  else
    lbMetresToday.caption := FloatToStr(SimpleRoundTo(DMRFDateInfo.DayTotalMeters, 0)) +' M';
end;

function TFormScotTruss.IJPPrintLength(s: string): Double;
var
  w, w0: integer; // pixel width
begin
  with InkjetStatus1.uxStatus1.canvas do
  begin
    w0 := TextWidth('0');
    w := TextWidth(s);
  end;
  result := w / w0 * 16;
end;

function TFormScotTruss.MaxPrintLength(AItem: TItemBase): Double;
const
  Gap = 40; // safety gap
var
  PrintPosition: Double;
begin
  PrintPosition := strtofloat(  formsettings.headpos.text);
  result := AItem.ItemLength - PrintPosition - Gap;
end;

procedure TFormScotTruss.IJPPrint(AItem: TItemBase);
var PrintSpaceRemaining: Double;
  Maxsize: Double;
begin
  if InkJetMaster.IJPEnabled then
  begin;
    Maxsize := MaxPrintLength(AItem);
    IJPString := AItem.IJPPrintLine( function(AString: string): boolean begin result := IJPPrintLength(AString)< Maxsize; end);
    if IJPString <> '' then
    begin
      // Send  the print string
      //   Mathews Printer: sent to printer with delay
      //   Sojet: queued in printer, & wait for trigger
      PrintSpaceRemaining := Maxsize - IJPPrintLength(IJPString);
      InkJetMaster.StartPrint(IJPString, PrintSpaceRemaining);
      RecordToolOp(format('InkPrint,text=%s',[ansiquotedstr(IJPString, '''')]));
    end;
  end;
end;

procedure TFormScotTruss.triggerPrint;
begin
  // trigger print at the print position: no-op except for Sojet
  if (IJPString <> '') then
    InkJetMaster.triggerPrint;
end;

function TFormScotTruss.SendPrintCommand(cs: AnsiString; wfr: Boolean): boolean;
begin
  // called from settings form (NOT for sojet)
  result := false;
  InkJetMaster.SendPrintCommand(cs, wfr); // ignored for sojet
end;

procedure TFormScotTruss.PrintLabel(AItem: TEntityItem);
// Prints frame label on label printer
var y: integer;
begin
  assert(G_Settings.general_label);
  printer.orientation := PoLandscape;
  printer.canvas.Font.color := clBlack;
  printer.canvas.Font.size := strtoint(G_Settings.label_font);
  printer.BeginDoc;
  try
    // printer.NewPage;
    printer.canvas.Font.style := [fsBold];
    printer.canvas.TextOut(1, 1, G_Settings.label_job);
    // move down line x 1.5
    y := trunc(1.5 * printer.canvas.TextHeight(G_Settings.label_job));
    printer.canvas.TextOut(1, y, AItem.TrussName);
  finally
    printer.EndDoc;
  end;
end;

procedure TFormScotTruss.RedrawFrame;
begin
  PaintBox1.Invalidate;
end;

procedure TFormScotTruss.DisplayItemDetails(AItem: TItemBase);
var
 anItemDispalyString : string;
begin
  anItemDispalyString := Format('%s %2d %s %5s', [AItem.TrussName, AItem.SerialNumber, AnsiLeftStr(AItem.ItemName,2), UnitsOut(IntToStr(Round(AItem.ItemLength)))]);
{$IFDEF TRUSS}
  anItemDispalyString := anItemDispalyString + GetScrewStr(nil, AItem);
{$ENDIF}
  if AItem.Frame <> nil then
    Billboard.DisplayItem(anItemDispalyString);
end;

// FRAMES
procedure TFormScotTruss.BuildQueueFromFrameSelection(aFrameToProduce : TFrameSelection;
                                                              AAccept : TProcessFilter);
begin
  ProductionQueueQ.Clear;
  ProductionQueueQ.TriggerRequired := InkJetMaster.IJPTriggerRequired;
  ProductionQueueQ.AddOffcut;
  ProductionQueueQ.AddSelectionToQueue(aFrameToProduce, AAccept);
  FSelection := aFrameToProduce; // for view next / prev
end;

Function TFormScotTruss.BuildQFromProcessStrings(aFrameSelection : TFrameSelection; aLines: TStrings; AAccept: TProcessFilter): Boolean;
begin
  ProductionQueueQ.Clear;
  ProductionQueueQ.TriggerRequired := False;
  ProductionQueueQ.AddOffcut;
  DMLoadEP2Files.ProcessFile(TStringList(aLines), aFrameSelection);
  ProductionQueueQ.AddSelectionToQueue(AFrameSelection, AAccept);
  FSelection := aFrameSelection; // for view next / prev
end;

Function TFormScotTruss.BuildQFromProcessStrings(AStrings: TStrings;  bAddOffcut: boolean; ACount: integer): boolean;
begin
  Caption := appname;
  FSelection :=nil;
  ProductionQueueQ.Clear;
  ProductionQueueQ.TriggerRequired := False;
  if bAddOffcut then
    ProductionQueueQ.AddOffcut;
  result := ProductionQueueQ.ParseProcessStrings(AStrings, ACount);
end;

Function TFormScotTruss.BuildQFromProcessStringsSingle(AStrings: tStrings;  bAddOffcut: boolean; ACount: integer): boolean;
begin
  Caption := appname;
  FSelection :=nil;
  ProductionQueueQ.Clear;
  ProductionQueueQ.TriggerRequired := False;
  if bAddOffcut then
    ProductionQueueQ.AddOffcut;
  result := ProductionQueueQ.ParseProcessStrings(AStrings, ACount);
end;

Function TFormScotTruss.BuildQFromManualLengthStrings(AStrings: tStrings; bAddOffcut: boolean=True; ACount: integer=1): boolean; // Process file / strings
begin
  Caption := appname;
  FSelection :=nil;
  ProductionQueueQ.Clear;
  ProductionQueueQ.TriggerRequired := False;
  if bAddOffcut then
    ProductionQueueQ.AddOffcut;
  result := ProductionQueueQ.ParseProcessStrings(AStrings, ACount);
end;


procedure TFormScotTruss.UpdateCardInfoPanel;
begin
  if (DriveClass = tdcSim) then
    Exit;
  GREMAINMETERS  := CardAdapter.Metres;
  if G_Settings.general_imperial then
    lbCardRemaining.caption := IntToStr(trunc(GREMAINMETERS * fratio)) +' Ft'
  else
    lbCardRemaining.caption := IntToStr(Round(GREMAINMETERS)) + ' M';
  if ProductionQueueQ.Running and
     not ProductionQueueQ.AsyncPause and
     not CardAdapter.hasCredit then
  begin
    Pause(True);
    Showmessage('SCS STEEL CARD ' + CardAdapter.NoCreditMessage);
  end;
end;

function TFormScotTruss.GetScrewStr(Q: TProductionQueue; AItem: TItemBase): string;
begin
  if (AItem is TEntityItem) and (TEntityItem(AItem).ScrewCount > 0) then
    result := format(' << %d', [TEntityItem(AItem).ScrewCount div 2])
  else
    result := '';
end;

procedure TFormScotTruss.SetCurrentRF;
begin
{$IFDEF PANEL}
  Rollformer.BoxWeb := False;
{$ELSE}
  Rollformer.BoxWeb := ProductionQueueQ.CurrentItem.isBoxWeb and G_Settings.general_BoxRF;
{$ENDIF}
end;

procedure TFormScotTruss.SimDelay;
// *Delay function - waits approx d/100 secs
var N: integer;
begin
  N := uxSimspeed.Max - uxSimspeed.position;
  if N>0 then
  begin
    Application.ProcessMessages;
    Sleep(N div 10);
  end;
end;

procedure TFormScotTruss.SetButtons;
var
  bStopped: boolean;
begin
  bnPause.visible     := not ProductionQueueQ.AsyncPause;
  bnResume.visible    := ProductionQueueQ.AsyncPause;
  bnPause.enabled     := ProductionQueueQ.Running;
  bnResume.enabled    := ProductionQueueQ.Running;
  bStopped            := ProductionQueueQ.AsyncPause or not ProductionQueueQ.Running;
  bnViewPrev.enabled  := bStopped and (PrevFrame <>nil);
  bnViewNext.enabled  := bStopped and (NextFrame <>nil);
  bnCalibrate.enabled := bStopped;
end;

procedure TFormScotTruss.Pause(APause: boolean);
var
  aJSONObject : TJSONObject;
begin
  aJSONObject := TJSONObject.Create;
  aJSONObject.AddPair(TJSONPair.Create('EventID', IntToStr(Ord(rfetPause))));
  aJSONObject.AddPair(TJSONPair.Create('RollformerID', RollformerID));
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
  ProductionQueueQ.AsyncPause := APause;
  Animate1.stop;
  SetButtons;
  if APause and not StopRequested then // if not already paused
    FRFDateInfo.StartPause := now;
end;

procedure TFormScotTruss.bnResumeClick(Sender: TObject);
var
  PauseReason: string;
  bRun: boolean;
begin
  FSelectedItem:=nil;
  Pause(false); // unpause
  FDisplayFrame := ProductionQueueQ.CurrentItem.Frame;
  Invalidate;
  { request & log pause reason }
  bRun := bnResume.caption='Run';
  if G_Settings.Logging_LogPauseReason and not bRun then
  begin
    PauseReason := GetPauseReason;
    EventAudit(rfetPause, Format('Duration=%d,Reason=%s', [SecondsBetween(Now, StartPause), PauseReason]));
  end
  else
  begin
    PauseReason := '';
    EventAudit(rfetPause, Format('Duration=%d', [SecondsBetween(Now, StartPause)]));
  end;
  updateCardInfoPanel;
end;

procedure TFormScotTruss.bnViewNextClick(Sender: TObject);
begin
  FDisplayFrame := NextFrame;
  SetButtons;
  Invalidate;
end;

procedure TFormScotTruss.bnViewPrevClick(Sender: TObject);
begin
  FDisplayFrame := PrevFrame;
  SetButtons;
  Invalidate;
end;

function TFormScotTruss.NextFrame: TSteelFrame;
var i: integer;
begin
  result := nil;
  if assigned(FSelection) and (FSelection.SelectedFrames.Count > 0) then
  begin
    i := succ(FSelection.SelectedFrames.indexof(FDisplayFrame));
    if i < FSelection.SelectedFrames.Count then
      exit(TSteelFrame(FSelection.SelectedFrames[i]));
  end;
end;

function TFormScotTruss.PrevFrame: TSteelFrame;
var
  I: integer;
begin
  Result := nil;
  if Assigned(FSelection) and (FSelection.SelectedFrames.Count > 0) then
  begin
    I := Pred(FSelection.SelectedFrames.indexof(FDisplayFrame));
    if I >= 0 then
      exit(TSteelFrame(FSelection.SelectedFrames[i]));
  end;
end;

procedure TFormScotTruss.bnCalibrateClick(Sender: TObject);
begin
  if (DriveClass = tdcSim) then
    NotInSimMessage
  else
    TCalibrateForm.Exec( not ProductionQueueQ.Running );
end;

procedure TFormScotTruss.bnPauseClick(Sender: TObject);
begin { pause button }
  bnResume.caption:='Resume';
  Pause(true);
end;

procedure TFormScotTruss.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caHide;
end;

procedure TFormScotTruss.FormCreate(Sender: TObject);
var
  p1, p2: word;
begin
  Caption := AppName;
  { Read mex or mnt file version from RF }
  { Remove txt fater . if any, for 3 phase or single phase indication }
  FPVersion := GetFileVersion();
  p1 := pos('.', FPVersion);
  p2 := pos('.', copy(FPVersion, p1 + 1, 255));
  FPVersion := copy(FPVersion, 1, p1 + p2 - 1);
  FTotalProductionLength := 0;
  FTotalRivets := 0;
  { initial vars }
  ReceivedStrings := '';
  StopRequested := False;
  StopNow := False;
  LabelMotorMovingDistance.Caption := '';
  LabelConnectorTotal.Caption := '';
  LabelRFDriver.color := clBtnFace;
  LabelRFDriver.Font.color := clred;
  LabelRFDriver.caption := 'Machine Mode';
  uxPrecamber.caption := '';
  RollFormer.pcfactive := false;
  Calibrating := False;
  if bframes and fileexists(extractfilepath(paramstr(0)) + 'NuFrameRF.bmp') then
  begin
    ImageLogoTitle.Picture.LoadFromFile(extractfilepath(paramstr(0)) + 'NuFrameRF.bmp');
  end;
  try
    Animate1.filename := 'CogAnimation.avi';
  except
    on E: Exception do
      HandleException(e,'TFormScotTruss.FormCreate',[]);
  end;
  InkJetMaster.StatusFrame2 := InkjetStatus1;
end;

procedure TFormScotTruss.FormResize(Sender: TObject);
begin
  bnPause.Left :=(bnViewPrev.Left - 90) div 2;
  bnResume.Left := bnPause.Left;
  uxSimSpeed.Left := bnResume.Left+bnResume.Width + 20;
  uxSimSpeedIcon.Left := uxSimSpeed.Left + 28;
end;

procedure TFormScotTruss.FormShow(Sender: TObject);
begin
  uxSimSpeed.visible     := (DriveClass = tdcSim) or (DriveClass = tdcVirtual);
  uxSimSpeedIcon.visible := (DriveClass = tdcSim) or (DriveClass = tdcVirtual);
  If NOT assigned(DMItemProduction) then
    DMItemProduction := TDMItemProduction.Create(Self);
end;

procedure TFormScotTruss.WMStartQ(var Message: TMessage);
begin
  try
    FDisplayFrame :=nil;
    StopNow := False;
    StopRequested := False;
    FTotalProductionLength := 0;
    FTotalRivets := 0;
    FProductionRate := 0;
    if Message.wParam=0 then
    begin
      Pause(True);
      bnResume.caption:='Run';
    end
    else
      Pause(False);
    if ProductionQueueQ.Running then
    begin
      MessageDlg('already running', mterror,[mbOK], 0);
      exit;
    end;
    if (ProductionQueueQ.Empty) then
    begin
      MessageBeep(0);
      ShowMessage('Queue is empty');
      exit;
    end;
    if (DriveClass = tdcMint) then
      try
        RollFormer.ReadMachineCounters;
      except
        on e: exception do
          HandleException(e,'RollFormer.ReadMachineCounters',[]);
      end;
    if not InitForm then
      exit;
    InkJetMaster.InitSojetPrinter;
  except
    on e: exception do
    begin
      close;
      exit;
    end;
  end;
  try
    try
      ProductionQueueQ.Run;
      SetButtons; // update buttons to finished state
    except
      on e: ENoSteel do
      begin
        MessageDlg(e.message, mtwarning, [mbOK], 0);
        setCurrentRF;
        TDlgLoad.Exec(rollformer.BoxWeb);
        close;
      end;
    end;
  finally
    updateCardInfoPanel;
  end;
end;

function TFormScotTruss.InitForm: boolean;
begin
  Billboard.Clear;
  Billboard.SetFontSize(strtoint(G_Settings.general_fontsize));
  uxFrame.Caption :='';
  if not (DriveClass = tdcSim) then
  begin
    if not rollformer.ConnectToDrive then
      exit(false);
    if CardAdapter.CheckCardOK then
    begin
      lbCardID.caption := CardAdapter.IssuedTO;
      if G_Settings.general_metric then
        lbCardRemaining.caption := inttostr(CardAdapter.Metres)
      else
        lbCardRemaining.caption := inttostr(trunc(CardAdapter.Metres * fratio));
    end
    else
    begin
      lbCardRemaining.caption := 'CARDERROR';
      exit(false);
    end;
  end;
  LabelRFDriver.Color := clBtnFace;
  LabelRFDriver.Font.color := clred;
  LabelRFDriver.Caption := G_Settings.general_drive;
  Gauge1.color := clred;
  if not G_Settings.misc_power then
    Gauge2.visible := false;
  result := true;
end;

procedure TFormScotTruss.bnCloseClick(Sender: TObject);
begin
  postMessage(handle, WM_CLOSE, 0, 0); // same as [x] on caption
end;

procedure TFormScotTruss.WMClose(var Message: TWMClose);
begin
  if ProductionQueueQ.Running then
  begin
    if MessageDlg('Cancel Job?', mtConfirmation, mbYesNo, 0) = mrYes then
    begin
      ProductionQueueQ.AsyncAbort := true;
      modalResult := mrCancel;
    end;
  end
  else
    close;
end;

function TFormScotTruss.GetItemColor(AFrame: TSteelFrame; p: pEntityRecType): TColor;
begin
  if p = FSelectedItem then
    exit(clRed);
  if (FDisplayFrame <> ProductionQueueQ.CurrentItem.Frame) then
     exit(clWebDodgerBlue); // preview
  if TypeSelectform.SelectByItems and not TypeSelectform.isItemTypeSelected(AFrame, p)  then
    exit(clsilver);
  exit( ProductionQueueQ.GetItemColor(AFrame, p));
end;

function TFormScotTruss.GetRollFormerID : String;
begin
  result:=IntToStr(FRFDateInfo.ROLLFORMERID);
end;

procedure TFormScotTruss.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin
  if ProductionQueueQ.AsyncPause or not ProductionQueueQ.Running then
  begin
    R := Rect(0, 0, PaintBox1.ClientWidth, PaintBox1.ClientHeight);
    InflateRect(R,-12,-12);
    FSelectedItem := TFrameDraw.ItemAtPoint(point(x,y), FDisplayFrame, PaintBox1.canvas, R);
    Paintbox1.invalidate;
  end;
end;

procedure TFormScotTruss.PaintBox1Paint(Sender: TObject);
var
  R: TRect;
begin
  R := Rect(0, 0, PaintBox1.ClientWidth, PaintBox1.ClientHeight);
  PaintBox1.canvas.Brush.color := clWebGhostWhite;
  PaintBox1.canvas.Brush.style := bsSolid;
  PaintBox1.canvas.FillRect(R);
  InflateRect(R,-12,-12);
  if assigned(ProductionQueueQ) and assigned(FDisplayFrame) then
  begin
    if FSelectedItem <> nil then
      TFrameDraw.DrawStructure2(FDisplayFrame, FSelectedItem, true, PaintBox1.canvas, R, Self.GetItemColor)
    else if ProductionQueueQ.Running then
      TFrameDraw.DrawStructure2(FDisplayFrame, ProductionQueueQ.CurrentEntity, false, PaintBox1.canvas, R, Self.GetItemColor)
    else
      TFrameDraw.DrawStructure2(FDisplayFrame, nil, false, PaintBox1.canvas, R, Self.GetItemColor);
  end
  else
    TFrameDraw.FillRect(PaintBox1.canvas, R);
end;

procedure TFormScotTruss.Updateprogressbar(ADelta: double);
var APercent: integer;
  L: Double;
begin
  APercent := 0;
  if ProductionQueueQ.CurrentItem <>nil then
  begin
    L := ProductionQueueQ.CurrentItem.ItemLength;
    if L > 0 then
      APercent := ceil((ProductionQueueQ.ItemPosition+ADelta) / L * 100)
  end;
  Gauge1.Progress := APercent;
end;

END.
