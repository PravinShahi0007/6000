// May not need this Unit, Will Merge into BaseObject later
unit BaseObj;

interface

uses
  System.SysUtils, System.Classes, Generics.Collections, Data.DBXJson, System.JSON
  , Data.DBXJsonReflect, System.DateUtils, System.RTTI;

type

  {$MethodInfo ON}
  TBaseObj = class(TObject)
  private
    aInteger: integer;
    aString: String;
  protected
    class procedure RegisterConverters(aMar: TJsonMarshal); virtual;
    class procedure RegisterReverters(aUnMar: TJSONUnMarshal); virtual;
  public
    constructor Create; virtual;
    procedure Assign(aSource: TBaseObj); virtual;
    procedure SetupData; virtual;
    function Marshal: TJSONObject; virtual;
    procedure UnMarshal(aJsonObj: TJSONObject); virtual;
    function SaveToJsonFile(sFileName: String; bOverWriteIfExists: Boolean = true): Boolean; virtual;
    procedure LoadFromJsonFile(sFileName: String); virtual;
    property pInteger: integer read aInteger write aInteger;
    property pString: String read aString write aString;
  end;
  {$MethodInfo OFF}

  TMyClassList<T: TBaseObj, constructor> = class(TObjectList<T>)
  private
    class procedure RegisterConverters(aMar: TJsonMarshal); virtual;
    class procedure RegisterReverters(aUnMar: TJSONUnMarshal); virtual;
  public
    constructor Create; virtual;
    procedure Assign(aSource: TMyClassList<T>); virtual;
    function Marshal: TJSONObject; virtual;
    procedure UnMarshal(aJsonObj: TJSONObject); virtual;
    function SaveToJsonFile(sFileName: String; bOverWriteIfExists: Boolean = true): Boolean; virtual;
    function AsBaseList: TMyClassList<TBaseObj>; virtual;
    procedure LoadFromJsonFile(sFileName: String); virtual;
    procedure Populate100Elements;
  end;

  // COMPLEX OBJECT - Contains TStringList as property.
  TMyComplexClass = class(TBaseObj)
  private
    aStringList: TStringList;
  protected
    class procedure RegisterConverters(aMar: TJsonMarshal); override;
    class procedure RegisterReverters(aUnMar: TJSONUnMarshal); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Assign(aSource: TBaseObj); override;
    procedure SetupData; override;
    property pStringList: TStringList read aStringList write aStringList;
  end;

  TMyComplexClassList<T: TMyComplexClass, constructor> = class(TMyClassList<T>)
  private
  public
    constructor Create; override;
    procedure Assign(aSource: TMyClassList<T>); override;
  end;

  // VERY COMPLEX CLASS - Contains a TMyComplexClassList as property.

  // Class to test one instance with a Complex List as property.
  TMyCompositeClass = class(TMyComplexClass)
  private
    aRandomAbove100: integer;
    aTimeStamp: TDateTime;
    aComplexList: TMyComplexClassList<TMyComplexClass>; // Complex list
    class procedure RegisterConverters(aMar: TJsonMarshal); override;
    class procedure RegisterReverters(aUnMar: TJSONUnMarshal); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Assign(aSource: TBaseObj); override;
    procedure SetupData; override;
    property pRandomAbove100: integer read aRandomAbove100 write aRandomAbove100;
    property pTimeStamp: TDateTime read aTimeStamp write aTimeStamp;
    property pComplexList: TMyComplexClassList<TMyComplexClass> read aComplexList write aComplexList;
  end;

var
  initComplexList: TMyComplexClassList<TMyComplexClass>;

implementation

{ TMyClass }

procedure TBaseObj.Assign(aSource: TBaseObj);
begin
  aInteger := aSource.aInteger;
  aString := aSource.aString;
end;

constructor TBaseObj.Create;
begin
  inherited Create;
  aString := '';
  aInteger := 0;
end;

procedure TBaseObj.LoadFromJsonFile(sFileName: String);
var
  aSL: TStringList;
  aObj: TJSONObject;
begin
  aSL := TStringList.Create;
  try
    aSL.LoadFromFile(sFileName);
    aObj := TJSONObject.Create;
    try
      aObj.Parse(TEncoding.ASCII.GetBytes(aSL.Text), 0);
      UnMarshal(aObj);
    finally
      aObj.Free;
    end;
  finally
    aSL.Free;
  end;
end;

function TBaseObj.Marshal: TJSONObject;
var
  FMar : TJsonMarshal;
begin
  FMar := TJsonMarshal.Create;
  try
    RegisterConverters(FMar);
    try
      Result := FMar.Marshal(Self) as TJSONObject;
    except
      Result := nil;
    end;
  finally
    FMar.Free;
  end;
end;

class procedure TBaseObj.RegisterConverters(aMar: TJsonMarshal);
begin
  // none yet - abstract?
end;

class procedure TBaseObj.RegisterReverters(aUnMar: TJSONUnMarshal);
begin
  // none yet - abstract ?
end;

