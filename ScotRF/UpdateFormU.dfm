object frmUpdate: TfrmUpdate
  Left = 330
  Top = 376
  BorderStyle = bsToolWindow
  Caption = 'Update Application'
  ClientHeight = 108
  ClientWidth = 287
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnGetZip: TSpeedButton
    Left = 68
    Top = 34
    Width = 150
    Height = 22
    Caption = 'Get Zip Update'
    Enabled = False
    OnClick = btnGetZipClick
  end
  object btnGetChangesFile: TSpeedButton
    Left = 68
    Top = 60
    Width = 150
    Height = 22
    Caption = 'Get Changes File'
    Enabled = False
    OnClick = btnGetChangesFileClick
  end
  object btnSelfUpdate: TSpeedButton
    Left = 68
    Top = 8
    Width = 150
    Height = 22
    Caption = 'Self Update'
    Enabled = False
    OnClick = btnSelfUpdateClick
  end
  object sBar: TStatusBar
    Left = 0
    Top = 89
    Width = 287
    Height = 19
    Panels = <
      item
        Width = 75
      end
      item
        Alignment = taCenter
        Width = 50
      end>
    OnResize = sBarResize
  end
  object pBar: TProgressBar
    Left = 16
    Top = 96
    Width = 150
    Height = 16
    Position = 50
    Smooth = True
    TabOrder = 1
  end
end
