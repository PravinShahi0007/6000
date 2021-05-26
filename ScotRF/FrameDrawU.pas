unit FrameDrawU;

interface

uses
  SysUtils, Windows, classes, GlobalU, Graphics, Gauges, FrameDataU, Units;

const
  Margin = 40;

type
  TGetItemColor = Function(AFrame: TSteelFrame; p:pEntityRecType): TColor of object;

  TFrameDraw = class(TObject)
  private
    FFrame         : TSteelFrame;
    FFocusedEntity : pEntityRecType;
    FDrawItemTitle : Boolean;
    FCanvasRect    : TRect;
    FRect          : TRect;
    FCanvas        : TCanvas;
    FOnGetColour   : TGetItemColor;
    FOrigin        : Point2D; // 2D point at image centre
    FRectCentre    : TPoint; // image centre
    FScale         : Double;
    procedure InitCanvas;
    procedure SetScaleAndOrigin;
    function  Client2Screen(Pt: Point2D): TPoint;
    procedure LineOut(AP1, AP2: Point2D);
    procedure Circle(APt: Point2D; ARadius: integer; AColor: TColor);
    procedure Square(APt: Point2D; ARadius: integer; AColor: TColor);
    procedure TextOutAtP(APt: Point2D; Caption: string; dy: integer=0);
    procedure SquareUnder(APt: Point2D; ARadius: integer; AColor: TColor);
    procedure DrawEntity(pEntity: pEntityRecType);
    function  GetEntityPoints(Ent: pEntityRecType): RectType;
    procedure Initialise(ACanvas: TCanvas; R: TRect);
    procedure DrawCaption(Aent: pEntityRecType);
    procedure TextOut(s: string; APt: Point2D);
    procedure SetPen(AColour: TColor; AStyle: tpenstyle; AWidth: integer);
    procedure SetFont(AColor:TColor=clblack; ASize:integer=8; AStyle: TFontStyles=[]); overload;
    procedure SetFont(AColor:TColor; AStyle: TFontStyles=[]); overload;
    procedure doDrawStructure(ACanvas: TCanvas; R: TRect; AOnGetColour: TGetItemColor);
    procedure DrawItem(p: pEntityRecType);
    procedure DrawOperations(pEnt: pEntityRecType);
  public
    Constructor Create(AFrame: TSteelFrame; AEnt: pEntityRecType=nil; APreview: boolean=false);
    Class Procedure DrawFrameStructure(AFrame: TSteelFrame; AEntity: pEntityRecType; APreview: boolean;ACanvas: TCanvas; R: TRect; AOnGetColour: TGetItemColor); static;
    Class Procedure FillRect(ACanvas: TCanvas; R: TRect); static;
    Class Function  ItemAtPoint(APt: TPoint; AFrame: TSteelFrame; ACanvas: TCanvas; R: TRect): pEntityRecType;
  end;

implementation

uses
  USettings, UtilsU, Math, strUtils, ScotRFTypes;

{ TFrameDraw }

Class Procedure TFrameDraw.DrawFrameStructure(AFrame: TSteelFrame; AEntity: pEntityRecType; APreview: boolean; ACanvas: TCanvas; R: TRect; AOnGetColour: TGetItemColor);
var
  aFrameDraw : TFrameDraw;
begin
  aFrameDraw := TFrameDraw.Create(AFrame, AEntity, APreview);
  try
    aFrameDraw.doDrawStructure(ACanvas, R, AOnGetColour);
    if APreview then
      AFrame.ForEachItem(aFrameDraw.DrawEntity);
  finally
    FreeAndNil(aFrameDraw);
  end;
end;

Class Function TFrameDraw.ItemAtPoint(APt: TPoint; AFrame: TSteelFrame; ACanvas: TCanvas; R: TRect):pEntityRecType;
var
  FD: TFrameDraw;
  Res: pEntityRecType;
  Pt2D: Point2D;
begin
  // mouse hit test
  FD := TFrameDraw.Create(AFrame);
  FD.Initialise(ACanvas, R);
  try
    Res:=nil;
    Pt2D.x:=Apt.x;
    Pt2D.y:=Apt.y;
    AFrame.ForEachItem(procedure (pEntity: pEntityRecType)
                       var corners: RectType;
                       begin
                         if (Res=nil) then
                         begin
                           corners:= FD.getEntityPoints(pEntity);
                           if IsInRect(corners,Pt2D) then
                             Res := pEntity;
                           end;
                         end);
  finally
    FD.Free;
  end;
  Result := Res;
end;

