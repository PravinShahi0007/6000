unit serialports;

{
 Displays serial ports from registry
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, registry;

type
  TPortListForm = class(TForm)
    BitBtn1: TBitBtn;
    SerialList: TListBox;
  private
    procedure Initialise;
  public
    class function Exec: boolean;
  end;

implementation

{$R *.dfm}
{ TPortListForm }

class function TPortListForm.Exec: boolean;
var Form: TPortListForm;
begin
  Form := TPortListForm.Create(nil);
  try
    Form.Initialise;
    result := Form.showmodal=mrOK;
  finally
    Form.Free;
  end;
end;

procedure TPortListForm.Initialise;
var
  i: integer;
  R: TRegistry;
begin
  R := TRegistry.Create;
  try
    R.rootkey := HKEY_LOCAL_MACHINE;
    if R.keyexists('HARDWARE') and R.openkeyReadOnly('HARDWARE')then
    begin
      if R.keyexists('DEVICEMAP') and R.openkeyReadOnly('DEVICEMAP')then
      begin
        if R.keyexists('SERIALCOMM') and R.openkeyReadOnly('SERIALCOMM')then
        begin
          R.GetValueNames(SerialList.items);
          for i := 0 to SerialList.items.count - 1 do
            SerialList.items[i]:= R.readstring(SerialList.items[i]);
        end
      end;
    end;
  finally
    R.Free;
  end;
end;

end.
