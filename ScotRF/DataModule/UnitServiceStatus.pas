unit UnitServiceStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,ScotRFTypes,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList, UnitServiceManager, Vcl.Buttons;

type
  TFrameServiceStatus = class(TFrame)
    PanelServiceStatus: TPanel;
    LabelServiceName: TLabel;
    ImageStatusLight: TImage;
    StatusImages: TImageList;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    FServiceManager : TServiceManager;
    FServiceStatus  : TServiceState;
    FAfterStatusChange : TNotifyEvent;
    function getStatusLightBmp(const Value: TStatusLight): TBitMap;
    Procedure StatusChange(Sender: TObject);
  public
    { Public declarations }
    Property ServiceStatus     : TServiceState read FServiceStatus write FServiceStatus;
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;
  published
    property AfterStatusChange : TNotifyEvent  read FAfterStatusChange write FAfterStatusChange;
  end;

implementation

{$R *.dfm}

uses MainU;

function TFrameServiceStatus.getStatusLightBmp(const Value: TStatusLight): TBitMap;
begin
  Result := tBitmap.Create;
  StatusImages.GetBitmap(ord(Value), Result);
end;

Procedure TFrameServiceStatus.StatusChange(Sender: TObject);
begin
  FServiceStatus := FServiceManager.ServiceByName['ServiceScot'].State;
  Case FServiceStatus of
    ssStopped      : begin
                       ImageStatusLight.Picture.Bitmap := GetStatusLightBmp(tsRed);
                       FServiceManager.ServiceByName['ServiceScot'].ServiceStart(True);
                     end;
    ssStartPending : ImageStatusLight.Picture.Bitmap := GetStatusLightBmp(tsRed);
    ssStopPending  : ImageStatusLight.Picture.Bitmap := GetStatusLightBmp(tsRed);
    ssRunning      : begin
                       ImageStatusLight.Picture.Bitmap := GetStatusLightBmp(tsOk);
                     end;
    ssContinuePending:;
    ssPausePending:;
    ssPaused:;
  End;

  if Assigned(FAfterStatusChange) then
    FAfterStatusChange(nil);

end;

constructor TFrameServiceStatus.Create(AOwner: TComponent);
begin
  inherited;
  AfterStatusChange := MainU.TMainForm(AOwner).UpdateScreenButtons;
  FServiceManager := TServiceManager.Create;
  FServiceManager.Active := True;
  FServiceManager.ServiceByName['ServiceScot'].AfterStatusChange := StatusChange;
  StatusChange(nil);
end;

Destructor TFrameServiceStatus.Destroy;
begin
  FServiceManager.ServiceByName['ServiceScot'].ServiceStop(True);
  inherited;
end;

procedure TFrameServiceStatus.SpeedButton1Click(Sender: TObject);
begin
  FServiceManager.ServiceByName['ServiceScot'].ServiceStart(True);
end;

end.
