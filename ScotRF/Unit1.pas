// 
// Created by the DataSnap proxy generator.
// 29/05/2019 3:49:16 PM
// 

unit Unit1;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect;

type
  TDataModuleScotRFServerClient = class(TDSAdminClient)
  private
    FDSServerModuleCreateCommand: TDBXCommand;
    FGetRFDateInfoCommand: TDBXCommand;
    FGetRollFormerCommand: TDBXCommand;
    FGetItemProductionCommand: TDBXCommand;
    FGetAuditCommand: TDBXCommand;
    FGetRFOperationCommand: TDBXCommand;
    FGetJobCommand: TDBXCommand;
    FGetJOBDETAILCommand: TDBXCommand;
    FGetEP2FileCommand: TDBXCommand;
    FGetFRAMECommand: TDBXCommand;
    FGetFRAMEENTITYCommand: TDBXCommand;
    FGetTHINGSONFRAMEENTITYCommand: TDBXCommand;
    FGetNewAutoIDCommand: TDBXCommand;
    FApplyChangesJSONCommand: TDBXCommand;
    FApplyChangesCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function GetRFDateInfo: TFDJSONDataSets;
    function GetRollFormer: TFDJSONDataSets;
    function GetItemProduction: TFDJSONDataSets;
    function GetAudit: TFDJSONDataSets;
    function GetRFOperation: TFDJSONDataSets;
    function GetJob: TFDJSONDataSets;
    function GetJOBDETAIL: TFDJSONDataSets;
    function GetEP2File: TFDJSONDataSets;
    function GetFRAME: TFDJSONDataSets;
    function GetFRAMEENTITY: TFDJSONDataSets;
    function GetTHINGSONFRAMEENTITY: TFDJSONDataSets;
    function GetNewAutoID(gen_fields_id: string): Integer;
    procedure ApplyChangesJSON(ATableName: string; AJSONObject: TJSONObject);
    procedure ApplyChanges(ATableName: string; ADeltaList: TFDJSONDeltas);
  end;

implementation

procedure TDataModuleScotRFServerClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FDBXConnection.CreateCommand;
    FDSServerModuleCreateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDSServerModuleCreateCommand.Text := 'TDataModuleScotRFServer.DSServerModuleCreate';
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

function TDataModuleScotRFServerClient.GetRFDateInfo: TFDJSONDataSets;
begin
  if FGetRFDateInfoCommand = nil then
  begin
    FGetRFDateInfoCommand := FDBXConnection.CreateCommand;
    FGetRFDateInfoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetRFDateInfoCommand.Text := 'TDataModuleScotRFServer.GetRFDateInfo';
    FGetRFDateInfoCommand.Prepare;
  end;
  FGetRFDateInfoCommand.ExecuteUpdate;
  if not FGetRFDateInfoCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetRFDateInfoCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetRFDateInfoCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetRFDateInfoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDataModuleScotRFServerClient.GetRollFormer: TFDJSONDataSets;
begin
  if FGetRollFormerCommand = nil then
  begin
    FGetRollFormerCommand := FDBXConnection.CreateCommand;
    FGetRollFormerCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetRollFormerCommand.Text := 'TDataModuleScotRFServer.GetRollFormer';
    FGetRollFormerCommand.Prepare;
  end;
  FGetRollFormerCommand.ExecuteUpdate;
  if not FGetRollFormerCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetRollFormerCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetRollFormerCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetRollFormerCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDataModuleScotRFServerClient.GetItemProduction: TFDJSONDataSets;
begin
  if FGetItemProductionCommand = nil then
  begin
    FGetItemProductionCommand := FDBXConnection.CreateCommand;
    FGetItemProductionCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetItemProductionCommand.Text := 'TDataModuleScotRFServer.GetItemProduction';
    FGetItemProductionCommand.Prepare;
  end;
  FGetItemProductionCommand.ExecuteUpdate;
  if not FGetItemProductionCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetItemProductionCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetItemProductionCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetItemProductionCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDataModuleScotRFServerClient.GetAudit: TFDJSONDataSets;
begin
  if FGetAuditCommand = nil then
  begin
    FGetAuditCommand := FDBXConnection.CreateCommand;
    FGetAuditCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetAuditCommand.Text := 'TDataModuleScotRFServer.GetAudit';
    FGetAuditCommand.Prepare;
  end;
  FGetAuditCommand.ExecuteUpdate;
  if not FGetAuditCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetAuditCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetAuditCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetAuditCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDataModuleScotRFServerClient.GetRFOperation: TFDJSONDataSets;
begin
  if FGetRFOperationCommand = nil then
  begin
    FGetRFOperationCommand := FDBXConnection.CreateCommand;
    FGetRFOperationCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetRFOperationCommand.Text := 'TDataModuleScotRFServer.GetRFOperation';
    FGetRFOperationCommand.Prepare;
  end;
  FGetRFOperationCommand.ExecuteUpdate;
  if not FGetRFOperationCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetRFOperationCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetRFOperationCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetRFOperationCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDataModuleScotRFServerClient.GetJob: TFDJSONDataSets;
begin
  if FGetJobCommand = nil then
  begin
    FGetJobCommand := FDBXConnection.CreateCommand;
    FGetJobCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetJobCommand.Text := 'TDataModuleScotRFServer.GetJob';
    FGetJobCommand.Prepare;
  end;
  FGetJobCommand.ExecuteUpdate;
  if not FGetJobCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetJobCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetJobCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetJobCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDataModuleScotRFServerClient.GetJOBDETAIL: TFDJSONDataSets;
