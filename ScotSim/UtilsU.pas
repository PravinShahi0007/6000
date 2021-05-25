unit UtilsU;

{
Utility routines includes:
        geometry, vectors, display and sorting routines
}

interface

uses
  Windows,
  //Messages,
  //SysUtils,
  //Classes,
  Graphics,
  OpenGL,
  GlobalU,
  Math;

  procedure SetOGLColorBytes(R,G,B: GLubyte);
  procedure SetOGLColor(fR,fG,fB: GLfloat); overload;
  procedure SetOGLColor(AColor: TColor); overload;

  function PointsAreSame(p1,p2: Point2D): Boolean;
  procedure Draw2DStippledLine(Pt1, Pt2: Point2D; r,g,b: Single);
  procedure DrawPoint(p: Point2D);
  procedure Draw2DCircle(Centre: Point2D; Radius: Double; nSegments: Word=36);
  procedure Draw2DCircleWithCross(Centre: Point2D; Radius: Double; nSegments: Word=36);
  //procedure DrawFilled2DCircle(Centre: Point2D; Radius: Double; nSegments: Word);
  procedure DrawSquare(p: Point2D; r,g,b: Byte; ASize: GLFloat);
  procedure CADQuad(p: array of Point2D); {overload;
  procedure CADQuad(p: array of Point2D; r,g,b: Byte); overload;}
  //procedure CADFillRectWithHalfToneStipple(p: array of Point2D);
  procedure Draw2DLines(p: array of Point2D);
  procedure Draw2DLine(Pt1, Pt2: Point2D); overload;
  procedure Draw2DLine(ALine: LineType2D); overload;
  //procedure Draw2DLine(Pt1, Pt2: Point2D; r,g,b: Byte); overload;
  //procedure Draw2DLine(ALine: LineType; r,g,b: Byte); overload;
  procedure Draw2DLine(Pt1, Pt2: Point2D; AColor: TColor); overload;

  procedure SwapPoints(var p,q: Point2D);
  function MidPoint2D(Pt1, Pt2: Point2D): Point2D; overload;
  function MidPoint2D(Aline: LineType2D): Point2D; overload;
  function LineLength2D(Pt1, Pt2: Point2D): Double; overload;
  function LineLength2D(ALine: LineType2D): Double; overload;
  procedure TranslatePoint(V: Vector2D; d: Double; var p: Point2D);
  procedure TranslateLine(V: Vector2D; d: Double; var Line: LineType2D);
  function FindIntercept(L1P1, L1P2, L2P1, L2P2: Point2D; var Pt: Point2D): Boolean; overload;
  function FindIntercept(L1, L2: LineType2D; var Pt: Point2D): Boolean; overload;
  function IsInRect(p1,p2,p3,p4, Pt: Point2D): Boolean; overload;
  function IsInRect(ARect: RectType; Pt: Point2D): Boolean; overload;
  function IsInOrOnRect(p1,p2,p3,p4, Pt: Point2D; Tol: double=0.1): Boolean; overload;
  function IsInOrOnRect(ARect: RectType; Pt: Point2D; Tol: double=0.1): Boolean; overload;
  function LineSlope(x1,y1,x2,y2: Double): Double;
  function PointOnLine(L1,L2,Pt: Point2D; tol: Double): Boolean; overload;
  function PointOnLine(ALine: LineType2D; Pt: Point2D; tol: Double): Boolean; overload;
  function Between(n,n1,n2: Extended; tol: Double): Boolean;
  function PerpDistance(Pt1,Pt2,Pt: Point2D): Double; overload;
  function PerpDistance(ALine: LineType2D; Pt: Point2D): Double; overload;
  function PerpDistanceToLine(Pt1,Pt2,Pt: Point2D): Double; overload;
  function PerpDistanceToLine(ALine: LineType2D; Pt: Point2D): Double; overload;
  function LineDirectionRadians(Pt1, Pt2: Point2D): Extended; overload;
  function LineDirectionRadians(ALine: LineType2D): Extended; overload;
  function AngleFromHorizontal(Pt1, Pt2: Point2D): Extended;

  function Vector2DFrom2DPoints(Pt1, Pt2: Point2D): Vector2D;
  function Vector2DMagnitude(AVector:Vector2D): Double;
  function Normalize2D(AVector: Vector2D): Vector2D;
  function ScaleVector2D(V: Vector2D; Factor: Double): Vector2D;
  function DotProduct2D(V1,V2: Vector2D): Double;

  function Point2DFromParametricEquation(StartPt: Point2D; V: Vector2D; u: Double): Point2D;
  function ClosestPtOn2DLine(LinePt1, LinePt2, FromPt: Point2D): Point2D; overload;
  function ClosestPtOn2DLine(ALine: LineType2D; FromPt: Point2D): Point2D; overload;
  function AngleBetweenVectors(V1, V2: Vector2D; DegreesWanted: Boolean): Extended;
  function AngleBetweenLines2D(L1, L2: LineType2D; DegreesWanted: Boolean): Extended;
  function PointIsOrigin(p: Point2D): Boolean;
  procedure QuickSort(var A: array of SortPointsType); overload;
  procedure QuickSort(var A: array of Double); overload;

  procedure Snap2ndPtToAngle(Pt1: Point2D; var Pt2: Point2D; fSnapDegrees: Double);

  //function AbsRadians(Radians: Extended): Extended;
  function LinesAreParallel(L1Pt1, L1Pt2, L2Pt1, L2Pt2: Point2D): Boolean; //overload;
  //function LinesAreParallel(L1, L2: LineType): Boolean; overload;
  //function LinesAreParallel(L1, L2: LineType; DegreesTol: Extended): Boolean; overload;
  function ArePerpendicular(Dirn1, Dirn2: Extended): Boolean;
  //function GetOffSets(Pt1, Pt2: Point2D; Amount: Double; var XOff, YOff: Double): Extended;
  procedure OutputDebugString(s: string);

  {
type
  Matrix2D = array[1..2, 1..2]of Extended;

  function RotateZMatrix2D(Angle: Extended; IsRadians: Boolean): Matrix2D;
  function MatrixOp2D(p: Point2D; M: Matrix2D): Point2D;
  procedure RotateAboutPoint(var p: Point2D; Centre: Point2D; Angle: Extended; IsRadians: Boolean);
  }

