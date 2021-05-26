unit FormatDetailU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CardBaseU;

type
  TFormatDetail = class(TForm)
    bnOK: TBitBtn;
    rgPanelOrTruss: TRadioGroup;
    rgCardCharge: TRadioGroup;
    procedure rgPanelOrTrussClick(Sender: TObject);
  public
    function PanelOrTruss: AnsiString;
    function ChargeScheme: TChargeType;
    procedure setChargeScheme(AValue: TChargeType);
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

procedure TFormatDetail.setChargeScheme(AValue: TChargeType);
begin
  rgCardCharge.ItemIndex :=0;
  case AValue of
    ccRed :        rgCardCharge.ItemIndex:=1;
    ccNoCharge :   rgCardCharge.ItemIndex:=2;
  end;
end;

end.

