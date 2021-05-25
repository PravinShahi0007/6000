//
// Created by the DataSnap proxy generator.
// 31/10/2019 10:18:42 AM
//

unit UnitDataSnapClientClass;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type
  TDSServerMethodsClient = class(TDSAdminClient)
  private
    FDSServerModuleCreateCommand: TDBXCommand;
    FGetRFDateInfoCommand: TDBXCommand;
    FGetRollFormerCommand: TDBXCommand;
    FGetAuditCommand: TDBXCommand;
    FGetRFOperationCommand: TDBXCommand;
    FGetJobCommand: TDBXCommand;
    FGetJobTRANSFERCommand: TDBXCommand;
    FGetJOBDETAILCommand: TDBXCommand;
    FGetEP2FileBLOBCommand: TDBXCommand;
    FGetEP2FileCommand: TDBXCommand;
    FGetEP2FileJobIDCommand: TDBXCommand;
    FGetEP2FileWithoutBlobCommand: TDBXCommand;
    FGetFRAMECommand: TDBXCommand;
    FGetFRAMEEP2FILEIDCommand: TDBXCommand;
    FGetFRAMEENTITYCommand: TDBXCommand;
    FGetFRAMEENTITYFrameIDCommand: TDBXCommand;
    FGetItemProductionCommand: TDBXCommand;
    FGetItemProductionFrameIDCommand: TDBXCommand;
    FGetItemProductionROLLFORMERIDCommand: TDBXCommand;
    FGetJobFinishedLENGTHCommand: TDBXCommand;
    FGetEP2FinishedLENGTHCommand: TDBXCommand;
    FGetFrameFinishedLENGTHCommand: TDBXCommand;
    FGetJobTotalLENGTHCommand: TDBXCommand;
    FGetEP2TotalLENGTHCommand: TDBXCommand;
    FGetFrameTotalLENGTHCommand: TDBXCommand;
    FGetNewAutoIDCommand: TDBXCommand;
    FGetServerDateTimeCommand: TDBXCommand;
    FDeleteAJobCommand: TDBXCommand;
    FTheJobAlreadyLoadedCommand: TDBXCommand;
    FGetEP2AssignInfoCommand: TDBXCommand;
    FApplyChangesJSONCommand: TDBXCommand;
    FApplyChangesCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function GetRFDateInfo(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetRollFormer(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetAudit(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetRFOperation(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetJob(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetJobTRANSFER(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetJOBDETAIL(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetEP2FileBLOB(anEP2FILEID: Integer): TFDJSONDataSets;
    function GetEP2File(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetEP2FileJobID(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime; aJobID: Integer): TFDJSONDataSets;
    function GetEP2FileWithoutBlob(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetFRAME(aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetFRAMEEP2FILEID(aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime; anEP2FILEID: Integer): TFDJSONDataSets;
    function GetFRAMEENTITY(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetFRAMEENTITYFrameID(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime; aFrameID: Integer): TFDJSONDataSets;
    function GetItemProduction(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetItemProductionFrameID(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime; aFrameID: Integer): TFDJSONDataSets;
    function GetItemProductionROLLFORMERID(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
    function GetJobFinishedLENGTH: TFDJSONDataSets;
    function GetEP2FinishedLENGTH: TFDJSONDataSets;
    function GetFrameFinishedLENGTH: TFDJSONDataSets;
    function GetJobTotalLENGTH: TFDJSONDataSets;
    function GetEP2TotalLENGTH: TFDJSONDataSets;
    function GetFrameTotalLENGTH: TFDJSONDataSets;
    function GetNewAutoID(gen_fields_id: string): Integer;
    function GetServerDateTime: TDateTime;
    procedure DeleteAJob(aJobID: Integer);
    function TheJobAlreadyLoaded(aJobName: string): Integer;
    function GetEP2AssignInfo(aSiteID: SmallInt; aJobID: Integer): TFDJSONDataSets;
    procedure ApplyChangesJSON(ATableName: string; AJSONObject: TJSONObject);
    procedure ApplyChanges(ATableName: string; ADeltaList: TFDJSONDeltas);
  end;

implementation

procedure TDSServerMethodsClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FDBXConnection.CreateCommand;
    FDSServerModuleCreateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleCreateCommand.Text := 'TDSServerMethods.DSServerModuleCreate';
    FDSServerModuleCreateCommand.Prepare;
  end;
  if not Assigned(Sender) then
    FDSServerModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDSServerModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FDSServerModuleCreateCommand.ExecuteUpdate;
end;

function TDSServerMethodsClient.GetRFDateInfo(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetRFDateInfoCommand = nil then
  begin
    FGetRFDateInfoCommand := FDBXConnection.CreateCommand;
    FGetRFDateInfoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetRFDateInfoCommand.Text := 'TDSServerMethods.GetRFDateInfo';
    FGetRFDateInfoCommand.Prepare;
  end;
  FGetRFDateInfoCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetRFDateInfoCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetRFDateInfoCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetRFDateInfoCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetRFDateInfoCommand.ExecuteUpdate;
  if not FGetRFDateInfoCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetRFDateInfoCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetRFDateInfoCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetRFDateInfoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetRollFormer(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetRollFormerCommand = nil then
  begin
    FGetRollFormerCommand := FDBXConnection.CreateCommand;
    FGetRollFormerCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetRollFormerCommand.Text := 'TDSServerMethods.GetRollFormer';
    FGetRollFormerCommand.Prepare;
  end;
  FGetRollFormerCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetRollFormerCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetRollFormerCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetRollFormerCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetRollFormerCommand.ExecuteUpdate;
  if not FGetRollFormerCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetRollFormerCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetRollFormerCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetRollFormerCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetAudit(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetAuditCommand = nil then
  begin
    FGetAuditCommand := FDBXConnection.CreateCommand;
    FGetAuditCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetAuditCommand.Text := 'TDSServerMethods.GetAudit';
    FGetAuditCommand.Prepare;
  end;
  FGetAuditCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetAuditCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetAuditCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetAuditCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetAuditCommand.ExecuteUpdate;
  if not FGetAuditCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetAuditCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetAuditCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetAuditCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetRFOperation(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetRFOperationCommand = nil then
  begin
    FGetRFOperationCommand := FDBXConnection.CreateCommand;
    FGetRFOperationCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetRFOperationCommand.Text := 'TDSServerMethods.GetRFOperation';
    FGetRFOperationCommand.Prepare;
  end;
  FGetRFOperationCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetRFOperationCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetRFOperationCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetRFOperationCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetRFOperationCommand.ExecuteUpdate;
  if not FGetRFOperationCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetRFOperationCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetRFOperationCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetRFOperationCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetJob(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetJobCommand = nil then
  begin
    FGetJobCommand := FDBXConnection.CreateCommand;
    FGetJobCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetJobCommand.Text := 'TDSServerMethods.GetJob';
    FGetJobCommand.Prepare;
  end;
  FGetJobCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetJobCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetJobCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetJobCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetJobCommand.ExecuteUpdate;
  if not FGetJobCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetJobCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetJobCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetJobCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetJobTRANSFER(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetJobTRANSFERCommand = nil then
  begin
    FGetJobTRANSFERCommand := FDBXConnection.CreateCommand;
    FGetJobTRANSFERCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetJobTRANSFERCommand.Text := 'TDSServerMethods.GetJobTRANSFER';
    FGetJobTRANSFERCommand.Prepare;
  end;
  FGetJobTRANSFERCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetJobTRANSFERCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetJobTRANSFERCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetJobTRANSFERCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetJobTRANSFERCommand.ExecuteUpdate;
  if not FGetJobTRANSFERCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetJobTRANSFERCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetJobTRANSFERCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetJobTRANSFERCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetJOBDETAIL(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetJOBDETAILCommand = nil then
  begin
    FGetJOBDETAILCommand := FDBXConnection.CreateCommand;
    FGetJOBDETAILCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetJOBDETAILCommand.Text := 'TDSServerMethods.GetJOBDETAIL';
    FGetJOBDETAILCommand.Prepare;
  end;
  FGetJOBDETAILCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetJOBDETAILCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetJOBDETAILCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetJOBDETAILCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetJOBDETAILCommand.ExecuteUpdate;
  if not FGetJOBDETAILCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetJOBDETAILCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetJOBDETAILCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetJOBDETAILCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetEP2FileBLOB(anEP2FILEID: Integer): TFDJSONDataSets;
begin
  if FGetEP2FileBLOBCommand = nil then
  begin
    FGetEP2FileBLOBCommand := FDBXConnection.CreateCommand;
    FGetEP2FileBLOBCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetEP2FileBLOBCommand.Text := 'TDSServerMethods.GetEP2FileBLOB';
    FGetEP2FileBLOBCommand.Prepare;
  end;
  FGetEP2FileBLOBCommand.Parameters[0].Value.SetInt32(anEP2FILEID);
  FGetEP2FileBLOBCommand.ExecuteUpdate;
  if not FGetEP2FileBLOBCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetEP2FileBLOBCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetEP2FileBLOBCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetEP2FileBLOBCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetEP2File(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetEP2FileCommand = nil then
  begin
    FGetEP2FileCommand := FDBXConnection.CreateCommand;
    FGetEP2FileCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetEP2FileCommand.Text := 'TDSServerMethods.GetEP2File';
    FGetEP2FileCommand.Prepare;
  end;
  FGetEP2FileCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetEP2FileCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetEP2FileCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetEP2FileCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetEP2FileCommand.ExecuteUpdate;
  if not FGetEP2FileCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetEP2FileCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetEP2FileCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetEP2FileCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetEP2FileJobID(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime; aJobID: Integer): TFDJSONDataSets;
begin
  if FGetEP2FileJobIDCommand = nil then
  begin
    FGetEP2FileJobIDCommand := FDBXConnection.CreateCommand;
    FGetEP2FileJobIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetEP2FileJobIDCommand.Text := 'TDSServerMethods.GetEP2FileJobID';
    FGetEP2FileJobIDCommand.Prepare;
  end;
  FGetEP2FileJobIDCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetEP2FileJobIDCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetEP2FileJobIDCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetEP2FileJobIDCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetEP2FileJobIDCommand.Parameters[4].Value.SetInt32(aJobID);
  FGetEP2FileJobIDCommand.ExecuteUpdate;
  if not FGetEP2FileJobIDCommand.Parameters[5].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetEP2FileJobIDCommand.Parameters[5].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetEP2FileJobIDCommand.Parameters[5].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetEP2FileJobIDCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetEP2FileWithoutBlob(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetEP2FileWithoutBlobCommand = nil then
  begin
    FGetEP2FileWithoutBlobCommand := FDBXConnection.CreateCommand;
    FGetEP2FileWithoutBlobCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetEP2FileWithoutBlobCommand.Text := 'TDSServerMethods.GetEP2FileWithoutBlob';
    FGetEP2FileWithoutBlobCommand.Prepare;
  end;
  FGetEP2FileWithoutBlobCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetEP2FileWithoutBlobCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetEP2FileWithoutBlobCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetEP2FileWithoutBlobCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetEP2FileWithoutBlobCommand.ExecuteUpdate;
  if not FGetEP2FileWithoutBlobCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetEP2FileWithoutBlobCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetEP2FileWithoutBlobCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetEP2FileWithoutBlobCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetFRAME(aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetFRAMECommand = nil then
  begin
    FGetFRAMECommand := FDBXConnection.CreateCommand;
    FGetFRAMECommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetFRAMECommand.Text := 'TDSServerMethods.GetFRAME';
    FGetFRAMECommand.Prepare;
  end;
  FGetFRAMECommand.Parameters[0].Value.SetInt16(aSiteID);
  FGetFRAMECommand.Parameters[1].Value.AsDateTime := aStartTime;
  FGetFRAMECommand.Parameters[2].Value.AsDateTime := aEndTime;
  FGetFRAMECommand.ExecuteUpdate;
  if not FGetFRAMECommand.Parameters[3].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetFRAMECommand.Parameters[3].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetFRAMECommand.Parameters[3].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetFRAMECommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetFRAMEEP2FILEID(aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime; anEP2FILEID: Integer): TFDJSONDataSets;
begin
  if FGetFRAMEEP2FILEIDCommand = nil then
  begin
    FGetFRAMEEP2FILEIDCommand := FDBXConnection.CreateCommand;
    FGetFRAMEEP2FILEIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetFRAMEEP2FILEIDCommand.Text := 'TDSServerMethods.GetFRAMEEP2FILEID';
    FGetFRAMEEP2FILEIDCommand.Prepare;
  end;
  FGetFRAMEEP2FILEIDCommand.Parameters[0].Value.SetInt16(aSiteID);
  FGetFRAMEEP2FILEIDCommand.Parameters[1].Value.AsDateTime := aStartTime;
  FGetFRAMEEP2FILEIDCommand.Parameters[2].Value.AsDateTime := aEndTime;
  FGetFRAMEEP2FILEIDCommand.Parameters[3].Value.SetInt32(anEP2FILEID);
  FGetFRAMEEP2FILEIDCommand.ExecuteUpdate;
  if not FGetFRAMEEP2FILEIDCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetFRAMEEP2FILEIDCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetFRAMEEP2FILEIDCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetFRAMEEP2FILEIDCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetFRAMEENTITY(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetFRAMEENTITYCommand = nil then
  begin
    FGetFRAMEENTITYCommand := FDBXConnection.CreateCommand;
    FGetFRAMEENTITYCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetFRAMEENTITYCommand.Text := 'TDSServerMethods.GetFRAMEENTITY';
    FGetFRAMEENTITYCommand.Prepare;
  end;
  FGetFRAMEENTITYCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetFRAMEENTITYCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetFRAMEENTITYCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetFRAMEENTITYCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetFRAMEENTITYCommand.ExecuteUpdate;
  if not FGetFRAMEENTITYCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetFRAMEENTITYCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetFRAMEENTITYCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetFRAMEENTITYCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetFRAMEENTITYFrameID(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime; aFrameID: Integer): TFDJSONDataSets;
begin
  if FGetFRAMEENTITYFrameIDCommand = nil then
  begin
    FGetFRAMEENTITYFrameIDCommand := FDBXConnection.CreateCommand;
    FGetFRAMEENTITYFrameIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetFRAMEENTITYFrameIDCommand.Text := 'TDSServerMethods.GetFRAMEENTITYFrameID';
    FGetFRAMEENTITYFrameIDCommand.Prepare;
  end;
  FGetFRAMEENTITYFrameIDCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetFRAMEENTITYFrameIDCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetFRAMEENTITYFrameIDCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetFRAMEENTITYFrameIDCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetFRAMEENTITYFrameIDCommand.Parameters[4].Value.SetInt32(aFrameID);
  FGetFRAMEENTITYFrameIDCommand.ExecuteUpdate;
  if not FGetFRAMEENTITYFrameIDCommand.Parameters[5].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetFRAMEENTITYFrameIDCommand.Parameters[5].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetFRAMEENTITYFrameIDCommand.Parameters[5].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetFRAMEENTITYFrameIDCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetItemProduction(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetItemProductionCommand = nil then
  begin
    FGetItemProductionCommand := FDBXConnection.CreateCommand;
    FGetItemProductionCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetItemProductionCommand.Text := 'TDSServerMethods.GetItemProduction';
    FGetItemProductionCommand.Prepare;
  end;
  FGetItemProductionCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetItemProductionCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetItemProductionCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetItemProductionCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetItemProductionCommand.ExecuteUpdate;
  if not FGetItemProductionCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetItemProductionCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetItemProductionCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetItemProductionCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetItemProductionFrameID(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime; aFrameID: Integer): TFDJSONDataSets;
begin
  if FGetItemProductionFrameIDCommand = nil then
  begin
    FGetItemProductionFrameIDCommand := FDBXConnection.CreateCommand;
    FGetItemProductionFrameIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetItemProductionFrameIDCommand.Text := 'TDSServerMethods.GetItemProductionFrameID';
    FGetItemProductionFrameIDCommand.Prepare;
  end;
  FGetItemProductionFrameIDCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetItemProductionFrameIDCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetItemProductionFrameIDCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetItemProductionFrameIDCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetItemProductionFrameIDCommand.Parameters[4].Value.SetInt32(aFrameID);
  FGetItemProductionFrameIDCommand.ExecuteUpdate;
  if not FGetItemProductionFrameIDCommand.Parameters[5].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetItemProductionFrameIDCommand.Parameters[5].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetItemProductionFrameIDCommand.Parameters[5].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetItemProductionFrameIDCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetItemProductionROLLFORMERID(aStatusID: SmallInt; aSiteID: SmallInt; aStartTime: TDateTime; aEndTime: TDateTime): TFDJSONDataSets;
begin
  if FGetItemProductionROLLFORMERIDCommand = nil then
  begin
    FGetItemProductionROLLFORMERIDCommand := FDBXConnection.CreateCommand;
    FGetItemProductionROLLFORMERIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetItemProductionROLLFORMERIDCommand.Text := 'TDSServerMethods.GetItemProductionROLLFORMERID';
    FGetItemProductionROLLFORMERIDCommand.Prepare;
  end;
  FGetItemProductionROLLFORMERIDCommand.Parameters[0].Value.SetInt16(aStatusID);
  FGetItemProductionROLLFORMERIDCommand.Parameters[1].Value.SetInt16(aSiteID);
  FGetItemProductionROLLFORMERIDCommand.Parameters[2].Value.AsDateTime := aStartTime;
  FGetItemProductionROLLFORMERIDCommand.Parameters[3].Value.AsDateTime := aEndTime;
  FGetItemProductionROLLFORMERIDCommand.ExecuteUpdate;
  if not FGetItemProductionROLLFORMERIDCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetItemProductionROLLFORMERIDCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetItemProductionROLLFORMERIDCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetItemProductionROLLFORMERIDCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetJobFinishedLENGTH: TFDJSONDataSets;
begin
  if FGetJobFinishedLENGTHCommand = nil then
  begin
    FGetJobFinishedLENGTHCommand := FDBXConnection.CreateCommand;
    FGetJobFinishedLENGTHCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetJobFinishedLENGTHCommand.Text := 'TDSServerMethods.GetJobFinishedLENGTH';
    FGetJobFinishedLENGTHCommand.Prepare;
  end;
  FGetJobFinishedLENGTHCommand.ExecuteUpdate;
  if not FGetJobFinishedLENGTHCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetJobFinishedLENGTHCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetJobFinishedLENGTHCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetJobFinishedLENGTHCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetEP2FinishedLENGTH: TFDJSONDataSets;
begin
  if FGetEP2FinishedLENGTHCommand = nil then
  begin
    FGetEP2FinishedLENGTHCommand := FDBXConnection.CreateCommand;
    FGetEP2FinishedLENGTHCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetEP2FinishedLENGTHCommand.Text := 'TDSServerMethods.GetEP2FinishedLENGTH';
    FGetEP2FinishedLENGTHCommand.Prepare;
  end;
  FGetEP2FinishedLENGTHCommand.ExecuteUpdate;
  if not FGetEP2FinishedLENGTHCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetEP2FinishedLENGTHCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetEP2FinishedLENGTHCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetEP2FinishedLENGTHCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetFrameFinishedLENGTH: TFDJSONDataSets;
begin
  if FGetFrameFinishedLENGTHCommand = nil then
  begin
    FGetFrameFinishedLENGTHCommand := FDBXConnection.CreateCommand;
    FGetFrameFinishedLENGTHCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetFrameFinishedLENGTHCommand.Text := 'TDSServerMethods.GetFrameFinishedLENGTH';
    FGetFrameFinishedLENGTHCommand.Prepare;
  end;
  FGetFrameFinishedLENGTHCommand.ExecuteUpdate;
  if not FGetFrameFinishedLENGTHCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetFrameFinishedLENGTHCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetFrameFinishedLENGTHCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetFrameFinishedLENGTHCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetJobTotalLENGTH: TFDJSONDataSets;
begin
  if FGetJobTotalLENGTHCommand = nil then
  begin
    FGetJobTotalLENGTHCommand := FDBXConnection.CreateCommand;
    FGetJobTotalLENGTHCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetJobTotalLENGTHCommand.Text := 'TDSServerMethods.GetJobTotalLENGTH';
    FGetJobTotalLENGTHCommand.Prepare;
  end;
  FGetJobTotalLENGTHCommand.ExecuteUpdate;
  if not FGetJobTotalLENGTHCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetJobTotalLENGTHCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetJobTotalLENGTHCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetJobTotalLENGTHCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetEP2TotalLENGTH: TFDJSONDataSets;
begin
  if FGetEP2TotalLENGTHCommand = nil then
  begin
    FGetEP2TotalLENGTHCommand := FDBXConnection.CreateCommand;
    FGetEP2TotalLENGTHCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetEP2TotalLENGTHCommand.Text := 'TDSServerMethods.GetEP2TotalLENGTH';
    FGetEP2TotalLENGTHCommand.Prepare;
  end;
  FGetEP2TotalLENGTHCommand.ExecuteUpdate;
  if not FGetEP2TotalLENGTHCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetEP2TotalLENGTHCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetEP2TotalLENGTHCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetEP2TotalLENGTHCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetFrameTotalLENGTH: TFDJSONDataSets;
begin
  if FGetFrameTotalLENGTHCommand = nil then
  begin
    FGetFrameTotalLENGTHCommand := FDBXConnection.CreateCommand;
    FGetFrameTotalLENGTHCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetFrameTotalLENGTHCommand.Text := 'TDSServerMethods.GetFrameTotalLENGTH';
    FGetFrameTotalLENGTHCommand.Prepare;
  end;
  FGetFrameTotalLENGTHCommand.ExecuteUpdate;
  if not FGetFrameTotalLENGTHCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetFrameTotalLENGTHCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetFrameTotalLENGTHCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetFrameTotalLENGTHCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDSServerMethodsClient.GetNewAutoID(gen_fields_id: string): Integer;
begin
  if FGetNewAutoIDCommand = nil then
  begin
    FGetNewAutoIDCommand := FDBXConnection.CreateCommand;
    FGetNewAutoIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetNewAutoIDCommand.Text := 'TDSServerMethods.GetNewAutoID';
    FGetNewAutoIDCommand.Prepare;
  end;
  FGetNewAutoIDCommand.Parameters[0].Value.SetWideString(gen_fields_id);
  FGetNewAutoIDCommand.ExecuteUpdate;
  Result := FGetNewAutoIDCommand.Parameters[1].Value.GetInt32;
end;

function TDSServerMethodsClient.GetServerDateTime: TDateTime;
begin
  if FGetServerDateTimeCommand = nil then
  begin
    FGetServerDateTimeCommand := FDBXConnection.CreateCommand;
    FGetServerDateTimeCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetServerDateTimeCommand.Text := 'TDSServerMethods.GetServerDateTime';
    FGetServerDateTimeCommand.Prepare;
  end;
  FGetServerDateTimeCommand.ExecuteUpdate;
  Result := FGetServerDateTimeCommand.Parameters[0].Value.AsDateTime;
end;

procedure TDSServerMethodsClient.DeleteAJob(aJobID: Integer);
begin
  if FDeleteAJobCommand = nil then
  begin
    FDeleteAJobCommand := FDBXConnection.CreateCommand;
    FDeleteAJobCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteAJobCommand.Text := 'TDSServerMethods.DeleteAJob';
    FDeleteAJobCommand.Prepare;
  end;
  FDeleteAJobCommand.Parameters[0].Value.SetInt32(aJobID);
  FDeleteAJobCommand.ExecuteUpdate;
end;

function TDSServerMethodsClient.TheJobAlreadyLoaded(aJobName: string): Integer;
begin
  if FTheJobAlreadyLoadedCommand = nil then
  begin
    FTheJobAlreadyLoadedCommand := FDBXConnection.CreateCommand;
    FTheJobAlreadyLoadedCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FTheJobAlreadyLoadedCommand.Text := 'TDSServerMethods.TheJobAlreadyLoaded';
    FTheJobAlreadyLoadedCommand.Prepare;
  end;
  FTheJobAlreadyLoadedCommand.Parameters[0].Value.SetWideString(aJobName);
  FTheJobAlreadyLoadedCommand.ExecuteUpdate;
  Result := FTheJobAlreadyLoadedCommand.Parameters[1].Value.GetInt32;
end;

function TDSServerMethodsClient.GetEP2AssignInfo(aSiteID: SmallInt; aJobID: Integer): TFDJSONDataSets;
begin
  if FGetEP2AssignInfoCommand = nil then
  begin
    FGetEP2AssignInfoCommand := FDBXConnection.CreateCommand;
    FGetEP2AssignInfoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetEP2AssignInfoCommand.Text := 'TDSServerMethods.GetEP2AssignInfo';
    FGetEP2AssignInfoCommand.Prepare;
  end;
  FGetEP2AssignInfoCommand.Parameters[0].Value.SetInt16(aSiteID);
  FGetEP2AssignInfoCommand.Parameters[1].Value.SetInt32(aJobID);
  FGetEP2AssignInfoCommand.ExecuteUpdate;
  if not FGetEP2AssignInfoCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetEP2AssignInfoCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetEP2AssignInfoCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetEP2AssignInfoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

procedure TDSServerMethodsClient.ApplyChangesJSON(ATableName: string; AJSONObject: TJSONObject);
begin
  if FApplyChangesJSONCommand = nil then
  begin
    FApplyChangesJSONCommand := FDBXConnection.CreateCommand;
    FApplyChangesJSONCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FApplyChangesJSONCommand.Text := 'TDSServerMethods.ApplyChangesJSON';
    FApplyChangesJSONCommand.Prepare;
  end;
  FApplyChangesJSONCommand.Parameters[0].Value.SetWideString(ATableName);
  FApplyChangesJSONCommand.Parameters[1].Value.SetJSONValue(AJSONObject, FInstanceOwner);
  FApplyChangesJSONCommand.ExecuteUpdate;
end;

procedure TDSServerMethodsClient.ApplyChanges(ATableName: string; ADeltaList: TFDJSONDeltas);
begin
  if FApplyChangesCommand = nil then
  begin
    FApplyChangesCommand := FDBXConnection.CreateCommand;
    FApplyChangesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FApplyChangesCommand.Text := 'TDSServerMethods.ApplyChanges';
    FApplyChangesCommand.Prepare;
  end;
  FApplyChangesCommand.Parameters[0].Value.SetWideString(ATableName);
  if not Assigned(ADeltaList) then
    FApplyChangesCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FApplyChangesCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FApplyChangesCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(ADeltaList), True);
      if FInstanceOwner then
        ADeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
  end;
  FApplyChangesCommand.ExecuteUpdate;
end;

constructor TDSServerMethodsClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TDSServerMethodsClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TDSServerMethodsClient.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FGetRFDateInfoCommand.DisposeOf;
  FGetRollFormerCommand.DisposeOf;
  FGetAuditCommand.DisposeOf;
  FGetRFOperationCommand.DisposeOf;
  FGetJobCommand.DisposeOf;
  FGetJobTRANSFERCommand.DisposeOf;
  FGetJOBDETAILCommand.DisposeOf;
  FGetEP2FileBLOBCommand.DisposeOf;
  FGetEP2FileCommand.DisposeOf;
  FGetEP2FileJobIDCommand.DisposeOf;
  FGetEP2FileWithoutBlobCommand.DisposeOf;
  FGetFRAMECommand.DisposeOf;
  FGetFRAMEEP2FILEIDCommand.DisposeOf;
  FGetFRAMEENTITYCommand.DisposeOf;
  FGetFRAMEENTITYFrameIDCommand.DisposeOf;
  FGetItemProductionCommand.DisposeOf;
  FGetItemProductionFrameIDCommand.DisposeOf;
  FGetItemProductionROLLFORMERIDCommand.DisposeOf;
  FGetJobFinishedLENGTHCommand.DisposeOf;
  FGetEP2FinishedLENGTHCommand.DisposeOf;
  FGetFrameFinishedLENGTHCommand.DisposeOf;
  FGetJobTotalLENGTHCommand.DisposeOf;
  FGetEP2TotalLENGTHCommand.DisposeOf;
  FGetFrameTotalLENGTHCommand.DisposeOf;
  FGetNewAutoIDCommand.DisposeOf;
  FGetServerDateTimeCommand.DisposeOf;
  FDeleteAJobCommand.DisposeOf;
  FTheJobAlreadyLoadedCommand.DisposeOf;
  FGetEP2AssignInfoCommand.DisposeOf;
  FApplyChangesJSONCommand.DisposeOf;
  FApplyChangesCommand.DisposeOf;
  inherited;
end;

end.

