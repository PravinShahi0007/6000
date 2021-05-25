inherited Sojet: TSojet
  OldCreateOrder = True
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocket1Connect
    OnDisconnect = ClientSocket1Disconnect
    OnRead = ClientSocket1Read
    OnError = ClientSocket1Error
    Left = 112
    Top = 72
  end
  object ClientSocket2: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocket2Connect
    OnDisconnect = ClientSocket2Disconnect
    OnRead = ClientSocket2Read
    OnError = ClientSocket2Error
    Left = 192
    Top = 72
  end
  object StatusTimer: TTimer
    Enabled = False
    OnTimer = StatusTimerTimer
    Left = 194
    Top = 8
  end
end