function TBaseObj.SaveToJsonFile(sFileName: String; bOverWriteIfExists: Boolean): Boolean;
var
  aSL: TStringList; // makes it easy to save a file :-)
  aJObj: TJSONObject;
begin
  if not(bOverWriteIfExists) and (FileExists(sFileName)) then
    Exit(false);
  aSL := TStringList.Create;
  try
    aJObj := Marshal;
    try
      aSL.Add(aJObj.ToString);
      aSL.SaveToFile(sFileName);
      Result := true;
    finally
      aJObj.Free;
    end;
  finally
    aSL.Free;
  end;
end;

procedure TBaseObj.SetupData;
begin
  aString := 'Created : ' + FormatDateTime('ddmmyyyy hhnnss_zzz', now);
  aInteger := Random(100);
end;

procedure TBaseObj.UnMarshal(aJsonObj: TJSONObject);
var
  tmpObj: TBaseObj;
  FUnMar : TJSONUnMarshal;
begin
  FUnMar := TJSONUnMarshal.Create;
  try
    RegisterReverters(FUnMar);
    try
      tmpObj := TBaseObj(FUnMar.UnMarshal(aJsonObj)); // MUST USE CAST ... not as ... as uses RTTI and therefore needs info about class.
      try
        try
          Assign(tmpObj);
        except
          on e: Exception do
            raise Exception.Create('ERROR - UnMarshal MyClass(Assign) : ' + e.Message);
        end;
      finally
        tmpObj.Free;
      end;
    except
      on e: Exception do
        raise Exception.Create('ERROR - UnMarshal MyClass : ' + e.Message);
    end;
  finally
    FUnMar.Free;
  end;
end;

{ TMyComplexClass }

procedure TMyComplexClass.Assign(aSource: TBaseObj);
var
  aStr: String;
  aCC: TMyComplexClass;
begin
  inherited Assign(aSource);
  aStringList.Clear;
  aCC := aSource as TMyComplexClass;
  for aStr in aCC.aStringList do
    aStringList.Add(aStr);
end;

constructor TMyComplexClass.Create;
begin
  inherited Create;
  aStringList := TStringList.Create;
end;

destructor TMyComplexClass.Destroy;
begin
  aStringList.Free;
  inherited;
end;

class procedure TMyComplexClass.RegisterConverters(aMar: TJsonMarshal);
begin
  inherited;
  // register class specifik converters here.
  aMar.RegisterConverter(TStringList,
    function(Data: TObject): TListOfStrings
    var
      i, Count: integer;
    begin
      Count := TStringList(Data).Count;
      SetLength(Result, Count);
      for i := 0 to Count - 1 do
        Result[i] := TStringList(Data)[i];
    end);
end;

class procedure TMyComplexClass.RegisterReverters(aUnMar: TJSONUnMarshal);
begin
  inherited;
  // register class specific reverters here
  aUnMar.RegisterReverter(TStringList,
    function(Data: TListOfStrings): TObject
    var
      StrList: TStringList;
      Str: string;
    begin
      StrList := TStringList.Create;
      for Str in Data do
        StrList.Add(Str);
      Result := StrList;
    end);
end;

procedure TMyComplexClass.SetupData;
var
  i: integer;
begin
  inherited SetupData;
  for i := 0 to aInteger do
    aStringList.Add(IntToStr(aInteger) + ' - Text - ' + IntToStr(i));
end;

{ TMyClassList<T> }

procedure TMyClassList<T>.Populate100Elements;
var
  i: integer;
  Element: T;
begin
  for i := 1 to 100 do
  begin
    Element := T.Create;
    Element.SetupData;
    Add(Element);
  end;
end;

function TMyClassList<T>.SaveToJsonFile(sFileName: String; bOverWriteIfExists: Boolean): Boolean;
var
  aSL: TStringList;
  aJObj: TJSONObject;
begin
  if not(bOverWriteIfExists) and (FileExists(sFileName)) then
    Exit(false);
  aSL := TStringList.Create;
  try
    aJObj := Marshal;
    try
      aSL.Add(aJObj.ToString);
      aSL.SaveToFile(sFileName);
      Result := true;
    finally
      aJObj.Free;
    end;
  finally
    aSL.Free;
  end;
end;

procedure TMyClassList<T>.UnMarshal(aJsonObj: TJSONObject);
var
  tmpList: TMyClassList<T>;
  FUnMar : TJSONUnMarshal;
begin
  FUnMar := TJSONUnMarshal.Create;
  try
    RegisterReverters(FUnMar);
    try
      tmpList := TMyClassList<T>(FUnMar.UnMarshal(aJsonObj)); // MUST CAST .. not use as ... since as uses RTTI ???
      try
        try
          Assign(tmpList);
        except
          on e: Exception do
            raise Exception.Create('ERROR - TMyClassList.UnMarshal(Assign) : ' + e.Message);
        end;
      finally
        tmpList.Free;
      end;
    except
      on e: Exception do
        raise Exception.Create('ERROR - TMyClassList.UnMarshal : ' + e.Message);
    end;
  finally
    FUnMar.Free;
  end;
