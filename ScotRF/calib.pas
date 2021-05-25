unit calib;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Buttons;

type
  TCalibform = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    UpDown1: TUpDown;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel1: TPanel;
    Label3: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Calibform: TCalibform;

implementation

uses Unit1, Usettings, Com_Exception, ScotRFTypes;
{$R *.DFM}

function Emperial2Metric(es: string): string;
// *Performs the imperial to metric conversion
// *Returns a string of the mm
var
  ftpos, i, fracpos, spcpos, feet, inches, numerator, denominator, neg: integer;
begin
  neg := 1;
  result := '0';
  feet := 0;
  inches := 0;
  denominator := 1;
  numerator := 1;
  try
    for i := 1 to length(es) do
      if es[i] = '"' then
        es[i] := ' ';
    es := trim(es);
    neg := 1;
    if es[1] = '-' then
    begin
      neg := -1;
      delete(es, 1, 1);
    end
    else
      neg := 1;
    inches := 0;
    feet := 0;
    numerator := 0;
    denominator := 1;
    ftpos := pos(ansichar(39), es);
    if ftpos > 0 then
    begin
      feet := strtoint(copy(es, 1, ftpos - 1));
      delete(es, 1, ftpos);
    end;
    es := trim(es);
    spcpos := pos(' ', es);
    fracpos := pos(ansichar(47), es);
    if (spcpos = 0) and (fracpos = 0) and (length(es) > 0) then
      inches := strtoint(es);
    if (spcpos > 0) and (fracpos > 0) then
    begin
      inches := strtoint(copy(es, 1, spcpos - 1));
      delete(es, 1, spcpos);
    end;
    fracpos := pos(ansichar(47), es);
    if fracpos > 0 then
    begin
      numerator := strtoint(copy(es, 1, fracpos - 1));
      denominator := strtoint(copy(es, fracpos + 1, 4));
    end;
  except
    on E: Exception do
      HandleException(e,'Emperial2Metric',[]);
  end;
  result := inttostr(neg * round(feet * 12 * 25.4 + inches * 25.4 + (numerator / denominator * 25.4)));
end;

function FracInch(f: real): string;
// *Function that return a fraction string of 16ths, with SCD
var
  sixteenths: byte;
begin
  sixteenths := round(f * 16);
  if sixteenths = 16 then
    FracInch := '1'
  else
    case sixteenths of
      1:
        FracInch := '1/16';
      2:
        FracInch := '1/8';
      3:
        FracInch := '3/16';
      4:
        FracInch := '1/4';
      5:
        FracInch := '5/16';
      6:
        FracInch := '3/8';
      7:
        FracInch := '7/16';
      8:
        FracInch := '1/2';
      9:
        FracInch := '9/16';
      10:
        FracInch := '5/8';
      11:
        FracInch := '11/16';
      12:
        FracInch := '3/4';
      13:
        FracInch := '13/16';
      14:
        FracInch := '7/8';
      15:
        FracInch := '15/16';
    end;
end;

function Metric2Emperial(mms: string; inchonly: boolean): string;
// *Function that converts mm to feet, inches & 1/16ths
var
  emperials, fracs, negs: string;
  inches, feet, mm: longint;
  remain: real;
  neg: boolean;
begin
  result := '0';
  if mms = '' then
    system.exit;
  try
    mm := strtoint(mms);
    neg := mm < 0;
    if neg then
      negs := '-'
    else
      negs := '';
    mm := abs(mm);
    inches := trunc(mm / 25.4);
    remain := mm - inches * 25.4;
    fracs := trim(FracInch(remain / 25.4));
    if fracs = '1' then
    begin
      inc(inches);
      fracs := '';
    end;
    if inchonly then
      if inches = 0 then
        emperials := fracs
      else
        emperials := inttostr(inches) + ' ' + fracs
      else
      begin
        emperials := '';
        feet := inches div 12;
        if feet <> 0 then
          emperials := inttostr(feet) + ansichar(39);
        if (inches - feet * 12) > 0 then
          emperials := emperials + ' ' + inttostr(inches - feet * 12);
        if fracs <> '' then
          emperials := emperials + ' ' + fracs;
      end;
    result := negs + emperials;
    if result = '' then
      result := '0';
  except
    on E: Exception do
      HandleException(e,'Metric2Emperial',[]);
  end;
end;

function CnvrtIn(s: string): string;
// *Converts imperial to metric strings
begin
  if G_Settings.general_metric  then
    CnvrtIn := s
  else
    CnvrtIn := Emperial2Metric(s);
end;

function CnvrtOut(s: string): string;
// *Converts metric to imperial strings
begin
  if G_Settings.general_metric  then
    CnvrtOut := s
  else
    CnvrtOut := Metric2Emperial(s, false);
end;

procedure TCalibform.BitBtn2Click(Sender: TObject);
begin
  if (Edit2.text <> '') and (strtoint(Edit2.text) > 0) then
  begin
    form1.calibrating := true;
    Label3.caption := 'Running';
  end
  else
    showmessage('Frequency error!');
end;

procedure TCalibform.BitBtn3Click(Sender: TObject);
begin
  form1.calibrating := false;
  Label3.caption := 'Stopped';
end;

procedure TCalibform.FormShow(Sender: TObject);
begin
  Edit1.text := CnvrtOut(inttostr(form1.caliblengthlimit));
  Edit2.text := inttostr(form1.calibfreq);
end;

procedure TCalibform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.caliblengthlimit := strtoint(CnvrtIn(Edit1.text));
  form1.calibfreq := strtoint(Edit2.text);
end;

end.