begin
  if FGetJOBDETAILCommand = nil then
  begin
    FGetJOBDETAILCommand := FDBXConnection.CreateCommand;
    FGetJOBDETAILCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetJOBDETAILCommand.Text := 'TDataModuleScotRFServer.GetJOBDETAIL';
    FGetJOBDETAILCommand.Prepare;
  end;
  FGetJOBDETAILCommand.ExecuteUpdate;
  if not FGetJOBDETAILCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetJOBDETAILCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetJOBDETAILCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetJOBDETAILCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDataModuleScotRFServerClient.GetEP2File: TFDJSONDataSets;
begin
  if FGetEP2FileCommand = nil then
  begin
    FGetEP2FileCommand := FDBXConnection.CreateCommand;
    FGetEP2FileCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetEP2FileCommand.Text := 'TDataModuleScotRFServer.GetEP2File';
    FGetEP2FileCommand.Prepare;
  end;
  FGetEP2FileCommand.ExecuteUpdate;
  if not FGetEP2FileCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetEP2FileCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetEP2FileCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetEP2FileCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDataModuleScotRFServerClient.GetFRAME: TFDJSONDataSets;
begin
  if FGetFRAMECommand = nil then
  begin
    FGetFRAMECommand := FDBXConnection.CreateCommand;
    FGetFRAMECommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetFRAMECommand.Text := 'TDataModuleScotRFServer.GetFRAME';
    FGetFRAMECommand.Prepare;
  end;
  FGetFRAMECommand.ExecuteUpdate;
  if not FGetFRAMECommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetFRAMECommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetFRAMECommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetFRAMECommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDataModuleScotRFServerClient.GetFRAMEENTITY: TFDJSONDataSets;
begin
  if FGetFRAMEENTITYCommand = nil then
  begin
    FGetFRAMEENTITYCommand := FDBXConnection.CreateCommand;
    FGetFRAMEENTITYCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetFRAMEENTITYCommand.Text := 'TDataModuleScotRFServer.GetFRAMEENTITY';
    FGetFRAMEENTITYCommand.Prepare;
  end;
  FGetFRAMEENTITYCommand.ExecuteUpdate;
  if not FGetFRAMEENTITYCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetFRAMEENTITYCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetFRAMEENTITYCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetFRAMEENTITYCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDataModuleScotRFServerClient.GetTHINGSONFRAMEENTITY: TFDJSONDataSets;
begin
  if FGetTHINGSONFRAMEENTITYCommand = nil then
  begin
    FGetTHINGSONFRAMEENTITYCommand := FDBXConnection.CreateCommand;
    FGetTHINGSONFRAMEENTITYCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetTHINGSONFRAMEENTITYCommand.Text := 'TDataModuleScotRFServer.GetTHINGSONFRAMEENTITY';
    FGetTHINGSONFRAMEENTITYCommand.Prepare;
  end;
  FGetTHINGSONFRAMEENTITYCommand.ExecuteUpdate;
  if not FGetTHINGSONFRAMEENTITYCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FGetTHINGSONFRAMEENTITYCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetTHINGSONFRAMEENTITYCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetTHINGSONFRAMEENTITYCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TDataModuleScotRFServerClient.GetNewAutoID(gen_fields_id: string): Integer;
begin
  if FGetNewAutoIDCommand = nil then
  begin
    FGetNewAutoIDCommand := FDBXConnection.CreateCommand;
    FGetNewAutoIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetNewAutoIDCommand.Text := 'TDataModuleScotRFServer.GetNewAutoID';
    FGetNewAutoIDCommand.Prepare;
  end;
  FGetNewAutoIDCommand.Parameters[0].Value.SetWideString(gen_fields_id);
  FGetNewAutoIDCommand.ExecuteUpdate;
  Result := FGetNewAutoIDCommand.Parameters[1].Value.GetInt32;
end;

procedure TDataModuleScotRFServerClient.ApplyChangesJSON(ATableName: string; AJSONObject: TJSONObject);
begin
  if FApplyChangesJSONCommand = nil then
  begin
    FApplyChangesJSONCommand := FDBXConnection.CreateCommand;
    FApplyChangesJSONCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FApplyChangesJSONCommand.Text := 'TDataModuleScotRFServer.ApplyChangesJSON';
    FApplyChangesJSONCommand.Prepare;
  end;
  FApplyChangesJSONCommand.Parameters[0].Value.SetWideString(ATableName);
  FApplyChangesJSONCommand.Parameters[1].Value.SetJSONValue(AJSONObject, FInstanceOwner);
  FApplyChangesJSONCommand.ExecuteUpdate;
end;

procedure TDataModuleScotRFServerClient.ApplyChanges(ATableName: string; ADeltaList: TFDJSONDeltas);
begin
  if FApplyChangesCommand = nil then
  begin
    FApplyChangesCommand := FDBXConnection.CreateCommand;
    FApplyChangesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FApplyChangesCommand.Text := 'TDataModuleScotRFServer.ApplyChanges';
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

constructor TDataModuleScotRFServerClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TDataModuleScotRFServerClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TDataModuleScotRFServerClient.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FGetRFDateInfoCommand.DisposeOf;
  FGetRollFormerCommand.DisposeOf;
  FGetItemProductionCommand.DisposeOf;
  FGetAuditCommand.DisposeOf;
  FGetRFOperationCommand.DisposeOf;
  FGetJobCommand.DisposeOf;
  FGetJOBDETAILCommand.DisposeOf;
  FGetEP2FileCommand.DisposeOf;
  FGetFRAMECommand.DisposeOf;
  FGetFRAMEENTITYCommand.DisposeOf;
  FGetTHINGSONFRAMEENTITYCommand.DisposeOf;
  FGetNewAutoIDCommand.DisposeOf;
  FApplyChangesJSONCommand.DisposeOf;
  FApplyChangesCommand.DisposeOf;
  inherited;
end;

end.
