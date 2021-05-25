unit Mintstatus;
{
Displays Mint drive status values
Changes display fields to match drive type
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ScotRFTypes, GlobalU, ComCtrls;

type
  TFormMintStatus = class(TForm)
    Label5: TLabel;
    BitBtn1: TBitBtn;
    uxComErrors: TEdit;
    Label2: TLabel;
    uxError: TEdit;
    Label1: TLabel;
    uxVersion: TEdit;
    Label4: TLabel;
    uxFirmware: TEdit;
    Label6: TLabel;
    uxDriveTemp: TEdit;
    Label7: TLabel;
    uxRFTemp: TEdit;
    bnCounter: TButton;
    StatusBar1: TStatusBar;
    procedure bnCounterClick(Sender: TObject);
  private
    procedure initialise;
    function hasTemp: boolean;
  public
    class function Exec(AText: string): Boolean; static;
  end;


implementation

uses Usettings, RollformerU, VirtualMachineU;

{$R *.dfm}

procedure TFormMintStatus.bnCounterClick(Sender: TObject);
begin
  MessageDlg('Life counter = '+ rollformer.getMintString(mintLifeCounter), mtInformation,[mbOk], 0);
end;

class function TFormMintStatus.Exec(AText: string): Boolean;
var
  FormMintStatus: TFormMintStatus;
begin
  assert(DriveClass=tdcMint,'Not a Mint drive');
  FormMintStatus:= TFormMintStatus.create(nil);
  try
    FormMintStatus.caption := AText;
    try
       FormMintStatus.initialise;
    except
       on e: exception do
         FormMintStatus.statusbar1.simpletext:=e.message;
    end;
    result:=FormMintStatus.ShowModal=mrOK;
  finally
    FormMintStatus.free;
  end;
end;

{$IFDEF Panel}
function TFormMintStatus.hasTemp: boolean;
var
  Version: Double;
begin
  version:=strtofloatDef(rollformer.mintVersion,0);
  result := (Version >= 721)
            or ((Version >= 636) and (Version < 700))
            or ((Version >= 421) and (Version < 500)) ;
end;
{$else}
function TFormMintStatus.hasTemp: boolean;
begin
  Result:= True
end;
{$Endif}

procedure TFormMintStatus.initialise;
var
 RFTemp: double;
begin
  uxFirmware.Text:='';
  uxDriveTemp.Text:='';
  uxError.text:='';
  uxComErrors.text:='';
  uxVersion.text:=Rollformer.MintVersion;

  if hasTemp then
  begin
    RFTemp := StrToFloatDef(rollformer.getMintString(mintRFTemp),-1);
    if RFTemp<0 then
      uxRFTemp.text:=rollformer.getMintString(mintRFTemp)
    else
      uxRFTemp.text:=intToStr(round(RFTemp));
  end;

  if IsBaldorDrive then
  begin
    uxFirmware.Text:=rollformer.ReadMachineFirmware;
    uxDriveTemp.Text:=inttostr(trunc(rollformer.MintController1.Temperature[0]));
  end else
  begin
    uxFirmware.Visible:=false;
    uxDriveTemp.Visible:=false;
    label4.Visible:=false;
    label6.Visible:=false;
  end;

 if rollformer.readcommsarray('25',false) then
   uxError.text:=rollformer.commdata;    // ERRCODE
 if rollformer.readcommsarray('27',false) then
   uxComErrors.text:=rollformer.commdata;    // ERRLINE

end;

end.