implementation
     {
var
  HalfToneMask: array[0..127]of GLubyte = (
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55,
                 $AA, $AA, $AA, $AA, $55, $55, $55, $55
                 );      }

procedure SetOGLColorBytes(R,G,B: GLubyte);
begin
  SetOGLColor(R / 255, G / 255, B / 255);
  // or use ...
  //glColor3ub(R,G,B);
  // ... but this may have been causing display issues on some machines (e.g. Grant's laptop)
end;

procedure SetOGLColor(fR,fG,fB: GLfloat);
var  ambient: array[0..3] of glFloat;
begin
  {glColor3f(fR,fG,fB);                  }
  ambient[0] := fR;
  ambient[1] := fG;
  ambient[2] := fB;
  ambient[3] := 1.0;
  glMaterialfv(GL_FRONT, GL_AMBIENT, @ambient);
end;

procedure SetOGLColor(AColor: TColor);
var
  R,G,B: Byte;
begin
  R := GetRValue(AColor); G := GetGValue(AColor); B := GetBValue(AColor);
  SetOGLColorBytes(R,G,B);
end;

function PointsAreSame(p1,p2: Point2D): Boolean;
begin
  Result := (Round(p1.x-p2.x)=0)and(Round(p1.y-p2.y)=0);
end;

procedure Draw2DStippledLine(Pt1, Pt2: Point2D; r,g,b: Single);
const
  factor = 1;
  pattern= $C3C3;  //also medium = $F0F; but starts with a line not a space
  //tiny spaces = $5555; large spaces = $FF;  //see p96 OpenGL SuperBible
begin
  glEnable(GL_LINE_STIPPLE);
  glLineStipple(factor, pattern);
  glLineWidth( 1 );
  SetOGLColor(r, g, b);
  Draw2DLine(Pt1, Pt2);
  glDisable(GL_LINE_STIPPLE);
end;

procedure DrawPoint(p: Point2D);
begin
  glBegin(GL_POINTS);
    glVertex4d(p.x, p.y, 0, Scale);
  glEnd;
end;

procedure Draw2DCircle(Centre: Point2D; Radius: Double; nSegments: Word=36);
var
  theta, a: Extended;
  p: Point2D;
  i: Word;
begin
  if nSegments=0 then
    exit;
  theta := 2*pi/nSegments;
  glBegin(GL_LINE_LOOP);
  for i:=0 to pred(nSegments)do
  begin
    a := i*theta;
    p.x := Centre.x + Radius*Cos(a);
    p.y := Centre.y + Radius*Sin(a);
    glVertex4d(p.x, p.y, 0, Scale);
  end;
  glEnd;
end;

