unit TrussManual;

{
 Manual Truss RF operation form
 Allows users to Load, make blank lengths & operate tool functions
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, CardAdapterU, GlobalU, ScotRFTypes;

type
  TTrussManualForm = class(TForm)
    CutBtn: TSpeedButton;
    CopeBtn: TSpeedButton;
    NotchBtn: TSpeedButton;
    LipHoleBtn: TSpeedButton;
    FlangeHoleBtn: TSpeedButton;
    BoxHoleBtn: TSpeedButton;
    ExitBtn: TSpeedButton;
    LoadBtn: TSpeedButton;
    SwageBtn: TSpeedButton;
    procedure CutBtnClick(Sender: TObject);
    procedure CopeBtnClick(Sender: TObject);
    procedure NotchBtnClick(Sender: TObject);
    procedure LengthBtnClick(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure LipHoleBtnClick(Sender: TObject);
    procedure FlangeHoleBtnClick(Sender: TObject);
    procedure BoxHoleBtnClick(Sender: TObject);
    procedure SwageBtnClick(Sender: TObject);
  private
    FBox: Boolean;
    procedure Init(ABox: boolean);
  public
    class function Exec(ABox: boolean): integer;

  end;


implementation

uses   LoadSteelU, units, Usettings , RollformerU;
{$R *.DFM}

class function TTrussManualForm.Exec(ABox: boolean): integer;
var
  TrussManualForm: TTrussManualForm;
begin
  TrussManualForm:= TTrussManualForm.Create(nil);
  try
    TrussManualForm.Init(ABox);
    result := TrussManualForm.showModal;
  finally
    TrussManualForm.free;
  end;
end;

procedure TTrussManualForm.CutBtnClick(Sender: TObject);
//*Operate cut
begin Rollformer.Cutter;
end;

procedure TTrussManualForm.BoxHoleBtnClick(Sender: TObject);
begin
  Rollformer.LPunch;
end;

procedure TTrussManualForm.CopeBtnClick(Sender: TObject);
//*Operate cope
begin
  Rollformer.Cope;
end;

procedure TTrussManualForm.NotchBtnClick(Sender: TObject);
//*Operate notch
begin
  Rollformer.Notch;
end;

procedure TTrussManualForm.SwageBtnClick(Sender: TObject);
begin
  Rollformer.Swage;
end;

procedure TTrussManualForm.LengthBtnClick(Sender: TObject);
begin
//  if (DlgMove.showModal = mrOK) then
//    Rollformer.MakeLength(DlgMove.Length,false);
end;

procedure TTrussManualForm.ExitBtnClick(Sender: TObject);
//* Exit form. Stop if loading
begin
  Rollformer.stopnow := true;
  Close;
end;

procedure TTrussManualForm.LoadBtnClick(Sender: TObject);
//*Display load (jog) form
begin
  TDlgLoad.Exec(false); {unit9}
end;

procedure TTrussManualForm.LipHoleBtnClick(Sender: TObject);
//*Operate Lip punch
begin
  Rollformer.LPunch;
end;

procedure TTrussManualForm.FlangeHoleBtnClick(Sender: TObject);
//*Operate Flange punch
begin
  Rollformer.FPunch;
end;

procedure TTrussManualForm.Init(ABox: boolean);
begin
  FBox := ABox;
  if ABox then
  begin
    caption := 'Box RF manual operation';
    CutBtn.Visible := true;
    BoxHoleBtn.Visible := true;
    NotchBtn.Visible := false;
    CopeBtn.Visible := false;
    LipHoleBtn.Visible := false;
    FlangeHoleBtn.Visible := false;
    ExitBtn.Visible := true;
  end
  else
  begin
    caption := 'Local RF manual operation';
    CutBtn.Visible := true;
    BoxHoleBtn.Visible := false;
    NotchBtn.Visible := true;
    CopeBtn.Visible := true;
    LipHoleBtn.Visible := true;
    FlangeHoleBtn.Visible := true;
    ExitBtn.Visible := true;
  end;
  SwageBtn.Visible := G_Settings.general_machinetype='75MMTRUSS';
  // move other buttons to left, so Exit is on right end.
  FlangeHoleBtn.Left := 0;
  LipHoleBtn.Left := 0;
  CopeBtn.Left := 0;
  NotchBtn.Left := 0;
  BoxHoleBtn.Left := 0;
  CutBtn.Left := 0;

end;

END.
