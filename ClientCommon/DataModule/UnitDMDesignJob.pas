unit UnitDMDesignJob;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, FrameDataU, GlobalU, Data.FMTBcd, Data.SqlExpr,
  Datasnap.Provider, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.FireDACJSONReflect,
  DataSnap.DSClientRest, FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin,
  Vcl.StdCtrls;

type

  TTransferType =(ttJob, ttEP2TXT, ttFrame, ttFrameItem);

  TDMDesignJob = class(TDataModule)
    DataSourceJob: TDataSource;
    DataSourceFrame: TDataSource;
    DataSourceFrameEntity: TDataSource;
    DataSourceItemProduction: TDataSource;
    DataSourceEP2File: TDataSource;
    FDMemTableItemProduction: TFDMemTable;
    FDMemTableFrameEntity: TFDMemTable;
    FDMemTableFrame: TFDMemTable;
    FDMemTableEP2FILE: TFDMemTable;
    FDMemTableJOB: TFDMemTable;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDMemTableFrameEntityFRAMELENGTH: TAggregateField;
    FDMemTableJOBDETAIL: TFDMemTable;
    FDMemTableRFDateInfo: TFDMemTable;
    FDMemTableRollFormer: TFDMemTable;
    FDMemTableFrameFRAMEID: TIntegerField;
    FDMemTableFrameEP2FILEID: TIntegerField;
    FDMemTableFrameJOBID: TIntegerField;
    FDMemTableFrameMINHOLEDISTANCE: TFloatField;
    FDMemTableFramePROFILEHEIGHT: TFloatField;
    FDMemTableFramePRECAMBER: TFloatField;
    FDMemTableFrameITEMCOUNT: TSmallintField;
    FDMemTableFramePRODUCEDFRAMES: TSmallintField;
    FDMemTableFrameNUMBEROFFRAMES: TSmallintField;
    FDMemTableFramePLATEYMIN: TFloatField;
    FDMemTableFramePLATEYMAX: TFloatField;
    FDMemTableFrameXMIN: TFloatField;
    FDMemTableFrameXMAX: TFloatField;
    FDMemTableFrameYMIN: TFloatField;
    FDMemTableFrameYMAX: TFloatField;
    FDMemTableFrameSPACERS: TSmallintField;
    FDMemTableFrameTEKSCREWS: TSmallintField;
    FDMemTableFrameCONNECTIONCOUNT: TSmallintField;
    FDMemTableFrameCONNECTORS: TSmallintField;
    FDMemTableFrameSTATUSID: TSmallintField;
    FDMemTableFrameSITEID: TSmallintField;
    FDMemTableFrameADDEDON: TSQLTimeStampField;
    FDMemTableFrameRIVETS: TIntegerField;
    FDMemTableFrameLENGTH: TFloatField;
    FDMemTableFrameRFTYPEID: TSmallintField;
    FDMemTableFrameFRAMENAME: TWideStringField;
    FDMemTableFrameEP2FILE: TWideStringField;
    FDMemTableFrameEntityFRAMEENTITYID: TIntegerField;
    FDMemTableFrameEntityFRAMEID: TIntegerField;
    FDMemTableFrameEntityJOBID: TIntegerField;
    FDMemTableFrameEntityID: TIntegerField;
    FDMemTableFrameEntityPOINT1X: TFloatField;
    FDMemTableFrameEntityPOINT1Y: TFloatField;
    FDMemTableFrameEntityPOINT2X: TFloatField;
    FDMemTableFrameEntityPOINT2Y: TFloatField;
    FDMemTableFrameEntityPOINT3X: TFloatField;
    FDMemTableFrameEntityPOINT3Y: TFloatField;
    FDMemTableFrameEntityPOINT4X: TFloatField;
    FDMemTableFrameEntityPOINT4Y: TFloatField;
    FDMemTableFrameEntityLENGTH: TFloatField;
    FDMemTableFrameEntityWEB: TFloatField;
    FDMemTableFrameEntityCOL: TIntegerField;
    FDMemTableFrameEntityOPCOUNT: TIntegerField;
    FDMemTableFrameEntityORIENTATION: TSmallintField;
    FDMemTableFrameEntityNONRF: TSmallintField;
    FDMemTableFrameEntityISFACINGITEM: TSmallintField;
    FDMemTableFrameEntitySTATUSID: TSmallintField;
    FDMemTableFrameEntitySITEID: TIntegerField;
    FDMemTableFrameEntityADDEDON: TSQLTimeStampField;
    FDMemTableFrameEntityRFTYPEID: TSmallintField;
    FDMemTableFrameEntityITEMNAME: TWideStringField;
    FDMemTableFrameEntityFRAMENAME: TWideStringField;
    FDMemTableFrameEntityFRAMETYPE: TWideStringField;
    DataSourceRollFormer: TDataSource;
    FDMemTableItemProductionITEMPRODUCTIONID: TIntegerField;
    FDMemTableItemProductionITEMLENGTH: TFloatField;
    FDMemTableItemProductionISLAST: TSmallintField;
    FDMemTableItemProductionSERIALNUMBER: TIntegerField;
    FDMemTableItemProductionISBOXWEB: TSmallintField;
    FDMemTableItemProductionISBOXWEBDOUBLE: TSmallintField;
    FDMemTableItemProductionSCREWCOUNT: TSmallintField;
    FDMemTableItemProductionSPACERCOUNT: TSmallintField;
    FDMemTableItemProductionSTATUSID: TSmallintField;
    FDMemTableItemProductionFRAMEID: TIntegerField;
    FDMemTableItemProductionSITEID: TIntegerField;
    FDMemTableItemProductionROLLFORMERID: TIntegerField;
    FDMemTableItemProductionADDEDON: TSQLTimeStampField;
    FDMemTableItemProductionTRUSSNAME: TWideStringField;
    FDMemTableItemProductionITEMNAME: TWideStringField;
    FDMemTableItemProductionLENGTHTOTAL: TAggregateField;
    FDMemTableRFDateInfoRFDATEINFOID: TSmallintField;
    FDMemTableRFDateInfoRFINFODATE: TDateField;
    FDMemTableRFDateInfoROLLFORMERID: TSmallintField;
    FDMemTableRFDateInfoCARDNUMBER: TWideStringField;
    FDMemTableRFDateInfoMETERS: TFloatField;
    FDMemTableRFDateInfoRUNSECONDS: TIntegerField;
    FDMemTableRFDateInfoSITEID: TSmallintField;
    FDMemTableItemProductionCARDNUMBER: TWideStringField;
    FDMemTableItemProductionCOPYID: TSmallintField;
    FDMemTableFrameROLLFORMERID: TSmallintField;
    FDMemTableJOBROLLFORMERID: TSmallintField;
    FDMemTableJOBDESIGN: TWideStringField;
    FDMemTableJOBSITEID: TSmallintField;
    FDMemTableJOBJOBID: TIntegerField;
    FDMemTableJOBADDEDON: TSQLTimeStampField;
    FDMemTableJOBFRAMECOPIES: TSmallintField;
    FDMemTableJOBSTEEL: TWideStringField;
    FDMemTableJOBRFTYPEID: TSmallintField;
    FDMemTableEP2FILEEP2FILEID: TIntegerField;
    FDMemTableEP2FILERFTYPEID: TSmallintField;
    FDMemTableEP2FILEEP2FILE: TWideStringField;
    FDMemTableEP2FILESTATUSID: TSmallintField;
    FDMemTableEP2FILEJOBID: TIntegerField;
    FDMemTableEP2FILESITEID: TSmallintField;
    FDMemTableEP2FILEROLLFORMERID: TIntegerField;
    FDMemTableEP2FILEADDEDON: TSQLTimeStampField;
    FDMemTableJobTotalLength: TFDMemTable;
    FDMemTableEP2TotalLength: TFDMemTable;
    FDMemTableFrameTotalLength: TFDMemTable;
    FDMemTableJobTotalLengthJOBID: TIntegerField;
    FDMemTableEP2TotalLengthEP2FILEID: TIntegerField;
    FDMemTableFrameTotalLengthFRAMEID: TIntegerField;
    FDMemTableJobFinishedLength: TFDMemTable;
    FDMemTableEP2FinishedLength: TFDMemTable;
    FDMemTableFrameFinishedLength: TFDMemTable;
    FDMemTableJobFinishedLengthJOBID: TIntegerField;
    FDMemTableEP2FinishedLengthEP2FILEID: TIntegerField;
    FDMemTableFrameFinishedLengthFRAMEID: TIntegerField;
    FDMemTableFramePercentage: TFloatField;
    FDMemTableJOBPercentage: TFloatField;
    FDMemTableEP2FILEPercentage: TFloatField;
    FDMemTableJobFinishedLengthITEMLENGTH: TFloatField;
    FDMemTableEP2FinishedLengthITEMLENGTH: TFloatField;
    FDMemTableFrameFinishedLengthITEMLENGTH: TFloatField;
    FDMemTableJobTotalLengthLENGTH: TFloatField;
    FDMemTableEP2TotalLengthLENGTH: TFloatField;
    FDMemTableFrameTotalLengthLENGTH: TFloatField;
    FDMemTableEP2FILELENGTH: TFloatField;
    FDMemTableEP2FILEFINISHEDLENGTH: TFloatField;
    FDMemTableJOBLENGTH: TFloatField;
    FDMemTableJOBFINISHEDLENGTH2: TFloatField;
    FDMemTableFrameFinishedLength2: TFloatField;
    FDMemTableFrameTOTALLENGTH2: TFloatField;
    FDMemTableEP2FILETotalCount: TIntegerField;
    FDMemTableEP2FILEFinishCount: TIntegerField;
    FDMemTableEP2FILECountDisplay: TStringField;
    FDMemTableJOBTotalCount: TIntegerField;
    FDMemTableJOBFinishCount: TIntegerField;
    FDMemTableJOBCountDisplay: TStringField;
    FDMemTableJobFinishedLengthFinishCount: TLargeintField;
    FDMemTableEP2FinishedLengthFinishCount: TLargeintField;
    FDMemTableJobTotalLengthTotalCount: TIntegerField;
    FDMemTableEP2TotalLengthTotalCount: TIntegerField;
    FDMemTableROLLFORMERIDItemProduction: TFDMemTable;
    FDMemTableROLLFORMERIDItemProductionROLLFORMERID: TIntegerField;
    FDMemTableJobTransfer: TFDMemTable;
    FDMemTableItemProductionJOBID: TIntegerField;
    FDMemTableROLLFORMERIDItemProductionTOTALLENGTH: TFloatField;
    FDMemTableROLLFORMERIDItemProductionPRODUCEDON: TStringField;
    DataSourceDailyProduction: TDataSource;
    FDMemTableROLLFORMERIDItemProductionMeters: TFloatField;
    FDMemTableJOBTRANSFERTORFID1: TSmallintField;
    FDMemTableJOBTRANSFERTORFID2: TSmallintField;
    FDMemTableJOBTRANSFERTORFID3: TSmallintField;
    FDMemTableJOBTRANSFERTORFID4: TSmallintField;
    FDMemTableJOBTRANSFERTORFID5: TSmallintField;
    FDMemTableJOBTRANSFERTORFID6: TSmallintField;
    FDMemTableEP2FILETRANSFERTORFID1: TSmallintField;
    FDMemTableEP2FILETRANSFERTORFID2: TSmallintField;
    FDMemTableEP2FILETRANSFERTORFID3: TSmallintField;
    FDMemTableEP2FILETRANSFERTORFID4: TSmallintField;
    FDMemTableEP2FILETRANSFERTORFID5: TSmallintField;
    FDMemTableEP2FILETRANSFERTORFID6: TSmallintField;
    FDMemTableFrameTRANSFERTORFID1: TSmallintField;
    FDMemTableFrameTRANSFERTORFID2: TSmallintField;
    FDMemTableFrameTRANSFERTORFID3: TSmallintField;
    FDMemTableFrameTRANSFERTORFID4: TSmallintField;
    FDMemTableFrameTRANSFERTORFID5: TSmallintField;
    FDMemTableFrameTRANSFERTORFID6: TSmallintField;
    FDMemTableJOBFILEPATH: TWideStringField;
    FDMemTableEP2JobAssign: TFDMemTable;
    FDMemTableJOBJobAssign: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSFrameCalcFields(DataSet: TDataSet);
    procedure FDMemTableFrameCalcFields(DataSet: TDataSet);
    procedure FDMemTableFrameROLLFORMERIDGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure FDMemTableEP2FILECalcFields(DataSet: TDataSet);
    procedure FDMemTableJOBCalcFields(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FDMemTableROLLFORMERIDItemProductionCalcFields(DataSet: TDataSet);
    procedure FDMemTableJOBAfterScroll(DataSet: TDataSet);
    procedure FDMemTableJOBFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FDMemTableEP2FILEFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure FDMemTableEP2FILETRANSFERTORFID1GetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
    FStartTime : TDatetime;
    FEndTime   : TDatetime;
    FJOBIDs    : TStringList;
    FRollFormerStrings   : TStringList;
    FScotRFRollFormerID  : Integer;
    FMemoJobTransferInfo : TMemo;
    FMemoEP2TransferInfo : TMemo;
    FFilterDown          : Boolean;
    FTempDesignName      : String;
    FTempJobID           : Integer;
    procedure SetStartTime(aTime : TDatetime);
    procedure SetEndTime(aTime : TDatetime);
    function  GetProjectName : String;
    function  GetDeltas(aTableName : String; aFDMemTable : TFDMemTable) : TFDJSONDeltas;
    function  GetRollFoemerStrings : TStringList;
    function  GetItemProducedWarning    : String;
    function  GetEP2TransferInformation : String;
    function  GetJobLoadInformation : String;
  public
    { Public declarations }
    procedure GetItemProduction;
    procedure GetItemProductionROLLFORMERID;
    procedure GetFrameEntity;
    procedure GetFrame;
    procedure GetEP2FILE;
    procedure GetJOB;
    procedure GetJOBDetails;
    procedure GetROLLFORMER;
    procedure GetRFDateInfo;
    procedure GetJOBTransfer;
    procedure GetJobTotalLENGTH;
    procedure GetEP2TotalLENGTH;
    procedure GetFrameTotalLENGTH;
    procedure GetJobFinishedLENGTH;
    procedure GetEP2FinishedLENGTH;
    procedure GetFrameFinishedLENGTH;
    procedure ApplyUpdates(aTableName : String; aFDMemTable : TFDMemTable);
    procedure RefreshData(Sender: TObject);
    procedure ResetFilter (aRFID : String);
    procedure DoTransfer;overload;
    procedure DoTransfer(aFrom : Integer; aTo :Integer; aTransferType : TTransferType );overload;
    procedure DoAssignTo(aAssignTo :Integer );
    procedure DeleteAJob(aJobID : Integer; aJobName: String);
    procedure RefreshRFJobList(aFDMemTable : TFDMemTable);
    function  GetRollFormerName(aRFID : Integer) : String;
    function  TheJobIsAlreadyLoaded(AFilePath : String) : Integer;
    property  StartTime   : TDatetime read FStartTime write SetStartTime;
    property  EndTime     : TDatetime read FEndTime   write SetEndTime;
    property  ProjectName : String read GetProjectName;
    property  RollFoemerStrings : TStringList read GetRollFoemerStrings;
    property  ItemProducedWarning : String read GetItemProducedWarning;
    property  ScotRFRollFormerID : Integer read FScotRFRollFormerID write FScotRFRollFormerID;
    property  EP2TransferInformation : String read GetEP2TransferInformation;
    property  JobLoadInformation     : String read GetJobLoadInformation;
    property  FilterDown          : Boolean read FFilterDown write FFilterDown;
  end;

var
  DMDesignJob: TDMDesignJob;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses DateUtils, Com_Exception, ScotRFTypes, UnitDMRollFormer,
  UnitDataSnapClientClass, System.JSON, System.Generics.Collections, Variants,
  PBThreadedSplashscreenU, SplashScreenU, UnitDMJobTransfer, dialogs,
  UnitRemoteDBClass, UnitLocalDBClass, UnitDisplayDataset, UnitDMLoadEP2Files;

function IsEmptyOrNull(const Value: Variant): Boolean;
begin
  Result := VarIsClear(Value) or VarIsEmpty(Value) or VarIsNull(Value)
           or (VarCompareValue(Value, Unassigned) = vrEqual);
  if (not Result) and VarIsStr(Value) then
    Result := Value = '';
end;

procedure TDMDesignJob.ResetFilter(aRFID : String);
begin
  FDMemTableItemProduction.Filtered := False;
  FDMemTableJOB.Filtered            := False;
  FDMemTableEP2FILE.Filtered        := False;
  FDMemTableFrame.Filtered          := False;
  IF aRFID='0' THEN
    EXIT;
  FDMemTableItemProduction.Filtered := True;
  FDMemTableJOB.Filtered            := True;
  FDMemTableEP2FILE.Filtered        := True;
  FDMemTableFrame.Filtered          := True;
end;


function  TDMDesignJob.GetDeltas(aTableName : String; aFDMemTable : TFDMemTable) : TFDJSONDeltas;
begin
  // Post if editing
  if aFDMemTable.State in dsEditModes then
  begin
    aFDMemTable.Post;
  end;
  // Create a delta list
  Result := TFDJSONDeltas.Create;
  TFDJSONDeltasWriter.ListAdd(Result, aTableName, aFDMemTable);
end;

procedure TDMDesignJob.RefreshRFJobList(aFDMemTable : TFDMemTable);
begin
  try
    if not aFDMemTable.Active then
      aFDMemTable.Open;
    aFDMemTable.EmptyDataSet;
    FDMemTableEP2FILE.First;
    while not FDMemTableEP2FILE.eof do
    begin
      if not aFDMemTable.FindKey([1,FDMemTableEP2FILE.FieldByName('JOBID').asInteger]) then
      begin
        aFDMemTable.Append;
        aFDMemTable.FieldByName('SITEID').asInteger := 1;
        aFDMemTable.FieldByName('JOBID').asInteger  := FDMemTableEP2FILE.FieldByName('JOBID').asInteger;
        aFDMemTable.Post;
      end;
      FDMemTableEP2FILE.Next;
    end;
  except
    on e : exception do
      HandleException(e,'TFormJobSelection.FormCreate',[])
  end;
end;

procedure TDMDesignJob.ApplyUpdates(aTableName : String; aFDMemTable : TFDMemTable);
begin
  Try
    DMScotServer.ApplyUpdates(aTableName, aFDMemTable);
  except
    on E: Exception do
      HandleException(E, 'TDMTemplate.ApplyUpdates', []);
  end;
end;

procedure TDMDesignJob.CDSFrameCalcFields(DataSet: TDataSet);
begin
{$IFDEF PANEL}
  FDMemTableFrameRIVETS.AsInteger := FDMemTableFrameCONNECTIONCOUNT.AsInteger*2;
{$ELSE}
  FDMemTableFrameRIVETS.AsInteger := FDMemTableFrameCONNECTIONCOUNT.AsInteger;
{$ENDIF}
end;

procedure TDMDesignJob.DataModuleCreate(Sender: TObject);
begin
  FStartTime    := Now-14;
  FEndTime      := Now;
  FRollFormerStrings := TStringList.Create;
  FJOBIDs            := TStringList.Create;
  FilterDown         := False;
  ScotRFRollFormerID := DMSCOTRFID.ScotRFRollFormerID;
  RefreshData(nil);
end;

procedure TDMDesignJob.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FRollFormerStrings);
  FreeAndNil(FJOBIDs);