procedure Draw2DCircleWithCross(Centre: Point2D; Radius: Double; nSegments: Word=36);
var
  theta, a: Extended;
  p: Point2D;
  i: Word;
begin
  if nSegments=0 then
    exit;
  theta := 2*pi/nSegments;
  glBegin(GL_LINE_LOOP);
  for i:=0 to pred(nSegments)do
  begin
    a := i*theta;
    p.x := Centre.x + Radius*Cos(a);
    p.y := Centre.y + Radius*Sin(a);
    glVertex4d(p.x, p.y, 0, Scale);
  end;
  glEnd;
  glBegin(GL_LINES);
    glVertex4d(Centre.x - Radius, Centre.y, 0, Scale);
    glVertex4d(Centre.x + Radius, Centre.y, 0, Scale);
    glVertex4d(Centre.x, Centre.y - Radius, 0, Scale);
    glVertex4d(Centre.x, Centre.y + Radius, 0, Scale);
  glEnd;
end;
          {
procedure DrawFilled2DCircle(Centre: Point2D; Radius: Double; nSegments: Word);
var
  theta, a: Extended;
  p: Point2D;
  i: Word;
begin
  if nSegments<3 then
    exit;
  theta := 2*pi/nSegments;
  glBegin(GL_POLYGON);
  for i:=0 to pred(nSegments) do
  begin
    a := i*theta;
    p.x := Centre.x + Radius*Cos(a);
    p.y := Centre.y + Radius*Sin(a);
    glVertex4d(p.x, p.y, 0, Scale);
  end;
  glEnd;
end;      }

procedure DrawSquare(p: Point2D; r,g,b: Byte; ASize: GLFloat);
var
  d: Double;
  temp: GLFloat;
begin
  glGetFloatv(GL_LINE_WIDTH, @temp);
  glLineWidth(2.5);
  //glBegin(GL_POLYGON);    // <---  filled
  glBegin(GL_LINE_LOOP);
    SetOGLColorBytes(r,g,b);
    //Start at p
    {
    glVertex4d(p.x,         p.y,         0, Scale);
    glVertex4d(p.x + ASize, p.y,         0, Scale);
    glVertex4d(p.x + ASize, p.y - ASize, 0, Scale);
    glVertex4d(p.x,         p.y - ASize, 0, Scale);
    }
    //Centre on p
    d := ASize / 2;
    glVertex4d(p.x - d, p.y + d, 0, Scale);
    glVertex4d(p.x + d, p.y + d, 0, Scale);
    glVertex4d(p.x + d, p.y - d, 0, Scale);
    glVertex4d(p.x - d, p.y - d, 0, Scale);
  glEnd;
  glLineWidth(temp);
end;

//* assumes a multiple of 4 points, but could be a convex polygon
procedure CADQuad(p: array of Point2D);
var
  i: Integer;
begin
  glBegin(GL_TRIANGLE_FAN);        //was glBegin(GL_QUADS);
    for i:=Low(p) to High(p)do
      glVertex4d(p[i].x, p[i].y, 0, Scale);
  glEnd;
end;

//* Polygon really
{  not used currently
procedure CADQuad(p: array of Point2D; r,g,b: Byte);
begin
  SetOGLColorBytes(r,g,b);
  CADQuad(p);
end;
}

procedure Draw2DLines(p: array of Point2D);
var
  i: Integer;
begin
  glBegin(GL_LINES);
    for i:=Low(p) to High(p)do
      glVertex4d(p[i].x, p[i].y, 0, Scale);
  glEnd;
end;

{
procedure CADFillRectWithHalfToneStipple(p: array of Point2D);
begin
  glEnable(GL_POLYGON_STIPPLE);
    glPolygonStipple(@HalfToneMask);                //p.61 OpenGL SuperBible
    CADQuads(p);
  glDisable(GL_POLYGON_STIPPLE);
end;      }

//* Display a line
procedure Draw2DLine(Pt1, Pt2: Point2D);
begin
  glBegin(GL_LINES);
    glVertex4d(Pt1.x, Pt1.y, 0, Scale);
    glVertex4d(Pt2.x, Pt2.y, 0, Scale);
  glEnd;
end;

procedure Draw2DLine(ALine: LineType2D);
begin
  Draw2DLine(ALine.Pt[1], ALine.Pt[2]);
end;

