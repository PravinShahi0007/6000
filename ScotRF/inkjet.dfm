object Inkjetform: TInkjetform
  Left = 240
  Top = 166
  AutoSize = True
  BorderWidth = 5
  Caption = 'Inkjet printer settings'
  ClientHeight = 372
  ClientWidth = 245
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
  object Label1: TLabel
    Left = 60
    Top = 4
    Width = 52
    Height = 13
    Caption = 'Printer Port'
  end
  object Label2: TLabel
    Left = 9
    Top = 296
    Width = 47
    Height = 13
    Caption = 'Command'
  end
  object Label3: TLabel
    Left = 11
    Top = 127
    Width = 106
    Height = 13
    Caption = 'Actual character width'
  end
  object Label4: TLabel
    Left = 172
    Top = 86
    Width = 16
    Height = 13
    Caption = 'mm'
  end
  object Label5: TLabel
    Left = 28
    Top = 158
    Width = 87
    Height = 13
    Caption = 'Print head position'
  end
  object Label6: TLabel
    Left = 179
    Top = 127
    Width = 16
    Height = 13
    Caption = 'mm'
  end
  object Shape1: TShape
    Left = 0
    Top = 114
    Width = 235
    Height = 5
  end
  object Image1: TImage
    Left = 0
    Top = 20
    Width = 31
    Height = 45
    Picture.Data = {
      07544269746D617076020000424D760200000000000076000000280000002000
      0000200000000100040000000000000200000000000000000000100000000000
      0000000000000000800000800000008080008000000080008000808000008080
      8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00FFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0FFFFFFFFFFF
      FFFFFFFFFFFFFFFF0F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F0FFFFFFFFFFF
      FFFFFFFFFFFFFF0F0F0F0FFFFFFFFFFFFFFFFFFFFFFFFF0F0F0F0FFFFFFFFFFF
      FFFFFFFFFFFF0F0F000F0FFFFFFFFFFFFFFFFFFFFFFF0F0008000FFFFFFFFFFF
      FFFFFFFFFFFF0F0808880FFFFFFFFFFFFFFFFFFFFF0F0088088880FFFFFFFFFF
      FFFFFFFFFF0F088808888800FFFFFFFFFFFFFFFFFF008888088888880FFFFFFF
      FFFFFFFFFF088888088888880FFFFFFFFFFFFFFF00888888088888880FFFFFFF
      FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
      FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
      FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
      FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
      FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
      FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
      FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
      FFFFFFFF08888888088888880FFFFFFFFFFFFFFF08888888088888880FFFFFFF
      FFFF}
    Transparent = True
  end
  object Label7: TLabel
    Left = 72
    Top = 84
    Width = 45
    Height = 13
    Caption = 'Job Code'
  end
  object BitBtn1: TBitBtn
    Left = 170
    Top = 347
    Width = 75
    Height = 25
    Caption = 'Save'
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 84
    Top = 347
    Width = 75
    Height = 25
    Caption = 'Close'
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object com2port: TEdit
    Left = 130
    Top = 0
    Width = 49
    Height = 21
    TabOrder = 2
    Text = 'Com2'
  end
  object Edit2: TEdit
    Left = 73
    Top = 292
    Width = 106
    Height = 21
    TabOrder = 3
  end
  object Button1: TButton
    Left = 186
    Top = 290
    Width = 55
    Height = 25
    Caption = 'Send'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = Button1Click
  end
  object BitBtn3: TBitBtn
    Left = 54
    Top = 221
    Width = 144
    Height = 28
    Caption = 'Send default configuration'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = BitBtn3Click
  end
  object BitBtn4: TBitBtn
    Left = 93
    Top = 257
    Width = 60
    Height = 24
    Caption = 'Flush'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 6
    OnClick = BitBtn4Click
  end
  object FCodecbox: TCheckBox
    Left = 58
    Top = 32
    Width = 85
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Frame code'
    TabOrder = 7
  end
  object IDescrCBox: TCheckBox
    Left = 42
    Top = 58
    Width = 101
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Item description'
    TabOrder = 8
  end
  object chrlength: TEdit
    Left = 128
    Top = 125
    Width = 39
    Height = 21
    TabOrder = 9
    Text = '14'
  end
  object headpos: TEdit
    Left = 128
    Top = 154
    Width = 39
    Height = 21
    TabOrder = 10
    Text = '140'
  end
  object BitBtn5: TBitBtn
    Left = 0
    Top = 347
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkHelp
    ParentDoubleBuffered = False
    TabOrder = 11
    OnClick = BitBtn5Click
  end
  object editjob: TEdit
    Left = 128
    Top = 80
    Width = 101
    Height = 21
    TabOrder = 12
  end
  object BitBtn6: TBitBtn
    Left = 54
    Top = 182
    Width = 144
    Height = 27
    Caption = 'Set head position'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 13
    OnClick = BitBtn6Click
  end
end
