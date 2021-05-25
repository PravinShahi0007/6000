object PanelWizardForm: TPanelWizardForm
  Left = 698
  Top = 341
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'Panel Wizard'
  ClientHeight = 206
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    382
    206)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 0
    Top = 4
    Width = 33
    Height = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Length'
  end
  object Label1: TLabel
    Left = 203
    Top = 5
    Width = 37
    Height = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akBottom]
    Caption = 'Number'
  end
  object bnOK: TBitBtn
    Left = 292
    Top = 160
    Width = 75
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 0
    OnClick = bnOKClick
  end
  object BitBtn2: TBitBtn
    Left = 208
    Top = 160
    Width = 75
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 48
    Top = 0
    Width = 97
    Height = 21
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 2
    Text = '0'
  end
  object GroupBox2: TGroupBox
    Left = 192
    Top = 32
    Width = 177
    Height = 117
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'End 2'
    TabOrder = 3
    object Label4: TLabel
      Left = 16
      Top = 24
      Width = 42
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Hole pos'
    end
    object Label8: TLabel
      Left = 20
      Top = 56
      Width = 38
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Flat size'
    end
    object Label10: TLabel
      Left = 16
      Top = 84
      Width = 50
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Notch size'
    end
    object E2pos: TEdit
      Left = 92
      Top = 20
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 0
      Text = '0'
    end
    object E2Flat: TEdit
      Left = 92
      Top = 52
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 1
      Text = '0'
    end
    object E2notch: TEdit
      Left = 92
      Top = 80
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 2
      Text = '0'
    end
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 32
    Width = 177
    Height = 117
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'End 1'
    TabOrder = 4
    object Label3: TLabel
      Left = 16
      Top = 24
      Width = 42
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Hole pos'
    end
    object Label7: TLabel
      Left = 20
      Top = 56
      Width = 38
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Flat size'
    end
    object Label9: TLabel
      Left = 16
      Top = 88
      Width = 50
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Notch size'
    end
    object E1pos: TEdit
      Left = 92
      Top = 20
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 0
      Text = '0'
    end
    object E1Flat: TEdit
      Left = 92
      Top = 52
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 1
      Text = '0'
    end
    object E1notch: TEdit
      Left = 92
      Top = 84
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 2
      Text = '0'
    end
  end
  object DblRivetsCB: TCheckBox
    Left = 20
    Top = 166
    Width = 87
    Height = 14
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Alignment = taLeftJustify
    Caption = 'Double rivets'
    TabOrder = 5
  end
  object edCount: TEdit
    Left = 251
    Top = 1
    Width = 33
    Height = 21
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akBottom]
    TabOrder = 6
    Text = '1'
  end
  object UpDown1: TUpDown
    Left = 284
    Top = 1
    Width = 16
    Height = 21
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akBottom]
    Associate = edCount
    Min = 1
    Position = 1
    TabOrder = 7
  end
end
