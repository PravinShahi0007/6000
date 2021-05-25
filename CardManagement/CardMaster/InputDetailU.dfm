object InputDetail: TInputDetail
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Card Data'
  ClientHeight = 256
  ClientWidth = 383
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
  object Label1: TLabel
    Left = 8
    Top = 53
    Width = 127
    Height = 13
    Caption = 'Name (16 characters max)'
  end
  object lbUnits: TLabel
    Left = 56
    Top = 91
    Width = 79
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Metres'
  end
  object lbEcho: TLabel
    Left = 152
    Top = 114
    Width = 121
    Height = 13
    AutoSize = False
    Caption = 'xxx Metres'
    Visible = False
  end
  object Label2: TLabel
    Left = 69
    Top = 15
    Width = 66
    Height = 13
    Alignment = taRightJustify
    Caption = 'Serial Number'
  end
  object lbExpiry: TLabel
    Left = 56
    Top = 172
    Width = 79
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Expiry Date'
  end
  object edName: TEdit
    Left = 152
    Top = 49
    Width = 121
    Height = 21
    MaxLength = 16
    TabOrder = 1
    OnChange = edNameChange
  end
  object edQuantity: TEdit
    Left = 152
    Top = 87
    Width = 121
    Height = 21
    TabOrder = 2
    OnChange = edQuantityChange
  end
  object bnOK: TBitBtn
    Left = 198
    Top = 223
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 4
    OnClick = bnOKClick
  end
  object rgUnits: TRadioGroup
    Left = 296
    Top = 87
    Width = 81
    Height = 57
    Caption = 'Units'
    ItemIndex = 0
    Items.Strings = (
      'Metres'
      'Feet')
    TabOrder = 3
    OnClick = rgUnitsClick
  end
  object edSerial: TEdit
    Left = 152
    Top = 11
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = edSerialChange
  end
  object uxExpiry: TDateTimePicker
    Left = 152
    Top = 168
    Width = 121
    Height = 21
    Date = 42997.000000000000000000
    Time = 42997.000000000000000000
    TabOrder = 5
    OnChange = uxExpiryChange
  end
end
