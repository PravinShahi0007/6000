object frmHoleAuto: TfrmHoleAuto
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'HoleAuto Coords'
  ClientHeight = 478
  ClientWidth = 522
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    522
    478)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 3
    Top = 0
    Width = 108
    Height = 13
    Caption = 'Please select the items'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 70
    Height = 13
    Caption = 'From HoleAuto'
  end
  object Label3: TLabel
    Left = 272
    Top = 56
    Width = 58
    Height = 13
    Caption = 'As 2 Entities'
  end
  object lstEntityDetails: TListBox
    Left = 264
    Top = 76
    Width = 250
    Height = 364
    Style = lbOwnerDrawFixed
    Anchors = [akLeft, akTop, akBottom]
    MultiSelect = True
    PopupMenu = popLst
    TabOrder = 5
    OnDrawItem = lstHoleAutoDetailsDrawItem
    OnMouseDown = lstHoleAutoDetailsMouseDown
  end
  object lstHoleAutoDetails: TListBox
    Left = 0
    Top = 76
    Width = 250
    Height = 364
    Style = lbOwnerDrawFixed
    Anchors = [akLeft, akTop, akBottom]
    MultiSelect = True
    PopupMenu = popLst
    TabOrder = 4
    OnDrawItem = lstHoleAutoDetailsDrawItem
    OnMouseDown = lstHoleAutoDetailsMouseDown
  end
  object cboItem1: TComboBox
    Left = 0
    Top = 14
    Width = 145
    Height = 21
    Style = csDropDownList
    DropDownCount = 15
    TabOrder = 0
    OnChange = cboItem1Change
  end
  object cboItem2: TComboBox
    Left = 160
    Top = 14
    Width = 145
    Height = 21
    Style = csDropDownList
    DropDownCount = 15
    TabOrder = 1
    OnChange = cboItem1Change
  end
  object BitBtn1: TBitBtn
    Left = 440
    Top = 448
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Kind = bkClose
    TabOrder = 2
  end
  object radUnits: TRadioGroup
    Left = 314
    Top = 0
    Width = 200
    Height = 39
    Caption = 'Units'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Metric'
      'Imperial')
    TabOrder = 3
    OnClick = cboItem1Change
  end
  object popLst: TPopupMenu
    OnPopup = popLstPopup
    Left = 176
    Top = 208
    object mnuCopy: TMenuItem
      Caption = 'Copy'
      OnClick = mnuCopyClick
    end
    object mnuSelectAll: TMenuItem
      Caption = 'Select All'
      OnClick = mnuSelectAllClick
    end
  end
end