end;

procedure TDMDesignJob.FDMemTableEP2FILECalcFields(DataSet: TDataSet);
begin
  FDMemTableEP2FILEPercentage.AsFloat   := 100*FDMemTableEP2FILEFinishedLength.AsFloat/FDMemTableEP2FILELength.AsFloat;
  FDMemTableEP2FILECountDisplay.AsString := Format('%d of %d',[FDMemTableEP2FILEFinishCount.AsInteger, FDMemTableEP2FILETotalCount.AsInteger]);
end;

procedure TDMDesignJob.FDMemTableEP2FILEFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If not DMScotServer.IsDashboard then
  begin
    Accept :=  (ScotRFRollFormerID = FDMemTableEP2FILERollFormerID.AsInteger)
            or (ScotRFRollFormerID = FDMemTableEP2FILETRANSFERTORFID1.AsInteger)
            or (ScotRFRollFormerID = FDMemTableEP2FILETRANSFERTORFID2.AsInteger)
            or (ScotRFRollFormerID = FDMemTableEP2FILETRANSFERTORFID3.AsInteger)
            or (ScotRFRollFormerID = FDMemTableEP2FILETRANSFERTORFID4.AsInteger)
            or (ScotRFRollFormerID = FDMemTableEP2FILETRANSFERTORFID5.AsInteger)
            or (ScotRFRollFormerID = FDMemTableEP2FILETRANSFERTORFID6.AsInteger) ;
  end;
