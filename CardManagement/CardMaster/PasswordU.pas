unit PasswordU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TpwdForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Edit1: TEdit;
  private
  public
  end;

function InputPassword(const APrompt: string): string; overload;
function InputPassword(const ACaption, APrompt: string): string; overload;

implementation

{$R *.dfm}

uses math;

function InputPassword(const APrompt: string): string; overload;
begin
  Result := InputPassword('ScotRF', APrompt);
end;

function InputPassword(const ACaption, APrompt: string): string;
var pwdForm: TpwdForm;
begin
  Result := '';
  pwdForm := TpwdForm.Create(Application);
  with pwdForm do
    try
      Caption := ACaption;
      Label1.Caption := APrompt;
      Edit1.left := Label1.left + Label1.Width + 8;
      clientwidth := max(clientwidth, Edit1.left + Edit1.Width + 12);
      if showModal = mrOK then
        Result := Edit1.text;
    finally
      Free
    end;
end;

end.
