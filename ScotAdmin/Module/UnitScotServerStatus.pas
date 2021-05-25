unit UnitScotServerStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitServiceStatus, System.ImageList,
  Vcl.ImgList, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, UnitServiceManager,
  Data.DB, Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON;

type
  TFrameScotServerStatus = class(TFrameServiceStatus)
    LabelIPAddress: TLabel;
    procedure SpeedButtonStartServerClick(Sender: TObject);
  private
    { Private declarations }
    FServiceName    : String;
    function GetServiceStatus  : TServiceState;override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AServiceName: String; AServiceManager : TServiceManager);override;
  end;

implementation

{$R *.dfm}

uses Com_Exception, UnitDSServerDB;

constructor TFrameScotServerStatus.Create(AOwner: TComponent; AServiceName: String; AServiceManager : TServiceManager);
begin
  FServiceName             := AServiceName;
  Name                     := FServiceName;
  inherited;
end;

function TFrameScotServerStatus.GetServiceStatus  : TServiceState;
var
  aJsonFile : String;
begin
  FServiceManager.RebuildServicesList;
  FServiceStatus := FServiceManager.ServiceByName[FServiceName].State;
  inherited;
  try
    aJsonFile := GetServerDatabaseDirectory+'CDSServerInfo.Json';
    if FileExists(aJsonFile) then
    begin
      FDMemTableServerInfo.LoadFromFile(aJsonFile);
      LabelIPAddress.Caption := Format('IP Address:%s; Port:%s',[FDMemTableServerInfoIPAddress.AsString, FDMemTableServerInfoPort.AsString]);
    end;
  except
    On E: Exception do
      HandleException(e,'DMSCS.ServerClient.GetServerIPandPort',[]);
  end;
end;

procedure TFrameScotServerStatus.SpeedButtonStartServerClick(Sender: TObject);
begin
  inherited;
  FServiceManager.ServiceByName[FServiceName].ServiceStart(True);
  StatusChange(nil);
end;

end.
