unit UnitDMEXPORTFRAMEENTITY;

interface

uses
  System.SysUtils, System.Classes, UnitDMTemplate, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, GlobalU, Data.FMTBcd, Datasnap.Provider, Data.SqlExpr,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDMEXPORTFRAMEENTITY = class(TDMTemplate)
    procedure CDSItemsNewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GetFDMemTableItems;

  public
    { Public declarations }
    procedure AddEntity(anEntity: EntityRecType );
    procedure ApplyUpdates;
    function GetNewRecordID: Integer;
  end;

var
  DMEXPORTFRAMEENTITY: TDMEXPORTFRAMEENTITY;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses Usettings, ScotRFTypes, Com_Exception, UnitDMDesignJob, Data.FireDACJSONReflect;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMEXPORTFRAMEENTITY.GetFDMemTableItems;
begin
  DMScotServer.GetFRAMEENTITY(0,1,0,Now,FDMemTableItems);
end;

procedure TDMEXPORTFRAMEENTITY.ApplyUpdates;
begin
  inherited;
  GetFDMemTableItems;
end;

procedure TDMEXPORTFRAMEENTITY.AddEntity(anEntity: EntityRecType );
begin
  try
    if not FDMemTableItems.Active then
      FDMemTableItems.Open;
    FDMemTableItems.Append;
    FDMemTableItems.FieldByName('ITEMNAME').AsString         := anEntity.Item;
    FDMemTableItems.FieldByName('FRAMENAME').AsString        := anEntity.Truss;
    FDMemTableItems.FieldByName('FRAMETYPE').AsString        := anEntity.iType;
    FDMemTableItems.FieldByName('ID').AsInteger              := anEntity.ID;
    FDMemTableItems.FieldByName('JOBID').AsInteger           := anEntity.JOBID;
    FDMemTableItems.FieldByName('EP2FILEID').AsInteger       := anEntity.EP2FILEID;
    FDMemTableItems.FieldByName('FRAMEID').AsInteger         := anEntity.FrameID;
    FDMemTableItems.FieldByName('POINT1X').AsFloat           := anEntity.Pt[1].x;
    FDMemTableItems.FieldByName('POINT1Y').AsFloat           := anEntity.Pt[1].y;
    FDMemTableItems.FieldByName('POINT2X').AsFloat           := anEntity.Pt[2].x;
    FDMemTableItems.FieldByName('POINT2Y').AsFloat           := anEntity.Pt[2].y;
    FDMemTableItems.FieldByName('POINT3X').AsFloat           := anEntity.Pt[3].x;
    FDMemTableItems.FieldByName('POINT3Y').AsFloat           := anEntity.Pt[3].y;
    FDMemTableItems.FieldByName('POINT4X').AsFloat           := anEntity.Pt[4].x;
    FDMemTableItems.FieldByName('POINT4Y').AsFloat           := anEntity.Pt[4].y;
    FDMemTableItems.FieldByName('LENGTH').AsFloat            := anEntity.Len;
    FDMemTableItems.FieldByName('WEB').AsFloat               := anEntity.Web;
    FDMemTableItems.FieldByName('COL').AsInteger             := anEntity.Col;
    FDMemTableItems.FieldByName('OPCOUNT').AsInteger         := anEntity.OpCount;
    FDMemTableItems.FieldByName('ORIENTATION').AsInteger     := Integer(anEntity.Orientation);
    FDMemTableItems.FieldByName('NONRF').AsInteger           := Integer(anEntity.bNonRF);
    FDMemTableItems.FieldByName('ISFACINGITEM').AsInteger    := Integer(anEntity.bIsFacingItem);
{$IFDEF PANEL}
    FDMemTableItems.FieldByName('RFTYPEID').AsInteger     := ord(rfPanel);
{$ELSE}
    FDMemTableItems.FieldByName('RFTYPEID').AsInteger     := ord(rfTruss);
{$ENDIF}
    FDMemTableItems.FieldByName('STATUSID').AsInteger        := 0;
    FDMemTableItems.FieldByName('SITEID').AsInteger          := StrToIntDef(Site_ID, 1);
    FDMemTableItems.FieldByName('ADDEDON').AsDateTime        := Now;
  except
    on E: Exception do
      HandleException(e,'TDMEXPORTFRAMEENTITY.AddEntity',[]);
  end;
end;

procedure TDMEXPORTFRAMEENTITY.CDSItemsNewRecord(DataSet: TDataSet);
begin
  inherited;
  FDMemTableItems.FieldByName('FRAMEENTITYID').AsInteger := FTEMPID;
end;

procedure TDMEXPORTFRAMEENTITY.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FTableName := aFRAMEENTITY;
  GetFDMemTableItems;
end;

function TDMEXPORTFRAMEENTITY.GetNewRecordID: Integer;
begin
  inherited;
  result := DMScotServer.GetNewAutoID('GEN_FRAMEENTITYID')
end;

end.
