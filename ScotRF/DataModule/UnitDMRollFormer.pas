unit UnitDMRollFormer;

interface

uses
  System.SysUtils, System.Classes, UnitDMTemplate, Data.DB, Datasnap.DBClient,
  Data.FMTBcd, Datasnap.Provider, Data.SqlExpr, ScotRFTypes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDMRollFormer = class(TDMTemplate)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    Function GetRollFormerID : Integer;
    procedure GetFDMemTableItems;
    procedure ApplyUpdates;
  public
    { Public declarations }
    property ScotRFRollFormerID : Integer read GetRollFormerID;
  end;

var
  DMSCOTRFID : TDMRollFormer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Com_Exception, RollformerU, UnitDMDesignJob, Data.FireDACJSONReflect;

{$R *.dfm}

procedure TDMRollFormer.GetFDMemTableItems;
begin
  DMScotServer.GetRollFormer(0,1,0,Now,FDMemTableItems);
end;

procedure TDMRollFormer.ApplyUpdates;
begin
  inherited;
  GetFDMemTableItems;
end;

procedure TDMRollFormer.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FTableName := aRollFormer;
  GetFDMemTableItems;
  FDMemTableItems.IndexFieldNames:='NAME';
  FDMemTableItems.IndexesActive:=True;
end;

Function TDMRollFormer.GetRollFormerID : Integer;
begin
  result := 0;
  if NOT assigned(Self) then
    Exit;
  if FDMemTableItems.FindKey([G_Settings.general_MachineName]) then  //G_Settings.general_MachineName
  begin
    result := FDMemTableItems.FieldByName('ROLLFORMERID').AsInteger;
    Exit;
  end
  else
  If not DMScotServer.IsDashboard then
  begin
    try
      FDMemTableItems.Append;
      FDMemTableItems.FieldByName('ROLLFORMERID').AsInteger := -1;
      FDMemTableItems.FieldByName('NAME').AsString          := G_Settings.general_MachineName;
      if RollFormer.MachineDetail<>'' then
        FDMemTableItems.FieldByName('DESCRIPTION').AsString := RollFormer.MachineDetail
      else
        FDMemTableItems.FieldByName('DESCRIPTION').AsString := G_Settings.general_MachineName;
      if RollFormer.ConnectInfo<>'' then
        FDMemTableItems.FieldByName('PROGRAM').AsString     := RollFormer.ConnectInfo
      else
        FDMemTableItems.FieldByName('PROGRAM').AsString     := G_Settings.general_MachineName;
      if RollFormer.MintVersion<>'' then
        FDMemTableItems.FieldByName('VERSION').AsString     := RollFormer.MintVersion
      else
        FDMemTableItems.FieldByName('VERSION').AsString     := G_Settings.general_MachineName;
      if G_Settings.general_MachineID<>'' then
        FDMemTableItems.FieldByName('CODE').AsString        := G_Settings.general_MachineID
      else
        FDMemTableItems.FieldByName('CODE').AsString        := G_Settings.general_MachineName;
      FDMemTableItems.FieldByName('PRODUCTION').AsFloat     := 0.00;
  {$IFDEF PANEL}
      FDMemTableItems.FieldByName('RFTYPEID').AsInteger     := 0;
  {$ELSE}
      FDMemTableItems.FieldByName('RFTYPEID').AsInteger     := 1;
  {$ENDIF}
      FDMemTableItems.FieldByName('STATUSID').AsInteger     := 0;
      FDMemTableItems.FieldByName('SITEID').AsInteger       := 1;
      FDMemTableItems.FieldByName('ADDEDON').AsDateTime     := Now;
      ApplyUpdates;
      result := DMScotServer.GetNewAutoID('GEN_ROLLFORMERID');
      if FDMemTableItems.FindKey([G_Settings.general_MachineName]) then
        result := FDMemTableItems.FieldByName('ROLLFORMERID').AsInteger;
    except
      On e:Exception do
        HandleException(e,'TDMRollFormer.GetRollFormerID',[])
    end;
  end;
end;

end.
