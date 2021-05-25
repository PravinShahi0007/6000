object DMDesignJob: TDMDesignJob
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 626
  Width = 1051
  object DataSourceJob: TDataSource
    DataSet = FDMemTableJOB
    Left = 496
    Top = 344
  end
  object DataSourceFrame: TDataSource
    DataSet = FDMemTableFrame
    Left = 496
    Top = 168
  end
  object DataSourceFrameEntity: TDataSource
    DataSet = FDMemTableFrameEntity
    Left = 496
    Top = 96
  end
  object DataSourceItemProduction: TDataSource
    DataSet = FDMemTableItemProduction
    Left = 496
    Top = 24
  end
  object DataSourceEP2File: TDataSource
    DataSet = FDMemTableEP2FILE
    Left = 496
    Top = 256
  end
  object FDMemTableItemProduction: TFDMemTable
    IndexFieldNames = 'FRAMEID;ID'
    AggregatesActive = True
    MasterSource = DataSourceFrame
    MasterFields = 'FRAMEID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 696
    Top = 16
    object FDMemTableItemProductionITEMPRODUCTIONID: TIntegerField
      FieldName = 'ITEMPRODUCTIONID'
      Required = True
    end
    object FDMemTableItemProductionTRUSSNAME: TWideStringField
      FieldName = 'TRUSSNAME'
    end
    object FDMemTableItemProductionITEMNAME: TWideStringField
      FieldName = 'ITEMNAME'
    end
    object FDMemTableItemProductionITEMLENGTH: TFloatField
      FieldName = 'ITEMLENGTH'
      Required = True
      DisplayFormat = '0.##'
    end
    object FDMemTableItemProductionISLAST: TSmallintField
      FieldName = 'ISLAST'
      Required = True
    end
    object FDMemTableItemProductionSERIALNUMBER: TIntegerField
      FieldName = 'SERIALNUMBER'
      Required = True
    end
    object FDMemTableItemProductionISBOXWEB: TSmallintField
      FieldName = 'ISBOXWEB'
      Required = True
    end
    object FDMemTableItemProductionISBOXWEBDOUBLE: TSmallintField
      FieldName = 'ISBOXWEBDOUBLE'
      Required = True
    end
    object FDMemTableItemProductionSCREWCOUNT: TSmallintField
      FieldName = 'SCREWCOUNT'
    end
    object FDMemTableItemProductionSPACERCOUNT: TSmallintField
      FieldName = 'SPACERCOUNT'
    end
    object FDMemTableItemProductionSTATUSID: TSmallintField
      FieldName = 'STATUSID'
      Required = True
    end
    object FDMemTableItemProductionFRAMEID: TIntegerField
      FieldName = 'FRAMEID'
      Required = True
    end
    object FDMemTableItemProductionSITEID: TIntegerField
      FieldName = 'SITEID'
      Required = True
    end
    object FDMemTableItemProductionROLLFORMERID: TIntegerField
      FieldName = 'ROLLFORMERID'
      Required = True
      OnGetText = FDMemTableFrameROLLFORMERIDGetText
    end
    object FDMemTableItemProductionADDEDON: TSQLTimeStampField
      FieldName = 'ADDEDON'
      Required = True
    end
    object FDMemTableItemProductionCARDNUMBER: TWideStringField
      FieldName = 'CARDNUMBER'
    end
    object FDMemTableItemProductionCOPYID: TSmallintField
      FieldName = 'COPYID'
    end
    object FDMemTableItemProductionJOBID: TIntegerField
      FieldName = 'JOBID'
    end
    object FDMemTableItemProductionLENGTHTOTAL: TAggregateField
      FieldName = 'LENGTHTOTAL'
      Active = True
      DisplayName = ''
      DisplayFormat = '0.## Meters'
      Expression = 'SUM(ITEMLENGTH)/1000'
    end
  end
  object FDMemTableFrameEntity: TFDMemTable
    IndexFieldNames = 'SITEID;FRAMEID;ID'
    AggregatesActive = True
    MasterSource = DataSourceFrame
    MasterFields = 'SITEID;FRAMEID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 696
    Top = 88
    object FDMemTableFrameEntityFRAMEENTITYID: TIntegerField
      FieldName = 'FRAMEENTITYID'
      Required = True
    end
    object FDMemTableFrameEntityITEMNAME: TWideStringField
      FieldName = 'ITEMNAME'
    end
    object FDMemTableFrameEntityFRAMEID: TIntegerField
      FieldName = 'FRAMEID'
      Required = True
    end
    object FDMemTableFrameEntityFRAMENAME: TWideStringField
      FieldName = 'FRAMENAME'
    end
    object FDMemTableFrameEntityFRAMETYPE: TWideStringField
      FieldName = 'FRAMETYPE'
    end
    object FDMemTableFrameEntityJOBID: TIntegerField
      FieldName = 'JOBID'
      Required = True
    end
    object FDMemTableFrameEntityID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object FDMemTableFrameEntityPOINT1X: TFloatField
      FieldName = 'POINT1X'
      Required = True
      DisplayFormat = '#.00'
    end
    object FDMemTableFrameEntityPOINT1Y: TFloatField
      FieldName = 'POINT1Y'
      Required = True
      DisplayFormat = '#.00'
    end
    object FDMemTableFrameEntityPOINT2X: TFloatField
      FieldName = 'POINT2X'
      Required = True
      DisplayFormat = '#.00'
    end
    object FDMemTableFrameEntityPOINT2Y: TFloatField
      FieldName = 'POINT2Y'
      Required = True
      DisplayFormat = '#.00'
    end
    object FDMemTableFrameEntityPOINT3X: TFloatField
      FieldName = 'POINT3X'
      Required = True
      DisplayFormat = '#.00'
    end
    object FDMemTableFrameEntityPOINT3Y: TFloatField
      FieldName = 'POINT3Y'
      Required = True
      DisplayFormat = '#.00'
    end
    object FDMemTableFrameEntityPOINT4X: TFloatField
      FieldName = 'POINT4X'
      Required = True
      DisplayFormat = '#.00'
    end
    object FDMemTableFrameEntityPOINT4Y: TFloatField
      FieldName = 'POINT4Y'
      Required = True
      DisplayFormat = '#.00'
    end
    object FDMemTableFrameEntityLENGTH: TFloatField
      FieldName = 'LENGTH'
      Required = True
      DisplayFormat = '0.##'
    end
    object FDMemTableFrameEntityWEB: TFloatField
      FieldName = 'WEB'
      Required = True
    end
    object FDMemTableFrameEntityCOL: TIntegerField
      FieldName = 'COL'
      Required = True
    end
    object FDMemTableFrameEntityOPCOUNT: TIntegerField
      FieldName = 'OPCOUNT'
      Required = True
    end
    object FDMemTableFrameEntityORIENTATION: TSmallintField
      FieldName = 'ORIENTATION'
      Required = True
    end
    object FDMemTableFrameEntityNONRF: TSmallintField
      FieldName = 'NONRF'
      Required = True
    end
    object FDMemTableFrameEntityISFACINGITEM: TSmallintField
      FieldName = 'ISFACINGITEM'
      Required = True
    end
    object FDMemTableFrameEntitySTATUSID: TSmallintField
      FieldName = 'STATUSID'
      Required = True
    end
    object FDMemTableFrameEntitySITEID: TIntegerField
      FieldName = 'SITEID'
      Required = True
    end
    object FDMemTableFrameEntityADDEDON: TSQLTimeStampField
      FieldName = 'ADDEDON'
      Required = True
    end
    object FDMemTableFrameEntityRFTYPEID: TSmallintField
      FieldName = 'RFTYPEID'
      Required = True
    end
    object FDMemTableFrameEntityFRAMELENGTH: TAggregateField
      FieldName = 'FRAMELENGTH'
      Active = True
      DisplayName = ''
      DisplayFormat = '#.00'
      Expression = 'SUM(LENGTH)/1000'
    end
  end
  object FDMemTableFrame: TFDMemTable
    OnCalcFields = FDMemTableFrameCalcFields
    CachedUpdates = True
    IndexFieldNames = 'EP2FILEID;FRAMEID'
    MasterSource = DataSourceEP2File
    MasterFields = 'EP2FILEID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 696
    Top = 167
    object FDMemTableFrameFRAMEID: TIntegerField
      FieldName = 'FRAMEID'
      Required = True
    end
    object FDMemTableFrameFRAMENAME: TWideStringField
      FieldName = 'FRAMENAME'
    end
    object FDMemTableFrameEP2FILEID: TIntegerField
      FieldName = 'EP2FILEID'
      Required = True
    end
    object FDMemTableFrameJOBID: TIntegerField
      FieldName = 'JOBID'
      Required = True
    end
    object FDMemTableFrameMINHOLEDISTANCE: TFloatField
      FieldName = 'MINHOLEDISTANCE'
      Required = True
    end
    object FDMemTableFramePROFILEHEIGHT: TFloatField
      FieldName = 'PROFILEHEIGHT'
      Required = True
    end
    object FDMemTableFramePRECAMBER: TFloatField
      FieldName = 'PRECAMBER'
      Required = True
    end
    object FDMemTableFrameITEMCOUNT: TSmallintField
      FieldName = 'ITEMCOUNT'
      Required = True
    end
    object FDMemTableFramePRODUCEDFRAMES: TSmallintField
      FieldName = 'PRODUCEDFRAMES'
      Required = True
    end
    object FDMemTableFrameNUMBEROFFRAMES: TSmallintField
      FieldName = 'NUMBEROFFRAMES'
      Required = True
    end
    object FDMemTableFramePLATEYMIN: TFloatField
      FieldName = 'PLATEYMIN'
      Required = True
    end
    object FDMemTableFramePLATEYMAX: TFloatField
      FieldName = 'PLATEYMAX'
      Required = True
    end
    object FDMemTableFrameXMIN: TFloatField
      FieldName = 'XMIN'
      Required = True
    end
    object FDMemTableFrameXMAX: TFloatField
      FieldName = 'XMAX'
      Required = True
    end
    object FDMemTableFrameYMIN: TFloatField
      FieldName = 'YMIN'
      Required = True
    end
    object FDMemTableFrameYMAX: TFloatField
      FieldName = 'YMAX'
      Required = True
    end
    object FDMemTableFrameSPACERS: TSmallintField
      FieldName = 'SPACERS'
      Required = True
    end
    object FDMemTableFrameTEKSCREWS: TSmallintField
      FieldName = 'TEKSCREWS'
      Required = True
    end
    object FDMemTableFrameCONNECTIONCOUNT: TSmallintField
      FieldName = 'CONNECTIONCOUNT'
      Required = True
    end
    object FDMemTableFrameCONNECTORS: TSmallintField
      FieldName = 'CONNECTORS'
      Required = True
    end
    object FDMemTableFrameEP2FILE: TWideStringField
      FieldName = 'EP2FILE'
      Size = 250
    end
    object FDMemTableFrameSTATUSID: TSmallintField
      FieldName = 'STATUSID'
      Required = True
    end
    object FDMemTableFrameSITEID: TSmallintField
      FieldName = 'SITEID'
      Required = True
    end
    object FDMemTableFrameADDEDON: TSQLTimeStampField
      FieldName = 'ADDEDON'
      Required = True
    end
    object FDMemTableFrameRIVETS: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'RIVETS'
      Calculated = True
    end
    object FDMemTableFrameLENGTH: TFloatField
      FieldKind = fkLookup
      FieldName = 'LENGTH'
      LookupDataSet = FDMemTableFrameEntity
      LookupKeyFields = 'FRAMEID'
      LookupResultField = 'FRAMELENGTH'
      KeyFields = 'FRAMEID'
      Lookup = True
    end
    object FDMemTableFrameRFTYPEID: TSmallintField
      FieldName = 'RFTYPEID'
      Required = True
    end
    object FDMemTableFrameROLLFORMERID: TSmallintField
      FieldName = 'ROLLFORMERID'
      OnGetText = FDMemTableFrameROLLFORMERIDGetText
    end
    object FDMemTableFramePercentage: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Percentage'
      DisplayFormat = '0.00%'
      Calculated = True
    end
    object FDMemTableFrameFinishedLength2: TFloatField
      FieldKind = fkLookup
      FieldName = 'FinishedLength'
      LookupDataSet = FDMemTableFrameFinishedLength
      LookupKeyFields = 'FRAMEID'
      LookupResultField = 'ITEMLENGTH'
      KeyFields = 'FRAMEID'
      Lookup = True
    end
    object FDMemTableFrameTOTALLENGTH2: TFloatField
      FieldKind = fkLookup
      FieldName = 'TOTALLENGTH'
      LookupDataSet = FDMemTableFrameTotalLength
      LookupKeyFields = 'FRAMEID'
      LookupResultField = 'LENGTH'
      KeyFields = 'FRAMEID'
      Lookup = True
    end
    object FDMemTableFrameTRANSFERTORFID1: TSmallintField
      FieldName = 'TRANSFERTORFID1'
    end
    object FDMemTableFrameTRANSFERTORFID2: TSmallintField
      FieldName = 'TRANSFERTORFID2'
    end
    object FDMemTableFrameTRANSFERTORFID3: TSmallintField
      FieldName = 'TRANSFERTORFID3'
    end
    object FDMemTableFrameTRANSFERTORFID4: TSmallintField
      FieldName = 'TRANSFERTORFID4'
    end
    object FDMemTableFrameTRANSFERTORFID5: TSmallintField
      FieldName = 'TRANSFERTORFID5'
    end
    object FDMemTableFrameTRANSFERTORFID6: TSmallintField
      FieldName = 'TRANSFERTORFID6'
    end
  end
  object FDMemTableEP2FILE: TFDMemTable
    OnCalcFields = FDMemTableEP2FILECalcFields
    OnFilterRecord = FDMemTableEP2FILEFilterRecord
    CachedUpdates = True
    IndexFieldNames = 'SITEID;JOBID;EP2FILEID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 704
    Top = 248
    object FDMemTableEP2FILEEP2FILEID: TIntegerField
      FieldName = 'EP2FILEID'
    end
    object FDMemTableEP2FILERFTYPEID: TSmallintField
      FieldName = 'RFTYPEID'
    end
    object FDMemTableEP2FILEEP2FILE: TWideStringField
      DisplayWidth = 150
      FieldName = 'EP2FILE'
      Size = 150
    end
    object FDMemTableEP2FILESTATUSID: TSmallintField
      FieldName = 'STATUSID'
    end
    object FDMemTableEP2FILEJOBID: TIntegerField
      FieldName = 'JOBID'
    end
    object FDMemTableEP2FILEROLLFORMERID: TIntegerField
      FieldName = 'ROLLFORMERID'
      OnGetText = FDMemTableFrameROLLFORMERIDGetText
    end
    object FDMemTableEP2FILESITEID: TSmallintField
      FieldName = 'SITEID'
    end
    object FDMemTableEP2FILEADDEDON: TSQLTimeStampField
      FieldName = 'ADDEDON'
    end
    object FDMemTableEP2FILEPercentage: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Percentage'
      DisplayFormat = '0.00%'
      Calculated = True
    end
    object FDMemTableEP2FILELENGTH: TFloatField
      FieldKind = fkLookup
      FieldName = 'LENGTH'
      LookupDataSet = FDMemTableEP2TotalLength
      LookupKeyFields = 'EP2FILEID'
      LookupResultField = 'LENGTH'
      KeyFields = 'EP2FILEID'
      Lookup = True
    end
    object FDMemTableEP2FILEFINISHEDLENGTH: TFloatField
      FieldKind = fkLookup
      FieldName = 'FINISHEDLENGTH'
      LookupDataSet = FDMemTableEP2FinishedLength
      LookupKeyFields = 'EP2FILEID'
      LookupResultField = 'ITEMLENGTH'
      KeyFields = 'EP2FILEID'
      Lookup = True
    end
    object FDMemTableEP2FILETotalCount: TIntegerField
      FieldKind = fkLookup
      FieldName = 'TotalCount'
      LookupDataSet = FDMemTableEP2TotalLength
      LookupKeyFields = 'EP2FILEID'
      LookupResultField = 'TotalCount'
      KeyFields = 'EP2FILEID'
      Lookup = True
    end
    object FDMemTableEP2FILEFinishCount: TIntegerField
      FieldKind = fkLookup
      FieldName = 'FinishCount'
      LookupDataSet = FDMemTableEP2FinishedLength
      LookupKeyFields = 'EP2FILEID'
      LookupResultField = 'FinishCount'
      KeyFields = 'EP2FILEID'
      Lookup = True
    end
    object FDMemTableEP2FILECountDisplay: TStringField
      FieldKind = fkCalculated
      FieldName = 'CountDisplay'
      Calculated = True
    end
    object FDMemTableEP2FILETRANSFERTORFID1: TSmallintField
      FieldName = 'TRANSFERTORFID1'
      OnGetText = FDMemTableEP2FILETRANSFERTORFID1GetText
    end
    object FDMemTableEP2FILETRANSFERTORFID2: TSmallintField
      FieldName = 'TRANSFERTORFID2'
      OnGetText = FDMemTableEP2FILETRANSFERTORFID1GetText
    end
    object FDMemTableEP2FILETRANSFERTORFID3: TSmallintField
      FieldName = 'TRANSFERTORFID3'
      OnGetText = FDMemTableEP2FILETRANSFERTORFID1GetText
    end
    object FDMemTableEP2FILETRANSFERTORFID4: TSmallintField
      FieldName = 'TRANSFERTORFID4'
      OnGetText = FDMemTableEP2FILETRANSFERTORFID1GetText
    end
    object FDMemTableEP2FILETRANSFERTORFID5: TSmallintField
      FieldName = 'TRANSFERTORFID5'
      OnGetText = FDMemTableEP2FILETRANSFERTORFID1GetText
    end
    object FDMemTableEP2FILETRANSFERTORFID6: TSmallintField
      FieldName = 'TRANSFERTORFID6'
      OnGetText = FDMemTableEP2FILETRANSFERTORFID1GetText
    end
  end
  object FDMemTableJOB: TFDMemTable
    AfterScroll = FDMemTableJOBAfterScroll
    OnCalcFields = FDMemTableJOBCalcFields
    OnFilterRecord = FDMemTableJOBFilterRecord
    CachedUpdates = True
    IndexFieldNames = 'SITEID;JOBID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 704
    Top = 336
    object FDMemTableJOBROLLFORMERID: TSmallintField
      FieldName = 'ROLLFORMERID'
      OnGetText = FDMemTableFrameROLLFORMERIDGetText
    end
    object FDMemTableJOBDESIGN: TWideStringField
      DisplayWidth = 150
      FieldName = 'DESIGN'
      Size = 150
    end
    object FDMemTableJOBSITEID: TSmallintField
      FieldName = 'SITEID'
    end
    object FDMemTableJOBJOBID: TIntegerField
      FieldName = 'JOBID'
    end
    object FDMemTableJOBADDEDON: TSQLTimeStampField
      FieldName = 'ADDEDON'
      DisplayFormat = 'dd/mm'
    end
    object FDMemTableJOBFRAMECOPIES: TSmallintField
      FieldName = 'FRAMECOPIES'
    end
    object FDMemTableJOBSTEEL: TWideStringField
      FieldName = 'STEEL'
    end
    object FDMemTableJOBRFTYPEID: TSmallintField
      FieldName = 'RFTYPEID'
    end
    object FDMemTableJOBPercentage: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Percentage'
      DisplayFormat = '0.00%'
      Calculated = True
    end
    object FDMemTableJOBLENGTH: TFloatField
      FieldKind = fkLookup
      FieldName = 'LENGTH'
      LookupDataSet = FDMemTableJobTotalLength
      LookupKeyFields = 'JOBID'
      LookupResultField = 'LENGTH'
      KeyFields = 'JOBID'
      Lookup = True
    end
    object FDMemTableJOBFINISHEDLENGTH2: TFloatField
      FieldKind = fkLookup
      FieldName = 'FINISHEDLENGTH'
      LookupDataSet = FDMemTableJobFinishedLength
      LookupKeyFields = 'JOBID'
      LookupResultField = 'ITEMLENGTH'
      KeyFields = 'JOBID'
      Lookup = True
    end
    object FDMemTableJOBTotalCount: TIntegerField
      FieldKind = fkLookup
      FieldName = 'TotalCount'
      LookupDataSet = FDMemTableJobTotalLength
      LookupKeyFields = 'JOBID'
      LookupResultField = 'TotalCount'
      KeyFields = 'JOBID'
      Lookup = True
    end
    object FDMemTableJOBFinishCount: TIntegerField
      FieldKind = fkLookup
      FieldName = 'FinishCount'
      LookupDataSet = FDMemTableJobFinishedLength
      LookupKeyFields = 'JOBID'
      LookupResultField = 'FinishCount'
      KeyFields = 'JOBID'
      Lookup = True
    end
    object FDMemTableJOBCountDisplay: TStringField
      FieldKind = fkCalculated
      FieldName = 'CountDisplay'
      Calculated = True
    end
    object FDMemTableJOBTRANSFERTORFID1: TSmallintField
      FieldName = 'TRANSFERTORFID1'
      OnGetText = FDMemTableFrameROLLFORMERIDGetText
    end
    object FDMemTableJOBTRANSFERTORFID2: TSmallintField
      FieldName = 'TRANSFERTORFID2'
      OnGetText = FDMemTableFrameROLLFORMERIDGetText
    end
    object FDMemTableJOBTRANSFERTORFID3: TSmallintField
      FieldName = 'TRANSFERTORFID3'
      OnGetText = FDMemTableFrameROLLFORMERIDGetText
    end
    object FDMemTableJOBTRANSFERTORFID4: TSmallintField
      FieldName = 'TRANSFERTORFID4'
      OnGetText = FDMemTableFrameROLLFORMERIDGetText
    end
    object FDMemTableJOBTRANSFERTORFID5: TSmallintField
      FieldName = 'TRANSFERTORFID5'
      OnGetText = FDMemTableFrameROLLFORMERIDGetText
    end
    object FDMemTableJOBTRANSFERTORFID6: TSmallintField
      FieldName = 'TRANSFERTORFID6'
      OnGetText = FDMemTableFrameROLLFORMERIDGetText
    end
    object FDMemTableJOBFILEPATH: TWideStringField
      FieldName = 'FILEPATH'
      Size = 150
    end
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 224
    Top = 24
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 80
    Top = 24
  end
  object FDMemTableJOBDETAIL: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 920
    Top = 16
  end
  object FDMemTableRFDateInfo: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 920
    Top = 112
    object FDMemTableRFDateInfoRFDATEINFOID: TSmallintField
      FieldName = 'RFDATEINFOID'
    end
    object FDMemTableRFDateInfoRFINFODATE: TDateField
      FieldName = 'RFINFODATE'
    end
    object FDMemTableRFDateInfoROLLFORMERID: TSmallintField
      FieldName = 'ROLLFORMERID'
    end
    object FDMemTableRFDateInfoCARDNUMBER: TWideStringField
      FieldName = 'CARDNUMBER'
    end
    object FDMemTableRFDateInfoMETERS: TFloatField
      FieldName = 'METERS'
    end
    object FDMemTableRFDateInfoRUNSECONDS: TIntegerField
      FieldName = 'RUNSECONDS'
    end
    object FDMemTableRFDateInfoSITEID: TSmallintField
      FieldName = 'SITEID'
    end
  end
  object FDMemTableRollFormer: TFDMemTable
    IndexFieldNames = 'NAME'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 704
    Top = 432
  end
  object DataSourceRollFormer: TDataSource
    DataSet = FDMemTableRollFormer
    Left = 496
    Top = 440
  end
  object FDMemTableJobTotalLength: TFDMemTable
    IndexFieldNames = 'JOBID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 256
    object FDMemTableJobTotalLengthJOBID: TIntegerField
      FieldName = 'JOBID'
    end
    object FDMemTableJobTotalLengthLENGTH: TFloatField
      FieldName = 'LENGTH'
    end
    object FDMemTableJobTotalLengthTotalCount: TIntegerField
      FieldName = 'TotalCount'
    end
  end
  object FDMemTableEP2TotalLength: TFDMemTable
    IndexFieldNames = 'EP2FILEID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 344
    object FDMemTableEP2TotalLengthEP2FILEID: TIntegerField
      FieldName = 'EP2FILEID'
    end
    object FDMemTableEP2TotalLengthLENGTH: TFloatField
      FieldName = 'LENGTH'
    end
    object FDMemTableEP2TotalLengthTotalCount: TIntegerField
      FieldName = 'TotalCount'
    end
  end
  object FDMemTableFrameTotalLength: TFDMemTable
    IndexFieldNames = 'FRAMEID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 432
    object FDMemTableFrameTotalLengthFRAMEID: TIntegerField
      FieldName = 'FRAMEID'
    end
    object FDMemTableFrameTotalLengthLENGTH: TFloatField
      FieldName = 'LENGTH'
    end
  end
  object FDMemTableJobFinishedLength: TFDMemTable
    IndexFieldNames = 'JOBID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 280
    Top = 256
    object FDMemTableJobFinishedLengthJOBID: TIntegerField
      FieldName = 'JOBID'
    end
    object FDMemTableJobFinishedLengthITEMLENGTH: TFloatField
      FieldName = 'ITEMLENGTH'
    end
    object FDMemTableJobFinishedLengthFinishCount: TLargeintField
      FieldName = 'FinishCount'
    end
  end
  object FDMemTableEP2FinishedLength: TFDMemTable
    IndexFieldNames = 'EP2FILEID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 280
    Top = 336
    object FDMemTableEP2FinishedLengthEP2FILEID: TIntegerField
      FieldName = 'EP2FILEID'
    end
    object FDMemTableEP2FinishedLengthITEMLENGTH: TFloatField
      FieldName = 'ITEMLENGTH'
    end
    object FDMemTableEP2FinishedLengthFinishCount: TLargeintField
      FieldName = 'FinishCount'
    end
  end
  object FDMemTableFrameFinishedLength: TFDMemTable
    IndexFieldNames = 'FRAMEID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 280
    Top = 432
    object FDMemTableFrameFinishedLengthFRAMEID: TIntegerField
      FieldName = 'FRAMEID'
    end
    object FDMemTableFrameFinishedLengthITEMLENGTH: TFloatField
      FieldName = 'ITEMLENGTH'
    end
  end
  object FDMemTableROLLFORMERIDItemProduction: TFDMemTable
    OnCalcFields = FDMemTableROLLFORMERIDItemProductionCalcFields
    CachedUpdates = True
    IndexFieldNames = 'ROLLFORMERID'
    MasterSource = DataSourceRollFormer
    MasterFields = 'ROLLFORMERID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 944
    Top = 448
    object FDMemTableROLLFORMERIDItemProductionROLLFORMERID: TIntegerField
      FieldName = 'ROLLFORMERID'
    end
    object FDMemTableROLLFORMERIDItemProductionTOTALLENGTH: TFloatField
      FieldName = 'TOTALLENGTH'
      DisplayFormat = '0.##'
    end
    object FDMemTableROLLFORMERIDItemProductionPRODUCEDON: TStringField
      FieldName = 'PRODUCEDON'
    end
    object FDMemTableROLLFORMERIDItemProductionMeters: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Meters'
      DisplayFormat = '#.##'
      Calculated = True
    end
  end
  object FDMemTableJobTransfer: TFDMemTable
    CachedUpdates = True
    IndexFieldNames = 'JOBID;TOROLLFORMERID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 712
    Top = 520
  end
  object DataSourceDailyProduction: TDataSource
    DataSet = FDMemTableROLLFORMERIDItemProduction
    Left = 944
    Top = 376
  end
  object FDMemTableEP2JobAssign: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 856
    Top = 288
  end
  object FDMemTableJOBJobAssign: TFDMemTable
    IndexFieldNames = 'SITEID;JOBID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 856
    Top = 240
  end
end
