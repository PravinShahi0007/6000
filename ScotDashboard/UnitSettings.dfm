inherited MDIChildSettings: TMDIChildSettings
  Caption = 'Settings'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBoxServer: TGroupBox
    Left = 138
    Top = 72
    Width = 263
    Height = 25
    TabOrder = 0
    object LabelServer: TLabel
      Left = 3
      Top = 2
      Width = 39
      Height = 13
      Caption = 'Server :'
    end
    object LabelPort: TLabel
      Left = 175
      Top = 3
      Width = 27
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
      Top = 1
      Width = 50
      Height = 21
      TabOrder = 1
    end
  end
  object ButtonSave: TButton
    Left = 424
    Top = 69
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
end
