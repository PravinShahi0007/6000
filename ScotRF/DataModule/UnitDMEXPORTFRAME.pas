unit UnitDMEXPORTFRAME;

interface

uses
  System.SysUtils, System.Classes, UnitDMTemplate, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Data.FMTBcd, Data.SqlExpr, Datasnap.Provider,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDMEXPORTFRAME = class(TDMTemplate)
    procedure CDSItemsNewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GetFDMemTableItems;
  public
    { Public declarations }
    function GetNewRecordID: Integer;
    procedure AddData(anObject: TObject );override;
    procedure ApplyUpdates;override;
  end;

var
  DMEXPORTFRAME: TDMEXPORTFRAME;

implementation

uses FrameDataU, Usettings, Com_Exception,
  ScotRFTypes, UnitDMDesignJob, Data.FireDACJSONReflect, UnitDMRollFormer;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMEXPORTFRAME.GetFDMemTableItems;
begin
  DMScotServer.GetFRAME(1,0,Now, FDMemTableItems);
end;

procedure TDMEXPORTFRAME.ApplyUpdates;
begin
  inherited;
  GetFDMemTableItems;
end;

procedure TDMEXPORTFRAME.AddData(anObject: TObject );
begin
  Inherited;
  try
    if not FDMemTableItems.Active then
      FDMemTableItems.Open;
    FDMemTableItems.Append;
    FDMemTableItems.FieldByName('FRAMENAME').AsString        := TSteelFrame(anObject).FrameName;
    FDMemTableItems.FieldByName('EP2FILEID').AsInteger       := TSteelFrame(anObject).EP2FILEID;
    FDMemTableItems.FieldByName('JOBID').AsInteger           := TSteelFrame(anObject).JOBID;
    FDMemTableItems.FieldByName('MINHOLEDISTANCE').AsFloat   := TSteelFrame(anObject).MinHoleDist;
    FDMemTableItems.FieldByName('PROFILEHEIGHT').AsFloat     := TSteelFrame(anObject).ProFileHeight;
    FDMemTableItems.FieldByName('PRECAMBER').AsFloat         := TSteelFrame(anObject).PreCamber;
    FDMemTableItems.FieldByName('PRODUCEDFRAMES').AsInteger  := 0;
    FDMemTableItems.FieldByName('NUMBEROFFRAMES').AsInteger  := TSteelFrame(anObject).NumberOfFrames;
    FDMemTableItems.FieldByName('ITEMCOUNT').AsInteger       := TSteelFrame(anObject).ItemCount;
    FDMemTableItems.FieldByName('PLATEYMIN').AsFloat         := 0.00;
    FDMemTableItems.FieldByName('PLATEYMAX').AsFloat         := 0.00;
    FDMemTableItems.FieldByName('XMIN').AsFloat              := TSteelFrame(anObject).xMin;
    FDMemTableItems.FieldByName('XMAX').AsFloat              := TSteelFrame(anObject).xMax;
    FDMemTableItems.FieldByName('YMIN').AsFloat              := TSteelFrame(anObject).yMin;
    FDMemTableItems.FieldByName('YMAX').AsFloat              := TSteelFrame(anObject).YMax;
    FDMemTableItems.FieldByName('TEKSCREWS').AsInteger       := TSteelFrame(anObject).TEKSCREWS;
    FDMemTableItems.FieldByName('CONNECTIONCOUNT').AsInteger := TSteelFrame(anObject).FConnectionCount;
    FDMemTableItems.FieldByName('CONNECTORS').AsInteger      := TSteelFrame(anObject).FConnectors;
{$IFDEF PANEL}
    FDMemTableItems.FieldByName('RFTYPEID').AsInteger        := ord(rfPanel);
    FDMemTableItems.FieldByName('SPACERS').AsInteger         := 0;
{$ELSE}
    FDMemTableItems.FieldByName('RFTYPEID').AsInteger        := ord(rfTruss);
    FDMemTableItems.FieldByName('SPACERS').AsInteger         := TSteelFrame(anObject).SPACERS;
{$ENDIF}
    FDMemTableItems.FieldByName('EP2FILE').AsString          := TSteelFrame(anObject).EP2FILE;
    FDMemTableItems.FieldByName('STATUSID').AsInteger        := 0;
    FDMemTableItems.FieldByName('SITEID').AsInteger          := StrToIntDef(Site_ID, 1);
    FDMemTableItems.FieldByName('ROLLFORMERID').AsInteger    := DMSCOTRFID.ScotRFRollFormerID;
    FDMemTableItems.FieldByName('TRANSFERTORFID1').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID2').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID3').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID4').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID5').AsInteger := 0;
    FDMemTableItems.FieldByName('TRANSFERTORFID6').AsInteger := 0;
    FDMemTableItems.FieldByName('ADDEDON').AsDateTime        := Now;
  except
    on E: Exception do
      HandleException(e,'TDMEXPORTFRAME.AddData',[]);
  end;
end;

procedure TDMEXPORTFRAME.CDSItemsNewRecord(DataSet: TDataSet);
begin
  inherited;
  FDMemTableItems.FieldByName('FRAMEID').AsInteger := FTEMPID;
end;

procedure TDMEXPORTFRAME.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FTableName := aFRAME;
  GetFDMemTableItems;
end;

function TDMEXPORTFRAME.GetNewRecordID: Integer;
begin
  inherited;
  result := DMScotServer.GetNewAutoID('GEN_FRAMEID')
end;

end.
