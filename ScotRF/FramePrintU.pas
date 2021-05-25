unit FramePrintU;

interface

uses sysUtils, Windows, classes, Graphics, Gauges, Printers, FrameDataU, utilsu, globalu,
     generics.Collections, generics.Defaults, winUtils ;

type
  TFramePrinter = class
  private type
    TKeyValue  = class
      key,value:string;
      constructor Create(const Akey,Avalue:string); overload;
      constructor Create(const Akey: string; const AValue: Double); overload;
    end;
    Const           // font sizes
      FS_Caption=14;
      FS_TABLE = 10;
      FS_SUPER = 26;
    var
      FS_ITEMID:integer;
  private
    FLogo: TBitmap;
    YOffset, FramePageH: integer;
    FrameNumber: integer;
    pscale: double;
    cxorg, cyorg: real;
    TableData: TObjectlist<TKeyValue>;
    FLineSpacing: Integer;
    FTextSize: TSize; // FS_STANDARD text size
    FMargin: Integer;
    FTop: integer;
    function TwoPerPage: boolean;
    procedure PrintName(AFrame: TSteelFrame);
    function Client2Printer(sx, sy: double): TPoint;
    procedure PrintJobDetails(AFilePath: string);
    procedure PrintLogo;
    procedure PrintFrame(AFrame: TSteelFrame);
    procedure PrintL(x1, y1, x2, y2: real; col: longint; lt: tpenstyle; pw: integer);
    procedure PrintTextW(x, y: double; s: string; AFontSize: integer; AColor:tColor=clBlack);
    procedure PrintText(x, y: integer; s: string; AFontSize: integer; AColor:tColor=clBlack);

    procedure PrintBearing(op: topkind; x, y: double; N: integer; AColor: integer);
    procedure SetScale(AFrame: TSteelFrame);
    procedure PrintCircle(x, y: double;Radius: integer;APenWidth: integer;AColor: TColor);
    procedure PrintBrace(op: topkind; x, y: double;   AColor:tColor);
    procedure PrintTableData(AFrame: TSteelFrame);
    procedure PrintVerticalTextW(x, y: double; s: string;   AFontsize: integer;AColor:tColor);
    procedure PrintItemLabel(AItem: pEntityRecType; AID: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure PrintFrames(AFrameSelection: TFrameSelection; ALogo: TBitmap);
  end;

  TFrameHelper = class(TSteelFrame)

  end;

implementation

uses Math,USettings, units, coil, ScotRFTypes;

procedure TFramePrinter.PrintFrames(AFrameSelection: TFrameSelection; ALogo: TBitmap);
var f: TSteelFrame;
  function NewPageReqd(N: integer): boolean;
  begin
    if TwoPerPage then
      result :=(N > 1) and odd(N)
    else
      result := true;
  end;

begin
  FLogo := ALogo;

  if formsettings.PrinterRG.Itemindex = 1 then
    printer.orientation := PoLandscape
  else
    printer.orientation := poportrait;
  printer.BeginDoc;
  try
    FrameNumber := 0;
    for f in AFrameSelection.selectedFrames do
    begin
      inc(FrameNumber);
      YOffset := 0;
      FTop := FTextSize.cy; // top margin for name / job detail
      if TwoPerPage and not odd(FrameNumber) then
      begin
        YOffset := printer.PageHeight div 2 - + FLineSpacing;
        FTop := YOffset;
      end;


      if not TwoPerPage or odd(FrameNumber) then
        if FrameNumber > 1 then
          printer.newPage;

      SetScale(f);
      PrintFrame(f);
      PrintName(f);

//      SortChordArray;
      PrintTableData(f);
      if not TwoPerPage or odd(FrameNumber) then
      begin
//        PrintJobDetails(AFrameSelection.FilePath);
        if not bframes then
          PrintLogo;
      end;
      if printer.Aborted then
        break;
    end;
  finally
    printer.enddoc;
  end;
end;

procedure TFramePrinter.PrintItemLabel(AItem: pEntityRecType; AID: string);
var
  sName: string;
  offset,x,y: Double;
  pt2D: point2D;
  oldTA: cardinal;
begin
  with AItem^ do
  begin
    // Member Label
    case formsettings.ItemLabelRG.Itemindex of
      0: sName := copy(item, 1, 2) + ':' + AID;
      1: sName := AID;
      else   exit; // no label
    end;
    if SameValue(pt[1].x , pt[2].x, 2) then // if vertical
    begin
      // vertical label @ 55mm from bottom end
      pt2D.x := pt[1].x;
      if Len<200 then
        Offset:=Len/5
      else
        Offset:=55;
      pt2D.y := minvalue([pt[1].y , pt[2].y, pt[3].y, pt[4].y]) + Offset;
      y := minvalue([pt[1].y , pt[2].y,pt[3].y,pt[4].y]) + Offset;
      x := pt[1].x; // uses alignment relative to flange line
      if pt[1].x < pt[4].x then
      begin
        oldTA:=setTextAlign(printer.Canvas.Handle, TA_TOP or TA_LEFT);
      end
      else
      begin
        oldTA:=setTextAlign(printer.Canvas.Handle, TA_BOTTOM or TA_LEFT);
      end;
      PrintVerticalTextW(x, y, sName, FS_ITEMID, clBlack);
      setTextAlign(printer.Canvas.Handle,oldTA);
    end else
    begin
      // Horizontal label @ frame center
      PrintTextW((pt[1].x + pt[3].x) / 2, (pt[1].y + pt[3].y) / 2 , sName, FS_ITEMID)
    end;
  end;
end;
procedure TFramePrinter.PrintFrame(AFrame: TSteelFrame);
var
  i, j, opcnt: integer;
  basewidth, linewidth: integer;
  PenWidth,Radius: integer;  {$ifDEF TRUSS} s: string; {$endif}
begin { of PrintStructure }
  TableData.Clear;
  with TFrameHelper(AFrame) do // cast to access protected members
  begin
{$IFDEF PANEL}
   TableData.Add( TKeyValue.Create('Height', PlateYMax - PlateYMin));
   TableData.Add( TKeyValue.Create('Width',  xmax - xmin));
{$ELSE}
  TableData.Add( TKeyValue.Create('Height', ChordYMax - ChordYMin));
  TableData.Add( TKeyValue.Create('Span', BCxmax - BCxmin));
{$ENDIF}
  end;
  for i := 0 to pred(TFrameHelper(AFrame).FItemcount) do
    with TFrameHelper(AFrame).FEntity[i] do
    begin
      if (itype = 'Chord') or(itype = 'Cord2') or (pos('Web', itype)> 0) or (pos('Heel', itype)> 0) or (pos('BC', itype)> 0) then
      begin
        if (itype = 'Web3') or (itype = 'Web4') then // change line widths for box web doubled items
        begin
          basewidth := 8;
          linewidth := 10;
        end
        else
        begin
          basewidth := 4;
          linewidth := 1;
        end;
        if not formsettings.Colourcbox.Checked then
        begin
          PrintL(pt[1].x, pt[1].y, pt[2].x, pt[2].y, clBlue, psSolid, basewidth);
          PrintL(pt[2].x, pt[2].y, pt[3].x, pt[3].y, clBlack, psSolid, linewidth);
          PrintL(pt[3].x, pt[3].y, pt[4].x, pt[4].y, clBlack, psSolid, linewidth);
          PrintL(pt[4].x, pt[4].y, pt[1].x, pt[1].y, clBlack, psSolid, linewidth);
        end
        else
        begin
          PrintL(pt[1].x, pt[1].y, pt[2].x, pt[2].y, col, psSolid, basewidth);
          PrintL(pt[2].x, pt[2].y, pt[3].x, pt[3].y, col, psSolid, linewidth);
          PrintL(pt[3].x, pt[3].y, pt[4].x, pt[4].y, col, psSolid, linewidth);
          PrintL(pt[4].x, pt[4].y, pt[1].x, pt[1].y, col, psSolid, linewidth);
        end;
      end;
  end;
  radius := ceil(FTextSize.cx/3);
  PenWidth:= round(radius/5);

  for i := 0 to pred(TFrameHelper(AFrame).FItemcount) do
  begin
    with TFrameHelper(AFrame).FEntity[i] do
    begin
      // rivets
      j:=1;
      while not PointIsOrigin(LHoles[j])do
      begin
        PrintCircle(LHoles[j].x, LHoles[j].y, 3{ radius}, 2 {penwidth}, clNavy);
        inc(j);
      end;
      j:=1;
      while not PointIsOrigin(FHoles[j])do
      begin
        PrintCircle(FHoles[j].x, FHoles[j].y, 3{ radius}, 2 {penwidth},clBlue);
        inc(j);
      end;
    end;
    // bearings & special joints
    with TFrameHelper(AFrame).FEntity[i] do
    begin
      // print this members display ops - Screws, spacers, braces, text etc ..
      opcnt := OpCount;
      for j := 1 to opcnt do
      begin
        if (op[j].Kind in [OkBrA,OkBrB,OkBrC]) then
          PrintBearing(op[j].Kind, op[j].p.x, op[j].p.y, op[j].num, clBlack);
        if (op[j].Kind = okBrace) and (formsettings.BraceCBox.Checked) then
          PrintBrace(op[j].Kind, op[j].p.x, op[j].p.y, clBlack);
        if op[j].Kind = OkCon1 then
        begin
          PrintCircle(op[j].p.x, op[j].p.y, radius, penWidth, clGreen);
        end;
        if (op[j].Kind = OkSCR) and not bframes then
        begin
          PrintCircle(op[j].p.x, op[j].p.y, radius, penWidth, clRed);
          PrintTextW(op[j].p.x, op[j].p.y, inttostr(op[j].num), FS_ITEMID, clRed);
        end;
        if (op[j].Kind = OkServ1) and bframes and G_Settings.printer_service then
          PrintCircle(op[j].p.x, op[j].p.y, PenWidth, radius, clBlue);
        //ok2Rivet, ok4Rivet, ok2Rivet2Tek, ok2Rivet4Tek  (2Rivet is standard)
        case op[j].Kind of
          ok4Rivet:     PrintTextW(op[j].p.x, op[j].p.y, '4R', FS_ITEMID);
          ok2Rivet2Tek: PrintTextW(op[j].p.x, op[j].p.y, '2R+2T', FS_ITEMID);
          ok2Rivet4Tek: PrintTextW(op[j].p.x, op[j].p.y, '2R+4T', FS_ITEMID);
        end;


      end;
    end;
  end;
  for i := 0 to pred(TFrameHelper(AFrame).FItemcount) do
    PrintItemLabel(@TFrameHelper(AFrame).FEntity[i], inttostr(I + 1));

  {$ifDEF TRUSS}
  for i := 0 to pred(TFrameHelper(AFrame).FItemcount) do
    with TFrameHelper(AFrame).FEntity[i] do
    begin
       // tabulated item data
       if formsettings.websizecbox.Checked then
       begin
          s := copy(item, 1, 2) + ':' + trim(inttostr(i + 1));
          TableData.Add( TKeyValue.Create(s, LineLength2D(pt[1], pt[2])));
       end;
    end;
  {$ENDIF}
end;

function TFramePrinter.Client2Printer(sx, sy: double): TPoint;
// *Changes sx,sy from actual coordinates to printer coordinates
var
  cx, cy: integer;
 pxorg, pyorg: double;
begin
  cx := trunc(sx);
  cy := trunc(sy);

  pxorg := trunc(printer.PageWidth / 2); // pxorg,pyorg is printer page origin
  if TwoPerPage then
    pyorg := trunc(printer.PageHeight / 4) + YOffset  // centre of top or bottom 1/2 page
  else
    pyorg := trunc(printer.PageHeight / 2);   // vert. centre whole page
  // cxorg,cyorg is client(real) origin
  result.x := round((cx - cxorg) * pscale + pxorg); // pscale is printer scale
  result.y := round(pyorg - (cy - cyorg) * pscale);
end;

procedure TFramePrinter.PrintL(x1, y1, x2, y2: real; col: longint; lt: tpenstyle; pw: integer);
// *Print line in real coordinates
// *Sets line style and width
var
  pt1,pt2: TPoint;
begin
  printer.Canvas.Pen.width := pw;
  printer.Canvas.Pen.style := lt;
  printer.Canvas.Pen.color := col;
  pt1:=Client2Printer(x1, y1);
  pt2:=Client2Printer(x2, y2);
  printer.Canvas.MoveTo(pt1.x, pt1.y);
  printer.Canvas.LineTo(pt2.x, pt2.y);
end;

procedure TFramePrinter.PrintTextW(x, y: double; s: string;  AFontSize: integer; AColor:tColor);
// * Prints string with world coordinates
// DY in pixels
var
  th, tw: integer;
  pt: TPoint;
begin
  printer.Canvas.Font.size := AFontSize;
  printer.Canvas.Font.color := AColor;
  th := trunc(printer.Canvas.TextHeight(s)) div 2;
  tw := trunc(printer.Canvas.TextWidth(s)) div 2;
  pt := Client2Printer(x, y);
  printer.Canvas.TextOut(pt.x - tw, pt.y - th, s);
end;

procedure TFramePrinter.PrintVerticalTextW(x, y: double; s: string;   AFontsize: integer;AColor:tColor);
// Prints string vertically with world coordinates
var
  pt: TPoint;
begin
  printer.Canvas.Font.size := AFontsize;
  printer.Canvas.Font.color := AColor;
  pt := Client2Printer(x, y);
  printer.Canvas.font.orientation:=900;
  try
    printer.Canvas.TextOut(pt.x, pt.y, s);
  finally
    printer.Canvas.font.orientation:=0;
  end;
end;

procedure TFramePrinter.PrintText(x, y: integer; s: string; AFontSize: integer; AColor:tColor=clBlack);
begin
  printer.Canvas.Font.size :=AFontSize;
  printer.Canvas.Font.color := AColor;
  printer.Canvas.TextOut(x, y, s);
end;

procedure TFramePrinter.PrintCircle(x, y: double; Radius: integer;APenWidth: integer;AColor: TColor);
// *prints circle with real origin and radius r, and colour col
var
  pt: TPoint;
begin
  printer.Canvas.Pen.color := AColor;
  printer.Canvas.Pen.Mode := pmCopy;
  printer.Canvas.Pen.width := APenWidth;
  printer.Canvas.Brush.style:=bsClear;
  pt := Client2Printer(x, y);
  printer.Canvas.Ellipse(pt.x - Radius, pt.y + Radius, pt.x + Radius, pt.y - Radius);
end;

constructor TFramePrinter.Create;
begin
  TableData:=TObjectlist<TKeyValue>.Create;
  FS_ITEMID := strtointdef(formsettings.fontsizeedit.text,8);
  printer.Canvas.Font.Size := FS_TABLE;
  printer.Canvas.Font.Name:='Microsoft Sans Serif';
  FLineSpacing := printer.Canvas.TextHeight('Xq')+2;
  FTextSize  := printer.Canvas.TextExtent('0');
  FMargin:= 2 * FTextSize.cy; // horz. margin
end;

destructor TFramePrinter.Destroy;
begin
  TableData.free;
  inherited;
end;

procedure TFramePrinter.PrintBearing(op: topkind; x, y: double; N: Integer; AColor: integer);
// *Prints truss bearing B1,B2 or B3 - types, as rectangles in real position x,y
var
  pt: TPoint;
  sz: tSize;
  BrgText: string;
const BrgSymbol: char='▲';
begin
  printer.Canvas.Font.size := FS_TABLE-2;
  printer.Canvas.Font.color := AColor;
  printer.Canvas.brush.style :=bsClear;
  sz := printer.Canvas.TextExtent(BrgSymbol);
  pt := Client2Printer(x, y);
  printer.Canvas.TextOut(pt.x - sz.cx div 2, pt.y, BrgSymbol);
  BrgText:='B' + inttostr(N);
  sz := printer.Canvas.TextExtent(BrgText);
  printer.Canvas.TextOut(pt.x - sz.cx div 2, pt.y + sz.cy - 4, BrgText );
  printer.Canvas.brush.style :=bsSolid;
end;

procedure TFramePrinter.PrintBrace(op: topkind; x, y: double; AColor:tColor);
var
  pt: TPoint;
const BraceSymbol: char='';
begin
  printer.Canvas.Font.size := FS_TABLE;
  printer.Canvas.Font.color := AColor;
  pt := Client2Printer(x, y);
  printer.Canvas.TextOut(pt.x, pt.y, BraceSymbol);
end;

procedure TFramePrinter.PrintJobDetails(AFilePath: string);
// Print the file name and job details
var
  y : integer;
  TextSize: tsize;
  LineSpacing: integer;
begin
  printer.Canvas.Font.size := FS_CAPTION;
  printer.Canvas.Font.color := clBlack;
  TextSize  := printer.Canvas.TextExtent('0');
  LineSpacing := round(TextSize.cy * 1.2);
  y := FTop;
  if formsettings. prtfilepathcbox.checked then
  begin
    printer.Canvas.TextOut(FMargin, y, AFilePath);
    y := y + LineSpacing;
  end;
  y := y + LineSpacing;
  printer.Canvas.TextOut(FMargin, y, FJobDetail.Design);
   y := y + LineSpacing;
  printer.Canvas.Font.size := FS_TABLE;
  printer.Canvas.TextOut(FMargin, y, FJobDetail.Steel);
end;

procedure TFramePrinter.PrintName(AFrame: TSteelFrame);
// *Print frame/truss code with commons if > 1
var
  x, y: integer;
  ts: string;
begin
  ts := AFrame.FrameName;
  printer.Canvas.Font.color := clBlack;
  y := printer.Canvas.TextHeight(ts) + FTop;
  printer.Canvas.Font.size := FS_SUPER; { default large text size frame code }
  x := (printer.PageWidth - printer.Canvas.TextWidth(ts) - FMargin);
  printer.Canvas.TextOut(x, y, ts)
end;


procedure TFramePrinter.PrintLogo;
// *Prints SCS Logo in page corner
var
  dx, dy: integer;
begin
  if printer.PageHeight < printer.PageWidth then
  begin
    dx := trunc(printer.PageWidth / 7);
    dy := trunc(printer.PageHeight / 10);
  end
  else
  begin
    dx := trunc(printer.PageHeight / 7);
    dy := trunc(printer.PageWidth / 10);
  end;
  printer.Canvas.StretchDraw(Rect(printer.PageWidth - dx, printer.PageHeight - dy, printer.PageWidth, printer.PageHeight), FLogo);
end;

procedure TFramePrinter.SetScale(AFrame: TSteelFrame);
var xrange, yrange: double;
    scalex,scaley: double;
begin
  with AFrame do
  begin
    xrange := abs(xmax - xmin);
    yrange := abs(YMax - YMin);
    cxorg := (xmax + xmin) / 2;
    cyorg := (YMax + YMin) / 2;
    scalex := (printer.PageWidth / xrange) * 0.8;

    if TwoPerPage then
      scaley := (printer.PageHeight / (yrange * 2)) * 0.8
    else
      scaley := (printer.PageHeight / yrange) * 0.8;

    pscale := min(Scalex,scaley);
  end;
  if TwoPerPage then
    FramePageH:= printer.PageHeight div 2
  else
    FramePageH:= printer.PageHeight;
end;

function TFramePrinter.TwoPerPage: boolean;
begin
  result := formsettings.MultiPrtCBox.Checked;
end;

procedure TFramePrinter.PrintTableData(AFrame: TSteelFrame);
var
  y, top: integer;
  R, x, Rows: integer;
  KeyValue: TKeyValue;
begin
  rows := round(ceil(TableData.Count/5));
  R:=0;
  x := FMargin +FTextSize.cx * 8;
  top :=  Client2Printer(0, TFrameHelper(AFrame).YMin).y + FLineSpacing;
  y := Top;
  for KeyValue in TableData do
  begin
    printText(x, y, KeyValue.Key,FS_TABLE);
    printText(x + FTextSize.cx * 8, y, KeyValue.Value,FS_TABLE);
    inc(R);
    inc(y, FLineSpacing); // next row
    if R >= Rows then
    begin
      R:=0;
      Y:=Top;          // next column
      inc (x, FTextSize.cx * 20);
    end;
  end;
end;

{ TFramePrinter.TKeyValue }
constructor TFramePrinter.TKeyValue.Create(const Akey, Avalue: string);
begin
  key:=AKey; Value:= AValue;
end;
constructor TFramePrinter.TKeyValue.Create(const Akey: string; const AValue: Double);
begin
  key:=AKey;
  Value:= UnitsOut(trim(inttostr(round(AValue))));
end;

end.












