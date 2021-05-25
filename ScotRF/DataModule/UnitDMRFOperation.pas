unit UnitDMRFOperation;

interface

uses
  System.SysUtils, System.Classes, UnitDMTemplate, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDMRFOperation = class(TDMTemplate)
    CDSItemsRFOPERATIONID: TIntegerField;
    CDSItemsRFOPERATION: TSmallintField;
    CDSItemsDESCRIPTION: TStringField;
    CDSItemsSITEID: TIntegerField;
    CDSItemsROLLFORMERID: TIntegerField;
    CDSItemsSTATUSID: TSmallintField;
    CDSItemsADDEDON: TSQLTimeStampField;
    procedure CDSItemsNewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddData(anObject: TObject );override;
  end;

var
  DMRFOperation: TDMRFOperation;

implementation

uses FrameDataU, Usettings, ManufactureU, ScotRFTypes, RollFormerU
, DateUtils, Com_Exception;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMRFOperation.AddData(anObject: TObject );
begin
  if DriveClass<>tdcSim then
  try
    if not CDSItems.Active then
      CDSItems.Open;
    CDSItems.Append;
    CDSItems.FieldByName('RFOPERATION').AsInteger  := Integer(TRFOperation(anObject).Process);
    CDSItems.FieldByName('DESCRIPTION').AsString   := TRFOperation(anObject).Description;
    CDSItems.FieldByName('SITEID').AsInteger       := StrToInt(SiteID);
    CDSItems.FieldByName('ROLLFORMERID').AsInteger := StrToInt(ROLLFORMER.RollFormerID);
    CDSItems.FieldByName('ADDEDON').AsDateTime     := Now;
    CDSItems.Post;
  except
    on E: Exception do
      HandleException(e,'TDMRFOperation.AddData',[]);
  end;
end;

procedure TDMRFOperation.CDSItemsNewRecord(DataSet: TDataSet);
begin
  inherited;
  CDSItems.FieldByName('RFOPERATIONID').AsInteger := FTEMPID;
end;

procedure TDMRFOperation.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FTableName := aRFOperation;
  try
    CDSItems.FetchParams;
    CDSItems.Params[0].AsInteger:=1;
    CDSItems.Params[1].AsDateTime:=0;
    CDSItems.Params[2].AsDateTime:=EndOfTheDay(Now);
  except
    on E: Exception do
      HandleException(e,'TDMRFOperation.DataModuleCreate',[]);
  end;
end;

end.
