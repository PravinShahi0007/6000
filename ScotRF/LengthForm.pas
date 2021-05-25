unit LengthForm;

{
 Value entry form for entering machine manual distance move value
}
interface

uses
  Windows, SysUtils, Classes,  Controls, Forms, StdCtrls, ComCtrls, Menus, Buttons;

type
  TfrmManualLength = class(TForm)
    Label1: TLabel;
    editdist: TEdit;
    Label2: TLabel;
    edCount: TEdit;
    UpDown1: TUpDown;
    bnCancel: TSpeedButton;
    bnRun: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure bnOKClick(Sender: TObject);
    procedure bnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure editdistKeyPress(Sender: TObject; var Key: Char);
  private
    FProcessFile: tStringList;
    function GetLength: String;
  public
    class function Exec: boolean; static;
    property ProcessFile: tStringList read FProcessFile;
    property Length: String read GetLength;
    function Count: integer;
  end;

var frmManualLength: TfrmManualLength;

implementation

uses winUtils, units, ScotRFTypes, dialogs;
{$R *.DFM}

class function TfrmManualLength.Exec: boolean;
begin
  if FrmManualLength =nil then
    FrmManualLength := TFrmManualLength.Create(application);
  result := FrmManualLength.ShowModal = mrOK;
end;

procedure TfrmManualLength.FormCreate(Sender: TObject);
begin
  FProcessFile := TStringList.Create;
end;

procedure TfrmManualLength.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FProcessFile);
end;

procedure TfrmManualLength.FormShow(Sender: TObject);
begin
  ActiveControl := EditDist;
end;

function TfrmManualLength.GetLength: String;
var
  aString : String;
  iValue  : Integer;
  iCode   : Integer;
begin
  aString := Trim(EditDist.text);
  Val(aString, iValue, iCode);
  if G_Settings.general_metric then
  begin
    Check((iCode = 0), 'Error - Invalid value for Metric settings');
  end
  else
  begin
    Check(iCode <> 0, 'Error - Invalid value for Imperial settings');
  end;
  Result := EditDist.text;
end;

procedure TfrmManualLength.bnCancelClick(Sender: TObject);
begin
  ModalResult :=-mrCancel;
end;

procedure TfrmManualLength.bnOKClick(Sender: TObject);
Var
  I : Integer;
begin
  FProcessFile.Clear;
  FProcessFile.Add('A,00,0,C'); // initial cut;
  for I:=1 to count do
    FProcessFile.Add(format('A,%d,%s,C',[i,Length]));
  ModalResult := mrOK
end;

procedure TfrmManualLength.editdistKeyPress(Sender: TObject; var Key: Char);
begin
  if G_Settings.general_metric then
  begin
    if ( not CharInSet(Key, ['0'..'9','.',#8, #13]) ) then
      Key := #0;
  end
  else
  begin
    if ( not CharInSet(Key, ['0'..'9','.',#8, #13, #34, #39]) ) then
      Key := #0;
  end;
end;

function TfrmManualLength.Count: integer;
begin
  result := StrToInt(edCount.text);
end;

end.