end;

procedure TDMDesignJob.FDMemTableEP2FILETRANSFERTORFID1GetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if FDMemTableRollFormer.Locate('RollFormerID',Sender.AsInteger,[]) then
    Text:= 'Transferred to:'+FDMemTableRollFormer.FieldByName('NAME').AsString
  else
    DisplayText:= False;
end;

procedure TDMDesignJob.FDMemTableJOBFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If not DMScotServer.IsDashboard then
  begin
    Accept := (ScotRFRollFormerID = FDMemTableJOBROLLFORMERID.AsInteger);
    Accept := Accept or (ScotRFRollFormerID = FDMemTableJOBTRANSFERTORFID1.AsInteger);
    Accept := Accept or (ScotRFRollFormerID = FDMemTableJOBTRANSFERTORFID2.AsInteger);
    Accept := Accept or (ScotRFRollFormerID = FDMemTableJOBTRANSFERTORFID3.AsInteger);
    Accept := Accept or (ScotRFRollFormerID = FDMemTableJOBTRANSFERTORFID4.AsInteger);
    Accept := Accept or (ScotRFRollFormerID = FDMemTableJOBTRANSFERTORFID5.AsInteger);
    Accept := Accept or (ScotRFRollFormerID = FDMemTableJOBTRANSFERTORFID6.AsInteger);
  end
  else
  begin
    If FilterDown then
      Accept := (ScotRFRollFormerID = FDMemTableJOBROLLFORMERID.AsInteger)
    else
      Accept := True;
  end;
  Accept := Accept and NOT FDMemTableJobTransfer.Locate(
                                'JOBID;TOROLLFORMERID',
                            VarArrayOf([DataSet.FieldByName('JOBID').AsInteger, 0]),[]);// Remove Job
