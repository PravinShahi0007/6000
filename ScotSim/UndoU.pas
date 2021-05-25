unit UndoU;

interface

uses
  Windows
  , Messages
  , SysUtils
  , Classes
  , Graphics
  , Controls
  , Forms
  , Dialogs
  , Generics.Collections
  ;

  procedure InitUndoAndRedo;
  procedure SaveUndo(sHint: string='');
  procedure DoUndo;
  procedure DoRedo;

implementation

uses
  mainU
  , GlobalU
  ;

type
  TUndoItems = record
                 ItemName: string[10];
                 RectItem: RectType;
                 iType: string[5];
                 OpCount: Word;
                 Op: array[1..MAX_OPS]of OpType;
                 bNonRFItem: Boolean;
               end;

  TUndoRecord = record
    Hint: string;
    Items: array of TUndoItems;
  end;

var
  UndoStack: TStack<TUndoRecord>;
  RedoStack: TStack<TUndoRecord>;
  sCurrentHint: string;

procedure UpdateMainForm;
var
  s: string;
begin
  frmMain.actUndo.Enabled := (UndoStack.Count > 0);
  s := 'Undo';
  if (UndoStack.Count > 0) then
    s := s + ' ' + UndoStack.Peek.Hint;
  frmMain.actUndo.Hint := s;

  frmMain.actRedo.Enabled := (RedoStack.Count > 0);
  s := 'Redo';
  if (RedoStack.Count > 0) then
    s := s + ' ' + sCurrentHint;  //RedoStack.Peek.Hint;
  frmMain.actRedo.Hint := s;

  frmMain.FormPaint(nil);
end;

procedure InitUndoAndRedo;
begin
  UndoStack.Clear;
  RedoStack.Clear;

  UpdateMainForm;
end;

function GetTrussRectsAsUndoRecord: TUndoRecord;
var
  i,j: Integer;
begin
  SetLength(Result.Items, CurrentItem);
  i:=0;
  while (i < CurrentItem) do
  begin
    Result.Items[i].ItemName := TrussRects.ItemName[succ(i)];
    Result.Items[i].RectItem := TrussRects.Item[succ(i)];
    Result.Items[i].iType := TrussRects.iType[succ(i)];
    Result.Items[i].OpCount := TrussRects.OpCount[succ(i)];
    for j:=1 to MAX_OPS do
      Result.Items[i].Op[j] := TrussRects.Op[succ(i), j];
    Result.Items[i].bNonRFItem := TrussRects.bNonRFItem[succ(i)];
    inc(i);
  end;
  Result.Hint := sCurrentHint;
end;

procedure SaveUndo(sHint: string='');
var
  NewRec: TUndoRecord;
begin
  NewRec := GetTrussRectsAsUndoRecord;
  NewRec.Hint := sHint;
  UndoStack.Push(NewRec);

  UpdateMainForm;
end;

procedure SetTrussRectsFromUndoRecord(ARec: TUndoRecord);
var
  i,j, Num: Integer;
begin
  sCurrentHint := ARec.Hint;

  FillChar(TrussRects, SizeOf(TrussRects), 0);
  Num := Length(ARec.Items);
  i:=0;
  while i<Num do
  begin
    TrussRects.ItemName[succ(i)] := ARec.Items[i].ItemName;
    TrussRects.Item[succ(i)] := ARec.Items[i].RectItem;
    TrussRects.iType[succ(i)] := ARec.Items[i].iType;
    TrussRects.OpCount[succ(i)] := ARec.Items[i].OpCount;
    for j:=1 to MAX_OPS do
      TrussRects.Op[succ(i), j] := ARec.Items[i].Op[j];
    TrussRects.bNonRFItem[succ(i)] := ARec.Items[i].bNonRFItem;
    inc(i);
  end;
  CurrentItem := i;

  UpdateMainForm;
end;

procedure DoUndo;
var
  ARec: TUndoRecord;
begin
  if (UndoStack.Count <= 0) then
  begin
    UpdateMainForm;
    exit;
  end;
  // Current -> Redo
  ARec := GetTrussRectsAsUndoRecord;
  RedoStack.Push(ARec);

  //Undo -> Current
  ARec := UndoStack.Pop;
  SetTrussRectsFromUndoRecord(ARec);
end;

procedure DoRedo;
var
  ARec: TUndoRecord;
begin
  if (RedoStack.Count <= 0) then
  begin
    UpdateMainForm;
    exit;
  end;

  // Current -> Undo
  ARec := GetTrussRectsAsUndoRecord;
  UndoStack.Push(ARec);

  //Redo -> Current
  ARec := RedoStack.Pop;
  SetTrussRectsFromUndoRecord(ARec);
end;

initialization
  UndoStack := TStack<TUndoRecord>.Create;
  RedoStack := TStack<TUndoRecord>.Create;

finalization
  FreeAndNil(UndoStack);
  FreeAndNil(RedoStack);

END.
