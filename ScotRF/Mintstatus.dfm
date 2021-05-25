object FormMintStatus: TFormMintStatus
  Left = 307
  Top = 258
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'Status'
  ClientHeight = 298
  ClientWidth = 186
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 11
    Top = 75
    Width = 63
    Height = 13
    Caption = 'Comms errors'
  end
  object Label2: TLabel
    Left = 15
    Top = 39
    Width = 49
    Height = 13
    Caption = 'Error code'
  end
  object Label1: TLabel
    Left = 8
    Top = 7
    Width = 72
    Height = 13
    Caption = 'S/ware version'
  end
  object Label4: TLabel
    Left = 0
    Top = 108
    Width = 79
    Height = 13
    Caption = 'Firmware version'
  end
  object Label6: TLabel
    Left = 8
    Top = 140
    Width = 65
    Height = 13
    Caption = 'Drive Temp C'
  end
  object Label7: TLabel
    Left = 8
    Top = 172
    Width = 52
    Height = 13
    Caption = 'Air Temp C'
  end
  object BitBtn1: TBitBtn
    Left = 101
    Top = 226
    Width = 77
    Height = 33
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 0
  end
  object uxComErrors: TEdit
    Left = 91
    Top = 71
    Width = 85
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object uxError: TEdit
    Left = 91
    Top = 33
    Width = 85
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object uxVersion: TEdit
    Left = 91
    Top = 0
    Width = 85
    Height = 21
    TabOrder = 3
  end
  object uxFirmware: TEdit
    Left = 91
    Top = 104
    Width = 85
    Height = 21
    TabOrder = 4
  end
  object uxDriveTemp: TEdit
    Left = 91
    Top = 136
    Width = 45
    Height = 21
    TabOrder = 5
  end
  object uxRFTemp: TEdit
    Left = 91
    Top = 168
    Width = 46
    Height = 21
    TabOrder = 6
    Text = 'n/a'
  end
  object bnCounter: TButton
    Left = 0
    Top = 227
    Width = 71
    Height = 31
    Caption = 'Life counter'
    TabOrder = 7
    OnClick = bnCounterClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 279
    Width = 186
    Height = 19
    Panels = <>
    SimplePanel = True
  end
end
