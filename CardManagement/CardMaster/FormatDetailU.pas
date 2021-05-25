unit FormatDetailU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CardAPIU;

type
  TFormatDetail = class(TForm)
    bnOK: TBitBtn;
    rgPanelOrTruss: TRadioGroup;
    rgCardCharge: TRadioGroup;
    procedure rgPanelOrTrussClick(Sender: TObject);
  private
  public
    function PanelOrTruss: AnsiString;
    function ChargeScheme: TChargeType;
  end;

implementation

{$R *.dfm}

procedure TFormatDetail.rgPanelOrTrussClick(Sender: TObject);
begin
 bnOK.Enabled := rgPanelOrTruss.ItemIndex>=0;
end;

function TFormatDetail.PanelOrTruss: AnsiString;
begin
  case rgPanelOrTruss.ItemIndex of
    0 : Result := 'SCSPANEL';
    1 : Result := 'SCSTRUSS';
    else result := 'xxxxxxxx';
  end;
end;

function TFormatDetail.ChargeScheme: TChargeType;
const
  ChargeSchemeArray: array[0 .. 2] of TChargeType =(ccGreen, ccRed, ccNoCharge);
begin
  if rgCardCharge.ItemIndex <0 then
    raise exception.Create('no type selected');
  result := ChargeSchemeArray[rgCardCharge.ItemIndex];
end;

end.

