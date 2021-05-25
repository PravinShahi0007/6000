inherited MDIChildRFLiveStatus: TMDIChildRFLiveStatus
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsNone
  Caption = 'RollFormer Live Status'
  ClientHeight = 745
  ClientWidth = 1126
  ParentBiDiMode = False
  OnCreate = FormCreate
  ExplicitWidth = 1142
  ExplicitHeight = 784
  PixelsPerInch = 96
  TextHeight = 13
  object DBChartLiveProduction: TDBChart
    Left = 0
    Top = 297
    Width = 1126
    Height = 448
    Title.Font.Height = -16
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'RollFormer Production Meters')
    Align = alClient
    TabOrder = 0
    DefaultCanvas = 'TGDIPlusCanvas'
    PrintMargins = (
      15
      37
      15
      37)
    ColorPaletteIndex = 13
    object BarSeries1: TBarSeries
      ColorEachPoint = True
      Marks.Visible = False
      DataSource = DMRFStatus.FDMemTableProductionByRollFormer
      PercentFormat = '0.0%'
      Title = 'SeriesRunningTime'
      Transparency = 28
      ValueFormat = '#,##0.00M;(#,##0.00)'
      XLabelsSource = 'ROLLFORMERID'
      GradientRelative = True
      Sides = 98
      XValues.Name = 'X'
      XValues.Order = loAscending
      XValues.ValueSource = 'ROLLFORMERID'
      YValues.Name = 'Bar'
      YValues.Order = loNone
      YValues.ValueSource = 'METERS'
    end
  end
  object ScrollBoxRFStatus: TScrollBox
    Left = 0
    Top = 0
    Width = 1126
    Height = 297
    Align = alTop
    TabOrder = 1
  end
end
