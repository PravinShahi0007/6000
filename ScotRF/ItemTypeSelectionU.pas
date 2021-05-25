unit ItemTypeSelectionU;
{
Legacy form to allow users to select a subset of the Panel items for production
Allows multi steel thickness production of individual frames
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, inifiles, FrameDataU, GlobalU;

type
  TTypeSelectform = class(TForm)
    SelectItemsCheckBox: TCheckBox;
    bnOK: TBitBtn;
    bnCancel: TBitBtn;
    ItemsListBox: TListBox;
    procedure bnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    NumSelectedCodes : Integer;
    SelectItemCodes  : Array [1 .. 30] of String[10];
    procedure SetSelections;
    function  SelectedCode(itemcode: string): boolean;
  public
    procedure WriteSelections;
    procedure ReadSelections;
    function  isItemTypeSelected(AFrame: TSteelFrame; anEntityPointer: pEntityRecType): Boolean;
    function  SelectByItems: boolean;
  end;

var
  TypeSelectform: TTypeSelectform;

implementation

{$R *.DFM}

procedure TTypeSelectform.WriteSelections;
var
  anIni: TINIFile;
  i: integer;
begin
  anIni := TINIFile.Create(ExtractFilePath(paramstr(0))+ 'select.ini');
  with anIni do
  begin
    WriteBool('Select', 'Master', SelectItemsCheckBox.Checked);
    For I := 0 to 12 do
      WriteBool('Select', Trim(IntToStr(I)), ItemsListBox.Selected[I]);
  end;
  FreeAndNil(anIni);
end;

procedure TTypeSelectform.ReadSelections;
var
  anIni: TINIFile;
  i: integer;
begin
  anIni := TINIFile.Create(ExtractFilePath(paramstr(0))+ 'select.ini');
  with anIni do
  begin
    SelectItemsCheckBox.checked := ReadBool('Select', 'Master', False);
    for I := 0 to 12 do
      ItemsListBox.Selected[i]:= readbool('Select', Trim(IntToStr(I)), False);
  end;
  FreeAndNil(anIni);
end;

procedure TTypeSelectform.bnOKClick(Sender: TObject);
begin
  SetSelections;
  WriteSelections;
end;

procedure TTypeSelectform.FormCreate(Sender: TObject);
begin
  ReadSelections;
end;

procedure TTypeSelectform.SetSelections;
var
  si : integer;
  i  : word;
  StrSelectedItem : string;
begin
  si := 0;
  Fillchar(SelectItemCodes, Sizeof(SelectItemCodes), 0);
  if not SelectItemsCheckBox.Checked then
    exit;
  for i := 0 to ItemsListBox.items.Count - 1 do
  begin
    if ItemsListBox.selected[i] then
    begin
      inc(si);
      StrSelectedItem :=ItemsListBox.items[i];

      if StrSelectedItem = 'Plate bottom' then
        SelectItemCodes[si] := 'PB';

      if StrSelectedItem = 'Plate top' then
        SelectItemCodes[si] := 'PT';

      if StrSelectedItem = 'Opening studs' then
      begin
        SelectItemCodes[si] := 'SL*';
        inc(si);
        SelectItemCodes[si] := 'SR*';
      end;

      if StrSelectedItem = 'Opening top' then
        SelectItemCodes[si] := 'NT';

      if StrSelectedItem = 'Opening bottom' then
        SelectItemCodes[si] := 'NB';

      if StrSelectedItem = 'Studs' then
      begin
        SelectItemCodes[si] := 'SL';
        inc(si);
        SelectItemCodes[si] := 'SR';
      end;

      if StrSelectedItem = 'Joists' then
      begin
        SelectItemCodes[si] := 'JL';
        inc(si);
        SelectItemCodes[si] := 'JR';
      end;

      if StrSelectedItem = 'Rafters' then
      begin
        SelectItemCodes[si] := 'RL';
        inc(si);
        SelectItemCodes[si] := 'RR';
      end;

      if StrSelectedItem = 'Braces' then
      begin
        SelectItemCodes[si] := 'BL';
        inc(si);
        SelectItemCodes[si] := 'BR';
      end;

      if StrSelectedItem = 'Nogs / Blocking' then
      begin
        SelectItemCodes[si] := 'D0';
        inc(si);
        SelectItemCodes[si] := 'D1';
        inc(si);
        SelectItemCodes[si] := 'D2';
        inc(si);
        SelectItemCodes[si] := 'U0';
      end;

      if StrSelectedItem = 'Perimeters' then
      begin
        SelectItemCodes[si] := 'PL';
        inc(si);
        SelectItemCodes[si] := 'PR';
        inc(si);
        SelectItemCodes[si] := 'PU';
        inc(si);
        SelectItemCodes[si] := 'PD';
      end;

      if StrSelectedItem = 'Web' then
        SelectItemCodes[si] := 'Web';

      if StrSelectedItem = 'Chord' then
        SelectItemCodes[si] := 'Chord';

    end;
  end;
  NumSelectedCodes := si;
end;

function TTypeSelectform.SelectByItems: boolean;
begin
  result := SelectItemsCheckBox.checked;
end;

function TTypeSelectform.SelectedCode(itemcode: string): boolean;
var
  si: integer;
begin
  si := 0;
  if numselectedcodes = 0 then
    result := false
  else
  begin
    repeat
      inc(si);
    until (itemcode = selectitemcodes[si]) or (si = numselectedcodes);
    result := (itemcode = selectitemcodes[si]);
  end;
end;

function TTypeSelectform.isItemTypeSelected(AFrame: TSteelFrame; anEntityPointer: pEntityRecType): Boolean;
begin
  if not SelectItemsCheckBox.Checked then
    exit(true);
{$IFDEF PANEL}
  if (pos('*', anEntityPointer.item) = 3) then
    Exit ( SelectedCode(copy(anEntityPointer.item, 1, 3)))
  else
    EXIT( SelectedCode(copy(anEntityPointer.item, 1, 2)));
{$ELSE}// trusses
   EXIT( SelectedCode(anEntityPointer.itype));
{$ENDIF}
end;
end.
