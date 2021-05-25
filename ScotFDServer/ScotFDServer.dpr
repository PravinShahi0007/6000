program ScotFDServer;

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UnitServerMainForm in 'UnitServerMainForm.pas' {ServerMainForm},
  UnitScotFDServerContainer in 'UnitScotFDServerContainer.pas' {ServerContainerRF: TDataModule},
  UnitDBXMetadataHelper in '..\Common\UnitDBXMetadataHelper.pas',
  UnitDSServerDB in '..\Common\UnitDSServerDB.pas',
  Com_Exception in '..\Common\Com_Exception.pas',
  com_sync in '..\Common\com_sync.pas',
  DelphiCompat in '..\Common\DelphiCompat.pas',
  Com_Streams in '..\Common\Com_Streams.pas',
  Com_OSUtil in '..\Common\Com_OSUtil.pas',
  UnitDSServerMain in 'UnitDSServerMain.pas' {DSServerMain: TDSServerModule},
  MethodsServerModule in 'Modules\MethodsServerModule.pas' {DSServerMethods: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerMainForm, ServerMainForm);
  Application.CreateForm(TServerContainerRF, ServerContainerRF);
  Application.CreateForm(TDSServerMain, DSServerMain);
  Application.CreateForm(TDSServerMethods, DSServerMethods);
  Application.Run;
end.

