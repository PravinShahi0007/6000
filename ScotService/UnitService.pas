unit UnitService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient;

type
  TServiceScot = class(TService)
    FDMemTableServerInfo: TFDMemTable;
    FDMemTableServerInfoServerName: TStringField;
    FDMemTableServerInfoIPAddress: TStringField;
    FDMemTableServerInfoPort: TStringField;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceAfterInstall(Sender: TService);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  ServiceScot: TServiceScot;

implementation

uses Registry, Com_Exception, UnitScotFDServerContainer, UnitDSServerMain,
  UnitDSServerDB;

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ServiceScot.Controller(CtrlCode);
end;

function TServiceScot.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TServiceScot.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\'+Name, false) then
    begin
      Reg.WriteString('Description', 'This Service is for ScotRF and ScotDashboard');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TServiceScot.ServiceStart(Sender: TService; var Started: Boolean);
var
  Port      : Integer;
begin
  Port := 211;
  try
    ServerContainerRF.StartServer(Port);
    FDMemTableServerInfo.Open;
    If FDMemTableServerInfo.IsEmpty then
      FDMemTableServerInfo.Append
    else
      FDMemTableServerInfo.Edit;

    FDMemTableServerInfoServerName.AsString := DSServerMain.ServerComputerName;
    FDMemTableServerInfoIPAddress.AsString  := DSServerMain.IpAddress;
    FDMemTableServerInfoPort.AsString       := '211';
    FDMemTableServerInfo.Post;
    FDMemTableServerInfo.SaveToFile(GetServerDatabaseDirectory+'CDSServerInfo.Json', sfJson );
  except
    on E: Exception do
      HandleException(e,'TServiceScot.ServiceStart',[]);
  end;
end;

procedure TServiceScot.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  try
    ServerContainerRF.Shutdown;
  except
    on E: Exception do
      HandleException(e,'TServiceScot.ServiceStop',[]);
  end;
end;

end.
