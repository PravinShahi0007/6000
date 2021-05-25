unit mintsettings;
{
Sets drive settings for all drives. Flex+, Mint & Mint II
If baldorcom is true, it uses the MintController activeX component to talk to the drive
This allows easier access to drive temp, version nos etc..
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, PasswordU,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, ScotRFTypes, GlobalU, math, Menus, rollformerU;

type
  Tmintform = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    uxMaxSpeed: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    uxMaxAccel: TEdit;
    UpDown2: TUpDown;
    uxFile: TEdit;
    bnMexDownload: TBitBtn;
    bnFirmwareDownload: TBitBtn;
    bnSaveMax: TBitBtn;
    bnReadMax: TBitBtn;
    Shape2: TShape;
    bnOpen: TSpeedButton;
    OpenDialog1: TOpenDialog;
    Shape1: TShape;
    Label3: TLabel;
    uxRatedCurrent: TEdit;
    Label4: TLabel;
    uxAllowedCurrent: TEdit;
    bnReadRatedCurrent: TBitBtn;
    bnSaveMotorCurrent: TBitBtn;
    ckTempComp: TCheckBox;
    PopupMenu1: TPopupMenu;
    miSetMachineType: TMenuItem;
    gpCharge: TGroupBox;
    cbCharge: TComboBox;
    bnSaveCharge: TBitBtn;
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure bnSaveMaxClick(Sender: TObject);
    procedure bnMexDownloadClick(Sender: TObject);
    procedure bnFirmwareDownloadClick(Sender: TObject);
    function  ConfirmDownLoad:boolean;
    procedure bnReadMaxClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bnOpenClick(Sender: TObject);
    procedure bnReadRatedCurrentClick(Sender: TObject);
    procedure bnSaveMotorCurrentClick(Sender: TObject);
    procedure miSetMachineTypeClick(Sender: TObject);
    procedure bnSaveChargeClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
  private
    procedure setChargeTypeCombo;
  public
  end;

var
  mintform: Tmintform;

  const accfactor=300; rpmfactor=6.8;
implementation

uses Usettings, cardAPIU ;

{$R *.DFM}

procedure Tmintform.UpDown1Click(Sender: TObject; Button: TUDBtnType);
//*Changes max. motor rpm
begin
if Button=btnext then uxMaxSpeed.text:=inttostr(strtoint(uxMaxSpeed.text)+100);
if Button=btprev then uxMaxSpeed.text:=inttostr(strtoint(uxMaxSpeed.text)-100);
end;

procedure Tmintform.UpDown2Click(Sender: TObject; Button: TUDBtnType);
//*Changes max. motor acceleration
begin
if Button=btnext then uxMaxAccel.text:=inttostr(strtoint(uxMaxAccel.text)+10);
if Button=btprev then uxMaxAccel.text:=inttostr(strtoint(uxMaxAccel.text)-10);
end;

procedure Tmintform.bnSaveChargeClick(Sender: TObject);
var
 CC: TChargeType;
begin
  if Rollformer.NewProtocol then
  begin
    CC:=ccGreen;
    case cbCharge.ItemIndex  of
      1: CC:=ccRed;
      2: CC:=ccNoCharge;
    end;
    rollformer.SetChargeType(CC);
    setChargeTypeCombo;
  end
  else
    messagedlg('Function not available on ' + G_Settings.general_drive+' drive', mterror, [mbok],0);
end;

procedure Tmintform.bnSaveMaxClick(Sender: TObject);
//*set acceleration & max rpm
var
  MaxSpeed, maxAccel, bTempComp: Double;
begin
  MaxSpeed := strtofloat(uxMaxSpeed.text);
  maxAccel := strtofloat(uxMaxAccel.text);

  rollformer.setMintValue(motRPM, trunc(MaxSpeed * rpmfactor));
  rollformer.setMintValue(motAcc, trunc(maxAccel * accfactor));
  //* Set temp compensation on Mint IIs with firmware 5225+
  If DriveHasTemp then
  begin
    bTempComp:= ifthen(IsBaldorDrive and ckTempComp.Checked,1,0);
    rollformer.setMintValue(tempCompFlag, bTempComp);
  end;
  MessageDlg('Update successful', mtInformation, [mbOK], 0);
end;

procedure Tmintform.bnMexDownloadClick(Sender: TObject);
//*Downloads exisiting MintII mex file to controller
//* This can also be done via the Baldor workbench
var pwd:string;
begin
  pwd:=InputPassword('Downloads','Enter Access Code');
  if pwd <> 'ScottsdaleNZ' then
  begin
    messagebeep(1);
    exit;
  end;
  if ConfirmDownload and fileexists(uxFile.text) then
  begin
    rollformer.MintController1.DoMintFileDownload(uxFile.text);
    rollformer.MintController1.DoMintRun;  //Run new mex program
    close;
  end;
end;

procedure Tmintform.bnFirmwareDownloadClick(Sender: TObject);
//* Downloads exisiting Firmware file to controller
//* This can also be done via the Baldor workbench
var pwd:string;
begin {download firmware file}
  pwd := InputPassword('Downloads', 'Enter Access Code');
  if pwd <> 'ScottsdaleNZ' then
    begin
    messagebeep(1);
    exit;
  end;

  if ConfirmDownload and fileexists(uxFile.text) then
  begin
    rollformer.MintController1.DoParameterTableUpload(extractfilepath(paramstr(0))+ 'paramtable.ptx');
    //showmessage('Param table uploaded from drive');
    rollformer.MintController1.DoUpdateFirmware(uxFile.text);
    //showmessage('Firmware updated');
    if fileexists('C:\paramtable.ptx') then
    begin
      rollformer.MintController1.DoParameterTableDownload(extractfilepath(paramstr(0))+ 'paramtable.ptx');
      //showmessage('Parameters downloaded');
    end
    else
      with Application do
      begin
        NormalizeTopMosts;
        MessageBox('Parameters Not Found - Use WorkBench for settings', 'WARNING !', MB_OK);
        RestoreTopMosts;
      end;
    rollformer.MintController1.DoReset(0);
    //showmessage('Controller has been Reset');
    rollformer.MintController1.DoMintRun; //Run new mex program
  end;
  close;
end;

function TMintForm.ConfirmDownLoad:boolean;
begin
  result :=  MessageDlg('WARNING : This will overwrite existing settings?',
                        mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure Tmintform.bnReadMaxClick(Sender: TObject);
//* Read the drives current max rpm & acceleration from the drives software via comms array data
var
  MaxSpeed, maxAccel, bTempComp: Double;
begin

  MaxSpeed  := rollformer.getMintValue(motRPM);
  MaxAccel  := rollformer.getMintValue(motAcc);
  uxMaxSpeed.text := inttostr(trunc(MaxSpeed/rpmfactor));
  uxMaxAccel.text := inttostr(trunc(MaxAccel/accfactor));

  If DriveHasTemp then    //*Read temp comp from Truss and later Panel RF
  begin
    bTempComp := rollformer.getMintValue(tempCompFlag);
    ckTempComp.checked := round(bTempComp)=1;
  end;
  if Rollformer.NewProtocol then
    setChargeTypeCombo;
end;

procedure Tmintform.setChargeTypeCombo;
begin
  Rollformer.ReadMachineChargeType;
  case Rollformer.MachineChargeType of
    ccRed:      cbCharge.ItemIndex:=1;
    ccNoCharge: cbCharge.ItemIndex:=2;
    else        cbCharge.ItemIndex:=0;
  end;
end;

procedure Tmintform.FormShow(Sender: TObject);
begin
  uxAllowedCurrent.enabled := false;
  uxRatedCurrent.enabled := false;
  bnReadRatedCurrent.enabled := false;
  bnSaveMotorCurrent.enabled := false;
  ckTempComp.Visible := DriveHasTemp;
  if not IsBaldorDrive then
  begin
    uxFile.enabled := false;
    bnFirmwareDownload.enabled := false;
    bnMexDownload.enabled := false;
  end
  else
  begin
    uxFile.enabled := true;
    bnFirmwareDownload.enabled := true;
    bnMexDownload.enabled := true;
  end;
  If Rollformer.MintVersion >= '630' then
  begin
    uxAllowedCurrent.enabled := true;
    uxAllowedCurrent.enabled := true;
    bnReadRatedCurrent.enabled := true;
    bnSaveMotorCurrent.enabled := true;
  end;
  if bFrames and (copy(Rollformer.MintVersion, 1, 1)<> '8') then
  begin
    label3.visible := false; label4.visible := false;
    uxRatedCurrent.visible := false; uxAllowedCurrent.visible := false;
    bnSaveMotorCurrent.visible := false; bnReadRatedCurrent.visible := false;
  end;
end;

procedure Tmintform.miSetMachineTypeClick(Sender: TObject);
var pwd:string;
begin
  if Rollformer.NewProtocol then
  begin
    pwd := InputPassword('Charge Type Update Code');
    miSetMachineType.Checked := pwd = 'AC2017';
    gpCharge.Visible := miSetMachineType.Checked;
    setChargeTypeCombo;
  end else
    messagedlg('Function not available on ' + G_Settings.general_drive +' drive', mterror, [mbok],0);
end;

procedure Tmintform.PopupMenu1Popup(Sender: TObject);
begin
  if not Rollformer.NewProtocol then
    miSetMachineType.enabled:=false;
end;

procedure Tmintform.bnOpenClick(Sender: TObject);
begin
  Opendialog1.InitialDir:=extractfilepath(paramstr(0));
  if Opendialog1.execute then uxFile.Text:=opendialog1.filename;
end;

procedure Tmintform.bnReadRatedCurrentClick(Sender: TObject);
//*Read rated motor current from Truss RFs. Used in 3 phase to limit gearbox torque
//*Added for 3 phase series 800 RFs (USA manufactured)
var
  MintV: String;
  Rated, allowed: Double;
  CommsNo: integer;
begin
  MintV := copy(Rollformer.mintversion, 1, 1); // '8' = 800 series mint
  if not bFrames or (copy(Rollformer.mintversion, 1, 1)= '8') then
  begin
    CommsNo := ifThen(MintV = '8', 14, 13); // rated current
    Rated := rollformer.getMintValue(TMintValue(CommsNo));

    CommsNo := ifThen(MintV = '8', 13, 12);
    allowed := rollformer.getMintValue(TMintValue(CommsNo)); // readback to confirm

    uxRatedCurrent.text := format('%4.1f',[Rated]);
    uxAllowedCurrent.text := format('%4.1f',[allowed]);
  end;
end;

procedure Tmintform.bnSaveMotorCurrentClick(Sender: TObject);
//*Write rated motor current to Truss RFs. Used in 3 phase to limit gearbox torque
//*Added for 3 phase series 800 RFs (USA manufactured)
var
  MintV: String;
  CommsNo: integer;
begin
  MintV := copy(Rollformer.mintversion, 1, 1); // '8' = 800 series mint
  if (not bFrames) or (MintV = '8') then
  begin
    CommsNo := ifThen(MintV = '8', 13, 12);
    rollformer.setMintValue(TMintValue(CommsNo), strtofloat(uxAllowedCurrent.text));
    rollformer.getMintValue(TMintValue(CommsNo)); // readback to confirm
    MessageDlg('Update successful', mtInformation, [mbOK], 0);
  end;
end;

end.
