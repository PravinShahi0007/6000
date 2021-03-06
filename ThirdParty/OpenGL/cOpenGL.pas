unit cOpenGL;

interface
{$M+}
uses
  Windows,
  SysUtils,
  Classes,
  Controls,
  Forms,
  Dialogs,
  OpenGL;

type
  TPFDFlag = (
    DoubleBuffer,
    Stereo,
    Draw_To_Window,
    Draw_To_Bitmap,
    Support_GDI,
    Support_OpenGL,
    Generic_Format,
    Need_Palette,
    Need_System_Palette,
    Swap_Exchange,
    Swap_Copy,
    Swap_Layer_Buffers,
    Generic_Accelerated
  ); {TPFDFlag}
  TPFDFlags= set of TPFDFlag;
  TPFDPixelType=(
    RGBA,
    ColorIndex
  );
  TProjection=(
    Orthographic,
    Perspective
  );
  TEnable=(
   depthTest,
   cullFace,
   Lighting
  );
  TEnables=set of TEnable;

  TOpenGL=class(TComponent)
  private
    GLContext: HGLRC;
    FReady: boolean;
    FFlags: TPFDFlags;
    FPixelType: TPFDPixelType;
    FColorBits,
    FDepthBits,
    FStencilBits,
    oldWidth,
    oldHeight: integer;
    FProjection: TProjection;
    FEnable: TEnables;
    FClearRed,FClearGreen,FClearBlue: GLclampf;
    FLeft,FRight,FBottom,FTop,FNear,FFar: GLdouble;
    OldShutDown: TNotifyEvent;
    procedure ShutDown(Sender: TObject);
    procedure ExceptionGL(Sender:TObject;E:Exception);
  public
    glDC: HDC;
    constructor Create(AOwner:TComponent); override;
    procedure Loaded; override;
    procedure ErrorCheck(const s:string);
    procedure Swap;
    function Smaller: boolean;
    property Ready: boolean read FReady;
  published
    property pfdFlags: TPFDFlags read FFlags write FFlags;
    property PixelType: TPFDPixelType read FPixelType write FPixelType;
    property Projection: TProjection read FProjection write FProjection;
    property Enable: TEnables read FEnable write FEnable;
    property ClearRed: GLclampf read FClearRed write FClearRed;
    property ClearGreen: GLclampf read FClearGreen write FClearGreen;
    property ClearBlue: GLclampf read FClearBlue write FClearBlue;
    property prxLeft: GLdouble read FLeft write FLeft;
    property prxRight: GLdouble read FRight write FRight;
    property prxBottom: GLdouble read FBottom write FBottom;
    property prxTop: GLdouble read FTop write FTop;
    property prxNear: GLdouble read FNear write FNear;
    property prxFar: GLdouble read FFar write FFar;
    property ColorBits: integer read FColorBits write FColorBits;
    property DepthBits: integer read FDepthBits write FDepthBits;
    property StencilBits: integer read FStencilBits write FStencilBits;
  end; {TOpenGL}

procedure Register;

implementation

constructor TOpenGL.Create(AOwner:TComponent);
var
  frm: Tform;
begin
  inherited Create(AOwner); 
  FProjection := Perspective;
  FLeft := -1.0;
  FRight := 1.0;
  FBottom := -1.0;
  FTop := 1.0; 
  FNear := 2.0;
  FFar := 9.0;
  FColorBits := 24;
  FDepthBits := 32;
  FEnable := [depthTest,cullFace];
  FFlags := [DRAW_TO_WINDOW,SUPPORT_OPENGL];
  frm := TForm(AOwner);
  OldShutDown := frm.OnDestroy;
  frm.OnDestroy := ShutDown;
end;

procedure TOpenGL.Loaded;
var
  pfd: TPixelFormatDescriptor;
  FormatIndex: integer;
  pflags: TPFDFlags;
  flags: word absolute pFlags;
begin
  inherited Loaded;
  if (Owner<>nil) then
  with TWinControl(Owner) do
  begin
    pflags := pfdFlags;
    fillchar(pfd,SizeOf(pfd),0);
    with pfd do
    begin
      nSize        := SizeOf(pfd);
      nVersion     := 1;
      dwFlags      := flags;
      iPixelType   := byte(PixelType);
      cColorBits   := ColorBits;
      cDepthBits   := DepthBits;
      cStencilBits := StencilBits;
      iLayerType   := PFD_MAIN_PLANE;
    end; {with}
    glDC := getDC(handle);
    FormatIndex := ChoosePixelFormat(glDC,@pfd);
    if FormatIndex=0 then
      raise Exception.Create('ChoosePixelFormat failed '+
        IntToStr(GetLastError));

    if not SetPixelFormat(glDC,FormatIndex,@pfd) then
      raise Exception.Create('SetPixelFormat failed '+
        IntToStr(GetLastError));

    GLContext := wglCreateContext(glDC);
    if GLContext=0 then
      raise Exception.Create('wglCreateContext failed '+
        IntToStr(GetLastError));

    if not wglMakeCurrent(glDC,GLContext) then
      raise Exception.Create('wglMakeCurrent failed '+
        IntToStr(GetLastError));
    if depthTest in Enable then
      glEnable(GL_DEPTH_TEST);
    if cullFace in Enable then
      glEnable(GL_CULL_FACE);
    if Lighting in Enable then
      glEnable(GL_LIGHTING);

    glMatrixMode(GL_PROJECTION);
    if Projection=ORTHOGRAPHIC then
      glOrtho(prxLeft,prxRight,prxBottom,prxTop,prxNear,prxFar)
    else
      glFrustum(prxLeft,prxRight,prxBottom,prxTop,prxNear,prxFar);

    glClearColor(FClearRed,FClearGreen,FClearBlue,1.0);

    ErrorCheck('Loaded');

    FReady := true;

  end; {if}
  Application.OnException := ExceptionGL;
end;

procedure TOpenGL.ExceptionGL(Sender:TObject;E:Exception);
var
  errorCode: GLenum;
begin
  //ShowException(Sender,E);
  //This is better   BL
  if E.BaseException <> nil then
    Application.ShowException(E.BaseException)
  else
    Application.ShowException(E);

  repeat
    errorCode := glGetError;
    if errorCode<>GL_NO_ERROR then
      showMessage(gluErrorUnicodeStringEXT(errorCode));
  until errorCode=GL_NO_ERROR;
end;

function TOpenGL.Smaller:boolean;
begin
  result := (Owner<>nil) and Ready;
  if not result then
    exit;
  with TWinControl(Owner) do
  begin
    glViewPort(0,0,ClientWidth,ClientHeight);
    ErrorCheck('Smaller'); 
    result := (ClientWidth<=oldWidth) and (ClientHeight<=oldHeight);
    oldWidth := ClientWidth;
    oldHeight := ClientHeight;
  end;
end;

procedure TOpenGL.ErrorCheck(const s:string);
var
  errorCode: GLenum;
begin
  errorCode := glGetError;
  if errorCode<>GL_NO_ERROR then
    raise Exception.Create('Error in '+s+#13+
      gluErrorUnicodeStringEXT(errorCode));
end;

procedure TOpenGL.Swap;
begin
  SwapBuffers(glDC);
end;

procedure TOpenGL.ShutDown(Sender: TObject);
begin
  wglMakeCurrent(glDC,0);
  wglDeleteContext(GLContext);
  ReleaseDC(TWinControl(Owner).Handle,glDC);
  FReady := false;
  if Assigned(OldShutdown) then
    OldShutDown(Sender);
end;

procedure Register;
begin
  RegisterComponents('OpenGL',[TOpenGL]);
end;

end.

