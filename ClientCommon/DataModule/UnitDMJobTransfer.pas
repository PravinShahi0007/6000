unit UnitDMJobTransfer;

interface

uses
  System.SysUtils, System.Classes, UnitDMTemplate, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.DB,
  Datasnap.DBClient;

type
  TDMJobTransfer = class(TDMTemplate)
    procedure DataModuleCreate(Sender: TObject);
    procedure FDMemTableItemsNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    procedure GetFDMemTableItems;
    procedure ApplyUpdates;override;
  public
    { Public declarations }
    procedure AddData(anObject: TObject );override;
    function GetNewRecordID: Integer;override;

  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses Com_Exception, FrameDataU, UnitDMDesignJob, Data.FireDACJSONReflect,
  ScotRFTypes;


procedure TDMJobTransfer.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FTableName := aJobTransfer;
  GetFDMemTableItems;
end;

procedure TDMJobTransfer.FDMemTableItemsNewRecord(DataSet: TDataSet);
begin
  inherited;
  FDMemTableItems.FieldByName('JOBTRANSFERID').AsInteger := FTEMPID;
end;

procedure TDMJobTransfer.GetFDMemTableItems;
begin
  DMScotServer.GetJobTRANSFER(0,1,0,Now, FDMemTableItems);
end;

procedure TDMJobTransfer.ApplyUpdates;
begin
  inherited;
  GetFDMemTableItems;
end;

procedure TDMJobTransfer.AddData(anObject: TObject );
begin
  if not FDMemTableItems.Active then
    FDMemTableItems.Open;
  FDMemTableItems.Append;
  FDMemTableItems.FieldByName('JOBID').AsInteger             := TJOBTRANSFER(anObject).JOBID;
  FDMemTableItems.FieldByName('EP2FILEID').AsInteger         := TJOBTRANSFER(anObject).EP2FILEID;
  FDMemTableItems.FieldByName('FRAMEID').AsInteger           := TJOBTRANSFER(anObject).FrameID;
  FDMemTableItems.FieldByName('FRAMEENTITYID').AsInteger     := TJOBTRANSFER(anObject).FRAMEENTITYID;
  FDMemTableItems.FieldByName('FROMROLLFORMERID').AsInteger  := TJOBTRANSFER(anObject).FROMROLLFORMERID;
  FDMemTableItems.FieldByName('TOROLLFORMERID').AsInteger    := TJOBTRANSFER(anObject).TOROLLFORMERID;
  FDMemTableItems.FieldByName('STATUSID').AsInteger          := TJOBTRANSFER(anObject).STATUSID;
  FDMemTableItems.FieldByName('SITEID').AsInteger            := TJOBTRANSFER(anObject).SITEID;
  FDMemTableItems.FieldByName('ADDEDON').AsDateTime          := Now;
  ApplyUpdates;
end;

function TDMJobTransfer.GetNewRecordID: Integer;
begin
  inherited;
  result := DMScotServer.GetNewAutoID('GEN_JOBTRANSFERID')
end;



end.
