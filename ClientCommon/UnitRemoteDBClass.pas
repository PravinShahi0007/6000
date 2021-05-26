unit UnitRemoteDBClass;

interface

uses
  System.SysUtils, System.Classes, System.JSON, ScotRFTypes, Data.FireDACJSONReflect, FireDAC.Comp.Client,
  UnitDataSnapClientClass, Data.DB, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, Data.SqlExpr, Registry, IniFiles;

type

  TDMRemoteDB = class(TDataModule)
    SCSServerDataSnap: TSQLConnection;
  private
    { Private declarations }
    FInstanceOwner   : Boolean;
    FIsDashboard     : Boolean;
    FScotRF_Registry : TRegIniFile;
    FScotRF_INI      : TIniFile;
    FServerClient    : TDSServerMethodsClient;
    function GetServerClient : TDSServerMethodsClient;
    function GetSCSServerConnected : Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner : Boolean read FInstanceOwner write FInstanceOwner;
    property ServerClient  : TDSServerMethodsClient read GetServerClient write FServerClient;
    property SCSServerConnected  : Boolean read GetSCSServerConnected;
  end;

  TRemoteDB  = class(TInterfacedObject, IDataConn)
  private
    FDMRemoteDB : TDMRemoteDB;
    function  GetDeltas(aTableName: String; aDataSet : TFDMemTable ) : TFDJSONDeltas;
  public
    constructor Create;
    destructor Destroy; override;
    function GetRFDateInfo( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetRollFormer( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetAudit      ( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetRFOperation( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;

    function GetJob        ( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetJobTRANSFER( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetJOBDETAIL  ( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2File    ( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2FileWithoutBlob( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetFRAME      ( aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetFRAMEEP2FILEID( aSiteID    : SmallInt;
                            aEP2FILEID : Integer;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetFRAMEENTITY( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetFRAMEENTITYFrameID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            aFrameID   : Integer;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetItemProduction( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetItemProductionFrameID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            aFrameID   : Integer;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetItemProductionROLLFORMERID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
   function GetEP2FileJobID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            aJobID     : Integer;
                            var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2FileBLOB(anEP2FILEID: Integer;
                            var aDataSet   : TFDMemTable): Boolean;
    function GetJobFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2FinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetFrameFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetJobTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2TotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetFrameTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetNewAutoID(gen_fields_id: string): Integer;
    function IsDashboard : Boolean;
    procedure DeleteAJob(aJobID : Integer);
    function TheJobAlreadyLoaded(aJobName : String) : Integer;
    function GetEP2AssignInfo(var aDataSet : TFDMemTable; const aJobID : Integer ): Boolean;

    procedure ApplyUpdates( aTableName: String; var aDataSet : TFDMemTable );
    property DMRemoteDB : TDMRemoteDB read FDMRemoteDB;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses com_exception, Forms;


constructor TDMRemoteDB.create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TDMRemoteDB.Destroy;
begin
  FServerClient.Free;
  FreeAndNil(FScotRF_Registry);
  FreeAndNil(FScotRF_INI);
  inherited;
end;

function TDMRemoteDB.GetServerClient : TDSServerMethodsClient;
begin
  if FServerClient = nil then
    FServerClient:= TDSServerMethodsClient.Create(SCSServerDataSnap.DBXConnection, FInstanceOwner);
  Result := FServerClient;
end;

function TDMRemoteDB.GetSCSServerConnected : Boolean;
var
  aSettingsFile : String;
  aString : String;
begin
  Result := False;
  FScotRF_Registry := TRegIniFile.Create('Software\ScotPackage');
{$IFDEF PANEL}
    aSettingsFile         := FScotRF_Registry.ReadString('SETTINGS', 'PANELSETFILE', '');
{$ELSE}
    aSettingsFile         := FScotRF_Registry.ReadString('SETTINGS', 'TRUSSSETFILE', '');
{$ENDIF}
  FScotRF_INI := TIniFile.create(aSettingsFile);
  with SCSServerDataSnap.Params do
  begin
    Values['HostName']                 := FScotRF_Registry.ReadString('RemoteServer', 'Server', '127.0.0.1');
    Values['Port']                     := FScotRF_Registry.ReadString('RemoteServer', 'Port',   '211');
    If UpperCase(Application.Title)=UpperCase('Scotdashboard') then
    begin
      Values['DSAuthenticationUser']   := 'Dashboard';
    end
    else
    begin
      Values['DSAuthenticationUser']   := FScotRF_INI.ReadString('general', 'MachineName', 'SCOTTRF');
    end;
    Values['DSAuthenticationPassword'] := 'admin';
    try
      SCSServerDataSnap.Connected:=True;
      Result := True;
    except
      On E: Exception do
        HandleException(e,'TDMSCS.GetServerConnected',[]);
    end;
  end;
end;


Constructor TRemoteDB.Create;
begin
  inherited;
  FDMRemoteDB := TDMRemoteDB.Create(Application);
end;

destructor TRemoteDB.Destroy;
begin
  inherited;
end;


function TRemoteDB.GetRFDateInfo( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetRFDateInfo(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetRFDateInfo', [])
  end;
end;


function TRemoteDB.GetRollFormer( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetRollFormer(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetRollFormer', [])
  end;
end;

function TRemoteDB.GetAudit      ( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetAudit(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetAudit', [])
  end;
end;

function TRemoteDB.GetRFOperation( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetRFOperation(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetRFOperation', [])
  end;
end;

function TRemoteDB.GetJob        ( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetJob(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetJob', [])
  end;
end;

function TRemoteDB.GetJobTRANSFER( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetJobTRANSFER(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetJobTRANSFER', [])
  end;
end;
function TRemoteDB.GetJOBDETAIL  ( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetJOBDETAIL(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetJOBDETAIL', [])
  end;
end;
function TRemoteDB.GetEP2File    ( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetEP2File(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetEP2File', [])
  end;
end;
function TRemoteDB.GetEP2FileWithoutBlob( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetEP2FileWithoutBlob(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetEP2FileWithoutBlob', [])
  end;
end;
function TRemoteDB.GetFRAME      ( aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetFRAME(1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetFRAME', [])
  end;
end;
function TRemoteDB.GetFRAMEEP2FILEID( aSiteID    : SmallInt;
                        aEP2FILEID : Integer;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetFRAMEEP2FILEID(1,0,Now,aEP2FILEID);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetFRAMEEP2FILEID', [])
  end;
end;
function TRemoteDB.GetFRAMEENTITY( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetFRAMEENTITY(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetFRAMEENTITY', [])
  end;
end;

function TRemoteDB.GetFRAMEENTITYFrameID( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        aFrameID   : Integer;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetFRAMEENTITYFrameID(0,1,0,Now,aFrameID);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetFRAMEENTITYFrameID', [])
  end;
end;

function TRemoteDB.GetItemProduction( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetItemProduction(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetItemProduction', [])
  end;
end;

function TRemoteDB.GetItemProductionFrameID( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        aFrameID   : Integer;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetItemProductionFrameID(0,1,0,Now,aFrameID);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.Get', [])
  end;
end;
function TRemoteDB.GetItemProductionROLLFORMERID( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetItemProductionROLLFORMERID(0,1,0,Now);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetItemProductionROLLFORMERID', [])
  end;
end;

function TRemoteDB.GetEP2FileJobID( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        aJobID     : Integer;
                        var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetEP2FileJobID(0,1,0,Now,aJobID);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetEP2FileJobID', [])
  end;
end;

function TRemoteDB.GetEP2FileBLOB(anEP2FILEID: Integer;
                        var aDataSet   : TFDMemTable): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetEP2FileBLOB(anEP2FILEID);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetEP2FileBLOB', [])
  end;
end;

function TRemoteDB.GetJobFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetJobFinishedLENGTH;
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetJobFinishedLENGTH', [])
  end;
end;

function TRemoteDB.GetEP2FinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetEP2FinishedLENGTH;
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetEP2FinishedLENGTH', [])
  end;
end;

function TRemoteDB.GetFrameFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetFrameFinishedLENGTH;
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetFrameFinishedLENGTH', [])
  end;
end;

function TRemoteDB.GetJobTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetJobTotalLENGTH;
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetJobTotalLENGTH', [])
  end;
end;

function TRemoteDB.GetEP2TotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetEP2TotalLENGTH;
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.Get', [])
  end;
end;

function TRemoteDB.GetFrameTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetFrameTotalLENGTH;
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TDMRollFormer.GetFrameTotalLENGTH', [])
  end;
end;

function TRemoteDB.GetNewAutoID(gen_fields_id: string): Integer;
begin
  result := FDMRemoteDB.ServerClient.GetNewAutoID(gen_fields_id);
end;

function  TRemoteDB.GetDeltas(aTableName: String; aDataSet : TFDMemTable ) : TFDJSONDeltas;
begin
  if aDataSet.State in dsEditModes then
  begin
    aDataSet.Post;
  end;
  Result := TFDJSONDeltas.Create;
  TFDJSONDeltasWriter.ListAdd(Result, aTableName, aDataSet);
end;

procedure TRemoteDB.DeleteAJob(aJobID : Integer);
begin
  FDMRemoteDB.ServerClient.DeleteAJob(aJobID);
end;

function TRemoteDB.TheJobAlreadyLoaded(aJobName : String) : Integer;
begin
  result := FDMRemoteDB.ServerClient.TheJobAlreadyLoaded(aJobName);
end;

function TRemoteDB.GetEP2AssignInfo(var aDataSet : TFDMemTable; const aJobID : Integer ): Boolean;
var
  DataSetList: TFDJSONDataSets;
begin
  result := False;
  aDataSet.Active  := False;
  try
    DataSetList := FDMRemoteDB.ServerClient.GetEP2AssignInfo(1, aJobID);
    aDataSet.AppendData(TFDJSONDataSetsReader.GetListValue(DataSetList, 0));
    result := True;
  except
    on E: Exception do
      HandleException(E, 'TRemoteDB.GetEP2AssignInfo', [])
  end;
end;

procedure TRemoteDB.ApplyUpdates(aTableName: String; var aDataSet : TFDMemTable );
var
  ADeltaList: TFDJSONDeltas;
begin
  ADeltaList := GetDeltas(aTableName, aDataSet);
  Try
    FDMRemoteDB.ServerClient.ApplyChanges(aTableName, ADeltaList);
  except
    on E: Exception do
      HandleException(E, 'TRemoteDB.ApplyUpdates', []);
  end;
end;

function TRemoteDB.IsDashboard : Boolean;
begin
  Result := UpperCase(Application.Title)=UpperCase('Scotdashboard');
end;

end.
