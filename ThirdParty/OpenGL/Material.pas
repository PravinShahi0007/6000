unit Material;

interface

uses
  SysUtils,
  Classes,
  OpenGL;

type
  TGLColor=packed record
    red,green,blue,alpha: GLclampf;
  end;
  TGLPlace=packed record
    x,y,z: glFloat;
  end;
  TGLPosition=packed record
    x,y,z,w: glFloat;
  end;

  TFace=(faFront,faBack,faFrontAndBack);
  TMaterial=class(TComponent)
  private
    FsFace,
    FdFace,
    FmFace: TFace;
    FAmbColor,
    FDifColor: TGLColor;
    FShine: GLclampf;
    procedure SetRed(value:GLclampf);
    function GetRed:GLclampf;
    procedure SetGreen(value:GLclampf);
    function GetGreen:GLclampf;
    procedure SetBlue(value:GLclampf);
    function GetBlue:GLclampf;
    procedure SetAlpha(value:GLclampf);
    function GetAlpha:GLclampf;
    procedure SetAmbRed(value:GLclampf);
    function GetAmbRed:GLclampf;
    procedure SetAmbGreen(value:GLclampf);
    function GetAmbGreen:GLclampf;
    procedure SetAmbBlue(value:GLclampf);
    function GetAmbBlue:GLclampf;
    procedure SetAmbAlpha(value:GLclampf);
    function GetAmbAlpha:GLclampf;
  public
    procedure Apply;
  published
    property ambRed: GLclampf read GetAmbRed write SetAmbRed;
    property ambGreen: GLclampf read GetAmbGreen write SetAmbGreen;
    property ambBlue: GLclampf read GetAmbBlue write SetAmbBlue;
    property ambAlpha: GLclampf read GetAmbAlpha write SetAmbAlpha;
    property difRed: GLclampf read GetRed write SetRed;
    property difGreen: GLclampf read GetGreen write SetGreen;
    property difBlue: GLclampf read GetBlue write SetBlue;
    property difAlpha: GLclampf read GetAlpha write SetAlpha;
    property aFace: TFace read FmFace write FmFace;
    property dFace: TFace read FdFace write FdFace;
    property sFace: TFace read FsFace write FsFace;
    property mShine: GLclampf read FShine write FShine;
  end; {TMaterial}

var
  black,
  white: TGLColor;

procedure Register;

implementation

procedure TMaterial.SetRed(value:GLclampf);
begin
  FDifColor.red := value;
end;

function TMaterial.GetRed:GLclampf;
begin
  result := FDifColor.red;
end;

procedure TMaterial.SetGreen(value:GLclampf);
begin
  FDifColor.green := value;
end;

function TMaterial.GetGreen:GLclampf;
begin
  result := FDifColor.green;
end;

procedure TMaterial.SetBlue(value:GLclampf);
begin
  FDifColor.blue := value;
end;

function TMaterial.GetBlue:GLclampf;
begin
  result := FDifColor.blue;
end;

procedure TMaterial.SetAlpha(value:GLclampf);
begin
  FDifColor.alpha := value;
end;

function TMaterial.GetAlpha:GLclampf;
begin
  result := FDifColor.alpha;
end;

procedure TMaterial.SetAmbRed(value:GLclampf);
begin
  FAmbColor.red := value;
end;

function TMaterial.GetAmbRed:GLclampf;
begin
  result := FAmbColor.red;
end;

procedure TMaterial.SetAmbGreen(value:GLclampf);
begin
  FAmbColor.green := value;
end;

function TMaterial.GetAmbGreen:GLclampf;
begin
  result := FAmbColor.green;
end;

procedure TMaterial.SetAmbBlue(value:GLclampf);
begin
  FAmbColor.blue := value;
end;

function TMaterial.GetAmbBlue:GLclampf;
begin
  result := FAmbColor.blue;
end;

procedure TMaterial.SetAmbAlpha(value:GLclampf);
begin
  FAmbColor.alpha := value;
end;

function TMaterial.GetAmbAlpha:GLclampf;
begin
  result := FAmbColor.alpha;
end;

procedure TMaterial.Apply;
var
  aface: GLenum;
  spec: pointer;
begin
  aface := GL_FRONT;  //Stopt the compiler complaining, BL
  case FmFace of
    faFront: aface:= GL_FRONT;
    faBack: aface:= GL_BACK;
    faFrontAndBack: aface:= GL_FRONT_AND_BACK;
  end; {case}
  glMaterialfv(aface,GL_AMBIENT,@FAmbColor);

  case FdFace of
    faFront: aface:= GL_FRONT;
    faBack: aface:= GL_BACK;
    faFrontAndBack: aface:= GL_FRONT_AND_BACK;
  end; {case}
  glMaterialfv(aface,GL_DIFFUSE,@FDifColor); 

  case FsFace of
    faFront: aface:= GL_FRONT;
    faBack: aface:= GL_BACK;
    faFrontAndBack: aface:= GL_FRONT_AND_BACK;
  end; {case}
  if FShine=0 then
    spec := @black
  else
    spec := @white;  
  glMaterialfv(aface,GL_SPECULAR,spec);
  glMaterialf(aface,GL_SHININESS,FShine);
end;

procedure Register;
begin
  RegisterComponents('OpenGL',[TMaterial]);
end;

initialization
  with white do
  begin
    red := 1.0;
    green := 1.0;
    blue := 1.0;
    alpha := 1.0;
  end; {with}
  fillchar(black,sizeOf(black),0);
  black.alpha := 1.0;
end.
