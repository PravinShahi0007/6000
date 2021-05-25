unit frmPrintPreviewU;

interface

uses
  Windows, Messages, SysUtils,
  Classes, Graphics, Controls,
  Forms, Dialogs, Printers,
  ToolWin, ComCtrls, ExtCtrls,
  ActnList, ImgList, StdCtrls, Buttons;

type
  TfrmPrintPreview = class(TForm)
    sBox: TScrollBox;
    shpShadow: TShape;
    Pic: TImage;
    tool: TToolBar;
    btnZoomIn: TToolButton;
    btnZoomOut: TToolButton;
    btnPrint: TToolButton;
    shpBorder: TShape;
    act: TActionList;
    actZoomIn: TAction;
    actZoomOut: TAction;
    actPrint: TAction;
    Label1: TLabel;
    txtPageNum: TEdit;
    udPageNum: TUpDown;
    lblTotalPages: TLabel;
    cboPrintRange: TComboBox;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    btnSave: TToolButton;
    ToolButton3: TToolButton;
    btnClose: TButton;
    bnPrintsetup: TToolButton;
    ImageList32: TImageList;
    actPrintSetup: TAction;
    procedure btnZoomInClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnZoomOutClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure btnPrintClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PicMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure cboPrintRangeClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actPrintSetupExecute(Sender: TObject);
  private    { Private declarations }
    FStartWidth, FStartHeight: Integer;
    FScale: Double;
    procedure ResizePic(AWidth, AHeight: Integer);
    procedure ScalePic(NewScale: Double);
    procedure CentreScrollbars;
  public     { Public declarations }
    PrinterTitle: string;
    bMagnifyCursor: Boolean;
  end;

var
  frmPrintPreview: TfrmPrintPreview;

implementation

{$R *.DFM}
{$R *.RES}

const
  SHADOW_SIZE=3;
  BORDER_SIZE=1;
  BTN_ZOOM = 1.25;
  SCALE_ZOOM = 1.05;
  crMAGNIFY = 101;

procedure TfrmPrintPreview.ResizePic(AWidth, AHeight: Integer);
var
  L,T: Integer;
begin
  sBox.HorzScrollBar.Position := 0;
  sBox.VertScrollBar.Position := 0;

  sBox.HorzScrollBar.Range := AWidth;
  sBox.VertScrollBar.Range := AHeight;

  L := (sBox.Width - AWidth - SHADOW_SIZE) div 2;
  if L < 0 then
    L := 0;
  T := (sBox.Height- AHeight - SHADOW_SIZE) div 2;
{  if AHeight > sBox.Height then
    T := T - tool.Height div 2; }
  if T < 0 then
    T := 0;

  Pic.SetBounds(L, T, AWidth, AHeight);
  shpShadow.SetBounds(L+SHADOW_SIZE, T+SHADOW_SIZE, AWidth, AHeight);
  shpBorder.SetBounds(L-BORDER_SIZE, T-BORDER_SIZE, AWidth+2*BORDER_SIZE, AHeight + 2*BORDER_SIZE);
  if FStartHeight > 0 then
    FScale := AHeight / FStartHeight;
end;

procedure TfrmPrintPreview.FormResize(Sender: TObject);
var
  W, H: Integer;
begin
  W := Pic.Width;
  H := Pic.Height;
  ResizePic(W, H);
end;

procedure TfrmPrintPreview.btnZoomInClick(Sender: TObject);
var
  W, H: Integer;
begin
  W := Round(Pic.Width * BTN_ZOOM);
  H := Round(Pic.Height * BTN_ZOOM);
  ResizePic(W, H);
  CentreScrollbars;
end;

procedure TfrmPrintPreview.btnZoomOutClick(Sender: TObject);
var
  W, H: Integer;
begin
  W := Round(Pic.Width / BTN_ZOOM);
  H := Round(Pic.Height / BTN_ZOOM);
  ResizePic(W, H);
  CentreScrollbars;
end;

procedure TfrmPrintPreview.CentreScrollbars;
begin
  with sBox.HorzScrollBar do
    Position := (Range - sBox.ClientWidth) div 2;
  with sBox.VertScrollBar do
    Position := (Range - sBox.ClientHeight) div 2;
end;

procedure TfrmPrintPreview.ScalePic(NewScale: Double);
var
  W, H: Integer;
begin
  W := Round(FStartWidth * NewScale);
  H := Round(FStartHeight * NewScale);
  ResizePic(W, H);
end;

procedure TfrmPrintPreview.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  FScale := FScale * SCALE_ZOOM;
  ScalePic(FScale);
  CentreScrollbars;
  Handled := True;
end;

procedure TfrmPrintPreview.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  FScale := FScale / SCALE_ZOOM;
  ScalePic(FScale);
  CentreScrollbars;
  Handled := True;
end;

