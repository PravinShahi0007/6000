unit UnitDMRFDateInfo;

interface

uses
  System.SysUtils, System.Classes, UnitDMTemplate, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Data.FMTBcd, Data.SqlExpr, Datasnap.Provider,
  UnitDMRollFormer, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDMRFDateInfo = class(TDMTemplate)
    FDMemTableItemsRFDATEINFOID: TIntegerField;
    FDMemTableItemsRFINFODATE: TDateField;
    FDMemTableItemsROLLFORMERID: TIntegerField;
    FDMemTableItemsORIGINMETERS: TFloatField;
    FDMemTableItemsREMAINMETERS: TFloatField;
    FDMemTableItemsRUNSECONDS: TIntegerField;
    FDMemTableItemsPAUSETIME: TIntegerField;
    FDMemTableItemsMETERS: TFloatField;
    FDMemTableItemsCUTS: TIntegerField;
    FDMemTableItemsSWAGE: TIntegerField;
    FDMemTableItemsNOTCH: TIntegerField;
    FDMemTableItemsFLAT: TIntegerField;
    FDMemTableItemsFPUNCH: TIntegerField;
    FDMemTableItemsSTATUSID: TSmallintField;
    FDMemTableItemsSITEID: TIntegerField;
    FDMemTableItemsADDEDON: TSQLTimeStampField;
    FDMemTableItemsRFTYPEID: TSmallintField;
    FDMemTableItemsOriginUnit: TFloatField;
    FDMemTableItemsRemainUnit: TFloatField;
    FDMemTableItemsMetersUnit: TFloatField;
    FDMemTableItemsCARDNUMBER: TWideStringField;
    procedure CDSItemsNewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSItemsCalcFields(DataSet: TDataSet);
    procedure CDSItemsRUNSECONDSGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    procedure ResetFilter (aRFID : String);overload;
    Function GetDayTotalMeters : Integer;
    procedure ApplyUpdates;override;
  public
    { Public declarations }
    procedure GetFDMemTableItems;
    procedure AddData(aFrame: TObject );override;
    procedure ResetFilter;overload;//
    property DayTotalMeters : Integer read GetDayTotalMeters;
  end;

var
  DMRFDateInfo: TDMRFDateInfo;

implementation

uses
  ManufactureU,  Usettings, ScotRFTypes, RollFormerU, DateUtils, FrameDataU,
  dialogs, UnitDMDesignJob, Com_Exception, Data.FireDACJSONReflect;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMRFDateInfo.ResetFilter;
begin
  ResetFilter( IntToStr(DMSCOTRFID.ScotRFRollFormerID) );
end;

procedure TDMRFDateInfo.ResetFilter (aRFID : String);
begin
  FDMemTableItems.Filtered := False;
  FDMemTableItems.Filter := 'ROLLFORMERID = '+aRFID;
  FDMemTableItems.Filtered := True;
end;

procedure TDMRFDateInfo.CDSItemsCalcFields(DataSet: TDataSet);
var
  cf: Double;
  Delta: Integer;
  aTimeDifference : Double;
begin
  inherited;
  if G_Settings.general_metric then
    cf := 1
  else
    cf := 3.28084;
  FDMemTableItems.FieldByName('OriginUnit').AsFloat := FDMemTableItems.FieldByName('ORIGINMETERS').AsFloat*cf;
  FDMemTableItems.FieldByName('RemainUnit').AsFloat := FDMemTableItems.FieldByName('REMAINMETERS').AsFloat*cf;
  FDMemTableItems.FieldByName('MetersUnit').AsFloat := FDMemTableItems.FieldByName('METERS').AsFloat*cf;
end;

procedure TDMRFDateInfo.CDSItemsNewRecord(DataSet: TDataSet);
begin
  DEC(FTEMPID);
  FDMemTableItems.FieldByName('RFDATEINFOID').AsInteger := FTEMPID;
end;

procedure TDMRFDateInfo.CDSItemsRUNSECONDSGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := Format('%2.2d:%2.2d:%2.2d',[Sender.AsInteger div SecsPerHour, (Sender.AsInteger div SecsPerMin) mod SecsPerMin, Sender.AsInteger mod SecsPerMin]);
end;

procedure TDMRFDateInfo.GetFDMemTableItems;
begin
  DMScotServer.GetRFDateInfo(0,1,0,Now,FDMemTableItems);
end;

procedure TDMRFDateInfo.ApplyUpdates;
begin
  inherited;
  GetFDMemTableItems;
end;

procedure TDMRFDateInfo.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FTableName := aRFDateInfo;
  GetFDMemTableItems;
  FDMemTableItems.IndexFieldNames:='SITEID;RFINFODATE;ROLLFORMERID;CARDNUMBER';
  FDMemTableItems.IndexesActive:=True;
  FDMemTableItems.Open;
end;

