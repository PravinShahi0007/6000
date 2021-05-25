object frmFontSettings: TfrmFontSettings
  Left = 383
  Top = 220
  BorderStyle = bsDialog
  Caption = 'Font'
  ClientHeight = 183
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    201
    183)
  PixelsPerInch = 96
  TextHeight = 13
  object gpFont: TGroupBox
    Left = 0
    Top = 0
    Width = 201
    Height = 153
    Anchors = []
    TabOrder = 0
    object cboFace: TComboBox
      Left = 16
      Top = 24
      Width = 169
      Height = 21
      Style = csDropDownList
      DropDownCount = 16
      TabOrder = 0
      OnClick = cboFaceClick
    end
    object chkBold: TCheckBox
      Left = 134
      Top = 52
      Width = 50
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Bold'
      TabOrder = 1
      OnClick = cboFaceClick
    end
    object pnlSample: TPanel
      Left = 16
      Top = 96
      Width = 169
      Height = 41
      BevelOuter = bvLowered
      Caption = 'Sample'
      TabOrder = 2
    end
    object chkItalic: TCheckBox
      Left = 134
      Top = 71
      Width = 50
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Italic'
      TabOrder = 3
      OnClick = cboFaceClick
    end
    object cboSize: TComboBox
      Left = 16
      Top = 51
      Width = 40
      Height = 21
      DropDownCount = 16
      TabOrder = 4
      Text = '8'
      OnClick = cboFaceClick
      Items.Strings = (
        '8'
        '9'
        '10'
        '11'
        '12'
        '14'
        '16'
        '18'
        '20'
        '22'
        '24'
        '26'
        '28'
        '36'
        '48'
        '72')
    end
  end
  object btnOK: TBitBtn
    Left = 7
    Top = 157
    Width = 90
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object btnCancel: TBitBtn
    Left = 104
    Top = 157
    Width = 90
    Height = 25
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 2
  end
end
