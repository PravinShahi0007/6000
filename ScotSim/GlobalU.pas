unit GlobalU;

{
Global types, variables and constants
}

interface

uses
  SysUtils;

const
  MAX_OPS=500;  //v.301 was 100;  //v.205, was 60;
  MAX_HOLES = 240;  //120;

type
  Point2D = record x,y: Double; end;
  Point2DArray = array of Point2D;
  LineType2D = record Pt: array[1..2] of Point2D; end;
  Vector2D = record x,y: Double; end;
  RectType = record Pt: array[1..4] of Point2D; end;
  TTrapezium = record Pt: array[1..4] of Point2D; end;
  SortPointsType = record
                  SortNo: Double;
                  p: Point2D;
                end;
  OrientationType = (otLeft, otRight, otUp, otDown);

  TOpKind = (okNone, okCT, okIns, okCope, okNotch
          , okCon1, okTek, okTek2, okTek4  //spacers and spacers plus tek screws
          , okScr, okScb  //Scb is a doubled sided screw
          , okBrA, okBrB, okBrC   //three bearing types that display under the truss
          , okBrace               //brace symbol displayed next to a web
          , okPC                  //precamber % that is displayed next to a BC
          , okServ1, okServ2      //service holes, 1 small, 2 large
          , okSwage
          , okSlot                //Slotted hole, initially 8mm x 30mm, now not used
          , okLipHole, okFlgHole  //ops for adding holes with AddOpFormU, these get converted into okIns when saved
          , ok2Rivet, ok4Rivet, ok2Rivet2Tek, ok2Rivet4Tek  // ops for C-Section Trusses
          //  , okEndLoadCut           // 8mm slot 4mm from end of vert, panels only ... reusing OkSlot
          );
  OpType = record
             Kind: TOpKind;
             p: Point2D;
             Num: Word;  //was Byte;
             Pos: Double;  //for added swages
           end;
  TipType = (tt14, tt23);
  EntityRecType=record  //truss item record
                  Truss, Item: string[10];
                  iType: string[5];
                  ID: Word;
                  Pt: array[1..4]of Point2D;
                  Len, Web: Double;
                  Col: Integer;
                  FHoles, LHoles: array[1..MAX_HOLES] of Point2D;  //x,y positions
                  OpCount: Word;
                  Op: array[1..MAX_OPS]of OpType;
                  Notch, Cope: array[1..2] of Point2D;   //start & finish positions along flg or lip
                  PosFHoles, PosLHoles: array[1..MAX_HOLES] of Double;
                  PosNotch, PosCope: array[1..200] of Double;  //was 20, then 40, then 100 more are needed for flats in Frames
                  PosServ1,PosServ2: array[1..50] of Double;  //v.301 was 20, service hole output, 1 small, 2 large
                  PosSwage: array[1..30] of Double;           //was[1..2], Pete uses the extra values in RF
                  Swage: array[1..2] of Boolean;
                  //bCopeTolDone: Boolean;       //not used from v.329
                  bNonRF: Boolean;
                  PossibleSwagePt: Point2D;
                  bIsFacingItem: Boolean;
                  FRect: RectType; // original Rect
                  FrameID     : Integer;
                  JOBID       : Integer;
                  EP2FILEID   : Integer;
                  function IsVertical: Boolean;
                  function IsAMultiHoleType: Boolean;
                  function IsChord: Boolean;
                  function endline(ATip: TipType): LineType2D;
                  function isBoxDbl: boolean;
                  function isBoxWeb: boolean;
                  function bcItem: boolean;
                  function tcItem: boolean;
                  function Orientation: OrientationType;
                 end;
  pEntityRecType = ^EntityRecType;

  EdgeType = (et12, et34);
  PosAndPointType = (ppFlg, ppLip);
  NotchCopeType = (ncNotch, ncCope);
  StaticItemType = record
                     Pt: array[1..4]of Point2D;
                     HolePt: Point2D;
                     IsFlangeHole: Boolean;
                     OriginalIndex: Integer;
                     ExtendEnd: TipType;
                     CloserEdge: EdgeType;
                     TabNotch: Point2D;
                     bIsFacingItem: Boolean;
                     function Line(PtIdx1, PtIdx2: Byte): LineType2D;
                     function FlangeLine: LineType2D;
                     function FarTipLine: LineType2D;
                     function IsVertical: Boolean;
                     function IsHorz: Boolean;
                   end;
  IntersectItemType = record
                        Pt: array[1..4]of Point2D;
                        HolePt: Point2D;
                        IsFlangeHole: Boolean;
                        OriginalIndex: Integer;
                        ExtendEnd: TipType;
                        IntersectEdge: EdgeType;
                        Notch, Cope: Point2D;
                        function Line(PtIdx1, PtIdx2: Byte): LineType2D;
                        function FlangeLine: LineType2D;
                        function FarTipLine: LineType2D;
                        function IsVertical: Boolean;
                      end;
