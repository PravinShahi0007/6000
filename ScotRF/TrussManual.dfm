object TrussManualForm: TTrussManualForm
  Left = 243
  Top = 268
  ParentCustomHint = False
  AutoSize = True
  BiDiMode = bdLeftToRight
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Manual Operation'
  ClientHeight = 60
  ClientWidth = 548
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object CutBtn: TSpeedButton
    Left = 0
    Top = 0
    Width = 61
    Height = 60
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
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
      FF000000FFFFFFFFFFF000000FFFFFFFFFFFFF000000FFFFFFFFFFFFFF0FFFF0
      FFFFFFFFFFF0FFFF0FFFFFFFFFFFFF000000FFFFFFFFFFFFFF0FFFF0FFFFFFFF
      FFF0FFFF0FFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF0FFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF0FFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF0FFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF0FFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFF0FFFFFFFFFFF0FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFF0FFFFF0FFFFF0FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFF0
      FFFF070FFFF0FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFF0FFF07770
      FFF0FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFF0FF0777770FF0FFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFF0000000000000FFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFF07777777770FFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFF0777777777770FFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFF077777777777770FFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFF07777777777777770FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF0777
      777777777777770FFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFF0000000000000
      00000000FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFF77777FFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFF77777FFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFF77777FFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFF77777FFFFFFFFFFFFFFFFFFFFFF000000FFFF
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
    ParentBiDiMode = False
    OnClick = CutBtnClick
    ExplicitHeight = 59
  end
  object CopeBtn: TSpeedButton
    Left = 122
    Top = 0
    Width = 58
    Height = 60
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
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
      0000FFFFFFFFFFFFFF000000FFFFFFFFFFF000000FFFFFFFFFFFFF000000FFFF
      FFFFFFFFFF077770FFFFFFFFFFF077770FFFFFFFFFFFFF000000FFFFFFFFFFFF
      FF077770FFFFFFFFFFF077770FFFFFFFFFFFFF000000FFFFFFFFFFFFFF077770
      FFFFFFFFFFF077770FFFFFFFFFFFFF000000FFFFFFFFFFFFFF077770FFFFFFFF
      FFF077770FFFFFFFFFFFFF000000FFFFFFFFFFFFFF0777700FFFFFFFFF007777
      0FFFFFFFFFFFFF000000FFFFFFFFFFFFFF0777700FFFFFFFFF0077770FFFFFFF
      FFFFFF000000FFFFFFFFFFFFFF0777700FFFFFFFFF0077770FFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFF0777700FFFFFFFFF0077770FFFFFFFFFFFFF000000FFFF
      FFFFFFFFFF0777700FFFFFFFFF0077770FFFFFFFFFFFFF000000FFFFFFFFFFFF
      FF0777700FFFFFFFFF0077770FFFFFFFFFFFFF000000FFFFFFFFFFFFFF077770
      0FFFFFFFFF0077770FFFFFFFFFFFFF000000FFFFFFFFFFFFFF0777700FFFFFFF
      FF0077770FFFFFFFFFFFFF000000FFFFFFFFFFFFFF0000000FFFFFFFFF000000
      0FFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFF00000000000FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFF9FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFF9
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFF999FFFFF999FFF9F99FFFF9
      99FFFFFFFFFFFF000000FFFFFFFFFFFF9FFF9FFF9FFF9FF99FF9FF9FFF9FFFFF
      FFFFFF000000FFFFFFFFFFF9FFFFF9FF9FFF9FF9FFF9FF9FFFFFFFFFFFFFFF00
      0000FFFFFFFFFFF9FFFFFFFF9FFF9FF9FFF9FF99999FFFFFFFFFFF000000FFFF
      FFFFFFF9FFFFFFFF9FFF9FF9FFF9FF9FFF9FFFFFFFFFFF000000FFFFFFFFFFF9
      FFFFFFFF9FFF9FF99FF9FF9FFF9FFFFFFFFFFF000000FFFFFFFFFFF9FFFFFFFF
      F999FFF9F99FFFF999FFFFFFFFFFFF000000FFFFFFFFFFF9FFFFF9FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF9FFF9FFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFF999FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    ParentFont = False
    ParentBiDiMode = False
    OnClick = CopeBtnClick
    ExplicitLeft = 65
    ExplicitHeight = 59
  end
  object NotchBtn: TSpeedButton
    Left = 61
    Top = 0
    Width = 61
    Height = 60
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
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
      FFFFFFFFFFF000000FFFFFFFFF000000FFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFF0FFFF0FFFFFFFFF0FFFF0FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFF0FFFF
      0FFFFFFFFF0FFFF0FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF0FFFFFFF
      FF0FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFF00000000000FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      00777777700FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF00777777
      700FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF00777777700FFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFF077777770FFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFF077777770FFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFF077777770FFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFF077777770FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFF077777770FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      F000000000FFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFF9FFFFF9FFF999FFF99F
      FF999FFF9FFF9FFFFFFFFF000000FFFFFFFFF9FFFF99FF9FFF9FF9FFF9FFF9FF
      9FFF9FFFFFFFFF000000FFFFFFFFF9FFF9F9FF9FFF9FF9FFF9FFFFFF9FFF9FFF
      FFFFFF000000FFFFFFFFF9FFF9F9FF9FFF9FF9FFF9FFFFFF9FFF9FFFFFFFFF00
      0000FFFFFFFFF9FF9FF9FF9FFF9FF9FFF9FFFFFF9FFF9FFFFFFFFF000000FFFF
      FFFFF9FF9FF9FF9FFF9FF9FFF9FFF9FF99FF9FFFFFFFFF000000FFFFFFFFF9F9
      FFF9FFF999FF999FFF999FFF9F99FFFFFFFFFF000000FFFFFFFFF9F9FFF9FFFF
      FFFFF9FFFFFFFFFF9FFFFFFFFFFFFF000000FFFFFFFFF99FFFF9FFFFFFFFF9FF
      FFFFFFFF9FFFFFFFFFFFFF000000FFFFFFFFF9FFFFF9FFFFFFFFFFFFFFFFFFFF
      9FFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    ParentFont = False
    ParentBiDiMode = False
    OnClick = NotchBtnClick
    ExplicitLeft = 127
    ExplicitHeight = 59
  end
  object LipHoleBtn: TSpeedButton
    Left = 180
    Top = 0
    Width = 61
    Height = 60
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
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
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFF00000
      0FFFFFFFFF000000FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFF0FFFF0FFFFFFF
      FF0FFFF0FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFF0FFFF0FFFFFFFFF0FFFF0
      FFFFFFFFFFFFFF000000FFFFFF0000000000000F0FFFFFFFFF0F000000000000
      00FFFF000000FFFFFF0777777777770000FFFFFFF00007777777777770FFFF00
      0000FFFFFF0777777777770000FFFFFFF00007777777777770FFFF000000FFFF
      FF0000000000000F0FFFFFFFFF0F00000000000000FFFF000000FFFFFFFFFFFF
      FFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF0FFFFFFF
      FF0FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFF00000000000FFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF999999F9
      FF9F99FFFFFFF9FFF9FFF999FFF9FFF999FFFF000000FFFF9FFFFFF9FF99FF9F
      FFFFF9FFF9FF9FFF9FF9FF9FFF9FFF000000FFFF9FFFFFF9FF9FFF9FFFFFF9FF
      F9FF9FFF9FF9FF9FFFFFFF000000FFFF9FFFFFF9FF9FFF9FFFFFF9FFF9FF9FFF
      9FF9FF99999FFF000000FFFF9FFFFFF9FF9FFF9FFFFFF9FFF9FF9FFF9FF9FF9F
      FF9FFF000000FFFF9FFFFFF9FF99FF9FFFFFF99FF9FF9FFF9FF9FF9FFF9FFF00
      0000FFFF9FFFFFF9FF9F99FFFFFFF9F99FFFF999FFF9FFF999FFFF000000FFFF
      9FFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFF9FFFFFFFFFF000000FFFF9FFFFFFF
      FFFFFFFFFFFFF9FFFFFFFFFFFFF9FFFFFFFFFF000000FFFF9FFFFFF9FFFFFFFF
      FFFFF9FFFFFFFFFFFFF9FFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    ParentFont = False
    ParentBiDiMode = False
    OnClick = LipHoleBtnClick
    ExplicitLeft = 257
    ExplicitHeight = 59
  end
  object FlangeHoleBtn: TSpeedButton
    Left = 241
    Top = 0
    Width = 61
    Height = 60
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
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
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFF00000
      0FFFFFFFFF000000FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFF0FFFF0FFFFFFF
      FF0FFFF0FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFF0FFFF0FFFFFFFFF0FFFF0
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFFFF7777777777777F
      0FFFFFFFFF0F7777777777777FFFFF000000FFFFFF7777777777777000FFFFFF
      F0007777777777777FFFFF000000FFFFFF7777777777777000FFFFFFF0007777
      777777777FFFFF000000FFFFFF7777777777777F0FFFFFFFFF0F777777777777
      7FFFFF000000FFFFFFFFFFFFFFFFFFFF00000000000FFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFF999FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFF9FFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFF9
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF9FFFFFFF9FFF99F9FFFFFF9F
      FF9FFF999FFF9FFF999FFF000000FFFF9FFFFFFF9FF9FF99FFFFFF9FFF9FF9FF
      F9FF9FF9FFF9FF000000FFFF9FFFFFFF9FF9FFF9FFFFFF9FFF9FF9FFF9FF9FF9
      FFFFFF000000FFFF9FFFFFFF9FF9FFF9FFFFFF9FFF9FF9FFF9FF9FF99999FF00
      0000FFFF9FFFFFFF9FF9FFF9FFFFFF9FFF9FF9FFF9FF9FF9FFF9FF000000FFFF
      99999FFF9FF9FF99FFFFFF99FF9FF9FFF9FF9FF9FFF9FF000000FFFF9FFFFFFF
      9FFF99F9FFFFFF9F99FFFF999FFF9FFF999FFF000000FFFF9FFFFFFF9FFFFFFF
      FFFFFF9FFFFFFFFFFFFF9FFFFFFFFF000000FFFF9FFFFFFF9FFFFFFFFFFFFF9F
      FFFFFFFFFFFF9FFFFFFFFF000000FFFF999999FF9FFFFFFFFFFFFF9FFFFFFFFF
      FFFF9FFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    ParentFont = False
    ParentBiDiMode = False
    OnClick = FlangeHoleBtnClick
    ExplicitLeft = 285
  end
  object BoxHoleBtn: TSpeedButton
    Left = 302
    Top = 0
    Width = 61
    Height = 60
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
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
      FFFFFF000000FFFFFFFFFFFFFFFFFFFF00000000000FFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFFFFFF7777
      77777FFF0FFFFFFFFF0FFF7777777777FFFFFF000000FFFFFFFF777777777FFF
      0FFFFFFFFF0FFF7777777777FFFFFF000000FFFFFFFF77777777700F0FFFFFFF
      FF0F007777777777FFFFFF000000FFFFFFFF777777777FFF0FFFFFFFFF0FFF77
      77777777FFFFFF000000FFFFFFFF777777777FFF0FFFFFFFFF0FFF7777777777
      FFFFFF000000FFFFFFFF777777777FFF0FFFFFFFFF0FFF7777777777FFFFFF00
      0000FFFFFFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFF0FFFFFFFFF0FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFF0000FFF0000FFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFF9FFFFFFFFF9999FF9FFF9
      FFF999FFF9FFF9FFFFFFFF000000FFFFFFF9FFFFFFFF9FFF9FF9FFF9FF9FFF9F
      F9FFF9FFFFFFFF000000FFFFFFF9FFFFFFFF9FFF9FF9FFF9FF9FFFFFF9FFF9FF
      FFFFFF000000FFFFFFF9FFFFFFFF9FFF9FF9FFF9FF9FFFFFF9FFF9FFFFFFFF00
      0000FFFFFFF999999FFF9FFF9FF9FFF9FF9FFFFFF9FFF9FFFFFFFF000000FFFF
      FFF9FFFFF9FF9FFF9FF99FF9FF9FFF9FF99FF9FFFFFFFF000000FFFFFFF9FFFF
      F9FF9FFF9FF9F99FFFF999FFF9F99FFFFFFFFF000000FFFFFFF9FFFFF9FFFFFF
      FFFFFFFFFFFFFFFFF9FFFFFFFFFFFF000000FFFFFFF9FFFFF9FFFFFFFFFFFFFF
      FFFFFFFFF9FFFFFFFFFFFF000000FFFFFFF999999FFFFFFFFFFFFFFFFFFFFFFF
      F9FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    ParentFont = False
    ParentBiDiMode = False
    OnClick = BoxHoleBtnClick
    ExplicitLeft = 446
    ExplicitTop = 7
  end
  object ExitBtn: TSpeedButton
    Left = 487
    Top = 0
    Width = 61
    Height = 60
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
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
    OnClick = ExitBtnClick
    ExplicitLeft = 434
  end
  object LoadBtn: TSpeedButton
    Left = 424
    Top = 0
    Width = 63
    Height = 60
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFF0000
      0FFFFF000000FFFFFFFFFFFFFFFFF0888880FFFFFFFFFFFFFFF0888880FFFF00
      0000FFFFFFFFFFFFFFFF088888880FFFFFFFFFFFFF088888880FFF000000FFFF
      FFFFFFFFFFF08888888880FFFFFFFFFFF08888888880FF000000FFFFFFFFFFFF
      FFF08888888880FFFFFFFFFFF08888888880FF000000FFFFFFFFFFFFFFF08888
      888880FFFFFFFFFFF08888888880FF000000FFFFFFFFFFFFFFF08888888880FF
      FFFFFFFFF08888888880FF000000FFFFFFFFFFFFFFFF088888880FFFFFFFFFFF
      FF088888880FFF000000FFFFFFFFFFFFFFFFF0888880FFFFFFFFFFFFFFF08888
      80FFFF000000FFFFFFFFFFFFFFFFFF00000FFFFFFFFFFFFFFFFF00000FFFFF00
      00000FF0FFF00000000000000000000000000000000000000000000000000FF0
      FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FF0FFF0FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FF0FFF0FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FF0FFF0FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF0000000FF0FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF0000000FF0FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF0000000FF0FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      00000FF0FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FF0
      FFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FF0FFF0FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FF0FFF0FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000FF0FFF0FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF0000000FF0FFF00000000000000000000000000000
      00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF99
      9999FF999FFFF99F9FFF9999FFFFFFFFFFFFFF000000FFFFFFFFFF9FFFFFF9FF
      F9FF9FF99FF9FFF9FFFFFFFFFFFFFF000000FFFFFFFFFF9FFFFFF9FFF9FF9FFF
      9FF9FFF9FFFFFFFFFFFFFF000000FFFFFFFFFF9FFFFFF9FFF9FFF9999FF9FFF9
      FFFFFFFFFFFFFF000000FFFFFFFFFF9FFFFFF9FFF9FFFFFF9FF9FFF9FFFFFFFF
      FFFFFF000000FFFFFFFFFF9FFFFFF9FFF9FF9FFF9FF9FF99FFFFFFFFFFFFFF00
      0000FFFFFFFFFF9FFFFFFF999FFFF999FFFF99F9FFFFFFFFFFFFFF000000FFFF
      FFFFFF9FFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFF000000FFFFFFFFFF9F
      FFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFF000000FFFFFFFFFF9FFFFFFFFF
      FFFFFFFFFFFFFFF9FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
    ParentFont = False
    ParentBiDiMode = False
    OnClick = LoadBtnClick
    ExplicitLeft = 367
  end
  object SwageBtn: TSpeedButton
    Left = 363
    Top = 0
    Width = 61
    Height = 60
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
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
      FFF888FF00000000000000000000000000FF888FFFFFFF000000FFFFFFF888FF
      0FFFFFFFFFFFFFFFFFFFFFFFF0FF888FFFFFFF000000FFFFFFF888FF0FFFFFFF
      FFFFFFFFFFFFFFFFF0FF888FFFFFFF000000FFFFFFF888FF0FFFFFFFFFFFFFFF
      FFFFFFFFF0FF888FFFFFFF000000FFFFFFF888FF0FFFFFFFFFFFFFFFFFFFFFFF
      F0FF888FFFFFFF000000FF00000888FF0FFFFFFFFFFFFFFFFFFFFFFFF0FF888F
      FFFFFF000000FF08880888FF0FFFFFFFFFFFFFFFFFFFFFFFF0FF88800000FF00
      0000FF08880888FF0FFFFFFFFFFFFFFFFFFFFFFFF0FF88808880FF000000FF08
      880888FF0FFFFFFFFFFFFFFFFFFFFFFFF0FF88808880FF000000FF08880888FF
      0FFFFFFFFFFFFFFFFFFFFFFFF0FF88808880FF000000FF08880888FF0FFFFFFF
      FFFFFFFFFFFFFFFFF0FF88808880FF000000FF00000888FF0FFFFFFFFFFFFFFF
      FFFFFFFFF0FF88800000FF000000FFFFFFF888FF0FFFFFFFFFFFFFFFFFFFFFFF
      F0FF888FFFFFFF000000FFFFFFF888FF0FFFFFFFFFFFFFFFFFFFFFFFF0FF888F
      FFFFFF000000FFFFFFF888FF0FFFFFFFFFFFFFFFFFFFFFFFF0FF888FFFFFFF00
      0000FFFFFFF888FF0FFFFFFFFFFFFFFFFFFFFFFFF0FF888FFFFFFF000000FFFF
      FFF888FF0FFFFFFFFFFFFFFFFFFFFFFFF0FF888FFFFFFF000000FFFFFFF888FF
      000FFFFFFFFFFFFFFFFFFFF000FF888FFFFFFF000000FFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF999FFFFFFFF
      FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFF9FFFFFFFFFFFFF00
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFF9FFFFFFFFFFFFF000000FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFF000000FFFFFFFF9999
      9FFFF9FFF9FFFF99F9FFF99F9FFF999FFFFFFF000000FFFFFFF9FFFFF9FFF9FF
      F9FFF9FF99FF9FF99FF9FFF9FFFFFF000000FFFFFFF9FFFFF9FF9F9F9F9FF9FF
      F9FF9FFF9FF9FFFFFFFFFF000000FFFFFFFFFFFFF9FF9F9F9F9FFF9999FF9FFF
      9FF99999FFFFFF000000FFFFFFFFFFF99FFF9F9F9F9FFFFFF9FF9FFF9FF9FFF9
      FFFFFF000000FFFFFFFF999FFFF9FFF9FFF9F9FFF9FF9FF99FF9FFF9FFFFFF00
      0000FFFFFFF9FFFFFFF9FFF9FFF9FF999FFFF99F9FFF999FFFFFFF000000FFFF
      FFF9FFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFF9FFFF
      F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFF99999FFFFFFF
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
    OnClick = SwageBtnClick
    ExplicitLeft = 310
  end
end