end;

function TMyClassList<T>.AsBaseList: TMyClassList<TBaseObj>;
var
  Element: T;
  NewBase: TBaseObj;
begin
  Result := TMyClassList<TBaseObj>.Create;
  Result.OwnsObjects := false;
  for Element in Self do
  begin
    NewBase := Element;
    Result.Add(NewBase);
  end;
end;

procedure TMyClassList<T>.Assign(aSource: TMyClassList<T>);
var
  newObj, Element: T;
begin
  Clear; // delete data - if present
  for Element in aSource do
  begin
    newObj := T.Create;
    newObj.Assign(Element);
    Add(newObj);
  end;
end;

constructor TMyClassList<T>.Create;
begin
  inherited Create; // WARNING .... specify create here - otherwise we leak mem ???? WHY ?  (seen in XE2)
end;

procedure TMyClassList<T>.LoadFromJsonFile(sFileName: String);
var
  aSL: TStringList;
  aObj: TJSONObject;
begin
  aSL := TStringList.Create;
  try
    aSL.LoadFromFile(sFileName);
    aObj := TJSONObject.Create;
    try
      aObj.Parse(TEncoding.ASCII.GetBytes(aSL.Text), 0);
      UnMarshal(aObj);
    finally
      aObj.Free;
    end;
  finally
    aSL.Free;
  end;
end;

function TMyClassList<T>.Marshal: TJSONObject;
var
  FMar : TJsonMarshal;
begin
  FMar := TJsonMarshal.Create;
  try
    RegisterConverters(FMar);
    try
      Result := FMar.Marshal(Self) as TJSONObject;
    except
      Result := nil;
    end;
  finally
    FMar.Free;
  end;
end;

class procedure TMyClassList<T>.RegisterConverters(aMar: TJsonMarshal);
begin
  // call class method to get element converters registered with list marshaller
  T.RegisterConverters(aMar); // class method - Register element specific converters.
end;

class procedure TMyClassList<T>.RegisterReverters(aUnMar: TJSONUnMarshal);
begin
  // List property specific reverters goes here
  // call class method to get element reverters registered with list unmarshaller
  T.RegisterReverters(aUnMar); // class method - Register element specific reverters.
end;

{ TMyComplexClassList<T> }

procedure TMyComplexClassList<T>.Assign(aSource: TMyClassList<T>);
begin
  inherited Assign(aSource);
end;

constructor TMyComplexClassList<T>.Create;
begin
  inherited Create;

end;

{ TMyListComplexClass }

procedure TMyCompositeClass.Assign(aSource: TBaseObj);
var
  aCC: TMyCompositeClass;
begin
  inherited Assign(aSource);
  aCC := aSource as TMyCompositeClass;
  aRandomAbove100 := aCC.aRandomAbove100;
  aTimeStamp := aCC.aTimeStamp;
  aComplexList.Assign(aCC.aComplexList);
end;

constructor TMyCompositeClass.Create;
begin
  inherited Create;
  aRandomAbove100 := 0;
  aTimeStamp := 0;
  aComplexList := TMyComplexClassList<TMyComplexClass>.Create;
end;

destructor TMyCompositeClass.Destroy;
begin
  aComplexList.Free;
  inherited;
end;

class procedure TMyCompositeClass.RegisterConverters(aMar: TJsonMarshal);
begin
  inherited;
  aMar.RegisterConverter(Self, 'aTimeStamp',
    function(Data: TObject; Field: String): string
    begin
      Result := FormatDateTime('yyyy-mm-dd hh:nn:ss:zzz', TMyCompositeClass(Data).aTimeStamp);
    end);

  TMyComplexClassList<TMyComplexClass>.RegisterConverters(aMar);
end;

class procedure TMyCompositeClass.RegisterReverters(aUnMar: TJSONUnMarshal);
begin
  inherited;
  aUnMar.RegisterReverter(Self, 'aTimeStamp',
    procedure(Data: TObject; Field: string; Arg: string)
    begin
      TMyCompositeClass(Data).aTimeStamp := EncodeDateTime(StrToInt(Copy(Arg, 1, 4)), StrToInt(Copy(Arg, 6, 2)), StrToInt(Copy(Arg, 9, 2)), StrToInt(Copy(Arg, 12, 2)),
        StrToInt(Copy(Arg, 15, 2)), StrToInt(Copy(Arg, 18, 2)), StrToInt(Copy(Arg, 21, 3)));
    end);

  TMyComplexClassList<TMyComplexClass>.RegisterReverters(aUnMar);
end;

procedure TMyCompositeClass.SetupData;
begin
  inherited SetupData;
  aRandomAbove100 := Random(1000) + 100;
  aTimeStamp := now;
  aComplexList.Populate100Elements;
end;

initialization

initComplexList := TMyComplexClassList<TMyComplexClass>.Create;

finalization

initComplexList.Free;

end.