const
  INITIAL_SCALE=0.05;
  MAX_ITEMS=400;
  BIG_DUMMY=100000000;
  THE_ORIGIN: Point2D=(X:0; y:0);

  RESULT_OK = 0;

  //InitJoining Result values
  RESULT_NOT_FOUND = -1;
  RESULT_NOT_INITIALISED = -2;
  RESULT_LIP_LT_FLG = -3;  //LipHolePos < FlgHolePos
  RESULT_HOLE_ERR = -4;    //HoleCoords don't match pos (dist)
  //HoleFind ignores these
  RESULT_RANGE_ERR = -5;   //PosCope or PosNotch exceeded bounds (20)
  RESULT_ADDED_COPE_ERR = -6;
  RESULT_ADDED_NOTCH_ERR = -7;

  TXT_EXT = 'txt';
  TEXT_FILES_FILTER = 'Text Files (*.'
                    + TXT_EXT
                    + ')|*.'
                    + TXT_EXT;    //'Text Files (*.txt)|*.txt'
  sCHORD = 'Chord';
  sWEB = 'Web';
  //Multi Hole
  sCHORD2 = 'Cord2';
  sWEB2 = 'Web2';
  //Box Web and Box Heel doubles
  sBOX_HEEL_2 = 'Web3';  //was 'BoxH2'
  sBOX_WEB_2 = 'Web4';   //was 'BoxW2'

  HIDDEN_ITEM_CHAR: string[1] = '~';

  NOTCH_START_TOL = 1;   //to avoid damage to the guillotine, might be reduced to 1 later
  MIN_SWAGE_OVERLAP = 3;

var
  Scale: Double=INITIAL_SCALE;
  JointGap: Double=3;
  LipHolePos: Double=37; //15;
  FlgHolePos: Double=19;
  MinEndDist: Double = 15;   //smallest allowable dist to the end of the Truss (1.5 * HoleSize)
  LipSize: Double=6;

  //debugPunch: array[1..4] of Point2D;
  NotchSize: Double = 21;
  CopeSize: Double = 21;
  CopeNotchTol: Double = 10;
  //DebugBool: Boolean=False;
  //DebugLine: LineType;
  bMinimiseLengths: Boolean=False;
  Gauge: string;
  //bShortenBottomHorzItems: Boolean=False;
  bRequire2PtWebToWeb: Boolean=False;

  ScotTrussSettingsFile: string;
  ScotRFSettingsFile: string;

  bFrames: Boolean=False;  // bFrames = Panels
  FrameHolePos: Double=27; //or 22
  FrameHolePos2: Double=15;
  VertJointGap: Double=1;
  PanelSwageSize: Double=65;
  TrussSwageSize: Double=64;
  bPanelUseSwage: Boolean=True;
  bTrussUseSwage: Boolean = False;
  bEndLoadCut: Boolean = False;
  EndLoadCutSize: Double = 8;  // 8 mm cut width, 4mm from the end of the item
  CutWidth: Double=4.8;  //or 2 for RF4     BladeCutWidth
  TotalRivets: Integer=0;
  bIgnoreMinEndDistErrors: Boolean=False;
  bVirtualMitre: Boolean=True;
//  bUSJointing: Boolean=False;
  startpause,startnow:tdatetime;
  encrypt: Boolean=True;
  pwd1:boolean=false;
  pwd2:boolean=false;
  midas:boolean;  // touch screen active
  pzdist:integer; // (p)revious (z)oom distance for 2 finger zooming

  bUseBoxWebbing: Boolean;
  BoxWebHeight: Double=40;

  MaxAngleApart: Double=11;  //originally tested 40 for Debug, choice of hole 1 depends on angle apart

