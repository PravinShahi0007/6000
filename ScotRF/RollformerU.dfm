object Rollformer: TRollformer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 182
  Width = 531
  object VaComm1: TVaComm
    Baudrate = br9600
    FlowControl.OutCtsFlow = True
    FlowControl.OutDsrFlow = False
    FlowControl.ControlDtr = dtrDisabled
    FlowControl.ControlRts = rtsEnabled
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    FlowControl.DsrSensitivity = False
    FlowControl.TxContinueOnXoff = False
    DeviceName = 'com1'
    MonitorEvents = [ceCts, ceError, ceRxChar, ceTxEmpty]
    Buffers.ReadSize = 2048
    Buffers.ReadTimeout = 2000
    Buffers.WriteTimeout = 2000
    EventPriority = tpHigher
    SettingsStore.RegRoot = rrCURRENTUSER
    SettingsStore.Location = slINIFile
    OnRxChar = VaComm1RxChar
    Version = '2.0.4.0'
    Left = 16
    Top = 16
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer1Timer
    Left = 114
    Top = 8
  end
  object Timer4: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer4Timer
    Left = 168
    Top = 8
  end
end
