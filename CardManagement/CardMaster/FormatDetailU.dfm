object FormatDetail: TFormatDetail
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Card Format'
  ClientHeight = 167
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object bnOK: TBitBtn
    Left = 173
    Top = 135
    Width = 75
    Height = 25
    DoubleBuffered = True
    Enabled = False
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  object rgPanelOrTruss: TRadioGroup
    Left = 8
    Top = 8
    Width = 185
    Height = 81
    Caption = ' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    Items.Strings = (
      'Panel'
      'Truss')
    ParentFont = False
    TabOrder = 1
    OnClick = rgPanelOrTrussClick
  end
  object rgCardCharge: TRadioGroup
    Left = 216
    Top = 8
    Width = 185
    Height = 105
    Caption = 'Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Standard  - Green'
      'Red - high rate'
      'Gold - zero rate')
    ParentFont = False
    TabOrder = 2
  end
end
