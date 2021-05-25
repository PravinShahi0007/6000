object Itemhelpform: TItemhelpform
  Left = 223
  Top = 172
  AutoSize = True
  BorderIcons = []
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'Design syntax'
  ClientHeight = 436
  ClientWidth = 237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 237
    Height = 393
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'Frame , Item , Position , Operation'
      ''
      'Eg. 2400mm stud'
      'A1,SL,12 H'
      'A1,SL,2388 H'
      'A1,SL,2400 C'
      ''
      'Eg. 400mm notched nog'
      'A1,D2,12 H'
      'A1,D2,13 F'
      'A1,D2,17 N'
      'A1,D2,383 N'
      'A1,D2,387 F'
      'A1,D2,388 H'
      'A1,D2,400 C'
      ' '
      'Operation codes'
      'C - cut'
      'H- hole'
      'F - flatten     '
      'N - notch'
      'W - swage'
      'S - service')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object bnClose: TBitBtn
    Left = 64
    Top = 407
    Width = 81
    Height = 29
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 0
    Top = 0
    Width = 237
    Height = 121
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'Operation codes'
      'C - Cut'
      'H - Lip Hole'
      'F - Flange Hole'
      'P - Cope'
      'N - Notch')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
