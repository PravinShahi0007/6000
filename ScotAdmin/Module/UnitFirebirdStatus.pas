unit UnitFirebirdStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitServiceStatus, System.ImageList,
  Vcl.ImgList, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls, UnitServiceManager;

type
  TFrameFirebirdStatus = class(TFrameServiceStatus)
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

constructor TFrameFirebirdStatus.Create(AOwner: TComponent; AServiceName: String; AServiceManager : TServiceManager);
begin
  FServiceName             := AServiceName;
  Name                     := FServiceName;
  inherited;
end;

function TFrameFirebirdStatus.GetServiceStatus  : TServiceState;
begin
  FServiceManager.RebuildServicesList;
  FServiceStatus := FServiceManager.ServiceByName[FServiceName].State;
  inherited;
end;

procedure TFrameFirebirdStatus.SpeedButtonStartServerClick(Sender: TObject);
begin
  inherited;
  FServiceManager.ServiceByName[FServiceName].ServiceStart(True);
  StatusChange(nil);
end;

end.
