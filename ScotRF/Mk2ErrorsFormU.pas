unit Mk2ErrorsFormU;

{
 Form to display error details of AdjustForJoints
}
interface

uses
  Windows, Messages, Forms, SysUtils, ComCtrls, StdCtrls, Buttons, Controls, Classes, ExtCtrls;

type
  TfrmMk2Errors = class(TForm)
    imgIcon: TImage;
    memErrors: TMemo;
    bnOk: TBitBtn;
    lblErrorDesc: TLabel;
    StatusBar1: TStatusBar;
    bnCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    class function Show(ACaption: string;AList: TStrings;bCanCancel: boolean): boolean;
  end;

implementation

{$R *.dfm}

procedure TfrmMk2Errors.FormCreate(Sender: TObject);
begin
  imgIcon.Picture.Icon.Handle := LoadIcon(0, IDI_HAND); {IDI_EXCLAMATION}
end;

class function TfrmMk2Errors.Show(ACaption: string;AList: TStrings; bCanCancel: boolean): boolean;
var
 Form: TfrmMk2Errors;
begin
  Form := TfrmMk2Errors.Create(nil);
  try
    with Form do
    begin
      lblErrorDesc.Caption := ACaption;
      memErrors.Lines.Assign(AList);
      bnCancel.visible:= bCanCancel;
      if not bCanCancel then
        bnOk.left:=112;
    end;
    Result := Form.ShowModal=mrOK;
  finally
    FreeAndNil(Form);
  end;
end;

END.
