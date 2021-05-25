unit UnitChildJobStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitChildWin, Data.DB, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.DBCtrls,
  UnitDMDesignJob, FrameDrawU, FrameDataU, GlobalU, Vcl.ToolWin, Vcl.ComCtrls,
  System.Actions, Vcl.ActnList, Vcl.Menus, JvComponentBase, JvAppStorage,
  JvAppRegistryStorage, JvAppIniStorage, JvFormPlacement, DBXJSON, JSON, System.Generics.Collections,
  System.ImageList, Vcl.ImgList;

type

  TJobLiveCallback = class(TDBXCallback)
  public
    function Execute(const Arg: TJSONValue): TJSONValue; override;
  end;


  TMDIChildJobStatus = class(TMDIChild)
    Splitter2: TSplitter;
    PanelJob: TPanel;
    GroupBoxSelectedJobDetails: TGroupBox;
    DBTextAddedOn: TDBText;
    DBTextDesign: TDBText;
    DBTextFrameCopies: TDBText;
    DBTextJobID: TDBText;
    DBTextSteel: TDBText;
    Label1: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    GroupBoxJobList: TGroupBox;
    JvDBGridDesignJob: TJvDBGrid;
    PanelFrames: TPanel;
    Splitter1: TSplitter;
    Splitter3: TSplitter;
    GroupBoxSelectedFrames: TGroupBox;
    JvDBGridFrame: TJvDBGrid;
    GroupBoxSelectedFrameItemsForProduction: TGroupBox;
    JvDBGridFrameEntity: TJvDBGrid;
    GroupBoxProduced: TGroupBox;
    JvDBGridProducedFrameItems: TJvDBGrid;
    GroupBoxEP2Files: TGroupBox;
    JvDBGridEP2Files: TJvDBGrid;
    Splitter4: TSplitter;
    GroupBoxSelectedFramePicture: TGroupBox;
    PaintBoxFrame: TPaintBox;
    Splitter6: TSplitter;
    GroupBoxJobDetails: TGroupBox;
    DBTextOPERATOR: TDBText;
    DBTextREVETERS: TDBText;
    DBTextJobDetailADDON: TDBText;
    DBTextWEIGHT: TDBText;
    DBTextJobDetailSteel: TDBText;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    DBTextCOILID: TDBText;
    Splitter5: TSplitter;
    ToolBarJobStatus: TToolBar;
    ComboBoxRFSelection: TComboBox;
    ToolButtonApplyFilter: TToolButton;
    PopupMenuJobTransfer: TPopupMenu;
    MenuItemTransferJob: TMenuItem;
    MenuItemTRemoveJob: TMenuItem;
    PanelEntityGridTitle: TPanel;
    DBTextFrameLength: TDBText;
    DBTextFrameName: TDBText;
    Label4: TLabel;
    PopupMenuEP2Transfer: TPopupMenu;
    MenuItemTransferEP2: TMenuItem;
    JvAppRegistryStorage1: TJvAppRegistryStorage;
    JvFormStorage1: TJvFormStorage;
    PanelTransfered: TPanel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText0: TDBText;
    PanelCurrentStatus: TPanel;
    DBTextFrameEP2File: TDBText;
    LabelActiveRF: TLabel;
    ToolBarRollFormer: TToolBar;
    procedure PaintBoxFramePaint(Sender: TObject);
    procedure JvDBGridProducedFrameItemsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure JvDBGridFrameDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormPaint(Sender: TObject);
    procedure JvDBGridDesignJobMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure JvDBGridDesignJobKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure JvDBGridDesignJobDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBoxRFSelectionSelect(Sender: TObject);
    procedure ActionApplyFilterExecute(Sender: TObject);
    procedure ToolButtonApplyFilterClick(Sender: TObject);
    procedure JvDBGridEP2FilesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure MenuItemTransferEP2Click(Sender: TObject);
    procedure MenuItemTRemoveJobClick(Sender: TObject);
    procedure JvDBGridProducedFrameItemsDblClick(Sender: TObject);
  private
    { Private declarations }
    FCurrentFrame  : TSteelFrame;
    FCurrentRFID   : Integer;
    FCurrentJobsID : String;
    procedure AfterScroll(aDataset : TDataset);
    procedure ProductItemAfterScroll(aDataset : TDataset);
    procedure FDMemTableEP2FILEAfterScroll(DataSet: TDataSet);
    procedure QueueLogMsg(const Arg: TJSONValue);
    procedure LogMsg(const aRFID, aJobID, aJobName, aEP2FILEID, aEP2FILE, aFrameID, aFrameName, aItemName, aDayMeters, aEventID: string);
    function  GetItemColor(aFrameDraw: TFrameDraw; SteelFrame: TSteelFrame; aEntityPointer: pEntityRecType): TColor;overload;
    procedure AddButtonToToolbar(var aToolBar: TToolBar; aCaption: string; aRFID : Integer);
    procedure RFButtonClick(Sender: TObject);

  public
    { Public declarations }
  end;

