unit PreviewU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, ImgList, Dialogs,
  math, menus, strUtils, ScotRFTypes, GlobalU, FrameDataU, FrameDrawU, jpeg;

type
  TPreviewForm = class(TForm)
    ToolPanel: TPanel;
    bnClose: TSpeedButton;
    Image1: TImage;
    bnNext: TSpeedButton;
    PaintBox1: TPaintBox;
    StatusBar1: TStatusBar;
    bnPrev: TSpeedButton;
    bnRunOne: TSpeedButton;
    procedure PaintBox1Paint(Sender: TObject);
    procedure bnNextClick(Sender: TObject);
    procedure bnPrevClick(Sender: TObject);
    procedure bnCloseClick(Sender: TObject);
    procedure bnRunOneClick(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  private
    FrameSelection: TFrameSelection;
    FCurrentFrame: Integer; // index
    FSelectedItem: pEntityRecType;
    procedure SetCurrentFrame(const Value: Integer);
    function GetItemColor(AObject: TFrameDraw; AFrame: TSteelFrame; p: pEntityRecType): TColor;
    property CurrentFrame: Integer read FCurrentFrame write SetCurrentFrame;
  public
//    class function ShowFrames(AFrameSelection: TFrameSelection): boolean;
    constructor Create(AOwner: TComponent; AFrameSelection: TFrameSelection); Reintroduce;
    function isSelected(AFrame: TSteelFrame; Arg1: pEntityRecType): Boolean;

  end;
const mrRunFrame=101;

implementation

{$R *.DFM}

{ TPreviewForm }
constructor TPreviewForm.Create(AOwner: TComponent; AFrameSelection: TFrameSelection);
begin
  inherited  Create(AOwner);
  FrameSelection := AFrameSelection;
  CurrentFrame := 0; // property setter sets buttons etc
  Caption := AppName +' Preview';

end;

function TPreviewForm.isSelected(AFrame: TSteelFrame;Arg1: pEntityRecType): Boolean;
begin
  result := AFrame  = FrameSelection.SelectedFrames[FCurrentFrame];
end;


procedure TPreviewForm.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin
  R := Rect(0, 0, PaintBox1.ClientWidth, PaintBox1.ClientHeight);
  InflateRect(R,-12,-12);
  FSelectedItem := TFrameDraw.ItemAtPoint(point(x,y), FrameSelection.SelectedFrames[FCurrentFrame], PaintBox1.canvas, R);
  Paintbox1.invalidate;
end;

function TPreviewForm.GetItemColor(AObject: TFrameDraw ;AFrame: TSteelFrame; p:pEntityRecType): TColor;
begin
  if p = FSelectedItem then
    exit(clRed);
  Result := clWebDodgerBlue;
end;


procedure TPreviewForm.PaintBox1Paint(Sender: TObject);
var
  R: TRect;
  F: TSteelFrame;
begin
  R := Rect(0, 0, PaintBox1.ClientWidth, PaintBox1.ClientHeight);
  PaintBox1.canvas.Brush.color := clCream;
  PaintBox1.canvas.Brush.style := bsSolid;
  PaintBox1.canvas.FillRect(R);
  InflateRect(R,-12,-12);
  F := FrameSelection.SelectedFrames[FCurrentFrame];
  TFrameDraw.DrawStructure2(F, FSelectedItem, True, PaintBox1.canvas,  R, GetItemColor);
end;

procedure TPreviewForm.SetCurrentFrame(const Value: Integer);
begin
  if (Value >= 0) and (Value < FrameSelection.SelectedFrames.Count) then
    FCurrentFrame := Value;
  bnPrev.Enabled := FCurrentFrame > 0;
  bnNext.Enabled := FCurrentFrame < pred(FrameSelection.SelectedFrames.Count);
  StatusBar1.panels[0].text := FrameSelection.SelectedFrames[FCurrentFrame].FrameName;
  StatusBar1.panels[1].text := format('%d of %d',[FCurrentFrame + 1, FrameSelection.SelectedFrames.Count]);
  Invalidate;
end;

procedure TPreviewForm.bnNextClick(Sender: TObject);
begin
  SetCurrentFrame(succ(FCurrentFrame));
end;

procedure TPreviewForm.bnPrevClick(Sender: TObject);
begin
  SetCurrentFrame(pred(FCurrentFrame));
end;

procedure TPreviewForm.bnRunOneClick(Sender: TObject);
begin
  ModalResult := mrRunFrame;
end;


procedure TPreviewForm.bnCloseClick(Sender: TObject);
begin
  close;
end;

END.
