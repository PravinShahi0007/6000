object DMTemplate: TDMTemplate
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 345
  Width = 540
  object FDMemTableItems: TFDMemTable
    Tag = 9
    OnNewRecord = FDMemTableItemsNewRecord
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 432
    Top = 240
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 452
    Top = 17
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 344
    Top = 17
  end
end
