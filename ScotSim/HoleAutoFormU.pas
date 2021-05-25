unit HoleAutoFormU;

{
Form to compare points found for interactions of pairs of entity items.
One list displays points found by the HoleAuto.DLL,
the other by ProcessTruss
}

interface

uses
  Windows, Messages, SysUtils,
  Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  Clipbrd,
  Buttons, Menus;

type
  TfrmHoleAuto = class(TForm)
    cboItem1: TComboBox;
    cboItem2: TComboBox;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    radUnits: TRadioGroup;
    Label2: TLabel;
    Label3: TLabel;
    lstHoleAutoDetails: TListBox;
    lstEntityDetails: TListBox;
    popLst: TPopupMenu;
    mnuSelectAll: TMenuItem;
    mnuCopy: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure cboItem1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lstHoleAutoDetailsDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure popLstPopup(Sender: TObject);
    procedure mnuSelectAllClick(Sender: TObject);
    procedure mnuCopyClick(Sender: TObject);
    procedure lstHoleAutoDetailsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private     { Private declarations }
    procedure GetHoleAutoInfo(Idx1, Idx2: Word);
    procedure Get2EntitiesInfo(Idx1, Idx2: Word);
    procedure ReadIni;
    procedure WriteIni;

  public      { Public declarations }

  end;

var
  frmHoleAuto: TfrmHoleAuto;

implementation

uses GlobalU, AdjustForJointsU, mainU, UtilsU, IniFiles, TranslateU;

var
  CurrentListbox: TListBox;

{$R *.dfm}

procedure TfrmHoleAuto.ReadIni;
begin
  with TIniFile.Create(IniFileName)do
  begin
    try
      radUnits.ItemIndex := ReadInteger(OPTIONS_SETTINGS, 'Units', 0);
    finally
      Free;
    end;
  end;
end;

procedure TfrmHoleAuto.WriteIni;
begin
  with TIniFile.Create(IniFileName)do
  begin
    try
      WriteInteger(OPTIONS_SETTINGS, 'Units', radUnits.ItemIndex);
    finally
      Free;
    end;
  end;
end;

procedure TfrmHoleAuto.FormShow(Sender: TObject);
var
  i: Word;
begin
  Screen.Cursor := crHourGlass;
  try
    lstHoleAutoDetails.ItemHeight := lstHoleAutoDetails.Canvas.TextHeight('X');
    lstEntityDetails.ItemHeight := lstHoleAutoDetails.ItemHeight;
    lstHoleAutoDetails.Clear;  lstEntityDetails.Clear;
    cboItem1.Clear;  cboItem2.Clear;
    for i:=1 to pred(CurrentItem)do          //Load the names
      cboItem1.Items.Add(TrussRects.ItemName[i]);
    cboItem2.Items.Assign(cboItem1.Items);
    if cboItem1.Items.Count > 0 then
      cboItem1.ItemIndex := 0;
    if cboItem2.Items.Count > 1 then
      cboItem2.ItemIndex := 1;
    if cboItem1.Items.Count > 1 then  //auto load if there's 2 or more items
      cboItem1Change(Sender);
  finally
    Screen.Cursor := crDefault;
  end;
end;

{
function EntityIndexFromItemDesc(sItem: string): Word;
var
  i: Word;
begin
  Result := 0;
  for i:=1 to pred(CurrentItem)do
    if sItem = Entity[i].Item then
    begin
      Result := i;  break;
    end;
end;      }

function TrussRectIndexFromItemDesc(sItem: string): Word;
var
  i: Word;
begin
  Result := 0;
  for i:=1 to pred(CurrentItem)do
    if sItem = TrussRects.ItemName[i] then
    begin
      Result := i;  break;
    end;
end;