Class Procedure TFrameDraw.FillRect(ACanvas: TCanvas; R: TRect);
var
  x : Integer;
  y : Integer;
  w : Integer;
const
  text = 'www.scottsdalesteelframes.com';
begin
  with ACanvas do
  begin
    Font.Size  :=22;
    Font.Color := $2C8573;
    ACanvas.Font.Name :='Segoe UI Semibold';
    w := TextWidth(text);
    x := (R.Right -r.Left - w ) div 2;
    y := (R.Bottom-R.Top) div 2;
    If x<2 Then
      x:=2;
    TextOut(x,y,text);
    Font.Size  := 8;
    Font.Color := clBlack;
  end;
end;

Constructor TFrameDraw.Create(AFrame: TSteelFrame; AEnt: pEntityRecType; APreview: boolean);
begin
  FFrame         := AFrame;
  FFocusedEntity := AEnt;
  FDrawItemTitle := APreview;
end;

procedure TFrameDraw.Initialise(ACanvas: TCanvas; R: TRect);
begin
  FRect := R;
  FCanvasRect := R;
  FCanvas := ACanvas;
  inflateRect(FRect,-Margin,-Margin);
  SetScaleAndOrigin;
end;

procedure TFrameDraw.DrawCaption(Aent: pEntityRecType) ;
var
  Caption, sLength: string;
begin
  Caption := FFrame.FrameName;
  if assigned(FFocusedEntity) and (FFocusedEntity.Truss = FFrame.FrameName) then
  begin
    Caption := Caption + format(' %d %s', [FFocusedEntity.ID,  copy(FFocusedEntity.Item,1,2)]);
    if FDrawItemTitle then
    begin
      if NOT G_Settings.general_metric then
        sLength:=UnitsOut(intToStr(round(FFocusedEntity.Len)))
      else
        sLength:=FloatToStrF(FFocusedEntity.Len,ffNumber,9,0)+' mm';
      Caption := Caption + ' ' + sLength;
    end;
  end;
  SetFont(clBlack,28,[fsBold]);
  FCanvas.TextOut(10, 10, Caption);
  SetFont;
end;

procedure TFrameDraw.doDrawStructure(ACanvas: TCanvas; R: TRect; AOnGetColour: TGetItemColor);
begin
  FRect := R;
  FCanvasRect := R;
  FCanvas := ACanvas;
  FOnGetColour := AOnGetColour;
  InitCanvas;
  inflateRect(FRect,-Margin,-Margin);
  SetScaleAndOrigin;
  SetFont;
  if assigned(FFocusedEntity) and (FFrame.FrameName = FFocusedEntity.Truss) then
    DrawCaption(FFocusedEntity)  // entity details in caption
  else
    DrawCaption(nil); //Fram name (only) in caption

  FFrame.ForEachItem(DrawItem);
  FFrame.ForEachItem(DrawOperations);
end;

procedure TFrameDraw.DrawOperations(pEnt: pEntityRecType);
var
  Operation: OpType;
  Caption, s: string;
  i, BearingRad,  Radius, W, ServiceRad2: Integer;
  Color: TColor;
  p: TPoint;
  bShowConnections: Boolean;
