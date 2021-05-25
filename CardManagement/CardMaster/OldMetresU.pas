unit OldMetresU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmOldMetres = class(TForm)
    bnOK: TBitBtn;
    Edit1: TEdit;
    procedure bnOKClick(Sender: TObject);
  private
    FType: char;
    procedure getMetres;
    procedure setMetres(N: integer);
  public
    class procedure exec(AType: char); static;
  end;

implementation

{$R *.dfm}
{ TfrmOldMetres }

procedure TfrmOldMetres.bnOKClick(Sender: TObject);
var N: integer;
begin
  N := strToIntDef(Edit1.text,-1);
  if (N > 0) and (N < 51) then
    setMetres(N)
  else
    messagedlg('values 1 - 50 allowed', mtInformation, [mbok] , 0);
end;

class procedure TfrmOldMetres.exec(AType: char);
var frmOldMetres: TfrmOldMetres;
begin
  frmOldMetres := TfrmOldMetres.Create(Application);
  try
    frmOldMetres.FType := AType;
    frmOldMetres.getMetres;
  finally
    frmOldMetres.Free;
  end;

end;

procedure TfrmOldMetres.getMetres;
begin

end;

procedure TfrmOldMetres.setMetres(N: integer);
begin

end;

end.