procedure TDMRFDateInfo.AddData(aFrame: TObject );
begin
  if DriveClass=tdcSim then
    exit;
  if not FDMemTableItems.Active then
    FDMemTableItems.Open;
  If not FDMemTableItems.FindKey([TRFDateInfo(aFrame).SITEID
                         , TRFDateInfo(aFrame).RFINFODATE
                         , TRFDateInfo(aFrame).ROLLFORMERID
                         , TRFDateInfo(aFrame).CARDNUMBER]) then
  begin
    FDMemTableItems.Append;
    FDMemTableItems.FieldByName('RFDATEINFOID').AsInteger := FTempID;
    FDMemTableItems.FieldByName('SITEID').AsInteger       := TRFDateInfo(aFrame).SITEID;
    FDMemTableItems.FieldByName('RFINFODATE').AsDateTime  := TRFDateInfo(aFrame).RFINFODATE;
    FDMemTableItems.FieldByName('ROLLFORMERID').AsInteger := TRFDateInfo(aFrame).ROLLFORMERID;
{$IFDEF PANEL}
    FDMemTableItems.FieldByName('RFTYPEID').AsInteger     := ord(rfPanel);
{$ELSE}
    FDMemTableItems.FieldByName('RFTYPEID').AsInteger     := ord(rfTruss);
{$ENDIF}
    FDMemTableItems.FieldByName('CARDNUMBER').AsString    := TRFDateInfo(aFrame).CARDNUMBER;
    FDMemTableItems.FieldByName('ORIGINMETERS').AsFloat   := TRFDateInfo(aFrame).ORIGINMETERS;
    FDMemTableItems.FieldByName('ADDEDON').AsDateTime     := Now;
    FDMemTableItems.FieldByName('REMAINMETERS').AsFloat   := TRFDateInfo(aFrame).REMAINMETERS;
    FDMemTableItems.FieldByName('STATUSID').AsInteger     := TRFDateInfo(aFrame).STATUSID;
    FDMemTableItems.FieldByName('RUNSECONDS').AsInteger   := TRFDateInfo(aFrame).RUNTIME;
    FDMemTableItems.FieldByName('PAUSETIME').AsInteger    := TRFDateInfo(aFrame).PAUSETIME;
    FDMemTableItems.FieldByName('METERS').AsFloat         := TRFDateInfo(aFrame).METERS;
    FDMemTableItems.FieldByName('CUTS').AsInteger         := TRFDateInfo(aFrame).CUTS;
    FDMemTableItems.FieldByName('SWAGE').AsInteger        := TRFDateInfo(aFrame).FSWAGE;
    FDMemTableItems.FieldByName('NOTCH').AsInteger        := TRFDateInfo(aFrame).NOTCH;
    FDMemTableItems.FieldByName('FLAT').AsInteger         := TRFDateInfo(aFrame).FLAT;
    FDMemTableItems.FieldByName('FPUNCH').AsInteger       := TRFDateInfo(aFrame).FPUNCH;
    Dec(FTempID);
  end
  else
  begin
    FDMemTableItems.Edit;
    FDMemTableItems.FieldByName('REMAINMETERS').AsFloat   := TRFDateInfo(aFrame).REMAINMETERS;
    FDMemTableItems.FieldByName('STATUSID').AsInteger     := TRFDateInfo(aFrame).STATUSID;
    FDMemTableItems.FieldByName('RUNSECONDS').AsInteger   := FDMemTableItems.FieldByName('RUNSECONDS').AsInteger + TRFDateInfo(aFrame).RUNTIME;
    FDMemTableItems.FieldByName('PAUSETIME').AsInteger    := FDMemTableItems.FieldByName('PAUSETIME').AsInteger  + TRFDateInfo(aFrame).PAUSETIME;
    FDMemTableItems.FieldByName('METERS').AsFloat         := FDMemTableItems.FieldByName('METERS').AsFloat       + TRFDateInfo(aFrame).METERS;
    FDMemTableItems.FieldByName('CUTS').AsInteger         := FDMemTableItems.FieldByName('CUTS').AsInteger       + TRFDateInfo(aFrame).CUTS;
    FDMemTableItems.FieldByName('SWAGE').AsInteger        := FDMemTableItems.FieldByName('SWAGE').AsInteger      + TRFDateInfo(aFrame).FSWAGE;
    FDMemTableItems.FieldByName('NOTCH').AsInteger        := FDMemTableItems.FieldByName('NOTCH').AsInteger      + TRFDateInfo(aFrame).NOTCH;
    FDMemTableItems.FieldByName('FLAT').AsInteger         := FDMemTableItems.FieldByName('FLAT').AsInteger       + TRFDateInfo(aFrame).FLAT;
    FDMemTableItems.FieldByName('FPUNCH').AsInteger       := FDMemTableItems.FieldByName('FPUNCH').AsInteger     + TRFDateInfo(aFrame).FPUNCH;
  end;
  ApplyUpdates;
end;

Function TDMRFDateInfo.GetDayTotalMeters : Integer;
begin
  result := 0;
  if not FDMemTableItems.Active then
    FDMemTableItems.Open;
  IF FDMemTableItems.FindKey([StrToInt(SITE_ID)
                  ,  TRUNC(NOW)
                  ,  DMSCOTRFID.ScotRFRollFormerID]) THEN
  begin
    while not FDMemTableItems.Eof do
    begin
      result := result + FDMemTableItems.FieldByName('METERS').AsInteger;
      FDMemTableItems.Next;
    end;
  end
end;

end.
