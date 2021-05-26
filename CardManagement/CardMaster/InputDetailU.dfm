object InputDetail: TInputDetail
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Card Data'
  ClientHeight = 311
  ClientWidth = 453
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 167
    Width = 127
    Height = 13
    Caption = 'Name (16 characters max)'
  end
  object lbUnits: TLabel
    Left = 56
    Top = 205
    Width = 79
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Metres'
  end
  object lbEcho: TLabel
    Left = 152
    Top = 228
    Width = 121
    Height = 13
    AutoSize = False
    Caption = 'xxx Metres'
    Visible = False
  end
  object Label2: TLabel
    Left = 69
    Top = 128
    Width = 66
    Height = 13
    Alignment = taRightJustify
    Caption = 'Serial Number'
  end
  object lbExpiry: TLabel
    Left = 321
    Top = 71
    Width = 79
    Height = 13
    AutoSize = False
    Caption = 'Expiry Date'
  end
  object edName: TEdit
    Left = 152
    Top = 163
    Width = 121
    Height = 21
    MaxLength = 16
    TabOrder = 3
    OnChange = edNameChange
  end
  object edQuantity: TEdit
    Left = 152
    Top = 201
    Width = 121
    Height = 21
    TabOrder = 4
    OnChange = edQuantityChange
  end
  object bnOK: TBitBtn
    Left = 366
    Top = 271
    Width = 75
    Height = 25
    Enabled = False
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 6
    OnClick = bnOKClick
  end
  object rgUnits: TRadioGroup
    Left = 288
    Top = 199
    Width = 81
    Height = 57
    Caption = 'Units'
    ItemIndex = 0
    Items.Strings = (
      'Metres'
      'Feet')
    TabOrder = 5
    OnClick = rgUnitsClick
  end
  object edSerial: TEdit
    Left = 152
    Top = 125
    Width = 121
    Height = 21
    TabOrder = 2
    OnChange = edSerialChange
  end
  object uxExpiry: TDateTimePicker
    Left = 321
    Top = 90
    Width = 120
    Height = 21
    Date = 42997.000000000000000000
    Time = 42997.000000000000000000
    TabOrder = 1
    OnChange = uxExpiryChange
  end
  object rgCardCharge: TRadioGroup
    Left = 152
    Top = 14
    Width = 147
    Height = 99
    Caption = 'Type'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Standard  - Green'
      'Red - high rate'
      'Gold - zero rate')
    ParentFont = False
    TabOrder = 0
    OnClick = rgCardChargeClick
  end
end
