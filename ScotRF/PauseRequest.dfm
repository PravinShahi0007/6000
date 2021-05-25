object PauseRequestForm: TPauseRequestForm
  Left = 0
  Top = 0
  Anchors = []
  Caption = 'Pause detail requested'
  ClientHeight = 94
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 130
    Height = 13
    Caption = 'Select reason for RF Pause'
  end
  object ComboBoxPauseReason: TComboBox
    Left = 157
    Top = 21
    Width = 225
    Height = 21
    ItemIndex = 0
    TabOrder = 0
    Text = 'Mechanical'
    Items.Strings = (
      'Mechanical'
      'Coil changed'
      'Tea Break'
      'Lunch Break'
      'Bathroom'
      'Unknown')
  end
  object BitBtnOK: TBitBtn
    Left = 144
    Top = 56
    Width = 105
    Height = 30
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
end
