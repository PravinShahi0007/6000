unit Product;

interface

uses DBXJSON, DBXJSONReflect, SysUtils, BaseObject
, Data.SQLExpr, rtti, MarshalUnsupportedFields
, Classes, DBClient;

Type

  TSearchResult = (srNone,srProductCode,srPrimaryBarcode,srBarcode);

  TProducts = class(TBaseObject)
  private
    { Private declarations }
    FOnChange                  : TNotifyEvent;
    Function GetPRODUCTID      : Integer;
    Function GetSTORENO        : SmallInt;
    Function GetSTOREPRODUCTID : Integer;
    Function GetADDEDON        : TDatetime;
    Function GetTYPEID         : SmallInt;
    Function GetSTATUSID       : SmallInt;
    Function GetCODE           : String;
    Function GetDESCRIPTION    : String;
    Function GetCATEGORYID     : SmallInt;
    Function GetDEPARTMENTID   : SmallInt;
    Function GetSTYLE1ID       : SmallInt;
    Function GetSTYLE2ID       : SmallInt;
    Function GetMODEL          : String;
    Function GetWEIGHT         : Double;
    Function GetTAXID          : SmallInt;
    Function GetPRICE1         : Double;
    Function GetPRICE2         : Double;
    Function GetPRICE3         : Double;
    Function GetVENDOR         : String;
    Function GetVENDORCODE     : String;
    Function GetVENDORCOST     : Double;
    Function GetREORDERLEVEL   : Double;
    Function GetREORDERQTY     : Double;
    Function GetLASTCOST       : Double;
    Function GetLOCATIONID     : Integer;
    Function GetLOYALTYPOINTS  : SmallInt;
    Function GetWEIGHED        : SmallInt;

    procedure SetPRODUCTID(aInteger : integer);
    procedure SetSTORENO(aInteger : SmallInt);
    procedure SetSTOREPRODUCTID(aInteger : integer);
    procedure SetADDEDON(aDateTime : TDatetime);
    procedure SetTYPEID(aInteger : SmallInt);
    procedure SetSTATUSID(aInteger : SmallInt);
    procedure SetCODE(aString: string);
    procedure SetDESCRIPTION(aString: string);
    procedure SetCATEGORYID(aInteger : SmallInt);
    procedure SetDEPARTMENTID(aInteger : SmallInt);
    procedure SetSTYLE1ID(aInteger : SmallInt);
    procedure SetSTYLE2ID(aInteger : SmallInt);
    procedure SetMODEL(aString: string);
    procedure SetWEIGHT(aDouble : Double);
    procedure SetTAXID(aInteger : SmallInt);
    procedure SetPRICE1(aDouble : Double);
    procedure SetPRICE2(aDouble : Double);
    procedure SetPRICE3(aDouble : Double);
    procedure SetVENDOR(aString: string);
    procedure SetVENDORCODE(aString: string);
    procedure SetVENDORCOST(aDouble : Double);
    procedure SetREORDERLEVEL(aDouble : Double);
    procedure SetREORDERQTY(aDouble : Double);
    procedure SetLASTCOST(aDouble : Double);
    procedure SetLOCATIONID(aInteger : Integer);
    procedure SetLOYALTYPOINTS(aInteger : SmallInt);
    procedure SetWEIGHED(aInteger : SmallInt);

  protected
    { Public declarations }
    procedure DoChange; dynamic;

  public
    { protected declarations }
    procedure Find(sString : String);
    Property PRODUCTID      : Integer read GetPRODUCTID write SetPRODUCTID ;
    Property STORENO        : SmallInt read GetSTORENO write SetSTORENO ;
    Property STOREPRODUCTID : Integer read GetSTOREPRODUCTID write SetSTOREPRODUCTID ;
    Property ADDEDON        : TDatetime read GetADDEDON write SetADDEDON ;
    Property TYPEID         : SmallInt read GetTYPEID write SetTYPEID ;
    Property STATUSID       : SmallInt read GetSTATUSID write SetSTATUSID ;
    Property CODE           : String read GetCODE write SetCODE ;
    Property DESCRIPTION    : String read GetDESCRIPTION write SetDESCRIPTION ;
    Property CATEGORYID     : SmallInt read GetCATEGORYID write SetCATEGORYID ;
    Property DEPARTMENTID   : SmallInt read GetDEPARTMENTID write SetDEPARTMENTID ;
    Property STYLE1ID       : SmallInt read GetSTYLE1ID write SetSTYLE1ID ;
    Property STYLE2ID       : SmallInt read GetSTYLE2ID write SetSTYLE2ID ;
    Property MODEL          : String read GetMODEL write SetMODEL ;
    Property WEIGHT         : Double read GetWEIGHT write SetWEIGHT ;
    Property TAXID          : SmallInt read GetTAXID write SetTAXID ;
    Property PRICE1         : Double read GetPRICE1 write SetPRICE1 ;
    Property PRICE2         : Double read GetPRICE2 write SetPRICE2 ;
    Property PRICE3         : Double read GetPRICE3 write SetPRICE3 ;
    Property VENDOR         : String read GetVENDOR write SetVENDOR ;
    Property VENDORCODE     : String read GetVENDORCODE write SetVENDORCODE ;
    Property VENDORCOST     : Double read GetVENDORCOST write SetVENDORCOST ;
    Property REORDERLEVEL   : Double read GetREORDERLEVEL write SetREORDERLEVEL ;
    Property REORDERQTY     : Double read GetREORDERQTY write SetREORDERQTY ;
    Property LASTCOST       : Double read GetLASTCOST write SetLASTCOST ;
    Property LOCATIONID     : Integer read GetLOCATIONID write SetLOCATIONID ;
    Property LOYALTYPOINTS  : SmallInt read GetLOYALTYPOINTS write SetLOYALTYPOINTS ;
    Property WEIGHED        : SmallInt read GetWEIGHED write SetWEIGHED ;
    property OnChange : TNotifyEvent read FOnChange write FOnChange;
    constructor CreateWithDataSet(aDataSet : TClientDataset);override;
  end;