var
  MDIChildJobStatus: TMDIChildJobStatus;

implementation

{$R *.dfm}

uses
  UnitScotDashBoard, UnitJobTransferForm, UnitDMLoadEP2Files, ScotRFTypes;

function TJobLiveCallback.Execute(const Arg: TJSONValue): TJSONValue;
begin
  If Assigned(MDIChildJobStatus) then
    MDIChildJobStatus.QueueLogMsg(Arg);
  Result := TJSONTrue.Create;
end;

procedure TMDIChildJobStatus.ActionApplyFilterExecute(Sender: TObject);
begin
  inherited;
  If NOT ToolButtonApplyFilter.Down then
  begin
    DMDesignJob.ResetFilter('0');
    ComboBoxRFSelection.Enabled := False;
  end
  else
  begin
    ComboBoxRFSelection.Enabled := False;
    DMDesignJob.FDMemTableRollFormer.FindKey([ComboBoxRFSelection.Text]);
    DMDesignJob.ResetFilter(DMDesignJob.FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsString);
  end;
end;

procedure TMDIChildJobStatus.AfterScroll(aDataset : TDataset);
begin
  If Assigned(PaintBoxFrame) then
  begin
    PaintBoxFrame.Tag := 10; //draw frame
    PaintBoxFrame.Repaint;
  end;
  with DMDesignJob do
  begin
    GetFrameFinishedLENGTH;
    GetFrameTotalLENGTH;
    GetEP2FinishedLENGTH;
    GetEP2TotalLENGTH;
    GetJobFinishedLENGTH;
    GetJobTotalLENGTH;
    GetItemProduction;
  end;
end;

procedure TMDIChildJobStatus.ProductItemAfterScroll(aDataset : TDataset);
begin
  If Assigned(PaintBoxFrame) then
  begin
    PaintBoxFrame.Tag := 11; //draw item
    PaintBoxFrame.Repaint;
  end;
end;

procedure TMDIChildJobStatus.ComboBoxRFSelectionSelect(Sender: TObject);
begin
  inherited;
  DMDesignJob.FDMemTableRollFormer.FindKey([ComboBoxRFSelection.Text]);
  DMDesignJob.ScotRFRollFormerID := DMDesignJob.FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsInteger;
  DMDesignJob.ResetFilter(DMDesignJob.FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsString);
end;

procedure TMDIChildJobStatus.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  MDIChildJobStatus := nil;
end;

procedure TMDIChildJobStatus.FormCreate(Sender: TObject);
begin
  inherited;
  FCurrentJobsID :='';
  FCurrentRFID := -1;
  DMDesignJob.GetJOB;
  DMDesignJob.GetEP2FILE;
  DMDesignJob.GetFrame;
  DMDesignJob.GetFrameEntity;
  DMDesignJob.GetItemProduction;
  DMDesignJob.GetROLLFORMER;
  JvDBGridFrame.DataSource.DataSet.AfterScroll := AfterScroll;
  DMDesignJob.FDMemTableEP2FILE.AfterScroll := FDMemTableEP2FILEAfterScroll;
  ToolBarJobStatus.Parent := TFormScotDashBoard(Self.Owner).ToolBarMain;
  ToolBarJobStatus.Left   := 1200;
  ToolBarRollFormer.Parent := TFormScotDashBoard(Self.Owner).ToolBarMain;
  ToolBarRollFormer.Left := ToolBarJobStatus.Left +ToolBarJobStatus.Width
end;

procedure TMDIChildJobStatus.FormPaint(Sender: TObject);
begin
  inherited;
  GroupBoxJobDetails.Caption := DMDesignJob.ProjectName;
end;

procedure TMDIChildJobStatus.RFButtonClick(Sender: TObject);
var
  i : Integer;
