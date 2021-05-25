unit RectPropertiesForm;

{
Form to display details about the currently selected rectangle
with some editing of the rect
}

interface

uses
  Windows, Messages, SysUtils,
  Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls,
  GlobalU,
  Buttons, ImgList;

type
  TfrmRectProperties = class(TForm)
    gpRectInfo: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    txtX1: TEdit;
    txtY1: TEdit;
    txtX2: TEdit;
    txtY2: TEdit;
    txtX3: TEdit;
    txtY3: TEdit;
    txtY4: TEdit;
    txtX4: TEdit;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    chkWeb: TCheckBox;
    Label7: TLabel;
    txtName: TEdit;
    Label8: TLabel;
    txtLength: TEdit;
    chkMulti: TCheckBox;
    chkHideItem: TCheckBox;
    gpTransform: TGroupBox;
    btnRotate: TSpeedButton;
    btnReverse: TSpeedButton;
    btnFlip: TSpeedButton;
    btnDelete: TSpeedButton;
    lblTotalLength: TLabel;
    procedure btnReverseClick(Sender: TObject);
    procedure btnRotateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFlipClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private  { Private declarations }
    procedure TextboxesModified;
  public   { Public declarations }
    procedure SetTextboxValues(Pt: array of Point2D);
    procedure GetTextboxValues(var Pt: array of Point2D);
  end;

  procedure TiltItemPoints(var Pt: array of Point2D);

var
  frmRectProperties: TfrmRectProperties;

implementation

uses TranslateU, UtilsU, mainU;

{$R *.dfm}

//* Make the textboxes' modified property true to force the change
procedure TfrmRectProperties.TextboxesModified;
begin
  txtX1.Modified := True;
  txtX2.Modified := True;
  txtX3.Modified := True;
  txtX4.Modified := True;
  txtY1.Modified := True;
  txtY2.Modified := True;
  txtY3.Modified := True;
  txtY4.Modified := True;
end;

//* Set the Text value of the 8 textboxes from an array of points
//* assumes 4 members in the array
procedure TfrmRectProperties.SetTextboxValues(Pt: array of Point2D);
begin
  txtX1.Text := format('%f', [Pt[0].x]);
  txtX2.Text := format('%f', [Pt[1].x]);
  txtX3.Text := format('%f', [Pt[2].x]);
  txtX4.Text := format('%f', [Pt[3].x]);
  txtY1.Text := format('%f', [Pt[0].y]);
  txtY2.Text := format('%f', [Pt[1].y]);
  txtY3.Text := format('%f', [Pt[2].y]);
  txtY4.Text := format('%f', [Pt[3].y]);
end;

procedure TfrmRectProperties.GetTextboxValues(var Pt: array of Point2D);
begin
  Pt[0].x := StrToFloat(txtX1.Text);
  Pt[1].x := StrToFloat(txtX2.Text);
  Pt[2].x := StrToFloat(txtX3.Text);
  Pt[3].x := StrToFloat(txtX4.Text);
  Pt[0].y := StrToFloat(txtY1.Text);
  Pt[1].y := StrToFloat(txtY2.Text);
  Pt[2].y := StrToFloat(txtY3.Text);
  Pt[3].y := StrToFloat(txtY4.Text);
end;

procedure RotateItemPoints(var Pt: array of Point2D);
begin
  SwapPoints(Pt[0], Pt[3]);
  SwapPoints(Pt[1], Pt[2]);
end;

procedure ReverseItemPoints(var Pt: array of Point2D);
begin
  SwapPoints(Pt[0], Pt[1]);
  SwapPoints(Pt[2], Pt[3]);
end;

procedure TiltItemPoints(var Pt: array of Point2D);
var
  CentrePtX: Double;
  i: Integer;
begin
  CentrePtX := 0;     //find the Y-axis to mirror the item in
  for i:=0 to 3 do
    CentrePtX := CentrePtX + Pt[i].x;
  CentrePtX := CentrePtX / 4;

  for i:=0 to 3 do
    Pt[i].x := 2*CentrePtX - Pt[i].x;   //i.e. CentrePt.x + deltaX

  if Pt[0].x > Pt[1].x then    //keep the item orientation down
    ReverseItemPoints(Pt);
end;

procedure TfrmRectProperties.btnDeleteClick(Sender: TObject);
begin
  DeleteItem(Tag);
  ModalResult := mrIgnore;
end;

//* Tilt the other way, by mirroring points in the centre line
procedure TfrmRectProperties.btnFlipClick(Sender: TObject);
begin
  if (Tag = 0) then
    exit;

  with TrussRects.Item[Tag] do
  begin
    GetTextboxValues(Pt);
    TiltItemPoints(Pt);
    SetTextboxValues(Pt);
  end;
  frmMain.FormPaint(nil);
  TextboxesModified;
end;

{  Rotates 90 degrees
procedure TfrmRectProperties.btnRotate90Click(Sender: TObject);
var
  RotateMatrix: Matrix2D;
  Pt: array[1..4]of Point2D;
  Centre: Point2D;
  i: Integer;
  V: Vector2D;
  d: Double;
begin
  GetTextboxValues(Pt);

  Centre := THE_ORIGIN;
  for i:=1 to 4 do
  begin
    Centre.x := Centre.x + Pt[i].x;
    Centre.y := Centre.y + Pt[i].y;
  end;
  Centre.x := Centre.x / 4;
  Centre.y := Centre.y / 4;
  V := Vector2D(Centre);
  d := LineLength2D(Centre, THE_ORIGIN);

  RotateMatrix := RotateZMatrix2D(90, False);
  for i:=1 to 4 do
  begin
    TranslatePoint(V, -d, Pt[i]);
    Pt[i] := MatrixOp2D(Pt[i], RotateMatrix);
    TranslatePoint(V, d, Pt[i]);
  end;

  SetTextboxValues(Pt);
  TextboxesModified;
end;
}

//* Reverse the winding of the item
//* Swaps Pt[1] and Pt[2]
//* Swaps Pt[3] and Pt[4]
procedure TfrmRectProperties.btnReverseClick(Sender: TObject);
begin
  if (Tag = 0) then
    exit;

  with TrussRects.Item[Tag] do
  begin
    GetTextboxValues(Pt);
    ReverseItemPoints(Pt);
    SetTextboxValues(Pt);
  end;
  frmMain.FormPaint(nil);
  TextboxesModified;
end;

//* Reverse the winding of the item and the flange and lip sides
//* Swaps Pt[1] and Pt[4]
//* Swaps Pt[3] and Pt[2]
procedure TfrmRectProperties.btnRotateClick(Sender: TObject);
begin
  if (Tag = 0) then
    exit;

  with TrussRects.Item[Tag] do
  begin
    GetTextboxValues(Pt);
    RotateItemPoints(Pt);
    SetTextboxValues(Pt);
  end;
  frmMain.FormPaint(nil);
  TextboxesModified;
end;

procedure TfrmRectProperties.FormCreate(Sender: TObject);
begin
  TranslateForm(Self);
end;

procedure TfrmRectProperties.FormShow(Sender: TObject);
var
  p: TPoint;
begin
  p := Mouse.CursorPos;
  SetBounds(p.X - Width div 2, p.Y - Height div 2, Width, Height);
end;

END.
