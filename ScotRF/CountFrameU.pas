unit CountFrameU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ScotRFTypes, RollformerU;

type
  TCounterFrame = class(TFrame)
    uxCaption: TLabel;
    uxCount: TEdit;
    uxWarning: TEdit;
    bnReset: TSpeedButton;
    procedure bnResetClick(Sender: TObject);
  private
    function opCode: TOperationProcess;
  public
    procedure UpdateUxCounters;
    procedure UpdateCounters;
  end;

implementation

{$R *.dfm}

{ TCounterFrame }

function TCounterFrame.opCode: TOperationProcess;
begin
  result := TOperationProcess(Tag);
end;

function ConfirmReset: boolean;
begin
  result := MessageDlg('Do you really want to reset the counter ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

procedure TCounterFrame.bnResetClick(Sender: TObject);
var
  counter: TCounter;
begin
  counter := Rollformer.Counters[opCode];
  if counter=nil then
   Exit;
  if ConfirmReset then
  begin
    counter.Value := 0;
    uxCount.text := '0';
    Rollformer.setMintValue(TMintValue(counter.MintNumber), 0);
  end;
end;

procedure TCounterFrame.UpdateUxCounters;
var
  counter: TCounter;
begin
  counter := Rollformer.Counters[opCode];
  if counter=nil then
   Exit;
  uxCaption.caption := counter.longname;
  uxCount.text := IntToStr(counter.Value);
  uxWarning.text := IntToStr(counter.OpLimit);
  if counter.LimitExceeded then
    uxCount.Font.color := clRed
  else
    uxCount.Font.color := clBlack;
end;

procedure TCounterFrame.UpdateCounters;
var
  counter: TCounter;
begin
  counter := Rollformer.Counters[opCode];
  if counter=nil then
   Exit;
  counter.Value := strToIntDef(uxCount.text, 0);
  counter.OpLimit := strToIntDef(uxWarning.text, 0);
end;

end.
