unit OGLTextU;

{
OpenGL font routines
}

interface

uses
  Windows,
  //Messages,
  SysUtils,
  //Classes,
  Graphics,
  Controls, 
  Forms,
  Dialogs,
  GlobalU,
  OpenGL;

  procedure Create2DFont;
  procedure Write2DFont(sText: AnsiString; r,g,b: Byte; x,y,z: Double); overload;
  procedure Write2DFont(sText: string; r,g,b: Byte; x,y,z: Double); overload;
  function TextRectAtPoint(s: string; p: Point2D): RectType;
  procedure CADArrowWithText(Pt1, Pt2: Point2D; sText: string; AColor: TColor);
  procedure ShowFontSettingsForm;

var
  FontFace: string='Arial';
  FontHeight: Integer=-11;
  FontWeight: Integer=400;
  FontItalic: Boolean=False;

implementation

uses FontSettingsU, UtilsU;

type
  TGLFontInfo = record
                  Height: Integer;
                  Width: array[0..255] of Integer;
                end;
var
  nFontList: Cardinal;
  GLFontInfo: TGLFontInfo;

//* Save the width and height of the current OpenGL font
procedure LoadGLFontInfo;
var
  i: Byte;
  ABitmap: TBitmap;
  sFace: string;
  H, Wt: Integer;
  bItalic: Boolean;
begin
  sFace := FontFace;
  H := FontHeight;
  Wt:= FontWeight;
  bItalic := FontItalic;
  ABitmap := TBitmap.Create;
  try
    with ABitmap.Canvas do
    begin
      Font.Name := sFace;
      Font.Height := H;
      if bItalic then
        Font.Style := [fsItalic];
      if Wt > 500 then
        Font.Style := Font.Style + [fsBold];
      for i:=0 to 255 do
        GLFontInfo.Width[i] := TextWidth( chr(i) );
      GLFontInfo.Height := TextHeight( 'X' );
    end;
  finally
    ABitmap.Free;
  end;
end;

//* Find the width and height of the text
procedure WallTextExtent(Text: AnsiString; var ATextWidth, ATextHeight: Double);
var
  i: Integer;
begin
  ATextWidth := 0;
  for i:=1 to Length(Text)do
    ATextWidth := ATextWidth + GLFontInfo.Width[ ord(Text[i]) ];
  ATextWidth := ATextWidth * Scale;
  ATextHeight:= GLFontInfo.Height * Scale;
end;

//* Initialize the OpenGL font
procedure Create2DFont;
const
  NUM_CHARS=256;   //was 187, 186 is the degree symbolº
var
  FontHandle: HFONT;
  h_HDC: HDC;
begin
  //glPixelStorei(GL_UNPACK_ALIGNMENT,1);  //byte alignment, only needs to be called once
  if nFontList > 0 then
    glDeleteLists(nFontList, NUM_CHARS);
  nFontList := glGenLists(NUM_CHARS);    
  glListBase(nFontList);

  FontHandle := CreateFont(FontHeight,0,0,0,FontWeight,Byte(FontItalic),0,0,
             ANSI_CHARSET, OUT_TT_PRECIS, CLIP_DEFAULT_PRECIS,
             {PROOF_QUALITY} ANTIALIASED_QUALITY , DEFAULT_PITCH, PChar(FontFace));
  h_HDC := wglGetCurrentDC;
  SelectObject(h_HDC, FontHandle);
  if not wglUseFontBitmaps(h_HDC,0,NUM_CHARS,nFontList)then
    wglUseFontBitmaps(h_HDC,0,NUM_CHARS,nFontList);         //try again

  DeleteObject( FontHandle );
  LoadGLFontInfo;
end;

//* Display the sText in OpenGL
procedure Write2DFont(sText: AnsiString; r,g,b: Byte; x,y,z: Double);
var
  TextGap, th, tw: Double;
begin
  WallTextExtent( sText, TextGap, th );
  tw := TextGap;

  SetOGLColorBytes(r,g,b);
  glRasterPos2f((x-9*tw)/Scale, (y-5*th)/Scale); //Magic Nos
  //glPushMatrix;
  glPushAttrib(GL_LIST_BASE);
    glListBase(nFontList);
    glCallLists(Length(sText), GL_UNSIGNED_BYTE, PAnsiChar(sText));
  //glPopMatrix;
  glPopAttrib;
end;

procedure Write2DFont(sText: string; r,g,b: Byte; x,y,z: Double);
begin
  Write2DFont(RawByteString(sText), r,g,b, x,y,z);
end;

//* Converts a colour to its RGB values
// Named with "From" because Graphics.pas
//  already has a function called ColorToRGB
//  which strips the high order bits
procedure RGBFromColor(AColor: TColor; var r,g,b: Byte);
begin
  if AColor < 0 then
    AColor := ColorToRGB(AColor);
  r:=GetRValue(AColor); g:=GetGValue(AColor); b:=GetBValue(AColor);
end;

//* Perpendicular offsets from the endpoints of a line
//* and returns the angle in radians
function GetOffSets(Pt1, Pt2: Point2D; Amount: Double; var XOff, YOff: Double): Extended;
var
  Dirn: Extended;
