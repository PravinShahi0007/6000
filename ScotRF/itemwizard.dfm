object Itemwizardform: TItemwizardform
  Left = 555
  Top = 361
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'Items'
  ClientHeight = 202
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    369
    202)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 0
    Top = 5
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
  object bnOk: TBitBtn
    Left = 292
    Top = 177
    Width = 75
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 0
    OnClick = bnOkClick
  end
  object BitBtn2: TBitBtn
    Left = 204
    Top = 177
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
    Left = 44
    Top = 1
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
    Top = 33
    Width = 177
    Height = 133
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'End 2'
    TabOrder = 3
    object Label4: TLabel
      Left = 16
      Top = 24
      Width = 57
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Lip hole pos'
    end
    object Label6: TLabel
      Left = 16
      Top = 52
      Width = 57
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Flg hole pos'
    end
    object Label8: TLabel
      Left = 16
      Top = 80
      Width = 46
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Cope size'
    end
    object Label10: TLabel
      Left = 16
      Top = 108
      Width = 50
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Notch size'
    end
    object E2lippos: TEdit
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
    object E2flgpos: TEdit
      Left = 92
      Top = 48
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 1
      Text = '0'
    end
    object E2cope: TEdit
      Left = 92
      Top = 76
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 2
      Text = '0'
    end
    object E2notch: TEdit
      Left = 92
      Top = 104
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 3
      Text = '0'
    end
  end
  object GroupBox1: TGroupBox
    Left = 4
    Top = 33
    Width = 177
    Height = 133
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'End 1'
    TabOrder = 4
    object Label3: TLabel
      Left = 16
      Top = 24
      Width = 57
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Lip hole pos'
    end
    object Label5: TLabel
      Left = 16
      Top = 52
      Width = 57
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Flg hole pos'
    end
    object Label7: TLabel
      Left = 16
      Top = 80
      Width = 46
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Cope size'
    end
    object Label9: TLabel
      Left = 16
      Top = 108
      Width = 50
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Notch size'
    end
    object E1lippos: TEdit
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
    object E1flgpos: TEdit
      Left = 92
      Top = 48
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 1
      Text = '0'
    end
    object E1cope: TEdit
      Left = 92
      Top = 76
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 2
      Text = '0'
    end
    object E1notch: TEdit
      Left = 92
      Top = 104
      Width = 73
      Height = 21
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 3
      Text = '0'
    end
  end
  object BoxWebcBox: TCheckBox
    Left = 20
    Top = 177
    Width = 93
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Box web'
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
