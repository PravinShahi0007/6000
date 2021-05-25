unit AdjustForJointsU;

{
Main unit for processing the interactions of all the entity items
ProcessTruss is the main routine
Items are processed in pairs, one being called the StaticItem the other IntersectItem

Used by ScotSim, the COM DLL and the RF programs
}

interface

uses
  SysUtils,
  Classes,
  GlobalU,
  OpenGL,
  Dialogs,
  Math;

  procedure ClearClusters;
  function ProcessTruss(var AEntity: array of EntityRecType; NumEntities: Word): Integer;
  function HoleCoordFromPos(AEntityRec: EntityRecType; Position: Double; isFlange: Boolean): Point2D;
  function DistFromHoleToEnd(anEntity : pEntityRecType; p: Point2D): Double;
  function FlangeCoordFromPos(AEntityRec: EntityRecType; Position: Double): Point2D;
  function SwageSize: Double;

const
  JOINING_VERSION = '502';
  //the JOINING_VERSION constant should match the VerQueryValue value for
  //'StringFileInfo\140904E4\JoiningVersion' in HoleAuto.DLL,
  //change JOINING_VERSION to the minor version of ScotSim when changes are made
  //to this unit that affect the hole, notch and cope positions for trusses

type
  TCluster = record
               Pt: array[1..4] of Point2D;
             end;

var
  HoleOutPt: Point2D;
  NotchOut, CopeOut: array[0..1]of Point2D;
  HoleSize: Double = 5;  //was 4.75;    //internally represented by radius, externally a diameter 9.5
  Clusters: array of TCluster;
  nForcedHoleIdx: Byte=0;    //for predetermined selection of HoleIdx in FindOptHole
  FrameType: string;
  bisTruss: boolean;

implementation

uses UtilsU, ErrorsFormU, Forms;

const
  MAX_EXTEND_DIST = 1500;   //was 600
  TAB_TOL = 0.5;

var
  StaticItem: StaticItemType;
  IntersectItem: IntersectItemType;
  bTipsMeet, bFlgTipsMeet, bStaticItemTab: Boolean;    //  bMakeTab
  //Extra Notches to mitred ends
  //Could Store these inside EntityRecType and have 1-d arrays instead
  MitreNotch: array[0..pred(MAX_ITEMS), 1..2] of Point2D;   // [1] is from Pt[1], [2] is from Pt[2]
  MitreCope:  array[0..pred(MAX_ITEMS), 1..2] of Point2D;   // [1] is from Pt[4], [2] is from Pt[3]
  //from GlobalU
  Entity: array of EntityRecType;
  AcuteDist: Double;
  MinNotchDist: Double;
  HoleIdx: Byte;
  bMultiHoleFlagged: Boolean=False;   //panel with one of the items sCHORD2 or sWEB2
  bLateLengthChange: Boolean;
  Punch: array[1..4] of Point2D;
//procedure FixVirtualMitres; forward;
//procedure ForceVirtualMitres; forward;
function DistFromEnd1(Idx: Word; p: Point2D): Double; forward;

procedure AddCluster(APts: array of Point2D);
var
  Num, i: Integer;
begin
  Num := Length(Clusters);
  SetLength(Clusters, succ(Num));
  for i := 1 to 4 do
    Clusters[Num].Pt[i] := APts[pred(i)];
end;

procedure ClearClusters;
begin
  SetLength(Clusters, 0);  Clusters := nil;
end;

//* Returns True if the StaticItem and IntersectItem are perpendicular
function ItemsArePerpendicular: Boolean;
var
  Dirn1, Dirn2: Extended;
begin
  Dirn1 := LineDirectionRadians(IntersectItem.Pt[1], IntersectItem.Pt[2]);
  Dirn2 := LineDirectionRadians(StaticItem.Pt[1], StaticItem.Pt[2]);
  Result := ArePerpendicular(Dirn1, Dirn2);
end;

//* Get the Flange side hole line, and the Lip side hole line from the hole positions
//* NOTE: For bMultiHoleFlagged the Flg and Lip are the wrong way round
procedure FindFlangeAndLipHoleLines(ARect: RectType; var FlangeHoleLine, LipHoleLine: LineType2D);
var
  Web, FlangeFraction, LipFraction: Double;
begin
  with ARect do
  begin
    Web := LineLength2D(Pt[1], Pt[4]);
    
    LipFraction := LipHolePos / Web;
    if bFrames then
      LipFraction := FrameHolePos2 / Web;
    LipHoleLine.Pt[1].x := Pt[1].x + (Pt[4].x - Pt[1].x)*LipFraction;
    LipHoleLine.Pt[1].y := Pt[1].y + (Pt[4].y - Pt[1].y)*LipFraction;
    LipHoleLine.Pt[2].x := Pt[2].x + (Pt[3].x - Pt[2].x)*LipFraction;
    LipHoleLine.Pt[2].y := Pt[2].y + (Pt[3].y - Pt[2].y)*LipFraction;

    FlangeFraction := FlgHolePos / Web;
    if bFrames then
      FlangeFraction := FrameHolePos / Web;
    FlangeHoleLine.Pt[1].x := Pt[1].x + (Pt[4].x - Pt[1].x)*FlangeFraction;
    FlangeHoleLine.Pt[1].y := Pt[1].y + (Pt[4].y - Pt[1].y)*FlangeFraction;
    FlangeHoleLine.Pt[2].x := Pt[2].x + (Pt[3].x - Pt[2].x)*FlangeFraction;
    FlangeHoleLine.Pt[2].y := Pt[2].y + (Pt[3].y - Pt[2].y)*FlangeFraction;
  end;
end;

//* Determine the position of all 4 possible holes
procedure FindHoles;
const
  TOL=1;
var
  Intercept: Point2D;  //intercepts of Hole Lines
  HoleLine: array[1..2, 1..2] of LineType2D; //TrussItem[TrussIdx, SideIdx]  where FlangeSide=1, LipSide=2
  T1, T2: RectType;
  i,j, Idx: Byte;
begin
  T1 := RectType(StaticItem.Pt);
  T2 := RectType(IntersectItem.Pt);  //Typecast Pt[1..4] as RectType
  FindFlangeAndLipHoleLines(T1, HoleLine[1,1], HoleLine[1,2]);
  FindFlangeAndLipHoleLines(T2, HoleLine[2,1], HoleLine[2,2]);

  FillChar(Punch, SizeOf(Punch), 0);

  Idx:=1;
  for j:=1 to 2 do
    for i:=1 to 2 do
    begin
      if FindIntercept(HoleLine[1,i], HoleLine[2,j], Intercept)then
        Punch[Idx] := Intercept;
      inc(Idx);
    end;
end;

//* Change the length of the IntersectItem, -ve ExtByDist shortens it
procedure ExtendIntersectItem(ExtByDist: Double);
var
  v: Vector2D;
  Len: Double;
begin
  with IntersectItem do
  begin
    Len := LineLength2D(Pt[1],Pt[2]);
    ExtByDist := ExtByDist + Len;
    if ExtendEnd = tt14 then
    begin
      v := Vector2DFrom2DPoints(Pt[2], Pt[1]);
      Pt[1] := Point2DFromParametricEquation(Pt[2], v, ExtByDist);
      Pt[4] := Point2DFromParametricEquation(Pt[3], v, ExtByDist);
    end
    else begin
      v := Vector2DFrom2DPoints(Pt[1], Pt[2]);
      Pt[2] := Point2DFromParametricEquation(Pt[1], v, ExtByDist);
      Pt[3] := Point2DFromParametricEquation(Pt[4], v, ExtByDist);
    end;
  end;
end;

procedure CheckNotchIsInStaticItem(var ANotch: Point2D);
var
  p: Point2D;
  d12, d1, d2: Double;
  Vs: Vector2D;
  Li,Ls: LineType2D;
begin
  p := ClosestPtOn2DLine(StaticItem.Pt[1], StaticItem.Pt[2], ANotch);
  d1 := LineLength2D(p, StaticItem.Pt[1]);
  d2 := LineLength2D(p, StaticItem.Pt[2]);
  d12 := LineLength2D(StaticItem.Pt[1], StaticItem.Pt[2]);
  if (abs(d1 + d2 - d12) > 1)
  and((d1 + d2) > d12)then
  begin
    Vs := Vector2DFrom2DPoints(StaticItem.Pt[1], StaticItem.Pt[2]);
    if d1 < d2 then
    begin
      Ls := StaticItem.Line(1,4);
      TranslateLine(Vs, -CopeNotchTol, Ls);
    end
    else begin
      Ls := StaticItem.Line(2,3);
      TranslateLine(Vs, CopeNotchTol, Ls);
    end;

    Li := IntersectItem.Line(1,2);
    FindIntercept(Li,Ls, p);

    ANotch := ClosestPtOn2DLine(IntersectItem.Pt[1], IntersectItem.Pt[2], p);
  end;
end;

//* Return a notch distance from a point
function GetNotchDistance(var ANotch: Point2D): Double;
const
  TOL=0.1;  //Magic was 0.0001;
var
  FlangeLine1, FlangeLine2: LineType2D;
  d, Len, Gap: Double;    //, ExtDist
  V: Vector2D;            //, V12
  NearPt, FarPt, p, Intercept: Point2D;
begin
  Result := 0;
  if bStaticItemTab then
    exit;
  if not bFrames then                  //v.177
  if ((StaticItem.CloserEdge <> et12)and(not bTipsMeet)) then
    exit;

  FlangeLine1 := IntersectItem.FlangeLine;
  FlangeLine2 := StaticItem.FlangeLine;

  NearPt := IntersectItem.Pt[1];  FarPt := IntersectItem.Pt[2];
  if IntersectItem.ExtendEnd = tt23 then
    SwapPoints(NearPt, FarPt);

  if FindIntercept(FlangeLine1, FlangeLine2, Intercept)//then
  and PointOnLine(FlangeLine1, Intercept, 1)//then
  and PointOnLine(FlangeLine2, Intercept, 1)then
  begin
    ANotch := Intercept;
    with StaticItem do
    begin
      Gap := JointGap;
      if IntersectItem.IsVertical then
        Gap := VertJointGap;
      V := Vector2DFrom2DPoints(Pt[1], Pt[4]);
      if CloserEdge = et12 then
      begin
        V := ScaleVector2D(V, -1);
        Gap := CopeNotchTol;
      end;
    end;

    with FlangeLine2 do
    begin
      Pt[1] := Point2DFromParametricEquation(Pt[1], V, Gap);
      Pt[2] := Point2DFromParametricEquation(Pt[2], V, Gap);
      if (FindIntercept(FlangeLine1, FlangeLine2, p))then
        ANotch := p;
    end;
    CheckNotchIsInStaticItem(ANotch);

    if IntersectItem.ExtendEnd = tt14 then  //dist to other end
      d := LineLength2D(ANotch, IntersectItem.Pt[2])
    else
      d := LineLength2D(ANotch, IntersectItem.Pt[1]);

    with IntersectItem do
      Len := LineLength2D(Pt[1], Pt[2]);
    Result := Len - d;
  end
  else
    exit;

  Result := Result - TOL;

  if (Result > MAX_EXTEND_DIST)       //prevent really long notches
  and(not PointOnLine(FlangeLine2, ANotch, 1))then
  begin
    ANotch := StaticItem.Pt[1];
    if StaticItem.ExtendEnd = tt23 then
      ANotch := StaticItem.Pt[2];
    ANotch := ClosestPtOn2DLine(FlangeLine1.Pt[1], FlangeLine1.Pt[2], ANotch);
  end;
end;

//* Return a cope / flat distance from a point
function GetCopeDistance(var ACope: Point2D): Double;
var
  LipLine1: LineType2D;
  EndCope: Point2D;
//----------------------------------
  function LipCutsStaticEnd: Boolean;
  const
    END_TOL = 1;
  var
    L, SLip: LineType2D;
    V41, V12: Vector2D;
  begin
    Result := False;
    case StaticItem.CloserEdge of
      et12: begin
              V41 := Vector2DFrom2DPoints(StaticItem.Pt[4], StaticItem.Pt[1]);
              SLip.Pt[1] := Point2DFromParametricEquation(StaticItem.Pt[4], V41, LipSize);
              SLip.Pt[2] := Point2DFromParametricEquation(StaticItem.Pt[3], V41, LipSize);
              Result := (FindIntercept(LipLine1, SLip, EndCope))
                     and(PointOnLine(LipLine1, EndCope, 0.1))
                     {and(PointOnLine(SLip, EndCope, 0.1))};    // might not need this line...
            end;
      et34: begin
              V12 := Vector2DFrom2DPoints(StaticItem.Pt[1], StaticItem.Pt[2]);
              case StaticItem.ExtendEnd of
                tt14: begin
                        L.Pt[1] := Point2DFromParametricEquation(StaticItem.Pt[1], V12, -CopeNotchTol);
                        L.Pt[2] := Point2DFromParametricEquation(StaticItem.Pt[4], V12, -CopeNotchTol);
                      end;
                tt23: begin
                        L.Pt[1] := Point2DFromParametricEquation(StaticItem.Pt[2], V12, CopeNotchTol);
                        L.Pt[2] := Point2DFromParametricEquation(StaticItem.Pt[3], V12, CopeNotchTol);
                      end;
              end;
              Result := (FindIntercept(LipLine1, L, EndCope))
                     and(PointOnLine(LipLine1, EndCope, END_TOL))
                     and(PointOnLine(L, EndCope, END_TOL));
            end;
    end;
  end;
//----------------------------------
const
  TOL=1;
var
  LipLine2: LineType2D;
  d, Len: Double;
  V: Vector2D;
begin
  Result := 0;
  if bFrames then
    exit;
  if (StaticItem.CloserEdge = et12)and (not bTipsMeet) then
    exit;

  LipLine1 := IntersectItem.Line(4,3);
  LipLine2 := StaticItem.Line(4,3);
  if IntersectItem.IntersectEdge = et12 then
  with LipLine1 do
  begin
    V := Vector2DFrom2DPoints(IntersectItem.Pt[1], IntersectItem.Pt[4]);
    Pt[1] := Point2DFromParametricEquation(IntersectItem.Pt[4], V, -LipSize);
    Pt[2] := Point2DFromParametricEquation(IntersectItem.Pt[3], V, -LipSize);
  end;
  with LipLine2 do
  begin
    V := Vector2DFrom2DPoints(StaticItem.Pt[1], StaticItem.Pt[4]);
    Pt[1] := Point2DFromParametricEquation(StaticItem.Pt[4], V, CopeNotchTol);
    Pt[2] := Point2DFromParametricEquation(StaticItem.Pt[3], V, CopeNotchTol);
  end;

  with IntersectItem do
    Len := LineLength2D(Pt[3], Pt[4]);

  if FindIntercept(LipLine1, LipLine2, ACope)
  and PointOnLine(LipLine1, ACope, TOL)then
  begin
    if IntersectItem.ExtendEnd = tt14 then  //dist to other end
      d := LineLength2D(ACope, IntersectItem.Pt[3])
    else
      d := LineLength2D(ACope, IntersectItem.Pt[4]);
    Result := Len - d;
  end;

  if LipCutsStaticEnd then
  begin
    ACope := EndCope;
    //dist to other end
    Result := Len - abs(PerpDistance(IntersectItem.FarTipLine, EndCope));
  end;
end;

procedure FindExtraCopePoint(ExtraCopeDist: Double);
var
  V: Vector2D;
  p: Point2D;
begin
  if IntersectItem.ExtendEnd = tt14 then
  begin
    V := Vector2DFrom2DPoints(IntersectItem.Pt[4], IntersectItem.Pt[3]);
    p := IntersectItem.Pt[4];
  end
  else begin
    V := Vector2DFrom2DPoints(IntersectItem.Pt[3], IntersectItem.Pt[4]);
    p := IntersectItem.Pt[3];
  end;
  IntersectItem.Cope := Point2DFromParametricEquation(p, V, ExtraCopeDist);
end;

//* Initialize the StaticItem
procedure InitStaticItem(Idx: Word; PtIdx: Byte=0);
var       //Load all values except the HolePt
  i: Word;
begin
  FillChar(StaticItem, SizeOf(StaticItem), 0);
  for i:=1 to 4 do
    StaticItem.Pt[i] := Entity[Idx].Pt[i];
  StaticItem.OriginalIndex := Idx;
  bMultiHoleFlagged := bFrames and (Entity[Idx].IsAMultiHoleType) and (Entity[Idx].IsVertical);
  if (PtIdx > 0) then
  begin
    StaticItem.ExtendEnd := tt14;
    if (PtIdx = 2)or(PtIdx = 3)then
      StaticItem.ExtendEnd := tt23;
  end;
end;

//* Initialize the IntersectItem
procedure InitIntersectItem(Idx: Word; PtIdx: Byte);
const
  TOL = 0.001;
var       //Load all values except the HolePt
  i: Word;
  j, IntersectPtIdx: Byte;
  midPt: Point2D;
  d12, d34, d, furthestDist: Double;
  FarLine: LineType2D;
begin
  FillChar(IntersectItem, SizeOf(IntersectItem), 0);
  with IntersectItem do
  begin
    for i:=1 to 4 do
      Pt[i] := Entity[Idx].Pt[i];
    OriginalIndex := Idx;
    ExtendEnd := tt14;
    if (PtIdx=2)or(PtIdx=3)then
      ExtendEnd := tt23;
    midPt := MidPoint2D(Pt[1], Pt[3]);
    d12 := abs(PerpDistance(StaticItem.Line(1,2), MidPt));
    d34 := abs(PerpDistance(StaticItem.Line(3,4), MidPt));
    StaticItem.CloserEdge := et12;
    if d34 < d12 then
      StaticItem.CloserEdge := et34;
    FarLine := StaticItem.Line(1,2);
    if StaticItem.CloserEdge = et12 then
      FarLine := StaticItem.Line(4,3);

    if not ItemsArePerpendicular then
    begin
      furthestDist := abs( PerpDistance(FarLine.Pt[1], FarLine.Pt[2], Pt[1]) );
      IntersectPtIdx := 1;
      IntersectEdge := et34;
      for j:=2 to 4 do
      begin
        d := abs( PerpDistance(FarLine.Pt[1], FarLine.Pt[2], Pt[j]) );
        if d > (furthestDist + TOL)then  //without the tol 90 joins at the apex don't necessarily
        begin                            //choose the right edge
          IntersectPtIdx := j;
          furthestDist := d;
        end;
      end;
      if (IntersectPtIdx = 3)or(IntersectPtIdx = 4)then
        IntersectEdge := et12;
    end
    else begin
      midPt := MidPoint2D(StaticItem.Pt[1], StaticItem.Pt[3]);
      d12 := abs(PerpDistance(Pt[1], Pt[2], MidPt));
      d34 := abs(PerpDistance(Pt[3], Pt[4], MidPt));
      IntersectEdge := et12;
      if d34 < d12 then
        IntersectEdge := et34;

      bMultiHoleFlagged := bMultiHoleFlagged or (bFrames and (Entity[Idx].IsAMultiHoleType)and (Entity[Idx].IsVertical));
    end;
  end;
end;

//* Return True if any end points are on the rect, within Tol tolerance
function AnyEndPointIsOnRect(ARect: RectType; Idx: Word; ATip: TipType; Tol: Double): Boolean;
var
  p1,p2: Point2D;
begin
  p1 := Entity[Idx].Pt[1];  p2:=Entity[Idx].Pt[4];
  if ATip = tt23 then
  begin
    p1 := Entity[Idx].Pt[2];  p2:=Entity[Idx].Pt[3];
  end;
  if (not bFrames)then
    Result := PointOnLine(ARect.Pt[1], ARect.Pt[2], p1, Tol)
           or PointOnLine(ARect.Pt[1], ARect.Pt[2], p2, Tol)
           or PointOnLine(ARect.Pt[3], ARect.Pt[4], p1, Tol)
           or PointOnLine(ARect.Pt[3], ARect.Pt[4], p2, Tol)
  else
    Result := PointOnLine(ARect.Pt[1], ARect.Pt[2], p1, Tol)
           or PointOnLine(ARect.Pt[1], ARect.Pt[2], p2, 0)
           or PointOnLine(ARect.Pt[3], ARect.Pt[4], p1, Tol)
           or PointOnLine(ARect.Pt[3], ARect.Pt[4], p2, 0);
