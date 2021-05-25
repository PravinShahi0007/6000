object PortListForm: TPortListForm
  Left = 574
  Top = 330
  BorderStyle = bsToolWindow
  BorderWidth = 3
  Caption = 'Available Ports'
  ClientHeight = 152
  ClientWidth = 130
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 24
    Top = 120
    Width = 83
    Height = 29
    DoubleBuffered = True
    Kind = bkClose
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  object SerialList: TListBox
    Left = 4
    Top = 8
    Width = 121
    Height = 97
    ItemHeight = 13
    TabOrder = 1
  end
end
