unit Transfrm;

interface

uses
  Classes,
  OpenGL;

type
  TTransform=class(TComponent)
  private
    FTranX,
    FTranY,
    FTranZ,
    FAxisX,
    FAxisY,
    FAxisZ,
    FAngle,
    FScaleX,
    FScaleY,
    FScaleZ: GLfloat;
    FOnPaint: TNotifyEvent;
  protected
    procedure Paint; virtual;
  public
    constructor Create(AOwner:TComponent); override;
    procedure Apply;
  published
    property TranX: GLfloat read FTranX write FTranX;
    property TranY: GLfloat read FTranY write FTranY;
    property TranZ: GLfloat read FTranZ write FTranZ;
    property AxisX: GLfloat read FAxisX write FAxisX;
    property AxisY: GLfloat read FAxisY write FAxisY;
    property AxisZ: GLfloat read FAxisZ write FAxisZ;
    property Angle: GLfloat read FAngle write FAngle;
    property ScaleX: GLfloat read FScaleX write FScaleX;
    property ScaleY: GLfloat read FScaleY write FScaleY;
    property ScaleZ: GLfloat read FScaleZ write FScaleZ;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end; {TTransform}

procedure Register;

implementation

constructor TTransform.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FScaleX := 1.0;
  FScaleY := 1.0;
  FScaleZ := 1.0;
end;

procedure TTransform.Apply;
begin
  glMatrixMode(GL_MODELVIEW);
  glPushMatrix;
  glTranslatef(TranX,TranY,TranZ);
  glRotatef(FAngle,FAxisX,FAxisY,FAxisZ);
  glScalef(FScaleX,FScaleY,FScaleZ);
  Paint; 
  glPopMatrix;
end;

procedure TTransform.Paint;
begin
  if Assigned(FOnPaint) then
    FOnPaint(Self);
end;

procedure Register;
begin
  RegisterComponents('OpenGL',[TTransform]);
end;

end.