begin
  for I := 0 to ToolBarRollFormer.ButtonCount-1 do
    ToolBarRollFormer.Buttons[i].Down := ToolBarRollFormer.Buttons[i].Tag = TToolButton(Sender).Tag;
  FCurrentRFID := TToolButton(Sender).Tag;
  LabelActiveRF.Caption := Format('Machine %s is updating', [DMDesignJob.GetRollFormerName(FCurrentRFID)]);
end;

procedure TMDIChildJobStatus.AddButtonToToolbar(var aToolBar: TToolBar; aCaption: string; aRFID : Integer);
var
  aNewButton : TToolButton;
  aLastButtonIndex : Integer;
begin
  aNewButton := TToolButton.Create(aToolBar);
  with aNewButton do
  begin
    ImageIndex := aRFID-1;
    Tag        := aRFID;
    Height     := 30;
    Caption    := aCaption;
    OnClick    := RFButtonClick;
    ShowHint   := True;
    Style      := tbsCheck;
  end;
  aLastButtonIndex := aToolBar.ButtonCount - 1;
  if aLastButtonIndex > -1 then
    aNewButton.Left := aToolBar.Buttons[aLastButtonIndex].Left + aToolBar.Buttons[aLastButtonIndex].Width
  else
    aNewButton.Left := 0;
  aNewButton.Parent := aToolBar;
end;

procedure TMDIChildJobStatus.FormShow(Sender: TObject);
var
  i : integer;
begin
  inherited;
  ComboBoxRFSelection.Clear;
  ComboBoxRFSelection.Items.AddStrings(DMDesignJob.RollFoemerStrings);
  ToolBarRollFormer.ShowHint     := True;
  ToolBarRollFormer.ShowCaptions := True;
  DMDesignJob.FDMemTableRollFormer.First;
  while not DMDesignJob.FDMemTableRollFormer.Eof do
  begin
    AddButtonToToolbar(ToolBarRollFormer, DMDesignJob.FDMemTableRollFormer.FieldByName('Name').AsString
                                        , DMDesignJob.FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsInteger );
    DMDesignJob.FDMemTableRollFormer.Next;
  end;
end;

function TMDIChildJobStatus.GetItemColor(aFrameDraw: TFrameDraw; SteelFrame: TSteelFrame; aEntityPointer: pEntityRecType): TColor;
begin
  Result := clWebDodgerBlue;
end;

procedure TMDIChildJobStatus.JvDBGridDesignJobDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  with JvDBGridDesignJob, DMDesignJob do
  begin
    if (AnsiPos('|'+Trim(DataSource.DataSet.FieldByName('JOBID').AsString)+'|', FCurrentJobsID)>0) then
    begin
       Canvas.Font.Color := clPurple;
       Canvas.Brush.Color := clLime;
       Canvas.FillRect(Rect);
       DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end
    else
    begin
      IF (DataSource.DataSet.FieldByName('RFTYPEID').AsInteger=0) then
      begin
        GroupBoxEP2Files.Caption := 'Panel EP2 Files';
        JvDBGridEP2Files.Columns[2].Title.Caption :='EP2 Files'
      end
      else
      begin
        GroupBoxEP2Files.Caption := 'Truss TXT Files';
        JvDBGridEP2Files.Columns[2].Title.Caption :='TXT Files'
      end;
      IF (DataSource.DataSet.FieldByName('Percentage').AsInteger>99) then
        Canvas.Font.Color :=clRed
      else
      IF (DataSource.DataSet.FieldByName('Percentage').IsNull) then
        Canvas.Font.Color :=clBlack
      else
      IF (DataSource.DataSet.FieldByName('Percentage').AsInteger=0) then
        Canvas.Font.Color :=clGreen
      else
        Canvas.Font.Color :=clBlue;
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

procedure TMDIChildJobStatus.JvDBGridDesignJobKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  GroupBoxJobDetails.Caption := DMDesignJob.ProjectName;
end;

procedure TMDIChildJobStatus.JvDBGridDesignJobMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  GroupBoxJobDetails.Caption := DMDesignJob.ProjectName;
end;

procedure TMDIChildJobStatus.FDMemTableEP2FILEAfterScroll(DataSet: TDataSet);
begin
  IF DMDesignJob.FDMemTableEP2FILEROLLFORMERID.AsInteger = 0 then
  begin
    MenuItemTransferEP2.Caption := 'Assign To';
  end
  else
  begin
    MenuItemTransferEP2.Caption := 'Transfer To';
  end;
  DMLoadEP2Files.ResetFFileStrings;
