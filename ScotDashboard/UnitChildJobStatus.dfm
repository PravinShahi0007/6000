inherited MDIChildJobStatus: TMDIChildJobStatus
  Caption = 'MDIChildJobStatus'
  ClientHeight = 689
  ClientWidth = 1691
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnShow = FormShow
  ExplicitWidth = 1707
  ExplicitHeight = 728
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 0
    Top = 281
    Width = 1691
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 225
    ExplicitWidth = 412
  end
  object PanelJob: TPanel
    Left = 0
    Top = 0
    Width = 1691
    Height = 281
    Align = alTop
    TabOrder = 0
    object Splitter6: TSplitter
      Left = 1318
      Top = 1
      Height = 279
      ExplicitLeft = 1337
    end
    object Splitter5: TSplitter
      Left = 689
      Top = 1
      Height = 279
      ExplicitLeft = 537
    end
    object GroupBoxSelectedJobDetails: TGroupBox
      Left = 1321
      Top = 1
      Width = 369
      Height = 279
      Align = alClient
      Caption = 'Selected Job Information'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object DBTextAddedOn: TDBText
        Left = 128
        Top = 111
        Width = 200
        Height = 17
        DataField = 'ADDEDON'
        DataSource = DMDesignJob.DataSourceJob
      end
      object DBTextDesign: TDBText
        Left = 128
        Top = 52
        Width = 200
        Height = 17
        DataField = 'DESIGN'
        DataSource = DMDesignJob.DataSourceJob
      end
      object DBTextFrameCopies: TDBText
        Left = 128
        Top = 133
        Width = 200
        Height = 17
        DataField = 'FRAMECOPIES'
        DataSource = DMDesignJob.DataSourceJob
      end
      object DBTextJobID: TDBText
        Left = 128
        Top = 72
        Width = 73
        Height = 17
        DataField = 'JOBID'
        DataSource = DMDesignJob.DataSourceJob
      end
      object DBTextSteel: TDBText
        Left = 128
        Top = 92
        Width = 200
        Height = 17
        DataField = 'STEEL'
        DataSource = DMDesignJob.DataSourceJob
      end
      object Label1: TLabel
        Left = 81
        Top = 72
        Width = 37
        Height = 16
        Caption = 'JOBID'
      end
      object Label12: TLabel
        Left = 57
        Top = 111
        Width = 61
        Height = 16
        Caption = 'ADDEDON'
      end
      object Label2: TLabel
        Left = 73
        Top = 52
        Width = 45
        Height = 16
        Caption = 'DESIGN'
      end
      object Label3: TLabel
        Left = 82
        Top = 92
        Width = 36
        Height = 16
        Caption = 'STEEL'
      end
      object Label6: TLabel
        Left = 30
        Top = 133
        Width = 88
        Height = 16
        Caption = 'FRAMECOPIES'
      end
    end
    object GroupBoxJobList: TGroupBox
      Left = 1
      Top = 1
      Width = 688
      Height = 279
      Align = alLeft
      Caption = 'Job List'
      TabOrder = 1
      object JvDBGridDesignJob: TJvDBGrid
        Left = 2
        Top = 15
        Width = 684
        Height = 233
        Align = alClient
        DataSource = DMDesignJob.DataSourceJob
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        PopupMenu = PopupMenuJobTransfer
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = JvDBGridDesignJobDrawColumnCell
        OnKeyUp = JvDBGridDesignJobKeyUp
        OnMouseUp = JvDBGridDesignJobMouseDown
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        Columns = <
          item
            Expanded = False
            FieldName = 'ADDEDON'
            Title.Alignment = taCenter
            Title.Caption = 'DATE'
            Width = 45
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'JOBID'
            Title.Alignment = taCenter
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESIGN'
            ReadOnly = True
            Width = 350
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
      object ToolBarRollFormer: TToolBar
        Left = 2
        Top = 248
        Width = 684
        Height = 29
        Align = alBottom
        TabOrder = 1
      end
    end
    object GroupBoxEP2Files: TGroupBox
      Left = 692
      Top = 1
      Width = 626
      Height = 279
      Align = alLeft
      Caption = 'EP2 Files'
      TabOrder = 2
      object JvDBGridEP2Files: TJvDBGrid
        Left = 2
        Top = 15
        Width = 622
        Height = 241
        Align = alClient
        DataSource = DMDesignJob.DataSourceEP2File
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        PopupMenu = PopupMenuEP2Transfer
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = JvDBGridEP2FilesDrawColumnCell
        OnDblClick = JvDBGridProducedFrameItemsDblClick
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
            Width = 45
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'EP2FILEID'
            Title.Alignment = taCenter
            Title.Caption = 'FILEID'
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EP2FILE'
            ReadOnly = True
            Width = 263
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CountDisplay'
            Title.Alignment = taCenter
            Title.Caption = 'Total Frames Produced'
            Width = 121
            Visible = True
          end>
      end
      object PanelTransfered: TPanel
        Left = 2
        Top = 256
        Width = 622
        Height = 21
        Align = alBottom
        TabOrder = 1
        object DBText1: TDBText
          Left = 66
          Top = 1
          Width = 41
          Height = 19
          Align = alLeft
          AutoSize = True
          DataField = 'TRANSFERTORFID1'
          DataSource = DMDesignJob.DataSourceEP2File
          ExplicitHeight = 13
        end
        object DBText2: TDBText
          Left = 107
          Top = 1
          Width = 41
          Height = 19
          Align = alLeft
          AutoSize = True
          DataField = 'TRANSFERTORFID2'
          DataSource = DMDesignJob.DataSourceEP2File
          ExplicitHeight = 13
        end
        object DBText3: TDBText
          Left = 148
          Top = 1
          Width = 41
          Height = 19
          Align = alLeft
          AutoSize = True
          DataField = 'TRANSFERTORFID3'
          DataSource = DMDesignJob.DataSourceEP2File
          ExplicitHeight = 13
        end
        object DBText4: TDBText
          Left = 189
          Top = 1
          Width = 41
          Height = 19
          Align = alLeft
          AutoSize = True
          DataField = 'TRANSFERTORFID4'
          DataSource = DMDesignJob.DataSourceEP2File
          ExplicitHeight = 13
        end
        object DBText5: TDBText
          Left = 230
          Top = 1
          Width = 41
          Height = 19
          Align = alLeft
          AutoSize = True
          DataField = 'TRANSFERTORFID5'
          DataSource = DMDesignJob.DataSourceEP2File
          ExplicitHeight = 13
        end
        object DBText6: TDBText
          Left = 271
          Top = 1
          Width = 41
          Height = 19
          Align = alLeft
          AutoSize = True
          DataField = 'TRANSFERTORFID6'
          DataSource = DMDesignJob.DataSourceEP2File
          ExplicitHeight = 13
        end
        object DBText0: TDBText
          Left = 1
          Top = 1
          Width = 65
          Height = 19
          Align = alLeft
          DataField = 'ROLLFORMERID'
          DataSource = DMDesignJob.DataSourceEP2File
          ExplicitLeft = 9
          ExplicitTop = 2
        end
      end
    end
    object GroupBoxJobDetails: TGroupBox
      Left = 1321
      Top = 1
      Width = 0
      Height = 279
      Align = alLeft
      Caption = 'Selected Frame Information'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object DBTextOPERATOR: TDBText
        Left = 127
        Top = 121
        Width = 120
        Height = 17
        DataField = 'OPERATOR'
      end
      object DBTextREVETERS: TDBText
        Left = 127
        Top = 145
        Width = 150
        Height = 17
        DataField = 'RIVERTER'
      end
      object DBTextJobDetailADDON: TDBText
        Left = 127
        Top = 195
        Width = 160
        Height = 17
        DataField = 'ADDEDON'
      end
      object DBTextWEIGHT: TDBText
        Left = 127
        Top = 170
        Width = 100
        Height = 17
        DataField = 'WEIGHT'
      end
      object DBTextJobDetailSteel: TDBText
        Left = 127
        Top = 72
        Width = 150
        Height = 17
        DataField = 'STEEL'
      end
      object Label14: TLabel
        Left = 49
        Top = 145
        Width = 61
        Height = 16
        Alignment = taRightJustify
        Caption = 'RIVETERS'
      end
      object Label15: TLabel
        Left = 61
        Top = 170
        Width = 49
        Height = 16
        Alignment = taRightJustify
        Caption = 'WEIGHT'
      end
      object Label16: TLabel
        Left = 77
        Top = 195
        Width = 33
        Height = 16
        Alignment = taRightJustify
        Caption = 'DATE'
      end
      object Label18: TLabel
        Left = 74
        Top = 72
        Width = 36
        Height = 16
        Alignment = taRightJustify
        Caption = 'STEEL'
      end
      object Label20: TLabel
        Left = 42
        Top = 121
        Width = 68
        Height = 16
        Alignment = taRightJustify
        Caption = 'OPERATOR'
      end
      object Label22: TLabel
        Left = 67
        Top = 96
        Width = 43
        Height = 16
        Alignment = taRightJustify
        Caption = 'COILID'
      end
      object DBTextCOILID: TDBText
        Left = 127
        Top = 96
        Width = 150
        Height = 17
        DataField = 'COILID'
      end
      object ToolBarJobStatus: TToolBar
        Left = 40
        Top = 242
        Width = 300
        Height = 24
        Align = alNone
        ButtonHeight = 24
        Images = FormScotDashBoard.ImageListMainForm
        TabOrder = 0
        object ToolButtonApplyFilter: TToolButton
          Left = 0
          Top = 0
          Hint = 'Click down to enable RollFormer selection box'
          Caption = 'Apply Filter'
          ImageIndex = 16
          Style = tbsCheck
          OnClick = ToolButtonApplyFilterClick
        end
        object ComboBoxRFSelection: TComboBox
          Left = 23
          Top = 0
          Width = 201
          Height = 24
          Enabled = False
          TabOrder = 0
          OnChange = ActionApplyFilterExecute
          OnSelect = ComboBoxRFSelectionSelect
        end
      end
    end
  end
  object PanelFrames: TPanel
    Left = 0
    Top = 284
    Width = 1691
    Height = 405
    Align = alClient
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 473
      Top = 1
      Width = 5
      Height = 378
      ExplicitLeft = 496
      ExplicitHeight = 410
    end
    object Splitter3: TSplitter
      Left = 785
      Top = 1
      Height = 378
      ExplicitLeft = 855
      ExplicitTop = 6
      ExplicitHeight = 386
    end
    object Splitter4: TSplitter
      Left = 1246
      Top = 1
      Height = 378
      ExplicitLeft = 840
      ExplicitTop = 152
      ExplicitHeight = 100
    end
    object GroupBoxSelectedFrames: TGroupBox
      Left = 1
      Top = 1
      Width = 472
      Height = 378
      Align = alLeft
      Caption = 'Selected Frames'
      TabOrder = 0
      object JvDBGridFrame: TJvDBGrid
        Left = 2
        Top = 15
        Width = 468
        Height = 361
        Align = alClient
        DataSource = DMDesignJob.DataSourceFrame
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = JvDBGridFrameDrawColumnCell
        OnDblClick = JvDBGridProducedFrameItemsDblClick
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
            Width = 70
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ITEMCOUNT'
            ReadOnly = True
            Width = 68
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'RIVETS'
            ReadOnly = True
            Title.Alignment = taCenter
            Width = 110
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
      Left = 478
      Top = 1
      Width = 307
      Height = 378
      Align = alLeft
      Caption = 'Selected FrameItems For Production'
      TabOrder = 1
      object JvDBGridFrameEntity: TJvDBGrid
        Left = 2
        Top = 15
        Width = 303
        Height = 338
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
            Alignment = taCenter
            Expanded = False
            FieldName = 'ID'
            Title.Alignment = taCenter
            Title.Caption = 'Production Order'
            Width = 90
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
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'OPCOUNT'
            ReadOnly = True
            Width = 70
            Visible = True
          end>
      end
      object PanelEntityGridTitle: TPanel
        Left = 2
        Top = 353
        Width = 303
        Height = 23
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object DBTextFrameLength: TDBText
          Left = 158
          Top = 1
          Width = 80
          Height = 21
          Align = alRight
          Alignment = taRightJustify
          DataField = 'FRAMELENGTH'
          DataSource = DMDesignJob.DataSourceFrameEntity
          ExplicitLeft = 232
        end
        object DBTextFrameName: TDBText
          Left = 28
          Top = 1
          Width = 130
          Height = 21
          Align = alRight
          Alignment = taRightJustify
          DataField = 'FRAMENAME'
          DataSource = DMDesignJob.DataSourceFrame
          ExplicitLeft = 48
        end
        object Label4: TLabel
          Left = 238
          Top = 1
          Width = 64
          Height = 21
          Align = alRight
          Alignment = taCenter
          AutoSize = False
          Caption = 'Meters'
          ExplicitLeft = 312
        end
      end
    end
    object GroupBoxProduced: TGroupBox
      Left = 788
      Top = 1
      Width = 458
      Height = 378
      Align = alLeft
      Caption = 'Produced Frame Items'
      TabOrder = 2
      object JvDBGridProducedFrameItems: TJvDBGrid
        Left = 2
        Top = 15
        Width = 454
        Height = 361
        Align = alClient
        DataSource = DMDesignJob.DataSourceItemProduction
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = JvDBGridProducedFrameItemsDrawColumnCell
        OnDblClick = JvDBGridProducedFrameItemsDblClick
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
            Title.Caption = 'Production Order'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ROLLFORMERID'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'RollFormer'
            Width = 60
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
            FieldName = 'CARDNUMBER'
            ReadOnly = True
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COPYID'
            Visible = True
          end>
      end
    end
    object GroupBoxSelectedFramePicture: TGroupBox
      Left = 1249
      Top = 1
      Width = 441
      Height = 378
      Align = alClient
      Caption = 'Selected Frame'
      TabOrder = 3
      object PaintBoxFrame: TPaintBox
        Tag = 10
        Left = 2
        Top = 15
        Width = 437
        Height = 361
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        OnPaint = PaintBoxFramePaint
        ExplicitLeft = 1
        ExplicitTop = 11
        ExplicitWidth = 289
        ExplicitHeight = 369
      end
    end
    object PanelCurrentStatus: TPanel
      Left = 1
      Top = 379
      Width = 1689
      Height = 25
      Align = alBottom
      TabOrder = 4
      object DBTextFrameEP2File: TDBText
        Left = 1
        Top = 1
        Width = 656
        Height = 23
        Align = alLeft
        DataField = 'EP2FILE'
        DataSource = DMDesignJob.DataSourceFrame
      end
      object LabelActiveRF: TLabel
        Left = 657
        Top = 1
        Width = 1031
        Height = 23
        Align = alClient
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
    end
  end
  object PopupMenuJobTransfer: TPopupMenu
    Left = 560
    Top = 88
    object MenuItemTransferJob: TMenuItem
      Caption = 'Transfer Job'
      Visible = False
    end
    object MenuItemTRemoveJob: TMenuItem
      Caption = 'Remove Job'
      OnClick = MenuItemTRemoveJobClick
    end
  end
  object PopupMenuEP2Transfer: TPopupMenu
    Left = 992
    Top = 104
    object MenuItemTransferEP2: TMenuItem
      Caption = 'Transfer'
      OnClick = MenuItemTransferEP2Click
    end
  end
  object JvAppRegistryStorage1: TJvAppRegistryStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    Root = '%NONE%'
    SubStorages = <>
    Left = 784
    Top = 72
  end
  object JvFormStorage1: TJvFormStorage
    AppStorage = JvAppRegistryStorage1
    AppStoragePath = '%FORM_NAME%\'
    StoredProps.Strings = (
      'GroupBoxJobList.Width'
      'GroupBoxEP2Files.Width'
      'GroupBoxSelectedFrames.Width'
      'GroupBoxSelectedFrameItemsForProduction.Height'
      'GroupBoxProduced.Width'
      'PanelJob.Height')
    StoredValues = <>
    Left = 784
    Top = 136
  end
end
