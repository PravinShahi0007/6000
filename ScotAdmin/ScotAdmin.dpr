program ScotAdmin;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {FormAdministrator},
  Vcl.Themes,
  Vcl.Styles,
  UnitServiceStatus in 'Module\UnitServiceStatus.pas' {FrameServiceStatus: TFrame},
  UnitServiceManager in 'Module\UnitServiceManager.pas',
  PBThreadedSplashscreenU in '..\Common\PBThreadedSplashscreenU.pas',
  SplashScreenU in '..\Common\SplashScreenU.pas' {FormSplash},
  Com_Exception in '..\Common\Com_Exception.pas',
  com_sync in '..\Common\com_sync.pas',
  Com_Streams in '..\Common\Com_Streams.pas',
  Com_OSUtil in '..\Common\Com_OSUtil.pas',
  UnitFirebirdStatus in 'Module\UnitFirebirdStatus.pas' {FrameFirebirdStatus: TFrame},
  UnitScotServerStatus in 'Module\UnitScotServerStatus.pas' {FrameScotServerStatus: TFrame},
  UnitDSServerDB in '..\Common\UnitDSServerDB.pas',
  UnitDBXMetadataHelper in '..\Common\UnitDBXMetadataHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormAdministrator, FormAdministrator);
  Application.Run;
end.