implementation

constructor TProducts.CreateWithDataSet(aDataSet : TClientDataset);
begin
  inherited;
end;

procedure TProducts.Find(sString : String);
begin
  if ClientDataset.FindKey([sString]) then
    DoChange;
end;

procedure  TProducts.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

Function TProducts.GetPRODUCTID      : Integer;
begin
  result := ClientDataSet.FieldByName('PRODUCTID').AsInteger;
end;
Function TProducts.GetSTORENO        : SmallInt;
begin
  result := ClientDataSet.FieldByName('STORENO').AsInteger;
end;
Function TProducts.GetSTOREPRODUCTID : Integer;
begin
  result := ClientDataSet.FieldByName('STOREPRODUCTID').AsInteger;
end;
Function TProducts.GetADDEDON        : TDatetime;
begin
  result := ClientDataSet.FieldByName('ADDEDON').AsInteger;
end;
Function TProducts.GetTYPEID         : SmallInt;
begin
  result := ClientDataSet.FieldByName('TYPEID').AsInteger;
end;
Function TProducts.GetSTATUSID       : SmallInt;
begin
  result := ClientDataSet.FieldByName('STATUSID').AsInteger;
end;
Function TProducts.GetCODE           : String;
begin
  result := ClientDataSet.FieldByName('CODE').AsString;
end;
Function TProducts.GetDESCRIPTION    : String;
begin
  result := ClientDataSet.FieldByName('DESCRIPTION').AsString;
end;
Function TProducts.GetCATEGORYID     : SmallInt;
begin
  result := ClientDataSet.FieldByName('CATEGORYID').AsInteger;
end;
Function TProducts.GetDEPARTMENTID   : SmallInt;
begin
  result := ClientDataSet.FieldByName('DEPARTMENTID').AsInteger;
end;
Function TProducts.GetSTYLE1ID       : SmallInt;
begin
  result := ClientDataSet.FieldByName('STYLE1ID').AsInteger;
end;
Function TProducts.GetSTYLE2ID       : SmallInt;
begin
  result := ClientDataSet.FieldByName('STYLE2ID').AsInteger;
end;
Function TProducts.GetMODEL          : String;
begin
  result := ClientDataSet.FieldByName('MODEL').AsString;
end;
Function TProducts.GetWEIGHT         : Double;
begin
  result := ClientDataSet.FieldByName('WEIGHT').AsFloat;
