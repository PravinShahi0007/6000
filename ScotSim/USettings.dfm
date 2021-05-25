object FormSettings: TFormSettings
  Left = 257
  Top = 192
  CustomHint = BalloonHint1
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 445
  ClientWidth = 740
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    740
    445)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TBitBtn
    Left = 652
    Top = 410
    Width = 75
    Height = 25
    CustomHint = BalloonHint1
    Anchors = [akRight, akBottom]
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  object pgc: TPageControl
    Left = 0
    Top = 0
    Width = 740
    Height = 397
    CustomHint = BalloonHint1
    ActivePage = tabTrusses
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    TabStop = False
    object tabTrusses: TTabSheet
      CustomHint = BalloonHint1
      Caption = 'Trusses'
      DesignSize = (
        732
        369)
      object Label4: TLabel
        Left = 11
        Top = 14
        Width = 115
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Size of notch punch tool'
      end
      object lblCopeSize: TLabel
        Left = 11
        Top = 44
        Width = 111
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Size of cope punch tool'
      end
      object lblJointGap: TLabel
        Left = 11
        Top = 134
        Width = 45
        Height = 13
        Hint = 'Minimum distance between steel at a joint'
        CustomHint = BalloonHint1
        Caption = 'Joint Gap'
      end
      object lblHoleDist: TLabel
        Left = 11
        Top = 165
        Width = 83
        Height = 13
        Hint = 'Minimum distance from the hole edge to the end of the item'
        CustomHint = BalloonHint1
        Caption = 'Min Hole distance'
      end
      object lblCopeTol: TLabel
        Left = 11
        Top = 74
        Width = 113
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Cope / Notch Tolerance'
      end
      object Label1: TLabel
        Left = 11
        Top = 306
        Width = 31
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Gauge'
      end
      object Label9: TLabel
        Left = 84
        Top = 306
        Width = 117
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Exported File extension:'
      end
      object lblFileExt: TLabel
        Left = 207
        Top = 306
        Width = 18
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'TXF'
      end
      object Label10: TLabel
        Left = 423
        Top = 243
        Width = 35
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Lip Size'
      end
      object lblLipHoleHeight: TLabel
        Left = 391
        Top = 170
        Width = 71
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Lip Hole Height'
      end
      object lblFlgHoleHeight: TLabel
        Left = 395
        Top = 116
        Width = 72
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Flg Hole Height'
      end
      object Label2: TLabel
        Left = 443
        Top = 42
        Width = 43
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Hole Size'
      end
      object Shape1: TShape
        Left = 484
        Top = 76
        Width = 93
        Height = 5
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape2: TShape
        Left = 480
        Top = 76
        Width = 5
        Height = 149
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape3: TShape
        Left = 576
        Top = 76
        Width = 5
        Height = 149
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape4: TShape
        Left = 456
        Top = 224
        Width = 29
        Height = 5
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape5: TShape
        Left = 576
        Top = 224
        Width = 29
        Height = 5
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape6: TShape
        Left = 456
        Top = 204
        Width = 5
        Height = 25
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape7: TShape
        Left = 600
        Top = 204
        Width = 5
        Height = 25
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape13: TShape
        Left = 396
        Top = 80
        Width = 69
        Height = 1
        CustomHint = BalloonHint1
      end
      object Shape17: TShape
        Left = 428
        Top = 132
        Width = 1
        Height = 33
        CustomHint = BalloonHint1
      end
      object Shape16: TShape
        Left = 428
        Top = 80
        Width = 1
        Height = 33
        CustomHint = BalloonHint1
      end
      object lblHoleAuto: TLabel
        Left = 11
        Top = 350
        Width = 44
        Height = 13
        CustomHint = BalloonHint1
        Anchors = [akLeft, akBottom]
        Caption = 'HoleAuto'
        ExplicitTop = 334
      end
      object Label15: TLabel
        Left = 248
        Top = 204
        Width = 77
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Box Web Height'
      end
      object NotchSizeEdit: TEdit
        Left = 135
        Top = 11
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 0
        Text = '21'
      end
      object CopeSizeEdit: TEdit
        Left = 135
        Top = 41
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 1
        Text = '21'
      end
      object JointGapEdit: TEdit
        Left = 135
        Top = 131
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 3
        Text = '3'
      end
      object HoleDistanceEdit: TEdit
        Left = 135
        Top = 162
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 4
        Text = '15'
      end
      object CopeTolEdit: TEdit
        Left = 135
        Top = 71
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 2
        Text = '10'
      end
      object chkMinimiseLengths: TCheckBox
        Left = 11
        Top = 194
        Width = 216
        Height = 17
        CustomHint = BalloonHint1
        TabStop = False
        Alignment = taLeftJustify
        Caption = 'Minimise Lengths for Mitred ends'
        TabOrder = 10
      end
      object txtGauge: TEdit
        Left = 49
        Top = 303
        Width = 25
        Height = 21
        CustomHint = BalloonHint1
        MaxLength = 2
        TabOrder = 9
        Text = '24'
        OnChange = txtGaugeChange
      end
      object txtLipSize: TEdit
        Left = 503
        Top = 240
        Width = 34
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 8
        Text = '6'
      end
      object chkShortenBottomHorzItems: TCheckBox
        Left = 11
        Top = 276
        Width = 216
        Height = 17
        CustomHint = BalloonHint1
        TabStop = False
        Alignment = taLeftJustify
        Caption = 'Shorten Bottom Horizontal Items'
        TabOrder = 11
        Visible = False
      end
      object chkRequire2PtWebWeb: TCheckBox
        Left = 11
        Top = 222
        Width = 216
        Height = 17
        CustomHint = BalloonHint1
        TabStop = False
        Alignment = taLeftJustify
        Caption = 'Require 2 Points for Web-Web Joins'
        TabOrder = 12
      end
      object btnScotTrussSettings: TBitBtn
        Left = 425
        Top = 280
        Width = 180
        Height = 25
        CustomHint = BalloonHint1
        Caption = 'Get ScotTruss Settings...'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 13
        TabStop = False
        OnClick = btnScotTrussSettingsClick
      end
      object LipHoleHeightEdit: TEdit
        Left = 503
        Top = 167
        Width = 34
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 7
        Text = '37'
      end
      object FlangeHoleHeightEdit: TEdit
        Left = 503
        Top = 113
        Width = 34
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 6
        Text = '19'
      end
      object txtTrussHoleSize: TEdit
        Left = 503
        Top = 39
        Width = 34
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 5
        Text = '10'
      end
      object btnScotRFTrussSettings: TBitBtn
        Left = 425
        Top = 312
        Width = 180
        Height = 25
        CustomHint = BalloonHint1
        Caption = 'Get ScotRF - Truss Settings...'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 14
        TabStop = False
        OnClick = btnScotRFPanelSettingsClick
      end
      object chkUseBoxWebbing: TCheckBox
        Left = 248
        Top = 169
        Width = 123
        Height = 17
        CustomHint = BalloonHint1
        Alignment = taLeftJustify
        Caption = 'Use Box Webbing'
        TabOrder = 15
      end
      object txtBoxWebHeight: TEdit
        Left = 337
        Top = 201
        Width = 34
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 16
        Text = '40'
      end
      object chkTrussUseSwage: TCheckBox
        Left = 11
        Top = 103
        Width = 111
        Height = 17
        CustomHint = BalloonHint1
        TabStop = False
        Alignment = taLeftJustify
        Caption = 'Use Swage tool'
        TabOrder = 17
        OnClick = chkTrussUseSwageClick
      end
      object txtTrussSwageLength: TEdit
        Left = 135
        Top = 101
        Width = 50
        Height = 21
        Hint = 'Swage tool size for trusses'
        CustomHint = BalloonHint1
        Enabled = False
        TabOrder = 18
        Text = '64'
      end
    end
    object tabPanels: TTabSheet
      CustomHint = BalloonHint1
      Caption = 'Panels'
      ImageIndex = 1
      object Label3: TLabel
        Left = 343
        Top = 140
        Width = 54
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Hole height'
      end
      object Label5: TLabel
        Left = 467
        Top = 224
        Width = 42
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Hole size'
      end
      object Shape8: TShape
        Left = 411
        Top = 112
        Width = 29
        Height = 5
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape9: TShape
        Left = 595
        Top = 112
        Width = 29
        Height = 5
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape10: TShape
        Left = 619
        Top = 112
        Width = 5
        Height = 93
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape11: TShape
        Left = 411
        Top = 112
        Width = 5
        Height = 93
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape12: TShape
        Left = 411
        Top = 204
        Width = 213
        Height = 5
        CustomHint = BalloonHint1
        Pen.Color = clGray
        Pen.Width = 4
      end
      object Shape14: TShape
        Left = 343
        Top = 208
        Width = 57
        Height = 1
        CustomHint = BalloonHint1
      end
      object Shape15: TShape
        Left = 367
        Top = 160
        Width = 1
        Height = 49
        CustomHint = BalloonHint1
      end
      object Label6: TLabel
        Left = 11
        Top = 14
        Width = 91
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Flatten tool  length'
      end
      object Label11: TLabel
        Left = 11
        Top = 44
        Width = 82
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Notch tool length'
      end
      object Label12: TLabel
        Left = 11
        Top = 114
        Width = 92
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Service Hole length'
        Enabled = False
      end
      object Label13: TLabel
        Left = 11
        Top = 144
        Width = 99
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Plumbing Hole length'
        Enabled = False
      end
      object Label14: TLabel
        Left = 547
        Top = 84
        Width = 34
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Lip size'
      end
      object lblPanelJointGap: TLabel
        Left = 11
        Top = 226
        Width = 45
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Joint Gap'
      end
      object Label17: TLabel
        Left = 11
        Top = 256
        Width = 80
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Vertical joint gap'
      end
      object lblPanelHoleDist: TLabel
        Left = 11
        Top = 315
        Width = 64
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Hole distance'
      end
      object Label7: TLabel
        Left = 200
        Top = 44
        Width = 48
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Cut Width'
      end
      object Label8: TLabel
        Left = 11
        Top = 74
        Width = 78
        Height = 13
        CustomHint = BalloonHint1
        Caption = 'Notch Tolerance'
      end
      object txtFrameHoleHeight: TEdit
        Left = 426
        Top = 137
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 10
        Text = '25'
      end
      object txtPanelHoleSize: TEdit
        Left = 522
        Top = 221
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 12
        Text = '5.1'
      end
      object txtFlattenSize: TEdit
        Left = 135
        Top = 11
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 0
        Text = '50'
      end
      object txtPanelNotchSize: TEdit
        Left = 135
        Top = 41
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 1
        Text = '50'
      end
      object txtServiceHoleLen: TEdit
        Left = 135
        Top = 111
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        Enabled = False
        TabOrder = 3
      end
      object txtPlumbingHoleLen: TEdit
        Left = 135
        Top = 141
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        Enabled = False
        TabOrder = 4
      end
      object txtPanelLipSize: TEdit
        Left = 595
        Top = 81
        Width = 41
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 13
        Text = '6'
      end
      object txtPanelSwageLength: TEdit
        Left = 135
        Top = 181
        Width = 50
        Height = 21
        Hint = 'Swage tool size for panels'
        CustomHint = BalloonHint1
        TabOrder = 5
        Text = '65'
      end
      object txtPanelJointGap: TEdit
        Left = 135
        Top = 223
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 6
        Text = '3'
      end
      object txtVertJointGap: TEdit
        Left = 135
        Top = 253
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 7
        Text = '1'
      end
      object txtPanelHoleDist: TEdit
        Left = 135
        Top = 312
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 8
        Text = '10'
      end
      object chkPanelUseSwage: TCheckBox
        Left = 11
        Top = 183
        Width = 111
        Height = 17
        CustomHint = BalloonHint1
        TabStop = False
        Alignment = taLeftJustify
        Caption = 'Use Swage tool'
        Checked = True
        State = cbChecked
        TabOrder = 14
        OnClick = chkPanelUseSwageClick
      end
      object txtCutWidth: TEdit
        Left = 259
        Top = 41
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 9
        Text = '5'
      end
      object txtFlatNotchTol: TEdit
        Left = 135
        Top = 71
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 2
        Text = '10'
      end
      object chkIgnoreHoleDistErrors: TCheckBox
        Left = 213
        Top = 314
        Width = 209
        Height = 17
        CustomHint = BalloonHint1
        TabStop = False
        Caption = 'Ignore hole distance errors'
        TabOrder = 15
      end
      object btnScotRFPanelSettings: TBitBtn
        Left = 425
        Top = 333
        Width = 180
        Height = 25
        CustomHint = BalloonHint1
        Caption = 'Get ScotRF - Panel Settings...'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 16
        TabStop = False
        OnClick = btnScotRFPanelSettingsClick
      end
      object chkVirtualMitre: TCheckBox
        Left = 11
        Top = 343
        Width = 138
        Height = 17
        CustomHint = BalloonHint1
        TabStop = False
        Alignment = taLeftJustify
        Caption = 'Virtual Mitre'
        Checked = True
        State = cbChecked
        TabOrder = 17
      end
      object txtFrameHole2Height: TEdit
        Left = 426
        Top = 164
        Width = 50
        Height = 21
        Hint = 'Multi-hole height'
        CustomHint = BalloonHint1
        TabOrder = 11
        Text = '15'
      end
      object chkEndLoadCut: TCheckBox
        Left = 11
        Top = 283
        Width = 111
        Height = 17
        CustomHint = BalloonHint1
        Alignment = taLeftJustify
        Caption = 'End Load Cut'
        TabOrder = 18
      end
      object txtEndLoadCut: TEdit
        Left = 135
        Top = 281
        Width = 50
        Height = 21
        CustomHint = BalloonHint1
        TabOrder = 19
        Text = '8'
      end
    end
  end
  object chkIgnoreDuplicateOps: TCheckBox
    Left = 15
    Top = 414
    Width = 216
    Height = 17
    CustomHint = BalloonHint1
    TabStop = False
    Alignment = taLeftJustify
    Anchors = [akLeft, akBottom]
    Caption = 'Ignore Duplicate Operations'
    TabOrder = 2
  end
  object btnFont: TButton
    Left = 429
    Top = 410
    Width = 75
    Height = 25
    CustomHint = BalloonHint1
    Action = frmMain.actFont
    Anchors = [akLeft, akBottom]
    Images = frmMain.ilSmall
    TabOrder = 3
    TabStop = False
  end
  object BalloonHint1: TBalloonHint
    Left = 680
    Top = 40
  end
end
