unit LoadSteelU;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, Dialogs, StdCtrls, Buttons, ComCtrls, ScotRFTypes, ExtCtrls;

type
  TDlgLoad = class(TForm)
    bnRev: TSpeedButton;
    bnFwd: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    bnStop: TSpeedButton;
    Label3: TLabel;
    CutBtn: TSpeedButton;
    Bevel1: TBevel;
    bnClose: TSpeedButton;
    procedure bnFwdClick(Sender: TObject);
    procedure bnRevClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bnStopClick(Sender: TObject);
    procedure bnCloseClick(Sender: TObject);
    procedure bnExitProgramClick(Sender: TObject);
    procedure CutBtnClick(Sender: TObject);
  private
    FDir: integer;
    FPrevDir: integer;
    bBox: boolean;
    procedure setDir(ADir: integer);
  public
    Class function Exec(ABox: boolean): integer;
  end;

implementation

uses Usettings, RollformerU;
{$R *.DFM}

class function TDlgLoad.Exec(ABox: boolean): integer;
var
  DlgLoad: TDlgLoad;
begin
  DlgLoad := TDlgLoad.create(nil);
  try
    DlgLoad.bBox := ABox;
    DlgLoad.FPrevDir := 1;
    DlgLoad.setDir(0);
    result := DlgLoad.ShowModal;
  finally
    DlgLoad.free;
  end;
end;


procedure TDlgLoad.bnStopClick(Sender: TObject);
//*Stop jog
begin
  case DriveClass of
    tdcMint:
      begin
        rollformer.WriteCommsArray('3', '1');
        try
          rollformer.CommsArrayWaitForZero('3');
        except
          on ETimeout do
            ; // MINT will timeout if stop button pressed while jogactive is false
        end;
      end;
    tdcFlex: rollformer.SendCommand('JS#', true); {stop jog}
    tdcVirtual: rollformer.SendVirtualCommand('JOG Stop');
  end;
  setDir(0); // enable cutter only after stop acknowledged
end;

procedure TDlgLoad.bnFwdClick(Sender: TObject);
//*Forward Jog
begin
  setDir(1);
  case DriveClass of
    tdcMint: rollformer.WriteCommsArray('1', '1');
    tdcFlex: rollformer.SendCommand('MF#', true);
    tdcVirtual: rollformer.SendVirtualCommand('JOG Fwd');
  end;
end;

procedure TDlgLoad.bnRevClick(Sender: TObject);
//*Reverse Jog
begin
  setDir(-1);
  case DriveClass of
    tdcMint: rollformer.WriteCommsArray('2', '1');
    tdcFlex: rollformer.SendCommand('MR#', true);
    tdcVirtual: rollformer.SendVirtualCommand('JOG Rev');
  end;
end;

procedure TDlgLoad.CutBtnClick(Sender: TObject);
begin
  rollformer.Cutter;
end;

procedure TDlgLoad.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//*Keyboard routine to stop RF if spaceBar is pressed
begin {check for space bar}
  if (ord(Key)= 32) then
  begin
    if FDir = 0 then
    begin
      case FPrevDir of
        - 1: bnRevClick(nil);
        1: bnFwdClick(nil);
      end
    end
    else
      bnStopClick(nil);
  end;
end;

procedure TDlgLoad.setDir(ADir: integer);
begin
  FDir := ADir;
  if ADir <> 0 then
    FPrevDir := ADir;
  CutBtn.enabled := FDir = 0;
end;

procedure TDlgLoad.bnCloseClick(Sender: TObject);
begin
  if FDir <> 0 then
    bnStopClick(nil);
  modalresult := mrOk;
end;

procedure TDlgLoad.bnExitProgramClick(Sender: TObject);
begin
  if FDir <> 0 then
    bnStopClick(nil);
  modalresult := mrCancel;
end;

end.
