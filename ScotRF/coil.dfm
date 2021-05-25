object Coilform: TCoilform
  Left = 375
  Top = 293
  BorderIcons = [biSystemMenu]
  BorderWidth = 5
  Caption = 'Job Details'
  ClientHeight = 417
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 260
    Width = 62
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Coil ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 43
    Width = 62
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Job ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 106
    Width = 62
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Operator'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 160
    Width = 62
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Riveters'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 290
    Width = 63
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Weight'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 8
    Top = 12
    Width = 62
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Design'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 8
    Top = 74
    Width = 62
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Steel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI Semilight'
    Font.Style = []
    ParentFont = False
  end
  object uxCoilID: TEdit
    Left = 85
    Top = 256
    Width = 117
    Height = 21
    MaxLength = 32
    TabOrder = 3
    OnChange = EnableButtons
  end
  object bnSave: TBitBtn
    Left = 117
    Top = 366
    Width = 85
    Height = 26
    Caption = 'OK'
    Default = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 5
    OnClick = bnSaveClick
  end
  object uxJobName: TEdit
    Left = 85
    Top = 39
    Width = 156
    Height = 21
    MaxLength = 32
    TabOrder = 0
    OnChange = EnableButtons
  end
  object uxOperator: TEdit
    Left = 85
    Top = 102
    Width = 156
    Height = 21
    MaxLength = 32
    TabOrder = 1
    OnChange = EnableButtons
  end
  object uxRiveters: TMemo
    Left = 85
    Top = 149
    Width = 156
    Height = 88
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object uxCoilWeight: TEdit
    Left = 85
    Top = 283
    Width = 49
    Height = 21
    MaxLength = 12
    TabOrder = 4
    OnChange = EnableButtons
  end
  object uxDesign: TEdit
    Left = 85
    Top = 8
    Width = 156
    Height = 21
    MaxLength = 32
    TabOrder = 6
    OnChange = EnableButtons
  end
  object uxSteel: TEdit
    Left = 85
    Top = 70
    Width = 156
    Height = 21
    MaxLength = 32
    TabOrder = 7
    OnChange = EnableButtons
  end
end
