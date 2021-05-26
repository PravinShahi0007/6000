unit UnitJobSelection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Data.DB, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,
  UnitDMDesignJob, FrameDrawU,  FrameDataU, GlobalU, Vcl.DBCtrls,
  Vcl.WinXCalendars, Vcl.Mask, Vcl.Menus, JvFormPlacement, JvComponentBase,
  JvAppStorage, JvAppRegistryStorage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type

  TFormJobSelection = class(TForm)
    PanelJob: TPanel;
    PanelFrames: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    PanelButtons: TPanel;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    DBTextFrameEP2File: TDBText;
    GroupBoxSelectedJobDetails: TGroupBox;
    GroupBoxSelectedFrames: TGroupBox;
    JvDBGridFrame: TJvDBGrid;
    GroupBoxSelectedFrameItemsForProduction: TGroupBox;
    JvDBGridFrameEntity: TJvDBGrid;
    GroupBoxProduced: TGroupBox;
    Splitter3: TSplitter;
    JvDBGridProducedFrameItems: TJvDBGrid;
    GroupBoxFrameDrawing: TGroupBox;
    GroupBoxFramesForProduce: TGroupBox;
    ListBoxSelectedFrames: TListBox;
    PanelFramesProduceOption: TPanel;
    JvDBGridEP2FILES: TJvDBGrid;
    PaintBoxFrame: TPaintBox;
    ButtonLoadProject: TButton;
    GroupBoxSelectButtons: TGroupBox;
    Panel2: TPanel;
    bnSelect: TBitBtn;
    bnUnSelect: TBitBtn;
    bnSelectAll: TBitBtn;
    bnSelectNone: TBitBtn;
    lbWarning: TLabel;
    Label3: TLabel;
    uxFrameCopies: TEdit;
    UpDown1: TUpDown;
    GroupCBox: TCheckBox;
    GroupBoxFirstItemStartEnd: TGroupBox;
    uxFinalItem: TEdit;
    lbFinal: TLabel;
    ElementEdit: TEdit;
    label2: TLabel;
    Label1stFrameName: TLabel;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    EditToDo: TEdit;
    PanelGauge: TPanel;
    EditTrussGauge: TComboBox;
    LabelGaugeCaption: TLabel;
    Label1: TLabel;
    Splitter6: TSplitter;
    Splitter7: TSplitter;
    Splitter8: TSplitter;
    PopupMenuEP2Transfer: TPopupMenu;
    MenuItemTransferEP2: TMenuItem;
    FDMemTableJOB: TFDMemTable;
    FDMemTableJOBJOBID: TIntegerField;
    DataSourceJob: TDataSource;
    FDMemTableJOBSITEID: TSmallintField;
    GroupBoxJobList: TGroupBox;
    JvDBGridDesignJob: TJvDBGrid;
    PanelDateRange: TPanel;
    CalendarPickerStart: TCalendarPicker;
    CalendarPickerEnd: TCalendarPicker;
    MemoJobTransferInfo: TMemo;
    JvAppRegistryStorage1: TJvAppRegistryStorage;
    JvFormStorage1: TJvFormStorage;
    FDMemTableJOBTEMP: TFDMemTable;
    FDMemTableJOBJOBNAME: TWideStringField;
    PopupMenuJobTransfer: TPopupMenu;
    MenuItemTRemoveJob: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure PaintBoxFramePaint(Sender: TObject);
    procedure JvDBGridFrameCellClick(Column: TColumn);
    procedure JvDBGridProducedFrameItemsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure SpeedButtonUpClick(Sender: TObject);
    procedure SpeedButtonDownClick(Sender: TObject);
    procedure SpeedButtonRemoveClick(Sender: TObject);
    procedure JvDBGridFrameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure JvDBGridFrameDblClick(Sender: TObject);
    procedure JvDBGridFrameDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ButtonLoadProjectClick(Sender: TObject);
    procedure CalendarPickerEndChange(Sender: TObject);
    procedure CalendarPickerStartChange(Sender: TObject);
    procedure bnSelectClick(Sender: TObject);
    procedure bnSelectAllClick(Sender: TObject);
    procedure bnUnSelectClick(Sender: TObject);
    procedure bnSelectNoneClick(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure JvDBGridEP2FILESDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditToDoKeyPress(Sender: TObject; var Key: Char);
    procedure EditTrussGaugeChange(Sender: TObject);
    procedure JvDBGridEP2FILESDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure MenuItemTransferJobClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MenuItemTRemoveJobClick(Sender: TObject);
    procedure MenuItemTransferEP2Click(Sender: TObject);
    procedure JvDBGridDesignJobCellClick(Column: TColumn);
    procedure JvDBGridDesignJobKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FDeleteing   : Boolean;
		FOnChange    : TNotifyEvent;
    FOnExit      : TNotifyEvent;
		FOnPrevious  : TNotifyEvent;
		FOnNext      : TNotifyEvent;
		FOnLeft      : TNotifyEvent;
		FOnDelete    : TNotifyEvent;
		FOnReturn    : TNotifyEvent;
		FOnSelected  : TNotifyEvent;
		FOnCancel    : TNotifyEvent;
		FOnOk        : TNotifyEvent;
		FOnTab       : TNotifyEvent;
    FSelectedCount : Integer;
    SelectedList : Array of TBookmark;

    FStartMember : Integer;
    FLastMember  : Integer;
    FCopies      : Integer;
    FGrouped     : boolean;

    FDMDesignJob: TDMDesignJob;
    procedure AddItem(Item: TBookmark);
    procedure SelectFrame(Sender: TObject);
    procedure SelectAllFrames;
    function  GetItemColor(AFrame: TSteelFrame; p: pEntityRecType): TColor;
    procedure ProcessToDoEdit;
    procedure UpdatePanelFramesProduceOption;
    procedure EP2FILEAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
    Property StartMember : Integer Read FStartMember;
    Property LastMember  : Integer Read FLastMember;
    Property Copies      : Integer Read FCopies;
    Property Grouped     : boolean Read FGrouped;
    class procedure SelectFramesToProduce;
  end;

var
  FormJobSelection: TFormJobSelection;

implementation

{$R *.dfm}

uses UnitDMLoadEP2Files, DateUtils, UnitDMJOBDETAIL, coil, SplashScreenU
, Usettings, WinUtils, ScotRFTypes, StrUtils, ItemTypeSelectionU, units
, Mk2ErrorsFormU, Com_Exception, UnitDMRollFormer,
  UnitJobTransferForm;

procedure ListBoxMoveItemUp(AListBox: TListBox);
var
  CurrIndex: Integer;
begin
  with AListBox do
    if ItemIndex > 0 then
    begin
      CurrIndex := ItemIndex;
      Items.Move(ItemIndex, (CurrIndex - 1));
      ItemIndex := CurrIndex - 1;
    end;
end;

procedure ListBoxMoveItemDown(AListBox: TListBox);
var
  CurrIndex, LastIndex: Integer;
begin
  with AListBox do
  begin
    CurrIndex := ItemIndex;
    LastIndex := Items.Count;
    if ItemIndex <> -1 then
    begin
      if CurrIndex + 1 < LastIndex then
      begin
        Items.Move(ItemIndex, (CurrIndex + 1));
        ItemIndex := CurrIndex + 1;
      end;
    end;
  end;
end;

class procedure TFormJobSelection.SelectFramesToProduce;

var
  I, Quantity : Integer;
  aFormJobSelection : TFormJobSelection;
  aSteelFrame  : TSteelFrame;
  aString : String;
begin
  G_Material.Reset;
  FrameToProduce.ResetSelectedFrames;
  aFormJobSelection := TFormJobSelection.Create(nil);
  aString:='';
  with aFormJobSelection do
  try
    case ShowModal of
      mrOk: begin
              FCopies      := StrToIntDef(uxFrameCopies.Text, 1);
              For I := 0 to ListBoxSelectedFrames.Count-1 do
              begin
                with TSteelFrame(ListBoxSelectedFrames.Items.Objects[I]) do
                begin
                  Quantity := NumberOfFrames*FCopies;
                  G_Material.Metres     := G_Material.Metres     +     Quantity * MaterialLength;
  {$IFDEF PANEL}
                  G_Material.Connectors := G_Material.Connectors + 2 * Quantity * FConnectionCount;
  {$ELSE}
                  G_Material.Connectors := G_Material.Connectors +     Quantity * FConnectionCount;
  {$ENDIF}
                  G_Material.TEKScrews  := G_Material.TEKScrews  +     Quantity * TEKSCREWS;
                  G_Material.Spacers    := G_Material.Spacers    +     Quantity * SPACERS;
                end;
                FrameToProduce.SelectedFrames.Add(TSteelFrame(ListBoxSelectedFrames.Items.Objects[I]));
              end;
              FStartMember := StrToIntDef(ElementEdit.Text, 1);
              FLastMember  := StrToIntDef(uxFinalItem.Text, 1);
              FGrouped     := GroupCBox.Checked;
            end;
      mrYes:begin
            end;
    end;
  finally
    SetLength(SelectedList,0);
    FrameToProduce.StartMember := FStartMember;
    FrameToProduce.GroupItems  := FGrouped;
    FrameToProduce.LastMember  := FLastMember;
    FrameToProduce.Copies      := FCopies;
    FreeAndNil(aFormJobSelection);
  end;
end;

procedure TFormJobSelection.SpeedButtonDownClick(Sender: TObject);
begin
  ListBoxMoveItemDown(ListBoxSelectedFrames);
end;

procedure TFormJobSelection.SpeedButtonRemoveClick(Sender: TObject);
begin
  ListBoxSelectedFrames.DeleteSelected;
end;

procedure TFormJobSelection.SpeedButtonUpClick(Sender: TObject);
begin
  ListBoxMoveItemUp(ListBoxSelectedFrames);
end;

procedure TFormJobSelection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormJobSelection.FormCreate(Sender: TObject);
begin
  FSelectedCount:=0;
  CalendarPickerEnd.Date   := Now;
  CalendarPickerStart.Date := Now-14;
  PanelFramesProduceOption.Visible := ListBoxSelectedFrames.Count>0;
  FOnOk     := SelectFrame;
  FOnReturn := SelectFrame;
{$IFDEF PANEL}
  GroupBoxSelectedJobDetails.Caption := 'Selected PANEL Job &EP2 Files';
  JvDBGridFrame.Columns[4].Title.Caption := 'Rivets';
  JvDBGridFrame.Columns[5].Visible := False;
  PanelGauge.Visible := False;
{$ELSE}
  GroupBoxSelectedJobDetails.Caption := 'Selected TRUSS Job &TXTnnn Files';
  JvDBGridFrame.Columns[4].Title.Caption := 'Bolts';
  JvDBGridFrame.Columns[5].Visible := True;
  PanelGauge.Visible := True;
  EditTrussGauge.text  := G_Settings.trussprofile_gauge;
{$ENDIF}
  try
    DMDesignJob.FDMemTableJOB.Filtered := FALSE;
    DMScotServer.GetJOB(0, 1, Now-300, Now, FDMemTableJOBTEMP);
    DMDesignJob.RefreshRFJobList(FDMemTableJOB);
  except
    on e : exception do
      HandleException(e,'TFormJobSelection.FormCreate',[])
  end;
  If G_Settings.general_IsConnectToServer then
  BEGIN
    JvDBGridDesignJob.PopupMenu := nil
  END
  else
  BEGIN
    JvDBGridDesignJob.PopupMenu := PopupMenuJobTransfer;
  END;
end;

procedure TFormJobSelection.FormShow(Sender: TObject);
begin
  lbWarning.Visible := TypeSelectform.SelectByItems;
  if DataSourceJob.DataSet.RecordCount>0 then
  begin
    DMDesignJob.FDMemTableEP2FILE.MasterSource := DataSourceJob;
    DMDesignJob.FDMemTableEP2FILE.MasterFields := 'SITEID;JOBID';
  end;
  DMDesignJob.FDMemTableEP2FILE.AfterScroll  := EP2FILEAfterScroll;
end;

procedure TFormJobSelection.EP2FILEAfterScroll(DataSet: TDataSet);
begin
  DMLoadEP2Files.ResetFFileStrings;
end;


procedure TFormJobSelection.PaintBoxFramePaint(Sender: TObject);
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
    try
      abookmark := FDMemTableFrameEntity.GetBookmark;
      TFrameDraw.DrawFrameStructure(TSteelFrame.Create(FDMemTableFrame, FDMemTableFrameEntity), nil, false, PaintBoxFrame.canvas, R, GetItemColor);
      FDMemTableFrameEntity.GotoBookmark(abookmark);
    finally
    end;
  end;
end;

function TFormJobSelection.GetItemColor(AFrame: TSteelFrame; p: pEntityRecType): TColor;
begin
  result:=clWebDodgerBlue;
end;

procedure TFormJobSelection.AddItem(Item: TBookmark);
begin
  Inc(FSelectedCount);
  SetLength(SelectedList, FSelectedCount);
  SelectedList[FSelectedCount-1] := Item;
end;

procedure TFormJobSelection.SelectFrame(Sender: TObject);
var
  aSteelFrame : TSteelFrame;
  i, j : Integer;
begin
  If DMLoadEP2Files.FileStrings.Count=0 then
    DMLoadEP2Files.RestoreFile(DMDesignJob.FDMemTableEP2FILE);
  For i := 0 to JvDBGridFrame.SelectedRows.Count-1 do
  try
    AddItem(JvDBGridFrame.SelectedRows[i]);
    DMDesignJob.FDMemTableFrame.GotoBookmark(JvDBGridFrame.SelectedRows[i]);
    aSteelFrame :=  DMLoadEP2Files.LoadSelectedFrameToProduce(DMDesignJob.FDMemTableEP2FILE, DMDesignJob.FDMemTableFrame);
    aSteelFrame.NumberOfFrames := StrToIntDef(EditToDo.Text, 1);
    if aSteelFrame.NumberOfFrames=0 then
      aSteelFrame.NumberOfFrames :=1;
    ListBoxSelectedFrames.Items.AddObject(Format('%s %5d',[aSteelFrame.FrameName,aSteelFrame.NumberOfFrames]), aSteelFrame);
    if (ListBoxSelectedFrames.Count=1) then
    begin
      Label1stFrameName.Caption := DMDesignJob.FDMemTableFrame.FieldByName('FRAMENAME').AsString;
      ElementEdit.Text := '1';
      uxFinalItem.Text := DMDesignJob.FDMemTableFrame.FieldByName('ITEMCOUNT').AsString;
    end;
  finally
    PanelFramesProduceOption.Visible := ListBoxSelectedFrames.Count>0;
  end;
end;

procedure TFormJobSelection.SelectAllFrames;
begin
  If DMLoadEP2Files.FileStrings.Count=0 then
    DMLoadEP2Files.RestoreFile(DMDesignJob.FDMemTableEP2FILE);
  DMLoadEP2Files.LoadAllFrameToProduce(DMDesignJob.FDMemTableEP2FILE, DMDesignJob.FDMemTableFrame, ListBoxSelectedFrames);
end;

procedure TFormJobSelection.EditToDoKeyPress(Sender: TObject; var Key: Char);
begin
  if ( not CharInSet(Key, ['0'..'9', #8, #13]) ) then
    Key := #0;
end;

procedure TFormJobSelection.EditTrussGaugeChange(Sender: TObject);
begin
    G_Settings.trussprofile_gauge := EditTrussGauge.text;
    G_Settings.SaveSettings;
end;

procedure TFormJobSelection.ProcessToDoEdit;
var
  aInt : Integer;
begin
  aInt := DMDesignJob.FDMemTableFrame.FieldByName('NUMBEROFFRAMES').AsInteger - DMDesignJob.FDMemTableFrame.FieldByName('PRODUCEDFRAMES').AsInteger;
  if aInt <=0 then
    aInt := 1;
  EditToDo.Text := IntToStr(aInt);
end;

procedure TFormJobSelection.UpdatePanelFramesProduceOption;
begin
  PanelFramesProduceOption.Visible := ListBoxSelectedFrames.Count>0;
  If not PanelFramesProduceOption.Visible then
    Exit;
  Label1stFrameName.Caption := TSteelFrame(ListBoxSelectedFrames.Items.Objects[0]).FrameName;
  ElementEdit.Text := '1';
  uxFinalItem.Text := IntToStr(TSteelFrame(ListBoxSelectedFrames.Items.Objects[0]).ItemCount);
end;

procedure TFormJobSelection.JvDBGridDesignJobCellClick(Column: TColumn);
begin
  DMDesignJob.FDMemTableEP2FILE.Filtered := False;
  DMDesignJob.FDMemTableEP2FILE.Filtered := True;
end;

procedure TFormJobSelection.JvDBGridDesignJobKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  DMDesignJob.FDMemTableEP2FILE.Filtered := False;
  DMDesignJob.FDMemTableEP2FILE.Filtered := True;
end;

procedure TFormJobSelection.JvDBGridEP2FILESDblClick(Sender: TObject);
var
  aEP2BookMark : TBookMark;
begin
  {$IFDEF TRUSS}
  If (AnsiPos('.SCS',UPPERCASE(DMDesignJob.FDMemTableEP2FILEEP2FILE.AsString))>0) then
  BEGIN
    If (AnsiPos('.'+G_Settings.trussprofile_gauge, DMDesignJob.FDMemTableEP2FILEEP2FILE.AsString)<=0) then
    BEGIN
      ShowMessage('Gauge does not match with Truss Profile');
      Exit;
    END;
  END
  ELSE
  if (AnsiRightStr(DMDesignJob.FDMemTableEP2FILEEP2FILE.AsString,Length(G_Settings.trussprofile_gauge))<>G_Settings.trussprofile_gauge) then
  begin
    ShowMessage('Gauge does not match with Truss Profile');
    Exit;
  end;
  {$ENDIF}
  aEP2BookMark := DMDesignJob.FDMemTableEP2FILE.GetBookmark;
  TRY
    DMLoadEP2Files.LoadSelectedEP2FileFrames(DMDesignJob.FDMemTableEP2FILE);
  FINALLY
    DMDesignJob.FDMemTableEP2FILE.GotoBookmark(aEP2BookMark);
  END;
end;

procedure TFormJobSelection.JvDBGridEP2FILESDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with JvDBGridEP2Files, DMDesignJob do
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

procedure TFormJobSelection.JvDBGridFrameCellClick(Column: TColumn);
begin
  PaintBoxFrame.Repaint;
end;

procedure TFormJobSelection.JvDBGridFrameDblClick(Sender: TObject);
var
  SelectedButton : Integer;
begin
{$IFDEF TRUSS}
  If (AnsiPos('.SCS',UPPERCASE(DMDesignJob.FDMemTableEP2FILEEP2FILE.AsString))>0) then
  BEGIN
    If (AnsiPos('.'+G_Settings.trussprofile_gauge, DMDesignJob.FDMemTableEP2FILEEP2FILE.AsString)<=0) then
    BEGIN
      ShowMessage('Gauge does not match with Truss Profile');
      Exit;
    END;
  END
  ELSE
  if (AnsiRightStr(DMDesignJob.FDMemTableEP2FILEEP2FILE.AsString,Length(G_Settings.trussprofile_gauge))<>G_Settings.trussprofile_gauge) then
  begin
    ShowMessage('Gauge does not match with Truss Profile');
    Exit;
  end;
{$ENDIF}
  if (DMDesignJob.ItemProducedWarning<>'') then
  begin
    SelectedButton := messagedlg( DMDesignJob.ItemProducedWarning+', Continue?',mtCustom,
                             [mbYes,mbNo], 0);
    if SelectedButton=mrYes then
    begin
      if Assigned(FOnOk) then
        FOnOk(Self);
    end;
  end
  else
  if Assigned(FOnOk) then
    FOnOk(Self);
end;

procedure TFormJobSelection.JvDBGridFrameDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with JvDBGridFrame, DMDesignJob do
  begin
    IF (DataSource.DataSet.FieldByName('Percentage').AsInteger>99) then
      Canvas.Font.Color :=clRed
    else
      Canvas.Font.Color :=clGreen;
    Canvas.Brush.Color:=clWhite;
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFormJobSelection.JvDBGridFrameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Ord(Key) of
    65        : begin
                  if (ssCtrl in Shift)then
                     SelectAllFrames
                 end;

    VK_DOWN   : begin
                  if Assigned(FOnNext) then
                    FOnNext(Self);
                end;
    VK_UP     : begin
                  if Assigned(FOnPrevious) then
                    FOnPrevious(Self);
                end;
    VK_LEFT   : begin
                  if Assigned(FOnLeft) then
                  FOnLeft(Self);
                end;
		VK_DELETE : begin
                  FDeleteing := True;
                end;
    VK_TAB    : begin
                  if Assigned(FOnTab) then
                  FOnTab(Self);
                end;
    VK_RETURN : begin
                  if Assigned(FOnReturn) then
                  FOnReturn(Self);
                end;
    VK_F9     : begin
                  if Assigned(FOnOk) then
                    FOnOk(Self);
                end;
	end;
end;

procedure TFormJobSelection.JvDBGridProducedFrameItemsDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  with JvDBGridProducedFrameItems, DMDesignJob do
  begin
    if (DataCol = 0)and(DataSource.DataSet.RecordCount>0)and(Column.Field.AsInteger=0) then
    begin
      Canvas.Font.Color :=clBlue;
      SetTextAlign( Canvas.Handle, TA_LEFT + TA_BOTTOM );
      Canvas.TextRect( Rect, Rect.Left +1, Rect.Bottom -2, 'Produced' );
    end
    else
    begin
      SetTextAlign( Canvas.Handle, TA_LEFT + TA_TOP );
      Canvas.Font.Color :=clGreen;
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
end;

procedure TFormJobSelection.MenuItemTransferEP2Click(Sender: TObject);
begin
  TFormJobTransfer.TransferAJobToOtherMachine( DMDesignJob.ScotRFRollFormerID, ttEP2TXT);
end;

procedure TFormJobSelection.MenuItemTransferJobClick(Sender: TObject);
begin
  TFormJobTransfer.TransferAJobToOtherMachine( DMDesignJob.ScotRFRollFormerID, ttJob);
end;

procedure TFormJobSelection.MenuItemTRemoveJobClick(Sender: TObject);
begin
  DMDesignJob.DeleteAJob(FDMemTableJOBJOBID.AsInteger, FDMemTableJOBJOBNAME.AsWideString);
  DMDesignJob.RefreshRFJobList(FDMemTableJOB);
end;

procedure TFormJobSelection.bnSelectAllClick(Sender: TObject);
begin
  JvDBGridFrame.SelectAll;
  try
    JvDBGridFrameDblClick(Sender);
    UpdatePanelFramesProduceOption;
  finally
    JvDBGridFrame.UnselectAll;
  end;
end;

procedure TFormJobSelection.bnSelectClick(Sender: TObject);
begin
  JvDBGridFrameDblClick(Sender);
  UpdatePanelFramesProduceOption;
end;

procedure TFormJobSelection.bnSelectNoneClick(Sender: TObject);
begin
  ListBoxSelectedFrames.Clear;
  UpdatePanelFramesProduceOption;
end;

procedure TFormJobSelection.bnUnSelectClick(Sender: TObject);
begin
  ListBoxSelectedFrames.DeleteSelected;
  UpdatePanelFramesProduceOption;
end;

procedure TFormJobSelection.ButtonLoadProjectClick(Sender: TObject);
var
  aOpenDialog   : TFileOpenDialog;
  aRollFormerID : Integer;
  aPtr          : TDatasetNotifyEvent;
begin
  aPtr := DMDesignJob.FDMemTableEP2FILE.AfterScroll;
  DMDesignJob.FDMemTableEP2FILE.AfterScroll := NIL;
  aOpenDialog := TFileOpenDialog.Create(self);
  try
{$IFDEF PANEL}
    aOpenDialog.Title := 'Select EP2 File Folder to Import';
{$ELSE}
    aOpenDialog.Title := 'Select TX? File Folder to Import';
{$ENDIF}
    aOpenDialog.Options := [fdoPickFolders];
    if aOpenDialog.Execute then
    begin
      aRollFormerID := DMSCOTRFID.ScotRFRollFormerID;
      DMLoadEP2Files.LoadEP2Files(aOpenDialog.FileName, aRollFormerID);
    end;
    DMDesignJob.ResetFilter('0');
  finally
    FreeAndNil(aOpenDialog);
    DMDesignJob.GetEP2FILE;
    DMDesignJob.GetJOB;
    DMScotServer.GetJOB(0, 1, Now-300, Now, FDMemTableJOBTEMP);
    DMDesignJob.RefreshRFJobList(FDMemTableJOB);
    DMDesignJob.ResetFilter(IntToStr(DMSCOTRFID.ScotRFRollFormerID));
    DMDesignJob.FDMemTableJOB.Last;
    DMDesignJob.FDMemTableEP2FILE.Last;
    DMDesignJob.FDMemTableEP2FILE.AfterScroll := aPtr;
    SELF.Close;
  end;
end;

procedure TFormJobSelection.ButtonOkClick(Sender: TObject);
var
  i : Integer;
  aCoilform : TCoilform;
  aDMJOBDETAIL : TDMJOBDETAIL;
begin
  for I := 0 to ListBoxSelectedFrames.Count-1 do
  begin
    if TSteelFrame(ListBoxSelectedFrames.Items.Objects[i]).FrameErrors.Count>0 then
      TfrmMk2Errors.Show('Frame Errors', TSteelFrame(ListBoxSelectedFrames.Items.Objects[i]).FrameErrors, True {Cancel});
  end;
  ModalResult := MrOk;
  if (ListBoxSelectedFrames.Count>0)and(ModalResult = MrOk) then
  begin
    if G_Settings.Logging_JobDetails then
    begin
      aDMJOBDETAIL := TDMJOBDETAIL.Create(nil);
      aCoilform :=TCoilform.Create(nil);
      Try
        aCoilForm.SetFormDetails(FDMemTableJOB.FieldByName('JOBID').AsString
                             , FDMemTableJob.FieldByName('JobName').AsString
                             , ExtractBetween(DMDesignJob.FDMemTableEP2FILE.FieldByName('EP2FILE').AsString, '(',')'));
        if G_Settings.Logging_JobDetails then
        begin
          if aCoilForm.ShowModal <> mrOK then
            exit;
        end;
        for I := 0 to ListBoxSelectedFrames.Count-1 do
        begin
          FJobDetail := TJOBDETAIL.Create;
          FJobDetail.JOBID     := FDMemTableJob.FieldByName('JOBID').AsInteger;
          FJobDetail.EP2FILEID := DMDesignJob.FDMemTableEP2FILE.FieldByName('EP2FILEID').AsInteger;
          FJobDetail.FRAMEID   := TSteelFrame(ListBoxSelectedFrames.Items.Objects[i]).FrameID;
          FJobDetail.DESIGN    := FDMemTableJob.FieldByName('JobName').AsString;
          FJobDetail.STEEL     := aCoilform.Steel;
          FJobDetail.WORKER    := aCoilform.OperatorName;
          FJobDetail.RIVERTER  := aCoilform.RivetersStr;
          FJobDetail.COILID    := aCoilform.CoilID;
          FJobDetail.GAUGE     := FloatToStr(aCoilform.CoilGauge);
          FJobDetail.WEIGHT    := FloatToStr(aCoilform.CoilWeight);
          aDMJOBDETAIL.AddData(FJobDetail);
        end;
      Finally
        FreeAndNil(aDMJOBDETAIL);
        FreeAndNIl(aCoilForm);
      End;
    end;
  end;
end;

procedure TFormJobSelection.CalendarPickerEndChange(Sender: TObject);
begin
  If not Assigned(DMDesignJob) then
    Exit;
  DMDesignJob.FDMemTableFrame.AfterScroll := nil;
  DMDesignJob.EndTime:= EndOfTheDay(CalendarPickerEnd.Date);
end;

procedure TFormJobSelection.CalendarPickerStartChange(Sender: TObject);
begin
  If not Assigned(DMDesignJob) then
    Exit;
  DMDesignJob.FDMemTableFrame.AfterScroll := nil;
  DMDesignJob.StartTime:= 0;
end;

end.
