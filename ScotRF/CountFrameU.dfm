object CounterFrame: TCounterFrame
  Left = 0
  Top = 0
  Width = 369
  Height = 37
  Color = clWhite
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object uxCaption: TLabel
    Left = 3
    Top = 6
    Width = 110
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Guillotene'
  end
  object bnReset: TSpeedButton
    Left = 299
    Top = 3
    Width = 45
    Height = 21
    Caption = 'Reset'
    OnClick = bnResetClick
  end
  object uxCount: TEdit
    Left = 140
    Top = 3
    Width = 53
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 0
  end
  object uxWarning: TEdit
    Left = 227
    Top = 3
    Width = 53
    Height = 21
    TabOrder = 1
  end
end