//* Use the HoleFinder in HoleAuto.DLL to find the Hole position
procedure TfrmHoleAuto.GetHoleAutoInfo(Idx1, Idx2: Word);
  //--------------------------------------------------
  procedure AddNotchAndCopeInfo(AVariant: OleVariant);
  var
    Notch: array[1..2]of Point2D;
    Cope: array[1..2]of Point2D;
    j: Byte;
  begin
    if VarArrayHighBound(AVariant, 1) < 9 then
      exit;
    Notch[1].x := StrToFloat(VarToStr(AVariant[2]));  Notch[1].y := StrToFloat(VarToStr(AVariant[3]));
    Notch[2].x := StrToFloat(VarToStr(AVariant[4]));  Notch[2].y := StrToFloat(VarToStr(AVariant[5]));
    Cope[1].x := StrToFloat(VarToStr(AVariant[6]));   Cope[1].y := StrToFloat(VarToStr(AVariant[7]));
    Cope[2].x := StrToFloat(VarToStr(AVariant[8]));   Cope[2].y := StrToFloat(VarToStr(AVariant[9]));
    lstHoleAutoDetails.Items.Add('');
    if radUnits.ItemIndex = 0 then   //Metric
    begin
      for j:=1 to 2 do
      begin
        lstHoleAutoDetails.Items.Add(format('Notch %d: (%.3f, %.3f)', [j, Notch[j].x, Notch[j].y]));
        lstHoleAutoDetails.Items.Add(format('Cope %d: (%.3f, %.3f)', [j, Cope[j].x, Cope[j].y]));
      end;
    end
    else begin                       //Imperial
      for j:=1 to 2 do
      begin
        lstHoleAutoDetails.Items.Add(format('Notch %d: (%.3f, %.3f)', [j, Notch[j].x / 25.4, Notch[j].y / 25.4]));
        lstHoleAutoDetails.Items.Add(format('Cope %d: (%.3f, %.3f)', [j, Cope[j].x / 25.4, Cope[j].y / 25.4]));
      end;
    end;
  end;
  //--------------------------------------------------
var
  i: Byte;
  n: Word;
  p: Point2D;
  T: array[1..2]of TTrapezium;
  V: array[1..2]of OleVariant;
  vP: OleVariant;
  f: Double;
  fmt: string;
begin
  if not bDllIsInitialised then
    exit;  //InitDLL;
  if HoleFinder = nil then  //should already be caught by bDllIsInitialised
    exit;

  //T[1] := TTrapezium(Entity[Idx1].Pt);  T[2] := TTrapezium(Entity[Idx2].Pt);
  T[1] := TTrapezium(TrussRects.Item[Idx1].Pt);  T[2] := TTrapezium(TrussRects.Item[Idx2].Pt);
  for n:=1 to 2 do
    with T[n] do
    begin
      V[n] := VarArrayOf([Pt[1].x, Pt[1].y,
                          Pt[2].x, Pt[2].y,
                          Pt[3].x, Pt[3].y,
                          Pt[4].x, Pt[4].y]);
    end;

  //if (HoleFinder.FindHole(V[1], V[2], vP) = RESULT_OK)then
  if (HoleFinder.Find(V[1], V[2], vP) = RESULT_OK)then
  begin
    p.x:=vP[0];  p.y:=vP[1];
    if (not PointIsOrigin(p)) then
    begin
      fmt := '%.0f';
      if radUnits.ItemIndex = 0 then   //Metric
        lstHoleAutoDetails.Items.Add(format('HolePos: (%.3f, %.3f)', [p.x, p.y]))
      else begin                       //Imperial
        lstHoleAutoDetails.Items.Add(format('HolePos: (%.3f, %.3f)', [p.x / 25.4, p.y / 25.4]));
        fmt := '%3f';
      end;
      lstHoleAutoDetails.Items.Add('');
      lstHoleAutoDetails.Items.Add(cboItem1.Text);
      for i:=0 to 7 do
      begin
        f := StrToFloat(VarToStr(V[1][i]));
        if radUnits.ItemIndex > 0 then //Imperial
          f := f / 25.4;
        lstHoleAutoDetails.Items.Add(format(fmt,[f]));
      end;
      //AddNotchAndCopeInfo(V[1]);

      lstHoleAutoDetails.Items.Add('');
      lstHoleAutoDetails.Items.Add(cboItem2.Text);
      for i:=0 to 7 do
      begin
        f := StrToFloat(VarToStr(V[2][i]));
        if radUnits.ItemIndex > 0 then //Imperial
          f := f / 25.4;
        lstHoleAutoDetails.Items.Add(format(fmt,[f]));
      end;
      //AddNotchAndCopeInfo(V[2]);
      AddNotchAndCopeInfo(vP);
    end;
  end;
