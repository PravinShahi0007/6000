unit UnitScotFDServerContainer;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DB, Datasnap.DBClient,
  Datasnap.Provider, Data.SqlExpr, Windows, WinSock, IPPeerServer, DBXCommon,
  Datasnap.DSCommonServer, Datasnap.DSServer, Datasnap.DSTCPServerTransport,
  Data.DBXFirebird, Datasnap.DSAuth, Generics.Collections, DBXTransport,
  DBXDataSnap, IPPeerClient, Datasnap.DSSession, FireDAC.Phys.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Intf, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client
  , MethodsServerModule;

type
  TServerContainerRF = class(TDataModule)
    DSServerScotRF: TDSServer;
    DSTCPServerTransportScotRF: TDSTCPServerTransport;
    DSServerClassMethods: TDSServerClass;
    CDSCurrentConnections: TClientDataSet;
    procedure DSServerClassMethodsGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSServerScotRFConnect(
      DSConnectEventObject: TDSConnectEventObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DSServerScotRFDisconnect(
      DSConnectEventObject: TDSConnectEventObject);
  private
    { Private declarations }
    ConnectionList  : TDictionary<Integer,TSQLConnection>;

    Function GetConnection: TSQLConnection;

  public
    procedure Shutdown;
    procedure StartServer(port: Integer);
    function  GetDBName: String;
  end;

var
  ServerContainerRF: TServerContainerRF;

implementation

uses
  UnitDBXMetadataHelper, UnitDSServerDB, Com_Exception, StrUtils, UnitDSServerMain;


{$R *.dfm}

procedure TServerContainerRF.Shutdown;
begin
  try
    DSServerScotRF.Stop;
  except
    on E: Exception do
      HandleException(e,'TServerMainContainer.ShutDown',[]);
  end;
end;

procedure TServerContainerRF.StartServer(port: Integer);
begin
  try
    DSTCPServerTransportScotRF.port := port;
    DSServerScotRF.Start;
  except
    on E: Exception do
      HandleException(e,'TServerMainContainer.StartServer',[]);
  end;
end;

procedure TServerContainerRF.DataModuleCreate(Sender: TObject);
var
  Comm: TDBXCommand;
  Reader: TDBXReader;
begin
  ConnectionList := TDictionary<Integer, TSQLConnection>.Create;
  CDSCurrentConnections.CreateDataSet;
  CDSCurrentConnections.Active := True;
end;

procedure TServerContainerRF.DSServerClassMethodsGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDSServerMethods;
end;

function TServerContainerRF.GetConnection: TSQLConnection;
var
  dbconn : TSQLConnection;
begin
  if ConnectionList.ContainsKey(TDSSessionManager.GetThreadSession.Id) then
  begin
    Result := ConnectionList[TDSSessionManager.GetThreadSession.Id];
  end
  else
  begin
    dbconn := TSQLConnection.Create(nil);
    InitConnection(dbconn, GetServerDatabaseDirectory+POSDB_NAME);
    ConnectionList.Add(TDSSessionManager.GetThreadSession.Id, dbconn);
    Result := dbconn;
  end;
end;

procedure TServerContainerRF.DSServerScotRFConnect(DSConnectEventObject: TDSConnectEventObject);
begin
  try
    GetConnection.Open;
    IF DSConnectEventObject.ConnectProperties[TDBXPropertyNames.DSAuthenticationUser]='' then
      Exit;
    CDSCurrentConnections.Insert;
    if DSConnectEventObject.ChannelInfo <> nil then
    begin
      CDSCurrentConnections['ID']     := DSConnectEventObject.ChannelInfo.Id;
      CDSCurrentConnections['Info']   := DSConnectEventObject.ChannelInfo.Info;
    end;
    CDSCurrentConnections['UserName']         := DSConnectEventObject.ConnectProperties[TDBXPropertyNames.DSAuthenticationUser];
    CDSCurrentConnections['TillNo']           := 0;//StrToIntDef(aTill,0);
    CDSCurrentConnections['ServerConnection'] := DSConnectEventObject.ConnectProperties[TDBXPropertyNames.ServerConnection];
    CDSCurrentConnections.Post;
  except
    on E: Exception do
      HandleException(e,'InitialConnection',[]);
  end;
end;

procedure TServerContainerRF.DSServerScotRFDisconnect(
  DSConnectEventObject: TDSConnectEventObject);
begin
  if CDSCurrentConnections.Locate('ID', DSConnectEventObject.ChannelInfo.Id,[]) then
    CDSCurrentConnections.Delete;
end;

function TServerContainerRF.GetDBName: String;
begin
  Result := DSServerMain.SQLConnToDB.Params.Values['Database']
end;




end.

