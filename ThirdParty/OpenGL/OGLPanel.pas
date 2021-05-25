unit OGLPanel;

interface

{ original author shadow_tj }
uses
  SysUtils, Classes, Controls, ExtCtrls, OpenGl, Windows,
  Messages, Variants, Graphics, Forms,  Dialogs;

type
  TEnable=(   depthTest,   cullFace,   Lighting  );
  TEnables=set of TEnable;
  TOpenGlBasePanel = Class ( TPanel )
  private
    FGlDraw : TNotifyEvent;
    fFullScreen : TNotifyEvent;
    FEnable: TEnables;
    rc : HGLRC;
    FDC  : HDC;
  protected
    procedure Resize; override;
    procedure Idle(Sender: TObject; var Done: Boolean);
    Procedure glInit; virtual;
    procedure setBGColor(AColour: TColor);
  public
    property  glDC  : HDC read FDC;
    procedure Paint; override;
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
  published
    property Enable: TEnables read FEnable write FEnable;
    Property onGLDraw : TNotifyEvent read FGlDraw write FGlDraw;
    Property FullScreen : TNotifyEvent Read fFullScreen Write fFullScreen;
    Property Onkeydown;
  end;


  TOpenGlPanel = class(TOpenGlBasePanel)
  private
    fWireFrame : Boolean;
  public
    Procedure glInit; Override;
    procedure Paint; override;
    constructor Create(AOwner: TComponent); override;
  published
    Property WireFrame : Boolean Read fWireFrame Write fWireFrame;
  end;

  // for code compatibility with deprecated cOpenGL.TOpenGL
  TOpenGLProjectionValues=class(TComponent)
  private
    FLeft,FRight,FBottom,FTop,FNear,FFar: GLdouble;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property prxLeft: GLdouble read FLeft write FLeft;
    property prxRight: GLdouble read FRight write FRight;
    property prxBottom: GLdouble read FBottom write FBottom;
    property prxTop: GLdouble read FTop write FTop;
    property prxNear: GLdouble read FNear write FNear;
    property prxFar: GLdouble read FFar write FFar;
  end;

procedure Register;

implementation

//------------------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('OpenGL', [TOpenGlPanel,TOpenGLProjectionValues]);
end;

procedure RGBFromColor(AColor: TColor; var r,g,b: Byte);
begin
  if AColor < 0 then
    AColor := ColorToRGB(AColor);
  r:=GetRValue(AColor); g:=GetGValue(AColor); b:=GetBValue(AColor);
end;

procedure TOpenGlBasePanel.setBGColor(AColour: TColor);
var
  r,g,b: Byte;
begin
  RGBFromColor(AColour, r,g,b);
  glClearColor(r/255,g/255,b/255,1.0);
end;

procedure TOpenGlBasePanel.glInit();
var pfd : TPIXELFORMATDESCRIPTOR;
    pf  : Integer;
begin
  FDC:=GetDC( Self.Handle );
  pfd.nSize:=sizeof(pfd);
  pfd.nVersion:=1;
  pfd.dwFlags:=PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER or 0;
  pfd.iPixelType:=PFD_TYPE_RGBA;
  pfd.cColorBits:=32;
  pf :=ChoosePixelFormat(FDC, @pfd);
  SetPixelFormat(FDC, pf, @pfd);
  rc :=wglCreateContext(FDC);
  wglMakeCurrent(FDC,rc);

//  glClearColor(0.0, 0.0, 0.0, 0.0);
  glShadeModel(GL_SMOOTH);
  glClearDepth(1.0);
  glDepthFunc(GL_LESS);
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);

  setBGColor(self.Color);                  // set ogl background color from panel colour
  glShadeModel(GL_SMOOTH);                 // Enables Smooth Color Shading
  glClearDepth(1.0);                       // Depth Buffer Setup
  if depthTest in Enable then
    glEnable(GL_DEPTH_TEST);
  if cullFace in Enable then
    glEnable(GL_CULL_FACE);
  if Lighting in Enable then
    glEnable(GL_LIGHTING);
  glDepthFunc(GL_LESS);		           // The Type Of Depth Test To Do
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);   //Realy Nice perspective calculations
  glBlendFunc(GL_SRC_ALPHA, GL_ONE);
  glEnable(GL_TEXTURE_2D);

  Resize;

  Application.OnIdle := Idle;
end;

//------------------------------------------------------------------------------

constructor TOpenGlBasePanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BevelOuter := bvNone;
  BevelInner := bvNone;
end;

//------------------------------------------------------------------------------

destructor TOpenGlBasePanel.Destroy;
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(rc);
  inherited;
end;

//------------------------------------------------------------------------------

procedure TOpenGlBasePanel.Idle(Sender: TObject; var Done: Boolean);
begin
  Done := FALSE;
  if not assigned(FGlDraw) then
  begin
     Application.OnIdle:=nil;
     raise exception.Create('TOpenGlBasePanel - GlDraw() is nil' );
  end;

  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT or GL_STENCIL_BUFFER_BIT);
  FglDraw(Self);
  SwapBuffers(FDC);  //For Windows
//     if (Sender <> mnuPrint3DView) then
//      SwapBuffers(OpenGL1.glDC)
//    else
//      glFlush;

end;

//------------------------------------------------------------------------------

procedure TOpenGlBasePanel.Resize;
begin
  inherited;
  if not assigned(OnResize) then
  begin
    glViewport(0, 0, Self.Width, Self.Height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluPerspective(45.0, Self.Width/Self.Height, 1.0, 500.0);
    glMatrixMode(GL_MODELVIEW);
  end;
end;

//------------------------------------------------------------------------------

procedure TOpenGlBasePanel.Paint;
begin
  inherited;
  if csDesigning in ComponentState then
	with inherited Canvas do
	begin
	  Pen.Style := psDash;
	  Brush.Style := bsClear;
	  Rectangle(0, 0, Width, Height);
	end;
end;

//------------------------------------------------------------------------------

procedure TOpenGlPanel.Paint;
begin
  inherited;
  // Wire Frame Mode
  if Wireframe = TRUE then
    glPolygonmode(GL_FRONT_AND_BACK, GL_LINE)
  else
    glPolygonmode(GL_FRONT, GL_FILL);
end;
    
//------------------------------------------------------------------------------

procedure TOpenGlPanel.glInit;
begin
  inherited;
end;
        
//------------------------------------------------------------------------------

constructor TOpenGlPanel.Create(AOwner: TComponent);
begin
  inherited;
  Cursor := crNone;
end;

//------------------------------------------------------------------------------

{ TOpenGLProjectionValues }

constructor TOpenGLProjectionValues.Create(AOwner: TComponent);
begin
  inherited;

end;

end.
