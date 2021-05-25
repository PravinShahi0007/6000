unit Entityunit;

{
Form to display details for an Entity item
}

interface

uses
  Windows, Messages, SysUtils,
  Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls;

type
  TEntityForm = class(TForm)
    lblName: TLabel;
    txtTruss: TEdit;
    Label2: TLabel;
    txtItemIndex: TEdit;
    Label3: TLabel;
    txtLength: TEdit;
    lblWeb: TLabel;
    lblOrientation: TLabel;
    lblProfile: TLabel;
    memInfo: TMemo;
    chkDistancesFromFarEnd: TCheckBox;
    memInfo2: TMemo;
    lblOperations: TLabel;
    lblTotalLength: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure chkDistancesFromFarEndClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EntityForm: TEntityForm;

implementation

uses TranslateU;

{$R *.dfm}

procedure TEntityForm.chkDistancesFromFarEndClick(Sender: TObject);
begin
  memInfo.Visible := not chkDistancesFromFarEnd.Checked;
  memInfo2.Visible := chkDistancesFromFarEnd.Checked;
end;

procedure TEntityForm.FormCreate(Sender: TObject);
begin
  memInfo2.Left := memInfo.Left;
  memInfo2.Top := memInfo.Top;

  TranslateForm(Self);
end;

END.
