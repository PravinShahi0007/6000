//Use for Object eg. Customer. Location
unit BaseObject;

interface

uses Data.DBXJSON, Data.DBXJSONReflect, System.JSON
, DBClient, SysUtils, Classes;

type

  TBaseObject = class(TObject)
  private
    { private declarations }
  protected
    { protected declarations }
    FClientDataset : TClientDataset;
  public
    { public declarations }
    class function ObjectToJSON<T : class>(MyObject: T; AMarshal : TJSONMarshal): TJSONValue;
    class function JSONToObject<T : class>(Json: TJSONValue; AUnMarshal: TJSONUnMarshal): T;
    constructor create();virtual;
    constructor CreateWithDataSet(aDataSet : TClientDataset);virtual;
    destructor  Destroy();virtual;
    property ClientDataset : TClientDataset read FClientDataset write FClientDataset;
  end;

implementation

{ TBaseObject }
//
class function TBaseObject.ObjectToJSON<T>(MyObject: T; AMarshal : TJSONMarshal): TJSONValue;
var
  Marshal: TJSONMarshal;
begin
  if Assigned(MyObject) then
  begin
    if Assigned(AMarshal) then
       Marshal := AMarshal
    else
       Marshal := TJSONMarshal.Create(TJSONConverter.Create);
    try
      exit(Marshal.Marshal(MyObject));
    finally
      if not Assigned(AMarshal) then
         Marshal.Free;
    end;
  end
  else
    exit(TJSONNull.Create);
end;
//
class function TBaseObject.JSONToObject<T>(Json: TJSONValue; AUnMarshal: TJSONUnMarshal): T;
var
  UnMarshal: TJSONUnMarshal;
begin
  if Json is TJSONNull then
    exit(nil);
  if Assigned(AUnMarshal) then
     UnMarshal := AUnMarshal
  else
     UnMarshal := TJSONUnMarshal.Create;
  try
    exit(T(UnMarshal.Unmarshal(Json)))
  finally
    if not Assigned(AUnMarshal) then
       UnMarshal.Free;
  end;
end;
//
destructor TBaseObject.Destroy();
begin
  inherited;
end;

constructor TBaseObject.create();
begin
  inherited;
end;

constructor TBaseObject.CreateWithDataSet(aDataSet : TClientDataset);
begin
  inherited create;
  FClientDataset := aDataSet;
end;


end.
