unit Light;

interface

uses
  SysUtils,
  Classes,
  Material,
  OpenGL;

type
  TLight=class(TComponent)
  private
    FWhich: GLenum;
    FAmbient: TGLColor;
    FDiffuse: TGLColor;
    FSpecular: TGLColor;
    FCutoff: GLfloat;
    FSpotlight: boolean;
    FDirection: boolean;
    FPosition: boolean;
    FEnabled: boolean;
    LightPlace: TGLPosition;
    SpotDirect: TGLPlace;
    procedure SetAmbientRed(value: GLclampf);
    function GetAmbientRed: GLclampf;
    procedure SetAmbientGreen(value: GLclampf);
    function GetAmbientGreen: GLclampf;
    procedure SetAmbientBlue(value: GLclampf);
    function GetAmbientBlue: GLclampf;
    procedure SetDiffuseRed(value: GLclampf);
    function GetDiffuseRed: GLclampf;
    procedure SetDiffuseGreen(value: GLclampf);
    function GetDiffuseGreen: GLclampf;
    procedure SetDiffuseBlue(value: GLclampf);
    function GetDiffuseBlue: GLclampf;
    procedure SetSpecularRed(value: GLclampf);
    function GetSpecularRed: GLclampf;
    procedure SetSpecularGreen(value: GLclampf);
    function GetSpecularGreen: GLclampf;
    procedure SetSpecularBlue(value: GLclampf);
    function GetSpecularBlue: GLclampf;
    procedure SetWhich(value: byte); 
    function GetWhich: byte;
  public
    constructor Create(AOwner:TComponent); override;
    procedure Apply;
  published
    property Which: byte read GetWhich write SetWhich;
    property Cutoff: GLfloat read FCutoff write FCutoff;
    property AmbientRed: GLclampf read GetAmbientRed write SetAmbientRed;
    property AmbientGreen: GLclampf read GetAmbientGreen write SetAmbientGreen;
    property AmbientBlue: GLclampf read GetAmbientBlue write SetAmbientBlue;
    property DiffuseRed: GLclampf read GetDiffuseRed write SetDiffuseRed;
    property DiffuseGreen: GLclampf read GetDiffuseGreen write SetDiffuseGreen;
    property DiffuseBlue: GLclampf read GetDiffuseBlue write SetDiffuseBlue;
    property SpecularRed: GLclampf read GetSpecularRed write SetSpecularRed;
    property SpecularGreen: GLclampf read GetSpecularGreen write SetSpecularGreen;
    property SpecularBlue: GLclampf read GetSpecularBlue write SetSpecularBlue;
    property Direction: boolean read FDirection write FDirection;
    property Position: boolean read FPosition write FPosition;
    property Spotlight: boolean read FSpotlight write FSpotlight;
    property Enabled: boolean read FEnabled write FEnabled;
  end; {TLight}

procedure Register;

implementation

constructor TLight.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  LightPlace.w := 1.0;
  SpotDirect.z := -1.0;
end;

procedure TLight.SetAmbientRed(value: GLclampf);
begin
  FAmbient.Red := value;
end;

function TLight.GetAmbientRed: GLclampf;
begin
  result := FAmbient.red;
end;

procedure TLight.SetAmbientGreen(value: GLclampf);
begin
  FAmbient.Green := value;
end;

function TLight.GetAmbientGreen: GLclampf;
begin
  result := FAmbient.green;
end;

procedure TLight.SetAmbientBlue(value: GLclampf);
begin
  FAmbient.blue := value;
end;

function TLight.GetAmbientBlue: GLclampf;
begin
  result := FAmbient.blue;
end;

procedure TLight.SetDiffuseRed(value: GLclampf);
begin
  FDiffuse.red := value;
end;

function TLight.GetDiffuseRed: GLclampf;
begin
  result := FDiffuse.red;
end;

procedure TLight.SetDiffuseGreen(value: GLclampf);
begin
  FDiffuse.green := value;
end;

function TLight.GetDiffuseGreen: GLclampf;
begin
  result := FDiffuse.green;
end;

procedure TLight.SetDiffuseBlue(value: GLclampf);
begin
  FDiffuse.blue := value;
end;

function TLight.GetDiffuseBlue: GLclampf;
begin
  result := FDiffuse.blue;
end;

procedure TLight.SetSpecularRed(value: GLclampf);
begin
  FSpecular.red := value;
end;

function TLight.GetSpecularRed: GLclampf;
begin
  result := FSpecular.red;
end;

procedure TLight.SetSpecularGreen(value: GLclampf);
begin
  FSpecular.green := value;
end;

function TLight.GetSpecularGreen: GLclampf;
begin
  result := FSpecular.green;
end;

procedure TLight.SetSpecularBlue(value: GLclampf);
begin
  FSpecular.blue := value;
end;

function TLight.GetSpecularBlue: GLclampf;
begin
  result := FSpecular.blue;
end;

function TLight.GetWhich: byte;
begin
  case FWhich of
    GL_LIGHT1: result := 1;
    GL_LIGHT2: result := 2;
    GL_LIGHT3: result := 3;
    GL_LIGHT4: result := 4;
    GL_LIGHT5: result := 5;
    GL_LIGHT6: result := 6;
    GL_LIGHT7: result := 7;
    else       result := 0;
  end; {case}
end;

procedure TLight.SetWhich(value: byte);
begin
  case value of
    1: FWhich := GL_LIGHT1;
    2: FWhich := GL_LIGHT2;
    3: FWhich := GL_LIGHT3;
    4: FWhich := GL_LIGHT4;
    5: FWhich := GL_LIGHT5;
    6: FWhich := GL_LIGHT6;
    7: FWhich := GL_LIGHT7;
    else FWhich := GL_LIGHT0;
  end; {case}
end;

procedure TLight.Apply;
begin
  if FEnabled then
    glEnable(FWhich)
  else begin
    glDisable(FWhich);
    exit;
  end;
  if FPosition then
    glLightfv(FWhich,GL_POSITION,@LightPlace);
  if FDirection then
    glLightfv(FWhich,GL_SPOT_DIRECTION,@SpotDirect);
  if FSpotlight then
    glLightf(FWhich,GL_SPOT_CUTOFF,FCutoff);
  glLightfv(FWhich,GL_AMBIENT,@FAmbient);
  glLightfv(FWhich,GL_DIFFUSE,@FDiffuse);
  glLightfv(FWhich,GL_SPECULAR,@FSpecular);
end;

procedure Register;
begin
  RegisterComponents('OpenGL',[TLight]);
end;

end.
 