inherited MDIChildRFHistory: TMDIChildRFHistory
  Caption = 'MDIChildRFHistory'
  ClientHeight = 620
  ClientWidth = 1149
  OnCreate = FormCreate
  ExplicitWidth = 1165
  ExplicitHeight = 659
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 633
    Top = 0
    Height = 620
    ExplicitLeft = 432
    ExplicitTop = 240
    ExplicitHeight = 100
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 620
    Align = alLeft
    Caption = 'PanelLeft'
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 1
      Top = 317
      Width = 631
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 1
      ExplicitWidth = 319
    end
    object DBGridRollFormer: TDBGrid
      Left = 1
      Top = 1
      Width = 631
      Height = 316
      Align = alClient
      DataSource = DMDesignJob.DataSourceRollFormer
      PopupMenu = PopupMenuRFHistory
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = DBGridRollFormerCellClick
      OnKeyUp = DBGridRollFormerKeyUp
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 320
      Width = 631
      Height = 299
      Align = alBottom
      DataSource = DMDesignJob.DataSourceDailyProduction
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ROLLFORMERID'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRODUCEDON'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Meters'
          Visible = True
        end>
    end
  end
  object PanelRight: TPanel
    Left = 636
    Top = 0
    Width = 513
    Height = 620
    Align = alClient
    TabOrder = 1
    object DBChartRFProducedMeters: TDBChart
      Left = 1
      Top = 1
      Width = 511
      Height = 618
      AutoRefresh = False
      Title.Font.Height = -16
      Title.Font.Style = [fsBold]
      Title.Text.Strings = (
        'RollFormer produce meters')
      TopAxis.LabelStyle = talText
      TopAxis.Title.Visible = False
      View3D = False
      View3DOptions.Elevation = 315
      View3DOptions.Orthogonal = False
      View3DOptions.Perspective = 0
      View3DOptions.Rotation = 360
      Align = alClient
      TabOrder = 0
      DefaultCanvas = 'TGDIPlusCanvas'
      ColorPaletteIndex = 13
      object Series2: TBarSeries
        ColorEachPoint = True
        Marks.Visible = False
        DataSource = DMDesignJob.FDMemTableROLLFORMERIDItemProduction
        Title = 'SeriesRollFormerMeters'
        ValueFormat = '#,##0.00;(#,##0.00)'
        XLabelsSource = 'PRODUCEDON'
        XValues.Name = 'X'
        XValues.Order = loAscending
        XValues.ValueSource = 'ROLLFORMERID'
        YValues.Name = 'Bar'
        YValues.Order = loNone
        YValues.ValueSource = 'Meters'
      end
    end
  end
  object PopupMenuRFHistory: TPopupMenu
    Left = 568
    Top = 8
    object ActionLoadEP21: TMenuItem
      Action = FormScotDashBoard.ActionLoadEP2
    end
  end
end
