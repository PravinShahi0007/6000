unit AddOpFormU;

interface

uses
  Windows, Messages, SysUtils,
  Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls,
  GlobalU,
  Buttons, ComCtrls;

type
  TfrmAddOperation = class(TForm)
    gpOperation: TGroupBox;
    radCope: TRadioButton;
    radNotch: TRadioButton;
    radSmallServiceHole: TRadioButton;
    radLargeServiceHole: TRadioButton;
    radSwage: TRadioButton;
    radSlot: TRadioButton;
    radLipHole: TRadioButton;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    txtDistance: TEdit;
    Label1: TLabel;
    btnAdd: TButton;
    lvOperations: TListView;
    btnRemove: TButton;
    BalloonHint1: TBalloonHint;
    radFlgHole: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure txtDistanceChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure lvOperationsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvOperationsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnRemoveClick(Sender: TObject);
    procedure lvOperationsColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvOperationsCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private    { Private declarations }
    procedure LoadRadioBtnTags;

  public     { Public declarations }
    function SelectedOperation: TOpKind;
  end;

  function OpToString(AOp: OpType): string;
  function StringToOpType(s: string): TOpKind;

var
  frmAddOperation: TfrmAddOperation;

implementation

uses TranslateU;

{$R *.dfm}

function OpToString(AOp: OpType): string;
begin
  Result := '';
  case AOp.Kind of
    okCT:      Result := 'CT';
    okIns:     Result := 'Insert';
    okCope:    Result := 'Cope';
    okNotch:   Result := 'Notch';
    okCon1:    Result := 'Con1';
    okTek:     Result := 'Tek';    //total Teks = Tek * 2 (i.e. teks is teks per side)
    okTek2:    Result := 'Tek 2';
    okTek4:    Result := 'Tek 4';
    okScr:     Result := 'Scr';
    okScb:     Result := 'Scb';
    okBrA:     Result := 'BA';
    okBrB:     Result := 'BB';
    okBrC:     Result := 'BC';
    okBrace:   Result := 'BRACE';
    okPC:      Result := 'PC';
    okServ1:   Result := 'S1';
    okServ2:   Result := 'S2';
    okSwage:   Result := 'Swage';
    okSlot:    Result := 'Slot';
    okLipHole: Result := 'LipH';
    okFlgHole: Result := 'FlgH';
    ok2Rivet:  Result := '2R';
    ok4Rivet:  Result := '4R';
    ok2Rivet2Tek: Result := '2R+2T';
    ok2Rivet4Tek: Result := '2R+4T';
    //okEndLoadCut: Result := 'Cut';  // using okSlot
  end;
  case AOp.Kind of
    okScr,
    okScb,
    okBrA,
    okBrB,
    okBrC:   if AOp.Num < 10 then
               Result := Result + '0' + IntToStr(AOp.Num)
             else
               Result := Result + IntToStr(AOp.Num);
    okPC:    Result := Result + format('%.3f', [AOp.Num / 1000]);
  end;
end;

function StringToOpType(s: string): TOpKind;
begin
  Result := okNone;
  s := Trim( s );
  if SameText(s, 'CT')then begin Result:=okCT; exit; end;
  if SameText(s, 'Insert')then begin Result:=okIns; exit; end;
  if SameText(s, 'Cope')then begin Result:=okCope; exit; end;
  if SameText(s, 'Notch')then begin Result:=okNotch; exit; end;
  if SameText(s, 'Con1')then begin Result:=okCon1; exit; end;
  if SameText(s, 'Tek')then begin Result:=okTek; exit; end;
  if SameText(s, 'Tek 2')then begin Result:=okTek2; exit; end;
  if SameText(s, 'Tek 4')then begin Result:=okTek4; exit; end;
  if SameText(s, 'Scr02')then begin Result:=okScb; exit; end; //TP changed this from 'Scb'
  if SameText(s, 'Brace')then begin Result:=okBrace; exit; end;
  if SameText(s, 'S1')then begin Result:=okServ1; exit; end;
  if SameText(s, 'S2')then begin Result:=okServ2; exit; end;
  if SameText(s, 'Swage')then begin Result:=okSwage; exit; end;
  if SameText(s, 'Slot')then begin Result:=okSlot; exit; end;
  if SameText(s, 'LipH')then begin Result:=okLipHole; exit; end;
  if SameText(s, 'FlgH')then begin Result:=okFlgHole; exit; end;

  // C-Section ops, not used yet
  if SameText(s, '2R')then begin Result:=ok2Rivet; exit; end;
  if SameText(s, '4R')then begin Result:=ok4Rivet; exit; end;
  if SameText(s, '2R+2T')then begin Result:=ok2Rivet2Tek; exit; end;
  if SameText(s, '2R+4T')then begin Result:=ok2Rivet4Tek; exit; end;

  //if SameText(s, 'Cut')then begin Result:=okEndLoadCut; exit; end;  //using okSlot

  //Next ones can also have a Num, so get the starting chars only
  s := copy(s, 1, 3);
  if SameText(s, 'Scr')then begin Result:=okScr; exit; end;
  if SameText(s, 'Scb')then begin Result:=okScb; exit; end;
  s := copy(s, 1, 2);
  if SameText(s, 'BA')then begin Result:=okBrA; exit; end;
  if SameText(s, 'BB')then begin Result:=okBrB; exit; end;
  if SameText(s, 'BC')then begin Result:=okBrC; exit; end;
  if SameText(s, 'PC')then Result:=okPC;
