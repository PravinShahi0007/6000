inherited MDIChildRFStatus: TMDIChildRFStatus
  Caption = 'Dashboard'
  ClientHeight = 837
  ClientWidth = 1327
  OnCreate = FormCreate
  ExplicitWidth = 1343
  ExplicitHeight = 876
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 857
    Top = 0
    Width = 2
    Height = 837
    ExplicitLeft = 657
  end
  object PanelRight: TPanel
    Left = 859
    Top = 0
    Width = 468
    Height = 837
    Align = alClient
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 297
      Width = 466
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 106
      ExplicitWidth = 510
    end
    object Splitter5: TSplitter
      Left = 1
      Top = 598
      Width = 466
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 322
      ExplicitWidth = 294
    end
    object GroupBoxRollFormerRunningTime: TGroupBox
      Left = 1
      Top = 1
      Width = 466
      Height = 296
      Align = alTop
      Caption = 'RollFormer Running Time'
      TabOrder = 0
      object DBChartRFRuningTime: TDBChart
        Left = 2
        Top = 15
        Width = 462
        Height = 279
        Title.Font.Height = -16
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'RollFormer Running Time(Hours)')
        Legend.Visible = False
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          37
          15
          37)
        ColorPaletteIndex = 13
        object Series1: TBarSeries
          ColorEachPoint = True
          Marks.Visible = False
          DataSource = DMRFStatus.FDMemTableProductionByRollFormer
          PercentFormat = 'hh:mm'
          Title = 'SeriesRunningTime'
          Transparency = 28
          ValueFormat = '0'
          XLabelsSource = 'ROLLFORMERID'
          GradientRelative = True
          Sides = 98
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'ROLLFORMERID'
          YValues.Name = 'Bar'
          YValues.Order = loNone
          YValues.ValueSource = 'RUNTIME'
        end
      end
    end
    object GroupBoxRollFormerProduceMeters: TGroupBox
      Left = 1
      Top = 300
      Width = 466
      Height = 298
      Align = alTop
      Caption = 'RollFormer produce meters'
      TabOrder = 1
      object DBChartRFProducedMeters: TDBChart
        Left = 2
        Top = 15
        Width = 462
        Height = 281
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
          DataSource = DMRFStatus.FDMemTableProductionByRollFormer
          Title = 'SeriesRollFormerMeters'
          ValueFormat = '#,##0.00;(#,##0.00)'
          XLabelsSource = 'ROLLFORMERID'
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'ROLLFORMERID'
          YValues.Name = 'Bar'
          YValues.Order = loNone
          YValues.ValueSource = 'METERS'
        end
      end
    end
    object GroupBoxPauseTime: TGroupBox
      Left = 1
      Top = 601
      Width = 466
      Height = 235
      Align = alClient
      Caption = 'Pause Time'
      TabOrder = 2
      object DBChartProductionByRF: TDBChart
        Left = 2
        Top = 15
        Width = 462
        Height = 218
        Title.Text.Strings = (
          'Pause Time')
        View3D = False
        Align = alClient
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          30
          15
          30)
        ColorPaletteIndex = 13
        object Series5: TBarSeries
          ColorEachPoint = True
          DataSource = DMRFStatus.FDMemTableProductionByRollFormer
          XLabelsSource = 'ROLLFORMERID'
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'ROLLFORMERID'
          YValues.Name = 'Bar'
          YValues.Order = loNone
          YValues.ValueSource = 'PAUSETIME'
        end
      end
    end
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 0
    Width = 857
    Height = 837
    Align = alLeft
    TabOrder = 1
    object Splitter4: TSplitter
      Left = 1
      Top = 478
      Width = 855
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 433
      ExplicitWidth = 729
    end
    object GroupBoxProductionByCard: TGroupBox
      Left = 1
      Top = 257
      Width = 855
      Height = 221
      Align = alTop
      Caption = 'Production By Card'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object JvDBGridProductionByCard: TJvDBGrid
        Left = 2
        Top = 18
        Width = 851
        Height = 201
        Align = alClient
        DataSource = DMRFStatus.DataSourceProductionByCard
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnCellClick = JvDBGridRFStatusCellClick
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 20
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CARDNUMBER'
            ReadOnly = True
            Title.Alignment = taCenter
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ORIGINMETERS'
            ReadOnly = True
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REMAINMETERS'
            ReadOnly = True
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'METERS'
            ReadOnly = True
            Visible = True
          end>
      end
    end
    object GroupBoxProductionByRF: TGroupBox
      Left = 1
      Top = 1
      Width = 855
      Height = 256
      Align = alTop
      Caption = 'Production By RollFormer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object JvDBGridProductionByRF: TJvDBGrid
        Left = 2
        Top = 18
        Width = 851
        Height = 236
        Align = alClient
        DataSource = DMRFStatus.DataSourceProductionByRF
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnCellClick = JvDBGridRFStatusCellClick
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 20
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ROLLFORMERID'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'ROLLFORMER'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RUNSECONDS'
            ReadOnly = True
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PAUSETIME'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'METERS'
            ReadOnly = True
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CUTS'
            ReadOnly = True
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SWAGE'
            ReadOnly = True
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOTCH'
            ReadOnly = True
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FLAT'
            ReadOnly = True
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FPUNCH'
            ReadOnly = True
            Visible = True
          end>
      end
    end
    object GroupBoxJob: TGroupBox
      Left = 1
      Top = 481
      Width = 855
      Height = 355
      Align = alClient
      Caption = 'RollFormer Status'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object JvDBGridRFStatus: TJvDBGrid
        Left = 2
        Top = 18
        Width = 851
        Height = 335
        Align = alClient
        DataSource = DMRFStatus.DataSourceRFDateInfo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnCellClick = JvDBGridRFStatusCellClick
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 20
        Columns = <
          item
            Expanded = False
            FieldName = 'ROLLFORMERID'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'ROLLFORMER'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CARDNUMBER'
            ReadOnly = True
            Title.Alignment = taCenter
            Width = 106
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ORIGINMETERS'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'Start Meters'
            Width = 110
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'REMAINMETERS'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'Remain Meters'
            Width = 110
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RUNSECONDS'
            ReadOnly = True
            Title.Alignment = taCenter
            Width = 82
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'METERS'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RFINFODATE'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'DATE'
            Width = 60
            Visible = True
          end>
      end
    end
  end
end
