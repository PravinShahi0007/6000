inherited DMRFOperation: TDMRFOperation
  OldCreateOrder = True
  inherited CDSItems: TClientDataSet
    IndexFieldNames = 'RFOPERATIONID'
    Params = <
      item
        DataType = ftSmallint
        Name = 'SIDEID'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'STARTDATE'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'ENDDATE'
        ParamType = ptInput
      end>
    ProviderName = 'DSPRFOperation'
    object CDSItemsRFOPERATIONID: TIntegerField
      FieldName = 'RFOPERATIONID'
      Required = True
    end
    object CDSItemsRFOPERATION: TSmallintField
      FieldName = 'RFOPERATION'
      Required = True
    end
    object CDSItemsDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Required = True
      Size = 450
    end
    object CDSItemsSITEID: TIntegerField
      FieldName = 'SITEID'
      Required = True
    end
    object CDSItemsROLLFORMERID: TIntegerField
      FieldName = 'ROLLFORMERID'
      Required = True
    end
    object CDSItemsSTATUSID: TSmallintField
      FieldName = 'STATUSID'
      Required = True
    end
    object CDSItemsADDEDON: TSQLTimeStampField
      FieldName = 'ADDEDON'
      Required = True
    end
  end
end