end;

procedure TDMDesignJob.FDMemTableFrameCalcFields(DataSet: TDataSet);
begin
{$IFDEF PANEL}
  FDMemTableFrameRIVETS.AsInteger := FDMemTableFrameCONNECTIONCOUNT.AsInteger*2;
{$ELSE}
  FDMemTableFrameRIVETS.AsInteger := FDMemTableFrameCONNECTIONCOUNT.AsInteger;
{$ENDIF}
  FDMemTableFramePercentage.AsFloat := 100*FDMemTableFrameFinishedLength2.AsFloat/FDMemTableFrameTotalLength2.AsFloat;
end;

procedure TDMDesignJob.FDMemTableFrameROLLFORMERIDGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := GetRollFormerName(Sender.AsInteger);
end;

procedure TDMDesignJob.FDMemTableJOBAfterScroll(DataSet: TDataSet);
begin
  If DMScotServer.IsDashboard then
    ScotRFRollFormerID := FDMemTableJOBROLLFORMERID.AsInteger;
  FDMemTableJOB.AfterScroll := nil;
  try
    If not DMScotServer.IsDashboard then
      ResetFilter(IntToStr(ScotRFRollFormerID))
    else
      ResetFilter('0');
  finally
    FDMemTableJOB.AfterScroll := FDMemTableJOBAfterScroll;
  end;
