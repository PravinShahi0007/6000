object StopServiceForm: TStopServiceForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'StopServiceForm'
  ClientHeight = 50
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    323
    50)
  PixelsPerInch = 96
  TextHeight = 13
  object WaitingGradient: TJvWaitingGradient
    Left = 8
    Top = 32
    Width = 307
    Active = True
    Anchors = [akLeft, akRight]
    Color = clBtnFace
    GradientWidth = 50
    EndColor = clGreen
    ParentColor = False
    AlwaysRestart = True
  end
  object lblProgressTitle: TLabel
    Left = 8
    Top = 8
    Width = 177
    Height = 13
    Caption = 'Stopping Service Scot. Please wait...'
  end
  object btnHide: TButton
    Left = 269
    Top = 8
    Width = 46
    Height = 18
    Caption = '&Hide'
    TabOrder = 0
    OnClick = btnHideClick
  end
  object TimerAutoClose: TTimer
    Interval = 5000
    OnTimer = TimerAutoCloseTimer
    Left = 208
  end
end
