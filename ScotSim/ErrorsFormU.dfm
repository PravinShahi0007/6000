object frmErrors: TfrmErrors
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Error'
  ClientHeight = 256
  ClientWidth = 311
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
    311
    256)
  PixelsPerInch = 96
  TextHeight = 13
  object imgIcon: TImage
    Left = 8
    Top = 8
    Width = 32
    Height = 32
  end
  object lblErrorDesc: TLabel
    Left = 56
    Top = 16
    Width = 25
    Height = 13
    Caption = 'Error:'
  end
  object memErrors: TMemo
    Left = 8
    Top = 48
    Width = 297
    Height = 169
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = memErrorsChange
  end
  object BitBtn1: TBitBtn
    Left = 200
    Top = 224
    Width = 100
    Height = 25
    Anchors = [akRight, akBottom]
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object btnSave: TBitBtn
    Left = 16
    Top = 224
    Width = 100
    Height = 25
    Caption = '&Save'
    DoubleBuffered = True
    Enabled = False
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
      8888880000000000000880330000008803088033000000880308803300000088
      0308803300000000030880333333333333088033000000003308803088888888
      0308803088888888030880308888888803088030888888880308803088888888
      0008803088888888080880000000000000088888888888888888}
    ParentDoubleBuffered = False
    TabOrder = 2
    OnClick = btnSaveClick
  end
end
