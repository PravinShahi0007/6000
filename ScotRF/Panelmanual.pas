unit Panelmanual;

{
 Manual operation form for panel RFs
 Allows users to load RF, run blank lengths (calibration) and
 operate tool features.
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,ScotRFTypes;

type
  TPanelManualForm = class(TForm)
    CutBtn: TSpeedButton;
    PunchBtn: TSpeedButton;
    NotchBtn: TSpeedButton;
    FlatBtn: TSpeedButton;
    Service1Btn: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SwageBtn: TSpeedButton;
    Service2Btn: TSpeedButton;
    DblPunchBtn: TSpeedButton;
    bnEndBearing: TSpeedButton;
    LoadBtn: TSpeedButton;
    procedure CutBtnClick(Sender: TObject);
    procedure PunchBtnClick(Sender: TObject);
    procedure NotchBtnClick(Sender: TObject);
    procedure FlatBtnClick(Sender: TObject);
    procedure Service1BtnClick(Sender: TObject);
    procedure LengthBtnClick(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure SwageBtnClick(Sender: TObject);
    procedure Service2BtnClick(Sender: TObject);
    procedure DblPunchBtnClick(Sender: TObject);
    procedure bnEndBearingClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  public
    class function Exec: integer;
  end;

implementation

uses  LoadSteelU, units, Usettings, cardU, RollformerU;
{$R *.DFM}

class function TPanelManualForm.Exec: integer;
var
  PanelManualForm: TPanelManualForm;
begin
  PanelManualForm := TPanelManualForm.Create(nil);
  try
    PanelManualForm.autosize := true;
    PanelManualForm.bnEndBearing.visible := formSettings.MachineType=mtPanelHD;
    result := PanelManualForm.showModal;
  finally
    PanelManualForm.free;
  end;
end;

procedure TPanelManualForm.bnEndBearingClick(Sender: TObject);
begin
  Rollformer.EndBearingNotch
end;

procedure TPanelManualForm.CutBtnClick(Sender: TObject);
//*Operate Cut
begin
  Rollformer.Cutter;
end;

procedure TPanelManualForm.PunchBtnClick(Sender: TObject);
//*Operate Punch on panels
begin
  Rollformer.FPunch;
end;

procedure TPanelManualForm.NotchBtnClick(Sender: TObject);
//*Operate Notch
begin
  Rollformer.Notch;
end;

procedure TPanelManualForm.DblPunchBtnClick(Sender: TObject);
begin
  Rollformer.LPunch;
end;

procedure TPanelManualForm.FlatBtnClick(Sender: TObject);
//*Operate Flattener
begin
  Rollformer.Flat;
end;

procedure TPanelManualForm.FormShow(Sender: TObject);
begin
  DblPunchBtn.Visible := NOT G_Settings.IsSingleRivet;
end;

procedure TPanelManualForm.Service1BtnClick(Sender: TObject);
//*Operate Small service hole
begin
  Rollformer.Service1;
end;

procedure TPanelManualForm.LengthBtnClick(Sender: TObject);
begin
//  if (DlgMove.showModal = mrOK) then
//    Rollformer.MakeLength(DlgMove.Length,false);
end;
procedure TPanelManualForm.SpeedButton6Click(Sender: TObject);
//*Exit toolbar. Stop load if in progress
begin
  Rollformer.stopnow := true;
  Close;
end;

procedure TPanelManualForm.LoadBtnClick(Sender: TObject);
//*display screen to load (jog) material
begin
  TDlgLoad.Exec(false);
end;

procedure TPanelManualForm.SwageBtnClick(Sender: TObject);
//*Operate Swage
begin
  if FormSettings.Useswagecbox.checked then
    Rollformer.Swage;
end;

procedure TPanelManualForm.Service2BtnClick(Sender: TObject);
//*Operate Large service hole (plumbing tool)
begin
  Rollformer.Service2;
end;

end.
