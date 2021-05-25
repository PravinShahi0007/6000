unit AboutU;

{
About form for Displaying ScotSim version
also has links to the Update form and a link to the website
}

interface

uses
  Windows, Messages, SysUtils,
  Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, StdCtrls,
  ShellAPI,
  ExtCtrls, Buttons, jpeg;

type
  TfrmAbout = class(TForm)
    lblFileVer: TLabel;
    lblWebsite: TLabel;
    lblCheckForUpdate: TLabel;
    Image1: TImage;
    BalloonHint1: TBalloonHint;
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure lblWebsiteClick(Sender: TObject);
    procedure lblCheckForUpdateClick(Sender: TObject);
  private   { Private declarations }

  public    { Public declarations }
    
  end;

  procedure ShowUpdateForm;

var
  frmAbout: TfrmAbout;

implementation

uses
  UpdateFormU, TranslateU;  //, AdjustForJointsU;

{$R *.dfm}

//* Open and run a file
function ExecuteFile(const FileName: string): THandle;
var
  zFileName: array[0..pred(MAX_PATH)] of Char;
begin
  Result := ShellExecute(Application.MainForm.Handle, nil,
    StrPCopy(zFileName, FileName), PChar(''), PChar(''), SW_SHOW);
end;

//* Initialize the form, extracting and displaying the file version
procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  lblFileVer.Caption := 'version: ' + GetFileVersion;
  //lblCopyright.Caption := GetCopyright;
  //if HoleAutoJoinAdjustStr <> JOIN_ADJUST then
  //  ShowMessage('HoleAuto.dll needs to be updated');

  TranslateForm(Self);
end;

procedure TfrmAbout.FormClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

//* Go to the website
procedure TfrmAbout.lblWebsiteClick(Sender: TObject);
begin
  ExecuteFile(lblWebsite.Hint);
end;

//* Open the Update Form
procedure ShowUpdateForm;
begin
  with TfrmUpdate.Create(Application)do
  begin
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmAbout.lblCheckForUpdateClick(Sender: TObject);
begin
  ShowUpdateForm;
end;

END.
