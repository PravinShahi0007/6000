object DMRemoteDB: TDMRemoteDB
  OldCreateOrder = False
  Height = 460
  Width = 861
  object SCSServerDataSnap: TSQLConnection
    ConnectionName = 'DataSnapCONNECTION'
    DriverName = 'DataSnap'
    KeepConnection = False
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'DriverName=DataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DSAuthenticationUser=steven@26'
      'DSAuthenticationPassword=admin'
      'Filters={}')
    Left = 72
    Top = 24
    UniqueId = '{A25E5585-8B9C-45C4-B817-6A83F2DD95E8}'
  end
end
