object EntityForm: TEntityForm
  Left = 365
  Top = 354
  BorderStyle = bsSizeToolWin
  Caption = 'Item details'
  ClientHeight = 454
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    450
    454)
  PixelsPerInch = 96
  TextHeight = 16
  object lblName: TLabel
    Left = 17
    Top = 10
    Width = 52
    Height = 16
    Caption = 'Filename'
  end
  object Label2: TLabel
    Left = 251
    Top = 10
    Width = 26
    Height = 16
    Caption = 'Item'
  end
  object Label3: TLabel
    Left = 17
    Top = 40
    Width = 38
    Height = 16
    Caption = 'Length'
  end
  object lblWeb: TLabel
    Left = 251
    Top = 40
    Width = 26
    Height = 16
    Caption = 'Web'
  end
  object lblOrientation: TLabel
    Left = 251
    Top = 70
    Width = 68
    Height = 16
    Caption = 'Orientation:'
  end
  object lblProfile: TLabel
    Left = 17
    Top = 70
    Width = 36
    Height = 16
    Caption = 'Profile'
  end
  object lblOperations: TLabel
    Left = 251
    Top = 100
    Width = 71
    Height = 16
    Caption = 'Operations: '
  end
  object lblTotalLength: TLabel
    Left = 17
    Top = 100
    Width = 71
    Height = 16
    Caption = 'Total Length'
    Enabled = False
  end
  object txtTruss: TEdit
    Left = 88
    Top = 7
    Width = 108
    Height = 24
    Enabled = False
    TabOrder = 0
  end
  object txtItemIndex: TEdit
    Left = 305
    Top = 7
    Width = 41
    Height = 24
    Enabled = False
    TabOrder = 1
  end
  object txtLength: TEdit
    Left = 88
    Top = 37
    Width = 108
    Height = 24
    Enabled = False
    TabOrder = 2
    Text = '0'
  end
  object memInfo: TMemo
    Left = 4
    Top = 157
    Width = 440
    Height = 291
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object chkDistancesFromFarEnd: TCheckBox
    Left = 17
    Top = 130
    Width = 216
    Height = 17
    Caption = 'Show as distances from far end'
    TabOrder = 4
    OnClick = chkDistancesFromFarEndClick
  end
  object memInfo2: TMemo
    Left = 26
    Top = 171
    Width = 440
    Height = 291
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 5
    Visible = False
  end
end
