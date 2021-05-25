unit itemwizard;

{
 Item wizard form for Truss members
 2011 Aug - PG modified for 1dp accuracy in positions & sizes
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, units, inifiles;

type
  TItemwizardform = class(TForm)
    bnOk: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    E1lippos: TEdit;
    E1flgpos: TEdit;
    E1cope: TEdit;
    E1notch: TEdit;
    E2lippos: TEdit;
    E2flgpos: TEdit;
    E2cope: TEdit;
    E2notch: TEdit;
    BoxWebcBox: TCheckBox;
    Label1: TLabel;
    edCount: TEdit;
    UpDown1: TUpDown;
    procedure bnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function getCount: integer;
  public
    Lines: TStringlist;
    property count: integer read getCount;
  end;

var
  Itemwizardform: TItemwizardform;

implementation

uses Usettings, items, ScotRFTypes;
{$R *.DFM}

procedure TItemwizardform.bnOkClick(Sender: TObject);
//*Create item list form wizard parameters
var
  j: integer;
  e1lipholepos, e2lipholepos, e1flgholepos, e2flgholepos, e1notchsize, e1copesize, e2copesize, e2notchsize, itemlen, copesize, notchsize: real;
  ts1, ts2:string;
  ncope, nnotch: real;

  procedure SortSList;
  //*Sorts by operation position in member - bubble sort
  var s: integer; swap: boolean; ts:string;
  begin
    repeat
      swap := false;
      if Lines.count > 1 then
      begin
        for s := 0 to Lines.count - 2 do
        begin
          ts1 := Lines[s]; {sort on position of operations}
          delete(ts1, 1, pos(',', ts1));
          delete(ts1, 1, pos(',', ts1));
          ts1 := copy(ts1, 1, pos(',', ts1)- 1);
          ts2 := Lines[s + 1];
          delete(ts2, 1, pos(',', ts2));
          delete(ts2, 1, pos(',', ts2));
          ts2 := copy(ts2, 1, pos(',', ts2)- 1);
          if StrToMM(ts1) > StrToMM(ts2) then
          begin
            ts := Lines[s];
            Lines[s] := Lines[s + 1];
            Lines[s + 1]:= ts;
            swap := true;
          end;
        end;
      end;
    until not swap;
  end;

begin
  //* make items
  Lines.Clear;
  //* convert to metric
  itemlen := StrToMM(Edit2.text);
  e1lipholepos := StrToMM(E1lippos.text);
  e1flgholepos := StrToMM(E1flgpos.text);
  e1notchsize := StrToMM(E1notch.text);
  e1copesize := StrToMM(E1cope.text);
  e2lipholepos := StrToMM(E2lippos.text);
  e2flgholepos := StrToMM(E2flgpos.text);
  e2notchsize := StrToMM(E2notch.text);
  e2copesize := StrToMM(E2cope.text);
  copesize := StrToMM(G_Settings.trussrf_copesize);
  notchsize := StrToMM(G_Settings.trussrf_notchsize);

  ts1 := 'A,1,'; // op no.
  {end 1 hole}

  if e1lipholepos > 0 then
  begin
    ts2 := ts1 + UnitsOut(format('%7.2f',[e1lipholepos]))+ ',L';
    Lines.add(ts2);
  end;
  if e1flgholepos > 0 then
  begin
    ts2 := ts1 + UnitsOut(format('%7.2f',[e1flgholepos]))+ ',F';
    Lines.add(ts2);
  end;
  {end 1 copes}
  if e1copesize > 0 then
  begin
    ncope := e1copesize / copesize;
    if trunc(ncope)> 0 then
      for j := 1 to trunc(ncope) do
      begin
        ts2 := ts1 + UnitsOut(format('%7.2f',[(copesize *(j - 0.5))]))+ ',P';
        Lines.add(ts2);
      end;
    if frac(ncope)> 0 then
      Lines.add(ts1 + UnitsOut(format('%7.2f',[(ncope - 0.5)* copesize]))+ ',P');
  end;
  {end 1 notches}
  if e1notchsize > 0 then
  begin
    nnotch := e1notchsize / notchsize;
    if trunc(nnotch)> 0 then
      for j := 1 to trunc(nnotch) do
      begin
        ts2 := ts1 + UnitsOut(format('%7.2f',[(notchsize *(j - 0.5))]))+ ',N';
        Lines.add(ts2);
      end;
    if frac(nnotch)> 0 then
      Lines.add(ts1 + UnitsOut(format('%7.2f',[(nnotch - 0.5)* notchsize]))+ ',N');
  end;
  {end 2 hole}
  if e2lipholepos > 0 then
  begin
    ts2 := ts1 + UnitsOut(format('%7.2f',[itemlen - e2lipholepos]))+ ',L';
    Lines.add(ts2);
  end;
  if e2flgholepos > 0 then
  begin
    ts2 := ts1 + UnitsOut(format('%7.2f',[itemlen - e2flgholepos]))+ ',F';
    Lines.add(ts2);
  end;
  {end 2 copes}
  if e2copesize > 0 then
  begin
    ncope := e2copesize / copesize;
    if trunc(ncope)> 0 then
      for j := 1 to trunc(ncope) do
      begin
        ts2 := ts1 + UnitsOut(format('%7.2f',[itemlen - trunc(copesize *(j - 0.5))]))+ ',P';
        Lines.add(ts2);
      end;
    if frac(ncope)> 0 then
      Lines.add(ts1 + format('%7.2f',[itemlen -(ncope - 0.5)* copesize])+ ',P');
  end;
  {end 2 notches}
  if e2notchsize > 0 then
  begin
    nnotch := e2notchsize / notchsize;
    if trunc(nnotch)> 0 then
      for j := 1 to trunc(nnotch) do
      begin
        ts2 := ts1 + UnitsOut(format('%7.2f',[itemlen - trunc(notchsize *(j - 0.5))]))+ ',N';
        Lines.add(ts2);
      end;
    if frac(nnotch)> 0 then
      Lines.add(ts1 + UnitsOut(format('%7.2f',[(nnotch - 0.5)* notchsize]))+ ',N');
  end;
  ts2 := ts1 + UnitsOut(format('%7.2f',[itemlen]))+ ',C';
  Lines.add(ts2);
  SortSList;
end;

procedure TItemwizardform.FormClose(Sender: TObject; var Action: TCloseAction);
//*write initial settings from ini file
var inifile: tinifile;
begin
  inifile := tinifile.Create(extractfilepath(paramstr(0))+ 'RFwizard.ini');
  {  code not used
    with inifile do
    begin
    writestring('general','hole',holeposedit.text);
    writestring('general','notch',notchposedit.text);
    end;
    }
  inifile.free;
end;

procedure TItemwizardform.FormCreate(Sender: TObject);
begin
  Lines:= TStringlist.create;
end;

procedure TItemwizardform.FormDestroy(Sender: TObject);
begin
  Lines.Free;
end;

procedure TItemwizardform.FormShow(Sender: TObject);
var inifile: tinifile;
  //*Read parameters from ini file
begin
  inifile := tinifile.Create(extractfilepath(paramstr(0))+ 'RFwizard.ini');
  with inifile do
  begin
    { code not used
      holeposedit.text:=readstring('general','hole','0');
      notchposedit.text:=readstring('general','notch','0');
      }
    inifile.free;
  end;
end;

function TItemwizardform.getCount: integer;
begin
  result := strtoint(edCount.text);
end;

end.
