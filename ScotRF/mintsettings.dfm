object mintform: Tmintform
  Left = 290
  Top = 123
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'RF Mint settings'
  ClientHeight = 400
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 27
    Top = 12
    Width = 84
    Height = 13
    Caption = 'Max. motor speed'
  end
  object Label2: TLabel
    Left = 27
    Top = 50
    Width = 88
    Height = 13
    Caption = 'Motor acceleration'
  end
  object Shape2: TShape
    Left = 0
    Top = 244
    Width = 345
    Height = 5
  end
  object bnOpen: TSpeedButton
    Left = 300
    Top = 297
    Width = 23
    Height = 22
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
      333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
      0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
      07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
      07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
      0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
      B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
      3BB33773333773333773B333333B3333333B7333333733333337}
    NumGlyphs = 2
    OnClick = bnOpenClick
  end
  object Shape1: TShape
    Left = 0
    Top = 148
    Width = 345
    Height = 5
  end
  object Label3: TLabel
    Left = 8
    Top = 168
    Width = 96
    Height = 13
    Caption = 'Rated Motor Current'
  end
  object Label4: TLabel
    Left = 4
    Top = 208
    Width = 104
    Height = 13
    Caption = 'Allowed Motor Current'
  end
  object BitBtn1: TBitBtn
    Left = 127
    Top = 338
    Width = 88
    Height = 29
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 0
  end
  object uxMaxSpeed: TEdit
    Left = 130
    Top = 8
    Width = 65
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object UpDown1: TUpDown
    Left = 210
    Top = 0
    Width = 29
    Height = 37
    Min = -200
    Max = 200
    TabOrder = 2
    OnClick = UpDown1Click
  end
  object uxMaxAccel: TEdit
    Left = 130
    Top = 46
    Width = 65
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object UpDown2: TUpDown
    Left = 210
    Top = 40
    Width = 29
    Height = 37
    Min = -200
    Max = 200
    TabOrder = 4
    OnClick = UpDown2Click
  end
  object uxFile: TEdit
    Left = 4
    Top = 264
    Width = 261
    Height = 21
    TabOrder = 5
  end
  object bnMexDownload: TBitBtn
    Left = 144
    Top = 296
    Width = 122
    Height = 25
    Caption = 'MEX DownlLoad'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = bnMexDownloadClick
  end
  object bnFirmwareDownload: TBitBtn
    Left = 4
    Top = 296
    Width = 129
    Height = 25
    Caption = 'Firmware Download'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = bnFirmwareDownloadClick
  end
  object bnSaveMax: TBitBtn
    Left = 256
    Top = 52
    Width = 68
    Height = 23
    Caption = 'Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = bnSaveMaxClick
  end
  object bnReadMax: TBitBtn
    Left = 256
    Top = 17
    Width = 67
    Height = 23
    Caption = 'Read'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = bnReadMaxClick
  end
  object uxRatedCurrent: TEdit
    Left = 126
    Top = 164
    Width = 113
    Height = 21
    Color = cl3DLight
    ReadOnly = True
    TabOrder = 10
  end
  object uxAllowedCurrent: TEdit
    Left = 124
    Top = 204
    Width = 113
    Height = 21
    Enabled = False
    TabOrder = 11
  end
  object bnReadRatedCurrent: TBitBtn
    Left = 257
    Top = 162
    Width = 67
    Height = 25
    Caption = 'Read'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    OnClick = bnReadRatedCurrentClick
  end
  object bnSaveMotorCurrent: TBitBtn
    Left = 256
    Top = 202
    Width = 67
    Height = 25
    Caption = 'Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnClick = bnSaveMotorCurrentClick
  end
  object ckTempComp: TCheckBox
    Left = 28
    Top = 78
    Width = 169
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Temperature Compensation'
    TabOrder = 14
  end
  object gpCharge: TGroupBox
    Left = 8
    Top = 101
    Width = 297
    Height = 41
    Caption = 'Charge'
    TabOrder = 15
    Visible = False
    object cbCharge: TComboBox
      Left = 64
      Top = 13
      Width = 74
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'Standard'
      Items.Strings = (
        'Standard'
        'Red'
        'Gold')
    end
    object bnSaveCharge: TBitBtn
      Left = 190
      Top = 12
      Width = 68
      Height = 23
      Caption = 'Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = bnSaveChargeClick
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Mex files|*.mex|Firmware Files|*.chx'
    Left = 36
    Top = 336
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 264
    Top = 352
    object miSetMachineType: TMenuItem
      Caption = 'Set MT'
      RadioItem = True
      OnClick = miSetMachineTypeClick
    end
  end
end
