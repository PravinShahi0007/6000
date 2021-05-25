unit Class_Base;

interface

uses
  Windows, Classes, DB, DBClient, StdCtrls, Provider, Data.SqlExpr
  , SysUtils, ExtCtrls, Controls, Forms, ComCtrls, DBCtrls, Graphics
  , Buttons, Messages, DBGrids, Grids, dialogs, BaseObject;

Type

  TChangeMode   = (cmBrowse, cmEdit, cmNew);

  TItemType     = (itProduct, itKit, itMulti);
  TCtrType      = (ctKey = 1, ctFocusEdit, ctInteger, ctFloat);
  TButtonType   = (btNew = 1, btEdit, btPost, btCommit, btCancel, btExit, btPrint, btPreview, btPrintLabel, btDelete, btUse);
  TButtonStatus = (bsNew, bsAdded, bsEdited, bsPosted, bsSaved, bsCancel, bsGridClicked, bsNone );//use for panel button status
  TItemStatus   = (isEnabled, isDisabled, isDelAllowed);


  TBaseClass = class(TBaseObject)
  private
    FSelectOption  : Integer;
    FFirstLookon   : Boolean;
    FSecondLookon  : Boolean;
    FThirdLookon   : Boolean;
    FMatchsOption  : Integer;
    FStatusOption  : Integer;
    FChangeMode    : TChangeMode;
    FDSProvider    : TDataSetProvider;
  protected
    FSearchStr     : String;
    FFromStr       : String;
    FToStr         : String;
    IDXName        : String;
    FDataSet       : TClientDataSet;
    FDataSource    : TDataSource;
    FIndexFields   : String;
    FNewID         : Integer;
    FButtonPanel   : TPanel;
    FDetailPanel   : TGroupBox;

    function GetNewID : Int64; virtual;abstract;
    procedure DBGridTitleClick(Column: TColumn);virtual;
    Procedure CreateAndOpenClientDataSet(var AQuery : TSQLQuery
                                        ;var AClientDataSet : TClientDataSet
                                        ;var ADSP : TDataSetProvider );overload;virtual;
    procedure AfterApplyUpdateEvt(Sender: TObject; var OwnerData: OleVariant);virtual;
    procedure AfterPostEvt(Sender: TDataSet);virtual;
    procedure OnNewRecord(DataSet: TDataSet);virtual;

    procedure BeforeScrollEvt(DataSet: TDataSet);virtual;
    procedure AfterScrollEvt(DataSet: TDataSet);virtual;
  public
    Keys : Array of TVarRec;
    constructor Create;overload; virtual;
    constructor Create(ASqlStr : String);overload; virtual;
    destructor  Destroy; override;
    function  Find(Keys : Array of TVarRec) : boolean; overload; virtual;
    function  Find(const ALookupField, ALookupCode : Variant) : boolean; overload; virtual;
    function  Find(const ALookupCode : string; IsProductCode : Boolean = False ) : boolean; overload; virtual;
    procedure AddIndex;virtual;
    procedure Add();virtual;
    procedure Edit();virtual;
    procedure Delete;virtual;
    procedure Post;virtual;
    procedure Save();virtual;
    procedure Cancel();virtual;
    procedure SetFilter(FilterStr : String; ABoolean : Boolean);
    Procedure SetPanelButtons(ABtnPanel: TPanel; AChmod : TButtonStatus);virtual;
    Procedure EnableDisableFormControls(AForm  : TWinControl
                                      ; AChmod : TButtonStatus );
    Procedure EmptyControls(AForm : TWinControl);
    Procedure InitControls(AForm : TWinControl);
    procedure AssignEvent(AParent : TWinControl);
    procedure EnterKey(Sender: TObject; var Key: Char);virtual;
    procedure FilterRecord(DataSet: TDataSet;  var Accept: Boolean);virtual;
    procedure Close;
    procedure PopulateInfo(APanel : TWinControl);
    procedure AssignInfo(APanel : TWinControl);
    procedure ActionCancel;
    procedure ActionCommit;
    procedure ActionEdit;
    procedure ActionInsert;

    property IndexFields  : String read FIndexFields write FIndexFields;
    property ClientDataSet: TClientDataSet read FDataSet write FDataSet;
    property DataSource   : TDataSource read FDataSource write FDataSource;
    property NewID        : Int64 read GetNewID;
    property ChangeMode   : TChangeMode read FChangeMode write FChangeMode;
    property StatusOption : Integer read FStatusOption write FStatusOption;
    property MatchsOption : Integer read FMatchsOption write FMatchsOption;
    property FirstLookon  : Boolean read FFirstLookon  write FFirstLookon;
    property SecondLookon : Boolean read FSecondLookon write FSecondLookon;
    property ThirdLookon  : Boolean read FThirdLookon  write FThirdLookon;
    property SearchStr    : String  read FSearchStr write FSearchStr;
    property FromStr      : String  read FFromStr write FFromStr;
    property ToStr        : String  read FToStr write FToStr;
    property SelectOption : Integer read FSelectOption write FSelectOption;//0-All,1-Product range,2-group range,3-category range, 4- supplier range
    property ButtonPanel  : TPanel  read FButtonPanel  write FButtonPanel;
    property DetailPanel  : TGroupBox  read FDetailPanel  write FDetailPanel;
  end;

