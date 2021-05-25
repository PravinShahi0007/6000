unit UnitLocalDBClass;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON,
  Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr,
  Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, Data.DBXJSONReflect,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Client, FireDAC.Stan.StorageBin, FireDAC.Stan.StorageJSON,
  FireDAC.Comp.DataSet, ScotRFTypes, Data.DBXFirebird;

type
  TDMLocalDB = class(TDataModule)
    FDConnToDB: TFDConnection;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDTableAdapterRollFormer: TFDTableAdapter;
    FDCommandRollFormer: TFDCommand;
    FDTableAdapterRFDATEINFO: TFDTableAdapter;
    FDCommandRFDATEINFO: TFDCommand;
    FDTableAdapterAUDIT: TFDTableAdapter;
    FDCommandAUDIT: TFDCommand;
    FDTableAdapterRFOPERATION: TFDTableAdapter;
    FDCommandRFOPERATION: TFDCommand;
    FDTableAdapterEP2FileWithoutBlob: TFDTableAdapter;
    FDCommandEP2FileWithoutBlob: TFDCommand;
    FDTableAdapterEP2FileJobID: TFDTableAdapter;
    FDCommandEP2FileJobID: TFDCommand;
    FDTableAdapterEP2File: TFDTableAdapter;
    FDCommandEP2File: TFDCommand;
    FDTableAdapterEP2FileBLOB: TFDTableAdapter;
    FDCommandEP2FileBLOB: TFDCommand;
    FDTableAdapterJOBDETAIL: TFDTableAdapter;
    FDCommandJOBDETAIL: TFDCommand;
    FDTableAdapterJOBTRANSFER: TFDTableAdapter;
    FDCommandJOBTRANSFER: TFDCommand;
    FDTableAdapterJOB: TFDTableAdapter;
    FDCommandJOB: TFDCommand;
    FDTableAdapterITEMPRODUCTION: TFDTableAdapter;
    FDCommandITEMPRODUCTION: TFDCommand;
    FDTableAdapterFRAMEENTITYFrameID: TFDTableAdapter;
    FDCommandFRAMEENTITYFrameID: TFDCommand;
    FDTableAdapterFRAMEENTITY: TFDTableAdapter;
    FDCommandFRAMEENTITY: TFDCommand;
    FDTableAdapterFRAMEEP2FILEID: TFDTableAdapter;
    FDCommandFRAMEEP2FILEID: TFDCommand;
    FDTableAdapterFRAME: TFDTableAdapter;
    FDCommandFRAME: TFDCommand;
    FDTableAdapterItemProductionFrameID: TFDTableAdapter;
    FDCommandItemProductionFrameID: TFDCommand;
    FDTableAdapterItemProductionROLLFORMERID: TFDTableAdapter;
    FDCommandItemProductionROLLFORMERID: TFDCommand;
    SQLConnToDB: TSQLConnection;
    AdapterJobTotalLength: TFDTableAdapter;
    FDCmdJobTotalLength: TFDCommand;
    AdapterJobFinishedLength: TFDTableAdapter;
    FDCmdJobFinishedLength: TFDCommand;
    AdapterEP2TotalLength: TFDTableAdapter;
    FDCmdEP2TotalLength: TFDCommand;
    AdapterEP2FinishedLength: TFDTableAdapter;
    FDCmdEP2FinishedLength: TFDCommand;
    AdapterFrameTotalLength: TFDTableAdapter;
    FDCmdFrameTotalLength: TFDCommand;
    AdapterFrameFinishedLength: TFDTableAdapter;
    FDCmdFrameFinishedLength: TFDCommand;
    FDTableAdapterJOBEX: TFDTableAdapter;
    FDTableAdapterEP2FileEX: TFDTableAdapter;
    FDTableAdapterFRAMEEX: TFDTableAdapter;
    FDTableAdapterFRAMEENTITYEX: TFDTableAdapter;
    FDTableAdapterITEMPRODUCTIONEX: TFDTableAdapter;
    FDTableAdapterJOBDETAILEX: TFDTableAdapter;
    FDTableAdapterRFDATEINFOEX: TFDTableAdapter;
    FDTableAdapterRollFormerEX: TFDTableAdapter;
    FDTableAdapterFORRF: TFDTableAdapter;
    FDTableAdapterJOBTEMP: TFDTableAdapter;
    FDQueryTEMP: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDMemTableLocalDBJOBROLLFORMERIDGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    FTEMPID       : Integer;
    function  GetTransferToRollFormerID : Integer;
  public
    { Public declarations }
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

    function GetJobTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetJobFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;

    function GetEP2TotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2FinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;

    function GetFrameFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetFrameTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetNewAutoID(gen_fields_id: string): Integer;
    function GetEP2FileBLOB(anEP2FILEID: Integer;
                            var aDataSet   : TFDMemTable): Boolean;

    function TheJobRollFormerID(aJobName : String) : TJSONObject;
    function TheEP2RollFormerID(aEP2Name : String) : TJSONObject;
    function GetEP2AssignInfo(var aDataSet : TFDMemTable; const aJobID : Integer ): Boolean;
  end;

  TLocalDB  = class(TInterfacedObject, IDataConn)
  private
    FDMLocalDB : TDMLocalDB;
  public
    constructor Create;
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

    function GetJobTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetJobFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2FinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetFrameFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetEP2TotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetFrameTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
    function GetNewAutoID(gen_fields_id: string): Integer;
    function IsDashboard : Boolean;
    procedure DeleteAJob(aJobID : Integer);
    function TheJobAlreadyLoaded(aJobName : String) : Integer;
    function TheJobRollFormerID(aJobName: string): TJSONObject;
    function TheEP2RollFormerID(aEP2Name: string): TJSONObject;
    function GetEP2AssignInfo(var aDataSet : TFDMemTable; const aJobID : Integer ): Boolean;
    procedure ApplyUpdates( aTableName: String; var aDataSet   : TFDMemTable );
  end;