implementation

uses UtilsU;   // for LineDirectionRadians in Orientation function

{ StaticItemType }

function StaticItemType.Line(PtIdx1, PtIdx2: Byte): LineType2D;
begin
  Result.Pt[1] := Pt[PtIdx1];  Result.Pt[2] := Pt[PtIdx2];
end;

function StaticItemType.FarTipLine: LineType2D;
begin
  Result.Pt[1] := Pt[1];   Result.Pt[2] := Pt[4];
  if ExtendEnd = tt14 then
  begin
    Result.Pt[1] := Pt[2]; Result.Pt[2] := Pt[3];
  end;
end;

function StaticItemType.FlangeLine: LineType2D;
begin
  Result := Line(1,2);
end;

function StaticItemType.IsHorz: Boolean;
begin
  Result := Round(Pt[2].y - Pt[1].y) = 0;
end;

function StaticItemType.IsVertical: Boolean;
begin
  Result := Round(Pt[2].x - Pt[1].x) = 0;
end;

{ IntersectItemType }

function IntersectItemType.FarTipLine: LineType2D;
begin
  Result.Pt[1] := Pt[1];   Result.Pt[2] := Pt[4];
  if ExtendEnd = tt14 then
  begin
    Result.Pt[1] := Pt[2]; Result.Pt[2] := Pt[3];
  end;
end;

function IntersectItemType.Line(PtIdx1, PtIdx2: Byte): LineType2D;
begin
  Result.Pt[1] := Pt[PtIdx1];  Result.Pt[2] := Pt[PtIdx2];
end;

function IntersectItemType.FlangeLine: LineType2D;
begin
  Result := Line(1,2);
end;

function IntersectItemType.IsVertical: Boolean;
begin
  Result := Round(Pt[2].x - Pt[1].x) = 0;
end;

{ EntityRecType }

function EntityRecType.IsAMultiHoleType: Boolean;
begin
  Result := SameText(iType, sCHORD2)or SameText(iType, sWEB2);
end;

function EntityRecType.IsChord: Boolean;
begin
  Result := SameText(iType, sCHORD)or SameText(iType, sCHORD2);
end;

function EntityRecType.IsVertical: Boolean;
begin
  Result := Round(Pt[2].x - Pt[1].x) = 0;
end;

function EntityRecType.endline(ATip: TipType): LineType2D;
begin
  // tip line (uses original coordinates)
  if ATip = tt14 then
  begin
    Result.Pt[1] := FRect.Pt[1];
    Result.Pt[2] := FRect.Pt[4];
  end else
  begin
    Result.Pt[1] := FRect.Pt[2];
    Result.Pt[2] := FRect.Pt[3];
  end;

end;

//* Return the orientation of Entity[Idx] one of: otLeft, otRight, otUp, otDown
function EntityRecType.Orientation: OrientationType;
var
  Dirn: Extended;
begin
  Dirn := abs(LineDirectionRadians(Pt[1], Pt[2]));
  if (Dirn < 3*pi/4)and(Dirn > pi/4)then   //Closer to vertical, Left or Right
  begin
    Result := otLeft; //Default
    if Pt[1].x < Pt[4].x then
      Result := otRight;
  end
  else begin //Closer to Horiz, Up or Down
    Result := otUp; //Default
    if Pt[1].y > Pt[4].y then
      Result := otDown;
  end;
end;

function EntityRecType.tcItem: boolean;
begin
  tcItem := pos('TC', Item) > 0;
end;

function EntityRecType.bcItem: boolean;
begin
  bcItem := pos('BC', Item) > 0;
end;


function EntityRecType.isBoxDbl: boolean;
begin
  // all code relating to BoxDouble untested
  {$ifdef TRUSS}
  result :=bUseBoxwebbing and (SameText(itype, sBOX_WEB_2) OR SameText(iType,sBOX_HEEL_2));
  {$ELSE}
  result := false;
  {$ENDIF}
end;
function EntityRecType.isBoxWeb: boolean;
begin
  {$ifdef TRUSS}
  result :=bUseBoxwebbing and not tcItem and not bcItem;
  {$ELSE}
  result := false;
  {$ENDIF}
end;


begin
{$IFDEF Panel}
bframes:=true;
{$ELSE}
bFrames:=false;
{$ENDIF}

END.