end;

function  PointIsOnRect(ARect: RectType;  pt: Point2D; Tol: Double): Boolean;
begin
  // based on AnyEndPointIsOnRect
  Result := PointOnLine(ARect.Pt[1], ARect.Pt[2], pt, Tol) or
            PointOnLine(ARect.Pt[3], ARect.Pt[4], pt, Tol)
end;

//* Return True if either rect has either end in or on the other rect
function HasEndInOrOnRect(Rect1, Rect2: RectType): Boolean;
begin
  Result := (IsInOrOnRect(Rect1, Rect2.Pt[1]) and IsInOrOnRect(Rect1, Rect2.Pt[4]))
         or (IsInOrOnRect(Rect1, Rect2.Pt[2]) and IsInOrOnRect(Rect1, Rect2.Pt[3]))
         or (IsInOrOnRect(Rect2, Rect1.Pt[1]) and IsInOrOnRect(Rect2, Rect1.Pt[4]))
         or (IsInOrOnRect(Rect2, Rect1.Pt[2]) and IsInOrOnRect(Rect2, Rect1.Pt[3]));
end;

//* Return True if Entity[i] and Entity[j] are parallel
function ItemsAreParallel(i,j: Word): Boolean;
begin
  Result := LinesAreParallel(Entity[i].Pt[1], Entity[i].Pt[2], Entity[j].Pt[1], Entity[j].Pt[2]);
end;

function isConnected(ARect: RectType; Idx: Word; ATip: TipType; out AStaticItemEnd: integer): Boolean;
var
  EndLine: linetype2D;
  EndMidPoint: Point2d;
  d1,d2: double;
const
  TOL=0.1;
  TRUSSENDTOL=45;
begin
  result := false;
  AStaticItemEnd :=0 ;
  EndLine:= Entity[Idx].endline(ATip);
  EndMidPoint:=MidPoint2D(EndLine);

  if bIsTruss then
  begin
    if IsInRect(ARect, EndMidPoint) or
       PointIsOnRect(ARect,EndLine.Pt[1], TOL) or
       PointIsOnRect(ARect,EndLine.Pt[2], TOL) then
    begin
      result := True;
      // determine static item end
      d1:=linelength2d(EndMidPoint,ARect.Pt[1]);
      if d1 < TRUSSENDTOL then
        AStaticItemEnd:=1;
      d2:=linelength2d(EndMidPoint,ARect.Pt[2]);
      if d2 < TRUSSENDTOL then
        AStaticItemEnd:=2
    end;
  end else
  begin
    Result := PointIsOnRect(ARect,EndLine.Pt[1], TOL) or
              PointIsOnRect(ARect,EndLine.Pt[2], 0);
  end;
end;


//* Examine the 2 entity items
//* if they interact, the init the StaticItem and IntersectItem
function EntitiesTouch(Idx1, Idx2: Word): Boolean;
const
  TOL=0.1; //was 1; v113
  //HALF_A_DEGREE = 0.0087266462599716478846184538424431;
var
  i,j: Byte;
  Rect1, Rect2: RectType;
  Dirn1, Dirn2: Extended;
  StaticItemEnd: integer;    // 1 or 2 (0=not-at-end)
begin
  Result := False;

  Rect1 := Entity[Idx1].FRect;
  Rect2 := Entity[Idx2].FRect;

  if (not bFrames)then
  if  bRequire2PtWebToWeb
  and SameText(Entity[Idx1].iType, sWEB)
  and SameText(Entity[Idx2].iType, sWEB)then
  begin
    if not HasEndInOrOnRect(Rect1, Rect2) then
    begin
      Result := False;
      exit;
    end;
  end;

  bTipsMeet := False;  bFlgTipsMeet := False;  bLateLengthChange := False;  bStaticItemTab := False;   //   bMakeTab rem'd v.458
  //Look for ends touching first
    for i:=1 to 4 do
    begin
      for j:=1 to 4 do
        if LineLength2D(Entity[Idx1].Pt[i], Entity[Idx2].Pt[j]) < TOL then
        begin
          with Entity[Idx1]do
            Dirn1 := AngleFromHorizontal(Pt[1], Pt[2]);
          with Entity[Idx2]do
            Dirn2 := AngleFromHorizontal(Pt[1], Pt[2]);
          //if abs(Dirn1 - Dirn2) > HALF_A_DEGREE then
          //begin
            if Dirn1 < Dirn2 then
            begin
              InitStaticItem(Idx1, i);  InitIntersectItem(Idx2, j);
            end
            else begin
              InitStaticItem(Idx2, j);  InitIntersectItem(Idx1, i);
            end;
          {end
          else begin
            if MidPoint2D(Entity[Idx1].Pt[1], Entity[Idx1].Pt[3]).x //leftmost item
             < MidPoint2D(Entity[Idx2].Pt[1], Entity[Idx2].Pt[3]).x then
            begin
              InitStaticItem(Idx2, j);  InitIntersectItem(Idx1, i);
            end
            else begin
              InitStaticItem(Idx1, i);  InitIntersectItem(Idx2, j);
            end;
          end;  }
          Result := True;
          bTipsMeet := True;
          bFlgTipsMeet := (i<3) and (j<3);    //Flange edges meet

          break;
        end;
      if bTipsMeet then
        exit;
    end;

  if ItemsAreParallel(Idx1, Idx2) then     // end-to-end not found here
    exit;

  try
    if isConnected(Rect1, Idx2, tt14, StaticItemEnd)then
    begin
      InitStaticItem(Idx1, StaticItemEnd);
      InitIntersectItem(Idx2, 1);
      Exit(True);
    end;
    if isConnected(Rect1, Idx2, tt23, StaticItemEnd)then
    begin
      InitStaticItem(Idx1, StaticItemEnd);
      InitIntersectItem(Idx2, 2);
      Exit(True);
    end;
    //Same for the other Rect
    if isConnected(Rect2, Idx1, tt14, StaticItemEnd)then
    begin
      InitStaticItem(Idx2, StaticItemEnd);
      InitIntersectItem(Idx1, 1);
      Exit(True);
    end;
    if isConnected(Rect2, Idx1, tt23, StaticItemEnd)then
    begin
      InitStaticItem(Idx2, StaticItemEnd);
      InitIntersectItem(Idx1, 2);
      Exit(True);
    end;
  finally
    bTipsMeet := StaticItemEnd<>0;
    bFlgTipsMeet := bTipsMeet;    //Flange edges meet
  end;
end;

//* See if the IntersectItem needs further extension
//* Return the amount if it does, or 0 if not
function GetIntersectItemExtension: Double;
var
  MinDist, MaxDist,
  OptHoleDist, Len, OuterGapDist, D: Double;
  GapLine, Edge, NearEdgeLine, FarEdgeLine, OuterGapLine, OtherEdge: LineType2D;
  Intercept: Point2D;
  V: Vector2D;
begin
  Result := 0;
  try
    OptHoleDist := abs(PerpDistance(IntersectItem.FarTipLine, IntersectItem.HolePt));
    MinDist := MinEndDist + OptHoleDist;

    FarEdgeLine := StaticItem.Line(1,2);
    NearEdgeLine:= StaticItem.Line(4,3);
    if StaticItem.CloserEdge = et12 then
    begin
      FarEdgeLine := StaticItem.Line(4,3);
      NearEdgeLine:= StaticItem.Line(1,2);
    end;

    V := Vector2DFrom2DPoints(FarEdgeLine.Pt[1], NearEdgeLine.Pt[1]);
    D := JointGap;
    if bFrames and IntersectItem.IsVertical then
      D := VertJointGap;
    GapLine.Pt[1] := Point2DFromParametricEquation(FarEdgeLine.Pt[1], V, D);
    GapLine.Pt[2] := Point2DFromParametricEquation(FarEdgeLine.Pt[2], V, D);
    OuterGapLine.Pt[1] := Point2DFromParametricEquation(NearEdgeLine.Pt[1], V, D);
    OuterGapLine.Pt[2] := Point2DFromParametricEquation(NearEdgeLine.Pt[2], V, D);

    Edge := IntersectItem.Line(1,2);
    OtherEdge := IntersectItem.Line(3,4);
    if (not (bFrames and bFlgTipsMeet))then
    if IntersectItem.IntersectEdge = et34 then
    begin
      Edge := IntersectItem.Line(3,4);
      OtherEdge := IntersectItem.Line(1,2);
    end;
    MaxDist := MinDist; //default value
    if (StaticItem.CloserEdge = et34)then
    if FindIntercept(GapLine, Edge, Intercept) then
      MaxDist := abs(PerpDistance(IntersectItem.FarTipLine, Intercept));
    with IntersectItem do
      Len := LineLength2D(Pt[1], Pt[2]);
    if (MaxDist - Len) > MAX_EXTEND_DIST then
      MaxDist := MinDist;

    if (AngleBetweenLines2D(Edge, FarEdgeLine, True) < 45 ) and // use original length for angled webs
       (MaxDist > Len ) then
       MaxDist := Len;


    if bFrames then
    begin
      Result := MaxDist - Len;
      if bVirtualMitre then
      begin
        if (MaxDist < MinDist)then
        begin
          if (StaticItem.CloserEdge = et34) then
            Result := OptHoleDist - Len + (NotchSize / 2) - CutWidth - NOTCH_START_TOL;
        end;
      end;
      if (not bTipsMeet)or ItemsArePerpendicular then
        exit;
    end;

    if (MaxDist < MinDist)then   //an error occured
    begin
      begin
        Result := MinDist - Len;
        exit;
      end;
    end;

    if (IntersectItem.IntersectEdge = et34)
    and(StaticItem.CloserEdge = et12)then    //extra condition imposed v96
    begin
      //Pull back outer joins which are along both Pt1-Pt2 lines, v81
      if (
          (IntersectItem.ExtendEnd = tt14)
       and(PointOnLine(StaticItem.Pt[1], StaticItem.Pt[2], IntersectItem.Pt[1], 1))
          )
       or (
          (IntersectItem.ExtendEnd = tt23)
       and(PointOnLine(StaticItem.Pt[1], StaticItem.Pt[2], IntersectItem.Pt[2], 1))
           )then
      begin
        OuterGapDist := 0;
        if FindIntercept(OuterGapLine, OtherEdge, Intercept) then
          OuterGapDist := abs(PerpDistance(IntersectItem.FarTipLine, Intercept));
        if (Len > OuterGapDist)
        and(OuterGapDist < MaxDist)
        and(OuterGapDist > MinDist)then
        begin
          Result := OuterGapDist - Len;
          exit;
        end;
      end;
    end;

    Result := MinDist - Len;
    if Len > MaxDist then     //shorten
      Result := MaxDist - Len;
  finally
    if Result > MAX_EXTEND_DIST then      //prevent infinitely long extension results
      Result := 0;
  end;
end;

//* Change the length of the Entity[Idx] at the AEnd, -ve ExtByDist shortens it
procedure ExtendItemEnd(Idx: Integer; AEnd: TipType; ExtByDist: Double);
const
  MIN_TOL = 0.01;
var
  v: Vector2D;
begin
  if (abs(ExtByDist) < MIN_TOL) then
    exit;
  if(ExtByDist > MAX_EXTEND_DIST)then
    exit;
  with Entity[Idx] do
  begin
    Len := LineLength2D(Pt[1],Pt[2]);
    ExtByDist := ExtByDist + Len;
    if AEnd = tt14 then
    begin
      v := Vector2DFrom2DPoints(Pt[2], Pt[1]);
      Pt[1] := Point2DFromParametricEquation(Pt[2], v, ExtByDist);
      Pt[4] := Point2DFromParametricEquation(Pt[3], v, ExtByDist);
    end
    else begin
      v := Vector2DFrom2DPoints(Pt[1], Pt[2]);
      Pt[2] := Point2DFromParametricEquation(Pt[1], v, ExtByDist);
      Pt[3] := Point2DFromParametricEquation(Pt[4], v, ExtByDist);
    end;
  end;
end;

procedure AddOp(Idx: Integer; AKind: TOpKind; APt: Point2D);  //; ANum: Word=0; APos: Double=0);
begin
  inc(Entity[Idx].OpCount);
  with Entity[Idx] do
  begin
    Op[OpCount].Kind := AKind;
    Op[OpCount].p    := APt;
    Op[OpCount].Pos  := DistFromEnd1(idx, Apt);

    {Op[OpCount].Num  := ANum;
    Op[OpCount].Pos  := APos;}
  end;
end;

//* Add flats to the StaticItem if they're needed
//* IntesectItem comes in on the lip (34) side, ie StaticItem.CloserEdge = et34
function FindStaticItemFlattenPoints(SLine34, L12, L34: LineType2D): Boolean;
const
  TOL = 0.9;      //should be less than vertical joint gap
  FLAT_START_TOL = 2;
var
  p12,p34, p, StartPt, EndPt, MidPt, q, pPossible: Point2D;
  nFlats, i, Idx: Integer;
  TotalDist, Dist, d3,d4, FirstCopeDist, dEnd, dHole,dLen: Double;    // , d1,d
  V: Vector2D;
  bEndFlat: Boolean;
begin
  Result := False;

  if not(FindIntercept(SLine34,L12, p12)and FindIntercept(SLine34,L34, p34))then
    exit;
  if not(PointOnLine(SLine34, p12, TOL)or PointOnLine(SLine34, p34, TOL))then
    exit;
  //not needed if the IntersectItem doesn't cross the lip line
  if not((PointOnLine(L34, p34, TOL))or(PointOnLine(L12, p12, TOL))) then  //v.477
    exit;
  //don't need a flat in the StaticItem if the IntersectItem is notched and comes in on the 12 side,
  //it will go over the StaticItem, the IntersectItem will have the flat
  if (StaticItem.CloserEdge = et12)and(not PointIsOrigin(IntersectItem.Notch))then
    exit;
  // puts the flats on the correct item for unusual joins by exiting here
  // Draw an example with -90°, then starting at pt[1] 135°
  if bTipsMeet and (StaticItem.CloserEdge = et12) and (IntersectItem.IntersectEdge = et12) then
    exit;

  // Shorten the end dist
  if (not StaticItem.bIsFacingItem) then  //(not StaticItem.IsHorz) then
  begin
    dHole := abs(PerpDistanceToLine(StaticItem.FarTipLine, StaticItem.HolePt));
    with Entity[StaticItem.OriginalIndex] do
      dLen := LineLength2D(Pt[1], Pt[2]);
    dLen := MinEndDist - dLen + dHole;
    if abs(dLen) < Entity[StaticItem.OriginalIndex].Web then
      ExtendItemEnd(StaticItem.OriginalIndex, StaticItem.ExtendEnd, dLen);
  end;

  StartPt := p12;  EndPt := p34;  MidPt := MidPoint2D(p12, p34);

  Idx := StaticItem.OriginalIndex;
  with Entity[Idx]do
  begin
    SLine34.Pt[1] := Pt[3];  SLine34.Pt[2] := Pt[4];
  end;
  if not(FindIntercept(SLine34,L12, p12)and FindIntercept(SLine34,L34, p34))then
    exit;

  if LineLength2D(MidPt, p12) > LineLength2D(MidPt, StartPt) then
    StartPt := p12;
  if LineLength2D(MidPt, p34) > LineLength2D(MidPt, EndPt) then
    EndPt := p34;

  StartPt := ClosestPtOn2DLine(SLine34.Pt[1], SLine34.Pt[2], StartPt);
  EndPt := ClosestPtOn2DLine(SLine34.Pt[1], SLine34.Pt[2], EndPt);
  MidPt := ClosestPtOn2DLine(SLine34.Pt[1], SLine34.Pt[2], MidPt);

  if not bTipsMeet then
  begin
    if (IntersectItem.ExtendEnd = tt14) then
    begin
      if (FindIntercept(IntersectItem.Pt[1], IntersectItem.Pt[4], StartPt, EndPt, q))
      and(PointOnLine(StartPt, EndPt, q, TOL))
      and(PointOnLine(SLine34, q, TOL)) then
      begin
        if abs(PerpDistance(IntersectItem.FarTipLine, StartPt))
         > abs(PerpDistance(IntersectItem.FarTipLine, EndPt))then
          StartPt := q     //not found in the fan instances
        else
          EndPt := q;
      end;
    end
    else begin     //tt23
      if (FindIntercept(IntersectItem.Pt[2], IntersectItem.Pt[3], StartPt, EndPt, q))
      and(PointOnLine(StartPt, EndPt, q, TOL))
      and(PointOnLine(SLine34, q, TOL)) then
      begin
        if abs(PerpDistance(IntersectItem.FarTipLine, StartPt))
         > abs(PerpDistance(IntersectItem.FarTipLine, EndPt))then
          StartPt := q     //not found in the fan instances
        else
          EndPt := q;
      end;
    end;
    V := Vector2DFrom2DPoints(StartPt, EndPt);
    //assume EndPt = q
    EndPt := Point2DFromParametricEquation(EndPt, V, CopeNotchTol);
  end;

  FirstCopeDist := -FLAT_START_TOL + CopeSize/2;
  bEndFlat := False;
  if (not PointOnLine(SLine34, StartPt, 0.1)) then
  begin                                 //StartPt is off the end, move to an end
    bEndFlat := True;
    d3 := LineLength2D(StartPt, Entity[Idx].Pt[3]);
    d4 := LineLength2D(StartPt, Entity[Idx].Pt[4]);
    StartPt :=  Entity[Idx].Pt[4];
    if (d3 < d4) then
      StartPt :=  Entity[Idx].Pt[3];
  end
  else if (not PointOnLine(SLine34, EndPt, 0.1)) then  // StartPt wasn't off the end
  begin                                 //EndPt is off the end though...
    bEndFlat := True;
    d3 := LineLength2D(EndPt, Entity[Idx].Pt[3]);
    d4 := LineLength2D(EndPt, Entity[Idx].Pt[4]);
    EndPt :=  Entity[Idx].Pt[4];
    if (d3 < d4) then
      EndPt :=  Entity[Idx].Pt[3];
    SwapPoints(StartPt, EndPt);
  end;

  TotalDist := LineLength2D(StartPt, EndPt);
  nFlats := Succ(Trunc(TotalDist / CopeSize));

  //stop really the long flats which are beyond the end of the other item
  dEnd := PerpDistance(IntersectItem.FarTipLine, EndPt);
  if abs(dEnd) > (LineLength2D(IntersectItem.Line(3,4)) + CopeSize/2) then // further than its length + CopeSize/2
    nFlats := 1;

  Dist := CopeSize;
  if (nFlats > 1) then    //spacing for the flats
    Dist := (TotalDist - CopeSize) / pred(nFlats);

  with Entity[IntersectItem.OriginalIndex]do
  begin
    pPossible := ClosestPtOn2DLine(Pt[1], Pt[2], StartPt);
    if (LineLength2D(pPossible, StartPt) < Web / 2) then //nearer the swage (flg) side, than the lip side
      PossibleSwagePt := pPossible;
  end;

  with Entity[Idx]do
  begin
    V := Vector2DFrom2DPoints(StartPt, EndPt);
    if (bEndFlat) then
      p := Point2DFromParametricEquation(StartPt, V, FirstCopeDist)
    else if (nFlats > 1) then
      p := Point2DFromParametricEquation(StartPt, V, CopeSize/2)
    else
      p := MidPt;
    for i:=1 to nFlats do
    begin
      if PointOnLine(SLine34, p, 1) then
      begin
        AddOp(Idx, okCope, p);
        Result := True;
      end;
      p := Point2DFromParametricEquation(p, V, Dist);
    end;
  end;