begin
  Dirn := LineDirectionRadians(Pt1, Pt2);
  XOff := -Amount * Sin( Dirn ) / 2;
  YOff :=  Amount * Cos( Dirn ) / 2;
  Result := Dirn;
end;

//* Display an arrow from one point to another, at z=0
procedure CADHalfArrow(FromPt, ToPt: Point2D; r,g,b: Byte);
var
  XOff, YOff, ArrowHeadLen: Double;
  ArrowAngle, Dirn: Extended;
  Pt1: Point2D;
begin
  ArrowAngle := pi/6; //30 deg
  ArrowHeadLen := Scale * 300;

  //ambient[0]:=r/255; ambient[1]:=g/255; ambient[2]:=b/255; ambient[3]:=1.0;
  //glMaterialfv(GL_FRONT,GL_AMBIENT,@ambient);
  glLineWidth( 1 );
  SetOGLColorBytes(r,g,b);
  glBegin(GL_LINES);
    glVertex4d(FromPt.x, FromPt.y, 0, Scale);
    glVertex4d(ToPt.x, ToPt.y, 0, Scale);

    Dirn := GetOffSets(FromPt, ToPt, Scale*300, XOff, YOff);
    //Calc ArrowHead vertices
    Pt1.x := ToPt.x - Cos( Dirn - ArrowAngle ) * ArrowHeadLen;
    Pt1.y := ToPt.y - Sin( Dirn - ArrowAngle ) * ArrowHeadLen;

    //Draw ArrowHead
    glVertex4d(ToPt.x, ToPt.y, 0, Scale);
    glVertex4d(Pt1.x, Pt1.y, 0, Scale);

    //Draw Perpendicular lines marking the end
    glVertex4d(ToPt.x-XOff, ToPt.y-YOff, 0, Scale);
    glVertex4d(ToPt.x, ToPt.y, 0, Scale);
    glVertex4d(ToPt.x+XOff, ToPt.y+YOff, 0, Scale);
    glVertex4d(ToPt.x, ToPt.y, 0, Scale);
  glEnd;
end;

function TextRectAtPoint(s: string; p: Point2D): RectType;
var
  th, TextGap, dX,dY: Double;
begin
  WallTextExtent( RawByteString(s), TextGap, th );
  dX := TextGap * 10;  //25 / 2;     //magic no.
  dY := th * 10;  //25 / 2;          //magic no.

  Result.Pt[1].x := p.x - dX;  Result.Pt[1].y := p.y - dY;
  Result.Pt[2].x := p.x - dX;  Result.Pt[2].y := p.y + dY;
  Result.Pt[3].x := p.x + dX;  Result.Pt[3].y := p.y + dY;
  Result.Pt[4].x := p.x + dX;  Result.Pt[4].y := p.y - dY;
end;

//* Display a string in the centre of Pt1 and Pt2 with arrows from the text to each point
//* 2-D routine, i.e. it's at z=0
procedure CADArrowWithText(Pt1, Pt2: Point2D; sText: string; AColor: TColor);
var
  Dirn: Extended;
  TextPos, mid1, mid2: Point2D;
  r,g,b: Byte;
  th, TextGap, L: Double;
begin
  Dirn := LineDirectionRadians( Pt1, Pt2 );
  TextPos := MidPoint2D( Pt1, Pt2 );

  WallTextExtent( RawByteString(sText), TextGap, th );
  TextGap := TextGap * 25;   //magic no.
  th := th * 25;             //magic

  L := Sqrt(Sqr(TextGap * Cos(Dirn)) + Sqr(th * Sin(Dirn))) / 2;
  mid1.x := TextPos.x - L * Cos( Dirn );
  mid1.y := TextPos.y - L * Sin( Dirn );
  mid2.x := TextPos.x + L * Cos( Dirn );
  mid2.y := TextPos.y + L * Sin( Dirn );

  RGBFromColor(AColor, r,g,b);
  CADHalfArrow(mid1, Pt1, r,g,b);
  CADHalfArrow(mid2, Pt2, r,g,b);
  Write2DFont(sText, r,g,b, TextPos.x, TextPos.y, 0);
  //CADPoint(TextPos, 10, clRed);  //Debug
end;

//* Show a font selection form to allow the user to set the OpenGL font
procedure ShowFontSettingsForm;
begin
  with TfrmFontSettings.Create(Application)do
  begin
    try
      cboFace.ItemIndex := cboFace.Items.IndexOf( FontFace );
      chkBold.Checked := FontWeight > 500;
      chkItalic.Checked := FontItalic;
      cboSize.Text := IntToStr(-MulDiv(FontHeight, 72, Font.PixelsPerInch));
      cboFaceClick(nil);
      if ShowModal = mrOK then
      begin
        FontFace := pnlSample.Font.Name; //cboFace.Text;
        FontItalic := chkItalic.Checked;
        FontWeight := 400;
        if chkBold.Checked then
          FontWeight := 700;
        FontHeight := pnlSample.Font.Height;
        Create2DFont;
      end;
    finally
      Free;
    end;
  end;
end;

initialization
  glPixelStorei(GL_UNPACK_ALIGNMENT,1);

END.
