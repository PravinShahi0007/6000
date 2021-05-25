unit spdUnit;
{
 Legacy motor speed form for setting motor performance, in early panel RFs
 with Flex+ drives & BL1600 boards
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,rollformerU, Dialogs,
  StdCtrls, Buttons, ComCtrls;

type
  TSpeedForm = class(TForm)
    UpDown1: TUpDown;
    Edit1: TEdit;
    bnSetSpeed: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    StatusBar1: TStatusBar;
    procedure bnSetSpeedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
    class procedure Exec; static;
  end;

implementation

{$R *.DFM}

procedure TSpeedForm.bnSetSpeedClick(Sender: TObject);
begin
  if length(Edit1.text)= 4 then
  begin
    rollformer.SendCommand('SP' + Edit1.text + '#', true);
    rollformer.SendCommand('AC' + Edit2.text + '#', true);
  end;
  close;
end;

class procedure TSpeedForm.Exec;var
  SpeedForm: TSpeedForm;
begin
  SpeedForm:= TSpeedForm.Create(application);
  try
    SpeedForm.ShowModal ;
  finally
    SpeedForm.Free;
  end;
end;

procedure TSpeedForm.FormShow(Sender: TObject);
var
  ts, rs: ansistring;
  p: integer;
begin {get current RF motor settings}
  rs := '';
  rollformer.stopnow := false;
  if Rollformer.SendCommand('RP#', true) and
     (rs <> '') then
  begin
    statusbar1.SimpleText := rs;
    if rs[1]= '*' then
      delete(rs, 1, 1); {sc:gc:nc:pc#}
    ts := rs;
    p := pos(':', ts);
    Edit1.text := copy(ts, 1, p - 1);
    delete(ts, 1, p);
    Edit2.text := copy(ts, 1, length(ts)- 1);
  end;
end;

end.
