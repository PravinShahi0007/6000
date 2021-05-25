object TypeSelectform: TTypeSelectform
  Left = 381
  Top = 286
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'Include items'
  ClientHeight = 323
  ClientWidth = 177
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
  object SelectItemsCheckBox: TCheckBox
    Left = 20
    Top = 0
    Width = 117
    Height = 17
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taLeftJustify
    Caption = 'Select by items'
    TabOrder = 0
  end
  object bnOK: TBitBtn
    Left = 86
    Top = 288
    Width = 75
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 1
    OnClick = bnOKClick
  end
  object bnCancel: TBitBtn
    Left = 7
    Top = 288
    Width = 75
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 2
  end
  object ItemsListBox: TListBox
    Left = 20
    Top = 21
    Width = 130
    Height = 244
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ItemHeight = 13
    Items.Strings = (
      'Plate bottom'
      'Plate top'
      'Opening studs'
      'Opening top'
      'Opening bottom'
      'Studs'
      'Joists'
      'Rafters'
      'Nogs / Blocking'
      'Braces'
      'Perimeters'
      'Chord'
      'Web'
      'Web3'
      'Web4'
      'Heel'
      'BC')
    MultiSelect = True
    TabOrder = 3
  end
end