{ // not used currently
procedure Draw2DLine(Pt1, Pt2: Point2D; r,g,b: Byte);
begin
  glLineWidth( 1 );
  SetOGLColorBytes(r,g,b);
  Draw2DLine(Pt1, Pt2);
end;

procedure Draw2DLine(ALine: LineType; r,g,b: Byte);
begin
  Draw2DLine(ALine.Pt[1], ALine.Pt[2], r,g,b);
end;
}

procedure Draw2DLine(Pt1, Pt2: Point2D; AColor: TColor);
begin
  SetOGLColor(AColor);
  Draw2DLine(Pt1, Pt2);
end;

procedure SwapPoints(var p,q: Point2D);
var
  r: Point2D;
begin
  r := p;
  p := q;
  q := r;
end;

function MidPoint2D(Pt1, Pt2: Point2D): Point2D;
begin
  Result.x := (Pt1.x+Pt2.x)/2;
  Result.y := (Pt1.y+Pt2.y)/2;
end;

function MidPoint2D(Aline: LineType2D): Point2D;
begin
  with Aline do
    Result := MidPoint2D(Pt[1], Pt[2]);
end;

function LineLength2D(Pt1, Pt2: Point2D): Double;
begin
  Result := Sqrt( Sqr(Pt1.x-Pt2.x) + Sqr(Pt1.y-Pt2.y) );
end;

function LineLength2D(ALine: LineType2D): Double;
begin
  Result := LineLength2D(ALine.Pt[1], ALine.Pt[2]);
end;

procedure TranslatePoint(V: Vector2D; d: Double; var p: Point2D);
begin
  p := Point2DFromParametricEquation(p, V, d);
end;

procedure TranslateLine(V: Vector2D; d: Double; var Line: LineType2D);
begin
  Line.Pt[1] := Point2DFromParametricEquation(Line.Pt[1], V, d);
  Line.Pt[2] := Point2DFromParametricEquation(Line.Pt[2], V, d);
end;

function FindIntercept(L1P1, L1P2, L2P1, L2P2: Point2D; var Pt: Point2D): Boolean;
{Get the Co-ordinates of the intersection of 2 lines each defined by 2 Pts
 Returns False if lines are parallel or the intercept is too far away}
var
  m1,m2,c1,c2, dX, CheckDist: Double;
