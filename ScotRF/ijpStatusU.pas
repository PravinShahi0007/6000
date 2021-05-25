unit ijpStatusU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, ImgList, ScotRFTypes, System.ImageList;

type
  TInkjetStatus = class(TFrame)
    StatusImagesPrinter: TImageList;
    Panel1: TPanel;
    uxCaption: TLabel;
    uxIJPLight: TImage;
    uxStatus1: TLabel;
    uxStatus2: TLabel;
    uxItem: TLabel;
    Label1: TLabel;
  private
    FMinInk: Double;
    procedure SetStatusLight(const Value: TStatusLight);
    function getLine(Index: integer): String;
    procedure setLine(Index: integer; const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    function getStatusLightBmp(const Value: TStatusLight): TBitMap;
    property StatusLight: TStatusLight write SetStatusLight;
    procedure SetInkStatus(v1,v2: double );
    property  MinInk: Double read FMinInk;
    property Line[Index: integer]: string read getLine write setLine;
  end;

implementation

uses  math;
{$R *.dfm}
{ TInkjetStatus }

constructor TInkjetStatus.Create(AOwner: TComponent);
begin
  inherited;
  uxCaption.Caption := '';
  uxStatus1.Caption := '';
  uxStatus2.Caption := '';
  uxItem.Caption := '';
  FMinInk := 100;
end;

function TInkjetStatus.getLine(Index: integer): String;
begin
  case Index of
    0: result := uxCaption.Caption;
    1: result := uxStatus1.Caption;
    2: result := uxStatus2.Caption;
    3: result := uxItem.Caption;
  end;
end;

procedure TInkjetStatus.setLine(Index: integer; const Value: String);
begin
  case Index of
    0: uxCaption.Caption := Value;
    1: uxStatus1.Caption := Value;
    2:
      begin
       uxStatus2.Caption := Value;
       uxStatus2.Font.Style := [];
       uxStatus2.Font.Color := clBlack;
      end;
    3: uxItem.Caption := Value;
  end;
  invalidate;
  Repaint;
end;

procedure TInkjetStatus.SetInkStatus(v1,v2: double );
begin
  FMinInk := min(V1,V2);
  uxStatus2.Caption := Format('Ink remaining %2.1f%% %2.1f%%',[v1,v2]);
  if FMinInk< 10.0 then
  begin
    uxStatus2.Font.Style := [fsBold];
    uxStatus2.Font.Color := clRed;
  end else
  begin
    uxStatus2.Font.Style := [];
    uxStatus2.Font.Color := clBlack;
  end;
  invalidate;
  Repaint;
end;

function TInkjetStatus.getStatusLightBmp(const Value: TStatusLight): TBitMap;
begin
  Result := TBitmap.Create;
  StatusImagesPrinter.GetBitmap(ord(Value), Result);
end;

procedure TInkjetStatus.SetStatusLight(const Value: TStatusLight);
var Bmp: tBitmap;
begin
  Bmp := getStatusLightBmp(Value);
  try
    uxIJPLight.Picture.Bitmap.assign(Bmp);
    uxIJPLight.Hint := StatusHint[Value];
  finally
    Bmp.free;
  end;
  invalidate;
  Repaint;
end;

end.