begin
  // Connector and Bearing circle sizes - scalable
  FCanvas.pen.width:=2;
  Radius := round( FScale * pEnt^.Web / 2 ) ;
  BearingRad := Radius;

  {$IFDEF TRUSS}
    bShowConnections := G_Settings.tstructure_specialcons;
  {$ELSE}
    bShowConnections := True;    // for the C-Section trusses
  {$ENDIF}

  ServiceRad2:=FCanvas.TextWidth('X'); // service circle size - fixed
  for i := 1 to pEnt^.OpCount do
  begin
    Operation := pEnt^.Op[i];
    Caption := '';
    case Operation.Kind of
      okServ1:                // plumbing - 1/2 size
        if G_Settings.Pstructure_showservice then
          Circle(Operation.p, ServiceRad2  div 2, clblue);
      okServ2:
        if G_Settings.Pstructure_showservice then
          Circle(Operation.p, ServiceRad2, clRed);
      okIns:
        if bShowConnections then
          Circle(Operation.p, ServiceRad2, clRed);
      okCon1:                 // connectors
        if bShowConnections then
        begin
          FCanvas.Brush.Color :=clWebFirebrick;
          Circle(Operation.p, Radius, clRed);
          FCanvas.Brush.Color := clWhite;
        end;
      okScr, okScb:           // connectors (# screws / teks)
        if G_Settings.tstructure_screws then
        begin
          Caption := inttostr(Operation.num) + ifthen(Operation.Kind = okScb, 'B', '');
          SetFont(clRED,[fsBold]);
          TextOutAtP(Operation.p, Caption, -20); // centred text-out above connection
          SetFont;
        end;
      okBrA, okBrB, okBrC:    // bearings - possibly unnecessary
        if bShowConnections then
        begin
          Color:=clBlack;
          case Operation.Kind of
            okBrA: Color := clgreen;
            okBrB: Color := clblue;
            okBrC: Color := clRed;
          end;
          SquareUnder(Operation.p, BearingRad, Color);
          // Caption := inttostr(Operation.num);
          // W := FCanvas.TextWidth(Caption);
          // p := Client2Screen(Operation.p);
          // FCanvas.TextOut(p.X - W div 2, p.Y + BearingRad * 3 , Caption); // text under operation
        end;
      okBrace:
        if bShowConnections then
          Square(Operation.p, Radius, clBlack);
      okPC:
        if bShowConnections then
        begin
          Caption := format('PC %4.2f', [Operation.num / 1000]);
          W := FCanvas.TextWidth(Caption);
          p := Client2Screen(Operation.p);
          FCanvas.TextOut(p.X - W div 2, p.Y - 6, Caption); // centre text on operation
        end;
      ok4Rivet, ok2Rivet2Tek, ok2Rivet4Tek:   // not ok2Rivet, it's standard
        if bShowConnections then
        begin
          s := '4R';
          case Operation.Kind of
            ok2Rivet2Tek: s := '2R+2T';
            ok2Rivet4Tek: s := '2R+4T';
          end;
          W := FCanvas.TextWidth(s);
          p := Client2Screen(Operation.p);
          FCanvas.TextOut(p.X - W div 2, p.Y - 6, s); // centre text on operation
        end;
    end;
  end;
end;


function TFrameDraw.getEntityPoints(Ent: pEntityRecType): RectType;
var
  ScreenPoint: tPoint;
  i: integer;
begin
  for i:=1 to 4 do
  begin
    ScreenPoint:= Client2Screen(Ent^.Pt[i]);
    // convert PT (integer x,y) to Pt2D(double x,y)
    result.Pt[i].x := ScreenPoint.x; // int -> double
    result.Pt[i].y := ScreenPoint.y; // int -> double
  end;
end;

procedure TFrameDraw.DrawItem(p: pEntityRecType);
var
  linewidth, baseWidth: integer;
begin
  if p^.isBoxDbl then
  begin
    linewidth := 3;
    baseWidth := 3;
  end
  else
  begin
    linewidth := 1;
    baseWidth := 2;
  end;

  if p = FFocusedEntity then
  begin
    linewidth := 2;
    baseWidth := 2;
  end;

  FCanvas.Pen.Width := baseWidth;
  FCanvas.Pen.color := FOnGetColour(FFrame, p);

  with p^ do
  begin
    LineOut(Pt[1], Pt[2]);
    FCanvas.Pen.Width := linewidth;
    LineOut(Pt[2], Pt[3]);
    LineOut(Pt[3], Pt[4]);
    LineOut(Pt[4], Pt[1]);
  end;
end;

procedure TFrameDraw.DrawEntity(pEntity: pEntityRecType);
var
  pt2D   : Point2D;
  Sz     : TSize;
  P      : TPoint;
  text   : String;
  oldTA  : Cardinal;
  Offset : Double;
begin
  text  := IntToStr(pEntity^.ID);
  Sz    := FCanvas.TextExtent(text);
  FCanvas.Font.Style  :=[fsBold];
  with pEntity^ do
  begin
    if SameValue(pt[1].x , pt[2].x, 2) then // if vertical
    begin
      // vertical label @ 55mm from bottom end
      pt2D.x := pt[1].x;
      if pEntity^.Len<200 then
        Offset:=pEntity^.Len/5
      else
        Offset:=55;
      pt2D.y := minvalue([pt[1].y , pt[2].y, pt[3].y, pt[4].y]) + Offset;
      p := Client2Screen(pt2D);
      FCanvas.font.orientation:=900;
      if pt[1].x < pt[4].x then
      begin
        oldTA:=setTextAlign(FCanvas.Handle, TA_TOP or TA_LEFT);
      end
      else
      begin
        oldTA:=setTextAlign(FCanvas.Handle, TA_Bottom or TA_LEFT);
      end;
      try
        FCanvas.TextOut(p.X, p.Y , text);
      finally
        FCanvas.font.orientation:=0;
        setTextAlign(FCanvas.Handle, oldTA);
      end;
    end else
    begin
      // Horizontal label @ frame center
      pt2D := midPoint2D(pt[1], pt[3]);
      p := Client2Screen(pt2D);
      FCanvas.TextOut(p.X - sz.cx div 2 , p.Y - sz.cy div 2 , text);
    end;
  end;

  FCanvas.font.Style  :=[ ];
