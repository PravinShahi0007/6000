object Calibform: TCalibform
  Left = 325
  Top = 301
  AutoSize = True
  BorderWidth = 5
  Caption = 'Auto calibration'
  ClientHeight = 125
  ClientWidth = 241
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 4
    Width = 99
    Height = 13
    Caption = 'Minumum item length'
  end
  object Label2: TLabel
    Left = 56
    Top = 36
    Width = 50
    Height = 13
    Caption = 'Frequency'
  end
  object BitBtn1: TBitBtn
    Left = 144
    Top = 96
    Width = 93
    Height = 29
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 120
    Top = 0
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object Edit2: TEdit
    Left = 120
    Top = 32
    Width = 49
    Height = 21
    AutoSize = False
    TabOrder = 2
    Text = '0'
  end
  object UpDown1: TUpDown
    Left = 169
    Top = 32
    Width = 20
    Height = 21
    Associate = Edit2
    Max = 1000
    Increment = 5
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 0
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Start '
    TabOrder = 4
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 0
    Top = 100
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 5
    OnClick = BitBtn3Click
  end
  object Panel1: TPanel
    Left = 152
    Top = 72
    Width = 73
    Height = 21
    TabOrder = 6
    object Label3: TLabel
      Left = 12
      Top = 4
      Width = 48
      Height = 13
      Caption = 'Stopped'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
