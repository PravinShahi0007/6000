unit UnitDMEXPORTEP2FILE;

interface

uses
  System.SysUtils, System.Classes, UnitDMTemplate, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Data.FMTBcd, Datasnap.Provider, Data.SqlExpr,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, UnitDMDesignJob,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin;

type
  TDMEXPORTEP2FILE = class(TDMTemplate)
    procedure CDSItemsNewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure StoreBlob (aFileName, aFieldName: string);
    procedure GetFDMemTableItems;
  public
    { Public declarations }
    function GetNewRecordID: Integer;
    procedure AddData(anObject: TObject );override;
    procedure ApplyUpdates;

  end;

var
  DMEXPORTEP2FILE: TDMEXPORTEP2FILE;

implementation

uses FrameDataU, Usettings, Com_Exception, Data.FireDACJSONReflect,
  ScotRFTypes, UnitDMRollFormer;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMEXPORTEP2FILE.StoreBlob(aFileName, aFieldName: string);
var
  aBlob : TStream;
  myFileStream : TStream;
begin
  aBlob := FDMemTableItems.CreateBlobStream(FDMemTableItems.FieldByName(aFieldName), bmWrite);
  try
    aBlob.Seek(0, soFromBeginning);
    myFileStream := TFileStream.Create(aFileName, fmShareDenyWrite);
    try
      aBlob.CopyFrom(myFileStream, myFileStream.Size);
    finally
      myFileStream.Free;
    end;
  finally
    aBlob.Free;
  end;
end;

procedure TDMEXPORTEP2FILE.ApplyUpdates;
begin
  inherited;
  GetFDMemTableItems;
end;

procedure TDMEXPORTEP2FILE.AddData(anObject: TObject );
begin
  Inherited;
  try
    if not FDMemTableItems.Active then
      FDMemTableItems.Open;
    FDMemTableItems.Append;
    FDMemTableItems.FieldByName('EP2FILE').AsString         := ExtractFileName(TEXPORTFILE(anObject).EXPORTFILE);
    StoreBlob(TEXPORTFILE(anObject).EXPORTTEXT, 'EP2TEXT');
    FDMemTableItems.FieldByName('JOBID').AsInteger          := TEXPORTFILE(anObject).JobID;
    FDMemTableItems.FieldByName('STATUSID').AsInteger       := 0;
{$IFDEF PANEL}
    FDMemTableItems.FieldByName('RFTYPEID').AsInteger       := Ord(rfPanel);
{$ELSE}
    FDMemTableItems.FieldByName('RFTYPEID').AsInteger       := Ord(rfTruss);
{$ENDIF}
    FDMemTableItems.FieldByName('SITEID').AsInteger         := 1;
    FDMemTableItems.FieldByName('ROLLFORMERID').AsInteger   := TEXPORTFILE(anObject).RollFormerID;
    FDMemTableItems.FieldByName('TRANSFERTORFID1').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID2').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID3').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID4').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID5').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID6').AsInteger := 0;
    FDMemTableItems.FieldByName('ADDEDON').AsDateTime       := Now;
    ApplyUpdates;
  except
    on E: Exception do
      HandleException(e,'TDMEXPORTEP2FILE.AddData',[]);
  end;
end;

procedure TDMEXPORTEP2FILE.GetFDMemTableItems;
begin
  DMScotServer.GetEP2File(0,1,0,Now,FDMemTableItems);
end;

procedure TDMEXPORTEP2FILE.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FTableName := aEP2File;
  GetFDMemTableItems;
end;

procedure TDMEXPORTEP2FILE.CDSItemsNewRecord(DataSet: TDataSet);
begin
  inherited;
  FDMemTableItems.FieldByName('EP2FILEID').AsInteger := FTEMPID;
end;

function TDMEXPORTEP2FILE.GetNewRecordID: Integer;
begin
  inherited;
  result := DMScotServer.GetNewAutoID('GEN_EP2FILEID')
end;

end.
