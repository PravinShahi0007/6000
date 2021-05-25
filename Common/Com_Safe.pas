unit Com_Safe;

interface

uses SysUtils, Classes;

type
  IObjectSafe = interface
  {private}
    function  GetExceptionOnFree : Boolean;
    procedure SetExceptionOnFree(Value : Boolean);
  {public}
    function  Safe : TInterfacedObject;
    function  ISafe : IObjectSafe;
    procedure New(out aVar; const aObject : TObject);
    procedure Guard(const aObject : TObject);
    procedure Dispose(var aObject);
    procedure UnGuard(const aObject : TObject);
    property  ExceptionOnFree : Boolean read GetExceptionOnFree write SetExceptionOnFree;
  end;

  IExceptionSafe = interface
    procedure SaveException;
  end;

function ObjectSafe : IObjectSafe; overload;
function ObjectSafe(ExceptionOnFree : Boolean) : IObjectSafe; overload;
function ObjectSafe(out aObjectSafe : IObjectSafe; ExceptionOnFree : Boolean = True) : IObjectSafe; overload;
function ExceptionSafe : IExceptionSafe;

function IsAs (out   aReference {: Pointer};
               const aObject     : TObject;
               const aClass      : TClass) : Boolean;

function  AutoCleanup : IObjectSafe; overload;
procedure AutoCleanup(const Obj : TObject); overload;

implementation

uses Windows, Contnrs;

var
  L_AutoCleanup : IObjectSafe;

type

  TExceptionSafe = class (TInterfacedObject, IExceptionSafe)
  private
    FMessages : String;
  public
    destructor Destroy; override;
    procedure SaveException;
  end;

  TObjectSafe = class (TInterfacedObject, IObjectSafe)
  private
    FObjects : TObjectList;
    FExceptionOnFree : Boolean;
    function  GetExceptionOnFree : Boolean;
    procedure SetExceptionOnFree(Value : Boolean);
  public
    constructor Create;
    destructor  Destroy; override;

    function  Safe : TInterfacedObject;
    function  ISafe : IObjectSafe;
    procedure New(out aVar; const aObject : TObject);
    procedure Guard(const aObject : TObject);
    procedure Dispose(var aObject);
    procedure UnGuard(const aObject : TObject);
  end;

{ TObjectSafe }

constructor TObjectSafe.Create;
begin
  inherited Create;
  FObjects := TObjectList.Create(True);
  FExceptionOnFree := True;
end;

destructor TObjectSafe.Destroy;
var
  Ex : Exception;
begin
  Ex := nil;
  try

//Remove All Objects
    while FObjects.Count > 0 do
    try
      FObjects.Delete(FObjects.Count - 1);
    except
      if FExceptionOnFree and not Assigned(Ex) then
        //Ex := AcquireExceptionObject;
    end;

// Free Object List
    try
      FObjects.Free;
    except
      if FExceptionOnFree and not Assigned(Ex) then
        //.Ex := AcquireExceptionObject;
    end;

  except
  end;
  inherited Destroy;
// note that we only return the first exception that happened
  if Assigned(Ex) then
    raise Ex;
end;

function TObjectSafe.GetExceptionOnFree: Boolean;
begin
  Result := FExceptionOnFree;
end;

procedure TObjectSafe.SetExceptionOnFree(Value: Boolean);
begin
  FExceptionOnFree := Value;
end;

function TObjectSafe.Safe : TInterfacedObject;
begin
  Result := Self;
end;

function TObjectSafe.ISafe : IObjectSafe;
begin
  Result := Self;
end;

procedure TObjectSafe.Dispose (var aObject);
var
  i : Integer;
begin
  try
    i := FObjects.IndexOf(TObject(aObject));
    if i <> -1 then
    begin
      TObject(aObject) := nil;
      FObjects.Delete(i);
    end
    else
      FreeAndNil(aObject);
  except
    if FExceptionOnFree then
      raise;
  end;
end;

procedure TObjectSafe.Guard (const aObject : TObject);
var
  aCom : TComponent;
begin
  if not Assigned( aObject ) then
    exit;
  if (aObject is TComponent) then
  begin
    aCom := TComponent(aObject);
    if aCom.Owner <> nil then
      aCom.Owner.RemoveComponent(aCom);
  end;
  if FObjects.IndexOf(aObject) = -1 then
    FObjects.Add(aObject);
end;

procedure TObjectSafe.New (out aVar; const aObject : TObject);
begin
  try
    Guard(aObject);
    TObject(aVar) := aObject;
  except
    TObject(aVar) := Nil;
    raise;
  end;
end;

procedure TObjectSafe.UnGuard(const aObject: TObject);
begin
  FObjects.Extract(aObject);
end;

{ TExceptionSafe }

destructor TExceptionSafe.Destroy;
begin
  try
    if Length (FMessages) > 0 then
      raise Exception.Create (FMessages);
  finally
    try
      inherited Destroy;
    except
    end;
 end;
end;

procedure TExceptionSafe.SaveException;
begin
  try
    if (ExceptObject <> Nil) and (ExceptObject is Exception) then
      if FMessages = '' then
        FMessages := Exception (ExceptObject).Message
      else
        FMessages := FMessages + sLineBreak + sLineBreak + Exception (ExceptObject).Message;
  except
  end;
end;

function ExceptionSafe : IExceptionSafe;
begin
  Result := TExceptionSafe.Create;
end;

function ObjectSafe : IObjectSafe;
begin
  Result := TObjectSafe.Create;
end;

function ObjectSafe(ExceptionOnFree : Boolean) : IObjectSafe; overload;
begin
  Result := TObjectSafe.Create;
  Result.ExceptionOnFree := ExceptionOnFree;
end;

function ObjectSafe (out aObjectSafe : IObjectSafe; ExceptionOnFree : Boolean) : IObjectSafe; overload;
begin
  aObjectSafe := ObjectSafe;
  try
    aObjectSafe.ExceptionOnFree := ExceptionOnFree;
    Result := aObjectSafe;
  except
    aObjectSafe := nil;
    raise;
  end;
end;

function IsAs (out   aReference {: Pointer};
               const aObject     : TObject;
               const aClass      : TClass) : Boolean;
begin
  Result := (aObject <> Nil) and (aObject is aClass);

  if Result then
    TObject(aReference) := aObject;
end;

function AutoCleanup : IObjectSafe;
begin
  if not Assigned(L_AutoCleanup) then
    L_AutoCleanup := ObjectSafe(False);
  Result := L_AutoCleanup;
end;

procedure AutoCleanup(const Obj : TObject);
begin
  with AutoCleanup do Guard(Obj);
end;

initialization

finalization
  L_AutoCleanup := nil;
end.
