unit SystemU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,   GlobalU, ScotRFTypes;
{$MESSAGE FATAL 'Obsolete'}
type
  TSystemForm = class(TForm)
    BitBtn2: TBitBtn;
    BtnUpdateSWare: TBitBtn;
    bnCalibrate: TBitBtn;
    bnRFSetup: TBitBtn;
    BtnStatus: TBitBtn;
    AboutBtn: TBitBtn;
    function  RandomCode:string;
    function  Decode(ts:string):string;
    procedure BtnStatusClick(Sender: TObject);
    procedure bnCalibrateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bnRFSetupClick(Sender: TObject);
    procedure BtnUpdateSWareClick(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    class function Exec(ABox: Boolean): integer;
  end;


implementation

uses  calibrate,  mintsettings, units, Mintstatus, Usettings, UpdateFormU, splash, spdunit, RollformerU, Unit1, MainU;

const openpwd=false;
{$R *.DFM}

var key:string;
class function TSystemForm.Exec(ABox: Boolean): integer;
var
  SysForm: TSystemForm;
begin
  SysForm:= TSystemForm.Create(nil);
  try
    result := SysForm.showModal;
  finally
    SysForm.free;
  end;
end;

function TSystemForm.RandomCode:string;
//*Makes a RANDOM CODE - Legacy code for pre-s/card security
var ts:string; i:word;

function character:char;
//*Returns a random displayable chr
var sw:word;
begin
sw:=random(10);
if sw > 5 then character:=chr(random(26)+65)
  else character:=chr(random(9)+49);
end;

begin {of RandomCode}
Randomize;
for i:=1 to 10 do ts:=ts+character;
RandomCode:=ts;
end;

function TSystemForm.Decode(ts:string):string;
//*Simple decoder for the coded string  - legacy controllers with no s/cards
var i:word; ts1:string;
begin
ts1:='';
for i:=1 to length(ts) do
   ts1:=ts1+chr(ord(ts[i]) xor (ord(key[i])-48));
Decode:=ts1;
end;


procedure TSystemForm.BtnStatusClick(Sender: TObject);
//*Reads data & displays in Form FormMintStatus
var ts1:string; {Get machine status}
begin
  if mainform.CheckConnectionWithMessage then
    exit;
  case DriveClass of
    tdcMint: TFormMintstatus.Exec('Drive Status'); {Mint drives only}
    tdcFlex:
      begin  {Pre-Mint drives (Flex+}
        if Rollformer.SendCommand('RM#',true) and
          Rollformer.CommandCompleted then
        begin
          ts1:=copy(rs,2,length(rs)-2);
          showmessage('Status = ' + ts1);
        end
        else MessageDlg('No status response', mtInformation,[mbOk], 0);
      end;
  end;
  rs:='';
end;


procedure TSystemForm.bnCalibrateClick(Sender: TObject);
begin
  if (DriveClass = tdcSim) then
  begin
    NotInSimMessage;
    exit;
  end;
  TCalibrateForm.Exec;
end;

procedure TSystemForm.FormShow(Sender: TObject);
begin
  form1.stopnow:=false;
  if rollformer.Boxweb then
  begin
    caption:='Box RF settings';
    BtnUpdateSWare.Visible:=false;
    AboutBtn.visible:=false;
  end else
  begin
    caption:='Local RF settings';
    BtnUpdateSWare.Visible:=true;
    AboutBtn.Visible:=true;
  end;
end;

procedure TSystemForm.bnRFSetupClick(Sender: TObject);
//*Activates the Setup form MintForm for Mint drives. Speedform for Flex+ drives.
begin
  if (DriveClass = tdcSim) then
  begin
    NotInSimMessage;
    exit;
  end;

  case DriveClass of
    tdcMint: mintform.showmodal;
    tdcFlex: TSpeedform.exec;
  end;
end;

procedure TSystemForm.BtnUpdateSWareClick(Sender: TObject);
begin
  TfrmUpdate.Exec;
end;

procedure TSystemForm.AboutBtnClick(Sender: TObject);
//*Displays the ScotRF splashform - to view s/ware version info
begin
  TSplashform.Splash(True {modal});
end;

end.
