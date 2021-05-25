object FormJobFound: TFormJobFound
  Left = 0
  Top = 0
  Caption = 'Job Found'
  ClientHeight = 192
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MemoJobInformation: TMemo
    Left = 0
    Top = 0
    Width = 446
    Height = 151
    Align = alClient
    TabOrder = 0
  end
  object PanelButtons: TPanel
    Left = 0
    Top = 151
    Width = 446
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 16
      Top = 6
      Width = 113
      Height = 25
      Caption = 'Load as a new job'
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 160
      Top = 6
      Width = 130
      Height = 25
      Caption = 'Transfer the job'
      ModalResult = 6
      TabOrder = 1
      Visible = False
    end
    object Button3: TButton
      Left = 312
      Top = 6
      Width = 113
      Height = 25
      Caption = 'Ignore'
      ModalResult = 5
      TabOrder = 2
    end
  end
end
