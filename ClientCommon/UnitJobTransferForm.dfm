object FormJobTransfer: TFormJobTransfer
  Left = 0
  Top = 0
  Caption = 'Job Transfer'
  ClientHeight = 255
  ClientWidth = 559
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
  object PanelButtons: TPanel
    Left = 0
    Top = 214
    Width = 559
    Height = 41
    Align = alBottom
    TabOrder = 0
    object ButtonCancel: TButton
      Left = 352
      Top = 6
      Width = 105
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object ButtonOk: TButton
      Left = 120
      Top = 6
      Width = 97
      Height = 25
      Caption = '&Ok'
      ModalResult = 1
      TabOrder = 1
    end
  end
  object DBGridRollFormer: TDBGrid
    Left = 0
    Top = 0
    Width = 559
    Height = 214
    Align = alClient
    DataSource = DataSourceRollFormer
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Name'
        Title.Caption = 'RollFormer Name'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Width = 500
        Visible = True
      end>
  end
  object FDMemTableRollFormer: TFDMemTable
    OnFilterRecord = FDMemTableRollFormerFilterRecord
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 384
    Top = 104
  end
  object DataSourceRollFormer: TDataSource
    DataSet = FDMemTableRollFormer
    Left = 384
    Top = 160
  end
end
