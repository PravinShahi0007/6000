unit ErrorsFormU;

{
Form to display errors encountered from the ProcessTruss routine
}

interface

uses
  Windows, Messages, SysUtils,
  Variants, Classes, Graphics,
  Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfrmErrors = class(TForm)
    imgIcon: TImage;
    memErrors: TMemo;
    BitBtn1: TBitBtn;
    lblErrorDesc: TLabel;
    btnSave: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure memErrorsChange(Sender: TObject);
  private
  public
    class procedure ShowErrors(AHeading: string; AStrings: TStrings); static;
    class procedure AddToErrorsForm(sError: string); static;
  end;

  procedure ShowErrorInformation(ErrNum: Integer);

var
  frmErrors: TfrmErrors;
  SLErrorItems: TStringList;

implementation

uses GlobalU, TranslateU;

{$R *.dfm}

procedure TfrmErrors.FormCreate(Sender: TObject);
begin
  imgIcon.Picture.Icon.Handle := LoadIcon(0, IDI_HAND);  {IDI_EXCLAMATION}

  TranslateForm(Self);
end;

//* Open a dialog to save the contents of the memo to a text file
procedure TfrmErrors.btnSaveClick(Sender: TObject);
begin
  with TSaveDialog.Create(Application)do
  begin
    try
      Options := Options + [ofOverwritePrompt];
      DefaultExt := TXT_EXT;
      Filter := TEXT_FILES_FILTER;
      if Execute then
        memErrors.Lines.SaveToFile(FileName);
    finally
      Free;
    end;
  end;
end;

//* Enable the Save button when the memo's contents change
procedure TfrmErrors.memErrorsChange(Sender: TObject);
begin
  btnSave.Enabled := memErrors.Lines.Count > 0;
end;

//* Open a dialog which uses ErrNum for the Title, and
//* displays the error strings collected from the ProcessTruss routine.
//* This routine can be optionally called after calling ProcessTruss.
//* The dialog only displays if ErrNum between -7 and -1 (RESULT_NOT_FOUND and RESULT_ADDED_NOTCH_ERR)
procedure ShowErrorInformation(ErrNum: Integer);
var
  s: string;
begin
  //Errors must have a -ve number, RESULT_ADDED_NOTCH_ERR is the lowest so far
  if (ErrNum >= 0)or(ErrNum < RESULT_ADDED_NOTCH_ERR)then //or(SLErrorItems.Count = 0)
    exit;
  with TfrmErrors.Create(Application)do
  begin
    try
      s := '';
      case ErrNum of
        RESULT_NOT_FOUND:       s := 'Min End Distance error';
        RESULT_NOT_INITIALISED: s := 'DLL not initialised';
        RESULT_LIP_LT_FLG:      s := 'Lip Hole Height is less than Flg Hole Height';
        RESULT_HOLE_ERR:        s := 'Hole error';
        RESULT_RANGE_ERR:       s := 'Range error';
        RESULT_ADDED_COPE_ERR:  if (not bFrames)then
                                  s := 'Added cope error'
                                else
                                  s := 'Added flat error';
        RESULT_ADDED_NOTCH_ERR: s := 'Added notch error';
      end;
      lblErrorDesc.Caption := s;
      memErrors.Lines.Assign(SLErrorItems);

      ShowModal;
    finally
      Free;
    end;
  end;
end;

class procedure TfrmErrors.AddToErrorsForm(sError: string);
begin
  if frmErrors = nil then
  begin
    MessageDlg(sError, mtError, [mbOK], 0);
    exit;
  end;

  if frmErrors.memErrors.Lines.IndexOf(sError) < 0 then
    frmErrors.memErrors.Lines.Add(sError);
end;

class procedure TfrmErrors.ShowErrors(AHeading: string; AStrings: TStrings);
var
  form: TfrmErrors;
begin
  form := TfrmErrors.Create(Application);
  try
    form.lblErrorDesc.Caption := AHeading;
    if AStrings <> nil then
      form.memErrors.Lines.Assign(AStrings);
    form.ShowModal;
  finally
    form.Free;
  end;
end;


initialization
  SLErrorItems := TStringList.Create;

finalization
  SLErrorItems.Free;
  SLErrorItems := nil;

END.
 
