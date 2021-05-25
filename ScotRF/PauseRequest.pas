unit PauseRequest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TPauseRequestForm = class(TForm)
    ComboBoxPauseReason: TComboBox;
    Label1: TLabel;
    BitBtnOK: TBitBtn;
  private
    { Private declarations }
    Function GetPauseReason : String;
  public
    { Public declarations }
    property PauseReason:string read GetPauseReason;
  end;


function GetPauseReason: string;

implementation

{$R *.dfm}

function GetPauseReason: string;
var
  PauseRequestForm: TPauseRequestForm;
begin
  PauseRequestForm:= TPauseRequestForm.create(application);
  try
    PauseRequestForm.ShowModal;
    Result := PauseRequestForm.PauseReason;
  finally
    FreeAndNil(PauseRequestForm);
  end;
end;

Function TPauseRequestForm.GetPauseReason : String;
begin
  Result := ComboBoxPauseReason.Text;
end;


end.
