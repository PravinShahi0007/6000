object frmAddOperation: TfrmAddOperation
  Left = 0
  Top = 0
  CustomHint = BalloonHint1
  BorderStyle = bsSizeToolWin
  Caption = 'Add an Operation'
  ClientHeight = 333
  ClientWidth = 650
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object gpOperation: TGroupBox
    Left = 8
    Top = 8
    Width = 201
    Height = 281
    CustomHint = BalloonHint1
    Caption = 'Operation'
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 194
      Width = 44
      Height = 16
      CustomHint = BalloonHint1
      Caption = 'Position'
    end
    object radCope: TRadioButton
      Left = 24
      Top = 32
      Width = 160
      Height = 17
      CustomHint = BalloonHint1
      Caption = 'Cope'
      TabOrder = 0
      OnClick = txtDistanceChange
    end
    object radNotch: TRadioButton
      Left = 24
      Top = 64
      Width = 160
      Height = 17
      CustomHint = BalloonHint1
      Caption = 'Notch'
      TabOrder = 1
      OnClick = txtDistanceChange
    end
    object radSmallServiceHole: TRadioButton
      Left = 60
      Top = 16
      Width = 160
      Height = 17
      CustomHint = BalloonHint1
      Caption = 'Small Service Hole'
      TabOrder = 2
      Visible = False
      OnClick = txtDistanceChange
    end
    object radLargeServiceHole: TRadioButton
      Left = 76
      Top = 16
      Width = 160
      Height = 17
      CustomHint = BalloonHint1
      Caption = 'Large Service Hole'
      TabOrder = 3
      Visible = False
      OnClick = txtDistanceChange
    end
    object radSwage: TRadioButton
      Left = 92
      Top = 16
      Width = 160
      Height = 17
      CustomHint = BalloonHint1
      Caption = 'Swage'
      TabOrder = 4
      Visible = False
      OnClick = txtDistanceChange
    end
    object radLipHole: TRadioButton
      Left = 24
      Top = 96
      Width = 160
      Height = 17
      CustomHint = BalloonHint1
      Caption = 'Lip Hole'
      TabOrder = 6
      OnClick = txtDistanceChange
    end
    object txtDistance: TEdit
      Left = 96
      Top = 191
      Width = 88
      Height = 24
      CustomHint = BalloonHint1
      TabOrder = 7
      OnChange = txtDistanceChange
    end
    object btnAdd: TButton
      Left = 96
      Top = 237
      Width = 88
      Height = 25
      Hint = 'Click to add the operation to the list'
      CustomHint = BalloonHint1
      Caption = 'Add'
      Enabled = False
      TabOrder = 8
      OnClick = btnAddClick
    end
    object radFlgHole: TRadioButton
      Left = 24
      Top = 128
      Width = 160
      Height = 17
      CustomHint = BalloonHint1
      Caption = 'Flange Hole'
      TabOrder = 9
      OnClick = txtDistanceChange
    end
    object radSlot: TRadioButton
      Left = 108
      Top = 16
      Width = 160
      Height = 17
      CustomHint = BalloonHint1
      Caption = 'Slotted Hole'
      TabOrder = 5
      Visible = False
      OnClick = txtDistanceChange
    end
  end
  object btnOK: TBitBtn
    Left = 309
    Top = 297
    Width = 120
    Height = 25
    CustomHint = BalloonHint1
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object btnCancel: TBitBtn
    Left = 441
    Top = 297
    Width = 120
    Height = 25
    CustomHint = BalloonHint1
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object lvOperations: TListView
    Tag = -1
    Left = 224
    Top = 16
    Width = 337
    Height = 273
    Hint = 'Click a column header to sort the list'
    CustomHint = BalloonHint1
    Columns = <
      item
        Caption = 'Operation'
        Width = 159
      end
      item
        AutoSize = True
        Caption = 'Position'
      end>
    GridLines = True
    RowSelect = True
    TabOrder = 3
    ViewStyle = vsReport
    OnChange = lvOperationsChange
    OnColumnClick = lvOperationsColumnClick
    OnCompare = lvOperationsCompare
    OnSelectItem = lvOperationsSelectItem
  end
  object btnRemove: TButton
    Left = 567
    Top = 39
    Width = 75
    Height = 25
    Hint = 'Click to remove the selected item from the list'
    CustomHint = BalloonHint1
    Caption = 'Remove'
    Enabled = False
    TabOrder = 4
    OnClick = btnRemoveClick
  end
  object BalloonHint1: TBalloonHint
    Left = 576
    Top = 192
  end
end