end;
Function TProducts.GetTAXID          : SmallInt;
begin
  result := ClientDataSet.FieldByName('TAXID').AsInteger;
end;
Function TProducts.GetPRICE1         : Double;
begin
  result := ClientDataSet.FieldByName('PRICE1').AsFloat;
end;
Function TProducts.GetPRICE2         : Double;
begin
  result := ClientDataSet.FieldByName('PRICE2').AsFloat;
end;
Function TProducts.GetPRICE3         : Double;
begin
  result := ClientDataSet.FieldByName('PRICE3').AsFloat;
end;
Function TProducts.GetVENDOR         : String;
begin
  result := ClientDataSet.FieldByName('VENDOR').AsString;
end;
Function TProducts.GetVENDORCODE     : String;
begin
  result := ClientDataSet.FieldByName('VENDORCODE').AsString;
end;
Function TProducts.GetVENDORCOST     : Double;
begin
  result := ClientDataSet.FieldByName('VENDORCOST').AsFloat;
end;
Function TProducts.GetREORDERLEVEL   : Double;
begin
  result := ClientDataSet.FieldByName('REORDERLEVEL').AsFloat;
end;
Function TProducts.GetREORDERQTY     : Double;
begin
  result := ClientDataSet.FieldByName('REORDERQTY').AsFloat;
end;
Function TProducts.GetLASTCOST       : Double;
begin
  result := ClientDataSet.FieldByName('LASTCOST').AsFloat;
end;
Function TProducts.GetLOCATIONID     : Integer;
begin
  result := ClientDataSet.FieldByName('LOCATIONID').AsInteger;
end;
Function TProducts.GetLOYALTYPOINTS  : SmallInt;
begin
  result := ClientDataSet.FieldByName('LOYALTYPOINTS').AsInteger;
end;
Function TProducts.GetWEIGHED        : SmallInt;
begin
  result := ClientDataSet.FieldByName('WEIGHED').AsInteger;
end;

procedure TProducts.SetPRODUCTID(aInteger : integer);
begin

end;
procedure TProducts.SetSTORENO(aInteger : SmallInt);
begin

end;
procedure TProducts.SetSTOREPRODUCTID(aInteger : integer);
begin

end;
procedure TProducts.SetADDEDON(aDateTime : TDatetime);
begin

end;
procedure TProducts.SetTYPEID(aInteger : SmallInt);
begin

end;
procedure TProducts.SetSTATUSID(aInteger : SmallInt);
begin

end;
procedure TProducts.SetCODE(aString: string);
begin

end;
procedure TProducts.SetDESCRIPTION(aString: string);
begin

end;
procedure TProducts.SetCATEGORYID(aInteger : SmallInt);
begin

end;
procedure TProducts.SetDEPARTMENTID(aInteger : SmallInt);
begin

end;
procedure TProducts.SetSTYLE1ID(aInteger : SmallInt);
begin

end;
procedure TProducts.SetSTYLE2ID(aInteger : SmallInt);
begin

end;
procedure TProducts.SetMODEL(aString: string);
begin

end;
procedure TProducts.SetWEIGHT(aDouble : Double);
begin

end;
procedure TProducts.SetTAXID(aInteger : SmallInt);
begin

end;
procedure TProducts.SetPRICE1(aDouble : Double);
begin

end;
procedure TProducts.SetPRICE2(aDouble : Double);
begin

end;
procedure TProducts.SetPRICE3(aDouble : Double);
begin

end;
procedure TProducts.SetVENDOR(aString: string);
begin

end;
procedure TProducts.SetVENDORCODE(aString: string);
begin

end;
procedure TProducts.SetVENDORCOST(aDouble : Double);
begin

end;
procedure TProducts.SetREORDERLEVEL(aDouble : Double);
begin

end;
procedure TProducts.SetREORDERQTY(aDouble : Double);
begin

end;
procedure TProducts.SetLASTCOST(aDouble : Double);
begin

end;
procedure TProducts.SetLOCATIONID(aInteger : Integer);
begin

end;
procedure TProducts.SetLOYALTYPOINTS(aInteger : SmallInt);
begin

end;
procedure TProducts.SetWEIGHED(aInteger : SmallInt);
begin

end;

end.