end;

procedure TDMDesignJob.FDMemTableJOBCalcFields(DataSet: TDataSet);
begin
  FDMemTableJOBPercentage.AsFloat := 100*FDMemTableJOBFinishedLength2.AsFloat/FDMemTableJOBLength.AsFloat;
  FDMemTableJOBCountDisplay.AsString := Format('%d of %d',[FDMemTableJOBFinishCount.AsInteger, FDMemTableJOBTotalCount.AsInteger]);
end;

procedure TDMDesignJob.FDMemTableROLLFORMERIDItemProductionCalcFields(
  DataSet: TDataSet);
begin
  FDMemTableROLLFORMERIDItemProductionMeters.AsFloat := FDMemTableROLLFORMERIDItemProductionTOTALLENGTH.AsFloat/1000;
end;

procedure TDMDesignJob.RefreshData(Sender: TObject);
var
  aPtr : TDataSetNotifyEvent;
  aJobID     : Integer;
  aEP2FILEID : Integer;
  aFrameID   : Integer;
begin
  aPtr := FDMemTableEP2FILE.AfterScroll;
  ResetFilter(IntToStr(0));
  aJobID      := FDMemTableJOBJobID.AsInteger;
  aEP2FILEID  := FDMemTableEP2FILEEP2FILEID.AsInteger;
  aFrameID    := FDMemTableFrameFRAMEID.AsInteger;
  ShowSplashscreen('Refresh Data', 'PanelLogo');
  If DMScotServer.IsDashboard then
  begin
    FDMemTableEP2FILE.MasterFields := 'SITEID;JOBID';
    FDMemTableEP2FILE.MasterSource := DataSourceJOB;
  end;
  try
    FDMemTableJOB.AfterScroll := nil;
    FDMemTableEP2FILE.AfterScroll := nil;
    ShowSplashScreenMessage('Calculate Job Finish Percentage');
    GetJobTotalLENGTH;
    GetEP2TotalLENGTH;
    GetFrameTotalLENGTH;
    GetJobFinishedLENGTH;
    GetEP2FinishedLENGTH;
    GetFrameFinishedLENGTH;
    GetJOBTransfer;
    ShowSplashScreenMessage('Get Item Production');
    GetItemProduction;
    ShowSplashScreenMessage('Get Frame Entity');
    GetFrameEntity;
    ShowSplashScreenMessage('Get Frame');
    GetFrame;
    ShowSplashScreenMessage('Get EP2/TXT FILE');
    GetEP2FILE;
    ShowSplashScreenMessage('Get JOB');
    GetJOB;
    ShowSplashScreenMessage('Get JOBDetails');
    GetJOBDetails;
    ShowSplashScreenMessage('Get RFDateInfo');
    GetRFDateInfo;
    ShowSplashScreenMessage('Get ROLLFORMER');
    GetROLLFORMER;
    GetItemProductionROLLFORMERID;
  finally
    HideSplashscreen;
    if G_Settings.general_IsConnectToServer and (NOT TRemoteDB(DMScotServer).IsDashboard) then
    begin
      ResetFilter(IntToStr(ScotRFRollFormerID));
      FJOBIDs.Clear;
      FDMemTableJOB.First;
      while not FDMemTableJOB.Eof do
      begin
        FJOBIDs.Add(FDMemTableJOB.FieldByName('JOBID').AsString );
        FDMemTableJOB.Next;
      end;
    end
    else
    begin
      FDMemTableJOB.FindNearest([1,aJobID]);
      FDMemTableEP2FILE.FindNearest([1,aJOBID,aEP2FILEID]);
      FDMemTableFrame.FindNearest([aEP2FILEID,aFrameID]);
    end;
    FDMemTableJOB.AfterScroll := FDMemTableJOBAfterScroll;
    FDMemTableEP2FILE.AfterScroll := aPtr;
  end;
