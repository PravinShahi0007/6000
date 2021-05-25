object ServiceScot: TServiceScot
  OldCreateOrder = False
  DisplayName = 'Service Scot'
  AfterInstall = ServiceAfterInstall
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 224
  Width = 416
  object FDMemTableServerInfo: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 312
    Top = 16
    object FDMemTableServerInfoServerName: TStringField
      FieldName = 'ServerName'
    end
    object FDMemTableServerInfoIPAddress: TStringField
      FieldName = 'IPAddress'
    end
    object FDMemTableServerInfoPort: TStringField
      FieldName = 'Port'
    end
  end
end