end;

//* Add flats to the IntersectItem if they're needed
//* IntersectItem comes in on the flange (12) side, ie StaticItem.CloserEdge = et12
procedure FindIntersectItemFlattenPoints(I34, S12, S34: LineType2D);
const
  TOL=1;
  FLAT_START_TOL = 2;
var
  p12,p34, p, StartPt, EndPt, MidPt, ItemPt: Point2D;
  nFlats, i: Integer;
  TotalDist, Dist, L,d1,d2,d: Double;
  V: Vector2D;
  bStartPtOnLine, bEndPtOnLine: Boolean;
  bEndFlat: Boolean;
begin
  if(not(FindIntercept(I34, S12, p12)))
  or(not(FindIntercept(I34, S34, p34)))then
    exit;

  StartPt := p34;
  EndPt := p12;
  bStartPtOnLine := PointOnLine(I34, StartPt, TOL);
  bEndPtOnLine := PointOnLine(I34, EndPt, TOL);
  if (not bStartPtOnLine)and(not bEndPtOnLine) then
    exit;

  with Entity[IntersectItem.OriginalIndex]do
  begin
    I34.Pt[1] := Pt[4];  I34.Pt[2] := Pt[3];
  end;
  if(not(FindIntercept(I34, S12, p12)))
  or(not(FindIntercept(I34, S34, p34)))then
    exit;

  MidPt := MidPoint2D(StartPt, EndPt);
  if LineLength2D(MidPt, p34) > LineLength2D(MidPt, StartPt) then
    StartPt := p34;
  if LineLength2D(MidPt, p12) > LineLength2D(MidPt, EndPt) then
    EndPt := p12;

  StartPt := ClosestPtOn2DLine(I34.Pt[1], I34.Pt[2], StartPt);
  EndPt := ClosestPtOn2DLine(I34.Pt[1], I34.Pt[2], EndPt);

  TotalDist := LineLength2D(StartPt, EndPt);
  nFlats := Succ(Trunc(TotalDist / CopeSize));

  bEndFlat := True; //start the flat from an end
  if bEndFlat then
  begin
    ItemPt := I34.Pt[1];
    if (IntersectItem.ExtendEnd = tt23) then
      ItemPt := I34.Pt[2];
    if (not bStartPtOnLine) then
    begin
      StartPt := ItemPt;
    end
    else if (not bEndPtOnLine) then
    begin
      EndPt := ItemPt;
      SwapPoints(StartPt, EndPt);
    end
    else begin
      if LineLength2D(ItemPt, StartPt) < LineLength2D(ItemPt, EndPt) then
        StartPt := ItemPt
      else begin
        EndPt := ItemPt;
        SwapPoints(StartPt, EndPt);
      end;
    end;
    //reassess  ...
    TotalDist := LineLength2D(StartPt, EndPt) + FLAT_START_TOL;
    nFlats := Succ(Trunc(TotalDist / CopeSize));
  end;

  V := Vector2DFrom2DPoints(StartPt, EndPt);

  L := 0;  d1 := 0;
  if bTipsMeet then
  with Entity[StaticItem.OriginalIndex]do
  begin
    if StaticItem.ExtendEnd = tt14 then
    begin
      d1 := PerpDistance(Pt[1], Pt[4], StartPt);
      d2 := PerpDistance(Pt[1], Pt[4], EndPt);
    end
    else begin
      d1 := PerpDistance(Pt[2], Pt[3], StartPt);
      d2 := PerpDistance(Pt[2], Pt[3], EndPt);
    end;
    if (abs(d1) > 1)and(abs(d2) > 1)and(Sign(d1) <> Sign(d2))then
      L := LineLength2D(StartPt, EndPt);
  end;

  if (bTipsMeet)and(L <> 0)and(nFlats > 1) then
  begin
    d := abs(d1) + CopeNotchTol;
    EndPt := Point2DFromParametricEquation(StartPt, V, d);
    TotalDist := LineLength2D(StartPt, EndPt) + FLAT_START_TOL;
    nFlats := Succ(Trunc(TotalDist / CopeSize));
  end;

  Dist := CopeSize;
  if (nFlats > 1) then
    Dist := (TotalDist - CopeSize) / pred(nFlats);

  MidPt := MidPoint2D(StartPt, EndPt);
  with Entity[IntersectItem.OriginalIndex]do
  begin
    if (bEndFlat) then
      p := Point2DFromParametricEquation(StartPt, V, -FLAT_START_TOL + CopeSize/2)
    else if (nFlats > 1) then
      p := Point2DFromParametricEquation(StartPt, V, CopeSize/2)
    else
      p := MidPt;
    for i:=1 to nFlats do
    begin
      if PointOnLine(I34, p, 1) then
        AddOp(IntersectItem.OriginalIndex, okCope, p);
      p := Point2DFromParametricEquation(p, V, Dist);
    end;
  end;
end;

//* Find all the flats in the StaticItem and the IntersectItem
procedure FindFlattenPoints;
var
  SLine12, SLine34, L12,L34: LineType2D;
  bFlatDone: Boolean;
  V14: Vector2D;
begin
  if not bFrames then
    exit;

  with Entity[StaticItem.OriginalIndex]do
  begin
    V14 := Vector2DFrom2DPoints(Pt[1], Pt[4]);
    SLine34.Pt[1] := Point2DFromParametricEquation(Pt[3], V14, LipSize);
    SLine34.Pt[2] := Point2DFromParametricEquation(Pt[4], V14, LipSize);
  end;

  with Entity[IntersectItem.OriginalIndex]do
  begin
    V14 := Vector2DFrom2DPoints(Pt[1], Pt[4]);
    L12.Pt[1] := Point2DFromParametricEquation(Pt[1], V14, -CopeNotchTol);
    L12.Pt[2] := Point2DFromParametricEquation(Pt[2], V14, -CopeNotchTol);
    L34.Pt[1] := Point2DFromParametricEquation(Pt[4], V14, CopeNotchTol);
    L34.Pt[2] := Point2DFromParametricEquation(Pt[3], V14, CopeNotchTol);
  end;

  bFlatDone := FindStaticItemFlattenPoints(SLine34, L12, L34);
  if not bFlatDone then
  begin
    with Entity[IntersectItem.OriginalIndex]do
    begin
      L34.Pt[1] := Point2DFromParametricEquation(Pt[4], V14, LipSize);
      L34.Pt[2] := Point2DFromParametricEquation(Pt[3], V14, LipSize);
    end;
    with Entity[StaticItem.OriginalIndex]do
    begin
      V14 := Vector2DFrom2DPoints(Pt[1], Pt[4]);
      SLine12.Pt[1] := Point2DFromParametricEquation(Pt[1], V14, -CopeNotchTol);
      SLine12.Pt[2] := Point2DFromParametricEquation(Pt[2], V14, -CopeNotchTol);
    end;
    FindIntersectItemFlattenPoints(L34, SLine12, SLine34);
  end;
end;

//* Return the perpendicular distance p is from Entity[Idx].Pt[1]
function DistFromEnd1(Idx: Word; p: Point2D): Double;
var
  End1Line: LineType2D;  //First end out of the machine
  mid14, mid23: Point2D;
begin
  with Entity[Idx]do
  begin
    //Choose the line closest to the left, or bottom if Vertical as the End1Line
    //and set Pos from there
    mid14 := MidPoint2D(Pt[1], Pt[4]);    mid23 := MidPoint2D(Pt[2], Pt[3]);
    End1Line.Pt[1] := Pt[1];  End1Line.Pt[2] := Pt[4];
    if not (Entity[Idx].IsVertical)then
    begin
      if mid23.x < mid14.x then
      begin
        End1Line.Pt[1] := Pt[2];  End1Line.Pt[2] := Pt[3];
      end;
    end
    else begin
      if mid23.y < mid14.y then
      begin
        End1Line.Pt[1] := Pt[2];  End1Line.Pt[2] := Pt[3];
      end;
    end;
  end;
  Result := abs(PerpDistance(End1Line.Pt[1], End1Line.Pt[2], p));
end;

function SwageSize: Double;
begin
  Result := PanelSwageSize;
  if not bFrames then
    Result := TrussSwageSize;
end;

function NearSwagePtExists(Idx: Word; APt: Point2D): Boolean;
const
  TOL=0.01;
var
  bLoFound, bHiFound: Boolean;
  dPt, d: Double;
  i: Word;
begin
  Result := False;
  if Entity[Idx].OpCount < 1 then
    exit;
  bLoFound := False;  bHiFound := False;
  dPt := LineLength2D(Entity[Idx].Pt[1], APt);
  for i := 1 to Entity[Idx].OpCount do
  with Entity[Idx]do
    if (Op[i].Kind = okSwage)then
    begin
      d := LineLength2D(Entity[Idx].Pt[1], Op[i].p);
      if ((not bLoFound)and(d <= dPt + TOL)and(abs(dPt - d) < (SwageSize/2) - 3))then
        bLoFound :=  True;
      if ((not bHiFound)and(d >= dPt - TOL)and(abs(d - dPt) < (SwageSize/2) - 3))then
        bHiFound :=  True;
      if (bLoFound and bHiFound)then
      begin
        Result := True;
        exit;
      end;
    end;
end;

function AreUsingSwage: Boolean;
begin
  Result := (bFrames and bPanelUseSwage)
         or ((not bFrames) and bTrussUseSwage);
end;

procedure AddSwageToItem(Idx: Word; APt: Point2D);
var
  i: Word;
begin
  if (not AreUsingSwage)or NearSwagePtExists(Idx, APt) then
    exit;

  //prevent extremely long swages way off the end of the item             // 0.5 TOL
  if not PointOnLine(Entity[Idx].Pt[1], Entity[Idx].Pt[2], APt, (SwageSize / 2) + 0.5) then
    exit;

  for i := 1 to Entity[Idx].OpCount do
  with Entity[Idx]do     //prevent duplicate swages
    if (Op[i].Kind = okSwage) and PointsAreSame(Op[i].p, APt)then
      exit;

  AddOp(Idx, okSwage, APt);
end;

//* Return the lipline opposite Pt[3]-Pt[4]
function GetFlattenedLipLine(Idx: Integer): LineType2D;
var
  V: Vector2D;
begin
  V := Vector2DFrom2DPoints(Entity[Idx].Pt[1], Entity[Idx].Pt[4]);
  Result.Pt[1] := Point2DFromParametricEquation(Entity[Idx].Pt[4], V, LipSize + CopeNotchTol);
  Result.Pt[2] := Point2DFromParametricEquation(Entity[Idx].Pt[3], V, LipSize + CopeNotchTol);
end;

//* Add Swages to the Entity items
procedure FindSwages;
  //-------------------------------------------
  //if 2 possible swages meet, the one without flats is inside and should be swaged
  function SwageWouldMatchFlat(EndIdx: Byte; Idx: Integer): Boolean;
  var
    n: Byte;
    APtDist, AFlatDist: Double;
    p: Point2D;
  begin
    Result := False;
    p := Entity[Idx].Pt[EndIdx];
    if not PointIsOrigin(Entity[Idx].Notch[EndIdx])then
      p := Entity[Idx].Notch[EndIdx];
    APtDist := DistFromEnd1(Idx, p);
    for n:=1 to Entity[Idx].OpCount do
      if Entity[Idx].Op[n].Kind = okCope then
      begin
        AFlatDist := DistFromEnd1(Idx, Entity[Idx].Op[n].p);
        if abs(AFlatDist - APtDist) < (CopeSize / 2) + 1 then
        begin
          Result := True;
          break;
        end;
      end;
  end;
  //-------------------------------------------
var
  I12, J12, FlattenedLipLineI, FlattenedLipLineJ : LineType2D;
  d1, d2, MinSwageDist, dPossibleSwage: Double;
  i,j: Integer;
  Intercept: Point2D;
  bDone: Boolean;
begin
  if (not AreUsingSwage) then
    exit;

  for i:=0 to High(Entity) do
  begin
    I12.Pt[1] := Entity[i].Pt[1];   I12.Pt[2] := Entity[i].Pt[2];
    FlattenedLipLineI := GetFlattenedLipLine(i);
    for j:=succ(i) to High(Entity) do
    begin
      bDone := False;
      J12.Pt[1] := Entity[j].Pt[1];   J12.Pt[2] := Entity[j].Pt[2];
      d1 := abs(PerpDistanceToLine(I12, Entity[j].Pt[1])) - LipSize;
      d2 := abs(PerpDistanceToLine(I12, Entity[j].Pt[2])) - LipSize;
      MinSwageDist := Entity[i].Web - 2;
      if (d1 < MinSwageDist)or(d2 < MinSwageDist)then
      begin
        if FindIntercept(J12, FlattenedLipLineI, Intercept)    //I34
        and(PointOnLine(J12, Intercept, 1))and(PointOnLine(FlattenedLipLineI, Intercept, 1))then   //I34
        begin
          if (d1 < d2)then
          begin
            if (not SwageWouldMatchFlat(1, j)) then
            begin
              Entity[j].Swage[1] := True;
              dPossibleSwage := LineLength2D(Entity[j].Pt[1], Intercept);
              if dPossibleSwage > Entity[j].PosSwage[1] then
                Entity[j].PosSwage[1] := dPossibleSwage;    //temp store the intercept
              if (d1 > 0)and(not PointIsOrigin(Entity[j].PossibleSwagePt)) then
              if LineLength2D(Entity[j].Pt[1], Entity[j].PossibleSwagePt)
               < LineLength2D(Entity[j].Pt[2], Entity[j].PossibleSwagePt)then //closer to the 1 end
              begin
                dPossibleSwage := LineLength2D(Entity[j].Pt[1], Entity[j].PossibleSwagePt);
                if dPossibleSwage > Entity[j].PosSwage[1] then
                  Entity[j].PosSwage[1] := dPossibleSwage + CopeNotchTol;
              end;
              bDone := True;
            end;
          end
          else begin
            if (not SwageWouldMatchFlat(2, j)) then    //this never seems to get hit in the fan tests
            begin
              Entity[j].Swage[2] := True;
              dPossibleSwage := LineLength2D(Entity[j].Pt[2], Intercept);
              if dPossibleSwage > Entity[j].PosSwage[2] then
                Entity[j].PosSwage[2] := dPossibleSwage;
              if (d2 > 0)and(not PointIsOrigin(Entity[j].PossibleSwagePt)) then
              if LineLength2D(Entity[j].Pt[2], Entity[j].PossibleSwagePt)
               < LineLength2D(Entity[j].Pt[1], Entity[j].PossibleSwagePt)then //closer to the 2 end
              begin
                dPossibleSwage := LineLength2D(Entity[j].Pt[2], Entity[j].PossibleSwagePt);
                if dPossibleSwage > Entity[j].PosSwage[2] then
                  Entity[j].PosSwage[2] := dPossibleSwage + CopeNotchTol;
              end;
              bDone := True;
            end;
          end;
        end;
      end;

      if (not bDone) then  //try the items the other way round, for the corner items
      begin
        d1 := abs(PerpDistanceToLine(J12, Entity[i].Pt[1])) - LipSize;
        d2 := abs(PerpDistanceToLine(J12, Entity[i].Pt[2])) - LipSize;
        FlattenedLipLineJ := GetFlattenedLipLine(j);     //
        MinSwageDist := Entity[j].Web - 2;
        if (d1 < MinSwageDist)or(d2 < MinSwageDist)then
        begin
          if FindIntercept(I12, FlattenedLipLineJ, Intercept)      //     J34
          and(PointOnLine(I12, Intercept, 1))and(PointOnLine(FlattenedLipLineJ, Intercept, 1))then    //   J34
          begin
            if (d1 < d2)then
            begin
              if (not SwageWouldMatchFlat(1, i)) then
              begin
                Entity[i].Swage[1] := True;
                dPossibleSwage := LineLength2D(Entity[i].Pt[1], Intercept);
                if dPossibleSwage > Entity[i].PosSwage[1] then
                  Entity[i].PosSwage[1] := dPossibleSwage;
                if (d1 > 0)and(not PointIsOrigin(Entity[i].PossibleSwagePt)) then
                if LineLength2D(Entity[i].Pt[1], Entity[i].PossibleSwagePt)
                 < LineLength2D(Entity[i].Pt[2], Entity[i].PossibleSwagePt)then //closer to the 1 end
                begin
                  dPossibleSwage := LineLength2D(Entity[i].Pt[1], Entity[i].PossibleSwagePt);
                  if dPossibleSwage > Entity[i].PosSwage[1] then
                    Entity[i].PosSwage[1] := dPossibleSwage + CopeNotchTol;
                end;
              end;
            end
            else begin
              if (not SwageWouldMatchFlat(2, i)) then
              begin
                Entity[i].Swage[2] := True;
                dPossibleSwage := LineLength2D(Entity[i].Pt[2], Intercept);
                if dPossibleSwage > Entity[i].PosSwage[2] then
                  Entity[i].PosSwage[2] := dPossibleSwage;
                if (d2 > 0)and(not PointIsOrigin(Entity[i].PossibleSwagePt)) then  //this never seems to get hit in the fan tests
                if LineLength2D(Entity[i].Pt[2], Entity[i].PossibleSwagePt)
                 < LineLength2D(Entity[i].Pt[1], Entity[i].PossibleSwagePt)then //closer to the 2 end
                begin
                  dPossibleSwage := LineLength2D(Entity[i].Pt[2], Entity[i].PossibleSwagePt);
                  if dPossibleSwage > Entity[i].PosSwage[2] then
                    Entity[i].PosSwage[2] := dPossibleSwage + CopeNotchTol;
                end;
              end;
            end;
          end;
        end;
      end;

    end;  //for j:=
  end;
end;

//* See if the StaticItem needs further extension
//* Return the amount if it does, or 0 if not
function GetStaticItemExtension: Double;
var
  MinDist, MaxDist,         // (ToOtherEnd)
  OptHoleDist, Len, D: Double;
  d14, d23: Double;
  GapLine, Edge, NearEdgeLine, FarEdgeLine: LineType2D;
  Intercept: Point2D;
  V1, V2: Vector2D;
begin
  Result := 0;
  try
    with StaticItem do
    begin
      d14 := abs(PerpDistance(Pt[1], Pt[4], HolePt));
      d23 := abs(PerpDistance(Pt[2], Pt[3], HolePt));

      OptHoleDist := d23;
      if (ExtendEnd = tt23) then
        OptHoleDist := d14;

      Len := LineLength2D(Pt[1], Pt[2]);
      MinDist := MinEndDist + OptHoleDist;
    end;

    FarEdgeLine := IntersectItem.Line(1,2);
    NearEdgeLine:= IntersectItem.Line(4,3);
    if IntersectItem.IntersectEdge = et12 then
    begin
      FarEdgeLine := IntersectItem.Line(4,3);
      NearEdgeLine:= IntersectItem.Line(1,2);
    end;
    if bTipsMeet then
    if ItemsArePerpendicular then
    begin
      if (MinDist > Len) then
        Result := OptHoleDist + abs(PerpDistance(FarEdgeLine.Pt[1], FarEdgeLine.Pt[2], StaticItem.HolePt)) - Len;
      exit;
    end;

    V1 := Vector2DFrom2DPoints(FarEdgeLine.Pt[1], NearEdgeLine.Pt[1]);
    V2 := Vector2DFrom2DPoints(FarEdgeLine.Pt[2], NearEdgeLine.Pt[2]);
    D := JointGap;
    if bFrames and StaticItem.IsVertical then
      D := VertJointGap;
    GapLine.Pt[1] := Point2DFromParametricEquation(FarEdgeLine.Pt[1], V1, D);
    GapLine.Pt[2] := Point2DFromParametricEquation(FarEdgeLine.Pt[2], V2, D);

    Edge.Pt[1] := StaticItem.Pt[1];   Edge.Pt[2] := StaticItem.Pt[2];
    if IntersectItem.IntersectEdge = et34 then
    begin
      Edge.Pt[1] := StaticItem.Pt[3];   Edge.Pt[2] := StaticItem.Pt[4];
    end;
    MaxDist := MinDist; //default value
    if FindIntercept(GapLine, Edge, Intercept) then
      MaxDist := abs(PerpDistance(StaticItem.FarTipLine, Intercept));
    if (MaxDist - Len) > 50 then
      MaxDist := MinDist;

    if MaxDist < MinDist then  //an error occured, if there's no tab
    begin
      if (not bTipsMeet)then
        exit;
    end;

    Result := MinDist - Len;
  finally
    if (Result > MAX_EXTEND_DIST) then      //prevent infinitely long extension results
      Result := 0;
  end;
