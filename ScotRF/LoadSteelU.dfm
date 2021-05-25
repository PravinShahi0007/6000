object DlgLoad: TDlgLoad
  Left = 367
  Top = 259
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Scot RF'
  ClientHeight = 224
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object bnRev: TSpeedButton
    Left = 196
    Top = 9
    Width = 72
    Height = 47
    Glyph.Data = {
      76020000424D7602000000000000760000002800000020000000200000000100
      0400000000000002000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFF99FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF999FFFFFFFFFFFFFFFFFFFFFFFFFF
      FFF9999FFFFFFFFFFFFFFFFFFFFFFFFFFFF99999FFFFFFFFFFFFFFFFFFFFFFFF
      FFF999999FFFFFFFFFFFFFFFFF9999999999999999FFFFFFFFFFFFFFFF999999
      99999999999FFFFFFFFFFFFFFF999999999999999999FFFFFFFFFFFFFF999999
      9999999999999FFFFFFFFFFFFF99999999999999999999FFFFFFFFFFFF999999
      999999999999999FFFFFFFFFFF9999999999999999999999FFFFFFFFFF999999
      99999999999999999FFFFFFFFF999999999999999999999999FFFFFFFF999999
      9999999999999999999FFFFFFF99999999999999999999999999FFFFFF999999
      99999999999999999999FFFFFF9999999999999999999999999FFFFFFF999999
      999999999999999999FFFFFFFF99999999999999999999999FFFFFFFFF999999
      9999999999999999FFFFFFFFFF999999999999999999999FFFFFFFFFFF999999
      99999999999999FFFFFFFFFFFF9999999999999999999FFFFFFFFFFFFF999999
      999999999999FFFFFFFFFFFFFF99999999999999999FFFFFFFFFFFFFFF999999
      9999999999FFFFFFFFFFFFFFFFFFFFFFFFF999999FFFFFFFFFFFFFFFFFFFFFFF
      FFF99999FFFFFFFFFFFFFFFFFFFFFFFFFFF9999FFFFFFFFFFFFFFFFFFFFFFFFF
      FFF999FFFFFFFFFFFFFFFFFFFFFFFFFFFFF99FFFFFFFFFFFFFFF}
    OnClick = bnRevClick
  end
  object bnFwd: TSpeedButton
    Left = 14
    Top = 9
    Width = 72
    Height = 47
    Glyph.Data = {
      76020000424D7602000000000000760000002800000020000000200000000100
      0400000000000002000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFF99FFFFFFFFFFFFFFFFFFFFFFFFFFFFF999FFFFFFFFFFFFFFFFFFFFFFFFFFF
      F9999FFFFFFFFFFFFFFFFFFFFFFFFFFF99999FFFFFFFFFFFFFFFFFFFFFFFFFF9
      99999FFFFFFFFFFFFFFFFFFFFFFFFF99999999999999999FFFFFFFFFFFFFF999
      999999999999999FFFFFFFFFFFFF9999999999999999999FFFFFFFFFFFF99999
      999999999999999FFFFFFFFFFF999999999999999999999FFFFFFFFFF9999999
      999999999999999FFFFFFFFF99999999999999999999999FFFFFFFF999999999
      999999999999999FFFFFFF9999999999999999999999999FFFFFF99999999999
      999999999999999FFFFF999999999999999999999999999FFFFFF99999999999
      999999999999999FFFFFFF9999999999999999999999999FFFFFFFF999999999
      999999999999999FFFFFFFFF99999999999999999999999FFFFFFFFFF9999999
      999999999999999FFFFFFFFFFF999999999999999999999FFFFFFFFFFFF99999
      999999999999999FFFFFFFFFFFFF9999999999999999999FFFFFFFFFFFFFF999
      999999999999999FFFFFFFFFFFFFFF99999999999999999FFFFFFFFFFFFFFFF9
      999999999999999FFFFFFFFFFFFFFFFF99999FFFFFFFFFFFFFFFFFFFFFFFFFFF
      F9999FFFFFFFFFFFFFFFFFFFFFFFFFFFFF999FFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFF99FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFF}
    OnClick = bnFwdClick
  end
  object Label1: TLabel
    Left = 36
    Top = 58
    Width = 38
    Height = 13
    Caption = 'Forward'
  end
  object Label2: TLabel
    Left = 210
    Top = 58
    Width = 40
    Height = 13
    Caption = 'Reverse'
  end
  object bnStop: TSpeedButton
    Left = 105
    Top = 9
    Width = 72
    Height = 47
    Glyph.Data = {
      360C0000424D360C000000000000360000002800000020000000200000000100
      180000000000000C000000000000000000000000000000000000008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080008080008080
      008080008080008080008080008080DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDD008080008080008080008080008080008080008080008080008080008080
      008080008080008080008080DDDDDDD6D6D6737869787B71787B71787B71787B
      71787B71787B71787B71787B71787B71787B71787B71787B71787C71717667D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDDD6D6D6807A887071647273687273687273687273
      687273687273687273687273687273687273687273687273686F6F6A7A7B76D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD43483200000D0000390000330000330000330000
      3300003300003300003300003300003300003300003300003B00000553544BD6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360D07A22A20FF271DFF271DFF271DFF271D
      FF271DFF271DFF271DFF271DFF271DFF271DFF261DFF2C21FF06036F585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0590251DFB231BEB231BEB231BEB231B
      EB231BEB231BEB231BEB231BEB231BEB231BEB231BEA261DFF040062585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0591251DFD241CEC241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CEC261DFF040162585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0591251DFD241CEC241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CEC261DFF040162585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0591251DFD241CEC241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CEC261DFF040162585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0591251DFD241CEC241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CEC261DFF040162585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0591251DFD241CEC241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CEC261DFF040162585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0591251DFD241CEC241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CEC261DFF040162585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0591251DFD241CEC241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CEC261DFF040162585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0591251DFD241CEC241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CEC261DFF040162585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0591251DFD241CEC241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CEC261DFF040162585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0591251DFD241CEC241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CEC261DFF040162585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0591251DFD241CEC241CED241CED241C
      ED241CED241CED241CED241CED241CED241CED241CEC261DFF040162585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360A0590251DFB231BEB231BEB231BEB231B
      EB231BEB231BEB231BEB231BEB231BEB231BEB231BEA261DFF040062585A48D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD5155360D07A22A20FF271DFF271DFF271DFF271D
      FF271DFF271DFF271DFF271DFF271DFF271DFF261DFF2C21FF06036F545840D6
      D6D6DDDDDD008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD484E3600001302023B0101340101350101350101
      3501013501013501013501013501013501013501013403023C0000007F7F7FDD
      DDDD008080008080008080008080008080008080008080008080008080008080
      008080008080008080DDDDDD7F7F7F2513442E1D482E1D492E1D492E1D492E1D
      492E1D492E1D492E1D492E1D492E1D492E1D492E1D492E1D482313427F7F7FDD
      DDDD008080008080008080008080008080008080008080008080008080008080
      008080008080008080008080DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD00
      8080008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080008080008080
      0080800080800080800080800080800080800080800080800080800080800080
      8000808000808000808000808000808000808000808000808000808000808000
      8080008080008080008080008080008080008080008080008080}
    OnClick = bnStopClick
  end
  object Label3: TLabel
    Left = 127
    Top = 58
    Width = 22
    Height = 13
    Caption = 'Stop'
  end
  object CutBtn: TSpeedButton
    Left = 105
    Top = 92
    Width = 72
    Height = 47
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      EE050000424DEE05000000000000760000002800000032000000320000000100
      0400000000007805000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFF000000000000000000000000FFFFFFFFFFFFF000000FFFFFFFFFFFF
      F0FFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF000000FFFFFFFFFFFFF0FFFFFF
      FFFFFFFFFFFFFFFF0FFFFFFFFFFFFF000000FFFFFFFFFFFFF0FFFFFFFFFFFFFF
      FFFFFFFF0FFFFFFFFFFFFF000000FFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFF
      0FFFFFFFFFFFFF000000FFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFF0FFFFFFF
      FFFFFF000000FFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF00
      0000FFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF000000FFFF
      FFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFF000000FFFFFFFFFFFF
      F0FFFFFFFFFFF0FFFFFFFFFF0FFFFFFFFFFFFF000000FFFFFFFFFFFFF0FFFFFF
      FFFF080FFFFFFFFF0FFFFFFFFFFFFF000000FFFFFFFFFFFFF0FFFFFFFFF08880
      FFFFFFFF0FFFFFFFFFFFFF000000FFFFFFFFFFFFF0FFFFFFFF0888880FFFFFFF
      0FFFFFFFFFFFFF000000FFFFFFFFFFFFF0FFFFFFF088888880FFFFFF0FFFFFFF
      FFFFFF000000FFFFFFFFFFFFF0FFFFFF08888888880FFFFF0FFFFFFFFFFFFF00
      0000FFFFFFFFFFFFF0FFFFF0888888888880FFFF0FFFFFFFFFFFFF000000FFFF
      FFFFFFFFF0FFFF088888888888880FFF0FFFFFFFFFFFFF000000FFFFFFFFFFFF
      F000F08888888888888880F00FFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF0888
      888888888888880FFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFF0000000000000
      00000000FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFF88888FFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFF88888FFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFF88888FFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFF88888FFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFF999FFFFF999
      9FF99FFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF9FFF9FFF9FFF9FF9FFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFF9FFFFF9FF9FFF9FF9FFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFF9FFFFFFFF9FFF9FF9FFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFF9FFFFFFFF9FFF9FF9FFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFF9FFFFFFFF9FFF9FF9FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFF9FFFFFFFF9FFF9F999FFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFF9FFFF
      F9FFFFFFFFF9FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF9FFF9FFFFFFF
      FFF9FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFF999FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    ParentFont = False
    OnClick = CutBtnClick
  end
  object Bevel1: TBevel
    Left = -2
    Top = 144
    Width = 299
    Height = 10
    Shape = bsBottomLine
  end
  object bnClose: TSpeedButton
    Left = 73
    Top = 169
    Width = 133
    Height = 48
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      EE050000424DEE05000000000000760000002800000032000000320000000100
      0400000000007805000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFF9999FF9FF999FFF99FFF999FFFFFFFFFFFFFF00
      0000FFFFFFFFFFFF9FFFF9F9F9FFF9F9FF9F9FFF9FFFFFFFFFFFFF000000FFFF
      FFFFFFFF9FFFFFF9F9FFF9FFF9FF9FFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      9FFFFFF9F9FFF9FF9FFF99999FFFFFFFFFFFFF000000FFFFFFFFFFFF9FFFFFF9
      F9FFF9F9FF9F9FFF9FFFFFFFFFFFFF000000FFFFFFFFFFFF9FFFFFF9FF999FFF
      99FFF999FFFFFFFFFFFFFF000000FFFFFFFFFFFF9FFFFFF9FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFF9FFFF9F9FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFF9999FF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    ParentFont = False
    ParentBiDiMode = False
    OnClick = bnCloseClick
  end
end