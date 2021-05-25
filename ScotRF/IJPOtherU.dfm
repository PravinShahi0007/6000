inherited IJPOther: TIJPOther
  OldCreateOrder = True
  Height = 116
  Width = 252
  object Timer5: TTimer
    Interval = 200
    OnTimer = Timer5Timer
    Left = 48
    Top = 16
  end
  object VaComm2: TVaComm
    Baudrate = br9600
    FlowControl.OutCtsFlow = False
    FlowControl.OutDsrFlow = False
    FlowControl.ControlDtr = dtrDisabled
    FlowControl.ControlRts = rtsDisabled
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    FlowControl.DsrSensitivity = False
    FlowControl.TxContinueOnXoff = False
    DeviceName = 'com2'
    Buffers.ReadSize = 2048
    Buffers.ReadTimeout = 2000
    Buffers.WriteTimeout = 2000
    EventPriority = tpHigher
    SettingsStore.RegRoot = rrCURRENTUSER
    SettingsStore.Location = slINIFile
    OnRxChar = VaComm2RxChar
    Version = '2.0.3.0'
    Left = 120
    Top = 24
  end
end
