object FormSplash: TFormSplash
  Left = 74
  Top = 46
  AutoSize = True
  Caption = 'Scottsdale Construction System'
  ClientHeight = 390
  ClientWidth = 480
  Color = clBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 16
  object ImageAppLogo: TImage
    Left = 0
    Top = 0
    Width = 480
    Height = 360
    Stretch = True
  end
  object LabelDisplayInformation: TLabel
    Left = 48
    Top = 182
    Width = 353
    Height = 18
    Caption = 'Loading Data ......'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object LabelVersionNumver: TLabel
    Left = 145
    Top = 366
    Width = 105
    Height = 24
    Alignment = taRightJustify
    Caption = 'Version 1.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -20
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
end
