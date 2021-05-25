object VMForm: TVMForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Virtual Operations'
  ClientHeight = 791
  ClientWidth = 286
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline Billboard1: TBillboard
    Left = 0
    Top = 0
    Width = 286
    Height = 791
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 286
    ExplicitHeight = 791
    inherited Panel1: TPanel
      Width = 286
      Height = 791
      ExplicitWidth = 286
      ExplicitHeight = 791
      inherited Label1: TLabel
        Top = 522
        ExplicitTop = 522
      end
    end
  end
end
