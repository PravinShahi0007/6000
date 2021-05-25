object ServerContainerRF: TServerContainerRF
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 385
  Width = 648
  object DSServerScotRF: TDSServer
    OnConnect = DSServerScotRFConnect
    OnDisconnect = DSServerScotRFDisconnect
    Left = 96
    Top = 11
  end
  object DSTCPServerTransportScotRF: TDSTCPServerTransport
    Server = DSServerScotRF
    Filters = <>
    Left = 96
    Top = 81
  end
  object DSServerClassMethods: TDSServerClass
    OnGetClass = DSServerClassMethodsGetClass
    Server = DSServerScotRF
    Left = 96
    Top = 160
  end
  object CDSCurrentConnections: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'UserName'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ServerConnection'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Info'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TillNo'
        DataType = ftSmallint
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 496
    Top = 112
  end
end
