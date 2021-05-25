program ScotServer;

{$R *.dres}

uses
  Vcl.Forms,
  Com_Exception in '..\Common\Com_Exception.pas',
  Com_OSUtil in '..\Common\Com_OSUtil.pas',
  Com_Streams in '..\Common\Com_Streams.pas',
  com_sync in '..\Common\com_sync.pas',
  DelphiCompat in '..\Common\DelphiCompat.pas',
  UnitDBXMetadataHelper in '..\Common\UnitDBXMetadataHelper.pas',
  UnitDSServerDB in '..\Common\UnitDSServerDB.pas',
  MethodsServerModule in 'Modules\MethodsServerModule.pas' {DSServerMethods: TDSServerModule},
  UnitDSServerMain in 'UnitDSServerMain.pas' {DSServerMain: TDSServerModule},
  UnitScotFDServerContainer in 'UnitScotFDServerContainer.pas' {ServerContainerRF: TDataModule},
  UnitServerMainForm in 'UnitServerMainForm.pas' {ServerMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDSServerMain, DSServerMain);
  Application.CreateForm(TDSServerMethods, DSServerMethods);
  Application.CreateForm(TServerMainForm, ServerMainForm);
  Application.CreateForm(TServerContainerRF, ServerContainerRF);
  Application.Run;
end.
