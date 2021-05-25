unit InputDetailU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TInputDetail = class(TForm)
    Label1: TLabel;
    edName: TEdit;
    lbUnits: TLabel;
    edQuantity: TEdit;
    bnOK: TBitBtn;
    rgUnits: TRadioGroup;
    lbEcho: TLabel;
    edSerial: TEdit;
    Label2: TLabel;
    uxExpiry: TDateTimePicker;
    lbExpiry: TLabel;
    procedure rgUnitsClick(Sender: TObject);
    procedure bnOKClick(Sender: TObject);
    procedure edNameChange(Sender: TObject);
    procedure edQuantityChange(Sender: TObject);
    procedure edSerialChange(Sender: TObject);
    procedure uxExpiryChange(Sender: TObject);
  private
    function MaxN: integer;
    function CheckN: integer;
    procedure EnableOKButton;
  public
    function getMetres: integer;
    function SerialNumber: Integer;
  end;

implementation

{$R *.dfm}

procedure TInputDetail.bnOKClick(Sender: TObject);
var N1, N2: integer;
begin
  modalResult := mrNone;
  N1 := StrToInt(edQuantity.Text);
  if N1 > MaxN then
  begin
    MessageDlg(format('Exceeds limit %6.0n', [1.0 * MaxN]), mterror, [mbAbort], 0);
    exit;
  end;
  if N1 > CheckN then
  begin
    N2 := StrToIntDef(InputBox('Large amount', 'Please re-enter', ''), 0);
    if N1 <> N2 then
    begin
      MessageDlg('Values do not match', mterror,[mbAbort], 0);
      exit;
    end;
  end;
  modalResult := mrOK;
end;

function TInputDetail.getMetres: integer;
begin
  result := StrToIntDef(edQuantity.Text, 0);
  if rgUnits.ItemIndex = 1 then
    result := round(result * 0.3048);
end;

procedure TInputDetail.edNameChange(Sender: TObject);
begin
  EnableOKButton;
end;

procedure TInputDetail.EnableOKButton;
begin
  if uxExpiry.Visible then
    bnOK.Enabled := (SerialNumber>0) and (length(edName.Text) >= 4) and (uxExpiry.DateTime > Now)
  else
    bnOK.Enabled := (SerialNumber>0) and (length(edName.Text) >= 4) and (getMetres >= 1);
end;

procedure TInputDetail.edQuantityChange(Sender: TObject);
begin
  EnableOKButton;
  lbEcho.Visible := rgUnits.ItemIndex = 1;
  lbEcho.Caption := format('%6.0n Metres', [1.0 * getMetres]);
end;

procedure TInputDetail.edSerialChange(Sender: TObject);
begin
  EnableOKButton;
end;

function TInputDetail.MaxN: integer;
begin
  if rgUnits.ItemIndex = 0 then
    result := 100000
  else
    result := 328000;
end;

function TInputDetail.CheckN: integer;
begin
  if rgUnits.ItemIndex = 0 then
    result := 20000
  else
    result := 50000;
end;

procedure TInputDetail.rgUnitsClick(Sender: TObject);
begin
  if rgUnits.ItemIndex = 0 then
    lbUnits.Caption := 'Metres'
  else
    lbUnits.Caption := 'Feet';
  edQuantityChange(Sender);
end;

function TInputDetail.SerialNumber: Integer;
begin
  result := StrToIntDef(edSerial.text,0);
end;

procedure TInputDetail.uxExpiryChange(Sender: TObject);
begin
  EnableOKButton ;
end;

end.
