program ScotService;

uses
  Vcl.SvcMgr,
  UnitService in 'UnitService.pas' {ServiceScot: TService},
  UnitDBXMetadataHelper2 in '..\Common\UnitDBXMetadataHelper2.pas',
  Com_Exception in '..\Common\Com_Exception.pas',
  Com_OSUtil in '..\Common\Com_OSUtil.pas',
  Com_Streams in '..\Common\Com_Streams.pas',
  com_sync in '..\Common\com_sync.pas',
  DelphiCompat in '..\Common\DelphiCompat.pas',
  UnitDBXMetadataHelper in '..\Common\UnitDBXMetadataHelper.pas',
  UnitDSServerDB in '..\Common\UnitDSServerDB.pas',
  MethodsServerModule in '..\ScotFDServer\Modules\MethodsServerModule.pas' {DSServerMethods: TDSServerModule},
  UnitDSServerMain in '..\ScotFDServer\UnitDSServerMain.pas' {DSServerMain: TDSServerModule},
  UnitScotFDServerContainer in '..\ScotFDServer\UnitScotFDServerContainer.pas' {ServerContainerRF: TDataModule};

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TDSServerMain, DSServerMain);
  Application.CreateForm(TDSServerMethods, DSServerMethods);
  Application.CreateForm(TServiceScot, ServiceScot);
  Application.CreateForm(TServerContainerRF, ServerContainerRF);
  Application.Run;
end.
