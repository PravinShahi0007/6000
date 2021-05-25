unit UnitDMTemplate;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, Forms
  , Vcl.ActnList, Dialogs, DBXCommon
  , StdCtrls, Controls, ExtCtrls, ComCtrls,
  Datasnap.DSConnect, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.FireDACJSONReflect,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin;

type
  TDMTemplate = class(TDataModule)
    FDMemTableItems: TFDMemTable;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDMemTableItemsNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  protected
    FTEMPID       : Integer;
    FTableName    : String;
    function GetNewRecordID: Integer;virtual;abstract;
    function GetNewAutoID(gen_fields_id: String): Integer;
    procedure GetFDMemTableItems;virtual;abstract;
    function  GetDeltas: TFDJSONDeltas;
    procedure ApplyUpdates;virtual;
  public
    { Public declarations }
    function  StripNonAsciiExceptCRLF(const Value: AnsiString): AnsiString;
    procedure ActionCreateExecute(Sender: TObject);
    procedure ActionReadExecute(Sender: TObject);
    procedure ActionUpdateExecute(Sender: TObject);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure ActionCommitExecute(Sender: TObject);
    procedure ActionCancelExecute(Sender: TObject);
    procedure ActionExitExecute(Sender: TObject);
    procedure AddData(anObject: TObject );virtual;
    property  NewRecordID  : Integer read GetNewRecordID;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses DateUtils, Com_Exception, ScotRFTypes;

function TDMTemplate.StripNonAsciiExceptCRLF(const Value: AnsiString): AnsiString;
var
  AnsiCh: AnsiChar;
begin
  for AnsiCh in Value do
    if (AnsiCh >= #32) and (AnsiCh <= #127) and (AnsiCh <> #13) and (AnsiCh <> #10) then
      Result := Result + AnsiCh;
end;

function  TDMTemplate.GetDeltas : TFDJSONDeltas;
begin
  // Post if editing
  if FDMemTableItems.State in dsEditModes then
  begin
    FDMemTableItems.Post;
  end;
  // Create a delta list
  Result := TFDJSONDeltas.Create;
  TFDJSONDeltasWriter.ListAdd(Result, FTableName, FDMemTableItems);
end;

procedure TDMTemplate.ApplyUpdates;
begin
  Try
    DMScotServer.ApplyUpdates(FTableName, FDMemTableItems);
  except
    on E: Exception do
      HandleException(E, 'TDMTemplate.ApplyUpdates', []);
  end;
end;

procedure TDMTemplate.DataModuleCreate(Sender: TObject);
begin
  FDMemTableItems.CachedUpdates := True;
  FTempID :=-1;
end;

procedure TDMTemplate.FDMemTableItemsNewRecord(DataSet: TDataSet);
begin
  DEC(FTEMPID);
  try
    FDMemTableItems.FieldByName('STATUSID').AsInteger := 0;
  except
    on E: Exception do
      HandleException(e,'TDMTemplate.FDMemTableItemsNewRecord',[]);
  end;
end;

procedure TDMTemplate.ActionExitExecute(Sender: TObject);
begin
  TForm(TAction(Sender).Owner).Close;
end;

procedure TDMTemplate.ActionCreateExecute(Sender: TObject);
begin
end;

procedure TDMTemplate.ActionReadExecute(Sender: TObject);
begin
end;

procedure TDMTemplate.ActionUpdateExecute(Sender: TObject);
begin
end;

procedure TDMTemplate.ActionDeleteExecute(Sender: TObject);
begin
  if not FDMemTableItems.IsEmpty then
    FDMemTableItems.Delete;
end;

procedure TDMTemplate.ActionCommitExecute(Sender: TObject);
begin
end;

procedure TDMTemplate.ActionCancelExecute(Sender: TObject);
begin
end;

procedure TDMTemplate.AddData(anObject: TObject );
begin
end;

function TDMTemplate.GetNewAutoID(gen_fields_id: String): Integer;
begin
end;

end.