procedure TfrmPrintPreview.btnPrintClick(Sender: TObject);
//var OldScale: Double;
{var
  OffX, OffY, W, H, dX,dY: Integer;
  ARect: TRect;                       }
var
  i,p: Integer;
begin
  {OldScale := FScale;
  ScalePic(1);          }
  {
  OffX := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETX);
  OffY := GetDeviceCaps(Printer.Handle, PHYSICALOFFSETY);
  W := GetDeviceCaps(Printer.Handle, PHYSICALWIDTH);
  H := GetDeviceCaps(Printer.Handle, PHYSICALHEIGHT);

  dX := (W - Printer.PageWidth) div 2;
  ARect.Left := dX;
  ARect.Right := Printer.PageWidth + dX;

  dY := (H - Printer.PageHeight) div 2;
  ARect.Top := dY;
  ARect.Bottom := Printer.PageHeight + dY;
   }

  p := udPageNum.Position;
  Printer.Title := PrinterTitle;
  Printer.BeginDoc;
  if cboPrintRange.ItemIndex = 0 then   //All Pages
  begin
    for i:=1 to udPageNum.Max do
    begin
      Application.ProcessMessages;
      udPageNum.Position := i;
      with Printer.Canvas do
        StretchDraw(ClipRect, Pic.Picture.Metafile);
      if i < udPageNum.Max then
        Printer.NewPage;
    end;
  end
  else                                  //Current page only
    with Printer.Canvas do
        StretchDraw(ClipRect, Pic.Picture.Metafile);
  Printer.EndDoc;
  udPageNum.Position := p;  // return to viewed page

  //ShowMessage( format('%d, %d, %d, %d', [OffX,OffY,W,H]) );
  //ScalePic(OldScale);
end;

procedure TfrmPrintPreview.actPrintSetupExecute(Sender: TObject);
begin
  with TPrinterSetupDialog.Create(Application) do
  begin
    try
      Execute;
    finally
      Free;
    end;
  end;
end;

procedure TfrmPrintPreview.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrintPreview.FormCreate(Sender: TObject);
const
  PADDING=10;
  FORM_OUTER_SPACE=50;
var
  XFactor, YFactor, Factor: Single;
  L,T,W,H: Integer;
begin
  W := Screen.Width - (FORM_OUTER_SPACE * 2);
  L := FORM_OUTER_SPACE;
  T := FORM_OUTER_SPACE;
  H := Screen.Height - (FORM_OUTER_SPACE * 2);
  SetBounds(L, T, W, H);

  {Size to fit}
  XFactor := (ClientWidth - SHADOW_SIZE - PADDING) / Printer.PageWidth;
  YFactor := (ClientHeight - tool.Height - SHADOW_SIZE - PADDING) / Printer.PageHeight;
  Factor := YFactor;
  if YFactor > XFactor then
    Factor := XFactor;

  FStartWidth := Round(Printer.PageWidth * Factor);   //div 10;
  FStartHeight := Round(Printer.PageHeight * Factor); // div 10;
  ResizePic(FStartWidth, FStartHeight);

  //cboPrintRange.ItemIndex := 0; //All Pages

  try
    Screen.Cursors[crMagnify] := LoadCursor(HInstance, 'MAGNIFY');
  except
    bMagnifyCursor := False;
  end;
end;

procedure TfrmPrintPreview.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP:   if udPageNum.Position < udPageNum.Max then
               udPageNum.Position := udPageNum.Position + 1;
    VK_DOWN: if udPageNum.Position > udPageNum.Min then
               udPageNum.Position := udPageNum.Position - 1;
  end;
end;

procedure TfrmPrintPreview.PicMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  XFraction, YFraction: Double;
begin
  XFraction := X / Pic.Width;
  YFraction := Y / Pic.Height;

  sBox.HorzScrollBar.Position := 0;
  sBox.VertScrollBar.Position := 0;

  case Button of
    mbLeft:  begin
               FScale := FScale * BTN_ZOOM;
               ScalePic(FScale);
             end; //btnZoomInClick(Sender);
    mbRight: begin
               FScale := FScale / BTN_ZOOM;
               ScalePic(FScale);
             end; //btnZoomOutClick(Sender);
  end;

  with sBox.HorzScrollBar do
    Position := Round((Range - sBox.ClientWidth) * XFraction);
  with sBox.VertScrollBar do
    Position := Round((Range - sBox.ClientHeight) * YFraction);
end;

procedure TfrmPrintPreview.FormShow(Sender: TObject);
begin
  case Tag of
    0,1: cboPrintRange.ItemIndex := Tag;
  end;
  try
    if (bMagnifyCursor)and(Screen.Cursors[crMagnify]>0) then
      Pic.Cursor := crMagnify;
  except
    Pic.Cursor := crDefault;
  end;
end;

procedure TfrmPrintPreview.cboPrintRangeClick(Sender: TObject);
begin
  Tag := cboPrintRange.ItemIndex;
end;

end.
