object DMRFStatus: TDMRFStatus
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 390
  Width = 609
  object DataSourceRFDateInfo: TDataSource
    DataSet = FDMemTableRFDateInfo
    Left = 216
    Top = 216
  end
  object DataSourceProductionByCard: TDataSource
    DataSet = FDMemTableProductionByCard
    Left = 216
    Top = 96
  end
  object DataSourceProductionByRF: TDataSource
    DataSet = FDMemTableProductionByRollFormer
    Left = 216
    Top = 24
  end
  object FDMemTableProductionByRollFormer: TFDMemTable
    OnCalcFields = FDMemTableProductionByRollFormerCalcFields
    IndexFieldNames = 'ROLLFORMERID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 416
    Top = 24
    object FDMemTableProductionByRollFormerROLLFORMERID: TIntegerField
      FieldName = 'ROLLFORMERID'
      Required = True
      OnGetText = FDMemTableProductionByRollFormerROLLFORMERIDGetText
    end
    object FDMemTableProductionByRollFormerMETERS: TFloatField
      FieldName = 'METERS'
      Required = True
      DisplayFormat = '#.00M'
    end
    object FDMemTableProductionByRollFormerRUNSECONDS: TIntegerField
      FieldName = 'RUNSECONDS'
      OnGetText = FDMemTableProductionByRollFormerRUNSECONDSGetText
    end
    object FDMemTableProductionByRollFormerPAUSETIME: TIntegerField
      FieldName = 'PAUSETIME'
      Required = True
      OnGetText = FDMemTableProductionByRollFormerRUNSECONDSGetText
    end
    object FDMemTableProductionByRollFormerCUTS: TIntegerField
      FieldName = 'CUTS'
      Required = True
    end
    object FDMemTableProductionByRollFormerSWAGE: TIntegerField
      FieldName = 'SWAGE'
      Required = True
    end
    object FDMemTableProductionByRollFormerNOTCH: TIntegerField
      FieldName = 'NOTCH'
      Required = True
    end
    object FDMemTableProductionByRollFormerFLAT: TIntegerField
      FieldName = 'FLAT'
      Required = True
    end
    object FDMemTableProductionByRollFormerFPUNCH: TIntegerField
      FieldName = 'FPUNCH'
      Required = True
    end
    object FDMemTableProductionByRollFormerSTATUSID: TSmallintField
      FieldName = 'STATUSID'
      Required = True
    end
    object FDMemTableProductionByRollFormerRUNTIME: TFloatField
      FieldKind = fkCalculated
      FieldName = 'RUNTIME'
      Calculated = True
    end
  end
  object FDMemTableProductionByCard: TFDMemTable
    IndexFieldNames = 'CARDNUMBER'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 416
    Top = 104
    object FDMemTableProductionByCardCARDNUMBER: TWideStringField
      FieldName = 'CARDNUMBER'
    end
    object FDMemTableProductionByCardORIGINMETERS: TFloatField
      FieldName = 'ORIGINMETERS'
      Required = True
      DisplayFormat = '#.00M'
    end
    object FDMemTableProductionByCardMETERS: TFloatField
      FieldName = 'METERS'
      Required = True
      DisplayFormat = '#.00M'
    end
    object FDMemTableProductionByCardREMAINMETERS: TFloatField
      FieldName = 'REMAINMETERS'
      Required = True
      DisplayFormat = '#.00M'
    end
  end
  object FDMemTableRFDateInfo: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 424
    Top = 208
    object FDMemTableRFDateInfoROLLFORMERID: TSmallintField
      FieldName = 'ROLLFORMERID'
      OnGetText = FDMemTableProductionByRollFormerROLLFORMERIDGetText
    end
    object FDMemTableRFDateInfoRFINFODATE: TDateField
      FieldName = 'RFINFODATE'
    end
    object FDMemTableRFDateInfoCARDNUMBER: TWideStringField
      FieldName = 'CARDNUMBER'
    end
    object FDMemTableRFDateInfoORIGINMETERS: TFloatField
      FieldName = 'ORIGINMETERS'
    end
    object FDMemTableRFDateInfoREMAINMETERS: TFloatField
      FieldName = 'REMAINMETERS'
    end
    object FDMemTableRFDateInfoRUNSECONDS: TIntegerField
      FieldName = 'RUNSECONDS'
      OnGetText = FDMemTableProductionByRollFormerRUNSECONDSGetText
    end
    object FDMemTableRFDateInfoPAUSETIME: TIntegerField
      FieldName = 'PAUSETIME'
      OnGetText = FDMemTableProductionByRollFormerRUNSECONDSGetText
    end
    object FDMemTableRFDateInfoMETERS: TFloatField
      FieldName = 'METERS'
    end
    object FDMemTableRFDateInfoSTATUSID: TSmallintField
      FieldName = 'STATUSID'
    end
    object FDMemTableRFDateInfoCUTS: TIntegerField
      FieldName = 'CUTS'
    end
    object FDMemTableRFDateInfoSWAGE: TIntegerField
      FieldName = 'SWAGE'
    end
    object FDMemTableRFDateInfoNOTCH: TIntegerField
      FieldName = 'NOTCH'
    end
    object FDMemTableRFDateInfoFLAT: TIntegerField
      FieldName = 'FLAT'
    end
    object FDMemTableRFDateInfoFPUNCH: TIntegerField
      FieldName = 'FPUNCH'
    end
    object FDMemTableRFDateInfoRFTYPEID: TSmallintField
      FieldName = 'RFTYPEID'
    end
    object FDMemTableRFDateInfoSITEID: TSmallintField
      FieldName = 'SITEID'
    end
    object FDMemTableRFDateInfoADDEDON: TSQLTimeStampField
      FieldName = 'ADDEDON'
    end
  end
end