end;

{ TfrmAddOperation }

procedure TfrmAddOperation.btnAddClick(Sender: TObject);
var
  AItem: TListItem;
  AOp: OpType;
begin
  AItem := lvOperations.Items.Add;
  AOp.Num := 0;
  AOp.Kind := SelectedOperation;

  AItem.Caption := OpToString(AOp);
  AItem.SubItems.Add(txtDistance.Text);

  btnAdd.Enabled := False;
end;

procedure TfrmAddOperation.btnRemoveClick(Sender: TObject);
begin
  if lvOperations.Selected = nil then
    exit;
  with lvOperations do
    Items.Delete(Items.IndexOf(Selected));
  btnRemove.Enabled := lvOperations.Selected <> nil;
end;

procedure TfrmAddOperation.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
const
  sTITLE = 'Operation Not Added';
  sMSG = 'The operation has not been added to the list. Close anyhow?';
begin
  if (btnAdd.Enabled)and(ModalResult = mrOk) then
    CanClose := TaskMessageDlg(sTITLE, sMSG, mtConfirmation, mbYesNo, 0) = mrYes;
end;

procedure TfrmAddOperation.FormCreate(Sender: TObject);
begin
  LoadRadioBtnTags;

  TranslateForm(Self);
end;

procedure TfrmAddOperation.LoadRadioBtnTags;
begin
  radCope.Tag := ord(okCope);
  radNotch.Tag := ord(okNotch);
  radSmallServiceHole.Tag := ord(okServ1);
  radLargeServiceHole.Tag := ord(okServ2);
  radLipHole.Tag := ord(okLipHole);
  radFlgHole.Tag := ord(okFlgHole);
  radSlot.Tag := ord(okSlot);
  radSwage.Tag := ord(okSwage);

  radCope.Enabled := not bFrames;
  radSwage.Enabled := bFrames;
end;

procedure TfrmAddOperation.lvOperationsChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  btnOK.Enabled := True;
end;

procedure TfrmAddOperation.lvOperationsColumnClick(Sender: TObject; Column: TListColumn);
begin
  if abs(lvOperations.Tag) = succ(Column.Index)then
    lvOperations.Tag := -lvOperations.Tag
  else
    lvOperations.Tag := succ(Column.Index);
  lvOperations.AlphaSort;
  btnOK.Enabled := True;
end;

procedure TfrmAddOperation.lvOperationsCompare(Sender: TObject; Item1, Item2: TListItem;
                                               Data: Integer; var Compare: Integer);
begin
  case abs(lvOperations.Tag) of
    1: Compare := CompareText(Item1.Caption, Item2.Caption) * lvOperations.Tag;
    2: Compare := Round((StrToFloat(Item1.SubItems[0]) - StrToFloat(Item2.SubItems[0])) * lvOperations.Tag);
  end;
end;

procedure TfrmAddOperation.lvOperationsSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  btnRemove.Enabled := lvOperations.Selected <> nil;
end;

function TfrmAddOperation.SelectedOperation: TOpKind;
var
  i: Integer;
begin
  Result := okNone;
  for i := 0 to pred(gpOperation.ControlCount) do
    if (gpOperation.Controls[i] is TRadioButton)
    and((gpOperation.Controls[i] as TRadioButton).Checked)then
    begin
      Result := TOpKind((gpOperation.Controls[i] as TRadioButton).Tag);
      break;
    end;
end;

procedure TfrmAddOperation.txtDistanceChange(Sender: TObject);
begin
  btnAdd.Enabled := (txtDistance.Text <> '')and(SelectedOperation <> okNone);
end;

END.
