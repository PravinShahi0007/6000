object FormJobSelection: TFormJobSelection
  Left = 0
  Top = 0
  Caption = 'Job Selection'
  ClientHeight = 658
  ClientWidth = 1560
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 0
    Top = 271
    Width = 1560
    Height = 8
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 281
    ExplicitWidth = 1222
  end
  object PanelJob: TPanel
    Left = 0
    Top = 0
    Width = 1560
    Height = 271
    Align = alTop
    TabOrder = 0
    object Splitter6: TSplitter
      Left = 1164
      Top = 1
      Height = 269
      ExplicitLeft = 608
      ExplicitTop = 48
      ExplicitHeight = 100
    end
    object Splitter7: TSplitter
      Left = 564
      Top = 1
      Height = 269
      ExplicitLeft = 446
      ExplicitHeight = 191
    end
    object GroupBoxSelectedJobDetails: TGroupBox
      Left = 567
      Top = 1
      Width = 597
      Height = 269
      Align = alLeft
      Caption = 'Selected Job &EP2 Files'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object JvDBGridEP2FILES: TJvDBGrid
        Left = 2
        Top = 21
        Width = 593
        Height = 225
        Align = alClient
        DataSource = DMDesignJob.DataSourceEP2File
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenuEP2Transfer
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnDrawColumnCell = JvDBGridEP2FILESDrawColumnCell
        OnDblClick = JvDBGridEP2FILESDblClick
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'JOBID'
            Title.Alignment = taCenter
            Width = 50
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'EP2FILEID'
            Title.Alignment = taCenter
            Title.Caption = 'FILEID'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EP2FILE'
            ReadOnly = True
            Width = 307
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Percentage'
            Width = 0
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CountDisplay'
            Title.Alignment = taCenter
            Title.Caption = 'Total Frames Produced'
            Visible = True
          end>
      end
      object PanelGauge: TPanel
        Left = 2
        Top = 246
        Width = 593
        Height = 21
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object LabelGaugeCaption: TLabel
          Left = 468
          Top = 1
          Width = 69
          Height = 19
          Align = alRight
          Alignment = taCenter
          AutoSize = False
          Caption = 'Gauge'
          ExplicitLeft = 304
        end
        object EditTrussGauge: TComboBox
          Left = 537
          Top = 1
          Width = 55
          Height = 21
          Align = alRight
          TabOrder = 0
          Text = '22'
          OnChange = EditTrussGaugeChange
          Items.Strings = (
            '16'
            '18'
            '20'
            '22'
            '24'
            '55'
            '75'
            '95'
            '115'
            '160'
            '01')
        end
      end
    end
    object GroupBoxFrameDrawing: TGroupBox
      Left = 1167
      Top = 1
      Width = 392
      Height = 269
      Align = alClient
      Caption = 'Selected Frame'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object PaintBoxFrame: TPaintBox
        Left = 2
        Top = 21
        Width = 388
        Height = 246
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        OnPaint = PaintBoxFramePaint
        ExplicitTop = 40
        ExplicitWidth = 396
        ExplicitHeight = 149
      end
    end
    object GroupBoxJobList: TGroupBox
      Left = 1
      Top = 1
      Width = 563
      Height = 269
      Align = alLeft
      Caption = '&Job List'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object JvDBGridDesignJob: TJvDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 59
        Width = 553
        Height = 167
        Align = alClient
        DataSource = DataSourceJob
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenuJobTransfer
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -16
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 23
        Columns = <
          item
            Expanded = False
            FieldName = 'JOBID'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'JOBNAME'
            Width = 429
            Visible = True
          end>
      end
      object PanelDateRange: TPanel
        Left = 2
        Top = 21
        Width = 559
        Height = 35
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Visible = False
        object CalendarPickerStart: TCalendarPicker
          Left = 1
          Top = 1
          Width = 129
          Height = 33
          ParentCustomHint = False
          Align = alLeft
          BiDiMode = bdLeftToRight
          CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
          CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
          CalendarHeaderInfo.DaysOfWeekFont.Height = -13
          CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
          CalendarHeaderInfo.DaysOfWeekFont.Style = []
          CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
          CalendarHeaderInfo.Font.Color = clWindowText
          CalendarHeaderInfo.Font.Height = -20
          CalendarHeaderInfo.Font.Name = 'Segoe UI'
          CalendarHeaderInfo.Font.Style = []
          Color = clWindow
          Date = 43346.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          IsEmpty = False
          OnChange = CalendarPickerStartChange
          ParentBiDiMode = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          TextHint = 'select a date'
          Visible = False
        end
        object CalendarPickerEnd: TCalendarPicker
          Left = 130
          Top = 1
          Width = 127
          Height = 33
          Align = alLeft
          CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
          CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
          CalendarHeaderInfo.DaysOfWeekFont.Height = -13
          CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
          CalendarHeaderInfo.DaysOfWeekFont.Style = []
          CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
          CalendarHeaderInfo.Font.Color = clWindowText
          CalendarHeaderInfo.Font.Height = -20
          CalendarHeaderInfo.Font.Name = 'Segoe UI'
          CalendarHeaderInfo.Font.Style = []
          Color = clWindow
          Date = 43346.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          IsEmpty = False
          OnChange = CalendarPickerEndChange
          ParentFont = False
          TabOrder = 1
          TextHint = 'select a date'
        end
      end
      object MemoJobTransferInfo: TMemo
        Left = 2
        Top = 229
        Width = 559
        Height = 38
        Align = alBottom
        Color = clMenu
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Visible = False
      end
    end
  end
  object PanelFrames: TPanel
    Left = 0
    Top = 279
    Width = 1560
    Height = 337
    Align = alClient
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 890
      Top = 1
      Width = 5
      Height = 318
      ExplicitLeft = 496
      ExplicitHeight = 410
    end
    object DBTextFrameEP2File: TDBText
      Left = 1
      Top = 319
      Width = 1558
      Height = 17
      Align = alBottom
      DataField = 'EP2FILE'
      DataSource = DMDesignJob.DataSourceFrame
      ExplicitLeft = 536
      ExplicitTop = 152
      ExplicitWidth = 65
    end
    object Splitter3: TSplitter
      Left = 1119
      Top = 1
      Height = 318
      ExplicitLeft = 560
      ExplicitTop = 88
      ExplicitHeight = 100
    end
    object Splitter5: TSplitter
      Left = 641
      Top = 1
      Height = 318
      ExplicitLeft = 385
      ExplicitHeight = 330
    end
    object Splitter8: TSplitter
      Left = 561
      Top = 1
      Height = 318
      ExplicitHeight = 330
    end
    object GroupBoxSelectedFrames: TGroupBox
      Left = 1
      Top = 1
      Width = 560
      Height = 318
      Align = alLeft
      Caption = 'Selected &Frames'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object JvDBGridFrame: TJvDBGrid
        Left = 2
        Top = 21
        Width = 556
        Height = 295
        Align = alClient
        DataSource = DMDesignJob.DataSourceFrame
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = JvDBGridFrameCellClick
        OnDrawColumnCell = JvDBGridFrameDrawColumnCell
        OnDblClick = JvDBGridFrameDblClick
        OnKeyDown = JvDBGridFrameKeyDown
        MultiSelect = True
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'FRAMENAME'
            ReadOnly = True
            Title.Caption = 'Frame Name'
            Width = 79
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'PRODUCEDFRAMES'
            Title.Caption = 'Completed'
            Width = 68
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'NUMBEROFFRAMES'
            Title.Alignment = taCenter
            Title.Caption = 'Quantities'
            Width = 70
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'RIVETS'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'Rivets'
            Width = 40
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'SPACERS'
            Title.Alignment = taCenter
            Title.Caption = 'Spaces'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'TEKSCREWS'
            Title.Alignment = taCenter
            Title.Caption = 'Tek Screws'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Percentage'
            Visible = True
          end>
      end
    end
    object GroupBoxSelectedFrameItemsForProduction: TGroupBox
      Left = 895
      Top = 1
      Width = 224
      Height = 318
      Align = alLeft
      Caption = 'Selected FrameItems For &Production'
      TabOrder = 1
      object JvDBGridFrameEntity: TJvDBGrid
        Left = 2
        Top = 15
        Width = 220
        Height = 301
        Align = alClient
        DataSource = DMDesignJob.DataSourceFrameEntity
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            ReadOnly = True
            Title.Caption = 'Order'
            Width = 38
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ITEMNAME'
            ReadOnly = True
            Width = 60
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'LENGTH'
            ReadOnly = True
            Width = 60
            Visible = True
          end>
      end
    end
    object GroupBoxProduced: TGroupBox
      Left = 1122
      Top = 1
      Width = 437
      Height = 318
      Align = alClient
      Caption = 'Produced Frame &Items'
      TabOrder = 2
      object JvDBGridProducedFrameItems: TJvDBGrid
        Left = 2
        Top = 15
        Width = 433
        Height = 301
        Align = alClient
        DataSource = DMDesignJob.DataSourceItemProduction
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = JvDBGridProducedFrameItemsDrawColumnCell
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Expanded = False
            FieldName = 'SERIALNUMBER'
            ReadOnly = True
            Title.Caption = 'Order'
            Width = 43
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ITEMNAME'
            ReadOnly = True
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ROLLFORMERID'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'Roll Former'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COPYID'
            ReadOnly = True
            Visible = True
          end>
      end
    end
    object GroupBoxFramesForProduce: TGroupBox
      Left = 644
      Top = 1
      Width = 246
      Height = 318
      Align = alLeft
      Caption = 'Frames To Pro&duce'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Splitter4: TSplitter
        Left = 128
        Top = 21
        Height = 295
        ExplicitLeft = 120
        ExplicitTop = 112
        ExplicitHeight = 100
      end
      object ListBoxSelectedFrames: TListBox
        Left = 2
        Top = 21
        Width = 126
        Height = 295
        Align = alLeft
        ItemHeight = 19
        TabOrder = 0
      end
      object PanelFramesProduceOption: TPanel
        Left = 131
        Top = 21
        Width = 113
        Height = 295
        Align = alClient
        TabOrder = 1
        DesignSize = (
          113
          295)
        object Label3: TLabel
          Left = 2
          Top = 114
          Width = 32
          Height = 13
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akTop, akRight]
          Caption = 'Copies'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 5
        end
        object uxFrameCopies: TEdit
          Left = 2
          Top = 131
          Width = 28
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akTop, akRight]
          AutoSelect = False
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '1'
        end
        object UpDown1: TUpDown
          Left = 30
          Top = 131
          Width = 32
          Height = 20
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Anchors = [akTop, akRight]
          Associate = uxFrameCopies
          Min = 1
          Max = 30
          Position = 1
          TabOrder = 1
          Thousands = False
        end
        object GroupCBox: TCheckBox
          Left = 3
          Top = 153
          Width = 86
          Height = 17
          Anchors = [akTop, akRight]
          Caption = 'Group Items'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object GroupBoxFirstItemStartEnd: TGroupBox
          Left = 1
          Top = 1
          Width = 111
          Height = 96
          ParentCustomHint = False
          Align = alTop
          BiDiMode = bdLeftToRight
          Caption = 'First Frame'
          Color = clCream
          Ctl3D = True
          DoubleBuffered = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentBiDiMode = False
          ParentColor = False
          ParentCtl3D = False
          ParentDoubleBuffered = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 3
          DesignSize = (
            111
            96)
          object lbFinal: TLabel
            Left = 9
            Top = 66
            Width = 47
            Height = 13
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Anchors = [akTop, akRight]
            Caption = 'Final Item'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 12
          end
          object label2: TLabel
            Left = 9
            Top = 42
            Width = 49
            Height = 13
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Anchors = [akTop, akRight]
            Caption = 'Start Item'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 12
          end
          object Label1stFrameName: TLabel
            Left = 12
            Top = 20
            Width = 3
            Height = 13
          end
          object uxFinalItem: TEdit
            Left = 62
            Top = 63
            Width = 28
            Height = 21
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Anchors = [akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '1'
          end
          object ElementEdit: TEdit
            Left = 62
            Top = 39
            Width = 28
            Height = 21
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Anchors = [akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            Text = '1'
          end
        end
      end
    end
    object GroupBoxSelectButtons: TGroupBox
      Left = 564
      Top = 1
      Width = 77
      Height = 318
      Align = alLeft
      TabOrder = 4
      object Panel2: TPanel
        Left = 2
        Top = 15
        Width = 73
        Height = 301
        Align = alClient
        TabOrder = 0
        object lbWarning: TLabel
          Left = 3
          Top = 198
          Width = 66
          Height = 43
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taCenter
          AutoSize = False
          Caption = 'Include Items is Checked'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
          WordWrap = True
        end
        object Label1: TLabel
          Left = 1
          Top = 1
          Width = 71
          Height = 13
          Align = alTop
          Caption = 'Qty Remaining'
          ExplicitWidth = 70
        end
        object bnSelect: TBitBtn
          Left = 14
          Top = 59
          Width = 46
          Height = 25
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333FF3333333333333003333
            3333333333773FF3333333333309003333333333337F773FF333333333099900
            33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
            99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
            33333333337F3F77333333333309003333333333337F77333333333333003333
            3333333333773333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          Layout = blGlyphRight
          NumGlyphs = 2
          TabOrder = 0
          OnClick = bnSelectClick
        end
        object bnUnSelect: TBitBtn
          Left = 14
          Top = 88
          Width = 46
          Height = 25
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333FF3333333333333003333333333333F77F33333333333009033
            333333333F7737F333333333009990333333333F773337FFFFFF330099999000
            00003F773333377777770099999999999990773FF33333FFFFF7330099999000
            000033773FF33777777733330099903333333333773FF7F33333333333009033
            33333333337737F3333333333333003333333333333377333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = bnUnSelectClick
        end
        object bnSelectAll: TBitBtn
          Left = 14
          Top = 138
          Width = 46
          Height = 25
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          BiDiMode = bdLeftToRight
          Caption = 'All'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333FF3333333333333003333
            3333333333773FF3333333333309003333333333337F773FF333333333099900
            33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
            99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
            33333333337F3F77333333333309003333333333337F77333333333333003333
            3333333333773333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          Layout = blGlyphRight
          NumGlyphs = 2
          ParentBiDiMode = False
          TabOrder = 2
          OnClick = bnSelectAllClick
        end
        object bnSelectNone: TBitBtn
          Left = 14
          Top = 167
          Width = 46
          Height = 25
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'All'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333FF3333333333333003333333333333F77F33333333333009033
            333333333F7737F333333333009990333333333F773337FFFFFF330099999000
            00003F773333377777770099999999999990773FF33333FFFFF7330099999000
            000033773FF33777777733330099903333333333773FF7F33333333333009033
            33333333337737F3333333333333003333333333333377333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
          TabOrder = 3
          OnClick = bnSelectNoneClick
        end
        object EditToDo: TEdit
          Left = 10
          Top = 23
          Width = 53
          Height = 24
          Alignment = taCenter
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          Text = '1'
          OnKeyPress = EditToDoKeyPress
        end
      end
    end
  end
  object PanelButtons: TPanel
    Left = 0
    Top = 616
    Width = 1560
    Height = 42
    Align = alBottom
    TabOrder = 2
    object ButtonOk: TButton
      Left = 352
      Top = 6
      Width = 94
      Height = 25
      Caption = 'Ok'
      TabOrder = 0
      OnClick = ButtonOkClick
    end
    object ButtonCancel: TButton
      Left = 760
      Top = 6
      Width = 94
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object ButtonLoadProject: TButton
      Left = 491
      Top = 6
      Width = 94
      Height = 25
      Caption = 'Load Project'
      TabOrder = 2
      OnClick = ButtonLoadProjectClick
    end
  end
  object PopupMenuEP2Transfer: TPopupMenu
    Left = 784
    Top = 64
    object MenuItemTransferEP2: TMenuItem
      Caption = 'Transfer'
      OnClick = MenuItemTransferEP2Click
    end
  end
  object FDMemTableJOB: TFDMemTable
    CachedUpdates = True
    IndexFieldNames = 'SITEID;JOBID'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 360
    Top = 104
    object FDMemTableJOBSITEID: TSmallintField
      FieldName = 'SITEID'
    end
    object FDMemTableJOBJOBID: TIntegerField
      FieldName = 'JOBID'
    end
    object FDMemTableJOBJOBNAME: TWideStringField
      FieldKind = fkLookup
      FieldName = 'JOBNAME'
      LookupDataSet = FDMemTableJOBTEMP
      LookupKeyFields = 'JOBID'
      LookupResultField = 'DESIGN'
      KeyFields = 'JOBID'
      Size = 200
      Lookup = True
    end
  end
  object DataSourceJob: TDataSource
    DataSet = FDMemTableJOB
    Left = 488
    Top = 96
  end
  object JvAppRegistryStorage1: TJvAppRegistryStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    Root = '%NONE%'
    SubStorages = <>
    Left = 112
    Top = 104
  end
  object JvFormStorage1: TJvFormStorage
    AppStorage = JvAppRegistryStorage1
    AppStoragePath = '%FORM_NAME%\'
    StoredProps.Strings = (
      'GroupBoxJobList.Width'
      'GroupBoxSelectedJobDetails.Width'
      'GroupBoxSelectedFrames.Width'
      'GroupBoxSelectButtons.Width'
      'GroupBoxFramesForProduce.Width'
      'GroupBoxSelectedFrameItemsForProduction.Width'
      'PanelJob.Height')
    StoredValues = <>
    Left = 232
    Top = 104
  end
  object FDMemTableJOBTEMP: TFDMemTable
    Tag = 10
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 384
    Top = 160
  end
  object PopupMenuJobTransfer: TPopupMenu
    Left = 384
    Top = 32
    object MenuItemTRemoveJob: TMenuItem
      Caption = 'Remove Job'
      OnClick = MenuItemTRemoveJobClick
    end
  end
end