implementation

uses Com_Exception;

constructor TBaseClass.Create;
begin
  inherited;
  StatusOption := 0;
  MatchsOption := 0;
  FirstLookon  := true;
  SecondLookon := true;
  ThirdLookon  := true;
  FNewID       := -1;
end;

constructor TBaseClass.Create(ASqlStr : String);
begin
  inherited Create();
end;

procedure TBaseClass.AddIndex;
begin
end;

destructor TBaseClass.Destroy;
var
  i : integer;
begin
  inherited;
  FreeAndNil(FDataSet);
  FreeAndNil(FDSProvider);
  FreeAndNil(FDataSource);
  for i := 0 to Length(Keys)-1 do
    SysUtils.StrDispose(Keys[i].VPChar);
end;

Procedure TBaseClass.CreateAndOpenClientDataSet(var AQuery : TSQLQuery
                                        ;var AClientDataSet : TClientDataSet
                                        ;var ADSP : TDataSetProvider);
begin
  AClientDataSet := TClientDataSet.Create(nil);
  ADSP     := TDataSetProvider.Create(nil);
  AQuery   := TSQLQuery.Create(nil);
  ADSP.DataSet := AQuery;
  AClientDataSet.SetProvider(ADSP);
end;

function TBaseClass.Find(const ALookupField, ALookupCode : Variant) : Boolean;
begin
  if not FDataSet.Active then
    FDataSet.Open;
  result :=  FDataSet.Locate( ALookupField, ALookupCode,[] );
end;

function TBaseClass.Find(const ALookupCode : string; IsProductCode : Boolean = False ) : boolean;
begin
  SearchStr := ALookupCode;
  FDataSet.Filtered := False;
  FDataSet.Filtered := True;
end;

function TBaseClass.Find( Keys : Array of TVarRec ) : Boolean;
var
  i   : integer;
begin
  IDXName :='';
  for I := Low(Keys) to High(Keys) do
    begin
    if IDXName='' then
      IDXName := FDataSet.Fields[i].FieldName
    else
      IDXName := IDXName +'_'+FDataSet.Fields[i].FieldName
    end;
  if ClientDataSet.IndexName <> IDXName + '__IdxA' then// FDataSet.Fields[0].FieldName + '__IdxA' then
    //Set the index
    begin
    ClientDataSet.IndexDefs.Update;
    AddIndex;
    ClientDataSet.IndexName := IDXName + '__IdxA';
    ClientDataSet.First;
    end;
  if not FDataSet.Active then
    FDataSet.Open;
  result := FDataSet.FindKey(Keys);
  if not Result then
    FDataSet.FindNearest(Keys);
end;

procedure TBaseClass.Close;
begin
end;

procedure TBaseClass.Add();
begin
with FDataSet do
  begin
  Append;
  end;
end;

procedure TBaseClass.Delete;
begin
if MessageDlg('Are you sure you want to delete this record? '
             , mtConfirmation
             , [mbYes, mbNo], 0) = mrYes then
  begin
  FDataSet.Delete;
  FDataSet.ApplyUpdates(0);
  end;
end;

procedure TBaseClass.Post;
begin
  FDataSet.Post;
end;

procedure TBaseClass.Edit();
begin
with FDataSet do
  begin
  Edit;
  end;
end;

procedure TBaseClass.Save();
begin
  FDataSet.ApplyUpdates(0);
  ChangeMode := cmBrowse;