end;

//* Change the length of the StaticItem, -ve ExtByDist shortens it
procedure ExtendStaticItem(ExtByDist: Double);
var
  v: Vector2D;
begin
  with StaticItem do
  begin
    ExtByDist := ExtByDist + LineLength2D(Pt[1], Pt[2]);
    if ExtendEnd = tt14 then
    begin
      v := Vector2DFrom2DPoints(Pt[2], Pt[1]);
      Pt[1] := Point2DFromParametricEquation(Pt[2], v, ExtByDist);
      Pt[4] := Point2DFromParametricEquation(Pt[3], v, ExtByDist);
    end
    else begin
      v := Vector2DFrom2DPoints(Pt[1], Pt[2]);
      Pt[2] := Point2DFromParametricEquation(Pt[1], v, ExtByDist);
      Pt[3] := Point2DFromParametricEquation(Pt[4], v, ExtByDist);
    end;
  end;
end;

{
Punch Hole Indices
Truss
.....
           Static
         Flg | Lip
     Flg  1  |  2
Int  --------+------
     Lip  3  |  4
..................
Panel, i.e bFrames = T
.....
           Static
         Flg | Lip
     Flg  4  |  3
Int  --------+------
     Lip  2  |  1
}

//* Select a hole positions from the Punch array and store it in HolePt
//* There are 4 possibles for trusses, 1 for panels
procedure FindOptHole;
const
  TINY_TOL=0.001;    //Flg-Flg for when the hole diff is v. small,
                     //could be tinier, last prob was 10 trillionth of a mm
  //OPT_D=-1;//-0.5;   //Give preference to the flange, now not reqd. v72
                //-ve for Lip
                //was -0.000001 pre v136;
var
  OptHole: Point2D;
  //---------------------------------------------------------------
  function CheckForMatchingPoint(PtArray: array of Point2D): Boolean;
  var
    n, k: Byte;
  begin
    for n:=0 to pred(MAX_HOLES) do  //array is dynamic, so 1..120 becomes 0..119
    begin
      if PointIsOrigin( PtArray[n] ) then
        break;
      for k:=1 to 4 do
        if LineLength2D(Punch[k], PtArray[n]) < 1 then
        begin
          HoleIdx := k;
          OptHole := Punch[k];
          break;
        end;
      if HoleIdx > 0 then
        break;
    end;
    Result := (HoleIdx > 0);
    if Result then
    begin
      dec(TotalRivets);
      IntersectItem.IsFlangeHole := (HoleIdx in [1,2]); //True;  //1,2 are flg side of IntersectItem
      IntersectItem.HolePt := OptHole;
    end;
  end;
  //---------------------------------------------------------------
var
  i: Byte;
  d, smallestDist, d14, d23: Double;
  RadiansApart, DegreesApart: Extended;
begin
  FindHoles;

  HoleIdx := 0;
  if bFrames then
  begin
    if CheckForMatchingPoint( Entity[StaticItem.OriginalIndex].FHoles ) then
      if (not bMultiHoleFlagged) then
        exit;
    if CheckForMatchingPoint( Entity[StaticItem.OriginalIndex].LHoles ) then
      if (not bMultiHoleFlagged) then
        exit;
  end;

  HoleIdx := 1;  //Lip / Lip for panel, Flg/Flg for Truss
  smallestDist := abs(PerpDistance(IntersectItem.FarTipLine, Punch[1]));  // - TINY_TOL;
  if bFrames then  //panel
  begin
    if(not ItemsArePerpendicular) then
    begin
      for i:=2 to 4 do
      begin
        d := abs(PerpDistance(IntersectItem.FarTipLine, Punch[i]));
        if (d < smallestDist) then
        begin
          smallestDist := d;
          HoleIdx := i;
        end;
      end;
    end;
  end
  else begin       //truss, leave as it was with no test for perp, and the AcuteDist included
    for i:=2 to 4 do
    begin
      d := abs(PerpDistance(IntersectItem.FarTipLine, Punch[i]));
      if i=4 then
        d := d - AcuteDist;  //4.49; //14 degrees
      if (d < smallestDist) then
      begin
        smallestDist := d;
        HoleIdx := i;
      end;
    end;
  end;

  if (not bFrames) and bTipsMeet then
  begin
    if (HoleIdx <> 4) and (StaticItem.CloserEdge = et34) then  // fixes protruding corner
      HoleIdx := 4
    else begin
      d23 := LineLength2D(Punch[2], Punch[3]);
      if Round(d23)  > 0 then
      begin
        d14 := LineLength2D(Punch[1], Punch[4]);
        RadiansApart := 2 * (ArcTan(d14 / d23));
        DegreesApart := RadiansApart * 180 / pi;
        if DegreesApart < MaxAngleApart then
          HoleIdx := 1;                     //Flg-Flg (for Trusses)
      end;
    end;
  end;
  // fixes protruding corner
  if bFrames and bTipsMeet and (HoleIdx <> 1)     //bFlgTipsMeet gives identical fan test results
  and(StaticItem.CloserEdge = et34) then
    HoleIdx := 1;

  if nForcedHoleIdx in [1..4] then
    HoleIdx := nForcedHoleIdx;

  OptHole := Punch[HoleIdx];

  StaticItem.IsFlangeHole := Odd(HoleIdx);    //1,3 are flg side of StaticItem
  IntersectItem.IsFlangeHole := HoleIdx < 3;  //1,2 are flg side of IntersectItem

  StaticItem.HolePt := OptHole;
  IntersectItem.HolePt := OptHole;
end;

//* Add the point to either the FHoles or the LHoles array
procedure AddHole(EntityIdx: Word; p: Point2D; bIsFlange: Boolean);
var
  NextHoleIdx: Byte;
begin
  NextHoleIdx := 1;
  with Entity[EntityIdx]do
  begin
    if bIsFlange then
    begin
      while not PointIsOrigin(FHoles[NextHoleIdx]) do
        inc(NextHoleIdx);
      FHoles[NextHoleIdx] := p;
    end
    else begin
      while not PointIsOrigin(LHoles[NextHoleIdx]) do
        inc(NextHoleIdx);
      LHoles[NextHoleIdx] := p;
    end;
  end;
end;

//* Return True if Entity[Idx1] and Entity[Idx2] are butted
function EntitiesAreButted(Idx1, Idx2: Word): Boolean;
{----------------------------------------------------}
//* Only used in EntitiesAreButted,
//* ShortenItem is used in Unit scope to move holes too
  procedure ExtendItemRect(Idx: Word; ExtByDist: Double; ATip: TipType);
  var
    V: Vector2D;
  begin
    with Entity[Idx] do
    begin
      ExtByDist := ExtByDist + LineLength2D(Pt[1], Pt[2]);
      V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
      if ATip = tt14 then
      begin
        Pt[1] := Point2DFromParametricEquation(Pt[2], v, -ExtByDist);
        Pt[4] := Point2DFromParametricEquation(Pt[3], v, -ExtByDist);
      end
      else begin
        Pt[2] := Point2DFromParametricEquation(Pt[1], v, ExtByDist);
        Pt[3] := Point2DFromParametricEquation(Pt[4], v, ExtByDist);
      end;
    end;
  end;
{----------------------------------------------------}
const
  TOL=1;
var
  p, q: array[1..4]of Point2D;
  i: Byte;
  AHolePt: Point2D;
begin
  Result := False;
  for i:=1 to 4 do    //just to simplify the LineLength2D evaluations
  begin
    p[i] := Entity[Idx1].Pt[i];    q[i] := Entity[Idx2].Pt[i];
  end;

  //Note: Below Extends need to be done before adding the Notch and Cope
  //Also before adding the holes (or use ShortenItem with -ve dist)
  if (LineLength2D(p[2], q[1]) < TOL) and (LineLength2D(p[3], q[4]) < TOL)then
  begin
    Result := True;
    AHolePt := Point2DFromParametricEquation(p[2], Vector2DFrom2DPoints(p[2], p[3]), FlgHolePos);
    //extend Entity[Idx1] at et23,  extend Entity[Idx2] at et14
    ExtendItemRect(Idx1, MinEndDist, tt23);
    ExtendItemRect(Idx2, MinEndDist, tt14);
    if Entity[Idx1].Pt[2].y < Entity[Idx2].Pt[2].y then  //Notch the lower end
    begin             
      Entity[Idx1].Notch[2] := Entity[Idx2].Pt[1];
      Entity[Idx2].Cope[1] := Entity[Idx1].Pt[3];
    end
    else begin
      Entity[Idx1].Cope[2] := Entity[Idx2].Pt[4];
      Entity[Idx2].Notch[1] := Entity[Idx1].Pt[2];
    end;
  end
  else
  if (LineLength2D(p[2], q[2]) < TOL) and (LineLength2D(p[3], q[3]) < TOL)then
  begin
    Result := True;
    AHolePt := Point2DFromParametricEquation(p[2], Vector2DFrom2DPoints(p[2], p[3]), FlgHolePos);
    //extend Entity[Idx1] at et23,  extend Entity[Idx2] at et23
    ExtendItemRect(Idx1, MinEndDist, tt23);
    ExtendItemRect(Idx2, MinEndDist, tt23);
    if Entity[Idx1].Pt[2].y < Entity[Idx2].Pt[1].y then  //Notch the lower end
    begin
      Entity[Idx1].Notch[2] := Entity[Idx2].Pt[2];
      Entity[Idx2].Cope[2] := Entity[Idx1].Pt[3];
    end
    else begin
      Entity[Idx1].Cope[2] := Entity[Idx2].Pt[3];
      Entity[Idx2].Notch[2] := Entity[Idx1].Pt[2];
    end;
  end
  else
  if (LineLength2D(p[1], q[1]) < TOL) and (LineLength2D(p[4], q[4]) < TOL)then
  begin
    Result := True;
    AHolePt := Point2DFromParametricEquation(p[1], Vector2DFrom2DPoints(p[1], p[4]), FlgHolePos);
    //extend Entity[Idx1] at et14,  extend Entity[Idx2] at et14
    ExtendItemRect(Idx1, MinEndDist, tt14);
    ExtendItemRect(Idx2, MinEndDist, tt14);
    if Entity[Idx1].Pt[1].y < Entity[Idx2].Pt[2].y then  //Notch the lower end
    begin
      Entity[Idx1].Notch[1] := Entity[Idx2].Pt[1];
      Entity[Idx2].Cope[1] := Entity[Idx1].Pt[4];
    end
    else begin
      Entity[Idx1].Cope[1] := Entity[Idx2].Pt[4];
      Entity[Idx2].Notch[1] := Entity[Idx1].Pt[1];
    end;
  end
  else
  if (LineLength2D(p[1], q[2]) < TOL) and (LineLength2D(p[4], q[3]) < TOL)then
  begin
    Result := True;
    AHolePt := Point2DFromParametricEquation(p[1], Vector2DFrom2DPoints(p[1], p[4]), FlgHolePos);
    //extend Entity[Idx1] at et14,  extend Entity[Idx2] at et23
    ExtendItemRect(Idx1, MinEndDist, tt14);
    ExtendItemRect(Idx2, MinEndDist, tt23);
    if Entity[Idx1].Pt[1].y < Entity[Idx2].Pt[1].y then  //Notch the lower end
    begin
      Entity[Idx1].Notch[1] := Entity[Idx2].Pt[2];
      Entity[Idx2].Cope[2] := Entity[Idx1].Pt[4];
    end
    else begin
      Entity[Idx1].Cope[1] := Entity[Idx2].Pt[3];
      Entity[Idx2].Notch[2] := Entity[Idx1].Pt[1];
    end;
  end;

  if Result then
  begin
    AddHole(Idx1, AHolePt, True);    AddHole(Idx2, AHolePt, True);
  end;
end;

//* Store the width of the Entity items
procedure MeasureWebs;
var
  i: Integer;
begin
  for i:=0 to High(Entity) do
  with Entity[i]do
    Web := abs( PerpDistance(Pt[1], Pt[2], MidPoint2D(Pt[3], Pt[4])) );
end;

//* Store the length of the Entity items
procedure MeasureLens;
var
  i: Integer;
begin
  for i:=0 to High(Entity) do
  with Entity[i]do
    Len := LineLength2D(Pt[1], Pt[2]);
end;

//* Remove Entity[Idx].FHoles[AHoleIdx]
procedure RemoveFlangeHole(Idx: Integer; AHoleIdx: Byte);
var
  i: Byte;
begin
  i := AHoleIdx;
  while not PointIsOrigin(Entity[Idx].FHoles[i]) do
  begin     //move all the holes in the array up one index
    Entity[Idx].FHoles[i] := Entity[Idx].FHoles[succ(i)];
    Entity[Idx].PosFHoles[i] := Entity[Idx].PosFHoles[succ(i)];
    inc(i);
  end;
end;

//* Remove Entity[Idx].LHoles[AHoleIdx]
procedure RemoveLipHole(Idx: Integer; AHoleIdx: Byte);
var
  i: Byte;
begin
  i := AHoleIdx;
  while not PointIsOrigin(Entity[Idx].LHoles[i]) do
  begin     //move all the holes in the array up one index
    Entity[Idx].LHoles[i] := Entity[Idx].LHoles[succ(i)];
    Entity[Idx].PosLHoles[i] := Entity[Idx].PosLHoles[succ(i)];
    inc(i);
  end;
end;

//* Set the PosFHoles and PosLHoles array values
//* Returns -1 if any of the hole positions is greater than the MinEndDist
function SetPosHoles: Integer;
const
  TOL=0.1;
  //--------------------------------------
  function PosOfHoleIsNotOK(d: Double; Idx: Integer): Boolean;
  var
    Dist: Double;
  begin
    Result := False;
    if (not bFrames)then
      exit;
    if (bFrames)and(bIgnoreMinEndDistErrors)then
      exit;
    Dist := MinEndDist;
    if bFrames then
      Dist := HoleSize;
    Result := (d < Dist - TOL)
           or (d > Entity[Idx].Len - Dist + TOL);
  end;
  //--------------------------------------
var
  i: Integer;
  j: Byte;
  AHoleDist: Double;
begin
  Result := RESULT_OK; //0;
  for i:=0 to High(Entity) do
  with Entity[i]do
  begin
    j:=1;
    while not PointIsOrigin(FHoles[j])do
    begin
      AHoleDist := DistFromEnd1(i, FHoles[j]);
      if PosOfHoleIsNotOK(AHoleDist, i)then
      begin
        RemoveFlangeHole(i, j);
        Result := RESULT_NOT_FOUND;  //-1;
        if (not bFrames)then
          SLErrorItems.Add(format('PosFHoles[%d] error in %s',[j, Item]))
        else
          SLErrorItems.Add(format('PosHoles[%d] error in %s',[j, Item]));
      end
      else begin
        PosFHoles[j] := AHoleDist;
        inc(j);
        if (j > MAX_HOLES) then
        begin
          Result := RESULT_RANGE_ERR;  //-5
          SLErrorItems.Add(format('Too many Flange Holes in %s', [Item]));
          break;
        end;
      end;
      if Result > -1 then   //only increase if all's OK
        inc(Result);
    end;
    j:=1;
    while not PointIsOrigin(LHoles[j])do
    begin
      AHoleDist := DistFromEnd1(i, LHoles[j]);
      if PosOfHoleIsNotOK(AHoleDist, i)then
      begin
        RemoveLipHole(i, j);
        Result := RESULT_NOT_FOUND;  //-1;
        if (not bFrames)then
          SLErrorItems.Add(format('PosLHoles[%d] error in %s',[j, Item]))
        else
          SLErrorItems.Add(format('PosHoles[%d] error in %s',[j, Item]));
      end
      else begin
        PosLHoles[j] := AHoleDist;
        inc(j);
        if (j > MAX_HOLES) then
        begin
          Result := RESULT_RANGE_ERR;  //-5
          SLErrorItems.Add(format('Too many Lip Holes in %s', [Item]));
          break;
        end;
      end;
      if Result > -1 then     //only increase if all's OK
        inc(Result);
    end;
  end;
end;

//* Add mitre notches and copes to the Entity array
//* happens for trapeziums
procedure AddMitreNotchesAndCopes;
const
  TOL=1;
var
  i: Integer;
  j: Byte;
  bHasNotch, bHasCope, bHasMitreNotch, bHasMitreCope: Boolean;
  p: Point2D;
begin
  for i:=0 to High(Entity) do
  with Entity[i]do
  begin
    for j:=1 to 2 do
    begin
      bHasMitreNotch := not PointIsOrigin(MitreNotch[i,j]);
      //Check the notch still exists after the lengths have been optimised
      bHasMitreNotch := bHasMitreNotch and PointOnLine(Pt[1], Pt[2], MitreNotch[i,j], TOL);
      if bHasMitreNotch then
      begin
        bHasNotch := not PointIsOrigin(Notch[j]);
        if not bHasNotch then
          Notch[j] := MitreNotch[i,j]
        else begin //bHasNotch
          if LineLength2D(Pt[j], MitreNotch[i,j]) > LineLength2D(Pt[j], Notch[j]) then
            Notch[j] := MitreNotch[i,j];
        end;
      end;
    end;

    for j:=1 to 2 do
    begin
      bHasMitreCope := not PointIsOrigin(MitreCope[i,j]);
      bHasMitreCope := bHasMitreCope and PointOnLine(Pt[3], Pt[4], MitreCope[i,j], TOL);
      if bHasMitreCope then
      begin
        p := Pt[4];
        if j=2 then p := Pt[3];
        bHasCope := not PointIsOrigin(Cope[j]);
        if not bHasCope then
          Cope[j] := MitreCope[i,j]
        else begin //bHasCope
          if LineLength2D(p, MitreCope[i,j]) > LineLength2D(p, Cope[j]) then
            Cope[j] := MitreCope[i,j];
        end;
      end;
    end;
  end;
end;

//* Set the PosNotch and PosCope array values
//* Returns false if a range error was encountered
function SetPosNotchAndPosCope: Boolean;
const
  MIN_OVERLAP = 0.5;  //0.5mm min overlap between notches and copes, to stop sharp bits when ther are multiple notches or copes
var
  LastCut, FirstCut, CutLength,
  HalfNotch, HalfCope, Delta, ForcedOverlap: Double;
  i,j, nCuts1, nCuts2: Integer;
  bSwap: Boolean;
