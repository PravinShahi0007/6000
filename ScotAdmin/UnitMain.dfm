object FormAdministrator: TFormAdministrator
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Scot Service Administrator'
  ClientHeight = 299
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelButtons: TPanel
    Left = 0
    Top = 258
    Width = 525
    Height = 41
    Align = alBottom
    TabOrder = 0
    object ButtonRefreshStatus: TButton
      Left = 336
      Top = 8
      Width = 137
      Height = 25
      Caption = 'Refresh Status'
      TabOrder = 0
      OnClick = ButtonRefreshStatusClick
    end
  end
  object AdminEvents: TApplicationEvents
    OnMinimize = AdminEventsMinimize
    Left = 472
    Top = 32
  end
  object AdminTrayIcon: TTrayIcon
    Hint = 'Scot Service Administrator'
    BalloonHint = 'Scot Service Administrator'
    OnDblClick = AdminTrayIconDblClick
    Left = 472
    Top = 104
  end
end