begin
  m1 := BIG_DUMMY;                //Gradients
  dX := L1P2.x - L1P1.x;
  if dX <> 0 then
    m1 := (L1P2.y - L1P1.y)/dX;
  m2 := BIG_DUMMY;
  dX := L2P2.x - L2P1.x;
  if dX <> 0 then
    m2 := (L2P2.y - L2P1.y)/dX;
  Result :=  (m2 <> m1);
  if not Result then      //Lines are parallel 0 or infinite intercepts
    exit;
  c1 := L1P1.y - m1*L1P1.x;    //y-axis intercepts
  c2 := L2P1.y - m2*L2P1.x;
  Pt.x := (c2-c1)/(m1-m2);
  Pt.y := (m1*c2-m2*c1)/(m1-m2);

  {Quick Check
   the Intercept isn't miles away from the 1st point of each line}
  CheckDist := LineLength2D(L1P1, Pt);
  Result := CheckDist < BIG_DUMMY;
  if Result then
  begin
    CheckDist := LineLength2D(L2P1, Pt);
    Result := CheckDist < BIG_DUMMY;
  end;
end;

function FindIntercept(L1, L2: LineType2D; var Pt: Point2D): Boolean;
begin
  Result := FindIntercept(L1.Pt[1], L1.Pt[2], L2.Pt[1], L2.Pt[2], Pt);
end;

function PointInPoly2D(APoint : Point2D ; APoly : Point2DArray) : boolean;
Var
  i, j : integer;
  npol : integer;
begin
  Result := false;
  npol := length(APoly);
  for i := 0 to npol - 1 do begin
    j := (i + 1) mod npol;
    if ((((APoly[i].Y <= APoint.Y) and (APoint.Y < APoly[j].Y)) or
         ((APoly[j].Y <= APoint.Y) and (APoint.Y < APoly[i].Y))) and
        (APoint.X < (APoly[j].X - APoly[i].X) * (APoint.Y - APoly[i].Y) /
                    (APoly[j].Y - APoly[i].Y) + APoly[i].X)) then
      Result := not Result;
  end;
end;

//* Returns True if Pt is in Rect
//* Opposite vertices are like WallType, ie p1, p3 and p2, p4
function IsInRect(p1,p2,p3,p4, Pt: Point2D): Boolean;
var Poly: Point2DArray;
begin
  setlength(Poly,4);
  poly[0]:=p1;
  poly[1]:=p2;
  poly[2]:=p3;
  poly[3]:=p4;
  result := PointInPoly2D(Pt,Poly);
end;

function IsInRect(ARect: RectType; Pt: Point2D): Boolean;
begin
  Result := IsInRect(ARect.Pt[1], ARect.Pt[2], ARect.Pt[3], ARect.Pt[4], Pt);
end;

//* Returns True if Pt is in Rect or on its Edges
function IsInOrOnRect(p1,p2,p3,p4, Pt: Point2D; Tol: double=0.1): Boolean;
begin
  Result := IsInRect(p1,p2,p3,p4, Pt) or
            PointOnLine(p1, p2, Pt, tol) or
            PointOnLine(p2, p3, Pt, tol) or
            PointOnLine(p3, p4, Pt, tol) or
            PointOnLine(p4, p1, Pt, tol);
end;

function IsInOrOnRect(ARect: RectType; Pt: Point2D; Tol: double=0.1): Boolean;
begin
  Result := IsInOrOnRect(ARect.Pt[1], ARect.Pt[2], ARect.Pt[3], ARect.Pt[4], Pt);
end;

function LineSlope(x1,y1,x2,y2: Double): Double;
begin
  if abs(x2-x1)<0.001 then result:=BIG_DUMMY else result:= (y2-y1)/(x2-x1);
end;

function PointOnLine(L1,L2,Pt: Point2D; tol: Double): Boolean;
var s: Extended;
begin
s:=LineSlope(L1.x,L1.y, L2.x,L2.y);
if s = BIG_DUMMY then Result:=(abs(Pt.x-L1.x)<=tol) and Between(Pt.y,L1.y,L2.y,tol)
  else if s=0 then Result:=(abs(Pt.y-L1.y)<=tol) and Between(Pt.x,L1.x,L2.x,tol)
    else Result:=((abs(Pt.y-(s*(Pt.x-L1.x)+L1.y))<=tol) or (abs(Pt.x-((Pt.y-L1.y)/s+L1.x))<=tol)) and Between(Pt.y,L1.y,L2.y,tol)
                        and Between(Pt.x,L1.x,L2.x,tol);
end;

function PointOnLine(ALine: LineType2D; Pt: Point2D; tol: Double): Boolean;
begin
  Result := PointOnLine(ALine.Pt[1], ALine.Pt[2], Pt, tol);
end;

function Between(n,n1,n2: Extended; tol: Double): Boolean;
//* True if n is between n1 and n2
begin
  Result := ((n1<=n2)and(n>=n1-tol)and(n<=n2+tol))
                     or((n<=n1+tol)and(n>=n2-tol));
end;

function PerpDistance(Pt1,Pt2,Pt: Point2D): Double;
//* returns the perp. distance from a point Pt to line Pt1-Pt2
var
  s,angle,p:extended;
  x1,y1,x2,y2,x,y: Double;
begin
  x1 := Pt1.x;   y1 := Pt1.y;
  x2 := Pt2.x;   y2 := Pt2.y;
   x := Pt.x;     y := Pt.y;
s:=LineSlope(x1,y1,x2,y2);
angle:=arctan(s)+pi/2;
p:=x1*cos(angle)+y1*sin(angle);
Result:=(x*cos(angle)+y*sin(angle) - p);
end;

function PerpDistance(ALine: LineType2D; Pt: Point2D): Double;
begin
  Result := PerpDistance(ALine.Pt[1], ALine.Pt[2], Pt);
end;

function PerpDistanceToLine(Pt1,Pt2,Pt: Point2D): Double;
//* returns the perp. distance from a point Pt to a Line
//* if the intercept with the line is between L1 and L2
//* otherwise it returns BIG_DUMMY
const
  TOL=2;
var
  s,angle,p:extended;
  x1,y1,x2,y2,x,y, Dist: Double;
  TestPt: Point2D;
begin
  x1 := Pt1.x;   y1 := Pt1.y;
  x2 := Pt2.x;   y2 := Pt2.y;
   x := Pt.x;     y := Pt.y;
  s:=LineSlope(x1,y1,x2,y2);
  angle:=arctan(s)+pi/2;
  p:=x1*cos(angle)+y1*sin(angle);
  Dist:=(x*cos(angle)+y*sin(angle) - p);

  Result := Dist;

  if Angle >= pi/2 then
    TestPt.x := Round(Pt.x + Dist*abs(Cos(Angle)))
  else
    TestPt.x := Round(Pt.x - Dist*abs(Cos(Angle)));
  TestPt.y := Round(Pt.y - Dist*abs(Sin(Angle)));

  //Seems OK, but might need to inc the TOL from 1
  if not PointOnLine(Pt1,Pt2,TestPt,TOL) then
    Result := BIG_DUMMY;
end;

function PerpDistanceToLine(ALine: LineType2D; Pt: Point2D): Double;
begin
  Result := PerpDistanceToLine(ALine.Pt[1], ALine.Pt[2], Pt);
end;

function LineDirectionRadians(Pt1, Pt2: Point2D): Extended;
var
  dX, dY: Double;
begin
  dX := Pt2.x - Pt1.x;
  dY := Pt2.y - Pt1.y;
  if abs(dX) < 0.5 then     //vertical
  begin
    Result := pi/2;
    if (Pt2.y < Pt1.y) then
      Result := -pi/2;
    exit;
  end;
  if abs(dY) < 0.5 then     //horizontal
  begin
    Result := 0;
    if (Pt2.x < Pt1.x) then
      Result := pi;
    exit;
  end;
  Result := ArcTan2(dY, dX);
end;

function LineDirectionRadians(ALine: LineType2D): Extended;
begin
  Result := LineDirectionRadians(ALine.Pt[1], ALine.Pt[2]);
end;

function AngleFromHorizontal(Pt1, Pt2: Point2D): Extended;
var
  dX, dY: Double;
begin
  dX := abs(Pt2.x - Pt1.x);
  dY := abs(Pt2.y - Pt1.y);
  if dX < 0.5 then     //vertical
  begin
    Result := pi/2;
    exit;
  end;
  if dY < 0.5 then     //horizontal
  begin
    Result := 0;
    exit;
  end;
  Result := ArcTan(dY/dX);
end;


{********* Vector Utils **************}

function DotProduct2D(V1,V2: Vector2D): Double;
begin
  Result := (V1.x * V2.x) + (V1.y * V2.y);
end;

function Vector2DFrom2DPoints(Pt1, Pt2: Point2D): Vector2D;
begin
  Result.x := Pt2.x - Pt1.x;
  Result.y := Pt2.y - Pt1.y;
end;

function Vector2DMagnitude(AVector:Vector2D): Double;
begin
  Result := Sqrt( Sqr(AVector.x) + Sqr(AVector.y) );
end;

function Normalize2D(AVector: Vector2D): Vector2D;
var
  M: Double;
begin
  M := Vector2DMagnitude(AVector);
  if M = 0 then
    M := 1;
  Result.x := AVector.x / M;
  Result.y := AVector.y / M;
end;

//* Change the length of the vector
//* if factor is -1 the direction of the vector is reversed
function ScaleVector2D(V: Vector2D; Factor: Double): Vector2D;
begin
  Result.x := V.x * Factor;
  Result.y := V.y * Factor;
end;

function Point2DFromParametricEquation(StartPt: Point2D; V: Vector2D; u: Double): Point2D;
         { note: V gets normalised here
                 u is the Length, instead of the parametric equation parameter}
begin
  V := Normalize2D(V);
  Result.x := StartPt.x + u * V.x;
  Result.y := StartPt.y + u * V.y;
end;

function ClosestPtOn2DLine(LinePt1, LinePt2, FromPt: Point2D): Point2D;
var
  v12, v13: Vector2D;
  u: Double;              //parametric equation parameter
begin
  v12 := Vector2DFrom2DPoints(LinePt1, LinePt2);
  v13 := Vector2DFrom2DPoints(LinePt1, FromPt);
  u := DotProduct2D(v12, v13) / Vector2DMagnitude(v12);
  Result := Point2DFromParametricEquation(LinePt1, v12, u);
end;

function ClosestPtOn2DLine(ALine: LineType2D; FromPt: Point2D): Point2D;
begin
  Result := ClosestPtOn2DLine(ALine.Pt[1], ALine.Pt[2], FromPt);
end;

function AngleBetweenVectors(V1, V2: Vector2D; DegreesWanted: Boolean): Extended;
var
  Det, R: Double;
begin
  V1 := Normalize2D(V1);   V2 := Normalize2D(V2);
  Det := SQRT( Vector2DMagnitude(V1) * Vector2DMagnitude(V2) );
  if Det < 1/BIG_DUMMY then
    Det := 1;
  R := DotProduct2D(V1, V2) / Det;
  //Prevent NAN result from rounding
  if R > 1 then R := 1;
  if R < -1 then R := -1;
  Result := ArcCos( R );
  if DegreesWanted then
    Result := Result*180/pi;
end;

{
function AngleBetweenLines2D(L1P1, L1P2, L2P1, L2P2: Point2D; DegreesWanted: Boolean): Extended;
var
  V1, V2: Vector2D;
begin
  V1 := Vector2DFrom2DPoints(L1P1, L1P2);
  V2 := Vector2DFrom2DPoints(L2P1, L2P2);
  Result := AngleBetweenVectors(V1, V2, DegreesWanted);
end;
}

function AngleBetweenLines2D(L1, L2: LineType2D; DegreesWanted: Boolean): Extended;
var
  V1, V2: Vector2D;
begin
  V1 := Vector2DFrom2DPoints(L1.Pt[1], L1.Pt[2]);
  V2 := Vector2DFrom2DPoints(L2.Pt[1], L2.Pt[2]);
  Result := AngleBetweenVectors(V1, V2, DegreesWanted);
end;

{********* end of Vector Utils **************}

function PointIsOrigin(p: Point2D): Boolean;
begin
  Result := (p.x=0)and(p.y=0);
end;

procedure QuickSort(var A: array of SortPointsType);

  procedure QSort(var A: array of SortPointsType; iLo, iHi: Integer);
  var
    Lo, Hi: Integer;  Mid: Double; T: SortPointsType;
  begin
    Lo := iLo;
    Hi := iHi;
    Mid := A[(Lo + Hi) div 2].SortNo;
    repeat
      while A[Lo].SortNo < Mid do Inc(Lo);
      while A[Hi].SortNo > Mid do Dec(Hi);
      if Lo <= Hi then
      begin
        T := A[Lo];
        A[Lo] := A[Hi];
        A[Hi] := T;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then QSort(A, iLo, Hi);
    if Lo < iHi then QSort(A, Lo, iHi);
  end;

begin
  QSort(A, Low(A), High(A));
end;


procedure QuickSort(var A: array of Double);

  procedure QSort(var A: array of Double; iLo, iHi: Integer);
  var
    Lo, Hi: Integer;  Mid, T: Double;
  begin
    Lo := iLo;
    Hi := iHi;
    Mid := A[(Lo + Hi) div 2];
    repeat
      while A[Lo] < Mid do Inc(Lo);
      while A[Hi] > Mid do Dec(Hi);
      if Lo <= Hi then
      begin
        T := A[Lo];
        A[Lo] := A[Hi];
        A[Hi] := T;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then QSort(A, iLo, Hi);
    if Lo < iHi then QSort(A, Lo, iHi);
  end;

begin
  QSort(A, Low(A), High(A));
end;

{Angle Snapping, from Wall Designer}
{
var
  SnapDegrees: Double=30;
procedure SnapToAngle(var Dirn: Extended);
begin
  Dirn := Round( (Dirn * 180) / (pi * SnapDegrees) );
  Dirn := SnapDegrees * Dirn;
  Dirn := Dirn * pi / 180;
end;
        }
procedure SnapToAngle(var Dirn: Extended; fSnapDegrees: Double);
begin
  Dirn := Round( (Dirn * 180) / (pi * fSnapDegrees) );
  Dirn := fSnapDegrees * Dirn;
  Dirn := Dirn * pi / 180;
end;
 {
procedure Snap2ndPtToAngle(Pt1: WPointType; var Pt2: WPointType);
var
  Dirn: Extended;
  Len: Double;
begin
  Dirn := LineDirectionRadians(Pt1, Pt2);
  SnapToAngle(Dirn);

  Len:=LineLength2D(Pt1, Pt2);
  Pt2.x := Pt1.x + Len * Cos( Dirn );
  Pt2.y := Pt1.y + Len * Sin( Dirn );
end;       }

procedure Snap2ndPtToAngle(Pt1: Point2D; var Pt2: Point2D; fSnapDegrees: Double);
var
  Dirn: Extended;
  Len: Double;
begin
  Dirn := LineDirectionRadians(Pt1, Pt2);
  SnapToAngle(Dirn, fSnapDegrees);

  Len:=LineLength2D(Pt1, Pt2);
  Pt2.x := Pt1.x + Len * Cos( Dirn );
  Pt2.y := Pt1.y + Len * Sin( Dirn );
end;

function AbsRadians(Radians: Extended): Extended;
begin
  while Radians <= 0 do   //was <= 0, tried < 0 around v1308, but it buggered the SnapToWalls for horz
    Radians := Radians + pi;
  if Radians > pi then
    Radians := pi;
  if Between(Radians, 0, 0.0001, 0) then  //pick up rounding error
    Radians := 0;  //was pi !
  Result := Radians;
end;

function LinesAreParallel(L1Pt1, L1Pt2, L2Pt1, L2Pt2: Point2D): Boolean;
const
  TOL=0.001;
var
  Dirn1, Dirn2: Extended;
begin
  Dirn1 := AbsRadians( LineDirectionRadians(L1Pt1, L1Pt2) );
  if abs(Dirn1 - pi)<TOL then
    Dirn1 := 0;
  Dirn2 := AbsRadians( LineDirectionRadians(L2Pt1, L2Pt2) );
  if abs(Dirn2 - pi)<TOL then
    Dirn2 := 0;
  //Result := (Dirn1 < Dirn2 + 0.001) and (Dirn1 > Dirn2 - 0.001);
  Result := (abs(Dirn1 - Dirn2) < TOL);
  if not Result then
  begin
    Dirn2 := AbsRadians( LineDirectionRadians(L2Pt2, L2Pt1) );
    if abs(Dirn2 - pi)<TOL then
      Dirn2 := 0;
    Result := (abs(Dirn1 - Dirn2) < TOL);
  end;
end;
      {
function LinesAreParallel(L1, L2: LineType): Boolean;
begin
  Result := LinesAreParallel(L1.Pt[1], L1.Pt[2], L2.Pt[1], L2.Pt[2]);
end;

function LinesAreParallel(L1, L2: LineType; DegreesTol: Extended): Boolean;
const
  TOL=0.001;
var
  Dirn1, Dirn2, RadiansTol: Extended;
begin
  Dirn1 := AbsRadians( LineDirectionRadians(L1.Pt[1], L1.Pt[2]) );
  if abs(Dirn1 - pi)<TOL then
    Dirn1 := 0;
  Dirn2 := AbsRadians( LineDirectionRadians(L2.Pt[1], L2.Pt[2]) );
  if abs(Dirn2 - pi)<TOL then
    Dirn2 := 0;
  RadiansTol := (DegreesTol * pi/180);
  Result := abs(Dirn1 - Dirn2) < RadiansTol;
  if not Result then
  begin
    Dirn2 := AbsRadians( LineDirectionRadians(L2.Pt[2], L2.Pt[1]) );
    if abs(Dirn2 - pi)<TOL then
      Dirn2 := 0;
    Result := abs(Dirn1 - Dirn2) < RadiansTol;
  end;
end;
      }

function ArePerpendicular(Dirn1, Dirn2: Extended): Boolean;
var
  delta: Extended;
begin
  delta := abs( absRadians(Dirn1) - absRadians(Dirn2) );
  Result := Between(delta, pi/2 + 0.001, pi/2 - 0.001, 0);
end;
         {
function RotateZMatrix2D(Angle: Extended; IsRadians: Boolean): Matrix2D;
begin
  if not IsRadians then
    Angle := Angle*Pi/180;
  Result[1,1]:=Cos(Angle);   Result[1,2]:=Sin(Angle);
  Result[2,1]:=-Sin(Angle);  Result[2,2]:=Cos(Angle);
end;

function MatrixOp2D(p: Point2D; M: Matrix2D): Point2D;
begin
  Result.x := p.x*M[1,1] + p.y*M[2,1];
  Result.y := p.x*M[1,2] + p.y*M[2,2];
end;

procedure RotateAboutPoint(var p: Point2D; Centre: Point2D; Angle: Extended; IsRadians: Boolean);
var
  RotateMatrix: Matrix2D;
  V: Vector2D;
  d: Double;
begin
  RotateMatrix := RotateZMatrix2D(Angle, IsRadians);
  V := Vector2D(Centre);
  d := LineLength2D(Centre, THE_ORIGIN);

  TranslatePoint(V, -d, p);
  p := MatrixOp2D(p, RotateMatrix);
  TranslatePoint(V, d, p);
end;


function GetOffSets(Pt1, Pt2: Point2D; Amount: Double; var XOff, YOff: Double): Extended;
var
  Dirn: Extended;
begin
  Dirn := LineDirectionRadians(Pt1, Pt2);
  XOff := -Amount * Sin( Dirn ) / 2;
  YOff :=  Amount * Cos( Dirn ) / 2;
  Result := Dirn;
end;      }

procedure OutputDebugString(s: string);
begin
{$IFDEF DEBUG}
  OutputDebugStringW(PChar(s));
{$ENDIF}
end;

END.
