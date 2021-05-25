unit UnitDMJOBDETAIL;

interface

uses
  System.SysUtils, System.Classes, UnitDMTemplate, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Data.FMTBcd, Datasnap.Provider, Data.SqlExpr,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDMJOBDETAIL = class(TDMTemplate)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GetFDMemTableItems;
  public
    { Public declarations }
    procedure AddData(anObject: TObject );override;
  end;

var
  DMJOBDETAIL: TDMJOBDETAIL;

implementation

USES Usettings, ScotRFTypes, FrameDataU, DateUtils, Com_Exception,
  UnitDMDesignJob, Data.FireDACJSONReflect;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMJOBDETAIL.GetFDMemTableItems;
begin
  DMScotServer.GetJOBDETAIL(0,1,0,Now,FDMemTableItems);
end;

procedure TDMJOBDETAIL.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FTableName := aJOBDETAIL;
  GetFDMemTableItems;
end;

procedure TDMJOBDETAIL.AddData(anObject: TObject );
begin
  if DriveClass=tdcSim then
    Exit;
  if not FDMemTableItems.Active then
    FDMemTableItems.Open;
  try
    if not FDMemTableItems.Active then
      FDMemTableItems.Open;
    FDMemTableItems.Append;
    FDMemTableItems.FieldByName('JOBID').AsInteger     := TJOBDETAIL(anObject).JOBID;
    FDMemTableItems.FieldByName('EP2FILEID').AsInteger := TJOBDETAIL(anObject).EP2FILEID;
    FDMemTableItems.FieldByName('FRAMEID').AsInteger   := TJOBDETAIL(anObject).FRAMEID;
    FDMemTableItems.FieldByName('DESIGN').AsString     := TJOBDETAIL(anObject).DESIGN;
    FDMemTableItems.FieldByName('STEEL').AsString      := TJOBDETAIL(anObject).STEEL;
    FDMemTableItems.FieldByName('OPERATOR').AsString   := TJOBDETAIL(anObject).WORKER;
    FDMemTableItems.FieldByName('RIVERTER').AsString   := TJOBDETAIL(anObject).RIVERTER;
    FDMemTableItems.FieldByName('COILID').AsString     := TJOBDETAIL(anObject).COILID;
    FDMemTableItems.FieldByName('GAUGE').AsString      := TJOBDETAIL(anObject).GAUGE;
    FDMemTableItems.FieldByName('WEIGHT').AsString     := TJOBDETAIL(anObject).WEIGHT;
{$IFDEF PANEL}
    FDMemTableItems.FieldByName('RFTYPEID').AsInteger     := ord(rfPanel);
{$ELSE}
    FDMemTableItems.FieldByName('RFTYPEID').AsInteger     := ord(rfTruss);
{$ENDIF}
    FDMemTableItems.FieldByName('SITEID').AsInteger    := StrToInt(Site_ID);
    FDMemTableItems.FieldByName('ADDEDON').AsDateTime  := Now;
    FDMemTableItems.Post;
  except
    on E: Exception do
      HandleException(e,'TDMJOBDETAIL.AddData',[]);
  end;
end;


end.
