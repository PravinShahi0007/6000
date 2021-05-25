object frmRectProperties: TfrmRectProperties
  Left = 510
  Top = 148
  BorderStyle = bsDialog
  Caption = 'Rectangle Properties'
  ClientHeight = 277
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    411
    277)
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 9
    Top = 170
    Width = 27
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Name'
    ExplicitTop = 199
  end
  object Label8: TLabel
    Left = 9
    Top = 213
    Width = 33
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Length'
  end
  object btnDelete: TSpeedButton
    Left = 264
    Top = 170
    Width = 104
    Height = 30
    Caption = 'Delete'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FF0732DE0732DEFF00FF0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DEFF00FFFF00FF0732DE
      0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732
      DE0732DEFF00FFFF00FFFF00FF0732DE0732DD0732DE0732DEFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FF
      0534ED0732DF0732DE0732DEFF00FFFF00FFFF00FFFF00FF0732DE0732DEFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732DE0732DDFF
      00FF0732DD0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF0732DD0633E60633E60633E90732DCFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0633E307
      32E30534EFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF0732DD0534ED0533E90434EF0434F5FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0434F40534EF0533EBFF
      00FFFF00FF0434F40335F8FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF0335FC0534EF0434F8FF00FFFF00FFFF00FFFF00FF0335FC0335FBFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB0335FCFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF0335FB0335FBFF00FFFF00FFFF00FFFF00FF0335FB
      0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FF0335FBFF00FFFF00FF0335FB0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    OnClick = btnDeleteClick
  end
  object lblTotalLength: TLabel
    Left = 9
    Top = 251
    Width = 60
    Height = 13
    Caption = 'Total Length'
    Enabled = False
  end
  object gpRectInfo: TGroupBox
    Left = 1
    Top = 0
    Width = 225
    Height = 153
    Caption = 'Rect'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 30
      Width = 33
      Height = 13
      Caption = 'Point 1'
    end
    object Label2: TLabel
      Left = 8
      Top = 60
      Width = 33
      Height = 13
      Caption = 'Point 2'
    end
    object Label3: TLabel
      Left = 8
      Top = 90
      Width = 33
      Height = 13
      Caption = 'Point 3'
    end
    object Label4: TLabel
      Left = 8
      Top = 120
      Width = 33
      Height = 13
      Caption = 'Point 4'
    end
    object Label5: TLabel
      Left = 93
      Top = 10
      Width = 6
      Height = 13
      Caption = 'X'
    end
    object Label6: TLabel
      Left = 174
      Top = 10
      Width = 6
      Height = 13
      Caption = 'Y'
    end
    object txtX1: TEdit
      Left = 65
      Top = 26
      Width = 65
      Height = 21
      TabOrder = 0
    end
    object txtY1: TEdit
      Left = 145
      Top = 26
      Width = 65
      Height = 21
      TabOrder = 1
    end
    object txtX2: TEdit
      Left = 65
      Top = 56
      Width = 65
      Height = 21
      TabOrder = 2
    end
    object txtY2: TEdit
      Left = 145
      Top = 56
      Width = 65
      Height = 21
      TabOrder = 3
    end
    object txtX3: TEdit
      Left = 65
      Top = 86
      Width = 65
      Height = 21
      TabOrder = 4
    end
    object txtY3: TEdit
      Left = 145
      Top = 86
      Width = 65
      Height = 21
      TabOrder = 5
    end
    object txtY4: TEdit
      Left = 145
      Top = 116
      Width = 65
      Height = 21
      TabOrder = 7
    end
    object txtX4: TEdit
      Left = 65
      Top = 116
      Width = 65
      Height = 21
      TabOrder = 6
    end
  end
  object BitBtn2: TBitBtn
    Left = 325
    Top = 246
    Width = 80
    Height = 25
    Anchors = [akRight, akBottom]
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 4
  end
  object BitBtn1: TBitBtn
    Left = 231
    Top = 246
    Width = 80
    Height = 25
    Anchors = [akRight, akBottom]
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 3
  end
  object chkWeb: TCheckBox
    Left = 147
    Top = 166
    Width = 65
    Height = 17
    TabStop = False
    Alignment = taLeftJustify
    Anchors = [akLeft, akBottom]
    Caption = 'Web'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object txtName: TEdit
    Left = 49
    Top = 167
    Width = 81
    Height = 21
    Anchors = [akLeft, akBottom]
    MaxLength = 10
    TabOrder = 1
  end
  object txtLength: TEdit
    Left = 49
    Top = 210
    Width = 81
    Height = 21
    Anchors = [akLeft, akBottom]
    MaxLength = 10
    TabOrder = 2
  end
  object chkMulti: TCheckBox
    Left = 147
    Top = 189
    Width = 65
    Height = 17
    TabStop = False
    Alignment = taLeftJustify
    Anchors = [akLeft, akBottom]
    Caption = 'Multi'
    TabOrder = 6
  end
  object chkHideItem: TCheckBox
    Left = 147
    Top = 212
    Width = 65
    Height = 17
    TabStop = False
    Alignment = taLeftJustify
    Anchors = [akLeft, akBottom]
    Caption = 'Hide Item'
    TabOrder = 7
  end
  object gpTransform: TGroupBox
    Left = 231
    Top = 0
    Width = 174
    Height = 153
    Caption = 'Transform'
    TabOrder = 8
    object btnRotate: TSpeedButton
      Left = 33
      Top = 60
      Width = 104
      Height = 30
      Caption = 'Rotate'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFF9FFFFFFFFFFFFFF999FFFFFFFFFFFF9F9F9FFFFFFFFFFFFF9FFFF
        FFFF00000009000000000FFFFFF9FFFFFFF00FFFFFF9FFFFFFF00FFFFFF9FFFF
        FFF00FFFFFF9FFFFFFF0CCCCCCC9CCCCCCCCFFFFFFF9FFFFFFFFFFFFF9F9F9FF
        FFFFFFFFFF999FFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = btnRotateClick
    end
    object btnReverse: TSpeedButton
      Left = 33
      Top = 14
      Width = 104
      Height = 30
      Caption = 'Reverse'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF00000000000000000FFFFFFFFFFFFFF00FFFFFFFFFFFFFF00FFFFFFFFFFF
        FFF00FFFFFFFFFFFFFF0CCCCCCCCCCCCCCCCFFFF9FFFFFF9FFFFFFF9FFFFFFFF
        9FFFFF999999999999FFFFF9FFFFFFFF9FFFFFFF9FFFFFF9FFFF}
      OnClick = btnReverseClick
    end
    object btnFlip: TSpeedButton
      Left = 33
      Top = 106
      Width = 104
      Height = 30
      Caption = 'Flip'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFF0FFFFFF
        9FFFFFFF0F0FFFF9FFFFFFF0FFF0FF9999FFFF0FFFFF0FF9FF9FF0FFFFFFF0FF
        9FF9FF0FFFFFFF0FFFF9FFF0FFFFFFF0FFF9FFFF0FFFFFFF0FFFFFFFF0FFFFFF
        F0FF9FFFFF0FFFFFFF0F9FFFFFF0FFFFFFF09FF9FFFF0FFFFF0FF9FF9FFFF0FF
        F0FFFF9999FFFF0F0FFFFFFF9FFFFFF0FFFFFFF9FFFFFFFFFFFF}
      OnClick = btnFlipClick
    end
  end
end
