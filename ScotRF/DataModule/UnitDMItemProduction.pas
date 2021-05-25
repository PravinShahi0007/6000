unit UnitDMItemProduction;

interface

uses
  System.SysUtils, System.Classes, UnitDMTemplate, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Data.FMTBcd, Data.SqlExpr, Datasnap.Provider,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDMItemProduction = class(TDMTemplate)
    procedure CDSItemsNewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure GetFDMemTableItems;
    procedure ApplyUpdates;override;
  public
    { Public declarations }
    procedure AddData(aFrame: TObject );override;
  end;

var
  DMItemProduction: TDMItemProduction;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  ManufactureU,  Usettings, ScotRFTypes, RollFormerU, DateUtils,
  UnitDMDesignJob, Com_Exception, Data.FireDACJSONReflect;

{$R *.dfm}

procedure TDMItemProduction.ApplyUpdates;
begin
  inherited;
  GetFDMemTableItems;
end;

procedure TDMItemProduction.AddData(aFrame: TObject );
begin
  if DriveClass=tdcSim then
    exit;
  if not FDMemTableItems.Active then
    FDMemTableItems.Open;
  FDMemTableItems.Append;
  FDMemTableItems.FieldByName('JOBID').AsInteger             := TItemBase(aFrame).JOBID;
  FDMemTableItems.FieldByName('EP2FILEID').AsInteger         := TEntityItem(aFrame).EP2FILEID;

  FDMemTableItems.FieldByName('ID').AsInteger                := TItemBase(aFrame).ID;
  FDMemTableItems.FieldByName('COPYID').AsInteger            := TItemBase(aFrame).CopyID;
  FDMemTableItems.FieldByName('TRUSSNAME').AsString          := TItemBase(aFrame).TrussName;
  FDMemTableItems.FieldByName('ITEMNAME').AsString           := TItemBase(aFrame).ItemName;
  FDMemTableItems.FieldByName('CARDNUMBER').AsString         := TEntityItem(aFrame).SmartCardNumber;
  FDMemTableItems.FieldByName('ITEMLENGTH').AsFloat          := TItemBase(aFrame).ItemLength;
  FDMemTableItems.FieldByName('ISLAST').AsInteger            := Integer(TItemBase(aFrame).isLast);
  FDMemTableItems.FieldByName('SERIALNUMBER').AsInteger      := TItemBase(aFrame).SerialNumber;
  FDMemTableItems.FieldByName('ISBOXWEB').AsInteger          := Integer(TItemBase(aFrame).isBoxWeb);
  FDMemTableItems.FieldByName('ISBOXWEBDOUBLE').AsInteger    := Integer(TItemBase(aFrame).isBoxWebDbl);
  FDMemTableItems.FieldByName('FRAMEID').AsInteger           := TItemBase(aFrame).FrameID;
{$IFDEF PANEL}
  FDMemTableItems.FieldByName('RFTYPEID').AsInteger          := 0;
{$ELSE}
  FDMemTableItems.FieldByName('RFTYPEID').AsInteger          := 1;
{$ENDIF}
  FDMemTableItems.FieldByName('STATUSID').AsInteger          := 0;
  FDMemTableItems.FieldByName('SITEID').AsInteger            := TEntityItem(aFrame).SteelFrame.SITEID;
  FDMemTableItems.FieldByName('ROLLFORMERID').AsInteger      := TEntityItem(aFrame).SteelFrame.ROLLFORMERID;
  FDMemTableItems.FieldByName('ADDEDON').AsDateTime          := Now;
  ApplyUpdates;
end;

procedure TDMItemProduction.CDSItemsNewRecord(DataSet: TDataSet);
begin
  inherited;
  FDMemTableItems.FieldByName('ITEMPRODUCTIONID').AsInteger := FTEMPID;
end;

procedure TDMItemProduction.GetFDMemTableItems;
begin
  DMScotServer.GetItemProduction(0,1,0,Now,FDMemTableItems);
end;

procedure TDMItemProduction.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FTableName := aItemProduction;
  GetFDMemTableItems;
end;

end.
