object CardApi: TCardApi
  OldCreateOrder = False
  Height = 150
  Width = 215
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Tick
    Left = 40
    Top = 80
  end
end
