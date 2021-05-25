program ScotDashboard;

{$R *.dres}

uses
  Forms,
  UnitScotDashBoard in 'UnitScotDashBoard.pas' {FormScotDashBoard},
  UnitChildWin in 'UnitChildWin.pas' {MDIChild},
  UnitAbout in 'UnitAbout.pas' {FormAboutBox},
  UnitChildRFStatus in 'UnitChildRFStatus.pas' {MDIChildRFStatus},
  UnitChildJobStatus in 'UnitChildJobStatus.pas' {MDIChildJobStatus},
  UnitDMLoadEP2Files in '..\ClientCommon\DataModule\UnitDMLoadEP2Files.pas' {DMLoadEP2Files: TDataModule},
  UnitDMDesignJob in '..\ClientCommon\DataModule\UnitDMDesignJob.pas' {DMDesignJob: TDataModule},
  GlobalU in '..\ScotSim\GlobalU.pas',
  UnitRFLiveStatus in 'UnitRFLiveStatus.pas' {MDIChildRFLiveStatus},
  ScotRFTypes in '..\ScotRF\ScotRFTypes.pas',
  UnitStopServiceForm in '..\Common\UnitStopServiceForm.pas' {StopServiceForm},
  UnitDataSnapClientClass in '..\ClientCommon\UnitDataSnapClientClass.pas',
  UnitDMRFStatus in 'DataModule\UnitDMRFStatus.pas' {DMRFStatus: TDataModule},
  UnitLiveRollFormer in 'UnitLiveRollFormer.pas' {FrameLiveRollFormer: TFrame},
  UnitDMRollFormer in '..\ScotRF\DataModule\UnitDMRollFormer.pas' {DMRollFormer: TDataModule},
  UnitSettings in 'UnitSettings.pas' {MDIChildSettings},
  PBThreadedSplashscreenU in '..\Common\PBThreadedSplashscreenU.pas',
  SplashScreenU in '..\Common\SplashScreenU.pas' {FormSplash},
  UnitChildRFHistory in 'UnitChildRFHistory.pas' {MDIChildRFHistory},
  UnitJobTransferForm in '..\ClientCommon\UnitJobTransferForm.pas' {FormJobTransfer},
  UnitDMJobTransfer in '..\ClientCommon\DataModule\UnitDMJobTransfer.pas' {DMJobTransfer: TDataModule},
  UnitLocalDBClass in '..\ClientCommon\UnitLocalDBClass.pas' {DMLocalDB: TDataModule},
  UnitRemoteDBClass in '..\ClientCommon\UnitRemoteDBClass.pas' {DMRemoteDB: TDataModule},
  UnitJobFoundForm in '..\ClientCommon\UnitJobFoundForm.pas' {FormJobFound},
  UnitChildJobStatusLive in 'UnitChildJobStatusLive.pas' {MDIChildCurrentJobProcessing};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormScotDashBoard, FormScotDashBoard);
  Application.Run;
end.
