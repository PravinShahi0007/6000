unit PanelWizard;
{
 Item wizard form for Panel members
 2012  - added 'D' type op as double rivets
 2016  - add 'Count='
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, Units;

type
  TPanelWizardForm = class(TForm)
    Label2: TLabel;
    bnOK: TBitBtn;
    BitBtn2: TBitBtn;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    E2pos: TEdit;
    E2Flat: TEdit;
    E2notch: TEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    E1pos: TEdit;
    E1Flat: TEdit;
    E1notch: TEdit;
    DblRivetsCB: TCheckBox;
    Label1: TLabel;
    edCount: TEdit;
    UpDown1: TUpDown;
    procedure bnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function getCount: integer;
  public
    Lines: TStringlist;
    property count: integer read getCount;
  end;

var
  PanelWizardForm: TPanelWizardForm;

implementation

{$R *.dfm}

uses  Usettings, ScotRFTypes;

procedure TPanelWizardForm.bnOKClick(Sender: TObject);
//*Create item text entries in listbox, from the form values
var
  j : integer;
  e1holepos, e2holepos, e1notchsize, e1flatsize, e2flatsize, e2notchsize, itemlen, flatsize, notchsize: real;
  ts1, ts2:string;
  ncope, nnotch: real;

  procedure SortSList;
  //*Sort into operation position order
  var s: integer; swap: boolean; ts:string;
  begin
    repeat
      swap := false;
      if Lines.count > 1 then
      begin
        for s := 0 to Lines.count - 2 do
        begin
          ts1 := Lines[s]; {sort on position of operations}
          delete(ts1, 1, pos(',', ts1)); delete(ts1, 1, pos(',', ts1));
          ts1 := copy(ts1, 1, pos(',', ts1)- 1);
          ts2 := Lines[s + 1];
          delete(ts2, 1, pos(',', ts2)); delete(ts2, 1, pos(',', ts2));
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

begin {make items}
  Lines.Clear;

  itemlen := StrToMM(Edit2.text);
  e1holepos := StrToMM(E1pos.text);
  e1notchsize := StrToMM(E1notch.text);
  e1flatsize := StrToMM(E1Flat.text);
  e2holepos := StrToMM(E2pos.text);
  e2notchsize := StrToMM(E2notch.text);
  e2flatsize := StrToMM(E2Flat.text);
  flatsize := StrToMM(G_Settings.panelrf_flatsize);
  notchsize := StrToMM(G_Settings.panelrf_notchsize);

  ts1 := 'A,1,';
  {end 1 hole}
  if e1holepos > 0 then
  begin
    ts2 := ts1 + UnitsOut(format('%7.2f',[e1holepos]))+ ',H';
    Lines.add(ts2);
    if DblRivetsCB.checked then
    begin
      ts2 := ts1 + UnitsOut(format('%7.2f',[e1holepos]))+ ',D';
      Lines.add(ts2);
    end;
  end; // hole(s)
  {end 1 flats}
  if e1flatsize > 0 then
  begin
    ncope := e1flatsize / flatsize;
    if trunc(ncope)> 0 then
    begin
      for j := 1 to trunc(ncope) do
      begin
        ts2 := ts1 + UnitsOut(format('%7.2f',[(flatsize *(j - 0.5))]))+ ',F'; // flat
        Lines.add(ts2);
      end;
    end;
    if frac(ncope)> 0 then
      Lines.add(ts1 + UnitsOut(format('%7.2f',[(ncope - 0.5)* flatsize]))+ ',F');
  end;
  {end 1 notches}
  if e1notchsize > 0 then
  begin
    nnotch := e1notchsize / notchsize;
    if trunc(nnotch)> 0 then
    begin
      for j := 1 to trunc(nnotch) do
      begin
        ts2 := ts1 + UnitsOut(format('%7.2f',[(notchsize *(j - 0.5))]))+ ',N';
        Lines.add(ts2);
      end;
    end;
    if frac(nnotch)> 0 then
      Lines.add(ts1 + UnitsOut(format('%7.2f',[(nnotch - 0.5)* notchsize]))+ ',N');
  end;
  {end 2 hole}
  if e2holepos > 0 then
  begin
    ts2 := ts1 + UnitsOut(format('%7.2f',[(itemlen - e2holepos)]))+ ',H';
    Lines.add(ts2);
    if DblRivetsCB.checked then
    begin
      ts2 := ts1 + UnitsOut(format('%7.2f',[(itemlen - e2holepos)]))+ ',D';
      Lines.add(ts2);
    end;
  end; //flange hole and liphole ?
  {end 2 flats}
  if e2flatsize > 0 then
  begin
    ncope := e2flatsize / flatsize;
    if trunc(ncope)> 0 then
    begin
      for j := 1 to trunc(ncope) do
      begin
        ts2 := ts1 + UnitsOut(format('%7.2f',[(itemlen - trunc(flatsize *(j - 0.5)))]))+ ',F';
        Lines.add(ts2);
      end;
    end;
    if frac(ncope)> 0 then
      Lines.add(ts1 + UnitsOut(format('%7.2f',[(itemlen - trunc((ncope - 0.5)* flatsize))]))+ ',F');
  end;
  {end 2 notches}
  if e2notchsize > 0 then
  begin
    nnotch := e2notchsize / notchsize;
    if trunc(nnotch)> 0 then
    begin
      for j := 1 to trunc(nnotch) do
      begin
        ts2 := ts1 + UnitsOut(format('%7.2f',[(itemlen - trunc(notchsize *(j - 0.5)))]))+ ',N';
        Lines.add(ts2);
      end;
    end;
    if frac(nnotch)> 0 then
      Lines.add(ts1 + UnitsOut(format('%7.2f',[(itemlen - trunc((nnotch - 0.5)* notchsize))]))+ ',N');
  end;
  ts2 := ts1 + UnitsOut(format('%7.2f',[itemlen]))+ ',C'; Lines.add(ts2);
  SortSList;
end;

procedure TPanelWizardForm.FormCreate(Sender: TObject);
begin
  Lines:= TStringlist.Create;
end;

procedure TPanelWizardForm.FormDestroy(Sender: TObject);
begin
  Lines.Free;
end;

function TPanelWizardForm.getCount: integer;
begin
  result := strtoint(edCount.text);
end;

end.
