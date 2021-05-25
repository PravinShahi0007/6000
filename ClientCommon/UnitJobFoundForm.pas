unit UnitJobFoundForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormJobFound = class(TForm)
    MemoJobInformation: TMemo;
    PanelButtons: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function AJobFound(anInfo : String) : Integer;
  end;

var
  FormJobFound: TFormJobFound;

implementation

{$R *.dfm}

uses UnitDMDesignJob, ScotRFTypes;

class function TFormJobFound.AJobFound(anInfo : String) : Integer;
var
  aJobFound : TFormJobFound;
begin
  aJobFound := TFormJobFound.Create(nil);
  try
    aJobFound.MemoJobInformation.Lines.Add(anInfo);
    result := aJobFound.ShowModal;
  finally
    FreeAndNil(aJobFound);
  end;
end;

procedure TFormJobFound.FormCreate(Sender: TObject);
begin
  Button2.Visible := False;//  NOT DMScotServer.IsDashboard;
end;

end.