end;

procedure TDMDesignJob.SetStartTime(aTime : TDatetime);
begin
  FStartTime := aTime;
end;

procedure TDMDesignJob.SetEndTime(aTime : TDatetime);
begin
  FEndTime := aTime;
end;

function TDMDesignJob.GetProjectName : String;
begin
  Result:= FDMemTableRollFormer.FieldByName('NAME').AsString;
end;

function  TDMDesignJob.GetRollFoemerStrings : TStringList;
begin
  Result := FRollFormerStrings;
end;

function  TDMDesignJob.GetJobLoadInformation : String;
var
  aJobLoadInfo : String;
  aRFName : String;
begin
  aRFName :='';
  if FDMemTableJOBTRANSFERTORFID1.AsInteger>0 then
  begin
    aJobLoadInfo := GetRollFormerName(FDMemTableJOBTRANSFERTORFID1.AsInteger);
  end;
  if FDMemTableJOBTRANSFERTORFID2.AsInteger>0 then
  begin
    aJobLoadInfo := aJobLoadInfo +','+ GetRollFormerName(FDMemTableJOBTRANSFERTORFID2.AsInteger);
  end;
  if FDMemTableJOBTRANSFERTORFID3.AsInteger>0 then
  begin
    aJobLoadInfo := aJobLoadInfo +','+ GetRollFormerName(FDMemTableJOBTRANSFERTORFID3.AsInteger);
  end;
  if FDMemTableJOBTRANSFERTORFID4.AsInteger>0 then
  begin
    aJobLoadInfo := aJobLoadInfo +','+ GetRollFormerName(FDMemTableJOBTRANSFERTORFID4.AsInteger);
  end;
  if FDMemTableJOBTRANSFERTORFID5.AsInteger>0 then
  begin
    aJobLoadInfo := aJobLoadInfo +','+ GetRollFormerName(FDMemTableJOBTRANSFERTORFID5.AsInteger);
  end;
  if FDMemTableJOBTRANSFERTORFID6.AsInteger>0 then
  begin
    aJobLoadInfo := aJobLoadInfo +','+ GetRollFormerName(FDMemTableJOBTRANSFERTORFID6.AsInteger);
  end;
  if aRFName<>'' then
  begin
    result := Format('The JOB(%s) initally load on %s, also visible on %s',[FTempDesignName, GetRollFormerName(FDMemTableEP2FILEROLLFORMERID.AsInteger), aJobLoadInfo]);
  end
  else
  begin
    result := Format('The JOB(%s) loaded and assigned to %s', [FTempDesignName, GetRollFormerName(FDMemTableEP2FILEROLLFORMERID.AsInteger)]);
  end;
end;

function  TDMDesignJob.GetEP2TransferInformation : String;
var
  aEP2TransferToRF : String;
  aJOBTransferToRF : String;
  aEP2Temp         : String;