end;

procedure TFrameDraw.SetScaleAndOrigin;
var xrange, yrange: Double;
  W, H: integer;
begin
  with FFrame do
  begin
    FOrigin.X := (xmax + xmin)/ 2;
    FOrigin.Y := (ymax + ymin)/ 2;
    xrange := abs(xmax - xmin);
    yrange := abs(ymax - ymin);
  end;
  W := FRect.Right - FRect.Left;
  H := FRect.Bottom - FRect.Top;
  FRectCentre := Point(FRect.Left + W div 2, FRect.Top + H div 2); // image centre
  FScale := min(W / xrange, H / yrange);
end;

procedure TFrameDraw.SetFont(AColor:TColor; ASize:integer; AStyle: TFontStyles);
begin
  FCanvas.Font.Color := AColor;
  FCanvas.Font.Size  := ASize;
  FCanvas.Font.Style := AStyle;
end;

procedure TFrameDraw.SetFont(AColor: TColor; AStyle: TFontStyles);
begin
  FCanvas.Font.Color := AColor;
  FCanvas.Font.Style := AStyle;
end;

procedure TFrameDraw.SetPen(AColour: TColor; AStyle: tpenstyle; AWidth: integer);
begin
  FCanvas.Pen.Width := AWidth;
  FCanvas.Pen.style := AStyle;
  FCanvas.Pen.color := AColour;
end;

procedure TFrameDraw.InitCanvas;
begin
//  FCanvas.brush.color := clWhite;    -DELETED Use brush color set by caller
  FCanvas.Pen.color := clBlack;
  FCanvas.Pen.Width := 1;
  FCanvas.FillRect(FCanvasRect);
  FCanvas.font.name:='Arial';
end;

procedure TFrameDraw.LineOut(AP1, AP2: Point2D);
// Display line from real-world coordinates
var
  p1, p2: TPoint;
begin
  p1 := Client2Screen(AP1);
  p2 := Client2Screen(AP2);
  FCanvas.MoveTo(p1.X, p1.Y);
  FCanvas.LineTo(p2.X, p2.Y);
end;

procedure TFrameDraw.TextOut(s: string; APt: Point2D);
var
  p: TPoint;
begin
  // default alignment:  top-left of text
  p := Client2Screen(APt);
  FCanvas.TextOut(p.X, p.Y, s)
end;

function TFrameDraw.Client2Screen(Pt: Point2D): TPoint;
// Convert from real-world coordinates to screen coordinates
begin
  Result.X := FRectCentre.X + round(FScale * (Pt.X - FOrigin.X));
  Result.Y := FRectCentre.Y - round(FScale * (Pt.Y - FOrigin.Y));
end;

procedure TFrameDraw.TextOutAtP(APt: Point2D; Caption: string; dy: integer);   // centred text-out
var Sz: TSize;
  P: TPoint;
begin
  Sz := FCanvas.TextExtent(Caption);
  p := Client2Screen(APt);
  FCanvas.TextOut(p.X - sz.cx div 2, p.Y + dy - sz.cy div 2 , Caption); // centre text on operation
end;

procedure TFrameDraw.Circle(APt: Point2D; ARadius: integer; AColor: TColor);
// Display circle from real-world coordinates and canvas radius
var
  p: TPoint;
begin
  FCanvas.Pen.color := AColor;
  p := Client2Screen(APt);
  FCanvas.Ellipse(p.X - ARadius, p.Y - ARadius, p.X + ARadius, p.Y + ARadius);
end;

procedure TFrameDraw.Square(APt: Point2D; ARadius: integer; AColor: TColor);
var
  p: TPoint;
begin
  FCanvas.Pen.Color := AColor;
  p := Client2Screen(APt);
  FCanvas.Rectangle(p.X - ARadius, p.Y - ARadius, p.X + ARadius, p.Y + ARadius);
end;

procedure TFrameDraw.SquareUnder(APt: Point2D; ARadius: integer; AColor: TColor);
var
  p: TPoint;
begin
  FCanvas.Pen.Color := AColor;
  p := Client2Screen(APt);
  FCanvas.Rectangle(p.X - ARadius, p.Y , p.X + ARadius, p.Y + ARadius*2);
end;

end.