end;

procedure TBaseClass.AfterApplyUpdateEvt(Sender: TObject; var OwnerData: OleVariant);
begin
end;

procedure TBaseClass.AfterPostEvt(Sender: TDataSet);
begin
  if FDataSet.ApplyUpdates(0)=0 then
  begin
    FDataSet.Refresh;
    FNewID :=-1;
  end;
end;

procedure TBaseClass.OnNewRecord(DataSet: TDataSet);
begin
  FDataSet.Fields[0].AsInteger := FNewID;
  DEC(FNewID);
end;

procedure TBaseClass.FilterRecord(DataSet: TDataSet;  var Accept: Boolean);
begin
  if MatchsOption = 0 then
    Accept := FirstLookon and (AnsiPOS(UPPERCASE(FSearchStr), UPPERCASE(DataSet.Fields[0].AsString))=1)
       or SecondLookon and (AnsiPOS(UPPERCASE(FSearchStr), UPPERCASE(DataSet.Fields[1].AsString))=1)
       or (AnsiPOS(UPPERCASE(FSearchStr), UPPERCASE(DataSet.Fields[2].AsString))=1)
       or (FSearchStr='')
  else
  if MatchsOption = 1 then
    Accept := FirstLookon and (AnsiPOS(UPPERCASE(FSearchStr), UPPERCASE(DataSet.Fields[0].AsString))>0)
       or SecondLookon and (AnsiPOS(UPPERCASE(FSearchStr), UPPERCASE(DataSet.Fields[1].AsString))>0)
       or ThirdLookon and (AnsiPOS(UPPERCASE(FSearchStr), UPPERCASE(DataSet.Fields[2].AsString))>0)
       or (FSearchStr='');
end;

procedure TBaseClass.Cancel();
begin
  FDataSet.CancelUpdates;
end;

procedure TBaseClass.SetFilter(FilterStr : String; ABoolean : Boolean);
begin
  with FDataSet do
    begin
    Filter   := FilterStr ;
    Filtered := ABoolean;
    end;
end;

Procedure TBaseClass.SetPanelButtons(ABtnPanel: TPanel
                                   ; AChmod: TButtonStatus);
var
  i : Integer;
begin
  With ABtnPanel do
  for i := 0 to ControlCount - 1 do
    begin
      Controls[i].Visible := (Controls[i] is TPanel)or (Controls[i].Tag = 99);
      Case Controls[i].Tag of
      Integer(btCancel):  begin
                          Controls[i].Top     := 65;
                          Controls[i].Visible := True;
                          Controls[i].Enabled := AChmod in [bsNew, bsEdited, bsGridClicked];
                          end;
      Integer(btNew)   :  begin
                          Controls[i].Top     := 95;
                          Controls[i].Visible := True;
                          Controls[i].Enabled := AChmod in [bsAdded, bsPosted, bsSaved, bsCancel, bsNone, bsGridClicked];
                          end;
      Integer(btEdit)  :  begin
                          Controls[i].Top     := 125;
                          Controls[i].Visible := True;
                          Controls[i].Enabled := AChmod in [bsAdded, bsPosted, bsSaved, bsCancel,bsNone, bsGridClicked];
                          end;
      Integer(btPrint):  begin
                          Controls[i].Top     := 155;
                          Controls[i].Visible := True;
                          Controls[i].Enabled := AChmod in [bsCancel,bsNone,bsAdded, bsEdited, bsPosted];
                          end;
      Integer(btPreview):  begin
                          Controls[i].Top     := 185;
                          Controls[i].Visible := True;
                          Controls[i].Enabled := AChmod in [bsCancel,bsNone,bsAdded, bsEdited, bsPosted];
                          end;
      Integer(btPost)  :  begin
                          Controls[i].Enabled := AChmod in [bsNew, bsEdited, bsGridClicked];
                          end;
      Integer(btCommit):  begin
                          Controls[i].Top     := 215;
                          Controls[i].Visible := True;
                          Controls[i].Enabled := AChmod in [bsNew, bsAdded, bsEdited, bsPosted];
                          end;
      Integer(btDelete):  begin
                          Controls[i].Top     := 245;
                          Controls[i].Visible := True;
                          Controls[i].Enabled := True;
                          end;
      Integer(btUse) :    begin
                          Controls[i].Top     := 275;
                          Controls[i].Visible := True;
                          Controls[i].Enabled := True;
                          end;
      Integer(btExit):    begin
                          Controls[i].Top     := 305;
                          Controls[i].Visible := True;
                          Controls[i].Enabled := True;
                          end;
      End;
      if Controls[i].Name = 'Panel_ButtonHeader' then
        Controls[i].Top := 1;
    end;
