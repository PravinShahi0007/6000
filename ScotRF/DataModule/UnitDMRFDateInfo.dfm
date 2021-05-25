inherited DMRFDateInfo: TDMRFDateInfo
  OldCreateOrder = True
  inherited FDMemTableItems: TFDMemTable
    OnCalcFields = CDSItemsCalcFields
    IndexesActive = False
    IndexFieldNames = 'SITEID;RFINFODATE;ROLLFORMERID;CARDNUMBER'
    object FDMemTableItemsRFDATEINFOID: TIntegerField
      FieldName = 'RFDATEINFOID'
      Required = True
    end
    object FDMemTableItemsRFINFODATE: TDateField
      FieldName = 'RFINFODATE'
      Required = True
    end
    object FDMemTableItemsROLLFORMERID: TIntegerField
      FieldName = 'ROLLFORMERID'
      Required = True
    end
    object FDMemTableItemsCARDNUMBER: TWideStringField
      FieldName = 'CARDNUMBER'
    end
    object FDMemTableItemsORIGINMETERS: TFloatField
      FieldName = 'ORIGINMETERS'
      Required = True
    end
    object FDMemTableItemsREMAINMETERS: TFloatField
      FieldName = 'REMAINMETERS'
      Required = True
    end
    object FDMemTableItemsRUNSECONDS: TIntegerField
      FieldName = 'RUNSECONDS'
      Required = True
      OnGetText = CDSItemsRUNSECONDSGetText
    end
    object FDMemTableItemsPAUSETIME: TIntegerField
      FieldName = 'PAUSETIME'
      Required = True
      OnGetText = CDSItemsRUNSECONDSGetText
    end
    object FDMemTableItemsMETERS: TFloatField
      FieldName = 'METERS'
      Required = True
      OnGetText = CDSItemsRUNSECONDSGetText
      DisplayFormat = '0.00'
    end
    object FDMemTableItemsCUTS: TIntegerField
      FieldName = 'CUTS'
      Required = True
    end
    object FDMemTableItemsSWAGE: TIntegerField
      FieldName = 'SWAGE'
      Required = True
    end
    object FDMemTableItemsNOTCH: TIntegerField
      FieldName = 'NOTCH'
      Required = True
    end
    object FDMemTableItemsFLAT: TIntegerField
      FieldName = 'FLAT'
      Required = True
    end
    object FDMemTableItemsFPUNCH: TIntegerField
      FieldName = 'FPUNCH'
      Required = True
    end
    object FDMemTableItemsSTATUSID: TSmallintField
      FieldName = 'STATUSID'
      Required = True
    end
    object FDMemTableItemsSITEID: TIntegerField
      FieldName = 'SITEID'
      Required = True
    end
    object FDMemTableItemsADDEDON: TSQLTimeStampField
      FieldName = 'ADDEDON'
      Required = True
    end
    object FDMemTableItemsRFTYPEID: TSmallintField
      FieldName = 'RFTYPEID'
      Required = True
    end
    object FDMemTableItemsOriginUnit: TFloatField
      FieldKind = fkCalculated
      FieldName = 'OriginUnit'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object FDMemTableItemsRemainUnit: TFloatField
      FieldKind = fkCalculated
      FieldName = 'RemainUnit'
      DisplayFormat = '0.00'
      Calculated = True
    end
    object FDMemTableItemsMetersUnit: TFloatField
      FieldKind = fkCalculated
      FieldName = 'MetersUnit'
      DisplayFormat = '0.00'
      Calculated = True
    end
  end
end
