unit FontSettingsU;

{
Form to select the font for the OpenGL display
}

interface

uses
  Windows, Messages, SysUtils,
  Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmFontSettings = class(TForm)
    gpFont: TGroupBox;
    cboFace: TComboBox;
    chkBold: TCheckBox;
    pnlSample: TPanel;
    chkItalic: TCheckBox;
    cboSize: TComboBox;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    procedure cboFaceClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private     { Private declarations }

  public      { Public declarations }
  
  end;

var
  frmFontSettings: TfrmFontSettings;

implementation

uses TranslateU;

{$R *.dfm}

procedure TfrmFontSettings.cboFaceClick(Sender: TObject);
begin
  if chkBold.Checked then
    pnlSample.Font.Style := pnlSample.Font.Style + [fsBold]
  else
    pnlSample.Font.Style := pnlSample.Font.Style - [fsBold];

  if chkItalic.Checked then
    pnlSample.Font.Style := pnlSample.Font.Style + [fsItalic]
  else
    pnlSample.Font.Style := pnlSample.Font.Style - [fsItalic];

  if cboSize.Text <> '' then
    pnlSample.Font.Size := StrToIntDef(cboSize.Text,10);

  pnlSample.Font.Name := cboFace.Text;
end;

procedure TfrmFontSettings.FormCreate(Sender: TObject);
var
  SLFontsList: TStringList;
begin
  SLFontsList := TStringList.Create;
  try        //Use a StringList to filter out duplicate font names
    SLFontsList.Duplicates := dupIgnore;
    SLFontsList.AddStrings(Screen.Fonts);
    cboFace.Items.AddStrings(SLFontsList);
    cboFace.Sorted := True;
  finally
    SLFontsList.Free;
  end;

  TranslateForm(Self);
end;

END.
