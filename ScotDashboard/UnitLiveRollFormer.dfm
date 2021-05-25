object FrameLiveRollFormer: TFrameLiveRollFormer
  Left = 0
  Top = 0
  Width = 242
  Height = 317
  TabOrder = 0
  object LabelRFStatus: TLabel
    Left = 239
    Top = 65
    Width = 3
    Height = 13
    Align = alTop
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PanelRFTitle: TPanel
    Left = 0
    Top = 0
    Width = 242
    Height = 65
    Align = alTop
    TabOrder = 0
    object LabelRFName: TLabel
      Left = 1
      Top = 1
      Width = 84
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'LabelRFName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelJobName: TLabel
      Left = 1
      Top = 30
      Width = 82
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'LabelJobName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelDayMeters: TLabel
      Left = 1
      Top = 17
      Width = 65
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Day Meters'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelFrameName: TLabel
      Left = 1
      Top = 43
      Width = 131
      Height = 18
      Align = alTop
      Alignment = taCenter
      Caption = 'LabelFrameName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object MemoItems: TMemo
    Left = 0
    Top = 78
    Width = 242
    Height = 239
    Align = alClient
    TabOrder = 1
  end
end
