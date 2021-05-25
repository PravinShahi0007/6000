unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.AppEvnts, Vcl.ExtCtrls,
  UnitServiceStatus, Vcl.StdCtrls, UnitServiceManager;

type
  TFormAdministrator = class(TForm)
    AdminEvents: TApplicationEvents;
    AdminTrayIcon: TTrayIcon;
    PanelButtons: TPanel;
    ButtonRefreshStatus: TButton;
    procedure AdminEventsMinimize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AdminTrayIconDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonRefreshStatusClick(Sender: TObject);
  private
    { Private declarations }
    FServiceManager       : TServiceManager;
    FIsScotServiceRunning : TServiceState;

    FScotStatus     : TFrameServiceStatus;
    FFirebirdStatus : TFrameServiceStatus;
  public
    { Public declarations }
  end;

var
  FormAdministrator: TFormAdministrator;

implementation

{$R *.dfm}

uses UnitFirebirdStatus, UnitScotServerStatus;

procedure TFormAdministrator.AdminEventsMinimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  AdminTrayIcon.Visible := True;
  AdminTrayIcon.Animate := True;
  AdminTrayIcon.ShowBalloonHint;
end;

procedure TFormAdministrator.AdminTrayIconDblClick(Sender: TObject);
begin
  AdminTrayIcon.Visible := False;
  Show();
  FFirebirdStatus.ServiceStatus;
  FScotStatus.ServiceStatus;
  WindowState := wsNormal;
  Application.BringToFront();
end;

procedure TFormAdministrator.ButtonRefreshStatusClick(Sender: TObject);
begin
  FFirebirdStatus.ServiceStatus;
  FScotStatus.ServiceStatus;
end;

procedure TFormAdministrator.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  CanClose := False;
  if MessageDlg('Are you sure ?', mtConfirmation, mbYesNo, 0) = mrYes then
    CanClose := True;
end;

procedure TFormAdministrator.FormCreate(Sender: TObject);
begin
  FServiceManager          := TServiceManager.Create;
  FServiceManager.Active   := True;
  FScotStatus     := TFrameScotServerStatus.Create(Self,'ServiceScot', FServiceManager);
  FFirebirdStatus := TFrameFirebirdStatus.Create(Self,'FirebirdServerDefaultInstance', FServiceManager);
  AdminTrayIcon.BalloonTitle := 'Restoring the window.';
  AdminTrayIcon.BalloonHint  := 'Double click the system tray icon to restore the window.';
  AdminTrayIcon.BalloonFlags := bfInfo;
end;

end.
