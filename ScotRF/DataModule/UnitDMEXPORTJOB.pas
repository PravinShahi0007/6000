unit UnitDMEXPORTJOB;

interface

uses
  System.SysUtils, System.Classes, UnitDMTemplate, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Data.FMTBcd, Datasnap.Provider, Data.SqlExpr, DBXCommon,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, UnitDMDesignJob,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin;

type
  TDMEXPORTJOB = class(TDMTemplate)
    procedure DataModuleCreate(Sender: TObject);
    procedure FDMemTableItemsNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    procedure GetFDMemTableItems;
  protected
  public
    { Public declarations }
    function GetNewRecordID: Integer;override;
    procedure ApplyUpdates;
    procedure AddData(anObject: TObject );override;
  end;

var
  DMEXPORTJOB: TDMEXPORTJOB;

implementation

uses FrameDataU, Usettings, Com_Exception, ScotRFTypes, Data.FireDACJSONReflect,
  UnitDMRollFormer;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMEXPORTJOB.ApplyUpdates;
begin
  inherited;

  GetFDMemTableItems;
end;

procedure TDMEXPORTJOB.AddData(anObject: TObject );
begin
  try
    if not FDMemTableItems.Active then
      FDMemTableItems.Open;
    FDMemTableItems.Append;
    FDMemTableItems.FieldByName('DESIGN').AsString           := TDesignJob(anObject).Design;
    FDMemTableItems.FieldByName('STEEL').AsString            := TDesignJob(anObject).Steel;
    FDMemTableItems.FieldByName('ITEMTYPE').AsString         := TDesignJob(anObject).ItemType;
    FDMemTableItems.FieldByName('ITEMTYPEID').AsInteger      := TDesignJob(anObject).ITEMTYPEID;
    FDMemTableItems.FieldByName('FRAMECOPIES').AsInteger     := TDesignJob(anObject).FRAMECOPIES;
    FDMemTableItems.FieldByName('STARTMEMBER').AsInteger     := TDesignJob(anObject).StartMember;
    FDMemTableItems.FieldByName('LASTMEMBER').AsInteger      := TDesignJob(anObject).LastMember;
    FDMemTableItems.FieldByName('FILEPATH').AsString         := TDesignJob(anObject).FILEPATH;
    FDMemTableItems.FieldByName('ITEMTYPE').AsString         := TDesignJob(anObject).ITEMTYPE;
    FDMemTableItems.FieldByName('RFTYPEID').AsInteger        := Ord(TDesignJob(anObject).RFTYPEID);
    FDMemTableItems.FieldByName('STATUSID').AsInteger        := 0;
    FDMemTableItems.FieldByName('ROLLFORMERID').AsInteger    := TDesignJob(anObject).RollFormerID;
    FDMemTableItems.FieldByName('TRANSFERTORFID1').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID2').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID3').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID4').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID5').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID6').AsInteger := 0;
    FDMemTableItems.FieldByName('SITEID').AsInteger       := StrToIntDef(Site_ID,1);
    FDMemTableItems.FieldByName('ADDEDON').AsDateTime     := Now;
    ApplyUpdates;
  except
    on E: Exception do
      HandleException(e,'TDMEXPORTJOB.AddData',[]);
  end;
end;

procedure TDMEXPORTJOB.GetFDMemTableItems;
begin
  DMScotServer.GetJOB(0,1,0,0,FDMemTableItems);
end;

procedure TDMEXPORTJOB.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FTableName := aJob;
  GetFDMemTableItems;
end;

procedure TDMEXPORTJOB.FDMemTableItemsNewRecord(DataSet: TDataSet);
begin
  inherited;
  FDMemTableItems.FieldByName('JOBID').AsInteger := FTEMPID;
end;

function TDMEXPORTJOB.GetNewRecordID: Integer;
begin
  inherited;
  result := DMScotServer.GetNewAutoID('GEN_JOBID')
end;

end.
