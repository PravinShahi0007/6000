object Itemform: TItemform
  Left = 168
  Top = 165
  BorderIcons = [biSystemMenu]
  Caption = 'Items'
  ClientHeight = 363
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    372
    363)
  PixelsPerInch = 96
  TextHeight = 13
  object bnClear: TSpeedButton
    Left = 287
    Top = 15
    Width = 73
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'Clear'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = bnClearClick
    ExplicitLeft = 312
  end
  object bnLoad: TSpeedButton
    Left = 288
    Top = 50
    Width = 73
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'Load'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = bnLoadClick
    ExplicitLeft = 313
  end
  object bnSave: TSpeedButton
    Left = 288
    Top = 82
    Width = 73
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'Save'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = bnSaveClick
    ExplicitLeft = 313
  end
  object SpeedButton2: TSpeedButton
    Left = 3
    Top = 152
    Width = 73
    Height = 29
  end
  object bnHelp: TSpeedButton
    Left = 288
    Top = 200
    Width = 73
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = bnHelpClick
    ExplicitLeft = 313
  end
  object bnWizard: TSpeedButton
    Left = 287
    Top = 114
    Width = 73
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'Wizard'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = bnWizardClick
    ExplicitLeft = 312
  end
  object bnRun: TSpeedButton
    Left = 288
    Top = 261
    Width = 73
    Height = 29
    Anchors = [akTop, akRight]
    Caption = 'Run'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000C3C3C3C3C3C3
      C3C3C3C3C3C3C3C3C3C3C3C3E7E7E7121212D5D5D5C3C3C3C3C3C3C3C3C3C3C3
      C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3E7E5E718151800
      0000DBDADBC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
      C3C3C3C3C3C3E7E0E7182718000E00000000DBDADBC3C3C3C3C3C3C3C3C3C3C3
      C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3E7DEE718401800490000410000
      0000F3EFF3DBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBDBC3C3C3C3C3C3
      E7DFE7182F18004E00007400005A00001F000000000000000000000000000000
      00000000000000000000C3C3C3E7DCE7183918004D00008800018E0000670000
      4500003900003B00003B00003B00003900003400002E00001A00E7D7E7184D18
      005D00008C000AA008049602007F00007700007B00007B00007A00007B00007A
      00006F00005D000030002475240068000DA50B25BC2128BC2424B91F1BB5171D
      B7181BB4161BB4161DB7191EB81918B11407A105008200003F00248724008500
      2FC12B6BE4676AE16580EB7D93F48F87EF8486F08287F08380EC7C82ED7E75E9
      714BD34610A80D005500E6CEE71D9B1B00A0006EE5699DF79B9FF79CB9FDB7D0
      FFCEE8FFE7EEFFEDEDFFECEFFFEFDAFFD98AF3852EC82A005F00C3C3C3E5CAE6
      20A01E03A4007CEB7792F38F50D54B33C72F26C02226C52731C92D31C92D2BC4
      260FAD0C009100004A00C3C3C3C3C3C3E6CBE616901504A60075E97033C42F00
      9100005A00005300006000006300005B00004C00003C00001C00C3C3C3C3C3C3
      C3C3C3E6CDE714881401A20015AD12006800F3D6F3DBCEDBDBCCDBDBCCDBDBCD
      DBDBCFDBDBD1DBDBD4DBC3C3C3C3C3C3C3C3C3C3C3C3E7CEE717881600990000
      4800DBCFDBC3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3
      C3C3C3C3C3C3C3C3C3E7CEE7199119004600DBCFDBC3C3C3C3C3C3C3C3C3C3C3
      C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3E7D2E712
      6112D5CDD5C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3}
    ParentFont = False
    OnClick = bnRunClick
    ExplicitLeft = 313
  end
  object Memo1: TMemo
    Left = 0
    Top = 4
    Width = 276
    Height = 334
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 289
    Top = 307
    Width = 72
    Height = 33
    Anchors = [akTop, akRight]
    DoubleBuffered = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Kind = bkClose
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 344
    Width = 372
    Height = 19
    Panels = <>
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'fdn'
    Filter = 'Item process files|*.txt|Box web text files|*.bwt'
    Left = 188
    Top = 144
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'fdn'
    Filter = 'Item process files|*.txt|Box web Item files|*.bwt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 148
    Top = 144
  end
end