begin
  Result := True;
  HalfNotch := NotchSize / 2;
  HalfCope := CopeSize / 2;
  ForcedOverlap := NOTCH_START_TOL + CutWidth;  //pull notches back 7mm to stop making little sharp bits
  for i:=0 to High(Entity) do
  with Entity[i]do
  begin
    //bSwap means End1 is not Pt[1],Pt[4]
    bSwap := DistFromEnd1(i, Pt[1]) > 1;
    //Notches
    nCuts1 := 0;
    if not PointIsOrigin(Notch[1]) then
    begin
      if bSwap then
      begin
        FirstCut := LineLength2D(Pt[2], Notch[1]);
        LastCut := Len + ForcedOverlap;
      end
      else begin
        FirstCut := -ForcedOverlap;
        LastCut := LineLength2D(Pt[1], Notch[1]);
      end;
      CutLength := abs(LastCut - FirstCut);
      nCuts1 := succ( Trunc(CutLength / NotchSize) );
      if nCuts1 > High(PosNotch)then     //ERROR
      begin
        SLErrorItems.Add(format('Notches exceed range error in %s',[Item]));
        Result := False;
        nCuts1 := High(PosNotch);
      end;
      if nCuts1 > 0 then
      begin
        PosNotch[1] := FirstCut + HalfNotch;
        if (nCuts1 > 1)or bSwap then
        begin
          Delta := (LastCut - FirstCut - NotchSize) / pred(nCuts1);
          while (NotchSize - Delta) < MIN_OVERLAP do
          begin
            inc(nCuts1);
            Delta := (LastCut - FirstCut - NotchSize) / pred(nCuts1);
          end;
          for j:=2 to pred(nCuts1) do
            PosNotch[j] := PosNotch[pred(j)] + Delta;
          PosNotch[nCuts1] := LastCut - HalfNotch;
        end;
      end;
    end;   //if not PointIsOrigin(Notch[1])

    if not PointIsOrigin(Notch[2]) then
    begin
      if bSwap then
      begin
        FirstCut := -ForcedOverlap;
        LastCut := LineLength2D(Pt[2], Notch[2]);
      end
      else begin
        FirstCut := LineLength2D(Pt[1], Notch[2]);
        LastCut := Len + ForcedOverlap;
      end;
      CutLength := abs(LastCut - FirstCut);
      nCuts2 := succ( Trunc(CutLength / NotchSize) );
      if nCuts2 > High(PosNotch)then     //ERROR
      begin
        SLErrorItems.Add(format('Notches exceed range error in %s',[Item]));
        Result := False;
        nCuts2 := High(PosNotch);
      end;
      if nCuts2 > 0 then
      begin
        PosNotch[succ(nCuts1)] := FirstCut + HalfNotch;
        if (nCuts2 > 1)or (not bSwap) then
        begin
          Delta := (LastCut - FirstCut - NotchSize) / pred(nCuts2);
          while (NotchSize - Delta) < MIN_OVERLAP do
          begin
            inc(nCuts2);
            Delta := (LastCut - FirstCut - NotchSize) / pred(nCuts2); //recalculate
          end;
          for j:=2 to pred(nCuts2) do
            PosNotch[nCuts1+j] := PosNotch[pred(nCuts1+j)] + Delta;
          PosNotch[nCuts1+nCuts2] := LastCut - HalfNotch;
        end;
      end;
    end;  //if not PointIsOrigin(Notch[2])

    //Copes
    nCuts1 := 0;
    if not PointIsOrigin(Cope[1]) then
    begin
      if bSwap then
      begin
        FirstCut := LineLength2D(Pt[3], Cope[1]);
        LastCut := Len + ForcedOverlap;
      end
      else begin
        FirstCut := -ForcedOverlap;
        LastCut := LineLength2D(Pt[4], Cope[1]);
      end;
      CutLength := abs(LastCut - FirstCut);
      nCuts1 := succ( Trunc(CutLength / CopeSize) );
      if nCuts1 > High(PosCope)then     //ERROR
      begin
        if (not bFrames)then
          SLErrorItems.Add(format('Copes exceed range error in %s',[Item]))
        else
          SLErrorItems.Add(format('Flats exceed range error in %s',[Item]));
        Result := False;
        nCuts1 := High(PosCope);
      end;
      if nCuts1 > 0 then
      begin
        PosCope[1] := FirstCut + HalfCope;
        if (nCuts1 > 1)or bSwap then
        begin
          Delta := (LastCut - FirstCut - CopeSize) / pred(nCuts1);
          while (CopeSize - Delta) < MIN_OVERLAP do
          begin
            inc(nCuts1);
            Delta := (LastCut - FirstCut - CopeSize) / pred(nCuts1);
          end;
          for j:=2 to pred(nCuts1) do
            PosCope[j] := PosCope[pred(j)] + Delta;
          PosCope[nCuts1] := LastCut - HalfCope;
        end;
      end;
    end;  //if not PointIsOrigin(Cope[1])

    if not PointIsOrigin(Cope[2]) then
    begin
      if bSwap then
      begin
        FirstCut := -ForcedOverlap;
        LastCut := LineLength2D(Pt[3], Cope[2]);
      end
      else begin
        FirstCut := LineLength2D(Pt[4], Cope[2]);
        LastCut := Len + ForcedOverlap;
      end;
      CutLength := abs(LastCut - FirstCut);
      nCuts2 := succ( Trunc(CutLength / CopeSize) );
      if nCuts2 > High(PosCope)then      //ERROR
      begin
        if (not bFrames)then
          SLErrorItems.Add(format('Copes exceed range error in %s',[Item]))
        else
          SLErrorItems.Add(format('Flats exceed range error in %s',[Item]));
        Result := False;
        nCuts2 := High(PosCope);
      end;
      if nCuts2 > 0 then
      begin
        PosCope[succ(nCuts1)] := FirstCut + HalfCope;
        if (nCuts2 > 1)or (not bSwap) then
        begin
          Delta := (LastCut - FirstCut - CopeSize) / pred(nCuts2);
          while (CopeSize - Delta) < MIN_OVERLAP do
          begin
            inc(nCuts2);
            Delta := (LastCut - FirstCut - CopeSize) / pred(nCuts2); //recalculate
          end;
          for j:=2 to pred(nCuts2) do
            PosCope[nCuts1+j] := PosCope[pred(nCuts1+j)] + Delta;
          PosCope[nCuts1+nCuts2] := LastCut - HalfCope;
        end;
      end;
    end;  //if not PointIsOrigin(Cope[2])
  end;  //with Entity[i]do
end;

//* QuickSort routines
procedure SortHolesArrays(EntityIdx: Word; AType: PosAndPointType);
var
  i,j: Byte;
  aSort: array of SortPointsType;
begin
  i := 0;
  case AType of
    ppFlg: begin
             while Entity[EntityIdx].PosFHoles[succ(i)] > 0 do      //get all non-zero values
             begin
               SetLength(aSort, succ(i));
               aSort[i].SortNo := Entity[EntityIdx].PosFHoles[succ(i)];
               aSort[i].p      := Entity[EntityIdx].FHoles[succ(i)];
               inc(i);
             end;
           end;
    ppLip: begin
             while Entity[EntityIdx].PosLHoles[succ(i)] > 0 do      //get all non-zero values
             begin
               SetLength(aSort, succ(i));
               aSort[i].SortNo := Entity[EntityIdx].PosLHoles[succ(i)];
               aSort[i].p      := Entity[EntityIdx].LHoles[succ(i)];
               inc(i);
             end;
           end;
  end;

  if i<2 then  //don't need to sort 1 element
    exit;

  QuickSort(aSort);

  for j:=0 to pred(i) do
  begin
    case AType of
    ppFlg: begin
             Entity[EntityIdx].PosFHoles[succ(j)] := aSort[j].SortNo;
             Entity[EntityIdx].FHoles[succ(j)]    := aSort[j].p;
           end;
    ppLip: begin
             Entity[EntityIdx].PosLHoles[succ(j)] := aSort[j].SortNo;
             Entity[EntityIdx].LHoles[succ(j)]    := aSort[j].p;
           end;
    end;
  end;
end;

procedure SortNotchOrCopeArray(EntityIdx: Word; AType: NotchCopeType);
var
  i,j: Byte;
  aSort: array of Double;
begin
  i := 0;
  case AType of
    ncNotch: begin
               while (i < High(Entity[EntityIdx].PosNotch))
                 and (Entity[EntityIdx].PosNotch[succ(i)] > 0)do      //get all non-zero values
               begin
                 if i > Length(Entity[EntityIdx].PosNotch) then      //maybe this should raise an exception
                   break;
                 SetLength(aSort, succ(i));
                 aSort[i] := Entity[EntityIdx].PosNotch[succ(i)];
                 inc(i);
               end;
             end;
    ncCope:  begin
               while (i < High(Entity[EntityIdx].PosCope))
                 and (Entity[EntityIdx].PosCope[succ(i)] > 0)do      //get all non-zero values
               begin
                 if i > Length(Entity[EntityIdx].PosCope) then      //maybe this should raise an exception
                   break;
                 SetLength(aSort, succ(i));
                 aSort[i] := Entity[EntityIdx].PosCope[succ(i)];
                 inc(i);
               end;
             end;
  end;

  if i<2 then  //don't need to sort 1 element
    exit;

  QuickSort(aSort);

  case AType of
    ncNotch: if i > Length(Entity[EntityIdx].PosNotch) then
               i := Length(Entity[EntityIdx].PosNotch);      //ERROR
    ncCope:  if i > Length(Entity[EntityIdx].PosCope) then
               i := Length(Entity[EntityIdx].PosCope);       //ERROR
  end;

  for j:=0 to pred(i) do
    case AType of
      ncNotch: Entity[EntityIdx].PosNotch[succ(j)] := aSort[j];
      ncCope:  Entity[EntityIdx].PosCope[succ(j)]  := aSort[j];
    end;
end;

procedure SortHoles;
var
  i: Integer;
begin
  for i:=0 to High(Entity) do
  with Entity[i]do
  begin
    SortHolesArrays(i, ppFlg);
    SortHolesArrays(i, ppLip);
  end;
end;

procedure SortNotchesAndCopes;
var
  i: Integer;
begin
  for i:=0 to High(Entity) do
  with Entity[i]do
  begin
    SortNotchOrCopeArray(i, ncNotch);
    SortNotchOrCopeArray(i, ncCope);
  end;
end;

//* Filter the PosNotch array, so PosNotches within TOL are removed
procedure RemoveExtraNotches;
const
  TOL=NOTCH_START_TOL;      //same as the NOTCH_START_TOL
var
  i: Integer;
  j,k: Byte;
begin
  for i:=0 to High(Entity) do
  with Entity[i]do
  begin
    j := 1;
    while (PosNotch[j] > 0)and(j < High(PosNotch)) do
    begin
      if abs(PosNotch[j] - PosNotch[succ(j)]) <= TOL then
      begin
        PosNotch[j] := (PosNotch[succ(j)] + PosNotch[j]) / 2;
        k := succ(j);
        while (PosNotch[k] > 0)and(k < High(PosNotch)) do
        begin
          PosNotch[k] := PosNotch[succ(k)];
          inc(k);
        end;
        PosNotch[k] := 0;
      end
      else
        inc(j);
    end;
  end;
end;

//* Filter the PosCope array, so PosCopes within TOL are removed
procedure RemoveExtraCopes;
const     
  TOL=1;
var
  i: Integer;
  j,k: Byte;
begin
  for i:=0 to High(Entity) do
  with Entity[i]do
  begin
    j := 1;
    while (PosCope[j] > 0)and(j < High(PosCope)) do
    begin
      if abs(PosCope[j] - PosCope[succ(j)]) <= TOL then
      begin
        PosCope[j] := (PosCope[succ(j)] + PosCope[j]) / 2;  //halve the TOL dist
        k := succ(j);
        while (PosCope[k] > 0)and(k < High(PosCope)) do
        begin
          PosCope[k] := PosCope[succ(k)];
          inc(k);
        end;
        PosCope[k] := 0;
      end
      else
        inc(j);
    end;
  end;
end;

procedure AddEndLoadCuts;
var
  i: Integer;
  p: Point2D;
  V: Vector2D;
begin
  if (not bEndLoadCut)or(not bFrames) then
    exit;
  for i:=0 to High(Entity) do
    with Entity[i] do
    if IsVertical then
    begin
      V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
      p := Point2DFromParametricEquation(Pt[1], V, -CutWidth/2);
      AddOp(i, okSlot, p);
      p := Point2DFromParametricEquation(Pt[2], V,  CutWidth/2);
      AddOp(i, okSlot, p);
    end;
end;

//* Adjust all Entity items so they are rectangular
procedure MakeEndsSquare;
const
  TOL=0.25;
var
  i: Integer;
  p1,p2,p3,p4: Point2D;
begin
  //s := '';
  for i:=0 to High(Entity) do
  with Entity[i] do
  begin
    p1 := ClosestPtOn2DLine(Pt[1], Pt[2], Pt[4]);
    p2 := ClosestPtOn2DLine(Pt[1], Pt[2], Pt[3]);
    p3 := ClosestPtOn2DLine(Pt[3], Pt[4], Pt[2]);
    p4 := ClosestPtOn2DLine(Pt[3], Pt[4], Pt[1]);
    //use opposite corner to find the new rect
    if LineLength2D(Pt[3], p1) > LineLength2D(Pt[3], Pt[1]) + TOL then
    begin
      if not bFrames then
        MitreNotch[i, 1] := Pt[1];
      Pt[1] := p1;
    end;
    if LineLength2D(Pt[4], p2) > LineLength2D(Pt[4], Pt[2]) + TOL then
    begin
      if not bFrames then
        MitreNotch[i, 2] := Pt[2];
      Pt[2] := p2;
    end;
    if LineLength2D(Pt[1], p3) > LineLength2D(Pt[1], Pt[3]) + TOL then
    begin
      if not bFrames then
        MitreCope[i, 2] := Pt[3];
      Pt[3] := p3;
    end;
    if LineLength2D(Pt[2], p4) > LineLength2D(Pt[2], Pt[4]) + TOL then
    begin
      if not bFrames then
        MitreCope[i, 1] := Pt[4];
      Pt[4] := p4;
    end;
  end;
end;

//* Make the 34 side parallel, and set its distance to the web
//* must be called after MeasureWebs
procedure Make34Parallel;
var
  i: Integer;
  V: Vector2D;
  p: Point2D;
begin
  for i:=0 to High(Entity) do
  with Entity[i] do
  begin
    p := ClosestPtOn2DLine(Pt[3], Pt[4], Pt[1]);
    V := Vector2DFrom2DPoints(Pt[1], p);
    Pt[4] := Point2DFromParametricEquation(Pt[1], V, Web);
    Pt[3] := Point2DFromParametricEquation(Pt[2], V, Web);
  end;
end;

//* Add ops routines
procedure AddCTandInsertHoles;
var
  i: Integer;
  j: Byte;
  FlgLine, LipLine: LineType2D;
  ItemRect: RectType;
  FlgDist, LipDist, MinDist: Double;
  p: Point2D;
begin
  for i:=0 to High(Entity) do
  with Entity[i] do
  begin
    ItemRect := RectType(Pt);
    FindFlangeAndLipHoleLines(ItemRect, FlgLine, LipLine);
    MinDist := Entity[i].Web / 4;
    for j:=1 to OpCount do
    begin
      case Op[j].Kind of
        okIns,
        okCT:
         begin
           FlgDist := abs(PerpDistance(FlgLine.Pt[1], FlgLine.Pt[2], Op[j].p));
           LipDist := abs(PerpDistance(LipLine.Pt[1], LipLine.Pt[2], Op[j].p));
           if (LipDist < MinDist)or(FlgDist < MinDist)then
           begin
             if FlgDist < LipDist then
               p := ClosestPtOn2DLine(FlgLine.Pt[1], FlgLine.Pt[2], Op[j].p)
             else
               p := ClosestPtOn2DLine(LipLine.Pt[1], LipLine.Pt[2], Op[j].p);
             AddHole(i, p, FlgDist < LipDist);
           end;
         end;
        okLipHole:
          begin
            p := ClosestPtOn2DLine(LipLine.Pt[1], LipLine.Pt[2], Op[j].p);
            AddHole(i, p, False);
          end;
        okFlgHole:
          begin
            p := ClosestPtOn2DLine(FlgLine.Pt[1], FlgLine.Pt[2], Op[j].p);
            AddHole(i, p, True);
          end;
      end;     //case
    end;
  end;
end;

function AddAddedCopes: Boolean;
const
  TOL = 2;
  MSG = 'Added %s error in %s';    //'Added cope error in %s' or 'Added flat error in %s'
var
  i: Integer;
  j, NextCopeIdx: Byte;
  p: Point2D;
  bCountDone: Boolean;
  s: string;
begin
  Result := True;
  for i:=0 to High(Entity) do
  with Entity[i] do
  begin
    bCountDone := False;   NextCopeIdx := 1;
    for j:=1 to OpCount do
      if Op[j].Kind = okCope then
      begin
        if not bCountDone then   //find the next PosCope index to add in the added copes
        begin
          while PosCope[NextCopeIdx] > 0 do
            inc(NextCopeIdx);
          bCountDone := True;
        end;
        p := ClosestPtOn2DLine(Pt[4], Pt[3], Op[j].p);
        if (not PointOnLine(Pt[3], Pt[4], p, TOL))then
        begin
          s := 'cope';
          if bFrames then
            s := 'flat';
          SLErrorItems.Add(format(MSG,[s,Item]));
          Result := False;
        end;
        PosCope[NextCopeIdx] := DistFromEnd1(i, p); //LineLength2D(Pt[4], p);
        inc(NextCopeIdx);
        if NextCopeIdx > High(PosCope)then
          break;
      end;
  end;
end;

function AddAddedNotches: Boolean;
var
  i: Integer;
  j, NextNotchIdx: Byte;
  p: Point2D;
  bCountDone: Boolean;
begin
  Result := True;
  for i:=0 to High(Entity) do
  with Entity[i] do
  begin
    bCountDone := False;   NextNotchIdx := 1;
    for j:=1 to OpCount do
      if Op[j].Kind = okNotch then
      begin
        if not bCountDone then  //find the next PosNotch index to add in the added notches
        begin
          while PosNotch[NextNotchIdx] > 0 do
            inc(NextNotchIdx);
          bCountDone := True;
        end;
        p := ClosestPtOn2DLine(Pt[4], Pt[3], Op[j].p); //op[j].p is really nearer Pt[1], P[2]...
        if not PointOnLine(Pt[3], Pt[4], p, 1)then
        begin
          SLErrorItems.Add(format('Added notch error in %s',[Item]));
          Result := False;
        end;                      //... but we just want a dist from the end
        PosNotch[NextNotchIdx] := DistFromEnd1(i, p); //LineLength2D(Pt[4], p);
        inc(NextNotchIdx);
        if NextNotchIdx > High(PosNotch)then
          break;
      end;
  end;
end;

procedure MakeEndSwagesBetweenPoints(Idx: Word; p1, p2: Point2D);
var
  pn: Point2D;
  V: Vector2D;
  NumSwages, n: Integer;
  TotalDist, EndDist, Dist: Double;
begin
  EndDist := (SwageSize - MIN_SWAGE_OVERLAP) / 2;
  if (not PointOnLine(Entity[Idx].Pt[1], Entity[Idx].Pt[2], p2, 1))then
  begin
    p2 := Entity[Idx].Pt[1];
    SwapPoints(p1, p2);
  end
  else
    if (LineLength2D(Entity[Idx].Pt[1], p1) < EndDist)
    or (not PointOnLine(Entity[Idx].Pt[1], Entity[Idx].Pt[2], p1, 1))then
      p1 := Entity[Idx].Pt[1];

  V := Vector2DFrom2DPoints(p1, p2);

  TotalDist := LineLength2D(p1, p2) + 0.1;
  Dist := SwageSize - MIN_SWAGE_OVERLAP;
  NumSwages := succ(Trunc(TotalDist / Dist));
  if NumSwages > 1 then
    Dist := (TotalDist - SwageSize) / pred(NumSwages);

  pn := Point2DFromParametricEquation(p1, V, EndDist);
  for n:=1 to NumSwages do
  begin
    AddSwageToItem(Idx, pn);
    pn := Point2DFromParametricEquation(pn, V, Dist);
  end;
end;

procedure MakeSwagesBetweenPoints(Idx: Word; p1, p2: Point2D);
var
  p0,pn: Point2D;
  V: Vector2D;
  NumSwages, n: Integer;
  TotalDist, Dist: Double;