end;

Procedure TBaseClass.EnableDisableFormControls(AForm  : TWinControl
                                             ; AChmod : TButtonStatus);
var
  I : Integer;
begin
  With AForm do
  for I := 0 to ControlCount - 1 do
    begin
    if (Controls[I] is StdCtrls.TEdit)
    or (Controls[I] is TEdit)
    or (Controls[I] is TDBEdit)
    or (Controls[I] is TRadioGroup)
    or (Controls[I] is TCheckBox)
    or (Controls[I] is TComboBox)
    or (Controls[I] is TDBNavigator)
    or (Controls[I] is TListBox)
    or (Controls[I] is TSpeedButton)
    or (Controls[I] is TButton)
    or (Controls[I] is TBitBtn)
      then Controls[I].Enabled := (AChmod in [bsNew, bsEdited]) or (Controls[I].Tag = 99)
    else
    if (Controls[I] is TStringGrid) then
      begin
        with (Controls[I] as TStringGrid) do
          begin
          if (AChmod in [bsNew, bsEdited]) then
            Options := Options + [goEditing]
          else
            Options := Options - [goEditing];
          end;
      end;
    //if Controls in Container controls, recursive then
    if (csAcceptsControls in Controls[i].ControlStyle)
    or (Controls[i] is TPageControl)
    or (Controls[i] is TGroupBox) then
      EnableDisableFormControls( TWinControl(Controls[I]), AChmod );
    end;
end;

Procedure TBaseClass.EmptyControls(AForm : TWinControl);
var
  i : Integer;
begin
  With AForm do
  for I := 0 to ControlCount - 1 do
    begin
    if (Controls[I] is StdCtrls.TEdit) then
      begin
      if TCtrType((Controls[I] as StdCtrls.TEdit).Tag) = ctFloat then
        TEdit(Controls[I]).Text := '0.00'
      else
      if TCtrType((Controls[I] as StdCtrls.TEdit).Tag) = ctInteger then
        TEdit(Controls[I]).Text := '0'
      else
      if TCtrType(Controls[i].Tag) = ctKey then
        (Controls[i] as StdCtrls.TEdit).Text := IntToStr(NewID)
      else
        TEdit(Controls[I]).Text := '';
      end
    else
    if (Controls[I] is TEdit) then
      begin
      if TCtrType((Controls[I] as TEdit).Tag) = ctFloat then
        TEdit(Controls[I]).Text := '0.00'
      else
      if TCtrType((Controls[I] as TEdit).Tag) = ctInteger then
        TEdit(Controls[I]).Text := '0'
      else
      if TCtrType(Controls[i].Tag) = ctKey then
        (Controls[i] as TEdit).Text := IntToStr(NewID)
      else
        TEdit(Controls[I]).Text := '';
      end
    else
    if (Controls[I] is TRadioGroup) then
      TRadioGroup(Controls[I]).ItemIndex := 0
    else
    if (Controls[I] is TComboBox) then
      begin
      if (TComboBox(Controls[I]).Name ='ComboBox_GroupCL')
      or (TComboBox(Controls[I]).Name ='ComboBox_CatCL')
      or (TComboBox(Controls[I]).Name ='ComboBox_PurCL')
      or (TComboBox(Controls[I]).Name ='ComboBox_Loyalty')then
        TComboBox(Controls[I]).ItemIndex := TComboBox(Controls[I]).Items.Count-1
      else
        TComboBox(Controls[I]).ItemIndex := -1;
      end;
    if (csAcceptsControls in Controls[i].ControlStyle)
    or (Controls[i] is TPageControl)
    or (Controls[i] is TGroupBox) then
      EmptyControls(TWinControl(Controls[I]));
    end;
end;

Procedure TBaseClass.InitControls(AForm : TWinControl);
var
  i : Integer;
