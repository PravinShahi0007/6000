object SpeedForm: TSpeedForm
  Left = 296
  Top = 363
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Set Motor Parameters'
  ClientHeight = 147
  ClientWidth = 243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 18
    Top = 13
    Width = 64
    Height = 13
    Caption = 'Maximum rpm'
  end
  object Label2: TLabel
    Left = 22
    Top = 53
    Width = 59
    Height = 13
    Caption = 'Acceleration'
  end
  object UpDown1: TUpDown
    Left = 179
    Top = 9
    Width = 24
    Height = 21
    Associate = Edit1
    Min = 1000
    Max = 2400
    Increment = 100
    Position = 1800
    TabOrder = 0
    Thousands = False
  end
  object Edit1: TEdit
    Left = 90
    Top = 9
    Width = 89
    Height = 21
    TabOrder = 1
    Text = '1800'
  end
  object bnSetSpeed: TBitBtn
    Left = 26
    Top = 85
    Width = 93
    Height = 25
    Caption = 'Set'
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 2
    OnClick = bnSetSpeedClick
  end
  object BitBtn2: TBitBtn
    Left = 130
    Top = 85
    Width = 85
    Height = 25
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 90
    Top = 49
    Width = 89
    Height = 21
    TabOrder = 4
    Text = '300'
  end
  object UpDown2: TUpDown
    Left = 179
    Top = 49
    Width = 24
    Height = 21
    Associate = Edit2
    Max = 500
    Increment = 10
    Position = 300
    TabOrder = 5
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 128
    Width = 243
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitLeft = 32
    ExplicitTop = 136
    ExplicitWidth = 0
  end
end
