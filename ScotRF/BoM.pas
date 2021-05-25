// Bill of materials summary - Summary on screen; Details on printer

unit BoM;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFormBoM = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    lbConnector: TLabel;
    lbSpacerTxt: TLabel;
    lbScrewsText: TLabel;
    bnPrint: TBitBtn;
    lbMetres: TLabel;
    lbConnectors: TLabel;
    lbSpacers: TLabel;
    lbTeks: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    FMetres: Double;
    ConnectorCount: Integer; // Rivet or Bolt
    SpacerCount : Integer;
    TEKCount    : Integer;
  public
    class function Exec: integer;
  end;

implementation

{$R *.dfm}

uses Usettings, Units, ScotRFTypes;

class function TFormBoM.Exec: integer;
var
  FormBoM: TFormBoM;
begin
  FormBoM := TFormBoM.Create(nil);
  try
    Result := FormBoM.ShowModal;
  finally
    FreeAndNil(FormBoM);
  end;
end;

procedure TFormBoM.FormCreate(Sender: TObject);
begin
  if G_Settings.general_imperial then
    lbMetres.Caption   := IntToStr(Round(fratio*G_Material.Metres/1000))
  else
    lbMetres.Caption   := IntToStr(Round(G_Material.Metres/1000));
  lbConnectors.caption := inttostr(G_Material.Connectors);
{$IFDEF panel}
  lbConnector.caption  := 'Rivets';
  lbSpacerTxt.Visible  := false;
  lbSpacers.Visible    := false;
  lbScrewsText.Visible := false;
  lbTeks.Visible       := false;
{$ELSE}
  lbSpacers.caption    := inttostr(G_Material.Spacers);
  lbTeks.caption       := inttostr(G_Material.TEKScrews);
{$ENDIF}
end;

end.