end;

procedure TMDIChildJobStatus.JvDBGridEP2FilesDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  with JvDBGridEP2Files, DMDesignJob do
  begin
    if (gdSelected in State) then
    begin
       Canvas.Font.Color := clPurple;
       Canvas.Brush.Color := clLime;
       Canvas.FillRect(Rect);
       DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end
    else
    begin
      IF (DataSource.DataSet.FieldByName('Percentage').AsInteger>99) then
        Canvas.Font.Color :=clRed
      else
      IF (DataSource.DataSet.FieldByName('Percentage').IsNull) then
        Canvas.Font.Color :=clBlack
      else
      IF (DataSource.DataSet.FieldByName('Percentage').AsInteger=0) then
        Canvas.Font.Color :=clGreen
      else
        Canvas.Font.Color :=clBlue;
      Canvas.Brush.Color:=clWhite;
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

procedure TMDIChildJobStatus.JvDBGridFrameDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  with JvDBGridFrame, DMDesignJob do
  begin
    if (gdSelected in State) then
    begin
       Canvas.Font.Color := clPurple;
       Canvas.Brush.Color := clLime;
       Canvas.FillRect(Rect);
       DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end
    else
    begin
      IF (DataSource.DataSet.FieldByName('Percentage').AsInteger>99) then
        Canvas.Font.Color :=clRed
      else
        Canvas.Font.Color :=clGreen;
      Canvas.Brush.Color:=clWhite;
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

procedure TMDIChildJobStatus.JvDBGridProducedFrameItemsDblClick(
  Sender: TObject);
begin
  inherited;
  if not DMDesignJob.FDMemTableItemProductionROLLFORMERID.IsNull then
  begin
    FCurrentRFID := DMDesignJob.FDMemTableItemProductionROLLFORMERID.AsInteger;
    LabelActiveRF.Caption := Format('Machine %s is updating', [DMDesignJob.GetRollFormerName(FCurrentRFID)]);
  end;
end;

procedure TMDIChildJobStatus.JvDBGridProducedFrameItemsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  with JvDBGridProducedFrameItems, DMDesignJob do
  begin
    if (DataCol=0)and(DataSource.DataSet.RecordCount>0)and(Column.Field.AsInteger=0) then
    begin
      Canvas.Font.Color :=clBlue;
      Canvas.Brush.Color:=clWhite;
      Canvas.Font.Size  := 7;
      SetTextAlign( Canvas.Handle, TA_LEFT + TA_BOTTOM );
      Canvas.TextRect( Rect, Rect.Left +1, Rect.Bottom -2, 'Produced' );
      Canvas.Font.Size  := 8;
    end
    else
    begin
      SetTextAlign( Canvas.Handle, TA_LEFT + TA_TOP );
      Canvas.Font.Color :=clGreen;
      Canvas.Brush.Color:=clWhite;
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;

end;

procedure TMDIChildJobStatus.MenuItemTransferEP2Click(Sender: TObject);
begin
  inherited;
  TFormJobTransfer.TransferAJobToOtherMachine( DMDesignJob.FDMemTableJOBRollFormerID.AsInteger, ttEP2TXT);
end;

procedure TMDIChildJobStatus.MenuItemTRemoveJobClick(Sender: TObject);
begin
  inherited;
  DMDesignJob.DeleteAJob(DMDesignJob.FDMemTableJOBJOBID.AsInteger, DMDesignJob.FDMemTableJOBDESIGN.AsWideString);
  DMDesignJob.RefreshData(nil);
end;

procedure TMDIChildJobStatus.PaintBoxFramePaint(Sender: TObject);
var
  R: TRect;
  abookmark: TBookMark;
begin
  R := Rect(0, 0, PaintBoxFrame.ClientWidth, PaintBoxFrame.ClientHeight);
  PaintBoxFrame.canvas.Brush.color := clWebGhostWhite;
  PaintBoxFrame.canvas.Brush.style := bsSolid;
  PaintBoxFrame.canvas.FillRect(R);
  InflateRect(R,-12,-12);
  with DMDesignJob do
  begin
    FDMemTableFrameEntity.DisableControls;
    try
      FCurrentFrame := TSteelFrame.Create(FDMemTableFrame, FDMemTableFrameEntity);
      if PaintBoxFrame.Tag =10 then
        TFrameDraw.DrawStructure2(FCurrentFrame, nil, false, PaintBoxFrame.canvas, R, GetItemColor)
      else
      if PaintBoxFrame.Tag =11 then
      begin
        TFrameDraw.DrawStructure2(FCurrentFrame, nil{ProductionQueueQ.CurrentEntity}, false, PaintBoxFrame.canvas, R, GetItemColor);
      end;
    finally
      FDMemTableFrameEntity.EnableControls;
    end;
  end;
