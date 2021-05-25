unit UnitServiceStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.ImageList, Vcl.ImgList, UnitServiceManager, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageJSON;

type

  TStatusLight = (tsRed, tsAmber, tsOff, tsOK);

  TFrameServiceStatus = class(TFrame)
    PanelServiceStatus: TPanel;
    LabelServiceName: TLabel;
    ImageStatusLight: TImage;
    StatusImages: TImageList;
    SpeedButtonStartServer: TSpeedButton;
    FDMemTableServerInfo: TFDMemTable;
    FDMemTableServerInfoServerName: TStringField;
    FDMemTableServerInfoIPAddress: TStringField;
    FDMemTableServerInfoPort: TStringField;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
  private
    { Private declarations }

    FAfterStatusChange : TNotifyEvent;
    function GetStatusLightBmp(const Value: TStatusLight): TBitMap;
  protected
    FServiceName    : String;
    FServiceStatus  : TServiceState;
    FServiceManager : TServiceManager;
    function GetServiceStatus  : TServiceState;virtual;
    Procedure StatusChange(Sender: TObject);

  public
    { Public declarations }
    Property ServiceStatus     : TServiceState read GetServiceStatus;
    constructor Create(AOwner: TComponent; AServiceName: String; AServiceManager : TServiceManager);virtual;
  published
    property AfterStatusChange : TNotifyEvent  read FAfterStatusChange write FAfterStatusChange;
  end;

implementation

{$R *.dfm}

function TFrameServiceStatus.GetStatusLightBmp(const Value: TStatusLight): TBitMap;
begin
  Result := TBitmap.Create;
  StatusImages.GetBitmap(ord(Value), Result);
end;

function TFrameServiceStatus.GetServiceStatus  : TServiceState;
begin
  Case FServiceStatus of
    ssStopped      : begin
                       ImageStatusLight.Picture.Bitmap := GetStatusLightBmp(tsRed);
                       SpeedButtonStartServer.Visible := True;
                     end;
    ssStartPending : ImageStatusLight.Picture.Bitmap := GetStatusLightBmp(tsRed);
    ssStopPending  : ImageStatusLight.Picture.Bitmap := GetStatusLightBmp(tsRed);
    ssRunning      : begin
                       ImageStatusLight.Picture.Bitmap := GetStatusLightBmp(tsOk);
                       SpeedButtonStartServer.Visible := False;
                     end;
    ssContinuePending:;
    ssPausePending:;
    ssPaused:;
  End;
  Result := FServiceStatus;
end;

Procedure TFrameServiceStatus.StatusChange(Sender: TObject);
begin
  GetServiceStatus;
end;

constructor TFrameServiceStatus.Create(AOwner: TComponent; AServiceName: String; AServiceManager : TServiceManager);
begin
  inherited Create(AOwner);
  Parent := TForm(AOwner);
  Align  := alTop;
  FServiceManager          := AServiceManager;
  StatusChange(nil);
end;


end.
