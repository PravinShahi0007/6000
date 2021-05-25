unit UnitServerMainForm;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.ComCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON;

type
  TServerMainForm = class(TForm)
    DataSourceActiveConn: TDataSource;
    DataSourceEventLog: TDataSource;
    PanelLeft: TPanel;
    Splitter2: TSplitter;
    PanelServerLog: TPanel;
    LBServerName: TLabel;
    LBStartupTime: TLabel;
    PanelUsersAuthorixed: TPanel;
    DBGrid1: TDBGrid;
    PanelImage: TPanel;
    IMDSServer: TImage;
    IMServerStatus: TImage;
    PanelActiveConnection: TPanel;
    PanelRight: TPanel;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    DBGrid3: TDBGrid;
    FDMemTableServerInfo: TFDMemTable;
    FDMemTableServerInfoServerName: TStringField;
    FDMemTableServerInfoIPAddress: TStringField;
    FDMemTableServerInfoPort: TStringField;
    procedure IMServerStatusClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ShutdownServer;
    procedure StartServer;
    procedure LoadPNGImage(Res: String; Im: TImage);
    procedure GetServerInformation;
  public
    { Public declarations }
  end;

var
  ServerMainForm: TServerMainForm;

implementation

{$R *.dfm}

uses UnitScotFDServerContainer, UnitDSServerMain, Registry,
  UnitDBXMetadataHelper, UnitDSServerDB;

procedure TServerMainForm.LoadPNGImage(Res: String; Im: TImage);
var
  aResStream : TResourceStream;
  aPNGImage  : TPNGImage;
begin
  aResStream := TResourceStream.Create(hInstance, Res, RT_RCDATA);
  try
    aPNGImage := TPNGImage.Create;
    try
      aPNGImage.LoadFromStream(aResStream);
      Im.Picture.Graphic := aPNGImage;
    finally
      aPNGImage.Free
    end;
  finally
    aResStream.Free
  end;
end;

procedure TServerMainForm.GetServerInformation;
begin
  LoadPNGImage('PngScotServer', IMDSServer);
  LBServerName.Caption := 'Server Name (Port)/: ' +
    DSServerMain.ServerComputerName + '(' + IntToStr
    (ServerContainerRF.DSTCPServerTransportScotRF.Port)
    + ')/' + DSServerMain.IpAddress;
  StatusBar1.Panels[0].Text := 'Database: ' + ServerContainerRF.GetDBName;
end;

procedure TServerMainForm.FormShow(Sender: TObject);
begin
  StartServer;
  GetServerInformation;
end;

procedure TServerMainForm.IMServerStatusClick(Sender: TObject);
begin
  if ServerContainerRF.DSServerScotRF.Started then
    ShutdownServer
  else
    StartServer;
end;

procedure TServerMainForm.ShutdownServer;
begin
  try
    ServerContainerRF.Shutdown;
    LoadPNGImage('PngRed', IMServerStatus);
  except
    LoadPNGImage('PngGreen', IMServerStatus);
  end;
end;

procedure TServerMainForm.StartServer;
var
  Port: integer;
begin
  if ParamCount > 0 then
    Port := StrToInt(ParamStr(1))
  else
    Port := 211;
  try
    ServerContainerRF.StartServer(Port);
    LoadPNGImage('PngGreen', IMServerStatus);
    LBStartupTime.Caption := 'Startup: ' + DateTimeToStr(Now);
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
    LoadPNGImage('PngRed', IMServerStatus);
  end;
end;

end.

