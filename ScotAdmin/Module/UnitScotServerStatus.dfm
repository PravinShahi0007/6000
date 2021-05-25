inherited FrameScotServerStatus: TFrameScotServerStatus
  inherited PanelServiceStatus: TPanel
    inherited SpeedButtonStartServer: TSpeedButton
      OnClick = SpeedButtonStartServerClick
    end
    object LabelIPAddress: TLabel
      Left = 176
      Top = 1
      Width = 5
      Height = 18
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  inherited FDMemTableServerInfo: TFDMemTable
    Left = 272
  end
end