end;

//* Call ProcessTruss to find the Hole position
//* Adapted from GetEntityPointsFromTrussRects
procedure TfrmHoleAuto.Get2EntitiesInfo(Idx1, Idx2: Word);
  //----------------------------------------------------
  procedure AddNotchAndCopeInfo;
  var
    j: Byte;
  begin
    lstEntityDetails.Items.Add('');
    if radUnits.ItemIndex = 0 then   //Metric
    begin
      for j:=0 to 1 do
      begin
        lstEntityDetails.Items.Add(format('Notch %d: (%.3f, %.3f)', [succ(j), NotchOut[j].x, NotchOut[j].y]));
        lstEntityDetails.Items.Add(format('Cope %d: (%.3f, %.3f)', [succ(j), CopeOut[j].x, CopeOut[j].y]));
      end;
    end
    else begin                       //Imperial
      for j:=0 to 1 do
      begin
        lstEntityDetails.Items.Add(format('Notch %d: (%.3f, %.3f)', [succ(j), NotchOut[j].x / 25.4, NotchOut[j].y / 25.4]));
        lstEntityDetails.Items.Add(format('Cope %d: (%.3f, %.3f)', [succ(j), CopeOut[j].x / 25.4, CopeOut[j].y / 25.4]));
      end;
    end;    
  end;
  //----------------------------------------------------
var
  n: Word;
  i, j: Byte;
  p: Point2D;
  f: Double;
  fmt: string;
  tempEntity: array of EntityRecType;
begin
  //FillChar(tempEntity, SizeOf(tempEntity), 0);
  SetLength(tempEntity, 2);
  //Load the 1st entity from the TrussRects
  tempEntity[0].Item := TrussRects.ItemName[Idx1];
  for j:=1 to 4 do
    tempEntity[0].Pt[j] := TrussRects.Item[Idx1].Pt[j];
  tempEntity[0].iType := TrussRects.iType[1];
  tempEntity[0].OpCount := TrussRects.OpCount[Idx1];
  for n:=1 to TrussRects.OpCount[Idx1] do
    tempEntity[0].Op[n] := TrussRects.Op[1,n];

  //Load the 2nd entity
  tempEntity[1].Item := TrussRects.ItemName[Idx2];
  for j:=1 to 4 do
    tempEntity[1].Pt[j] := TrussRects.Item[Idx2].Pt[j];
  tempEntity[1].iType := TrussRects.iType[2];
  tempEntity[1].OpCount := TrussRects.OpCount[Idx2];
  for n:=1 to TrussRects.OpCount[Idx2] do
    tempEntity[1].Op[n] := TrussRects.Op[2,n];

  ProcessTruss(tempEntity, 2);

  p := HoleOutPt;
  if (not PointIsOrigin(p)) then
  begin
    fmt := '%.0f';
    if radUnits.ItemIndex = 0 then   //Metric
      lstEntityDetails.Items.Add(format('HolePos: (%.3f, %.3f)', [p.x, p.y]))
    else begin                       //Imperial
      lstEntityDetails.Items.Add(format('HolePos: (%.3f, %.3f)', [p.x / 25.4, p.y / 25.4]));
      fmt := '%3f';
    end;
    lstEntityDetails.Items.Add('');
    lstEntityDetails.Items.Add(cboItem1.Text);
    for i:=1 to 4 do
    begin
      f := tempEntity[0].Pt[i].x;
      if radUnits.ItemIndex > 0 then //Imperial
        f := f / 25.4;
      lstEntityDetails.Items.Add(format(fmt,[f]));

      f := tempEntity[0].Pt[i].y;
      if radUnits.ItemIndex > 0 then //Imperial
        f := f / 25.4;
      lstEntityDetails.Items.Add(format(fmt,[f]));
    end;
    //AddNotchAndCopeInfo(tempEntity[1]);

    lstEntityDetails.Items.Add('');
    lstEntityDetails.Items.Add(cboItem2.Text);
    for i:=1 to 4 do
    begin
      f := tempEntity[1].Pt[i].x;
      if radUnits.ItemIndex > 0 then //Imperial
        f := f / 25.4;
      lstEntityDetails.Items.Add(format(fmt,[f]));

      f := tempEntity[1].Pt[i].y;
      if radUnits.ItemIndex > 0 then //Imperial
        f := f / 25.4;
      lstEntityDetails.Items.Add(format(fmt,[f]));
    end;
    //AddNotchAndCopeInfo(tempEntity[2]);
    AddNotchAndCopeInfo;
  end;

  SetLength(tempEntity, 0);  tempEntity := nil;