begin
  aEP2TransferToRF :='';
  aJOBTransferToRF :='';
  DMScotServer.GetJOB(0, 1, EndTime-300, EndTime, FDMemTableJOBJobAssign);
  FDMemTableJOBJobAssign.FindKey([1,FTempJobID]);
  if FDMemTableJOBJobAssign.FieldByName('ROLLFORMERID').AsInteger <= 0 then
  begin
    aJOBTransferToRF := Format('The selected file initally load From %s',['Dashboard'])+#10#13;
  end
  else
  begin
    aJOBTransferToRF := Format('The selected file initally load on %s',[GetRollFormerName(FDMemTableJOBJobAssign.FieldByName('ROLLFORMERID').AsInteger)])+#10#13;
  end;
  DMScotServer.GetEP2AssignInfo(FDMemTableEP2JobAssign, FTempJobID);
  FDMemTableEP2JobAssign.First;

  while not FDMemTableEP2JobAssign.Eof do
  begin
    aEP2Temp :='';
    if FDMemTableEP2JobAssign.FieldByName('ROLLFORMERID').AsInteger>0 then
    begin
      aEP2Temp := GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('ROLLFORMERID').AsInteger);
    end;
    if FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID1').AsInteger>0 then
    begin
      IF aEP2Temp<>'' THEN
        aEP2Temp := aEP2Temp +','+ GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID1').AsInteger)
      ELSE
        aEP2Temp := GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID1').AsInteger);
    end;
    if FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID2').AsInteger>0 then
    begin
      IF aEP2Temp<>'' THEN
        aEP2Temp := aEP2Temp +','+ GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID2').AsInteger)
      ELSE
        aEP2Temp := GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID2').AsInteger);
    end;
    if FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID3').AsInteger>0 then
    begin
      IF aEP2Temp<>'' THEN
        aEP2Temp := aEP2Temp +','+ GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID3').AsInteger)
      ELSE
        aEP2Temp := GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID3').AsInteger);
    end;
    if FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID4').AsInteger>0 then
    begin
      IF aEP2Temp<>'' THEN
        aEP2Temp := aEP2Temp +','+ GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID4').AsInteger)
      ELSE
        aEP2Temp := GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID4').AsInteger);
    end;
    if FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID5').AsInteger>0 then
    begin
      IF aEP2Temp<>'' THEN
        aEP2Temp := aEP2Temp +','+ GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID5').AsInteger)
      ELSE
        aEP2Temp := GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID5').AsInteger);
    end;
    if FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID6').AsInteger>0 then
    begin
      IF aEP2Temp<>'' THEN
        aEP2Temp := aEP2Temp +','+ GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID6').AsInteger)
      ELSE
        aEP2Temp := GetRollFormerName(FDMemTableEP2JobAssign.FieldByName('TRANSFERTORFID6').AsInteger);
    end;
    aEP2TransferToRF := aEP2TransferToRF + Format('The EP2 File %d has been transferred to %s'+#10#13,[FDMemTableEP2JobAssign.FieldByName('EP2FILEID').AsInteger, aEP2Temp]);
    FDMemTableEP2JobAssign.Next;
  end;
  result := aJOBTransferToRF + aEP2TransferToRF;
end;

function  TDMDesignJob.GetItemProducedWarning    : String;
begin
  result := '';
  IF (FDMemTableFramePercentage.AsInteger >99) then
  begin
    result := FDMemTableFrameFRAMENAME.AsString + ' produced on '+ GetRollFormerName(FDMemTableItemProductionROLLFORMERID.AsInteger);
    Exit;
  end;
  FDMemTableItemProduction.First;
  while not FDMemTableItemProduction.Eof do
  begin
    result := result + Format(' %d %s '#10#13,
                              [FDMemTableItemProductionSERIALNUMBER.AsInteger,
                               FDMemTableItemProductionITEMNAME.AsString]);
    FDMemTableItemProduction.Next;
  end;
  if result<>'' then
    result := result + ' of '+FDMemTableItemProductionTRUSSNAME.AsString + ' produced on '+ GetRollFormerName(FDMemTableItemProductionROLLFORMERID.AsInteger);
end;


function  TDMDesignJob.TheJobIsAlreadyLoaded(AFilePath : String) : Integer;
begin
  result := 0;
  Delete(AFilePath, 1, LastDelimiter('\', AFilePath));
  FTempJobID := DMScotServer.TheJobAlreadyLoaded(AFilePath);
  result := FTempJobID;
  if (FTempJobID>0) then
  begin
    FTempDesignName := AFilePath;
  end;
end;

function  TDMDesignJob.GetRollFormerName(aRFID : Integer) : String;
begin
  if FDMemTableRollFormer.Locate('RollFormerID',aRFID,[]) then
    Result:= FDMemTableRollFormer.FieldByName('NAME').AsString//+'('+IntToStr(aRFID)+')'
  else
    Result:= 'Not Assigned';
end;

procedure TDMDesignJob.GetItemProduction;
begin
  DMScotServer.GetItemProduction(0,1,StartTime, EndTime, FDMemTableItemProduction);
end;

procedure TDMDesignJob.GetItemProductionROLLFORMERID;
begin
  DMScotServer.GetItemProductionROLLFORMERID(0,1,StartTime, EndTime, FDMemTableROLLFORMERIDItemProduction);
end;

procedure TDMDesignJob.GetFrameEntity;
begin
  DMScotServer.GetFrameEntity(0,1,StartTime, EndTime, FDMemTableFrameEntity);
end;

procedure TDMDesignJob.GetFrame;
begin
  DMScotServer.GetFrame(1,StartTime, EndTime, FDMemTableFrame);
end;

procedure TDMDesignJob.GetEP2FILE;
begin
  DMScotServer.GetEP2FileWithoutBlob(0, 1, EndTime-300, EndTime, FDMemTableEP2FILE);
end;

procedure TDMDesignJob.GetJOB;
begin
  DMScotServer.GetJOB(0, 1, EndTime-300, EndTime, FDMemTableJOB);
end;

procedure TDMDesignJob.GetJOBTransfer;
begin
  DMScotServer.GetJobTRANSFER(0, 1, EndTime-300, EndTime, FDMemTableJOBTransfer);
end;

procedure TDMDesignJob.GetJOBDetails;
begin
  DMScotServer.GetJOBDETAIL(0,1,StartTime, EndTime, FDMemTableJOBDETAIL);
end;

procedure TDMDesignJob.GetRFDateInfo;
begin
  DMScotServer.GetRFDateInfo(0, 1, StartTime, EndTime, FDMemTableRFDateInfo);
end;

procedure TDMDesignJob.GetJobTotalLENGTH;
begin
  DMScotServer.GetJobTotalLENGTH(FDMemTableJobTotalLENGTH);
end;

procedure TDMDesignJob.GetEP2TotalLENGTH;
begin
  DMScotServer.GetEP2TotalLENGTH(FDMemTableEP2TotalLENGTH);
end;

procedure TDMDesignJob.GetFrameTotalLENGTH;
begin
  DMScotServer.GetFrameTotalLENGTH(FDMemTableFrameTotalLENGTH);
end;

procedure TDMDesignJob.GetJobFinishedLENGTH;
begin
  DMScotServer.GetJobFinishedLENGTH(FDMemTableJobFinishedLENGTH);
end;

procedure TDMDesignJob.GetEP2FinishedLENGTH;
begin
  DMScotServer.GetEP2FinishedLENGTH(FDMemTableEP2FinishedLENGTH);
end;

procedure TDMDesignJob.GetFrameFinishedLENGTH;
begin
  DMScotServer.GetFrameFinishedLENGTH(FDMemTableFrameFinishedLENGTH);
end;

procedure TDMDesignJob.GetROLLFORMER;
begin
  FRollFormerStrings.Clear;
  DMScotServer.GetRollFormer(0, 1, 0, Now, FDMemTableRollFormer);
  while not FDMemTableRollFormer.Eof do
  begin
    FRollFormerStrings.Add(FDMemTableRollFormer.FieldByName('Name').AsString );
    FDMemTableRollFormer.Next;
  end;
end;

procedure TDMDesignJob.DoTransfer;
begin
  DoTransfer(FDMemTableJOBROLLFORMERID.AsInteger, ScotRFRollFormerID, ttJob);
end;

procedure TDMDesignJob.DoTransfer(aFrom : Integer; aTo :Integer; aTransferType : TTransferType );
begin
  case aTransferType of
    ttJob:       begin
                   FDMemTableJOB.Edit;
                   IF FDMemTableJOBTRANSFERTORFID1.AsInteger = 0 THEN
                     FDMemTableJOBTRANSFERTORFID1.AsInteger := aTo
                   ELSE
                   IF FDMemTableJOBTRANSFERTORFID2.AsInteger = 0 THEN
                     FDMemTableJOBTRANSFERTORFID2.AsInteger := aTo
                   ELSE
                   IF FDMemTableJOBTRANSFERTORFID3.AsInteger = 0 THEN
                     FDMemTableJOBTRANSFERTORFID3.AsInteger := aTo
                   ELSE
                   IF FDMemTableJOBTRANSFERTORFID4.AsInteger = 0 THEN
                     FDMemTableJOBTRANSFERTORFID4.AsInteger := aTo
                   ELSE
                   IF FDMemTableJOBTRANSFERTORFID5.AsInteger = 0 THEN
                     FDMemTableJOBTRANSFERTORFID5.AsInteger := aTo
                   ELSE
                   IF FDMemTableJOBTRANSFERTORFID6.AsInteger = 0 THEN
                     FDMemTableJOBTRANSFERTORFID6.AsInteger := aTo;
                   ApplyUpdates(aJOB, FDMemTableJOB);
                 end;
    ttEP2TXT:    begin
                   FDMemTableEP2FILE.Edit;
                   IF FDMemTableEP2FILETRANSFERTORFID1.AsInteger = 0 THEN
                     FDMemTableEP2FILETRANSFERTORFID1.AsInteger := aTo
                   ELSE
                   IF FDMemTableEP2FILETRANSFERTORFID2.AsInteger = 0 THEN
                     FDMemTableEP2FILETRANSFERTORFID2.AsInteger := aTo
                   ELSE
                   IF FDMemTableEP2FILETRANSFERTORFID3.AsInteger = 0 THEN
                     FDMemTableEP2FILETRANSFERTORFID3.AsInteger := aTo
                   ELSE
                   IF FDMemTableEP2FILETRANSFERTORFID4.AsInteger = 0 THEN
                     FDMemTableEP2FILETRANSFERTORFID4.AsInteger := aTo
                   ELSE
                   IF FDMemTableEP2FILETRANSFERTORFID5.AsInteger = 0 THEN
                     FDMemTableEP2FILETRANSFERTORFID5.AsInteger := aTo
                   ELSE
                   IF FDMemTableEP2FILETRANSFERTORFID6.AsInteger = 0 THEN
                     FDMemTableEP2FILETRANSFERTORFID6.AsInteger := aTo;
                   ApplyUpdates(aEP2FILE, FDMemTableEP2FILE);
                 end;
    ttFrame:     begin
                   FDMemTableFrame.Edit;
                   IF FDMemTableFrameTRANSFERTORFID1.AsInteger = 0 THEN
                     FDMemTableFrameTRANSFERTORFID1.AsInteger := aTo
                   ELSE
                   IF FDMemTableFrameTRANSFERTORFID2.AsInteger = 0 THEN
                     FDMemTableFrameTRANSFERTORFID2.AsInteger := aTo
                   ELSE
                   IF FDMemTableFrameTRANSFERTORFID3.AsInteger = 0 THEN
                     FDMemTableFrameTRANSFERTORFID3.AsInteger := aTo
                   ELSE
                   IF FDMemTableFrameTRANSFERTORFID4.AsInteger = 0 THEN
                     FDMemTableFrameTRANSFERTORFID4.AsInteger := aTo
                   ELSE
                   IF FDMemTableFrameTRANSFERTORFID5.AsInteger = 0 THEN
                     FDMemTableFrameTRANSFERTORFID5.AsInteger := aTo
                   ELSE
                   IF FDMemTableFrameTRANSFERTORFID6.AsInteger = 0 THEN
                     FDMemTableFrameTRANSFERTORFID6.AsInteger := aTo;
                   ApplyUpdates(aFRAME, FDMemTableFrame);
                 end;
    ttFrameItem: begin
                 end;
  end;
end;

procedure TDMDesignJob.DoAssignTo(aAssignTo :Integer );
begin
  FDMemTableEP2FILE.Edit;
  FDMemTableEP2FILEROLLFORMERID.AsInteger := aAssignTo;
  ApplyUpdates(aEP2FILE, FDMemTableEP2FILE);
end;

procedure TDMDesignJob.DeleteAJob(aJobID : Integer; aJobName : String);
var
  SelectedButton : Integer;
begin
  SelectedButton := messagedlg( Format('Remove %s',[aJobName ])
                              , mtCustom, [mbYes,mbNo], 0);   //yes-6 no-7
  if SelectedButton <> 6 then
    exit;
  DMScotServer.DeleteAJob(aJobID);
end;

end.
