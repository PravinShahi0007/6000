object DMLocalDB: TDMLocalDB
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 631
  Width = 1482
  object FDConnToDB: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'password=masterkey'
      'Database=C:\ScotRFProductionOutput\Bin\Panel\SCSDATA.FDB')
    LoginPrompt = False
    Left = 776
    Top = 24
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 968
    Top = 24
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 1072
    Top = 24
  end
  object FDTableAdapterRollFormer: TFDTableAdapter
    SelectCommand = FDCommandRollFormer
    Left = 72
    Top = 8
  end
  object FDCommandRollFormer: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 208
    Top = 8
  end
  object FDTableAdapterRFDATEINFO: TFDTableAdapter
    SelectCommand = FDCommandRFDATEINFO
    Left = 72
    Top = 64
  end
  object FDCommandRFDATEINFO: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 216
    Top = 64
  end
  object FDTableAdapterAUDIT: TFDTableAdapter
    SelectCommand = FDCommandAUDIT
    Left = 72
    Top = 120
  end
  object FDCommandAUDIT: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 216
    Top = 120
  end
  object FDTableAdapterRFOPERATION: TFDTableAdapter
    SelectCommand = FDCommandRFOPERATION
    Left = 72
    Top = 176
  end
  object FDCommandRFOPERATION: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 216
    Top = 176
  end
  object FDTableAdapterEP2FileWithoutBlob: TFDTableAdapter
    SelectCommand = FDCommandEP2FileWithoutBlob
    Left = 408
    Top = 88
  end
  object FDCommandEP2FileWithoutBlob: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 600
    Top = 88
  end
  object FDTableAdapterEP2FileJobID: TFDTableAdapter
    SelectCommand = FDCommandEP2FileJobID
    Left = 408
    Top = 24
  end
  object FDCommandEP2FileJobID: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 600
    Top = 24
  end
  object FDTableAdapterEP2File: TFDTableAdapter
    SelectCommand = FDCommandEP2File
    Left = 72
    Top = 512
  end
  object FDCommandEP2File: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 176
    Top = 512
  end
  object FDTableAdapterEP2FileBLOB: TFDTableAdapter
    SelectCommand = FDCommandEP2FileBLOB
    Left = 72
    Top = 440
  end
  object FDCommandEP2FileBLOB: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 216
    Top = 440
  end
  object FDTableAdapterJOBDETAIL: TFDTableAdapter
    SelectCommand = FDCommandJOBDETAIL
    Left = 72
    Top = 376
  end
  object FDCommandJOBDETAIL: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 216
    Top = 376
  end
  object FDTableAdapterJOBTRANSFER: TFDTableAdapter
    SelectCommand = FDCommandJOBTRANSFER
    Left = 72
    Top = 304
  end
  object FDCommandJOBTRANSFER: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 216
    Top = 304
  end
  object FDTableAdapterJOB: TFDTableAdapter
    SelectCommand = FDCommandJOB
    Left = 72
    Top = 240
  end
  object FDCommandJOB: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 208
    Top = 240
  end
  object FDTableAdapterITEMPRODUCTION: TFDTableAdapter
    SelectCommand = FDCommandITEMPRODUCTION
    Left = 408
    Top = 400
  end
  object FDCommandITEMPRODUCTION: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 608
    Top = 408
  end
  object FDTableAdapterFRAMEENTITYFrameID: TFDTableAdapter
    SelectCommand = FDCommandFRAMEENTITYFrameID
    Left = 408
    Top = 336
  end
  object FDCommandFRAMEENTITYFrameID: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 608
    Top = 336
  end
  object FDTableAdapterFRAMEENTITY: TFDTableAdapter
    UpdateTableName = 'FRAMEENTITY'
    DatSTableName = 'FDMemTableFRAMEENTITY'
    SelectCommand = FDCommandFRAMEENTITY
    Left = 408
    Top = 272
  end
  object FDCommandFRAMEENTITY: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 608
    Top = 280
  end
  object FDTableAdapterFRAMEEP2FILEID: TFDTableAdapter
    SelectCommand = FDCommandFRAMEEP2FILEID
    Left = 408
    Top = 216
  end
  object FDCommandFRAMEEP2FILEID: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 608
    Top = 216
  end
  object FDTableAdapterFRAME: TFDTableAdapter
    UpdateTableName = 'FRAME'
    DatSTableName = 'FDMemTableFRAME'
    SelectCommand = FDCommandFRAME
    Left = 408
    Top = 152
  end
  object FDCommandFRAME: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 608
    Top = 144
  end
  object FDTableAdapterItemProductionFrameID: TFDTableAdapter
    SelectCommand = FDCommandItemProductionFrameID
    Left = 408
    Top = 464
  end
  object FDCommandItemProductionFrameID: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 616
    Top = 464
  end
  object FDTableAdapterItemProductionROLLFORMERID: TFDTableAdapter
    SelectCommand = FDCommandItemProductionROLLFORMERID
    Left = 408
    Top = 528
  end
  object FDCommandItemProductionROLLFORMERID: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 616
    Top = 528
  end
  object SQLConnToDB: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=C:\ProgramData\ScotServer\SCSDATA.FDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    Left = 864
    Top = 24
  end
  object AdapterJobTotalLength: TFDTableAdapter
    SelectCommand = FDCmdJobTotalLength
    Left = 848
    Top = 128
  end
  object FDCmdJobTotalLength: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 944
    Top = 112
  end
  object AdapterJobFinishedLength: TFDTableAdapter
    SelectCommand = FDCmdJobFinishedLength
    Left = 848
    Top = 192
  end
  object FDCmdJobFinishedLength: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 944
    Top = 176
  end
  object AdapterEP2TotalLength: TFDTableAdapter
    SelectCommand = FDCmdEP2TotalLength
    Left = 856
    Top = 264
  end
  object FDCmdEP2TotalLength: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 944
    Top = 248
  end
  object AdapterEP2FinishedLength: TFDTableAdapter
    SelectCommand = FDCmdEP2FinishedLength
    Left = 856
    Top = 336
  end
  object FDCmdEP2FinishedLength: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 944
    Top = 320
  end
  object AdapterFrameTotalLength: TFDTableAdapter
    SelectCommand = FDCmdFrameTotalLength
    Left = 856
    Top = 408
  end
  object FDCmdFrameTotalLength: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 944
    Top = 392
  end
  object AdapterFrameFinishedLength: TFDTableAdapter
    SelectCommand = FDCmdFrameFinishedLength
    Left = 856
    Top = 480
  end
  object FDCmdFrameFinishedLength: TFDCommand
    Connection = FDConnToDB
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    CommandText.Strings = (
      '')
    Left = 952
    Top = 464
  end
  object FDTableAdapterJOBEX: TFDTableAdapter
    SelectCommand = FDCommandJOB
    Left = 120
    Top = 240
  end
  object FDTableAdapterEP2FileEX: TFDTableAdapter
    SelectCommand = FDCommandEP2File
    Left = 72
    Top = 504
  end
  object FDTableAdapterFRAMEEX: TFDTableAdapter
    UpdateTableName = 'FRAME'
    DatSTableName = 'FDMemTableFRAME'
    SelectCommand = FDCommandFRAME
    Left = 448
    Top = 152
  end
  object FDTableAdapterFRAMEENTITYEX: TFDTableAdapter
    UpdateTableName = 'FRAMEENTITY'
    DatSTableName = 'FDMemTableFRAMEENTITY'
    SelectCommand = FDCommandFRAMEENTITY
    Left = 424
    Top = 272
  end
  object FDTableAdapterITEMPRODUCTIONEX: TFDTableAdapter
    SelectCommand = FDCommandITEMPRODUCTION
    Left = 432
    Top = 400
  end
  object FDTableAdapterJOBDETAILEX: TFDTableAdapter
    SelectCommand = FDCommandJOBDETAIL
    Left = 80
    Top = 376
  end
  object FDTableAdapterRFDATEINFOEX: TFDTableAdapter
    SelectCommand = FDCommandRFDATEINFO
    Left = 72
    Top = 64
  end
  object FDTableAdapterRollFormerEX: TFDTableAdapter
    SelectCommand = FDCommandRollFormer
    Left = 80
    Top = 8
  end
  object FDTableAdapterFORRF: TFDTableAdapter
    UpdateTableName = 'FRAME'
    DatSTableName = 'FDMemTableFRAME'
    SelectCommand = FDCommandFRAME
    Left = 488
    Top = 152
  end
  object FDTableAdapterJOBTEMP: TFDTableAdapter
    SelectCommand = FDCommandJOB
    Left = 160
    Top = 240
  end
  object FDQueryTEMP: TFDQuery
    Connection = FDConnToDB
    Left = 1064
    Top = 96
  end
end