begin
  With AForm do
  for I := 0 to ControlCount - 1 do
    begin
    if (Controls[I].Tag=3) or (Controls[I].Tag=4) then
        TEdit(Controls[I]).Alignment := taRightJustify;
    if Controls[I] is TDBGrid then
      TDBGrid(Controls[I]).OnTitleClick := DBGridTitleClick;
    //if Controls in Container controls, recursive then
    if (csAcceptsControls in Controls[i].ControlStyle)
    or (Controls[i] is TPageControl)
    or (Controls[i] is TGroupBox) then
      InitControls(TWinControl(Controls[I]));
    end;
end;

procedure TBaseClass.AssignEvent(AParent: TWinControl);
var
  i : Integer;
begin
  with AParent do
    for I := 0 to ControlCount - 1 do
      begin
      if (Controls[i] is StdCtrls.TEdit) then
        (Controls[i] as StdCtrls.TEdit).OnKeyPress := EnterKey;
      if (Controls[i] is TEdit) then
        (Controls[i] as TEdit).OnKeyPress := EnterKey;
      if (Controls[i] is TComboBox) then
        (Controls[i] as TComboBox).OnKeyPress := EnterKey;
      if (Controls[i] is TCheckBox) then
        (Controls[i] as TCheckBox).OnKeyPress := EnterKey;
    if (csAcceptsControls in Controls[i].ControlStyle)
    or (Controls[i] is TPageControl)
    or (Controls[i] is TGroupBox) then
        AssignEvent(TWinControl(Controls[I]));
      end;
end;

