program ScotRF;



{$R *.dres}

uses
  SysUtils,
  Forms,
  Dialogs,
  Classes,
  TypInfo,
  coil in 'coil.pas' {Coilform},
  calibrate in 'calibrate.pas' {CalibrateForm},
  pause in 'pause.pas' {pauseform},
  items in 'items.pas' {Itemform},
  itemhelp in 'itemhelp.pas' {Itemhelpform},
  itemwizard in 'itemwizard.pas' {Itemwizardform},
  units in 'units.pas',
  mintsettings in 'mintsettings.pas' {mintform},
  Mintstatus in 'Mintstatus.pas' {FormMintStatus},
  BoM in 'BoM.pas' {FormBoM},
  UpdateFormU in 'UpdateFormU.pas' {frmUpdate},
  VersionU in 'VersionU.pas',
  Panelmanual in 'Panelmanual.pas' {PanelManualForm},
  PanelWizard in 'PanelWizard.pas' {PanelWizardForm},
  spdUnit in 'spdUnit.pas' {SpeedForm},
  mint in 'mint.pas',
  PauseRequest in 'PauseRequest.pas' {PauseRequestForm},
  ItemTypeSelectionU in 'ItemTypeSelectionU.pas' {TypeSelectform},
  Download in 'Download.pas',
  UpdateUtilsU in 'UpdateUtilsU.pas',
  Logging in 'Logging.pas',
  WinUtils in 'WinUtils.pas',
  ijpStatusU in 'ijpStatusU.pas' {InkjetStatus: TFrame},
  ScotRFTypes in 'ScotRFTypes.pas',
  IJPBaseU in 'IJPBaseU.pas' {InkJetB: TDataModule},
  IJPSojetU in 'IJPSojetU.pas' {Sojet: TDataModule},
  IJPOtherU in 'IJPOtherU.pas' {IJPOther: TDataModule},
  MainU in 'MainU.pas' {MainForm},
  FramePrintU in 'FramePrintU.pas',
  UnitScotTruss in 'UnitScotTruss.pas' {FormScotTruss},
  FrameDataU in 'FrameDataU.pas',
  TranslateU in 'TranslateU.pas',
  LoadSteelU in 'LoadSteelU.pas',
  FrameDrawU in 'FrameDrawU.pas',
  ManufactureU in 'ManufactureU.pas',
  TrussManual in 'TrussManual.pas' {TrussManualForm},
  PreviewU in 'PreviewU.pas' {PreviewForm},
  WinSCard in '..\CardManagement\CardMaster\WinSCard.pas',
  CardAPIU in '..\CardManagement\CardMaster\CardAPIU.pas' {CardApi: TDataModule},
  PasswordU in '..\CardManagement\CardMaster\PasswordU.pas' {pwdForm},
  RollformerU in 'RollformerU.pas' {Rollformer: TDataModule},
  CountFrameU in 'CountFrameU.pas' {CounterFrame: TFrame},
  CardAdapterU in '..\CardManagement\CardMaster\CardAdapterU.pas',
  CardU in '..\CardManagement\CardMaster\CardU.pas',
  BillboardU in 'BillboardU.pas' {Billboard: TFrame},
  VirtualMachineU in 'VirtualMachineU.pas' {VMForm},
  LengthForm in 'LengthForm.pas' {frmManualLength},
  IJPMasterU in 'IJPMasterU.pas',
  ErrorsFormU in '..\ScotSim\ErrorsFormU.pas' {frmErrors},
  GlobalU in '..\ScotSim\GlobalU.pas',
  UtilsU in '..\ScotSim\UtilsU.pas',
  AdjustForJointsU in '..\ScotSim\AdjustForJointsU.pas',
  UnitDMTemplate in 'DataModule\UnitDMTemplate.pas' {DMTemplate: TDataModule},
  UnitDMEXPORTJOB in 'DataModule\UnitDMEXPORTJOB.pas' {DMEXPORTJOB: TDataModule},
  UnitDMEXPORTFRAME in 'DataModule\UnitDMEXPORTFRAME.pas' {DMEXPORTFRAME: TDataModule},
  UnitDMEXPORTFRAMEENTITY in 'DataModule\UnitDMEXPORTFRAMEENTITY.pas' {DMEXPORTFRAMEENTITY: TDataModule},
  PBThreadedSplashscreenU in '..\Common\PBThreadedSplashscreenU.pas',
  SplashScreenU in '..\Common\SplashScreenU.pas' {FormSplash},
  UnitJobSelection in 'UnitJobSelection.pas' {FormJobSelection},
  UnitDMDesignJob in '..\ClientCommon\DataModule\UnitDMDesignJob.pas' {DMDesignJob: TDataModule},
  UnitDMLoadEP2Files in '..\ClientCommon\DataModule\UnitDMLoadEP2Files.pas' {DMLoadEP2Files: TDataModule},
  UnitDMEXPORTEP2FILE in 'DataModule\UnitDMEXPORTEP2FILE.pas' {DMEXPORTEP2FILE: TDataModule},
  ToolOffsets in 'ToolOffsets.pas',
  Usettings in 'Usettings.pas' {FormSettings},
  UnitDMJOBDETAIL in 'DataModule\UnitDMJOBDETAIL.pas' {DMJOBDETAIL: TDataModule},
  WindowsServices in '..\Common\WindowsServices.pas',
  UnitStopServiceForm in '..\Common\UnitStopServiceForm.pas' {StopServiceForm},
  UnitServiceManager in 'DataModule\UnitServiceManager.pas',
  UnitServiceStatus in 'DataModule\UnitServiceStatus.pas' {FrameServiceStatus: TFrame},
  UnitDBXMetadataHelper in '..\Common\UnitDBXMetadataHelper.pas',
  UnitDMRFDateInfo in 'DataModule\UnitDMRFDateInfo.pas' {DMRFDateInfo: TDataModule},
  UnitDMItemProduction in 'DataModule\UnitDMItemProduction.pas' {DMItemProduction: TDataModule},
  UnitDataSnapClientClass in '..\ClientCommon\UnitDataSnapClientClass.pas',
  UnitDMRollFormer in 'DataModule\UnitDMRollFormer.pas' {DMRollFormer: TDataModule},
  UnitDMJobTransfer in '..\ClientCommon\DataModule\UnitDMJobTransfer.pas' {DMJobTransfer: TDataModule},
  UnitJobTransferForm in '..\ClientCommon\UnitJobTransferForm.pas' {FormJobTransfer},
  UnitLocalDBClass in '..\ClientCommon\UnitLocalDBClass.pas' {DMLocalDB: TDataModule},
  UnitRemoteDBClass in '..\ClientCommon\UnitRemoteDBClass.pas' {DMRemoteDB: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  UnitDSServerDB in '..\Common\UnitDSServerDB.pas',
  UnitDisplayDataset in '..\Common\UnitDisplayDataset.pas' {FormDisplayDataset},
  UnitJobFoundForm in '..\ClientCommon\UnitJobFoundForm.pas' {FormJobFound},
  CardBaseU in '..\CardManagement\CardMaster\CardBaseU.pas';

{$R *.RES}

begin
  Application.Initialize;
  try
    Application.Title := 'ScotRF';
    InkJetMaster := TInkJetMaster.Create(application);
    CardApi:=TCardApi.Create(nil); // free (last) in finalization
    CardApi.Initialise;
    CardAdapter:= TCardAdapter.Create;
    Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormSettings, FormSettings);
  Application.CreateForm(TTypeSelectform, TypeSelectform);
  Application.CreateForm(TfrmErrors, frmErrors);
  Application.CreateForm(TItemform, Itemform);
  Application.CreateForm(TItemhelpform, Itemhelpform);
  Application.CreateForm(TItemwizardform, Itemwizardform);
  Application.CreateForm(Tmintform, mintform);
  Application.CreateForm(TPanelWizardForm, PanelWizardForm);
  Application.CreateForm(Tpauseform, pauseform);
  finally
    Application.Restore;
  end;
  Application.Run;
end.
