unit MethodsServerModule;

interface

uses

  System.SysUtils, System.Classes, System.Json, DBXJSONReflect,
  Datasnap.DSServer, Datasnap.DSAuth, DataSnap.DSProviderDataModuleAdapter,
  DBXCommon, Db, WideStrings,  FMTBcd, SqlExpr, DBXDBReaders,
  DBXClient, Data.DBXFirebird, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Data.FireDACJSONReflect, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin;

type
{$MethodInfo ON}
  TDSServerMethods = class(TDSServerModule)
    FDConnToDB  : TFDConnection;
    FDQueryRollFormer          : TFDQuery;
    FDQueryRFDateInfo          : TFDQuery;
    FDQueryItemProduction      : TFDQuery;
    FDQueryAudit               : TFDQuery;
    FDQueryRFOperation         : TFDQuery;
    FDQueryJob                 : TFDQuery;
    FDQueryJOBDETAIL           : TFDQuery;
    FDQueryEP2File             : TFDQuery;
    FDQueryFRAME               : TFDQuery;
    FDQueryFRAMEENTITY         : TFDQuery;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDQueryPercentage: TFDQuery;
    FDEventAlerter1: TFDEventAlerter;
    FDQueryEP2BLOB: TFDQuery;
    FDQueryEP2FILEJOBID: TFDQuery;
    FDQueryFRAMEEP2FILEID: TFDQuery;
    FDQueryFRAMEENTITYFRAMEID: TFDQuery;
    FDQueryItemProductionFRAMEID: TFDQuery;
    FDQueryEP2withoutBlob: TFDQuery;
    FDQueryItemProductionROLLFORMERID: TFDQuery;
    FDQueryJobTransfer: TFDQuery;
    FDQueryEP2Assign: TFDQuery;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure RegisterAlert;
    procedure PushEvent;overload;
    procedure PushEvent(aDataset : TFDQuery);overload;
  public
    function GetRFDateInfo(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetRollFormer(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetAudit(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetRFOperation(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetJob(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetJobTRANSFER(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetJOBDETAIL(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetEP2FileBLOB(const anEP2FILEID: Integer ) : TFDJSONDataSets;
    function GetEP2File(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetEP2FileJobID(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime;
                    const aJobID     : Integer ) : TFDJSONDataSets;
    function GetEP2FileWithoutBlob(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetFRAME(const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetFRAMEEP2FILEID(const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime;
                    const anEP2FILEID: Integer  ) : TFDJSONDataSets;
    function GetFRAMEENTITY(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetFRAMEENTITYFrameID(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime;
                    const aFrameID   : Integer ) : TFDJSONDataSets;
    function GetItemProduction(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
    function GetItemProductionFrameID(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime;
                    const aFrameID   : Integer ) : TFDJSONDataSets;
    function GetItemProductionROLLFORMERID(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime) : TFDJSONDataSets;
    function GetJobFinishedLENGTH : TFDJSONDataSets;
    function GetEP2FinishedLENGTH : TFDJSONDataSets;
    function GetFrameFinishedLENGTH : TFDJSONDataSets;
    function GetJobTotalLENGTH : TFDJSONDataSets;
    function GetEP2TotalLENGTH : TFDJSONDataSets;
    function GetFrameTotalLENGTH : TFDJSONDataSets;
    function GetNewAutoID(gen_fields_id: String): Integer;
    function GetServerDateTime: TDateTime;
    procedure DeleteAJob(aJobID : Integer);
    function TheJobAlreadyLoaded(aJobName : String) : Integer;
    function GetEP2AssignInfo(const aSiteID : SmallInt; const aJobID : Integer ) : TFDJSONDataSets;
    procedure ApplyChangesJSON(const ATableName : String; const AJSONObject: TJSONObject);
    procedure ApplyChanges(const ATableName : String; const ADeltaList: TFDJSONDeltas);
  end;
{$MethodInfo OFF}

var
  DSServerMethods: TDSServerMethods;

implementation

{$R *.dfm}

USES UnitDBXMetadataHelper, UnitDSServerDB, Com_Exception, Variants,
  UnitScotFDServerContainer;

// Update department and employees using deltas.  TFDJSONDeltas parameter.
procedure TDSServerMethods.ApplyChanges(const ATableName : String; const ADeltaList: TFDJSONDeltas);
var
  LApply: IFDJSONDeltasApplyUpdates;
begin

  LApply := TFDJSONDeltasApplyUpdates.Create(ADeltaList);

  if ATableName = aRollFormer then
  begin
    FDQueryRollFormer.UpdateOptions.UpdateTableName := ATableName;
    FDQueryRollFormer.UpdateOptions.KeyFields :='NAME';
    FDQueryRollFormer.UpdateOptions.UpdateMode := upWhereKeyOnly;
    LApply.ApplyUpdates(ATableName, FDQueryRollFormer.Command);
  end
  else
  if ATableName = aRFDateInfo then
    LApply.ApplyUpdates(ATableName, FDQueryRFDateInfo.Command)
  else
  if ATableName = aItemProduction then
    LApply.ApplyUpdates(ATableName, FDQueryItemProduction.Command)
  else
  if ATableName = aAudit then
    LApply.ApplyUpdates(ATableName, FDQueryAudit.Command)
  else
  if ATableName = aRFOperation then
    LApply.ApplyUpdates(ATableName, FDQueryRFOperation.Command)
  else
  if ATableName = aJob then
    LApply.ApplyUpdates(ATableName, FDQueryJob.Command)
  else
  if ATableName = aJobTransfer then
    LApply.ApplyUpdates(ATableName, FDQueryJobTransfer.Command)
  else
  if ATableName = aJOBDETAIL then
    LApply.ApplyUpdates(ATableName, FDQueryJOBDETAIL.Command)
  else
  if ATableName = aEP2File then
    LApply.ApplyUpdates(ATableName, FDQueryEP2File.Command)
  else
  if ATableName = aFRAME then
    LApply.ApplyUpdates(ATableName, FDQueryFRAME.Command)
  else
  if ATableName = aFRAMEENTITY then
    LApply.ApplyUpdates(ATableName, FDQueryFRAMEENTITY.Command);

  if LApply.Errors.Count > 0 then
    raise Exception.Create(LApply.Errors.Strings.Text);
end;

procedure TDSServerMethods.DeleteAJob(aJobID : Integer);
begin
  FDConnToDB.ExecSQL('Delete from JOB            where JOBID = :JOBID',[aJobID]);
  FDConnToDB.ExecSQL('Delete from EP2FILE        where JOBID = :JOBID',[aJobID]);
  FDConnToDB.ExecSQL('Delete from FRAME          where JOBID = :JOBID',[aJobID]);
  FDConnToDB.ExecSQL('Delete from JOBDETAIL      where JOBID = :JOBID',[aJobID]);
  FDConnToDB.ExecSQL('Delete from FRAMEENTITY    where JOBID = :JOBID',[aJobID]);
  FDConnToDB.ExecSQL('Delete from ITEMPRODUCTION where JOBID = :JOBID',[aJobID]);
end;

function TDSServerMethods.TheJobAlreadyLoaded(aJobName : String) : Integer;
begin
  Result := FDConnToDB.ExecSQLScalar('Select JOBID from JOB WHERE DESIGN = :NAME', [aJobName]);
end;

// Update AName using deltas TJSONObject parameter.
procedure TDSServerMethods.ApplyChangesJSON(const ATableName : String; const AJSONObject: TJSONObject);
var
  LDeltas: TFDJSONDeltas;
begin
  LDeltas := TFDJSONDeltas.Create;
  TFDJSONInterceptor.JSONObjectToDataSets(AJSONObject, LDeltas);
  ApplyChanges(ATableName, LDeltas);
end;

procedure TDSServerMethods.PushEvent;
var
  aJSONObject : TJSONObject;
begin
  aJSONObject := TJSONObject.Create;
  aJSONObject.AddPair(TJSONPair.Create('EventID',      'xx'));
  aJSONObject.AddPair(TJSONPair.Create('RollformerID', '1' ));
  aJSONObject.AddPair(TJSONPair.Create('JobName',      ''));
  aJSONObject.AddPair(TJSONPair.Create('FrameName',    ''));
  aJSONObject.AddPair(TJSONPair.Create('ItemName',     ''));
  aJSONObject.AddPair(TJSONPair.Create('DayMeters',    ''));
  ServerContainerRF.DSServerScotRF.BroadcastMessage('ChannelNameForDashboard', aJSONObject);
end;

function GetDataSetAsJSON(DataSet: TDataSet): TJSONObject;
var
  f: TField;
  o: TJSOnObject;
  a: TJSONArray;
begin
  a := TJSONArray.Create;
  DataSet.Active := True;
  DataSet.First;
  while not DataSet.EOF do begin
    o := TJSOnObject.Create;
    for f in DataSet.Fields do
      o.AddPair(f.FieldName, VarToStr(f.Value));
    a.AddElement(o);
    DataSet.Next;
  end;
  DataSet.Active := False;
  Result := TJSONObject.Create;
  Result.AddPair(DataSet.Name, a);
end;

procedure TDSServerMethods.PushEvent(aDataset : TFDQuery);
var
  aJSONObject : TJSONObject;
begin
  aJSONObject := GetDataSetAsJSON(aDataSet);
  ServerContainerRF.DSServerScotRF.BroadcastMessage('ChannelNameForDashboard', aJSONObject);
end;

procedure TDSServerMethods.RegisterAlert;
begin
  if FDEventAlerter1.Active then
    Exit;
  FDEventAlerter1.Names.Clear;
  FDEventAlerter1.Names.Add('ITEMPRODUCTION');
  FDEventAlerter1.Options.Synchronize := True;
  FDEventAlerter1.Options.Timeout := 10000;
  FDEventAlerter1.Register;
end;

procedure TDSServerMethods.DSServerModuleCreate(Sender: TObject);
begin
  RegisterAlert;
end;

function TDSServerMethods.GetRFDateInfo(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryRFDateInfo.Active := False;
  FDQueryRFDateInfo.Params[0].AsInteger  := aStatusID;
  FDQueryRFDateInfo.Params[1].AsInteger  := aSiteID;
  FDQueryRFDateInfo.Params[2].AsDateTime := aStartTime;
  FDQueryRFDateInfo.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryRFDateInfo);
end;

function TDSServerMethods.GetRollFormer(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryRollFormer.Active := False;
  FDQueryRollFormer.Params[0].AsInteger  := aStatusID;
  FDQueryRollFormer.Params[1].AsInteger  := aSiteID;
  FDQueryRollFormer.Params[2].AsDateTime := aStartTime;
  FDQueryRollFormer.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryRollFormer);
end;

function TDSServerMethods.GetItemProduction(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryItemProduction.Active := False;
  FDQueryItemProduction.Params[0].AsInteger  := aStatusID;
  FDQueryItemProduction.Params[1].AsInteger  := aSiteID;
  FDQueryItemProduction.Params[2].AsDateTime := aStartTime;
  FDQueryItemProduction.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryItemProduction);
end;

function TDSServerMethods.GetItemProductionFrameID(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime;
                    const aFrameID   : Integer ) : TFDJSONDataSets;
begin
  FDQueryItemProductionFrameID.Active := False;
  FDQueryItemProductionFrameID.Params[0].AsInteger  := aStatusID;
  FDQueryItemProductionFrameID.Params[1].AsInteger  := aSiteID;
  FDQueryItemProductionFrameID.Params[2].AsDateTime := aStartTime;
  FDQueryItemProductionFrameID.Params[3].AsDateTime := aEndTime;
  FDQueryItemProductionFrameID.Params[4].AsInteger  := aFrameID;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryItemProductionFrameID);
end;

function TDSServerMethods.GetItemProductionROLLFORMERID(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryItemProductionROLLFORMERID.Active := False;
  FDQueryItemProductionROLLFORMERID.Params[0].AsInteger  := aStatusID;
  FDQueryItemProductionROLLFORMERID.Params[1].AsInteger  := aSiteID;
  FDQueryItemProductionROLLFORMERID.Params[2].AsDateTime := aStartTime;
  FDQueryItemProductionROLLFORMERID.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryItemProductionROLLFORMERID);
end;

function TDSServerMethods.GetAudit(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryAudit.Active := False;
  FDQueryAudit.Params[0].AsInteger  := aStatusID;
  FDQueryAudit.Params[1].AsInteger  := aSiteID;
  FDQueryAudit.Params[2].AsDateTime := aStartTime;
  FDQueryAudit.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryAudit);
end;

function TDSServerMethods.GetRFOperation(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryRFOperation.Active := False;
  FDQueryRFOperation.Params[0].AsInteger  := aStatusID;
  FDQueryRFOperation.Params[1].AsInteger  := aSiteID;
  FDQueryRFOperation.Params[2].AsDateTime := aStartTime;
  FDQueryRFOperation.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryRFOperation);
end;

function TDSServerMethods.GetJob(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryJob.Active := False;
  FDQueryJob.Params[0].AsInteger  := aStatusID;
  FDQueryJob.Params[1].AsInteger  := aSiteID;
  FDQueryJob.Params[2].AsDateTime := aStartTime;
  FDQueryJob.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryJob);
end;

function TDSServerMethods.GetJobTRANSFER(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryJobTransfer.Active := False;
  FDQueryJobTransfer.Params[0].AsInteger  := aStatusID;
  FDQueryJobTransfer.Params[1].AsInteger  := aSiteID;
  FDQueryJobTransfer.Params[2].AsDateTime := aStartTime;
  FDQueryJobTransfer.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryJobTransfer);
end;

function TDSServerMethods.GetJOBDETAIL(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryJOBDETAIL.Active := False;
  FDQueryJOBDETAIL.Params[0].AsInteger  := aStatusID;
  FDQueryJOBDETAIL.Params[1].AsInteger  := aSiteID;
  FDQueryJOBDETAIL.Params[2].AsDateTime := aStartTime;
  FDQueryJOBDETAIL.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryJOBDETAIL);
end;

function TDSServerMethods.GetEP2FileBLOB(const anEP2FILEID: Integer ) : TFDJSONDataSets;
begin
  FDQueryEP2BLOB.Active := False;
  FDQueryEP2BLOB.Params[0].AsInteger  := anEP2FILEID;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryEP2BLOB);
end;

function TDSServerMethods.GetEP2File(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryEP2File.Active := False;
  FDQueryEP2File.Params[0].AsInteger  := aStatusID;
  FDQueryEP2File.Params[1].AsInteger  := aSiteID;
  FDQueryEP2File.Params[2].AsDateTime := aStartTime;
  FDQueryEP2File.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryEP2File);
end;

function TDSServerMethods.GetEP2FileWithoutBlob(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryEP2withoutBlob.Active := False;
  FDQueryEP2withoutBlob.Params[0].AsInteger  := aStatusID;
  FDQueryEP2withoutBlob.Params[1].AsInteger  := aSiteID;
  FDQueryEP2withoutBlob.Params[2].AsDateTime := aStartTime;
  FDQueryEP2withoutBlob.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryEP2withoutBlob);
end;

function TDSServerMethods.GetEP2FileJobID(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime;
                    const aJobID     : Integer ) : TFDJSONDataSets;
begin
  FDQueryEP2File.Active := False;
  FDQueryEP2File.Params[0].AsInteger  := aStatusID;
  FDQueryEP2File.Params[1].AsInteger  := aSiteID;
  FDQueryEP2File.Params[2].AsDateTime := aStartTime;
  FDQueryEP2File.Params[3].AsDateTime := aEndTime;
  FDQueryEP2File.Params[4].AsInteger  := aJobID;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryEP2File);
end;

function TDSServerMethods.GetEP2AssignInfo( const aSiteID  : SmallInt;
                                            const aJobID   : Integer ) : TFDJSONDataSets;
begin
  FDQueryEP2Assign.Active := False;
  FDQueryEP2Assign.Params[0].AsInteger  := aSiteID;
  FDQueryEP2Assign.Params[1].AsInteger  := aJobID;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryEP2Assign);
end;

function TDSServerMethods.GetFRAME(const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryFRAME.Active := False;
  FDQueryFRAME.Params[0].AsInteger  := aSiteID;
  FDQueryFRAME.Params[1].AsDateTime := aStartTime;
  FDQueryFRAME.Params[2].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryFRAME);
end;

function TDSServerMethods.GetFRAMEEP2FILEID(const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime;
                    const anEP2FILEID: Integer ) : TFDJSONDataSets;
begin
  FDQueryFRAMEEP2FILEID.Active := False;
  FDQueryFRAMEEP2FILEID.Params[0].AsInteger  := aSiteID;
  FDQueryFRAMEEP2FILEID.Params[1].AsDateTime := aStartTime;
  FDQueryFRAMEEP2FILEID.Params[2].AsDateTime := aEndTime;
  FDQueryFRAMEEP2FILEID.Params[3].AsInteger  := anEP2FILEID;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryFRAMEEP2FILEID);
end;

function TDSServerMethods.GetFRAMEENTITY(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime ) : TFDJSONDataSets;
begin
  FDQueryFRAMEENTITY.Active := False;
  FDQueryFRAMEENTITY.Params[0].AsInteger  := aStatusID;
  FDQueryFRAMEENTITY.Params[1].AsInteger  := aSiteID;
  FDQueryFRAMEENTITY.Params[2].AsDateTime := aStartTime;
  FDQueryFRAMEENTITY.Params[3].AsDateTime := aEndTime;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryFRAMEENTITY);
end;

function TDSServerMethods.GetFRAMEENTITYFrameID(const aStatusID  : SmallInt;
                    const aSiteID    : SmallInt;
                    const aStartTime : TDatetime;
                    const aEndTime   : TDatetime;
                    const aFrameID   : Integer ) : TFDJSONDataSets;
begin
  FDQueryFRAMEENTITYFrameID.Active := False;
  FDQueryFRAMEENTITYFrameID.Params[0].AsInteger  := aStatusID;
  FDQueryFRAMEENTITYFrameID.Params[1].AsInteger  := aSiteID;
  FDQueryFRAMEENTITYFrameID.Params[2].AsDateTime := aStartTime;
  FDQueryFRAMEENTITYFrameID.Params[3].AsDateTime := aEndTime;
  FDQueryFRAMEENTITYFrameID.Params[4].AsInteger  := aFrameID;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryFRAMEENTITYFrameID);
end;

function TDSServerMethods.GetNewAutoID(gen_fields_id: String): Integer;
begin
  Result := FDConnToDB.ExecSQLScalar('Select gen_id('+gen_fields_id+', 0) from rdb$database');
end;

function TDSServerMethods.GetServerDateTime: TDateTime;
begin
  Result := Now;
end;

function TDSServerMethods.GetJobFinishedLENGTH : TFDJSONDataSets;
begin
  FDQueryPercentage.SQL.Text := 'SELECT JOBID, Sum(ITEMLENGTH) AS ITEMLENGTH, Sum(ISLAST) AS FinishCount '
                              +' FROM ITEMPRODUCTION '
                              +' Group by JOBID ';
  FDQueryPercentage.Active := False;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryPercentage);
end;

function TDSServerMethods.GetEP2FinishedLENGTH : TFDJSONDataSets;
begin
  FDQueryPercentage.SQL.Text := 'SELECT EP2FILEID, Sum(ITEMLENGTH) AS ITEMLENGTH, Sum(ISLAST) AS FinishCount '
                              +' FROM ITEMPRODUCTION  '
                              +' Group by EP2FILEID ';
  FDQueryPercentage.Active := False;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryPercentage);
end;

function TDSServerMethods.GetFrameFinishedLENGTH : TFDJSONDataSets;
begin
  FDQueryPercentage.SQL.Text := 'SELECT FRAMEID, Sum(ITEMLENGTH) AS ITEMLENGTH '
                              +' FROM ITEMPRODUCTION '
                              +' Group by FRAMEID ';
  FDQueryPercentage.Active := False;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryPercentage);
end;

function TDSServerMethods.GetJobTotalLENGTH : TFDJSONDataSets;
begin
  FDQueryPercentage.SQL.Text := 'SELECT JOBID, Sum(LENGTH) AS LENGTH, count(distinct FRAMEID) AS TotalCount '
                              +' FROM FRAMEENTITY '
                              +' Group by JOBID ';
  FDQueryPercentage.Active := False;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryPercentage);
end;

function TDSServerMethods.GetEP2TotalLENGTH : TFDJSONDataSets;
begin
  FDQueryPercentage.SQL.Text := 'SELECT EP2FILEID, Sum(LENGTH) AS LENGTH, count(distinct FRAMEID) AS TotalCount '
                              +' FROM FRAMEENTITY  '
                              +' Group by EP2FILEID ';
  FDQueryPercentage.Active := False;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryPercentage);
end;

function TDSServerMethods.GetFrameTotalLENGTH : TFDJSONDataSets;
begin
  FDQueryPercentage.SQL.Text := 'SELECT FRAMEID, Sum(LENGTH) AS LENGTH '
                              +' FROM FRAMEENTITY '
                              +' Group by FRAMEID ';
  FDQueryPercentage.Active := False;
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, FDQueryPercentage);
end;

end.