begin
  Dist := SwageSize - MIN_SWAGE_OVERLAP;

  if (LineLength2D(Entity[Idx].Pt[1], p1) < (Dist / 2) + 0.01)then
  begin
    p1 := Entity[Idx].Pt[1];
    Entity[Idx].Swage[1] := True;
    Entity[Idx].PosSwage[1] := LineLength2D(p1, p2);
    exit;
  end;

  if (LineLength2D(Entity[Idx].Pt[2], p1) < (Dist / 2) + 0.01)then
  begin
    p1 := Entity[Idx].Pt[2];
    Entity[Idx].Swage[2] := True;
    Entity[Idx].PosSwage[2] := LineLength2D(p1, p2);
    exit;
  end;

  V := Vector2DFrom2DPoints(p1, p2);

  TotalDist := LineLength2D(p1, p2) + (2 * CopeNotchTol);  // + (2 * TOL);
  NumSwages := succ(Trunc(TotalDist / Dist));
  if NumSwages > 1 then
    Dist := (TotalDist - SwageSize) / pred(NumSwages);
  p0 := MidPoint2D(p1,p2);
  pn := Point2DFromParametricEquation(p0, V, -(NumSwages * Dist) / 2);
  pn := Point2DFromParametricEquation(pn, V, Dist / 2);
  for n:=1 to NumSwages do
  begin
    AddSwageToItem(Idx, pn);
    pn := Point2DFromParametricEquation(pn, V, Dist);
  end;
end;

procedure AddSwageToBothItems;
var
  p, q, pNotch: Point2D;
  L1, L2, FlattenedLipLine: LineType2D;
  d, dOneSwage,    d1,d2, dNotch,EndDist: Double;
  V,V14: Vector2D;
  IIdx, SIdx: Word;
begin
  if (not bFrames)or(not bPanelUseSwage)then
    exit;

  if not((StaticItem.CloserEdge = et12) or bStaticItemTab) then
    exit;

  V14 := Vector2DFrom2DPoints(IntersectItem.Pt[1], IntersectItem.Pt[4]);
  L1 := StaticItem.FlangeLine;
  L2 := IntersectItem.FlangeLine;
  FindIntercept(L1, L2, p);

  L2.Pt[1] := Point2DFromParametricEquation(IntersectItem.Pt[4], V14, LipSize);
  L2.Pt[2] := Point2DFromParametricEquation(IntersectItem.Pt[3], V14, LipSize);
  FlattenedLipLine := L2;
  FindIntercept(L1, L2, q);

  IIdx := IntersectItem.OriginalIndex;
  dOneSwage := SwageSize - MIN_SWAGE_OVERLAP - 0.2;

  if bStaticItemTab then
  begin
    EndDist := (SwageSize - MIN_SWAGE_OVERLAP) / 2;
    L1.Pt[1] := StaticItem.Pt[3];  L1.Pt[2] := StaticItem.Pt[4];
    L2.Pt[1] := IntersectItem.Pt[1];  L2.Pt[2] := IntersectItem.Pt[2];
    FindIntercept(L1, L2, q);
    V := Vector2DFrom2DPoints(p,q);

    SIdx := StaticItem.OriginalIndex;
    d1 := LineLength2D(Entity[SIdx].Pt[1], p) + MIN_SWAGE_OVERLAP;  //check only 1 swage is needed
    d2 := LineLength2D(Entity[SIdx].Pt[2], p) + MIN_SWAGE_OVERLAP;  //an approximation
    if d1 < d2 then
    begin
      if d1 > EndDist then
        EndDist := d1;
    end
    else
      if d2 > EndDist then
        EndDist := d2;

    q := Point2DFromParametricEquation(p, V, EndDist);
    d := LineLength2D(p, q);

    //single swage only at the end
    //here because no bTipsMeet test in SetSwagePositions (too late, it's out of the main ProcessTruss loop)
    if d > dOneSwage then
      d := dOneSwage;

    dNotch := 0;
    if not PointIsOrigin(IntersectItem.Notch) then
    with Entity[IIdx]do
    begin
      pNotch := Pt[1];
      if IntersectItem.ExtendEnd = tt23 then
        pNotch := Pt[2];
      dNotch :=  LineLength2D(pNotch, q);
    end;

    if dNotch > d then
      d := dNotch;
    if IntersectItem.ExtendEnd = tt14 then
    begin
      Entity[IIdx].Swage[1] := True;
      if d > Entity[IIdx].PosSwage[1] then
        Entity[IIdx].PosSwage[1] := d;
    end
    else begin
      Entity[IIdx].Swage[2] := True;
      if d > Entity[IIdx].PosSwage[2] then
        Entity[IIdx].PosSwage[2] := d;
    end;

    exit;
  end;

  if bTipsMeet then
  begin
    if IntersectItem.ExtendEnd = tt14 then
      q := Point2DFromParametricEquation(IntersectItem.Pt[4], V14, LipSize)
    else
      q := Point2DFromParametricEquation(IntersectItem.Pt[3], V14, LipSize);
    q := ClosestPtOn2DLine(L1.Pt[1], L1.Pt[2], q);

    SIdx := StaticItem.OriginalIndex;
    if not PointOnLine(Entity[SIdx].Pt[1], Entity[SIdx].Pt[2], p, 0.1) then
    begin
      if StaticItem.ExtendEnd = tt14 then
        p := Entity[SIdx].Pt[1]
      else
        p := Entity[SIdx].Pt[2];
    end;

    d := LineLength2D(p, q);

    //single swage only at the end
    //here because no bTipsMeet test in SetSwagePositions (too late, it's out of the main ProcessTruss loop)
    if d > dOneSwage then
      d := dOneSwage;

    if LineLength2D(Entity[SIdx].Pt[1], p) < LineLength2D(Entity[SIdx].Pt[2], p) then
    begin
      Entity[SIdx].Swage[1] := True;
      if d > Entity[SIdx].PosSwage[1] then
        Entity[SIdx].PosSwage[1] := d;
    end
    else begin
      Entity[SIdx].Swage[2] := True;
      if d > Entity[SIdx].PosSwage[2] then
        Entity[SIdx].PosSwage[2] := d;
    end;

    exit;
  end;

  if IntersectItem.IntersectEdge = et34 then //Extend the swage to the end of the other item
  begin
    if IntersectItem.ExtendEnd = tt14 then
      p := ClosestPtOn2DLine(L1.Pt[1], L1.Pt[2], Entity[IIdx].Pt[1])
    else
      p := ClosestPtOn2DLine(L1.Pt[1], L1.Pt[2], Entity[IIdx].Pt[2]);
  end
  else begin
    L2.Pt[1] := Point2DFromParametricEquation(IntersectItem.Pt[1], V14, -CopeNotchTol);    //was -LipSize);  //
    L2.Pt[2] := Point2DFromParametricEquation(IntersectItem.Pt[2], V14, -CopeNotchTol);    //was -LipSize);  //
    FindIntercept(L1, L2, p);                 //add a bit of tolerance

    if IntersectItem.ExtendEnd = tt14 then
      q := ClosestPtOn2DLine(L1.Pt[1], L1.Pt[2], FlattenedLipLine.Pt[1])
    else
      q := ClosestPtOn2DLine(L1.Pt[1], L1.Pt[2], FlattenedLipLine.Pt[2]);
  end;
  MakeSwagesBetweenPoints(StaticItem.OriginalIndex, p, q);
end;

//* Get Swage distances and add them to the Entity array
procedure SetSwagePositions;
var
  i: Integer;
  j: Word;
  p, q: Point2D;
  V: Vector2D;
  d: Double;
begin
  if (not AreUsingSwage) then
    exit;

  for i:=0 to High(Entity) do
  with Entity[i] do
  begin
    if Swage[1] then
    begin
      V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
      p := Pt[1];
      d := PosSwage[1];
      q := Point2DFromParametricEquation(Pt[1], V, d);
      MakeEndSwagesBetweenPoints(i, p, q);
    end;
    if Swage[2] then
    begin
      V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
      p := Pt[2];
      d := PosSwage[2];
      q := Point2DFromParametricEquation(Pt[2], V, -d);
      MakeEndSwagesBetweenPoints(i, p, q);
    end;
    //Set the Added Swage positions
    for j:=1 to OpCount do
      if Op[j].Kind = okSwage then
        Op[j].Pos := DistFromEnd1(i, Op[j].p);
    //clear the temp variables
    //Swage[1] := False;  Swage[2] := False;
    FillChar(Swage, SizeOf(Swage), 0);      //cleanup
    FillChar(PosSwage, SizeOf(PosSwage), 0);
  end;
end;

procedure SetServiceHolePositions;
var
  i: Integer;
  j, Idx1, Idx2: Byte;
begin
  if not bFrames then
    exit;
  for i:=0 to High(Entity) do
  with Entity[i] do
  begin
    FillChar(PosServ1, SizeOf(PosServ1), 0);
    FillChar(PosServ2, SizeOf(PosServ2), 0);
    Idx1 := 1;  Idx2 := 1;
    for j:=1 to OpCount do
    begin
      if Op[j].Kind = okServ1 then
      if (Idx1 <= High(PosServ1))then
      begin
        PosServ1[Idx1] := DistFromEnd1(i, Op[j].p);
        inc(Idx1);
      end;
      if Op[j].Kind = okServ2 then
      if (Idx2 <= High(PosServ2))then
      begin
        PosServ2[Idx2] := DistFromEnd1(i, Op[j].p);
        inc(Idx2);
      end;
    end;
  end;
end;

//* Rivets are added as Scr ops for panel files, along the Flange line
//* move them to the rivet line
//* and add them to the FHoles array,
//* the SetPosHoles call then also adds them to the PosFHoles array
procedure AdjustAddedRivetHolePositions;
const
  TOL=2;
var
  i: Integer;
  j: Byte;
  V: Vector2D;
  RivetLine: LineType2D;
begin
  if not bFrames then
    exit;
  for i:=0 to High(Entity) do
  with Entity[i] do
  begin
    for j:=1 to OpCount do
    begin
      if (Op[j].Kind = okScr)
      and(PointOnLine(Pt[1], Pt[2], Op[j].p, TOL))then  //added rivet
      begin
        V := Vector2DFrom2DPoints(Pt[1], Pt[4]);
        RivetLine.Pt[1] := Point2DFromParametricEquation(Pt[1], V, FrameHolePos);
        RivetLine.Pt[2] := Point2DFromParametricEquation(Pt[2], V, FrameHolePos);
        Op[j].p := ClosestPtOn2DLine(RivetLine.Pt[1], RivetLine.Pt[2], Op[j].p);
        AddHole(i, Op[j].p, True);
        inc(TotalRivets);
      end;
    end;
  end;
end;

//* Change the length of Entity[iItem] at the Tip end
//* -ve Dist to lengthen it
procedure ShortenItem(iItem: Word; Dist: Double; Tip: TipType);
var
  i: Word;
  V: Vector2D;
begin
  with Entity[iItem]do
  begin
    if Tip=tt14 then
    begin
      i:=1;
      while PosFHoles[i] > 0 do
      begin
        PosFHoles[i] := PosFHoles[i] - Dist;
        inc(i);
      end;
      i:=1;
      while PosLHoles[i] > 0 do
      begin
        PosLHoles[i] := PosLHoles[i] - Dist;
        inc(i);
      end;
    end;
    Len := Len - Dist;
    V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
    case Tip of
      tt14: begin
              Pt[1] := Point2DFromParametricEquation(Pt[1], V, Dist);
              Pt[4] := Point2DFromParametricEquation(Pt[4], V, Dist);
            end;
      tt23: begin
              Pt[2] := Point2DFromParametricEquation(Pt[2], V, -Dist);
              Pt[3] := Point2DFromParametricEquation(Pt[3], V, -Dist);
            end;
    end;
  end;
end;

procedure OptimizeLengths;
const
  TOL=1;
var
  i: Integer;
  j: Word;
  d, FDist, LDist: Double;
  bIsMitred14, bIsMitred23: Boolean;
begin
  for i:=0 to High(Entity) do
  with Entity[i] do
  begin
    bIsMitred14 := (not PointIsOrigin(MitreNotch[i, 1]))or(not PointIsOrigin(MitreCope[i, 1]));
    if bIsMitred14 then
    begin
      d := PosLHoles[1];
      if (PosFHoles[1]>0)and(PosFHoles[1] < PosLHoles[1]) then
        d := PosFHoles[1];
      d := d - MinEndDist;
      if (d > TOL)and(d<Web*2) then   //Magic
        ShortenItem(i, d, tt14);
    end;

    bIsMitred23 := (not PointIsOrigin(MitreNotch[i, 2]))or(not PointIsOrigin(MitreCope[i, 2]));
    if bIsMitred23 then
    begin
      FDist := 0;
      j:=1;
      while PosFHoles[j] > 0 do
      begin
        FDist := PosFHoles[j];
        inc(j);
      end;
      LDist := 0;
      j:=1;
      while PosLHoles[j] > 0 do
      begin
        LDist := PosLHoles[j];
        inc(j);
      end;
      d := FDist;
      if LDist > FDist then
        d := LDist;
      if d > 0 then
      begin
        d := Len - d - MinEndDist;
        if (d > TOL)and(d<Web*2) then   //Magic
          ShortenItem(i, d, tt23);
      end;
    end;
    //Remove Notches and Copes that are now off the Flg and Lip lines
    if bIsMitred14 or bIsMitred23 then
    begin
      for j:=1 to 2 do
      begin
        if not PointIsOrigin(Notch[j])then
          if not PointOnLine(Pt[1], Pt[2], Notch[j], TOL) then
            Notch[j] := THE_ORIGIN;
        if not PointIsOrigin(Cope[j])then
          if not PointOnLine(Pt[3], Pt[4], Cope[j], TOL) then
            Cope[j] := THE_ORIGIN;
      end;
    end;
  end;
end;

//* Check all the entity hole coords are where their pos says they should be
//* typically this would return false when an entity has be shortened twice,
//* by interactions with different entities
//* Also checks the Pos is on the item, not past its length, reports the error
//* and removes the hole on this item
function HoleCoordsMatchPos: Boolean;
const
  TOL=1;
var
  n: Integer;
  i: Word;
  p: Point2D;
  EndLength: Double;
begin
  Result := True;
  EndLength := MinEndDist - HoleSize - TOL;
  for n:=0 to High(Entity) do
  with Entity[n]do
  begin
    i:=1;
    while PosFHoles[i] <> 0 do
    begin
      p := HoleCoordFromPos(Entity[n], PosFHoles[i], True);
      if (PosFHoles[i] > Len - EndLength)
      or (PosFHoles[i] < EndLength)
      or (not PointsAreSame(p, FHoles[i]))then
      begin
        Result := False;
        if (not bFrames) then
          SLErrorItems.Add(format('FHoles[%d] error in %s',[i, Item]))
        else
          SLErrorItems.Add(format('Holes[%d] error in %s',[i, Item]));
        RemoveFlangeHole(n, i);
      end
      else
        inc(i);
    end;
    i:=1;
    while PosLHoles[i] <> 0 do
    begin
      p := HoleCoordFromPos(Entity[n], PosLHoles[i], False);
      if (PosLHoles[i] > Len - EndLength)
      or (PosLHoles[i] < EndLength)
      or (not PointsAreSame(p, LHoles[i]))then
      begin
        Result := False;
        if (not bFrames) then
          SLErrorItems.Add(format('LHoles[%d] error in %s',[i, Item]))
        else
          SLErrorItems.Add(format('Holes[%d] error in %s',[i, Item]));
        RemoveLipHole(n, i);
      end
      else
        inc(i);
    end;
  end;
end;

procedure MakeFramePerimeterTabs;
var
  i, j: Integer;
  Intercept: Point2D;
  MaxDist: Double;
begin
  if not bFrames then
    exit;
  for i:=0 to High(Entity)do
    for j:=succ(i)to High(Entity)do
    if (not ItemsAreParallel(i,j))then
    with Entity[i]do
    begin
      MaxDist := Web;
      if (PointsAreSame(Pt[1], Entity[j].Pt[2]))
      and(not(IsInOrOnRect(Pt[1], Pt[2], Pt[3], Pt[4], Entity[j].Pt[3])))then
      begin
        FindIntercept(Pt[1], Pt[2], Entity[j].Pt[3], Entity[j].Pt[4], Intercept);
        if LineLength2D(Pt[1], Intercept) < MaxDist then
        begin
          Pt[1] := Intercept;
          FindIntercept(Pt[3], Pt[4], Entity[j].Pt[1], Entity[j].Pt[2], Intercept);
          Entity[j].Pt[2] := Intercept;
        end;
      end;

      if (PointsAreSame(Pt[2], Entity[j].Pt[1]))
      and(not(IsInOrOnRect(Pt[1], Pt[2], Pt[3], Pt[4], Entity[j].Pt[4])))then
      begin
        FindIntercept(Pt[1], Pt[2], Entity[j].Pt[3], Entity[j].Pt[4], Intercept);
        if LineLength2D(Pt[2], Intercept) < MaxDist then
        begin
          Pt[2] := Intercept;
          FindIntercept(Pt[3], Pt[4], Entity[j].Pt[1], Entity[j].Pt[2], Intercept);
          Entity[j].Pt[1] := Intercept;
        end;
      end;

      if (PointsAreSame(Pt[1], Entity[j].Pt[1]))
      and(not(IsInOrOnRect(Pt[1], Pt[2], Pt[3], Pt[4], Entity[j].Pt[4])))then
      begin
        FindIntercept(Pt[1], Pt[2], Entity[j].Pt[3], Entity[j].Pt[4], Intercept);
        if LineLength2D(Pt[1], Intercept) < MaxDist then
        begin
          Pt[1] := Intercept;
          FindIntercept(Pt[3], Pt[4], Entity[j].Pt[1], Entity[j].Pt[2], Intercept);
          Entity[j].Pt[1] := Intercept;
        end;
      end;

      if (PointsAreSame(Pt[2], Entity[j].Pt[2]))
      and(not(IsInOrOnRect(Pt[1], Pt[2], Pt[3], Pt[4], Entity[j].Pt[3])))then
      begin
        FindIntercept(Pt[1], Pt[2], Entity[j].Pt[3], Entity[j].Pt[4], Intercept);
        if LineLength2D(Pt[2], Intercept) < MaxDist then
        begin
          Pt[2] := Intercept;
          FindIntercept(Pt[3], Pt[4], Entity[j].Pt[1], Entity[j].Pt[2], Intercept);
          Entity[j].Pt[2] := Intercept;
        end;
      end;
  end;
end;

//* Clean up the dynamic array
//* called at the start of ProcessTruss and in the finalization
procedure ClearEntity;
begin
  SetLength(Entity, 0);  Entity := nil;
end;

//* Calculate and store the distance for ACUTE_ANGLE degrees
//* The dist is used in the FindOptHole routine
procedure FindAcuteDist;
const
  ACUTE_ANGLE = 14;   //is actually 14.78 = atan(R / delta), use 15?
begin                 //R = hole radius = 4.75, delta = dist between holes = 18
  AcuteDist := (LipHolePos - FlgHolePos) * tan(ACUTE_ANGLE * pi / 180);
end;


//* Look for Points that are at the origin and artificially adjust them
procedure RemoveOriginPoints;
const
  TINY = 0.000001;
var
  i: Integer;
  j: Byte;
begin
  for i:=0 to High(Entity)do
  begin
    for j:=1 to 4 do
      if PointIsOrigin( Entity[i].Pt[j] )then
      begin
        Entity[i].Pt[j].x := TINY;
        break;
      end;
  end;
end;

function GetExtraCopeDistance: Double;
const
  TOL = 1;
var
  L1,L2: LineType2D;
  p: Point2D;
  IntersectIdx: Integer;
  V: Vector2D;