end;

procedure TMDIChildJobStatus.ToolButtonApplyFilterClick(Sender: TObject);
begin
  inherited;
  DMDesignJob.FilterDown := ToolButtonApplyFilter.Down;
  If NOT ToolButtonApplyFilter.Down then
  begin
    DMDesignJob.ResetFilter('0');
    ComboBoxRFSelection.Enabled := False;
    ToolButtonApplyFilter.Hint :='Click down to enable RollFormer selection box';
  end
  else
  begin
    ToolButtonApplyFilter.Hint :='Click to display all RollFormer Infomation';
    ComboBoxRFSelection.Enabled := True;
    DMDesignJob.FDMemTableRollFormer.FindKey([ComboBoxRFSelection.Text]);
    DMDesignJob.ResetFilter(DMDesignJob.FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsString);
  end;
end;

procedure TMDIChildJobStatus.QueueLogMsg(const Arg: TJSONValue);
var
  aRFID      : String;
  aJobName   : String;
  aEP2FILEID : String;
  aEP2FILE   : String;
  aFrameID   : String;
  aFrameName : String;
  aItemName  : String;
  aDayMeters : String;
  aEventID   : String;
  aJobID     : String;
begin
  aRFID      := Arg.GetValue<String>('RollformerID');
  aJobID     := Arg.GetValue<String>('JobID');
  aJobName   := Arg.GetValue<String>('JobName');
  aFrameID   := Arg.GetValue<String>('FRAMEID');
  aFrameName := Arg.GetValue<String>('FrameName');
  aEP2FILEID := Arg.GetValue<String>('EP2FILEID');
  aEP2FILE   := Arg.GetValue<String>('EP2FILE');
  aItemName  := Arg.GetValue<String>('ItemName');
  aDayMeters := Arg.GetValue<String>('DayMeters');
  aEventID   := Arg.GetValue<String>('EventID');
  if (FCurrentRFID=-1) or (FCurrentRFID=StrToInt(aRFID)) then
  begin
    TThread.Queue(nil, procedure begin LogMsg(aRFID, aJobID, aJobName, aEP2FILEID, aEP2FILE, aFrameID, aFrameName, aItemName, aDayMeters, aEventID) end);
  end;
end;

procedure TMDIChildJobStatus.LogMsg(const aRFID, aJobID, aJobName, aEP2FILEID, aEP2FILE, aFrameID, aFrameName, aItemName, aDayMeters, aEventID: string);
var
  aJobIDStr : String;
begin
  aJobIDStr := '|'+Trim(aJobID)+'|';
  If DMDesignJob.FDMemTableJOB.FindKey([1, StrToIntDef(aJobID, 0)]) Then
  begin
    IF ( TRFEventType(StrToInt(aEventID)) <> rfetJobFinish) then
    begin
      If (AnsiPos(aJobIDStr, FCurrentJobsID)<=0) then
        FCurrentJobsID := FCurrentJobsID + aJobIDStr;
    end
    else
    begin
      If (AnsiPos(aJobIDStr, FCurrentJobsID)>0) then
        Delete( FCurrentJobsID, AnsiPos(aJobIDStr, FCurrentJobsID), Length(aJobIDStr));
      with DMDesignJob do
      begin
        GetFrameFinishedLENGTH;
        GetFrameTotalLENGTH;
        GetEP2FinishedLENGTH;
        GetEP2TotalLENGTH;
        GetJobFinishedLENGTH;
        GetJobTotalLENGTH;
        GetItemProduction;
      end;
    end;
  end;
  DMDesignJob.FDMemTableEP2FILE.FindKey([1, StrToIntDef(aJobID, 0), StrToIntDef(aEP2FILEID, 0)]);
  DMDesignJob.FDMemTableFRAME.Locate('EP2FILEID;FRAMENAME',  VarArrayOf([StrToIntDef(aEP2FILEID, 0), aFrameName]), []);
end;

end.