procedure TBaseClass.EnterKey(Sender: TObject; var Key: Char);
begin
if Sender is StdCtrls.TEdit then
  begin
  if TCtrType((Sender as TWinControl).Tag) = ctFloat then //Set EditTextBox tag to 4 , only number allowed
    begin
    if ( CharInSet(Key, ['-']) and (AnsiPos('-',(Sender as StdCtrls.TEdit).Text)>0))
    or ( CharInSet(Key, ['.']) and (AnsiPos('.',(Sender as StdCtrls.TEdit).Text)<>0))
    or ( not CharInSet(Key, ['-','0'..'9','.',#8, #13]) ) then
      Key := #0;
    end
  else
  if TCtrType((Sender as TWinControl).Tag) = ctInteger then //Set EditTextBox tag to 3 , only number allowed
    begin
    if ( CharInSet(Key, ['-']) and (AnsiPos('-',(Sender as StdCtrls.TEdit).Text)>0))
     or (not CharInSet(Key, ['-','0'..'9',#8, #13])) then
    Key := #0;
    end;
  end
else
if Sender is StdCtrls.TEdit then
  begin
  if TCtrType((Sender as TWinControl).Tag) = ctFloat then //Set EditTextBox tag to 4 , only number allowed
    begin
    if ( CharInSet(Key, ['-']) and (AnsiPos('-',(Sender as TEdit).Text)>0))
    or ( CharInSet(Key, ['.']) and (AnsiPos('.',(Sender as TEdit).Text)<>0))
    or ( not CharInSet(Key, ['-','0'..'9','.',#8, #13]) ) then
      Key := #0;
    end
  else
  if TCtrType((Sender as TWinControl).Tag) = ctInteger then //Set EditTextBox tag to 3 , only number allowed
    begin
    if ( CharInSet(Key, ['-']) and (AnsiPos('-',(Sender as TEdit).Text)>0))
     or (not CharInSet(Key, ['-','0'..'9',#8, #13])) then
    Key := #0;
    end;
  end
else
if Sender is TComboBox then
  begin
  if TCtrType((Sender as TWinControl).Tag) = ctFloat then //Set EditTextBox tag to 4 , only number allowed
    begin
    if ( CharInSet(Key, ['-']) and (AnsiPos('-',(Sender as TComboBox).Text)<>0))
    or ( CharInSet(Key, ['.']) and (AnsiPos('.',(Sender as TComboBox).Text)<>0))
    or ( not CharInSet(Key, ['-','0'..'9','.',#8, #13]) ) then
      Key := #0;
    end
  else
  if TCtrType((Sender as TWinControl).Tag) = ctInteger then //Set EditTextBox tag to 3 , only number allowed
    begin
    if ( CharInSet(Key, ['-']) and (AnsiPos('-',(Sender as TComboBox).Text)>0))
     or (not CharInSet(Key, ['-','0'..'9',#8, #13])) then
    Key := #0;
    end;
  end;

  if ( Ord(Key) = VK_Return ) then
    TWinControl(TWinControl(Sender).Owner).Perform( WM_NextDlgCtl, 0, 0);

end;

procedure TBaseClass.DBGridTitleClick(Column: TColumn);
begin
end;

procedure TBaseClass.PopulateInfo(APanel : TWinControl);
var
  i : integer;
  FieldName : String;

  function ComboBoxItemIndex( AItemCode : String
                            ; AComboBox : TComboBox ) : Integer;
  var
    i : integer;
  begin
    result := -1;
    for I := 0 to AComboBox.Items.Count - 1 do
      begin
      if Assigned(AComboBox.Items.Objects[i]) then
        begin
//        if AItemCode = TComboObject(AComboBox.Items.Objects[i]).ObjCode then
          begin
          result := i;
          break;
          end
        end
      else
      if AItemCode = AComboBox.Items[i] then
        begin
        result := i;
        break;
        end;
      end;
  end;

begin

with APanel do
  for I := 0 to ControlCount - 1 do
    begin
    FieldName :=Copy ((Controls[i].Name),Pos('_',Controls[i].Name)+1,Length(Controls[i].Name));

    if (Controls[i] is TEdit) then
      begin
      if ClientDataSet.FindField(FieldName)<>nil then
        TEdit(Controls[i]).Text := ClientDataSet.FieldByName(FieldName).AsString;
      end
    else
    if (Controls[i] is StdCtrls.TEdit) then
      begin
      if ClientDataSet.FindField(FieldName)<>nil then
        StdCtrls.TEdit(Controls[i]).Text := ClientDataSet.FieldByName(FieldName).AsString;
      end
    else
    if (Controls[i] is TComboBox) then
      begin
      if ClientDataSet.FindField(FieldName)<>nil then
        begin
        TComboBox(Controls[i]).ItemIndex :=
          ComboBoxItemIndex(ClientDataSet.FieldByName(FieldName).AsString
                            , TComboBox(Controls[i]));
        end
      end
    else
    if (Controls[i] is TCheckBox) then
      begin
      if ClientDataSet.FindField(FieldName)<>nil then
        begin
//        TCheckBox(Controls[i]).Checked := StoB(ClientDataSet.FieldByName(FieldName).AsString);
        end
      end
    else
    if (Controls[i] is TDBGrid) then
      begin
      end
    else
    if (Controls[i] is TRadioGroup) then
      begin
      if ClientDataSet.FindField(FieldName)<>nil then
        begin
          TRadioGroup(Controls[i]).ItemIndex := StrToIntDef(ClientDataSet.FieldByName(FieldName).AsString,0);
        end
      end
    else
    if (Controls[i] is TLabel) then
      begin
      if ClientDataSet.FindField(FieldName)<>nil then
        begin
        if ClientDataSet.FieldByName(FieldName).DataType in [ftDate, ftTime, ftDateTime] then
          TLabel(Controls[i]).Caption := FormatDatetime('dd/mm/yyyy', ClientDataSet.FieldByName(FieldName).AsDateTime)
        else
        if ClientDataSet.FieldByName(FieldName).DataType in [ftCurrency, ftBCD] then
          TLabel(Controls[i]).Caption := Format('%m', [ClientDataSet.FieldByName(FieldName).AsCurrency])
        else
          TLabel(Controls[i]).Caption := ClientDataSet.FieldByName(FieldName).AsString;
        end
      else
        begin
        end;
      end;
    if csAcceptsControls in Controls[i].ControlStyle then
      PopulateInfo(TWinControl(Controls[I]));
    end;
end;

procedure TBaseClass.AssignInfo(APanel : TWinControl);
var
  i : integer;
  FieldName : String;
begin
try
with APanel do
  for I := 0 to ControlCount - 1 do
    begin
    FieldName :=Copy ((Controls[i].Name),Pos('_',Controls[i].Name)+1,Length(Controls[i].Name));
    if ClientDataSet.FindField(FieldName)<>nil then
      begin
      if (Controls[i] is TEdit) then
        begin
        ClientDataSet.FieldByName(FieldName).AsString := TEdit(Controls[i]).Text;
        end
      else
      if (Controls[i] is StdCtrls.TEdit) then
        begin
        ClientDataSet.FieldByName(FieldName).AsString := StdCtrls.TEdit(Controls[i]).Text;
        end
      else
      if (Controls[i] is TComboBox) then
        begin
        ClientDataSet.FieldByName(FieldName).AsString := TComboBox(Controls[i]).Text
        end
      else
      if (Controls[i] is TCheckBox) then
        begin
        if ClientDataSet.FieldByName(FieldName).DataType in [ftString] then
//          ClientDataSet.FieldByName(FieldName).AsString := BToS(TCheckBox(Controls[i]).Checked)
        else
        if ClientDataSet.FieldByName(FieldName).DataType in [ftSmallint, ftInteger] then
          ClientDataSet.FieldByName(FieldName).AsInteger := Integer(TCheckBox(Controls[i]).Checked)
        else
        if ClientDataSet.FieldByName(FieldName).DataType in [ftBoolean] then
          ClientDataSet.FieldByName(FieldName).AsBoolean := TCheckBox(Controls[i]).Checked;
        end
      else
      if (Controls[i] is TRadioGroup) then
        begin
        if ClientDataSet.FieldByName(FieldName).DataType in [ftString] then
          ClientDataSet.FieldByName(FieldName).AsString := IntToStr(TRadioGroup(Controls[i]).ItemIndex)
        else
        if ClientDataSet.FieldByName(FieldName).DataType in [ftSmallint, ftInteger] then
          ClientDataSet.FieldByName(FieldName).AsInteger := TRadioGroup(Controls[i]).ItemIndex
        else
        if ClientDataSet.FieldByName(FieldName).DataType in [ftBoolean] then
//          ClientDataSet.FieldByName(FieldName).AsBoolean := IToB(TRadioGroup(Controls[i]).ItemIndex);
        end
      else
      if (Controls[i] is TDatetimePicker) then
        begin
          ClientDataSet.FieldByName(FieldName).AsDatetime := TDatetimePicker(Controls[i]).DateTime;
        end;
      end;
    if csAcceptsControls in Controls[i].ControlStyle then
      AssignInfo(TWinControl(Controls[I]));
    end;
except
  on e : exception do
    HandleException(e,'TDMSP.AssignInfo',[])
end;
end;

procedure TBaseClass.ActionCancel;
begin
  ChangeMode := cmBrowse;
  PopulateInfo(DetailPanel);
  EnableDisableFormControls( DetailPanel, bsCancel);
  SetPanelButtons(ButtonPanel,bsCancel);
  ClientDataSet.Cancel;
end;

procedure TBaseClass.ActionCommit;
begin
  AssignInfo(DetailPanel);
  Post;
  Save;
  ChangeMode := cmBrowse;
  SetPanelButtons(ButtonPanel,bsSaved);
end;

procedure TBaseClass.ActionEdit;
begin
  EnableDisableFormControls( DetailPanel, bsEdited);
  SetPanelButtons(ButtonPanel,bsEdited);
  Edit;
  ChangeMode := cmEdit;
end;

procedure TBaseClass.ActionInsert;
begin
  FDataSet.BeforeScroll := nil;
  FDataSet.AfterScroll  := nil;
  EnableDisableFormControls(DetailPanel, bsNew);
  EmptyControls(DetailPanel);
  SetPanelButtons(ButtonPanel,bsNew);
  Add;
  ChangeMode := cmNew;
  FDataSet.BeforeScroll := BeforeScrollEvt;
  FDataSet.AfterScroll  := AfterScrollEvt;
end;


procedure TBaseClass.BeforeScrollEvt(DataSet: TDataSet);
begin
FDataSet.BeforeScroll := nil;
if ChangeMode<>cmBrowse then
  begin
  if MessageDlg('Are you want to save change '
               , mtConfirmation
               , [mbYes, mbNo], 0) = mrYes then
    Save
  else
    begin
    ChangeMode := cmBrowse;
    SetPanelButtons(ButtonPanel,bsCancel);
    end;
  end;
FDataSet.BeforeScroll := BeforeScrollEvt;
end;

procedure TBaseClass.AfterScrollEvt(DataSet: TDataSet);
begin
  FDataSet.AfterScroll  := nil;
  if (ChangeMode <> cmBrowse) then
    Exit
  else
  if (not FDataSet.IsEmpty) and FDataSet.Eof then
    FDataSet.First;

  if Assigned(DetailPanel) then
    PopulateInfo(DetailPanel);
  FDataSet.AfterScroll  := AfterScrollEvt;
end;


end.
