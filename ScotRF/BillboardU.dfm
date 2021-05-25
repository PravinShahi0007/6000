object Billboard: TBillboard
  Left = 0
  Top = 0
  Width = 143
  Height = 316
  TabOrder = 0
  OnResize = FrameResize
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 143
    Height = 316
    Align = alClient
    Color = clCream
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      143
      316)
    object Label1: TLabel
      Left = 0
      Top = 286
      Width = 64
      Height = 16
      Anchors = [akLeft, akBottom]
      Caption = '----------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ExplicitTop = 134
    end
  end
end
