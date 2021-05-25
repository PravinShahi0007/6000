object frmMk2Errors: TfrmMk2Errors
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu]
  Caption = 'Error'
  ClientHeight = 319
  ClientWidth = 302
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    302
    319)
  PixelsPerInch = 96
  TextHeight = 13
  object imgIcon: TImage
    Left = 0
    Top = 0
    Width = 32
    Height = 32
  end
  object lblErrorDesc: TLabel
    Left = 48
    Top = 8
    Width = 25
    Height = 13
    Caption = 'Error:'
  end
  object memErrors: TMemo
    Left = 0
    Top = 40
    Width = 294
    Height = 223
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object bnOk: TBitBtn
    Left = 179
    Top = 269
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 300
    Width = 302
    Height = 19
    Panels = <>
  end
  object bnCancel: TBitBtn
    Left = 48
    Top = 268
    Width = 81
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akRight, akBottom]
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
end