begin
  Result := 0;
  IntersectIdx := IntersectItem.OriginalIndex;
  L1.Pt[1] := Entity[IntersectIdx].Pt[4];  //can't use IntersectItem.Pt[4] because the entity
  L1.Pt[2] := Entity[IntersectIdx].Pt[3];  //was extended with ExtendItemEnd without updating IntersectItem
  with StaticItem do
  begin
    V := Vector2DFrom2DPoints(Pt[4], Pt[1]);
    L2.Pt[1] := Point2DFromParametricEquation(Pt[4], V, LipSize);
    L2.Pt[2] := Point2DFromParametricEquation(Pt[3], V, LipSize);
  end;
  if not FindIntercept(L1,L2, p)then
    exit;
  if not (PointOnLine(L1, p, TOL)and PointOnLine(L2, p, TOL))then    //Lips don't meet
    exit;
  if IntersectItem.ExtendEnd = tt14 then
    Result := LineLength2D(p, Entity[IntersectIdx].Pt[4])
  else
    Result := LineLength2D(p, Entity[IntersectIdx].Pt[3]);
end;

procedure CheckIntersectItemNotch;
var
  IntersectIdx, StaticIdx: Integer;
  V12: Vector2D;
  d, EndDist, AMinDist: Double;
  p, ANotch, q: Point2D;
begin
  if not bTipsMeet then
    exit;
  ANotch := IntersectItem.Notch;
  if PointIsOrigin(ANotch)then
    exit;

  IntersectIdx := IntersectItem.OriginalIndex;
  StaticIdx := StaticItem.OriginalIndex;

  if StaticItem.ExtendEnd = tt14 then
    p := Entity[StaticIdx].Pt[1]
  else
    p := Entity[StaticIdx].Pt[2];

  d := LineLength2D(p, ANotch);
  if d > CopeNotchTol then
  begin
    if StaticItem.ExtendEnd = tt14 then
      FindIntercept(Entity[StaticIdx].Pt[1], Entity[StaticIdx].Pt[4], Entity[IntersectIdx].Pt[1], Entity[IntersectIdx].Pt[2], ANotch)
    else
      FindIntercept(Entity[StaticIdx].Pt[2], Entity[StaticIdx].Pt[3], Entity[IntersectIdx].Pt[1], Entity[IntersectIdx].Pt[2], ANotch);
  end;

  AMinDist := NotchSize - 0.01;
  V12 := Vector2DFrom2DPoints(IntersectItem.Pt[1], IntersectItem.Pt[2]);
  if IntersectItem.ExtendEnd = tt14 then
  begin
    if d > CopeNotchTol then
      q := Point2DFromParametricEquation(ANotch, V12, CopeNotchTol)
    else
      q := Point2DFromParametricEquation(ANotch, V12, TAB_TOL);
    EndDist := LineLength2D(q, Entity[IntersectIdx].Pt[1]);
    if EndDist < AMinDist then     //so Notch[] displays ok after CheckIntersectItemLength has radically shortened the item
      Entity[IntersectIdx].Notch[1] := Point2DFromParametricEquation(ANotch, V12, AMinDist)
    else
      Entity[IntersectIdx].Notch[1] := q;
  end
  else begin
    if d > CopeNotchTol then
      q := Point2DFromParametricEquation(ANotch, V12, -CopeNotchTol)
    else
      q := Point2DFromParametricEquation(ANotch, V12, -TAB_TOL);
    EndDist := LineLength2D(q, Entity[IntersectIdx].Pt[2]);
    if EndDist < AMinDist then
      Entity[IntersectIdx].Notch[2] := Point2DFromParametricEquation(ANotch, V12, -AMinDist)
    else
      Entity[IntersectIdx].Notch[2] := q;
  end;
end;

//* Make sure the IntersectItem is no longer that MinEndDist past the hole
procedure CheckIntersectItemLength;
const
  BIGGEST_END_DIST = 60;
var
  D: Double;
  Idx: Word;
  L: LineType2D;
begin
  if not bTipsMeet then
    exit;
  Idx := IntersectItem.OriginalIndex;
  L.Pt[1] := Entity[Idx].Pt[1];   L.Pt[2] := Entity[Idx].Pt[4];
  if IntersectItem.ExtendEnd = tt23 then
  begin
    L.Pt[1] := Entity[Idx].Pt[2];   L.Pt[2] := Entity[Idx].Pt[3];
  end;

  D := abs(PerpDistance(L.Pt[1], L.Pt[2], IntersectItem.HolePt));
  if D > BIGGEST_END_DIST then  //shorten the item
    ExtendItemEnd(Idx, IntersectItem.ExtendEnd, -(D - BIGGEST_END_DIST));
end;

//* Make sure the StaticItem is no longer that MinEndDist past the hole
procedure CheckStaticItemLength;
const
  BIGGEST_END_DIST = 60;
var
  D: Double;
  Idx: Word;
  L: LineType2D;
begin
  if not bTipsMeet then
    exit;
  Idx := StaticItem.OriginalIndex;
  L.Pt[1] := Entity[Idx].Pt[1];   L.Pt[2] := Entity[Idx].Pt[4];
  if StaticItem.ExtendEnd = tt23 then
  begin
    L.Pt[1] := Entity[Idx].Pt[2];   L.Pt[2] := Entity[Idx].Pt[3];
  end;

  D := abs(PerpDistance(L.Pt[1], L.Pt[2], StaticItem.HolePt));
  if D > BIGGEST_END_DIST then  //MinEndDist then             //shorten the item
  begin
    ExtendItemEnd(Idx, StaticItem.ExtendEnd, -(D - BIGGEST_END_DIST));       //MinEndDist
    bLateLengthChange := True;
  end;
end;

procedure MakeTabbedNotch;
var
  p, Intercept, CopeIntercept: Point2D;
  IntersectIdx, StaticIdx: Integer;
  d, SingleNotchDist, L, Delta: Double;
  V12: Vector2D;
  IntersectEndLine, StaticFlgLine: LineType2D;
begin
  IntersectIdx := IntersectItem.OriginalIndex;
  StaticIdx := StaticItem.OriginalIndex;

  if FindIntercept(StaticItem.FlangeLine, IntersectItem.FlangeLine, Intercept) then
    if(not PointOnLine(Entity[StaticIdx].Pt[1], Entity[StaticIdx].Pt[2], Intercept, 10)) then
      exit;

  StaticFlgLine := StaticItem.FlangeLine;
  IntersectEndLine := IntersectItem.Line(1,4);
  p := Entity[IntersectIdx].Pt[1];
  if IntersectItem.ExtendEnd = tt23 then
  begin
    IntersectEndLine := IntersectItem.Line(2,3);
    p := Entity[IntersectIdx].Pt[2];
  end;
  if (FindIntercept(StaticFlgLine, IntersectEndLine, Intercept))
  and(PointOnLine(IntersectEndLine, Intercept, 0.1)) then
    p := Intercept;

  d := LineLength2D(p, StaticItem.TabNotch);
  if (d > CopeNotchTol) then //and((bFrames)or(not bUSJointing)) then
    StaticItem.TabNotch := ClosestPtOn2DLine(StaticItem.Pt[1], StaticItem.Pt[2], p);

  SingleNotchDist := NotchSize - CutWidth - NOTCH_START_TOL - TAB_TOL;
  if bFrames then    // added for bStaticItemTab
  begin
    L := LineLength2D(Entity[StaticIdx].Pt[1], Entity[StaticIdx].Pt[2]);
    Delta := abs(PerpDistanceToLine(StaticItem.FarTipLine, StaticItem.TabNotch)) + SingleNotchDist - L;
    ExtendItemEnd(StaticIdx, StaticItem.ExtendEnd, Delta - CopeNotchTol);
    if StaticItem.ExtendEnd = tt14 then
    begin
      Entity[StaticIdx].Notch[1] := StaticItem.TabNotch;
    end
    else begin
      Entity[StaticIdx].Notch[2] := StaticItem.TabNotch;
    end;
  end
  else begin
    L := LineLength2D(Entity[StaticIdx].Pt[1], Entity[StaticIdx].Pt[2]);
    Delta := abs(PerpDistanceToLine(StaticItem.FarTipLine, StaticItem.TabNotch)) + SingleNotchDist - L;

    if Delta > CopeNotchTol then
      ExtendItemEnd(StaticIdx, StaticItem.ExtendEnd, Delta - CopeNotchTol);

    V12 := Vector2DFrom2DPoints(StaticItem.Pt[1], StaticItem.Pt[2]);
    if StaticItem.ExtendEnd = tt14 then
    begin
      //here to show where the notch line is in single tabbed notches,
      //matches the notch line with the point at PosNotch
      if LineLength2D(Entity[StaticIdx].Pt[1], StaticItem.TabNotch) < SingleNotchDist then
        Entity[StaticIdx].Notch[1] := Point2DFromParametricEquation(Entity[StaticIdx].Pt[1], V12, SingleNotchDist)
      else
      if d > CopeNotchTol then
        Entity[StaticIdx].Notch[1] := Point2DFromParametricEquation(StaticItem.TabNotch, V12, CopeNotchTol)
      else    // not used
        Entity[StaticIdx].Notch[1] := Point2DFromParametricEquation(StaticItem.TabNotch, V12, TAB_TOL);

      if (not bFrames) then
      begin
        if (FindIntercept(StaticItem.Line(3,4), IntersectItem.FlangeLine, CopeIntercept))
        and(PointOnLine(Entity[StaticIdx].Pt[3],Entity[StaticIdx].Pt[4], CopeIntercept, 0.1)) then
          Entity[StaticIdx].Cope[1] := CopeIntercept;
      end;
    end
    else begin
      //here to show where the notch line is in single tabbed notches,
      //matches the notch line with the point at PosNotch
      if LineLength2D(Entity[StaticIdx].Pt[2], StaticItem.TabNotch) < SingleNotchDist then
        Entity[StaticIdx].Notch[2] := Point2DFromParametricEquation(Entity[StaticIdx].Pt[2], V12, -SingleNotchDist)
      else
      if d > CopeNotchTol then
        Entity[StaticIdx].Notch[2] := Point2DFromParametricEquation(StaticItem.TabNotch, V12, -CopeNotchTol)
      else    // not used
        Entity[StaticIdx].Notch[2] := Point2DFromParametricEquation(StaticItem.TabNotch, V12, -TAB_TOL);

      if (not bFrames) then
      begin
        if (FindIntercept(StaticItem.Line(3,4), IntersectItem.FlangeLine, CopeIntercept))
        and(PointOnLine(Entity[StaticIdx].Pt[3],Entity[StaticIdx].Pt[4], CopeIntercept, 0.1)) then
          Entity[StaticIdx].Cope[2] := CopeIntercept;
      end;
    end;
  end;
end;

//* Returns true if we are using box webbing and the item is a web or heel,
//* or the doubled version.
//* sBOX_WEB_2 and sBOX_HEEL_2 are identifiers to produce 2 identical items
function EntityIsBoxWeb(AEntityRec: EntityRecType): Boolean;
begin
  Result := bUseBoxWebbing
         and (
                 SameText(AEntityRec.iType, 'Web')or SameText(AEntityRec.iType, 'Heel')
              or SameText(AEntityRec.iType, sBOX_WEB_2)or SameText(AEntityRec.iType, sBOX_HEEL_2)
             );
end;

function BoxWebIntersection(i,j: Integer): Boolean;
var
  p, pLen, MidPt: Point2D;
  FlgLine, LipLine, ALine: LineType2D;
  ARect: RectType;
  V12, V14: Vector2D;
  W: Double;
  Idx, ChordIdx: Integer;
  bFlange: Boolean;
  AEnd: TipType;
begin
  Result := False;
  if bFrames or not bUseBoxWebbing then
    exit;
  if EntityIsBoxWeb(Entity[i]) and EntityIsBoxWeb(Entity[j]) then  //no web-web interaction
  begin
    Result := True;
    exit;
  end;
  //Get the index of the web item
  Idx := i;  ChordIdx := j;
  if (SameText(Entity[i].iType, 'Chord')or SameText(Entity[i].iType, 'BC'))
  and(EntityIsBoxWeb(Entity[j]))then  //2nd item is the web
  begin
    ARect := RectType(Entity[i].Pt);
    Idx := j;
    ChordIdx := i;
  end
  else
  if (SameText(Entity[j].iType, 'Chord')or SameText(Entity[j].iType, 'BC'))
  and(EntityIsBoxWeb(Entity[i]))then    //1st item is the web
    ARect := RectType(Entity[j].Pt)
  else       // neither or both items are webs or neither item is a chord
    exit;
  //centre line of the web item
  with Entity[Idx]do
  begin
    ALine.Pt[1] := MidPoint2D(Pt[1], Pt[4]);
    ALine.Pt[2] := MidPoint2D(Pt[2], Pt[3]);
  end;

  FindFlangeAndLipHoleLines(ARect, FlgLine, LipLine);

  if not FindIntercept(FlgLine, ALine, pLen)then  //point to use for length adjustment
    exit;

  bFlange := True;                         //Flange hole for all except BC
  if ((SameText(Entity[Idx].iType, 'Heel'))or(SameText(Entity[Idx].iType, sBOX_HEEL_2)))
  and(SameText(Entity[ChordIdx].iType, 'BC')) then  // Lip hole for heel on BC
  begin
    if not FindIntercept(LipLine, ALine, p)then
      exit;
    bFlange := False;
  end
  else
    p := pLen;

  Result := True;
  AddHole(Idx, p, True);            //webs always use flange
  AddHole(ChordIdx, p, bFlange);

  with Entity[Idx]do  //adjust the length
  begin
    V12 := Vector2DFrom2DPoints(Pt[1], Pt[2]);
    V14 := Vector2DFrom2DPoints(Pt[1], Pt[4]);
    W := LineLength2D(Pt[1], Pt[4]);
    if LineLength2D(pLen, Pt[1]) < LineLength2D(pLen, Pt[2]) then //1,4 end
    begin
      MidPt := Point2DFromParametricEquation(pLen, V12, -MinEndDist);
      Pt[1] := Point2DFromParametricEquation(MidPt, V14, -W/2);
      Pt[4] := Point2DFromParametricEquation(MidPt, V14, W/2);
    end
    else begin    //2,3 end
      MidPt := Point2DFromParametricEquation(pLen, V12, MinEndDist);
      Pt[2] := Point2DFromParametricEquation(MidPt, V14, -W/2);
      Pt[3] := Point2DFromParametricEquation(MidPt, V14, W/2);
    end;
  end;

  //for top chord and heel, increase the length of the top chord by the MinEndDist
  if bTipsMeet
  and((SameText(Entity[Idx].iType, 'Heel'))or(SameText(Entity[Idx].iType, sBOX_HEEL_2)))
  and(SameText(Entity[ChordIdx].iType, 'Chord')) then
  begin
    AEnd := tt14;
    if LineLength2D(p, Entity[ChordIdx].Pt[2]) < LineLength2D(p, Entity[ChordIdx].Pt[1]) then
      AEnd := tt23;
    case AEnd of    //add a notch to the top chord
      tt14: Entity[ChordIdx].Notch[1] := Entity[ChordIdx].Pt[1];
      tt23: Entity[ChordIdx].Notch[2] := Entity[ChordIdx].Pt[2];
    end;
    ExtendItemEnd(ChordIdx, AEnd, MinEndDist);
  end;
end;

{$REGION 'Force and remove virtual mitre for Truss(R) FrameType'}
{--------------------------}
//* Lateral shift to create virtual mitre when built on single-rivet machine
procedure ForceVirtualMitre;
var
  HolePt, P: Point2d;
  StaticItemNorm, dV: Vector2D;
  IntersectItemV,IntersectItemNorm : Vector2D;
  ILine,SLine, RLine1,RLine2: LineType2D;
  d, ItemLength: double;
  OptimumEndHoleDistance : double; // ~20mm
begin
  assert( SameValue(FrameHolePos ,FrameHolePos2,1));
  OptimumEndHoleDistance := MinEndDist *2; //  MinEndDist is from rivet centre
  ILine := IntersectItem.Line(1,2);
  SLine := StaticItem.Line(1,2);
  if (AngleBetweenLines2D(ILine, SLine, True) >= 45) then
     exit;
  if Entity[IntersectItem.OriginalIndex].isVertical then
     exit;
  if sametext(Entity[IntersectItem.OriginalIndex].iType,'Chord') then
     exit;

  StaticItemNorm := Normalize2D(Vector2DFrom2DPoints(StaticItem.Pt[1], StaticItem.Pt[4]));
  RLine1.Pt[1] := Point2DFromParametricEquation(StaticItem.Pt[1], StaticItemNorm, FrameHolePos);
  RLine1.Pt[2] := Point2DFromParametricEquation(StaticItem.Pt[2], StaticItemNorm, FrameHolePos);

  IntersectItemNorm := Normalize2D(Vector2DFrom2DPoints(IntersectItem.Pt[1], IntersectItem.Pt[4]));
  IntersectItemV := Vector2DFrom2DPoints(IntersectItem.Pt[1], IntersectItem.Pt[2]);
  RLine2.Pt[1] := Point2DFromParametricEquation(IntersectItem.Pt[1], IntersectItemNorm, FrameHolePos);
  RLine2.Pt[2] := Point2DFromParametricEquation(IntersectItem.Pt[2], IntersectItemNorm, FrameHolePos);
  ItemLength := linelength2d(IntersectItem.Pt[1], IntersectItem.Pt[2]);
  if not FindIntercept(RLine1,rLine2, {out }HolePt) then
    exit;

  if IsInRect(Entity[IntersectItem.OriginalIndex ].FRect, HolePt) then
    exit;       // if default hole position is inside the IntersectItem, nothing to do

  // find optimum hole position on intersect item
  if IntersectItem.ExtendEnd = tt14 then
    HolePt := Point2DFromParametricEquation(RLine2.Pt[1], IntersectItemV, OptimumEndHoleDistance)
  else
    HolePt := Point2DFromParametricEquation(RLine2.Pt[2], IntersectItemV, -OptimumEndHoleDistance);

  P:=ClosestPtOn2DLine(RLine1.Pt[1],RLine1.Pt[2],HolePt);
  dV:= Vector2DFrom2DPoints(HolePt,P);     // vector to closest point on static item rivet line
  if DotProduct2D(dV,StaticItemNorm) < 0 then
  begin
    d:=Vector2DMagnitude(dV) * ItemLength / (ItemLength - OptimumEndHoleDistance);
    with Entity[intersectItem.OriginalIndex] do
    begin
      if IntersectItem.ExtendEnd = tt14 then
      begin
        Pt[1] := Point2DFromParametricEquation(Pt [1], dV, d);
        Pt[4] := Point2DFromParametricEquation(Pt [4], dV, d);
      end
      else
      begin
        Pt[2] := Point2DFromParametricEquation(Pt [2], dV, d);
        Pt[3] := Point2DFromParametricEquation(Pt [3], dV, d);
      end;
    end;
  end;
end;

//* Lateral shift to remove virtual mitre when built on double-rivet machine
procedure FixVirtualMitre;
var
  P, PonGapLine: Point2d;
  StaticItemNorm, dV: Vector2D;
  ILine,SLine, gapLine: LineType2D;
  d: double;
