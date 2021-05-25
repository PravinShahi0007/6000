object FormSettings: TFormSettings
  Left = 363
  Top = 304
  BorderIcons = []
  BorderWidth = 3
  Caption = 'Settings'
  ClientHeight = 490
  ClientWidth = 980
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    980
    490)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 980
    Height = 417
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'General'
      object Label21: TLabel
        Left = 17
        Top = 9
        Width = 54
        Height = 13
        Alignment = taRightJustify
        Caption = 'Settings file'
      end
      object Label27: TLabel
        Left = 156
        Top = 119
        Width = 25
        Height = 13
        Caption = 'Drive'
      end
      object Label10: TLabel
        Left = 182
        Top = 147
        Width = 36
        Height = 13
        Caption = 'RF Port'
      end
      object SerialBtn: TSpeedButton
        Left = 458
        Top = 244
        Width = 73
        Height = 25
        Caption = 'Ports ?'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666066666666666666076666666666660077666660006660
          7770666607770007700666607777777706666607777777770666666077777777
          0666666307777777066666366077777706666666630777770666666636607770
          6666666666630706666666666636606666666666666666666666}
        OnClick = SerialBtnClick
      end
      object Label46: TLabel
        Left = 162
        Top = 180
        Width = 60
        Height = 13
        Caption = 'RF Baudrate'
      end
      object Label23: TLabel
        Left = 400
        Top = 214
        Width = 78
        Height = 13
        Caption = 'Operation pause'
      end
      object Label45: TLabel
        Left = 25
        Top = 287
        Width = 76
        Height = 13
        Caption = 'Display font size'
      end
      object Label55: TLabel
        Left = 389
        Top = 249
        Width = 63
        Height = 13
        Caption = 'Serial Comms'
      end
      object Label22: TLabel
        Left = 3
        Top = 41
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = 'Machine Type'
      end
      object LabelMachineID: TLabel
        Left = 9
        Top = 78
        Width = 72
        Height = 13
        Caption = 'Machine Name'
      end
      object Drivetype: TComboBox
        Left = 198
        Top = 116
        Width = 162
        Height = 21
        Style = csDropDownList
        DropDownCount = 10
        TabOrder = 0
        Items.Strings = (
          'Mint'
          'Mint II'
          'Mint II 5225+'
          'MotiFlex e100 Mint'
          'MotiFlex e100 IP Mint'
          'MicroFlex E150 IP'
          'MicroFlex E190 IP'
          'MotiFlex e180 IP'
          'Flex+')
      end
      object framepause: TCheckBox
        Left = 34
        Top = 152
        Width = 85
        Height = 16
        Alignment = taLeftJustify
        Caption = 'Frame pause'
        TabOrder = 1
      end
      object ShowItemNoCBox: TCheckBox
        Left = 739
        Top = 314
        Width = 89
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Large item no.'
        TabOrder = 14
        Visible = False
      end
      object EditRFComPort: TEdit
        Left = 238
        Top = 144
        Width = 49
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = 'COM1'
      end
      object WarnCBox: TCheckBox
        Left = 19
        Top = 219
        Width = 100
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Counter Warning'
        TabOrder = 3
      end
      object bnOpen: TBitBtn
        Left = 459
        Top = 1
        Width = 61
        Height = 25
        Caption = 'Open'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = bnOpenClick
      end
      object settingfile: TEdit
        Left = 78
        Top = 3
        Width = 374
        Height = 21
        TabOrder = 5
      end
      object RectanglesCBox: TCheckBox
        Left = 13
        Top = 253
        Width = 106
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Display rectangles'
        TabOrder = 6
      end
      object BaudCBox: TComboBox
        Left = 238
        Top = 177
        Width = 61
        Height = 21
        TabOrder = 7
        Text = '57600'
        Items.Strings = (
          '9600'
          '19200'
          '57600')
      end
      object OpPauseEdit: TEdit
        Left = 498
        Top = 211
        Width = 33
        Height = 21
        TabOrder = 8
        Text = '0'
      end
      object DisplayFontSize: TEdit
        Left = 107
        Top = 284
        Width = 29
        Height = 21
        TabOrder = 9
        Text = '10'
      end
      object RBMetric: TRadioButton
        Left = 268
        Top = 42
        Width = 92
        Height = 14
        Caption = 'Metric'
        Checked = True
        Enabled = False
        TabOrder = 10
        TabStop = True
      end
      object RBImperial: TRadioButton
        Left = 389
        Top = 42
        Width = 54
        Height = 14
        Caption = 'Imperial'
        TabOrder = 11
      end
      object LabelPrintCBox: TCheckBox
        Left = 34
        Top = 186
        Width = 85
        Height = 14
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Alignment = taLeftJustify
        Caption = 'Label printing'
        TabOrder = 12
      end
      object TwinRFCBox: TCheckBox
        Left = 389
        Top = 130
        Width = 129
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Use Twin box web RF'
        TabOrder = 13
        OnClick = TwinRFCBoxClick
      end
      object RemoveFrmCBox: TCheckBox
        Left = 377
        Top = 153
        Width = 141
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Remove selected frames'
        TabOrder = 15
      end
      object uxSimulationMode: TCheckBox
        Left = 19
        Top = 119
        Width = 100
        Height = 16
        Alignment = taLeftJustify
        Caption = 'Simulation Mode'
        TabOrder = 16
      end
      object uxMachineType: TComboBox
        Left = 77
        Top = 38
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 17
        Text = '50mm (2") Truss'
        OnChange = uxMachineTypeChange
        Items.Strings = (
          '50mm (2") Truss'
          '75mm (3") Truss')
      end
      object Edit_MachineName: TEdit
        Left = 88
        Top = 73
        Width = 332
        Height = 21
        TabOrder = 18
        OnChange = Edit_MachineNameChange
      end
      object CheckBoxIsConnectToServer: TCheckBox
        Left = 17
        Top = 328
        Width = 114
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Connect To Server'
        TabOrder = 19
        OnClick = CheckBoxIsConnectToServerClick
      end
      object GroupBoxServer: TGroupBox
        Left = 146
        Top = 328
        Width = 263
        Height = 25
        TabOrder = 20
        object LabelServer: TLabel
          Left = 3
          Top = 2
          Width = 37
          Height = 13
          Caption = 'Server :'
        end
        object LabelPort: TLabel
          Left = 175
          Top = 3
          Width = 25
          Height = 13
          Caption = 'Port :'
        end
        object EditServer: TEdit
          Left = 46
          Top = 2
          Width = 121
          Height = 21
          TabOrder = 0
        end
        object EditPort: TEdit
          Left = 199
          Top = 2
          Width = 50
          Height = 21
          TabOrder = 1
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Truss Rollformer'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label13: TLabel
        Left = 230
        Top = 3
        Width = 76
        Height = 13
        Caption = 'Tool Settings'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 299
        Top = 36
        Width = 44
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cut width'
      end
      object Label11: TLabel
        Left = 293
        Top = 69
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'Notch size'
      end
      object Label14: TLabel
        Left = 76
        Top = 248
        Width = 65
        Height = 13
        Caption = 'Pre-camber %'
      end
      object Label1: TLabel
        Left = 297
        Top = 102
        Width = 46
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cope size'
      end
      object Label47: TLabel
        Left = 210
        Top = 269
        Width = 52
        Height = 13
        Caption = '(TrussPlus)'
      end
      object Image2: TImage
        Left = 497
        Top = 3
        Width = 32
        Height = 32
        AutoSize = True
        Picture.Data = {
          055449636F6E0000010001002020100000000000E80200001600000028000000
          2000000040000000010004000000000080020000000000000000000000000000
          0000000000000000000080000080000000808000800000008000800080800000
          80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
          FFFFFF0000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000800000000000000000000000000000000800000000
          0000000000000000000000808000000000000000000000000000008808000000
          0000000000000008080000888080000000000000000000080880008888080000
          0000007700000000088800888880800000007777000000000888808888880800
          0000777700000000088800088888808000007777000000000800888088888808
          0000777700000000008888880888888080007777000000000088888880888888
          0800777700000000000888888808888880807777000000000000888888808888
          8800777700000000000008888888088888807777000000000007708888888088
          8880777700000000000777088888880888807777000000000007777088888880
          8880777700000000000777770888888808007777000000000007777770888888
          0000777700000000000777777008888000007777000000000007777770008000
          0077777700000000000777777000000077777700000000000007777770000077
          7777007700000000000777777000777777007777000000000007777770777777
          0077777700000000000777777777770077777777000000000007777777770077
          77777777FFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFFF8FFFFFFF87FFFFFF83FFF
          FE381FFFFC180FFCFC0807F0FE0003E0FF0001E0FF0000E0FF000060FF000020
          FF800000FFC00000FFE00000FFE00000FFC00000FFC00000FFC00000FFC00000
          FFC00000FFC00000FFC00000FFC00000FFC00000FFC00000FFC00000FFC00000
          FFC00000}
        Proportional = True
        Stretch = True
      end
      object Shape28: TShape
        Left = 76
        Top = 233
        Width = 393
        Height = 1
        Pen.Color = clGray
      end
      object lbFlangeLipHoleDiff: TLabel
        Left = 259
        Top = 165
        Width = 84
        Height = 26
        Caption = 'Flange hole to Lip hole vertical'
        WordWrap = True
      end
      object lbLipHoleHeight: TLabel
        Left = 274
        Top = 136
        Width = 69
        Height = 13
        Alignment = taRightJustify
        Caption = 'Lip hole height'
      end
      object lbTrussSwageSize: TLabel
        Left = 287
        Top = 203
        Width = 56
        Height = 13
        Alignment = taRightJustify
        Caption = 'Swage Size'
      end
      object trusscutwidthEdit: TEdit
        Left = 361
        Top = 32
        Width = 46
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '5'
      end
      object trussnotchsizeedit: TEdit
        Left = 361
        Top = 71
        Width = 46
        Height = 21
        TabOrder = 3
        Text = '50'
      end
      object trussprecamberedit: TEdit
        Left = 168
        Top = 244
        Width = 33
        Height = 21
        TabOrder = 8
        Text = '0'
      end
      object trusscopesizeedit: TEdit
        Left = 361
        Top = 98
        Width = 46
        Height = 21
        TabOrder = 4
        Text = '50'
      end
      object TrussAutoPCCBox: TCheckBox
        Left = 76
        Top = 279
        Width = 105
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Auto Pre-Camber'
        TabOrder = 10
        OnClick = TrussAutoPCCBoxClick
      end
      object SortChordWebCBox: TCheckBox
        Left = 304
        Top = 279
        Width = 137
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Sort chord before webs '
        TabOrder = 11
      end
      object LoadTrussToolBtn: TBitBtn
        Left = 431
        Top = 80
        Width = 148
        Height = 31
        Caption = 'Read Tool Settings from RF'
        TabOrder = 12
        TabStop = False
        OnClick = LoadTrussToolBtnClick
      end
      object SaveTrussToolBtn: TBitBtn
        Left = 431
        Top = 115
        Width = 148
        Height = 30
        Caption = 'Save Tool Settings to RF'
        TabOrder = 13
        TabStop = False
        OnClick = SaveTrussToolBtnClick
      end
      object uxFlangeLipHoleVDiff: TEdit
        Left = 361
        Top = 165
        Width = 46
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Text = '18'
        OnChange = uxFlangeLipHoleVDiffChange
        OnExit = uxFlangeLipHoleVDiffChange
      end
      object uxLipHoleHeight: TEdit
        Left = 361
        Top = 132
        Width = 46
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Text = '22'
      end
      object TrussDblNotchCB: TCheckBox
        Left = 354
        Top = 248
        Width = 87
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Alignment = taLeftJustify
        Caption = 'Double notch'
        TabOrder = 9
      end
      object uxTrussSwageSize: TEdit
        Left = 361
        Top = 199
        Width = 46
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Text = '18'
        OnChange = uxFlangeLipHoleVDiffChange
        OnExit = uxFlangeLipHoleVDiffChange
      end
      object TrussPanel: TPanel
        Left = 32
        Top = 31
        Width = 221
        Height = 170
        BevelOuter = bvNone
        BorderStyle = bsSingle
        ParentColor = True
        TabOrder = 0
        object lbTrussCutToLip: TLabel
          Left = 65
          Top = 5
          Width = 70
          Height = 13
          Alignment = taRightJustify
          Caption = 'Cut to Lip Hole'
        end
        object lbTrussCopeToLip: TLabel
          Left = 52
          Top = 39
          Width = 79
          Height = 13
          Alignment = taRightJustify
          Caption = 'Cope to Lip Hole'
        end
        object lbTrussNotchToLip: TLabel
          Left = 48
          Top = 72
          Width = 83
          Height = 13
          Alignment = taRightJustify
          Caption = 'Notch to Lip Hole'
        end
        object lbTrussFHtoLipH: TLabel
          Left = 20
          Top = 106
          Width = 111
          Height = 13
          Alignment = taRightJustify
          Caption = 'Flange Hole to Lip Hole'
        end
        object uxTrussCutToLip: TEdit
          Left = 141
          Top = 2
          Width = 57
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '85'
        end
        object uxTrussCopeToLip: TEdit
          Left = 141
          Top = 35
          Width = 57
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = '50'
        end
        object uxTrussNotchToLip: TEdit
          Left = 141
          Top = 68
          Width = 57
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = '52'
        end
        object uxTrussFHtoLipH: TEdit
          Left = 141
          Top = 102
          Width = 57
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = '65'
        end
      end
      object Truss75mmPanel: TPanel
        Left = 585
        Top = 16
        Width = 221
        Height = 161
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        ParentColor = True
        TabOrder = 1
        Visible = False
        object Label5: TLabel
          Left = 75
          Top = 5
          Width = 60
          Height = 13
          Alignment = taRightJustify
          Caption = 'Cut to Notch'
        end
        object Label6: TLabel
          Left = 66
          Top = 38
          Width = 69
          Height = 13
          Alignment = taRightJustify
          Caption = 'Cope to Notch'
        end
        object Label7: TLabel
          Left = 48
          Top = 72
          Width = 83
          Height = 13
          Alignment = taRightJustify
          Caption = 'Lip Hole to Notch'
        end
        object Label8: TLabel
          Left = 24
          Top = 130
          Width = 111
          Height = 13
          Alignment = taRightJustify
          Caption = 'Flange Hole to Lip Hole'
        end
        object lbTrussSwageTo: TLabel
          Left = 56
          Top = 103
          Width = 77
          Height = 13
          Alignment = taRightJustify
          Caption = 'Swage to Notch'
        end
        object uxTrussCutToNotch: TEdit
          Left = 141
          Top = 2
          Width = 57
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '85'
        end
        object uxTrussCopeToNotch: TEdit
          Left = 141
          Top = 34
          Width = 57
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = '50'
        end
        object uxTrussLipHoleToNotch: TEdit
          Left = 141
          Top = 67
          Width = 57
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = '52'
        end
        object uxTruss3inFHtoLipH: TEdit
          Left = 141
          Top = 126
          Width = 57
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Text = '65'
        end
        object uxTrussSwageToNotch: TEdit
          Left = 141
          Top = 99
          Width = 57
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = '65'
        end
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'Panel Rollformer'
      ImageIndex = 9
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label67: TLabel
        Left = 178
        Top = 11
        Width = 76
        Height = 13
        Caption = 'Tool Settings'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label59: TLabel
        Left = 63
        Top = 42
        Width = 48
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cut to Flat'
      end
      object Label60: TLabel
        Left = 20
        Top = 77
        Width = 91
        Height = 13
        Alignment = taRightJustify
        Caption = 'Primary Hole to Flat'
      end
      object Label61: TLabel
        Left = 50
        Top = 111
        Width = 61
        Height = 13
        Alignment = taRightJustify
        Caption = 'Notch to Flat'
      end
      object Label62: TLabel
        Left = 43
        Top = 146
        Width = 68
        Height = 13
        Alignment = taRightJustify
        Caption = 'Service to Flat'
      end
      object Label63: TLabel
        Left = 34
        Top = 179
        Width = 77
        Height = 13
        Alignment = taRightJustify
        Caption = 'Service 2 to Flat'
      end
      object Label64: TLabel
        Left = 226
        Top = 43
        Width = 65
        Height = 13
        Alignment = taRightJustify
        Caption = 'Swage to Flat'
      end
      object Label65: TLabel
        Left = 244
        Top = 76
        Width = 47
        Height = 13
        Alignment = taRightJustify
        Caption = 'Cut Width'
      end
      object Label66: TLabel
        Left = 178
        Top = 199
        Width = 3
        Height = 13
      end
      object Label52: TLabel
        Left = 204
        Top = 109
        Width = 87
        Height = 13
        Alignment = taRightJustify
        Caption = 'Flatten tool  length'
      end
      object Label53: TLabel
        Left = 210
        Top = 142
        Width = 81
        Height = 13
        Alignment = taRightJustify
        Caption = 'Notch tool length'
      end
      object lblSwageToolLen: TLabel
        Left = 206
        Top = 175
        Width = 85
        Height = 13
        Alignment = taRightJustify
        Caption = 'Swage tool length'
      end
      object Label75: TLabel
        Left = 242
        Top = 291
        Width = 101
        Height = 13
        Caption = 'Pre-camber 1 in 1000'
      end
      object Image3: TImage
        Left = 498
        Top = 3
        Width = 32
        Height = 32
        AutoSize = True
        Picture.Data = {
          055449636F6E0000010001002020100000000000E80200001600000028000000
          2000000040000000010004000000000080020000000000000000000000000000
          0000000000000000000080000080000000808000800000008000800080800000
          80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
          FFFFFF0000000000000000000000000000000000000000000000800000000000
          0000000000000000008880800000000000000000000000008888808800000000
          0000000000000088888880888000000000000000000088888888808008000000
          0000000000888888888800800880000000000000008888888880880888880000
          0000000008088888888808808888800000000000088088888888808808888800
          0000007708000888888888088088888000007777000080888888888088088888
          0000777700880808888888880880888880007777000880808888888880880888
          8800777700008808088888888808808888807777000008808088888888808808
          8880777700000088080888888888088088807777000000088080888888888088
          0880777700000000880808888888880880807777000000000880808888888880
          8800777700000000008808088888888808807777000000007708808088888888
          8080777700000077777088080888888888007777000000777777088080888888
          0000777700000077777770880808888000007777000000777777700880808000
          0077777700000077777770008808000077777700000000777777700008800077
          7777007700000077777770000000777777007777000000777777700000777777
          0077777700000077777770007777770077777777000000777777777777770077
          77777777FFF3FFFFFFC1FFFFFF00FFFFFC007FFFF0003FFFC0001FFF00000FFF
          000007FF000003FC000001F0000000C00000000000000000C0000000E0000000
          F0000000F8000000FC000000FE000000FF000000FF000000FC000000F8000000
          F8000000F8000000F8000000F8000000F8000000F8000000F8000000F8000000
          F8000000}
      end
      object Label87: TLabel
        Left = 22
        Top = 291
        Width = 76
        Height = 13
        Caption = 'Notch tolerance'
      end
      object Shape27: TShape
        Left = 66
        Top = 280
        Width = 400
        Height = 2
        Pen.Color = clGray
      end
      object Label54: TLabel
        Left = 200
        Top = 209
        Width = 91
        Height = 13
        Alignment = taRightJustify
        Caption = 'Primary Hole height'
      end
      object Label94: TLabel
        Left = 391
        Top = 111
        Width = 120
        Height = 13
        Caption = 'Horizontal hole difference'
      end
      object Label95: TLabel
        Left = 400
        Top = 77
        Width = 108
        Height = 13
        Caption = 'Vertical hole difference'
      end
      object PanelCut2Flat: TEdit
        Left = 121
        Top = 40
        Width = 56
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object PanelHole2Flat: TEdit
        Left = 121
        Top = 75
        Width = 56
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object PanelNotch2Flat: TEdit
        Left = 121
        Top = 109
        Width = 56
        Height = 21
        TabOrder = 2
        Text = '0'
      end
      object PanelService2Flat: TEdit
        Left = 121
        Top = 144
        Width = 56
        Height = 21
        TabOrder = 3
        Text = '0'
      end
      object PanelService22Flat: TEdit
        Left = 121
        Top = 176
        Width = 56
        Height = 21
        TabOrder = 4
        Text = '0'
      end
      object PanelSwage2Flat: TEdit
        Left = 310
        Top = 40
        Width = 51
        Height = 21
        TabOrder = 5
        Text = '0'
      end
      object PanelCutWidth: TEdit
        Left = 310
        Top = 73
        Width = 51
        Height = 21
        TabOrder = 6
        Text = '0'
      end
      object PanelFlatSize: TEdit
        Left = 308
        Top = 106
        Width = 53
        Height = 21
        TabOrder = 7
        Text = '50'
      end
      object PanelNotchSize: TEdit
        Left = 308
        Top = 139
        Width = 53
        Height = 21
        TabOrder = 8
        Text = '50'
      end
      object PanelSwageToolLen: TEdit
        Left = 308
        Top = 172
        Width = 53
        Height = 21
        TabOrder = 9
        Text = '65'
      end
      object PanelPreCamber: TEdit
        Left = 354
        Top = 288
        Width = 55
        Height = 21
        TabOrder = 10
        Text = '0'
      end
      object PanelNotchTol: TEdit
        Left = 113
        Top = 288
        Width = 53
        Height = 21
        TabOrder = 11
        Text = '10'
      end
      object LoadToolBtn: TBitBtn
        Left = 413
        Top = 162
        Width = 145
        Height = 30
        Caption = 'Read Tool Settings from RF'
        TabOrder = 12
        OnClick = LoadToolBtnClick
      end
      object SaveToolBtn: TBitBtn
        Left = 413
        Top = 206
        Width = 145
        Height = 29
        Caption = 'Save Tool Settings to RF'
        TabOrder = 13
        OnClick = SaveToolBtnClick
      end
      object PanelHoleHeight: TEdit
        Left = 308
        Top = 205
        Width = 53
        Height = 21
        TabOrder = 14
        Text = '27'
        OnChange = PanelHoleHeightChange
      end
      object PanelHoleDiffHorz: TEdit
        Left = 518
        Top = 109
        Width = 48
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 15
        Text = '0'
      end
      object PanelHoleDiffHeight: TEdit
        Left = 518
        Top = 75
        Width = 41
        Height = 21
        TabOrder = 16
        Text = '11'
        OnChange = PanelHoleHeightChange
      end
      object PanelHDSettings: TPanel
        Left = 4
        Top = 202
        Width = 179
        Height = 62
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        TabOrder = 17
        object lbPanelEndBrgToFlat: TLabel
          Left = 15
          Top = 7
          Width = 90
          Height = 13
          Alignment = taRightJustify
          Caption = 'End Bearing to Flat'
        end
        object lbPanelEndBrgSize: TLabel
          Left = 15
          Top = 34
          Width = 90
          Height = 13
          Alignment = taRightJustify
          Caption = 'End Bearing length'
        end
        object uxPanelEndBrgToFlat: TEdit
          Left = 115
          Top = 3
          Width = 56
          Height = 21
          TabOrder = 0
          Text = '0'
        end
        object uxPanelEndBrgSize: TEdit
          Left = 115
          Top = 30
          Width = 56
          Height = 21
          TabOrder = 1
          Text = '0'
        end
      end
    end
    object TabBoxRf: TTabSheet
      Caption = 'Box Rollformer'
      ImageIndex = 16
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label96: TLabel
        Left = 32
        Top = 124
        Width = 44
        Height = 13
        Caption = 'Cut width'
      end
      object Label97: TLabel
        Left = 32
        Top = 77
        Width = 53
        Height = 13
        Caption = 'Cut to Hole'
      end
      object Label98: TLabel
        Left = 230
        Top = 3
        Width = 76
        Height = 13
        Caption = 'Tool Settings'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LoadBoxToolBtn: TBitBtn
        Left = 254
        Top = 68
        Width = 148
        Height = 31
        Caption = 'Read Tool Settings from RF'
        TabOrder = 0
        OnClick = LoadBoxToolBtnClick
      end
      object SaveBoxToolBtn: TBitBtn
        Left = 254
        Top = 117
        Width = 148
        Height = 30
        Caption = 'Save Tool Settings to RF'
        TabOrder = 1
        OnClick = SaveBoxToolBtnClick
      end
      object BoxCutWidthEdit: TEdit
        Left = 124
        Top = 121
        Width = 46
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '5'
      end
      object BoxCut2holeEdit: TEdit
        Left = 124
        Top = 73
        Width = 57
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '85'
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Truss Profile'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label37: TLabel
        Left = 152
        Top = 20
        Width = 61
        Height = 13
        Caption = 'Profile height'
      end
      object Label9: TLabel
        Left = 29
        Top = 136
        Width = 69
        Height = 13
        Caption = 'Lip hole height'
      end
      object Label15: TLabel
        Left = 22
        Top = 75
        Width = 87
        Height = 13
        Caption = 'Flange hole height'
      end
      object Label39: TLabel
        Left = 264
        Top = 160
        Width = 35
        Height = 13
        Caption = 'Lip size'
      end
      object Label36: TLabel
        Left = 384
        Top = 218
        Width = 32
        Height = 13
        Caption = 'Gauge'
      end
      object Shape2: TShape
        Left = 124
        Top = 40
        Width = 105
        Height = 5
        Brush.Color = cl3DDkShadow
      end
      object Shape3: TShape
        Left = 228
        Top = 40
        Width = 5
        Height = 169
        Brush.Color = cl3DDkShadow
      end
      object Shape4: TShape
        Left = 124
        Top = 40
        Width = 5
        Height = 169
        Brush.Color = cl3DDkShadow
      end
      object Shape5: TShape
        Left = 108
        Top = 204
        Width = 21
        Height = 5
        Brush.Color = cl3DDkShadow
      end
      object Shape6: TShape
        Left = 228
        Top = 204
        Width = 21
        Height = 5
        Brush.Color = cl3DDkShadow
      end
      object Shape7: TShape
        Left = 104
        Top = 180
        Width = 5
        Height = 29
        Brush.Color = cl3DDkShadow
      end
      object Shape8: TShape
        Left = 248
        Top = 180
        Width = 5
        Height = 29
        Brush.Color = cl3DDkShadow
      end
      object Shape9: TShape
        Left = 124
        Top = 76
        Width = 5
        Height = 17
      end
      object Shape10: TShape
        Left = 228
        Top = 76
        Width = 5
        Height = 17
      end
      object Shape11: TShape
        Left = 124
        Top = 148
        Width = 5
        Height = 17
      end
      object Shape12: TShape
        Left = 228
        Top = 148
        Width = 5
        Height = 17
      end
      object HSLabel: TLabel
        Left = 248
        Top = 52
        Width = 43
        Height = 13
        Caption = 'Hole size'
      end
      object FlangeHgtLabel: TLabel
        Left = 8
        Top = 93
        Width = 111
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '(see RF settings)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LipHgtLabel: TLabel
        Left = 22
        Top = 153
        Width = 87
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = '(see RF settings)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object trussprofileedit: TEdit
        Left = 144
        Top = 52
        Width = 69
        Height = 21
        TabOrder = 0
        Text = '52'
      end
      object trussLipsizeEdit: TEdit
        Left = 260
        Top = 180
        Width = 41
        Height = 21
        TabOrder = 1
        Text = '6'
      end
      object trussGaugeEdit: TComboBox
        Left = 440
        Top = 215
        Width = 65
        Height = 21
        TabOrder = 2
        Text = '22'
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
      object Memo1: TMemo
        Left = 384
        Top = 40
        Width = 137
        Height = 161
        BevelOuter = bvNone
        Color = cl3DLight
        Lines.Strings = (
          '  24           0.55 mm'
          '  22           0.75 mm'
          '  20           1.0  mm'
          '  18           1.2  mm'
          '  16           1.6  mm'
          ''
          '  55           0.55 mm'
          '  75           0.75 mm'
          '  95           0.95 mm'
          '115           1.15 mm'
          '160           1.60 mm'
          '  01           Not engineered')
        ReadOnly = True
        TabOrder = 3
      end
      object TrussHoleSizeEdit: TEdit
        Left = 248
        Top = 72
        Width = 41
        Height = 21
        TabOrder = 4
      end
    end
    object TabSheet11: TTabSheet
      Caption = 'Panel Profile'
      ImageIndex = 10
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label50: TLabel
        Left = 171
        Top = 104
        Width = 59
        Height = 13
        Caption = 'Hole heights'
      end
      object Label51: TLabel
        Left = 284
        Top = 76
        Width = 43
        Height = 13
        Caption = 'Hole size'
      end
      object Shape13: TShape
        Left = 148
        Top = 80
        Width = 25
        Height = 5
        Brush.Color = clGray
      end
      object Shape14: TShape
        Left = 336
        Top = 80
        Width = 25
        Height = 5
        Brush.Color = clGray
      end
      object Shape15: TShape
        Left = 356
        Top = 80
        Width = 5
        Height = 93
        Brush.Color = cl3DDkShadow
      end
      object Shape16: TShape
        Left = 148
        Top = 84
        Width = 5
        Height = 93
        Brush.Color = cl3DDkShadow
      end
      object Shape17: TShape
        Left = 148
        Top = 172
        Width = 213
        Height = 5
        Brush.Color = cl3DDkShadow
      end
      object Label56: TLabel
        Left = 196
        Top = 52
        Width = 35
        Height = 13
        Caption = 'Lip size'
      end
      object Shape20: TShape
        Left = 148
        Top = 100
        Width = 5
        Height = 17
      end
      object Shape21: TShape
        Left = 356
        Top = 100
        Width = 5
        Height = 17
      end
      object Shape22: TShape
        Left = 389
        Top = 148
        Width = 2
        Height = 29
      end
      object Shape18: TShape
        Left = 364
        Top = 80
        Width = 25
        Height = 2
      end
      object Shape23: TShape
        Left = 388
        Top = 80
        Width = 2
        Height = 13
      end
      object Shape24: TShape
        Left = 364
        Top = 175
        Width = 25
        Height = 2
      end
      object Label58: TLabel
        Left = 368
        Top = 100
        Width = 53
        Height = 13
        Caption = 'Wall height'
      end
      object PanelHoleHgtLabel: TLabel
        Left = 159
        Top = 124
        Width = 82
        Height = 17
        Alignment = taCenter
        AutoSize = False
        Caption = '(see RF settings)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Shape29: TShape
        Left = 148
        Top = 136
        Width = 5
        Height = 17
      end
      object Shape19: TShape
        Left = 356
        Top = 136
        Width = 6
        Height = 17
      end
      object PanelHoleSize: TEdit
        Left = 283
        Top = 96
        Width = 50
        Height = 21
        TabOrder = 0
        Text = '5.1'
      end
      object PanelLipSize: TEdit
        Left = 148
        Top = 48
        Width = 41
        Height = 21
        TabOrder = 1
        Text = '6'
      end
      object PanelprofileHeight: TEdit
        Left = 368
        Top = 120
        Width = 53
        Height = 21
        TabOrder = 2
        Text = '40'
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Truss Structure'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label17: TLabel
        Left = 146
        Top = 27
        Width = 43
        Height = 13
        Caption = 'Joint gap'
      end
      object Label35: TLabel
        Left = 76
        Top = 60
        Width = 106
        Height = 13
        Caption = 'Min hole centre to end'
      end
      object Label19: TLabel
        Left = 76
        Top = 96
        Width = 110
        Height = 13
        Caption = 'Cope / notch tolerance'
      end
      object Label20: TLabel
        Left = 264
        Top = 68
        Width = 5
        Height = 13
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object Label40: TLabel
        Left = 252
        Top = 57
        Width = 66
        Height = 13
        Caption = '( Imported )'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object trussjointgap: TEdit
        Left = 200
        Top = 22
        Width = 45
        Height = 21
        TabOrder = 0
        Text = '4'
      end
      object trussHoledistanceedit: TEdit
        Left = 200
        Top = 56
        Width = 45
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object trusscopetoledit: TEdit
        Left = 200
        Top = 92
        Width = 45
        Height = 21
        TabOrder = 2
        Text = '10'
      end
      object trussminimizecbox: TCheckBox
        Left = 84
        Top = 136
        Width = 129
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Minimize mitred ends'
        TabOrder = 3
      end
      object trussSpecConCBox: TCheckBox
        Left = 64
        Top = 168
        Width = 149
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Show special connections'
        TabOrder = 4
      end
      object trussMinimizeBCCBox: TCheckBox
        Left = 344
        Top = 232
        Width = 137
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Minmize bottom chords'
        TabOrder = 5
        Visible = False
      end
      object trussWeb2webCBox: TCheckBox
        Left = 44
        Top = 232
        Width = 169
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Web-Web need 2 pt connect'
        TabOrder = 6
      end
      object trussScrewsCBox: TCheckBox
        Left = 92
        Top = 200
        Width = 121
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Display screw count'
        TabOrder = 7
      end
    end
    object TabSheet13: TTabSheet
      Caption = 'Panel Structure'
      ImageIndex = 12
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblPanelJointGap: TLabel
        Left = 104
        Top = 116
        Width = 45
        Height = 13
        Caption = 'Joint Gap'
      end
      object Label57: TLabel
        Left = 72
        Top = 148
        Width = 78
        Height = 13
        Caption = 'Vertical joint gap'
      end
      object lblPanelHoleDist: TLabel
        Left = 48
        Top = 80
        Width = 108
        Height = 13
        Caption = 'End hole dist. Minimum'
      end
      object Service2cbox: TCheckBox
        Left = 372
        Top = 136
        Width = 101
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Use Service 2'
        TabOrder = 0
      end
      object UseSwageCBox: TCheckBox
        Left = 364
        Top = 106
        Width = 109
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Use Swage tool'
        TabOrder = 1
      end
      object PanelJointGap: TEdit
        Left = 164
        Top = 112
        Width = 53
        Height = 21
        TabOrder = 2
        Text = '3'
      end
      object PanelVertJointGap: TEdit
        Left = 164
        Top = 144
        Width = 53
        Height = 21
        TabOrder = 3
        Text = '1'
      end
      object PanelMinHoleDist: TEdit
        Left = 164
        Top = 76
        Width = 53
        Height = 21
        TabOrder = 4
        Text = '10'
      end
      object PanelShowServicesCBox: TCheckBox
        Left = 56
        Top = 44
        Width = 121
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Show Service holes'
        TabOrder = 5
      end
      object PanelIgnoreHoleDistErrCBox: TCheckBox
        Left = 40
        Top = 178
        Width = 137
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Ignore End Hole errors'
        TabOrder = 6
      end
      object VirtualMitreCBox: TCheckBox
        Left = 64
        Top = 206
        Width = 113
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Use Virtual Mitres'
        TabOrder = 7
      end
      object DesignOrderCBox: TCheckBox
        Left = 320
        Top = 76
        Width = 153
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Use Design member order'
        TabOrder = 8
      end
    end
    object tabTrussCounters: TTabSheet
      Caption = 'Truss Counters'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label32: TLabel
        Left = 192
        Top = 12
        Width = 38
        Height = 13
        Caption = 'Elapsed'
      end
      object Label33: TLabel
        Left = 264
        Top = 12
        Width = 40
        Height = 13
        Caption = 'Warning'
      end
      object bnReadTrussCounters: TBitBtn
        Left = 192
        Top = 320
        Width = 121
        Height = 25
        Caption = 'Read counters'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = bnReadTrussCountersClick
      end
      inline uxTrussCutCounter: TCounterFrame
        Left = 112
        Top = 32
        Width = 369
        Height = 37
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        ExplicitLeft = 112
        ExplicitTop = 32
      end
      inline uxTrussCopeCounter: TCounterFrame
        Tag = 3
        Left = 112
        Top = 76
        Width = 369
        Height = 37
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        ExplicitLeft = 112
        ExplicitTop = 76
      end
      inline uxTrussNotchCounter: TCounterFrame
        Tag = 4
        Left = 112
        Top = 121
        Width = 369
        Height = 37
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 3
        ExplicitLeft = 112
        ExplicitTop = 121
      end
      inline uxTrussLipPunchCounter: TCounterFrame
        Tag = 1
        Left = 112
        Top = 165
        Width = 369
        Height = 37
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 4
        ExplicitLeft = 112
        ExplicitTop = 165
      end
      inline uxTrussFlangePunchCounter: TCounterFrame
        Tag = 2
        Left = 112
        Top = 210
        Width = 369
        Height = 37
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 5
        ExplicitLeft = 112
        ExplicitTop = 210
      end
    end
    object tabPanelCounters: TTabSheet
      Caption = 'Panel Counters'
      ImageIndex = 11
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label72: TLabel
        Left = 267
        Top = -1
        Width = 38
        Height = 13
        Caption = 'Elapsed'
      end
      object Label73: TLabel
        Left = 352
        Top = -1
        Width = 40
        Height = 13
        Caption = 'Warning'
      end
      object bnReadPanelCounters: TBitBtn
        Left = 252
        Top = 330
        Width = 121
        Height = 25
        Caption = 'Read counters'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = bnReadPanelCountersClick
      end
      inline CounterFrameFlangePunch: TCounterFrame
        Tag = 2
        Left = 112
        Top = 215
        Width = 369
        Height = 34
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 5
        ExplicitLeft = 112
        ExplicitTop = 215
        ExplicitHeight = 34
      end
      inline CounterFrameLipPunch: TCounterFrame
        Tag = 1
        Left = 112
        Top = 176
        Width = 369
        Height = 37
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 4
        ExplicitLeft = 112
        ExplicitTop = 176
      end
      inline CounterFrameNotches: TCounterFrame
        Tag = 4
        Left = 112
        Top = 136
        Width = 369
        Height = 37
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 3
        ExplicitLeft = 112
        ExplicitTop = 136
      end
      inline CounterFrameService1s: TCounterFrame
        Tag = 6
        Left = 115
        Top = 57
        Width = 369
        Height = 37
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        ExplicitLeft = 115
        ExplicitTop = 57
        inherited uxCount: TEdit
          Left = 137
          ExplicitLeft = 137
        end
        inherited uxWarning: TEdit
          Left = 224
          ExplicitLeft = 224
        end
      end
      inline CounterFrameCut: TCounterFrame
        Left = 112
        Top = 18
        Width = 369
        Height = 33
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        ExplicitLeft = 112
        ExplicitTop = 18
        ExplicitHeight = 33
      end
      inline CounterFrameEndingBearingNotch: TCounterFrame
        Tag = 9
        Left = 112
        Top = 255
        Width = 369
        Height = 28
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 6
        ExplicitLeft = 112
        ExplicitTop = 255
        ExplicitHeight = 28
      end
      inline CounterFrameService2s: TCounterFrame
        Tag = 7
        Left = 112
        Top = 93
        Width = 369
        Height = 37
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        ExplicitLeft = 112
        ExplicitTop = 93
      end
      inline CounterFrameFlatenPunch: TCounterFrame
        Tag = 3
        Left = 112
        Top = 289
        Width = 369
        Height = 28
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 8
        ExplicitLeft = 112
        ExplicitTop = 289
        ExplicitHeight = 28
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Printing'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label43: TLabel
        Left = 61
        Top = 76
        Width = 102
        Height = 13
        Caption = 'Spacer / Service size'
        Visible = False
      end
      object Label49: TLabel
        Left = 61
        Top = 105
        Width = 106
        Height = 13
        Caption = 'Bearing / Bracing Size'
      end
      object Label4: TLabel
        Left = 88
        Top = 44
        Width = 79
        Height = 13
        Caption = 'Item ID Font size'
      end
      object prtradiusedit: TEdit
        Left = 180
        Top = 72
        Width = 29
        Height = 21
        TabOrder = 0
        Text = '25'
        Visible = False
      end
      object bearingsizeedit: TEdit
        Left = 180
        Top = 101
        Width = 53
        Height = 21
        TabOrder = 1
        Text = '10'
      end
      object BraceCBox: TCheckBox
        Left = 360
        Top = 43
        Width = 109
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Print truss braces'
        TabOrder = 2
      end
      object PrtServicecBox: TCheckBox
        Left = 356
        Top = 66
        Width = 113
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Print Service holes'
        TabOrder = 3
      end
      object MultiPrtCBox: TCheckBox
        Left = 344
        Top = 20
        Width = 125
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Two frames per page'
        TabOrder = 4
      end
      object websizecbox: TCheckBox
        Left = 364
        Top = 89
        Width = 105
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Include web sizes'
        TabOrder = 5
      end
      object prtfilepathcbox: TCheckBox
        Left = 380
        Top = 112
        Width = 89
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Print file path'
        TabOrder = 6
      end
      object ItemLabelRG: TRadioGroup
        Left = 368
        Top = 171
        Width = 107
        Height = 91
        Caption = 'Item labels'
        Items.Strings = (
          'Code + number'
          'Number only'
          'Neither')
        TabOrder = 7
      end
      object PrinterRG: TRadioGroup
        Left = 193
        Top = 185
        Width = 107
        Height = 70
        Caption = 'Orientation'
        Items.Strings = (
          'Portrait'
          'Landscape')
        TabOrder = 8
      end
      object ColourCBox: TCheckBox
        Left = 56
        Top = 130
        Width = 137
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Use Orientation Colours'
        TabOrder = 9
      end
      object fontsizeedit: TEdit
        Left = 180
        Top = 41
        Width = 33
        Height = 21
        TabOrder = 10
        Text = '8'
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Inkjet printer'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label28: TLabel
        Left = 210
        Top = 11
        Width = 52
        Height = 13
        Alignment = taRightJustify
        Caption = 'Printer Port'
      end
      object Label29: TLabel
        Left = 17
        Top = 318
        Width = 47
        Height = 13
        Caption = 'Command'
      end
      object label30: TLabel
        Left = 156
        Top = 90
        Width = 106
        Height = 13
        Caption = 'Actual character width'
      end
      object Label83: TLabel
        Left = 175
        Top = 64
        Width = 87
        Height = 13
        Alignment = taRightJustify
        Caption = 'Print head position'
      end
      object Label84: TLabel
        Left = 323
        Top = 66
        Width = 16
        Height = 13
        Caption = 'mm'
      end
      object Shape1: TShape
        Left = 23
        Top = 201
        Width = 517
        Height = 9
        Brush.Color = clGray
      end
      object Image1: TImage
        Left = 569
        Top = 0
        Width = 69
        Height = 61
        Picture.Data = {
          07544269746D617076020000424D760200000000000076000000280000002000
          0000200000000100040000000000000200000000000000000000100000000000
          0000000000000000800000800000008080008000000080008000808000008080
          8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00FFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0FFFFFFFFFFF
          FFFFFFFFFFFFFFFF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F0FFFFFFFFFFF
          FFFFFFFFFFFFFF0F0F0F0FFFFFFFFFFFFFFFFFFFFFFFFF0F0F0F0FFFFFFFFFFF
          FFFFFFFFFFFF0F0F000F0FFFFFFFFFFFFFFFFFFFFFFF0F0008000FFFFFFFFFFF
          FFFFFFFFFFFF0F0808880FFFFFFFFFFFFFFFFFFFFF0F0088088880FFFFFFFFFF
          FFFFFFFFFF0F088808888800FFFFFFFFFFFFFFFFFF008888088888880FFFFFFF
          FFFFFFFFFF088888088888880FFFFFFFFFFFFFFF00888888088888880FFFFFFF
          FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
          FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
          FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
          FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
          FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
          FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
          FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
          FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
          FFFF}
        Stretch = True
        Transparent = True
      end
      object Label85: TLabel
        Left = 217
        Top = 117
        Width = 45
        Height = 13
        Alignment = taRightJustify
        Caption = 'Job Code'
      end
      object Label86: TLabel
        Left = 123
        Top = 216
        Width = 24
        Height = 13
        Caption = 'Logo'
      end
      object label16: TLabel
        Left = 323
        Top = 89
        Width = 16
        Height = 13
        Caption = 'mm'
      end
      object Label12: TLabel
        Left = 219
        Top = 37
        Width = 43
        Height = 13
        Alignment = taRightJustify
        Caption = 'Baudrate'
      end
      object Label99: TLabel
        Left = 367
        Top = 11
        Width = 50
        Height = 13
        Caption = 'IP address'
      end
      object Label31: TLabel
        Left = 373
        Top = 42
        Width = 44
        Height = 13
        Caption = 'Serial no.'
      end
      object Com2Port: TEdit
        Left = 278
        Top = 7
        Width = 61
        Height = 21
        TabOrder = 0
        Text = 'Com2'
      end
      object Edit2: TEdit
        Left = 70
        Top = 310
        Width = 106
        Height = 21
        TabOrder = 1
      end
      object SendBtn: TButton
        Left = 182
        Top = 306
        Width = 55
        Height = 25
        Caption = 'Send'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = SendBtnClick
      end
      object SetDefaultsBtn: TBitBtn
        Left = 391
        Top = 247
        Width = 117
        Height = 36
        Caption = 'Send  configuration'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = SetDefaultsBtnClick
      end
      object FlushBtn: TBitBtn
        Left = 391
        Top = 289
        Width = 117
        Height = 29
        Caption = 'Flush'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = FlushBtnClick
      end
      object FCodecbox: TCheckBox
        Left = 156
        Top = 143
        Width = 83
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Frame code'
        TabOrder = 5
      end
      object IDescrCBox: TCheckBox
        Left = 138
        Top = 170
        Width = 101
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Item description'
        TabOrder = 6
      end
      object chrlength: TEdit
        Left = 278
        Top = 86
        Width = 39
        Height = 21
        TabOrder = 7
        Text = '14'
      end
      object headpos: TEdit
        Left = 278
        Top = 60
        Width = 39
        Height = 21
        TabOrder = 8
        Text = '140'
      end
      object HelpBtn: TBitBtn
        Left = 625
        Top = 288
        Width = 73
        Height = 25
        Kind = bkHelp
        NumGlyphs = 2
        TabOrder = 9
        OnClick = HelpBtnClick
      end
      object editjob: TEdit
        Left = 278
        Top = 113
        Width = 417
        Height = 21
        TabOrder = 10
      end
      object SetHeadPosBtn: TBitBtn
        Left = 267
        Top = 246
        Width = 118
        Height = 37
        Caption = 'Set head position'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = SetHeadPosBtnClick
      end
      object LogoEdit: TEdit
        Left = 166
        Top = 213
        Width = 269
        Height = 21
        TabOrder = 12
      end
      object LogoCBox: TCheckBox
        Left = 467
        Top = 216
        Width = 69
        Height = 17
        Caption = 'Activate'
        TabOrder = 13
      end
      object InkBtn: TBitBtn
        Left = 269
        Top = 289
        Width = 60
        Height = 29
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Ink'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        OnClick = InkBtnClick
      end
      object CleanBtn: TBitBtn
        Left = 330
        Top = 288
        Width = 56
        Height = 29
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Cleaner'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnClick = CleanBtnClick
      end
      object InkBaudDropBox: TComboBox
        Left = 278
        Top = 33
        Width = 61
        Height = 21
        TabOrder = 16
        Text = '57600'
        Items.Strings = (
          '9600'
          '19200'
          '57600'
          '115200')
      end
      object InkIPEdit: TEdit
        Left = 432
        Top = 8
        Width = 82
        Height = 21
        TabOrder = 17
        Text = '192.168.1.9'
      end
      object InkSerialEdit: TEdit
        Left = 432
        Top = 39
        Width = 82
        Height = 21
        TabOrder = 18
        Text = '201115'
      end
      object rgInkPrinter: TRadioGroup
        Left = 3
        Top = 6
        Width = 118
        Height = 128
        Caption = ' Print Device'
        Items.Strings = (
          'None'
          'DoD 2002'
          'SX-32'
          'VideoJet'
          'Sojet')
        TabOrder = 19
        OnClick = rgInkPrinterClick
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Miscellaneous'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label42: TLabel
        Left = 3
        Top = 64
        Width = 132
        Height = 13
        Caption = 'Max Current Display (A rms) '
      end
      object CommsMessageCBox: TCheckBox
        Left = 20
        Top = 100
        Width = 145
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Show comms messages'
        TabOrder = 0
      end
      object PowercBox: TCheckBox
        Left = 33
        Top = 24
        Width = 132
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Display power meter'
        TabOrder = 1
      end
      object CurrentEdit: TEdit
        Left = 154
        Top = 60
        Width = 45
        Height = 21
        TabOrder = 2
        Text = '7.5'
      end
      object Button1: TButton
        Left = 284
        Top = 58
        Width = 187
        Height = 25
        Caption = 'Check Joint version'
        TabOrder = 3
        OnClick = Button1Click
      end
      object USJointCBox: TCheckBox
        Left = 360
        Top = 102
        Width = 111
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Alignment = taLeftJustify
        Caption = 'USA Jointing '
        TabOrder = 4
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Logging'
      ImageIndex = 8
      OnShow = TabSheet9Show
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 972
        Height = 49
        Align = alTop
        TabOrder = 0
        object Label_MachineName: TLabel
          Left = 9
          Top = 17
          Width = 72
          Height = 13
          Caption = 'Machine Name'
        end
        object uxPauseReason: TCheckBox
          Left = 652
          Top = 15
          Width = 117
          Height = 32
          Align = alRight
          Alignment = taLeftJustify
          Caption = 'Log Pause Reasons'
          TabOrder = 0
          Visible = False
        end
        object uxLogToolOps: TCheckBox
          Left = 769
          Top = 15
          Width = 117
          Height = 32
          Align = alRight
          Alignment = taLeftJustify
          Caption = 'Log Tool Operations'
          TabOrder = 1
          Visible = False
        end
        object uxRecordJobDetails: TCheckBox
          Left = 549
          Top = 15
          Width = 103
          Height = 32
          Align = alRight
          Alignment = taLeftJustify
          Caption = 'Record Job Details'
          TabOrder = 2
        end
        object CheckBoxAuditDetails: TCheckBox
          Left = 886
          Top = 15
          Width = 84
          Height = 32
          Align = alRight
          Alignment = taLeftJustify
          Caption = 'Audit Details'
          TabOrder = 3
          Visible = False
        end
      end
      object DBGridDateInfo: TDBGrid
        Left = 0
        Top = 49
        Width = 972
        Height = 340
        Align = alClient
        DataSource = DataSourceDateInfo
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'RFINFODATE'
            Title.Alignment = taCenter
            Title.Caption = 'Date'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'CARDNUMBER'
            Title.Alignment = taCenter
            Title.Caption = 'Card Number'
            Width = 120
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'OriginUnit'
            Title.Alignment = taCenter
            Title.Caption = 'Origin Meters'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'RemainUnit'
            Title.Alignment = taCenter
            Title.Caption = 'Remain Meters'
            Width = 64
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'RUNSECONDS'
            Title.Alignment = taCenter
            Title.Caption = 'Total Production Time'
            Width = 120
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'PAUSETIME'
            Title.Alignment = taCenter
            Title.Caption = 'Pause Time'
            Width = 83
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'MetersUnit'
            Title.Alignment = taCenter
            Title.Caption = 'Meters'
            Width = 73
            Visible = True
          end>
      end
    end
    object tabLabelPrinting: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Label Printing'
      ImageIndex = 14
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SpeedButton8: TSpeedButton
        Left = 224
        Top = 189
        Width = 127
        Height = 40
        Caption = 'Setup label printer'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
          0003377777777777777308888888888888807F33333333333337088888888888
          88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
          8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
          8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
          03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
          03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
          33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
          33333337FFFF7733333333300000033333333337777773333333}
        NumGlyphs = 2
        OnClick = SpeedButton8Click
      end
      object Label78: TLabel
        Left = 65
        Top = 71
        Width = 73
        Height = 13
        Caption = 'Job Description'
      end
      object Label79: TLabel
        Left = 94
        Top = 111
        Width = 44
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Font Size'
      end
      object Label90: TLabel
        Left = 108
        Top = 150
        Width = 30
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Printer'
      end
      object LabelJobEdit: TEdit
        Left = 159
        Top = 68
        Width = 251
        Height = 21
        TabOrder = 0
      end
      object LabelFontEdit: TEdit
        Left = 159
        Top = 108
        Width = 99
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        TabOrder = 1
        Text = '15'
      end
      object labelprinteredit: TEdit
        Left = 159
        Top = 147
        Width = 212
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        ReadOnly = True
        TabOrder = 2
      end
    end
    object tabAbout: TTabSheet
      Caption = 'About'
      ImageIndex = 15
      OnShow = tabAboutShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label92: TLabel
        Left = 48
        Top = 22
        Width = 322
        Height = 33
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Alignment = taCenter
        AutoSize = False
        Caption = 'ScotRF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI Semibold'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 48
        Top = 200
        Width = 97
        Height = 13
        Caption = 'Comms as per V 130'
      end
      object uxVersionInfo: TMemo
        Left = 48
        Top = 48
        Width = 322
        Height = 146
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4144959
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          '1'
          '2'
          '3'
          '4'
          '5')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object bnCancel: TBitBtn
    Left = 70
    Top = 430
    Width = 102
    Height = 29
    Anchors = [akLeft, akBottom]
    Kind = bkCancel
    Margin = 4
    NumGlyphs = 2
    Spacing = 7
    TabOrder = 1
    OnClick = bnCancelClick
  end
  object bnSave: TBitBtn
    Left = 238
    Top = 430
    Width = 102
    Height = 29
    Anchors = [akLeft, akBottom]
    Caption = 'Save Settings'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Kind = bkOK
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    OnClick = bnSaveClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 471
    Width = 980
    Height = 19
    Panels = <>
  end
  object GroupBox2: TGroupBox
    Left = 407
    Top = 423
    Width = 162
    Height = 40
    Anchors = [akLeft, akBottom]
    Caption = 'Passwords'
    TabOrder = 4
    object BtnPwd1: TButton
      Left = 3
      Top = 16
      Width = 71
      Height = 21
      Caption = 'Setup'
      TabOrder = 0
      OnClick = BtnPwd1Click
    end
    object Button3: TButton
      Left = 80
      Top = 16
      Width = 71
      Height = 21
      Caption = 'Fabricate'
      TabOrder = 1
      OnClick = BtnPwd2Click
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Settings |*.rfs'
    Left = 846
    Top = 101
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 846
    Top = 48
  end
  object DataSourceDateInfo: TDataSource
    DataSet = DMRFDateInfo.FDMemTableItems
    Left = 868
    Top = 224
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofEnableSizing]
    Left = 760
    Top = 288
  end
end