end;

procedure TfrmHoleAuto.cboItem1Change(Sender: TObject);
var
  Idx1, Idx2: Word;
begin
  lstHoleAutoDetails.Clear;  lstEntityDetails.Clear;
  if (cboItem1.ItemIndex < 0)or(cboItem2.ItemIndex < 0)then
    exit;
  if (cboItem1.ItemIndex = cboItem2.ItemIndex)then
    exit;

  //Idx1 := EntityIndexFromItemDesc(cboItem1.Text);
  Idx1 := TrussRectIndexFromItemDesc(cboItem1.Text);
  if Idx1 = 0 then
    exit;

  //Idx2 := EntityIndexFromItemDesc(cboItem2.Text);
  Idx2 := TrussRectIndexFromItemDesc(cboItem2.Text);
  if Idx2 = 0 then
    exit;

  GetHoleAutoInfo(Idx1, Idx2);
  Get2EntitiesInfo(Idx1, Idx2);
end;

procedure TfrmHoleAuto.FormCreate(Sender: TObject);
begin
  ReadIni;

  TranslateForm(Self);
end;

procedure TfrmHoleAuto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteIni;
end;

procedure TfrmHoleAuto.lstHoleAutoDetailsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  Margin=5;
var
  TextColor, BkgColor: TColor;
begin         {
  if lstEntityDetails.Items.Count = 0 then
    exit;
  if lstHoleAutoDetails.Items.Count = 0 then
    exit;  }
    
  TextColor := clHighlightText;
  BkgColor := clHighlight;
  if (not(odSelected in State))
  or (not Control.Focused)then
  begin
    TextColor := clWindowText;
    BkgColor := clWindow;
    //Colour the differences
    if (lstEntityDetails.Items.Count > Index)
    and(lstHoleAutoDetails.Items.Count > Index)then
      if lstEntityDetails.Items[Index] <> lstHoleAutoDetails.Items[Index] then
      begin
        TextColor := clInfoText;
        BkgColor := clInfoBk;
      end;
  end;
  with (Control as TListBox) do
  begin
    Canvas.Font.Color := TextColor;
    Canvas.Brush.Color:= BkgColor;
    Canvas.TextRect(Rect, Rect.Left+Margin, Rect.Top, Items[Index]);
  end;
end;

procedure TfrmHoleAuto.popLstPopup(Sender: TObject);
begin
  mnuCopy.Enabled := CurrentListbox.SelCount > 0;
end;

procedure TfrmHoleAuto.mnuSelectAllClick(Sender: TObject);
begin
  CurrentListbox.SelectAll;
end;

procedure TfrmHoleAuto.mnuCopyClick(Sender: TObject);
var
  i: Integer;
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    for i:=0 to pred(CurrentListbox.Items.Count)do
      if CurrentListbox.Selected[i]then
        SL.Add(CurrentListbox.Items[i]);
    Clipboard.SetTextBuf(PChar(SL.Text));
  finally
    SL.Free;
  end;
end;

procedure TfrmHoleAuto.lstHoleAutoDetailsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CurrentListbox := lstHoleAutoDetails;
  if (Sender = lstEntityDetails)  then
    CurrentListbox := lstEntityDetails;
end;

END.
