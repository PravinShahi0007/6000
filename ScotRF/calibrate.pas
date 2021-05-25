unit calibrate;

interface

uses
  Windows, SysUtils, Controls, Forms, Dialogs, WinUtils,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, Classes, Menus;

type
  TCalibrateForm = class(TForm)
    Label1: TLabel;
    edCalibration: TEdit;
    Panel2: TPanel;
    Label3: TLabel;
    edTarget: TEdit;
    Label4: TLabel;
    edMeasured: TEdit;
    bnUpdate: TBitBtn;
    bnTrussLength: TSpeedButton;
    ExitBtn: TSpeedButton;
    bnReset: TBitBtn;
    ResetPopupMenu: TPopupMenu;
    mi5000PulseEncoder: TMenuItem;
    mi1000PulseEncoder: TMenuItem;
    miFlexEncoderResolver: TMenuItem;
    bnPanelLength: TSpeedButton;
    bnApply: TBitBtn;
    procedure ExitBtnClick(Sender: TObject);
    procedure bnResetMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure mi5000PulseEncoderClick(Sender: TObject);
    procedure mi1000PulseEncoderClick(Sender: TObject);
    procedure miFlexEncoderResolverClick(Sender: TObject);
    procedure bnUpdateClick(Sender: TObject);
    procedure edTargetChange(Sender: TObject);
    procedure bnTrussLengthClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edCalibrationChange(Sender: TObject);
    procedure bnApplyClick(Sender: TObject);
  private
    procedure DoCalibrate;
    procedure ReadMachineCalibration;
    procedure SetCalibrationEdit(AValue: double);
    function getMeasured: double;
    function getTarget: double;
    procedure DoUpdate;
    property Target: double read getTarget;
    property Measured: double read getMeasured;
  public
    class function Exec(bEnableLength: boolean=true): boolean;
  end;

implementation

uses Usettings, CardAdapterU, ScotRFTypes, Units, RollformerU, UnitScotTruss, Com_Exception;

{$R *.DFM}

class function TCalibrateForm.Exec(bEnableLength: boolean): boolean;
var
  CalibrateForm: TCalibrateForm;
begin
    CalibrateForm := TCalibrateForm.Create(nil);
    try
      CalibrateForm.bnTrussLength.Enabled := bEnableLength;
      CalibrateForm.bnPanelLength.Enabled := bEnableLength;
      CalibrateForm.ReadMachineCalibration;
      CalibrateForm.ShowModal;
    finally
      CalibrateForm.Free;
    end;
  result := True;
end;

procedure TCalibrateForm.ReadMachineCalibration;
begin
  case DriveClass of
    tdcMint:
      {Mint Rfs}
      begin
        rollformer.writecommsarray('12', '1');
        repeat
          if not rollformer.Readcommsarray('12', false) then
            raise exception.Create('Calibration Read Error');
        until rollformer.commdata = '0';
        rollformer.Readcommsarray('13', True);
        SetCalibrationEdit(strtofloat(rollformer.commdata));
      end;
    tdcFlex:
      begin
        if rollformer.SendCommand('PP#', True) and rollformer.CommandCompleted then
        begin
          if ReceivedStrings <> '' then
          begin
            if ReceivedStrings[1]= '*' then
              delete(ReceivedStrings, 1, 1);
            if ReceivedStrings[1]= '0' then
              repeat
                delete(ReceivedStrings, 1, 1)
              until ReceivedStrings[1] <> '0';
              if length(ReceivedStrings)< 2 then
                ReceivedStrings := '1#';
          end;
          edCalibration.text := copy(ReceivedStrings, 1, length(ReceivedStrings)- 1);
        end;
      end;
  end;
end;


function TCalibrateForm.getMeasured: double;
begin
  try
    result := StrToMM(edMeasured.text);
  except
    result := 0;
  end;
end;

function TCalibrateForm.getTarget: double;
begin
  try
    result := StrToMM(edTarget.text);
  except
    result := 0;
  end;
end;

procedure TCalibrateForm.bnTrussLengthClick(Sender: TObject);
begin
  rollformer.MakeLength(Target, True);
end;

procedure TCalibrateForm.bnResetMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
begin
  p := point(X, Y);
  p := (Sender as TControl).ClientToScreen(p);
  ResetPopupMenu.Popup(p.X, p.Y);
end;

procedure TCalibrateForm.ExitBtnClick(Sender: TObject);
begin
  close;
end;

procedure TCalibrateForm.FormCreate(Sender: TObject);
begin
{$ifdef panel}
  bnPanelLength.BoundsRect:=bnTrussLength.BoundsRect ;
  bnPanelLength.Visible :=true;
  bnTrussLength.Visible := false;
{$endif}
end;

procedure TCalibrateForm.SetCalibrationEdit(AValue: double);
begin
  edCalibration.text := format('%8.4f',[AValue]);
end;

procedure TCalibrateForm.mi1000PulseEncoderClick(Sender: TObject);
begin
  SetCalibrationEdit(158);
  edMeasured.text := '';
  DoCalibrate;
end;

procedure TCalibrateForm.mi5000PulseEncoderClick(Sender: TObject);
begin
  SetCalibrationEdit(790);
  edMeasured.text := '';
  DoCalibrate;
end;

procedure TCalibrateForm.miFlexEncoderResolverClick(Sender: TObject);
begin
  SetCalibrationEdit(7.9);
  edMeasured.text := '';
  DoCalibrate;
end;

procedure TCalibrateForm.bnApplyClick(Sender: TObject);
var z: double;
begin
  edMeasured.text := '';
  z := strToFloatDef(edCalibration.Text ,0);
  if z>0 then
    DoCalibrate
  else
    messagedlg('Invalid setting', mtwarning, [mbok],0);
end;

procedure TCalibrateForm.bnUpdateClick(Sender: TObject);
begin
  try
    DoUpdate;
  except
    on E: Exception do
      HandleException(e,'TCalibrateForm.bnUpdateClick',[]);
  end;
end;

procedure TCalibrateForm.DoUpdate;
var
  V, Multiplier: double;
begin
  Check(Target <> 0, 'Invalid target');
  Check(Measured <> 0, 'Invalid measure');
  Multiplier := Target / Measured;
  if (Multiplier> 1.1) or (Multiplier<0.9) then
    if messagedlg('Calibration change exceeds 10%.'#10'Are you sure?', mtConfirmation, mbYesNo, 0) <> mrYes then
      exit;
  V := strToFloatDef(edCalibration.text, 0);
  Check(V > 0, 'No Calibration Value');
  SetCalibrationEdit(V * Multiplier);
  DoCalibrate;
  edMeasured.text := '';
end;

procedure TCalibrateForm.DoCalibrate;
// send calibration (EncPCm) value using screen value
var
  V: double;
begin
  V := strToFloatDef(edCalibration.text, 0);
  Check(V > 0, 'No Calibration Value');
  rollformer.calibrate(V);
  messagedlg('Calibration factor has been set to '+floatToStr(V), mtInformation, [mbOK],0);
end;

procedure TCalibrateForm.edCalibrationChange(Sender: TObject);
begin
bnApply.Enabled:=true;
end;

procedure TCalibrateForm.edTargetChange(Sender: TObject);
begin
  bnUpdate.Enabled := (Target <> 0) and (Measured <> 0);
end;

end.
