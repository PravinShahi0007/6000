object DMLoadEP2Files: TDMLoadEP2Files
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 331
  Width = 546
  object FDMemTableEP2FILE: TFDMemTable
    IndexFieldNames = 'EP2FILEID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 354
    Top = 72
    object FDMemTableEP2FILEEP2FILEID: TIntegerField
      FieldName = 'EP2FILEID'
    end
    object FDMemTableEP2FILEEP2TEXT: TBlobField
      FieldName = 'EP2TEXT'
    end
  end
end
