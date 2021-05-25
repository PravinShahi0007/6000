unit UnitSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitChildWin, Vcl.StdCtrls, ScotRFTypes;

type
  TMDIChildSettings = class(TMDIChild)
    GroupBoxServer: TGroupBox;
    LabelServer: TLabel;
    LabelPort: TLabel;
    EditServer: TEdit;
    EditPort: TEdit;
    ButtonSave: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  MDIChildSettings: TMDIChildSettings;

implementation

{$R *.dfm}

procedure TMDIChildSettings.ButtonSaveClick(Sender: TObject);
begin
  inherited;
  G_Settings.general_Server := EditServer.Text;
  G_Settings.general_Port   := EditPort.Text;
  G_Settings.SaveSettings;
end;

procedure TMDIChildSettings.FormCreate(Sender: TObject);
begin
  inherited;
  EditServer.Text := G_Settings.general_Server;
  EditPort.Text   := G_Settings.general_Port;
end;

end.