begin
  ILine := IntersectItem.Line(1,2);
  SLine := StaticItem.Line(1,2);
  if (AngleBetweenLines2D(ILine, SLine, True) >= 45) then
     exit;
  if Entity[IntersectItem.OriginalIndex].isVertical then
     exit;
  if sametext(Entity[IntersectItem.OriginalIndex].iType,'Chord') then
     exit;
  if IntersectItem.ExtendEnd = tt14 then
    p:=IntersectItem.Pt[1]
  else
    p:=IntersectItem.Pt[2];

  StaticItemNorm := Normalize2D(Vector2DFrom2DPoints(StaticItem.Pt[1], StaticItem.Pt[4]));
  gapLine.Pt[1] := Point2DFromParametricEquation(StaticItem.Pt[1], StaticItemNorm, JointGap);
  gapLine.Pt[2] := Point2DFromParametricEquation(StaticItem.Pt[2], StaticItemNorm, JointGap);
  PonGapLine:=ClosestPtOn2DLine(gapLine.Pt[1],gapLine.Pt[2],p);
  dV:= Vector2DFrom2DPoints(P,PonGapLine);
  if DotProduct2D(dV,StaticItemNorm)>0 then
  begin
    d:=Vector2DMagnitude(dV);
    with  Entity[intersectItem.OriginalIndex] do
    begin
      if IntersectItem.ExtendEnd = tt14 then
      begin
        Pt[1] := Point2DFromParametricEquation(Pt[1], dV, d);
        Pt[4] := Point2DFromParametricEquation(Pt[4], dV, d);
      end
      else
      begin
        Pt[2] := Point2DFromParametricEquation(Pt[2], dV, d);
        Pt[3] := Point2DFromParametricEquation(Pt[3], dV, d);
      end;
    end;
  end;
end;

procedure FixVirtualMitres;
var i,j: integer;
begin
  for i:=0 to pred(High(Entity))do
  begin
    for j:=succ(i) to High(Entity)do
    begin
      if ItemsAreParallel(i,j) or Entity[i].bNonRF or Entity[j].bNonRF then
        continue;
      if EntitiesTouch(i, j) then     //StaticItem and IntersectItem are decided back here
        FixVirtualMitre;
    end;
  end;
end;

procedure ForceVirtualMitres;
var i,j: integer;
begin
  for i:=0 to pred(High(Entity))do
  begin
    for j:=succ(i) to High(Entity)do
    begin
      if ItemsAreParallel(i,j) or Entity[i].bNonRF or Entity[j].bNonRF then
        continue;
      if EntitiesTouch(i, j) then     //StaticItem and IntersectItem are decided back here
        ForceVirtualMitre;
    end;
  end;
end;
{--------------------------}
{$ENDREGION}

function ItemsAreFacingEachOther: Boolean;
var
  p1, p2, Intercept: Point2D;
  //dFlg, dLip: Double;
  L: LineType2D;
begin
  p1 := MidPoint2D(IntersectItem.FlangeLine);
  p2 := MidPoint2D(StaticItem.FlangeLine);
  //dFlg := LineLength2D(p1,p2);

  {
  p1 := MidPoint2D(IntersectItem.Line(3,4));
  p2 := MidPoint2D(StaticItem.Line(3,4));
  dLip := LineLength2D(p1,p2);

  Result := dLip < dFlg;
  }
  L.Pt[1] := p1;  L.Pt[2] := p2;
  Result := FindIntercept(L, StaticItem.Line(3,4), Intercept)
         and (LineLength2D(p1,p2) > LineLength2D(p1, Intercept));
end;

//* Specially for trusses that have their flange tips joined that already have a notch
//* it put the cope on the other item (StaticItem)
//* occurs when there is a small angle between the items, 5 and 10 degrees
procedure CopeStaticItem;
const
  TOL=1;
var
  LipLine, EndLine: LineType2D;
  p: Point2D;
  V: Vector2D;
begin
  LipLine := StaticItem.Line(4,3);
  with LipLine do
  begin
    V := Vector2DFrom2DPoints(StaticItem.Pt[1], StaticItem.Pt[4]);
    Pt[1] := Point2DFromParametricEquation(StaticItem.Pt[4], V, -LipSize);
    Pt[2] := Point2DFromParametricEquation(StaticItem.Pt[3], V, -LipSize);
  end;

  EndLine := IntersectItem.Line(1,4);
  if IntersectItem.ExtendEnd = tt23 then
    EndLine := IntersectItem.Line(2,3);
  if not(
         (FindIntercept(LipLine, EndLine, p))
         and(PointOnLine(EndLine, p, TOL))
         ) then
    exit;

  p := ClosestPtOn2DLine(StaticItem.Line(4,3), p);

  // add the CopeNotchTol
  V := Vector2DFrom2DPoints(StaticItem.Pt[1], StaticItem.Pt[2]);
  case StaticItem.ExtendEnd of
    tt14: p := Point2DFromParametricEquation(p, V, CopeNotchTol);
    tt23: p := Point2DFromParametricEquation(p, V, -CopeNotchTol);
  end;

  // assign to the intended cope end
  case StaticItem.ExtendEnd of
    tt14: Entity[StaticItem.OriginalIndex].Cope[1] := p;
    tt23: Entity[StaticItem.OriginalIndex].Cope[2] := p;
  end;
end;

//* 2nd Cope proc for truss items that meet at the end of the flange but don't have a notch
procedure CopeStaticItem2;
const
  TOL=1;
var
  LipLine, FlgLine: LineType2D;
  p, q: Point2D;
  d: Double;
begin
  LipLine := StaticItem.Line(4,3);
  FlgLine := IntersectItem.FlangeLine;
  if not(
         (FindIntercept(LipLine, FlgLine, p))
         and(PointOnLine(LipLine, p, TOL))
         ) then
    exit;

  // Check it's not too far from the end
  q := Entity[StaticItem.OriginalIndex].Pt[4];
  if (StaticItem.ExtendEnd = tt23) then
    q := Entity[StaticItem.OriginalIndex].Pt[3];
  d := LineLength2D(q, p);

  if d > Entity[StaticItem.OriginalIndex].Web then     // > the width is too far
    exit;

  // assign to the intended cope end
  case StaticItem.ExtendEnd of
    tt14: Entity[StaticItem.OriginalIndex].Cope[1] := p;
    tt23: Entity[StaticItem.OriginalIndex].Cope[2] := p;
  end;
end;

//* Main routine
//* *********************************************************************
//*   Distances that need to be set from the calling program's settings form:
//*    JointGap
//*    LipHolePos
//*    FlgHolePos
//*    MinEndDist
//*    NotchSize
//*    CopeSize
//*    CopeNotchTol
//* *********************************************************************
function ProcessTruss(var AEntity: array of EntityRecType; NumEntities: Word): Integer;
var      //Returns the number of rivets needed (>= 0), or an error number (-ve)
  i,j, StaticIdx, IntersectIdx: Integer;
  k: Byte;
  ExtDist, CopeDistance, ExtraCopeDist,
  NotchDist: Double;
  Hole2Pt: Point2D;
begin
  ClearEntity;
  SLErrorItems.Clear;
  TotalRivets := 0;
  if (not bFrames) then
    FrameType := 'Truss';
  bisTruss := SameText(Copy(FrameType, 1, 5), 'Truss');
  Result := 0;
  if NumEntities < 2 then
    exit;

  if (LipHolePos < FlgHolePos)and(not bFrames) then
  begin
    Result := RESULT_LIP_LT_FLG;
    exit;
  end;

  SetLength(Entity, NumEntities);
  for i:=0 to pred(NumEntities) do
    Entity[i] := AEntity[i];

  RemoveOriginPoints;
  FillChar(MitreNotch, SizeOf(MitreNotch), 0);
  FillChar(MitreCope, SizeOf(MitreCope), 0);
  FillChar(NotchOut, SizeOf(NotchOut), 0);
  FillChar(CopeOut, SizeOf(CopeOut), 0);

  for i:=0 to High(Entity)do
    Entity[i].FRect := RectType(Entity[i].Pt); // design-profile for EntitiesTouch()

  if bFrames and SameText(FrameType, 'Truss(R)') then
  begin
    if SameValue(FrameHolePos,FrameHolePos2, 1) then
      ForceVirtualMitres    // Lateral shift to create virtual mitre when built on single-rivet machine
    else  // not SameValue(FrameHolePos, FrameHolePos2, 1)
      FixVirtualMitres;     // Lateral shift to remove virtual mitre when built on double-rivet machine
  end;

  MeasureWebs;
  MakeFramePerimeterTabs;
  MakeEndsSquare;      //MitreCope and MitreNotch set here

  Make34Parallel;

  FindAcuteDist;
  MinNotchDist := NotchSize - CutWidth - NOTCH_START_TOL;

  ClearClusters;

  HoleOutPt := THE_ORIGIN;
  for i:=0 to pred(High(Entity))do
    for j:=succ(i) to High(Entity)do
      if (not bFrames)and(EntitiesAreButted(i,j))then
      begin
        inc(Result);
        if NumEntities = 2 then
          HoleOutPt := Entity[i].FHoles[1];
      end
      else
      if EntitiesTouch(i, j) then     //StaticItem and IntersectItem are decided back here
      if (not bFrames)or(not ItemsAreParallel(i,j))then
      begin
        if not(Entity[i].bNonRF and Entity[j].bNonRF) then
          inc(Result);
        if not BoxWebIntersection(i,j)then
        begin
          StaticIdx := j;    IntersectIdx := i;
          if StaticItem.OriginalIndex = i then
          begin
            StaticIdx := i;  IntersectIdx := j;
          end;

          if bMultiHoleFlagged then
          begin
            bMultiHoleFlagged := ItemsArePerpendicular;
            //remove multihole from nogs
            if bMultiHoleFlagged then
            begin
              if Entity[StaticIdx].IsVertical then
                bMultiHoleFlagged := Entity[IntersectIdx].IsChord
              else
              if Entity[IntersectIdx].IsVertical then  // should always be the case for (bMultiHoleFlagged and(not Entity[StaticIdx].IsVertical))
                bMultiHoleFlagged := Entity[StaticIdx].IsChord;
            end;
          end;

          FindOptHole;

          StaticItem.bIsFacingItem := ItemsAreFacingEachOther;
          Entity[StaticIdx].bIsFacingItem := StaticItem.bIsFacingItem;  // is currently only set for the StaticItem

          ExtDist := GetIntersectItemExtension;
          if ExtDist <> 0 then
            ExtendIntersectItem(ExtDist);
          if bTipsMeet then
          begin
            ExtDist := GetStaticItemExtension;  //Only needed for end on extensions
            if ExtDist <> 0 then
            begin
              if (ExtDist > 0)
              //or (not StaticItem.IsHorz)  //or (Round(StaticItem.Pt[1].y) <> Round(StaticItem.Pt[2].y))  // <--- horiz
              //or (StaticItem.Pt[1].y >= StaticItem.Pt[4].y)then   // <--- bottom track
              or (not StaticItem.bIsFacingItem) then
                ExtendStaticItem(ExtDist);
            end;
          end;

          for k:=1 to 4 do
          begin
            Entity[StaticIdx].Pt[k] := StaticItem.Pt[k];
            Entity[IntersectIdx].Pt[k] := IntersectItem.Pt[k];
          end;

          if NumEntities = 2 then
            HoleOutPt := StaticItem.HolePt;

          //Add the Hole to the arrays
          AddHole(StaticIdx, StaticItem.HolePt, StaticItem.IsFlangeHole);
          AddHole(IntersectIdx, IntersectItem.HolePt, IntersectItem.IsFlangeHole);
          if bMultiHoleFlagged then
          begin
            //inc(Result);      //not required, no multihole for trusses
            case HoleIdx of
              1: Hole2Pt := Punch[4];
              2: Hole2Pt := Punch[3];
              3: Hole2Pt := Punch[2];
              4: Hole2Pt := Punch[1];
            end;
            AddHole(StaticIdx, Hole2Pt, not StaticItem.IsFlangeHole);
            AddHole(IntersectIdx, Hole2Pt, not IntersectItem.IsFlangeHole);
          end;
          AddCluster(Punch);

          bStaticItemTab := bFlgTipsMeet
                         and (StaticItem.CloserEdge = et34)
                         and (IntersectItem.IntersectEdge = et12); // set before GetNotchDistance
          ExtraCopeDist := 0;
          //Notch
          NotchDist := GetNotchDistance(IntersectItem.Notch);
          if (NotchDist>0)then
          begin
            if (NotchDist < MinNotchDist)then  //lengthen the item, so it's at the min ... necessary?
              ExtendItemEnd(IntersectIdx, IntersectItem.ExtendEnd, MinNotchDist - NotchDist);

            if (not bFrames)or(bFrames and bVirtualMitre)
            or(StaticItem.CloserEdge = et12)then
            begin
              if IntersectItem.ExtendEnd = tt14 then
                Entity[IntersectIdx].Notch[1] := IntersectItem.Notch
              else
                Entity[IntersectIdx].Notch[2] := IntersectItem.Notch;
            end;

            if (not bFrames)
            and(IntersectItem.IntersectEdge = et34)
            and(StaticItem.CloserEdge = et12)then
              ExtraCopeDist := GetExtraCopeDistance;  //was CopeSize;
          end;
          if bStaticItemTab then
            MakeTabbedNotch;

          //Cope
          if (not bFrames) and (bFlgTipsMeet) and (NotchDist > 0) then
            CopeStaticItem // special routine for trusses meeting at the end at small angles (copes the other item)
          else begin
            CopeDistance := GetCopeDistance(IntersectItem.Cope);
            if (CopeDistance>0)or(ExtraCopeDist>0) then
            begin
              if CopeDistance < ExtraCopeDist then
                FindExtraCopePoint( ExtraCopeDist );
              with Entity[IntersectIdx]do
                IntersectItem.Cope := ClosestPtOn2DLine(Pt[3], Pt[4], IntersectItem.Cope);
              if IntersectItem.ExtendEnd = tt14 then
                Entity[IntersectIdx].Cope[1] := IntersectItem.Cope
              else
                Entity[IntersectIdx].Cope[2] := IntersectItem.Cope;
            end;
            if (not bFrames) and (bFlgTipsMeet) and (not ItemsArePerpendicular) then
              CopeStaticItem2;
          end;
          if not bFrames then
            CheckStaticItemLength;
          CheckIntersectItemLength;
          AddSwageToBothItems;
          if bLateLengthChange then
            CheckIntersectItemNotch;
          FindFlattenPoints;
        end;
      end;

  if NumEntities = 2 then
  begin
    for i:=0 to 1 do
    begin
      NotchOut[i] := Entity[i].Notch[1];
      if (not PointIsOrigin(Entity[i].Notch[2])) then
        NotchOut[i] := Entity[i].Notch[2];

      CopeOut[i] := Entity[i].Cope[1];
      if (not PointIsOrigin(Entity[i].Cope[2])) then
        CopeOut[i] := Entity[i].Cope[2];
    end;
  end;

  FindSwages;
  MeasureLens;
  AddCTandInsertHoles;

  TotalRivets := TotalRivets + Result;   //TotalRivets is decremented in FindOptHole when matching holes are found

  AdjustAddedRivetHolePositions;     //needs to be before the SetPosHoles call

  if SetPosHoles < 0 then
    Result := RESULT_NOT_FOUND;  //-1;

  SortHoles;

  if bMinimiseLengths and(not bFrames)then
    OptimizeLengths;

  AddMitreNotchesAndCopes;
  if not SetPosNotchAndPosCope then
    Result := RESULT_RANGE_ERR;
  if not AddAddedCopes then
    Result := RESULT_ADDED_COPE_ERR;
  if not AddAddedNotches then
    Result := RESULT_ADDED_NOTCH_ERR;
  SortNotchesAndCopes;
  RemoveExtraNotches;
  RemoveExtraCopes;
  AddEndLoadCuts;

  SetServiceHolePositions;
  SetSwagePositions;

  if not HoleCoordsMatchPos then
    Result := RESULT_HOLE_ERR;

  for i:=0 to pred(NumEntities) do      //finally return to the dynamic array
    AEntity[i] := Entity[i];
  SetLength(Entity, 0);
  Entity := nil;
end;

//* Return the Hole Point from a Position value
function HoleCoordFromPos(AEntityRec: EntityRecType; Position: Double; isFlange: Boolean): Point2D;
var
  ThisWeb, Fraction: Double;
  End1Line, HoleLine: LineType2D;
  V: Vector2D;
  p0, mid14, mid23: Point2D;
begin
  Result := THE_ORIGIN;
  with AEntityRec do
  begin
    ThisWeb := LineLength2D(Pt[1], Pt[4]);
    if bFrames then
    begin
      Fraction := FrameHolePos2 / ThisWeb;
      if (isFlange)then
        Fraction := FrameHolePos / ThisWeb;
    end
    else begin
      if EntityIsBoxWeb(AEntityRec)then
        Fraction := 0.5
      else begin
        Fraction := LipHolePos / ThisWeb;
        if isFlange then
          Fraction := FlgHolePos / ThisWeb;
      end;
    end;
    
    HoleLine.Pt[1].x := Pt[1].x + (Pt[4].x - Pt[1].x)*Fraction;
    HoleLine.Pt[1].y := Pt[1].y + (Pt[4].y - Pt[1].y)*Fraction;
    HoleLine.Pt[2].x := Pt[2].x + (Pt[3].x - Pt[2].x)*Fraction;
    HoleLine.Pt[2].y := Pt[2].y + (Pt[3].y - Pt[2].y)*Fraction;
    V := Vector2DFrom2DPoints(HoleLine.Pt[1], HoleLine.Pt[2]);

    End1Line.Pt[1] := Pt[1];  End1Line.Pt[2] := Pt[4];
    mid14 := MidPoint2D(Pt[1], Pt[4]);    mid23 := MidPoint2D(Pt[2], Pt[3]);
    End1Line.Pt[1] := Pt[1];  End1Line.Pt[2] := Pt[4];
    if not (AEntityRec.IsVertical)then
    begin
      if mid23.x < mid14.x then
      begin
        End1Line.Pt[1] := Pt[2];  End1Line.Pt[2] := Pt[3];
        V.x := -V.x;  V.y := -V.y;
      end;
    end
    else begin
      if mid23.y < mid14.y then
      begin
        End1Line.Pt[1] := Pt[2];  End1Line.Pt[2] := Pt[3];
        V.x := -V.x;  V.y := -V.y;
      end;
    end;

    if FindIntercept(End1Line, HoleLine, p0)then
      Result := Point2DFromParametricEquation(p0, V, Position);
  end;
end;

//* Convert a flange distance to a point
function FlangeCoordFromPos(AEntityRec: EntityRecType; Position: Double): Point2D;
var
  p: Point2D;
  V: Vector2D;
begin
  Result := THE_ORIGIN;
  with AEntityRec do
  begin
    V := Vector2DFrom2DPoints(Pt[1], Pt[2]);
    p := Pt[1];
    if not (AEntityRec.IsVertical)then
    begin
      if Pt[2].x < Pt[1].x then
      begin
        p := Pt[2];
        V.x := -V.x;  V.y := -V.y;
      end;
    end
    else begin
      if Pt[2].y < Pt[1].y then
      begin
        p := Pt[2];
        V.x := -V.x;  V.y := -V.y;
      end;
    end;
    Result := Point2DFromParametricEquation(p, V, Position);
  end;
end;

function DistFromHoleToEnd(anEntity : pEntityRecType; p: Point2D): Double;
var
  End1Line  : LineType2D;  //First end out of the machine
  mid14     : Point2D;
  mid23     : Point2D;
begin
  with anEntity^ do
  begin
    mid14 := MidPoint2D(Pt[1], Pt[4]);    mid23 := MidPoint2D(Pt[2], Pt[3]);
    End1Line.Pt[1] := Pt[1];  End1Line.Pt[2] := Pt[4];
    if not (anEntity.IsVertical)then
    begin
      if mid23.x < mid14.x then
      begin
        End1Line.Pt[1] := Pt[2];  End1Line.Pt[2] := Pt[3];
      end;
    end
    else begin
      if mid23.y < mid14.y then
      begin
        End1Line.Pt[1] := Pt[2];  End1Line.Pt[2] := Pt[3];
      end;
    end;
  end;
  Result := abs(PerpDistance(End1Line.Pt[1], End1Line.Pt[2], p));
end;

initialization

finalization
  ClearEntity;
  ClearClusters;

END.