var
  DMLocalDB: TDMLocalDB;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses com_exception, UnitDSServerDB, Forms, UnitDMDesignJob;

{$R *.dfm}

procedure TDMLocalDB.DataModuleCreate(Sender: TObject);
begin
  FTEMPID := 0;
  InitialDatabase(SQLConnToDB, POSDB_NAME);
  FDConnToDB.Params.Database := POSDB_NAME;
  FDConnToDB.Connected := True;
end;

function TDMLocalDB.GetRFDateInfo( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandRFDATEINFO.CommandText.Clear;
    FDCommandRFDATEINFO.CommandText.Add('select * from RFDATEINFO where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandRFDATEINFO.ParamByName('StatusID').AsInteger   := aStatusID;
    FDCommandRFDATEINFO.ParamByName('SITEID').AsInteger     := aSiteID;
    FDCommandRFDATEINFO.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandRFDATEINFO.ParamByName('ENDDATE').AsDateTime   := aEndTime;
    If aDataSet.Tag=9 then
      aDataSet.Adapter := FDTableAdapterRFDATEINFOEX
    else
      aDataSet.Adapter := FDTableAdapterRFDATEINFO;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetRFDATEINFO', []);
  end;
end;
function TDMLocalDB.GetRollFormer(aStatusID  : SmallInt;
                                  aSiteID    : SmallInt;
                                  aStartTime : TDateTime;
                                  aEndTime   : TDateTime;
                                  var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandRollFormer.CommandText.Clear;
    FDCommandRollFormer.CommandText.Add('select * from ROLLFORMER where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandRollFormer.ParamByName('StatusID').AsInteger := aStatusID;
    FDCommandRollFormer.ParamByName('SiteID').AsInteger := aSiteID;
    FDCommandRollFormer.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandRollFormer.ParamByName('ENDDATE').AsDateTime := aEndTime;
    If aDataSet.Tag=9 then
      aDataSet.Adapter := FDTableAdapterRollFormerEX
    else
      aDataSet.Adapter := FDTableAdapterRollFormer;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetRollFormer', []);
  end;
end;

procedure TDMLocalDB.FDMemTableLocalDBJOBROLLFORMERIDGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := DMDesignJob.GetRollFormerName(Sender.AsInteger);
end;

function TDMLocalDB.GetAudit( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandAUDIT.CommandText.Clear;
    FDCommandAUDIT.CommandText.Add('select * from AUDIT where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandAUDIT.ParamByName('StatusID').AsInteger := aStatusID;
    FDCommandAUDIT.ParamByName('SiteID').AsInteger := aSiteID;
    FDCommandAUDIT.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandAUDIT.ParamByName('ENDDATE').AsDateTime := aEndTime;
    aDataSet.Adapter := FDTableAdapterAUDIT;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetAUDIT', []);
  end;
end;
function TDMLocalDB.GetRFOperation( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandRFOPERATION.CommandText.Clear;
    FDCommandRFOPERATION.CommandText.Add('select * from RFOPERATION where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandRFOPERATION.ParamByName('StatusID').AsInteger   := aStatusID;
    FDCommandRFOPERATION.ParamByName('SiteID').AsInteger     := aSiteID;
    FDCommandRFOPERATION.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandRFOPERATION.ParamByName('ENDDATE').AsDateTime   := aEndTime;
    aDataSet.Adapter := FDTableAdapterRFOPERATION;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetRFOPERATION', []);
  end;
end;

function TDMLocalDB.GetJob( aStatusID    : SmallInt;
                            aSiteID      : SmallInt;
                            aStartTime   : TDateTime;
                            aEndTime     : TDateTime;
                            var aDataSet : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandJOB.CommandText.Clear;
    FDCommandJOB.CommandText.Add('select * from JOB where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandJOB.ParamByName('StatusID').AsInteger   := aStatusID;
    FDCommandJOB.ParamByName('SITEID').AsInteger     := aSiteID;
    FDCommandJOB.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandJOB.ParamByName('ENDDATE').AsDateTime   := aEndTime;
    If aDataSet.Tag=10 then
      aDataSet.Adapter := FDTableAdapterJOBTEMP
    else
    If aDataSet.Tag=9 then
      aDataSet.Adapter := FDTableAdapterJOBEX
    else
      aDataSet.Adapter := FDTableAdapterJOB;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetJOB', []);
  end;
end;
function TDMLocalDB.GetJobTRANSFER( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandJOBTRANSFER.CommandText.Clear;
    FDCommandJOBTRANSFER.CommandText.Add('select * from JOBTRANSFER where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandJOBTRANSFER.ParamByName('StatusID').AsInteger   := aStatusID;
    FDCommandJOBTRANSFER.ParamByName('SiteID').AsInteger     := aSiteID;
    FDCommandJOBTRANSFER.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandJOBTRANSFER.ParamByName('ENDDATE').AsDateTime   := aEndTime;
    aDataSet.Adapter := FDTableAdapterJOBTRANSFER;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetJOBTRANSFER', []);
  end;
end;

function TDMLocalDB.GetJOBDETAIL( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandJOBDETAIL.CommandText.Clear;
    FDCommandJOBDETAIL.CommandText.Add('select * from JOBDETAIL where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandJOBDETAIL.ParamByName('StatusID').AsInteger   := aStatusID;
    FDCommandJOBDETAIL.ParamByName('SiteID').AsInteger     := aSiteID;
    FDCommandJOBDETAIL.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandJOBDETAIL.ParamByName('ENDDATE').AsDateTime   := aEndTime;
    IF aDataSet.Tag=9 THEN
      aDataSet.Adapter := FDTableAdapterJOBDETAILEX
    ELSE
      aDataSet.Adapter := FDTableAdapterJOBDETAIL;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetJOBDETAIL', []);
  end;
end;

function TDMLocalDB.GetEP2FileBLOB(anEP2FILEID: Integer;
                            var aDataSet   : TFDMemTable): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandEP2FileBLOB.CommandText.Clear;
    FDCommandEP2FileBLOB.CommandText.Add('select  EP2FILEID, EP2TEXT from EP2FILE where '
                                    + ' (EP2FILEID=:EP2FILEID) ');
    FDCommandEP2FileBLOB.ParamByName('EP2FILEID').AsInteger := anEP2FILEID;
    aDataSet.Adapter := FDTableAdapterEP2FileBLOB;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetEP2FileBLOB', []);
  end;
end;

function TDMLocalDB.GetEP2File( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandEP2File.CommandText.Clear;
    FDCommandEP2File.CommandText.Add('select * from EP2File where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandEP2File.ParamByName('StatusID').AsInteger := aStatusID;
    FDCommandEP2File.ParamByName('SiteID').AsInteger := aSiteID;
    FDCommandEP2File.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandEP2File.ParamByName('ENDDATE').AsDateTime := aEndTime;
    IF aDataSet.Tag=9 THEN
      aDataSet.Adapter := FDTableAdapterEP2FileEX
    ELSE
      aDataSet.Adapter := FDTableAdapterEP2File;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetEP2File', []);
  end;
end;

function TDMLocalDB.GetEP2FileJobID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            aJobID     : Integer;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandEP2FileJobID.CommandText.Clear;
    FDCommandEP2FileJobID.CommandText.Add('select EP2FILEID,RFTYPEID,EP2FILE, '
                                    + ' STATUSID,JOBID,SITEID,ROLLFORMERID, '
                                    + ' TRANSFERTORFID1,TRANSFERTORFID2,TRANSFERTORFID3,'
                                    + ' TRANSFERTORFID4,TRANSFERTORFID5,TRANSFERTORFID6,'
                                    + ' ADDEDON,EP2TEXT from EP2FILE where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE'
                                    + ' and (JOBID=:JOBID)');
    FDCommandEP2FileJobID.ParamByName('StatusID').AsInteger := aStatusID;
    FDCommandEP2FileJobID.ParamByName('SiteID').AsInteger := aSiteID;
    FDCommandEP2FileJobID.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandEP2FileJobID.ParamByName('ENDDATE').AsDateTime := aEndTime;
    FDCommandEP2FileJobID.ParamByName('JOBID').AsInteger := aJobID;
    aDataSet.Adapter := FDTableAdapterEP2FileJobID;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetEP2FileJobID', []);
  end;
end;

function TDMLocalDB.GetEP2FileWithoutBlob( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandEP2FileWithoutBlob.CommandText.Clear;
    FDCommandEP2FileWithoutBlob.CommandText.Add('select EP2FILEID,RFTYPEID,EP2FILE,STATUSID,JOBID,SITEID,ROLLFORMERID,'
                                    + ' TRANSFERTORFID1,TRANSFERTORFID2,TRANSFERTORFID3,'
                                    + ' TRANSFERTORFID4,TRANSFERTORFID5,TRANSFERTORFID6,'
                                    + ' ADDEDON from EP2FILE where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SIDEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandEP2FileWithoutBlob.ParamByName('StatusID').AsInteger := aStatusID;
    FDCommandEP2FileWithoutBlob.ParamByName('SIDEID').AsInteger := aSiteID;
    FDCommandEP2FileWithoutBlob.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandEP2FileWithoutBlob.ParamByName('ENDDATE').AsDateTime := aEndTime;
    aDataSet.Adapter := FDTableAdapterEP2FileWithoutBlob;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetEP2FileWithoutBlob', []);
  end;
end;

function TDMLocalDB.GetFRAME( aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandFRAME.CommandText.Clear;
    FDCommandFRAME.CommandText.Add('select * from FRAME  where '
                                    + ' (SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandFRAME.ParamByName('SiteID').AsInteger := aSiteID;
    FDCommandFRAME.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandFRAME.ParamByName('ENDDATE').AsDateTime := aEndTime;
    IF aDataSet.Tag=9 THEN
      aDataSet.Adapter := FDTableAdapterFRAMEEX
    ELSE
    IF aDataSet.Tag=5 THEN
      aDataSet.Adapter := FDTableAdapterFORRF
    ELSE
      aDataSet.Adapter := FDTableAdapterFRAME;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetFRAME', []);
  end;
end;

function TDMLocalDB.GetFRAMEEP2FILEID( aSiteID    : SmallInt;
                            aEP2FILEID : Integer;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Open;
  try
    FDCommandFRAMEEP2FILEID.CommandText.Clear;
    FDCommandFRAMEEP2FILEID.CommandText.Add('select * from FRAME where '
                                    + '  (EP2FILEID=:EP2FILEID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandFRAMEEP2FILEID.ParamByName('EP2FILEID').AsInteger := aEP2FILEID;
    FDCommandFRAMEEP2FILEID.ParamByName('SiteID').AsInteger := aSiteID;
    FDCommandFRAMEEP2FILEID.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandFRAMEEP2FILEID.ParamByName('ENDDATE').AsDateTime := aEndTime;
    aDataSet.Adapter := FDTableAdapterFRAMEEP2FILEID;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetFRAMEEP2FILEID', []);
  end;
end;

function TDMLocalDB.GetFRAMEENTITY( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandFRAMEENTITY.CommandText.Clear;
    FDCommandFRAMEENTITY.CommandText.Add('select * from FRAMEENTITY where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandFRAMEENTITY.ParamByName('StatusID').AsInteger := aStatusID;
    FDCommandFRAMEENTITY.ParamByName('SiteID').AsInteger := aSiteID;
    FDCommandFRAMEENTITY.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandFRAMEENTITY.ParamByName('ENDDATE').AsDateTime := aEndTime;
    IF aDataSet.Tag=9 THEN
      aDataSet.Adapter := FDTableAdapterFRAMEENTITYEX
    ELSE
      aDataSet.Adapter := FDTableAdapterFRAMEENTITY;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetFRAMEENTITY', []);
  end;
end;

function TDMLocalDB.GetFRAMEENTITYFrameID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            aFrameID   : Integer;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandFRAMEENTITYFrameID.CommandText.Clear;
    FDCommandFRAMEENTITYFrameID.CommandText.Add('select * from ROLLFORMER where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' AND(FRAMEID=:FRAMEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandFRAMEENTITYFrameID.ParamByName('StatusID').AsInteger := aStatusID;
    FDCommandFRAMEENTITYFrameID.ParamByName('SiteID').AsInteger := aSiteID;
    FDCommandFRAMEENTITYFrameID.ParamByName('FRAMEID').AsInteger := aFrameID;
    FDCommandFRAMEENTITYFrameID.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandFRAMEENTITYFrameID.ParamByName('ENDDATE').AsDateTime := aEndTime;
    aDataSet.Adapter := FDTableAdapterFRAMEENTITYFrameID;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetFRAMEENTITYFrameID', []);
  end;
end;

function TDMLocalDB.GetItemProduction( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandITEMPRODUCTION.CommandText.Clear;
    FDCommandITEMPRODUCTION.CommandText.Add('select * from ITEMPRODUCTION where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandITEMPRODUCTION.ParamByName('StatusID').AsInteger := aStatusID;
    FDCommandITEMPRODUCTION.ParamByName('SiteID').AsInteger := aSiteID;
    FDCommandITEMPRODUCTION.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandITEMPRODUCTION.ParamByName('ENDDATE').AsDateTime := aEndTime;
    IF aDataSet.Tag=9 THEN
      aDataSet.Adapter := FDTableAdapterITEMPRODUCTIONEX
    ELSE
      aDataSet.Adapter := FDTableAdapterITEMPRODUCTION;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetITEMPRODUCTION', []);
  end;
end;

function TDMLocalDB.GetItemProductionFrameID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            aFrameID   : Integer;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandItemProductionFrameID.CommandText.Clear;
    FDCommandItemProductionFrameID.CommandText.Add('select * from ITEMPRODUCTION where '
                                    + ' (STATUSID=:STATUSID) '
                                    + ' and(SITEID=:SITEID) '
                                    + ' AND(FRAMEID=:FRAMEID) '
                                    + ' and ADDEDON '
                                    + ' between :STARTDATE and :ENDDATE');
    FDCommandItemProductionFrameID.ParamByName('StatusID').AsInteger := aStatusID;
    FDCommandItemProductionFrameID.ParamByName('SiteID').AsInteger := aSiteID;
    FDCommandItemProductionFrameID.ParamByName('FRAMEID').AsInteger := aFRAMEID;
    FDCommandItemProductionFrameID.ParamByName('STARTDATE').AsDateTime := aStartTime;
    FDCommandItemProductionFrameID.ParamByName('ENDDATE').AsDateTime := aEndTime;
    aDataSet.Adapter := FDTableAdapterItemProductionFrameID;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetItemProductionFrameID', []);
  end;
end;

function TDMLocalDB.GetItemProductionROLLFORMERID( aStatusID  : SmallInt;
                            aSiteID    : SmallInt;
                            aStartTime : TDateTime;
                            aEndTime   : TDateTime;
                            var aDataSet   : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCommandItemProductionROLLFORMERID.CommandText.Clear;
    FDCommandItemProductionROLLFORMERID.CommandText.Add(' Select ROLLFORMERID, ProducedON, sum(ITEMLENGTH) TOTALLENGTH from (select ROLLFORMERID, ITEMLENGTH, extract(month from ADDEDON)||extract(day from ADDEDON) as ProducedON from ITEMPRODUCTION ) group by ROLLFORMERID, ProducedON ');
    aDataSet.Adapter := FDTableAdapterItemProductionROLLFORMERID;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetItemProductionROLLFORMERID', []);
  end;
end;

function  TDMLocalDB.GetTransferToRollFormerID : Integer;
begin
end;

function TDMLocalDB.GetJobFinishedLENGTH(var aDataSet : TFDMemTable ) : Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCmdJobFinishedLength.CommandText.Clear;
    FDCmdJobFinishedLength.CommandText.Add('SELECT JOBID, Sum(ITEMLENGTH) AS ITEMLENGTH, Sum(ISLAST) AS FinishCount '
                              +' FROM ITEMPRODUCTION '
                              +' Group by JOBID ');
    aDataSet.Adapter := AdapterJobFinishedLength;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetJobFinishedLENGTH', []);
  end;
end;
function TDMLocalDB.GetEP2FinishedLENGTH(var aDataSet : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCmdEP2FinishedLENGTH.CommandText.Clear;
    FDCmdEP2FinishedLENGTH.CommandText.Add('SELECT EP2FILEID, Sum(ITEMLENGTH) AS ITEMLENGTH, Sum(ISLAST) AS FinishCount '
                              +' FROM ITEMPRODUCTION  '
                              +' Group by EP2FILEID');
    aDataSet.Adapter := AdapterEP2FinishedLENGTH;
    aDataSet.Open;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetEP2FinishedLENGTH', []);
  end;
end;
function TDMLocalDB.GetFrameFinishedLENGTH(var aDataSet : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCmdFrameFinishedLENGTH.CommandText.Clear;
    FDCmdFrameFinishedLENGTH.CommandText.Add('SELECT FRAMEID, Sum(ITEMLENGTH) AS ITEMLENGTH '
                              +' FROM ITEMPRODUCTION '
                              +' Group by FRAMEID');
    aDataSet.Adapter := AdapterFrameFinishedLENGTH;
    aDataSet.Open;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetFrameFinishedLENGTH', []);
  end;
end;
function TDMLocalDB.GetJobTotalLENGTH(var aDataSet : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCmdJobTotalLength.CommandText.Clear;
    FDCmdJobTotalLength.CommandText.Add('SELECT JOBID, Sum(LENGTH) AS LENGTH, count(distinct FRAMEID) AS TotalCount '
                              +' FROM FRAMEENTITY '
                              +' Group by JOBID ');
    aDataSet.Adapter := AdapterJobTotalLength;
    aDataSet.Open;
    result := True;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetJobTotalLENGTH', []);
  end;
end;
function TDMLocalDB.GetEP2TotalLENGTH(var aDataSet : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCmdEP2TotalLength.CommandText.Clear;
    FDCmdEP2TotalLength.CommandText.Add('SELECT EP2FILEID, Sum(LENGTH) AS LENGTH, count(distinct FRAMEID) AS TotalCount '
                              +' FROM FRAMEENTITY  '
                              +' Group by EP2FILEID');
    aDataSet.Adapter := AdapterEP2TotalLength;
    aDataSet.Open;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetEP2TotalLENGTH', []);
  end;
end;
function TDMLocalDB.GetFrameTotalLENGTH(var aDataSet : TFDMemTable ): Boolean;
begin
  result := False;
  aDataSet.Close;
  try
    FDCmdFrameTotalLENGTH.CommandText.Clear;
    FDCmdFrameTotalLENGTH.CommandText.Add('SELECT FRAMEID, Sum(LENGTH) AS LENGTH '
                              +' FROM FRAMEENTITY '
                              +' Group by FRAMEID');
    aDataSet.Adapter := AdapterFrameTotalLENGTH;
    aDataSet.Open;
  except
    on E: Exception do
      HandleException(e, 'TDMLocalDB.GetFrameTotalLENGTH', []);
  end;
end;
function TDMLocalDB.GetNewAutoID(gen_fields_id: string): Integer;
begin
  Result := FDConnToDB.ExecSQLScalar('Select gen_id('+gen_fields_id+', 0) from rdb$database');
end;

function TDMLocalDB.TheJobRollFormerID(aJobName : String) : TJSONObject;
var
  aJSONObject : TJSONObject;
begin
  FDQueryTEMP.SQL.Text := 'Select ROLLFORMERID, TRANSFERTORFID1, TRANSFERTORFID2, TRANSFERTORFID3, TRANSFERTORFID4, TRANSFERTORFID5, TRANSFERTORFID6 from JOB WHERE DESIGN = :NAME';
  FDQueryTEMP.ParamByName('NAME').AsString := aJobName;
  FDQueryTEMP.Open;
  aJSONObject := TJSONObject.Create;
  aJSONObject.AddPair(TJSONPair.Create('RollformerID'   , FDQueryTEMP.FieldByName('RollformerID').AsString ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID1', FDQueryTEMP.FieldByName('TRANSFERTORFID1').AsString  ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID2', FDQueryTEMP.FieldByName('TRANSFERTORFID2').AsString  ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID3', FDQueryTEMP.FieldByName('TRANSFERTORFID3').AsString  ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID4', FDQueryTEMP.FieldByName('TRANSFERTORFID4').AsString  ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID5', FDQueryTEMP.FieldByName('TRANSFERTORFID5').AsString  ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID6', FDQueryTEMP.FieldByName('TRANSFERTORFID6').AsString  ));
  result := aJSONObject;
end;

function TDMLocalDB.TheEP2RollFormerID(aEP2Name : String) : TJSONObject;
var
  aJSONObject : TJSONObject;
begin
  FDQueryTEMP.SQL.Text := 'Select ROLLFORMERID, TRANSFERTORFID1, TRANSFERTORFID2, TRANSFERTORFID3, TRANSFERTORFID4, TRANSFERTORFID5, TRANSFERTORFID6 from EP2FILE WHERE EP2FILE = :NAME';
  FDQueryTEMP.ParamByName('NAME').AsString := aEP2Name;
  FDQueryTEMP.Open;
  aJSONObject := TJSONObject.Create;
  aJSONObject.AddPair(TJSONPair.Create('RollformerID'   , FDQueryTEMP.FieldByName('RollformerID').AsString ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID1', FDQueryTEMP.FieldByName('TRANSFERTORFID1').AsString  ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID2', FDQueryTEMP.FieldByName('TRANSFERTORFID2').AsString  ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID3', FDQueryTEMP.FieldByName('TRANSFERTORFID3').AsString  ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID4', FDQueryTEMP.FieldByName('TRANSFERTORFID4').AsString  ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID5', FDQueryTEMP.FieldByName('TRANSFERTORFID5').AsString  ));
  aJSONObject.AddPair(TJSONPair.Create('TRANSFERTORFID6', FDQueryTEMP.FieldByName('TRANSFERTORFID6').AsString  ));
  result := aJSONObject;
end;

function TDMLocalDB.GetEP2AssignInfo(var aDataSet : TFDMemTable; const aJobID : Integer ): Boolean;
begin
  result := False;
end;

Constructor TLocalDB.Create;
begin
  inherited;
  FDMLocalDB := TDMLocalDB.Create(Application);
end;

function TLocalDB.GetRFDateInfo( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetRFDateInfo(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;

function TLocalDB.GetRollFormer( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetRollFormer(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;

function TLocalDB.GetAudit      ( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetAudit(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;

function TLocalDB.GetRFOperation( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetRFoperation(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;

function TLocalDB.GetJob        ( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetJob(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;

function TLocalDB.GetJobTRANSFER( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetJobTRANSFER(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;

function TLocalDB.GetJOBDETAIL  ( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetJOBDETAIL(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;

function TLocalDB.GetEP2File    ( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetEP2File(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;

function TLocalDB.GetEP2FileWithoutBlob( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetEP2FileWithoutBlob(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;
function TLocalDB.GetFRAME      ( aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetFRAME(aSiteID,aStartTime,aEndTime,aDataSet);
end;
function TLocalDB.GetFRAMEEP2FILEID( aSiteID    : SmallInt;
                        aEP2FILEID : Integer;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetFRAMEEP2FILEID(aSiteID,aEP2FILEID,aStartTime,aEndTime,aDataSet);
end;
function TLocalDB.GetFRAMEENTITY( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetFRAMEENTITY(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;
function TLocalDB.GetFRAMEENTITYFrameID( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        aFrameID   : Integer;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetFRAMEENTITYFrameID(aStatusID,aSiteID,aStartTime,aEndTime,aFrameID,aDataSet);
end;
function TLocalDB.GetItemProduction( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetItemProduction(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;
function TLocalDB.GetItemProductionFrameID( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        aFrameID   : Integer;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetItemProductionFrameID(aStatusID,aSiteID,aStartTime,aEndTime,aFrameID,aDataSet);
end;
function TLocalDB.GetItemProductionROLLFORMERID( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetItemProductionROLLFORMERID(aStatusID,aSiteID,aStartTime,aEndTime,aDataSet);
end;
function TLocalDB.GetEP2FileJobID( aStatusID  : SmallInt;
                        aSiteID    : SmallInt;
                        aStartTime : TDateTime;
                        aEndTime   : TDateTime;
                        aJobID     : Integer;
                        var aDataSet   : TFDMemTable ): Boolean;
begin

end;
function TLocalDB.GetEP2FileBLOB(anEP2FILEID: Integer;
                        var aDataSet   : TFDMemTable): Boolean;
begin
  result :=  FDMLocalDB.GetEP2FileBLOB(anEP2FILEID,aDataSet);
end;

function TLocalDB.GetJobFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetJobFinishedLENGTH(aDataSet);
end;
function TLocalDB.GetEP2FinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetEP2FinishedLENGTH(aDataSet);
end;

function TLocalDB.GetFrameFinishedLENGTH(var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetFrameFinishedLENGTH(aDataSet);
end;
function TLocalDB.GetJobTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetJobTotalLENGTH(aDataSet);
end;
function TLocalDB.GetEP2TotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetEP2TotalLENGTH(aDataSet);
end;
function TLocalDB.GetFrameTotalLENGTH(var aDataSet   : TFDMemTable ): Boolean;
begin
  result :=  FDMLocalDB.GetFrameTotalLENGTH(aDataSet);
end;
function TLocalDB.GetNewAutoID(gen_fields_id: string): Integer;
begin
  result := FDMLocalDB.GetNewAutoID(gen_fields_id)
end;

function TLocalDB.TheJobAlreadyLoaded(aJobName : String) : Integer;
begin
  Result := FDMLocalDB.FDConnToDB.ExecSQLScalar('Select JOBID from JOB WHERE DESIGN = :NAME', [aJobName]);
end;

function TLocalDB.TheJobRollFormerID(aJobName: string): TJSONObject;
begin
  Result := FDMLocalDB.TheJobRollFormerID(aJobName);
end;

function TLocalDB.TheEP2RollFormerID(aEP2Name: string): TJSONObject;
begin
  Result := FDMLocalDB.TheEP2RollFormerID(aEP2Name);
end;

function TLocalDB.GetEP2AssignInfo(var aDataSet : TFDMemTable; const aJobID : Integer ): Boolean;
begin
  Result := FDMLocalDB.GetEP2AssignInfo(aDataSet, aJobID);
end;

procedure TLocalDB.DeleteAJob(aJobID : Integer);
begin
  FDMLocalDB.FDConnToDB.ExecSQL('Delete from JOB            where JOBID = :JOBID',[aJobID]);
  FDMLocalDB.FDConnToDB.ExecSQL('Delete from EP2FILE        where JOBID = :JOBID',[aJobID]);
  FDMLocalDB.FDConnToDB.ExecSQL('Delete from FRAME          where JOBID = :JOBID',[aJobID]);
  FDMLocalDB.FDConnToDB.ExecSQL('Delete from JOBDETAIL      where JOBID = :JOBID',[aJobID]);
  FDMLocalDB.FDConnToDB.ExecSQL('Delete from FRAMEENTITY    where JOBID = :JOBID',[aJobID]);
  FDMLocalDB.FDConnToDB.ExecSQL('Delete from ITEMPRODUCTION where JOBID = :JOBID',[aJobID]);
end;

procedure TLocalDB.ApplyUpdates(aTableName: String; var aDataSet : TFDMemTable );
begin
  if aDataSet.ApplyUpdates(0)=0 then
  begin
    //
  end;
end;

function TLocalDB.IsDashboard : Boolean;
begin
  Result := UpperCase(Application.Title)=UpperCase('Scotdashboard');
end;

end.
