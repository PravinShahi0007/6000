unit Pin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TPinForm = class(TForm)
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  function String2Pin(s:string):string;
  public
    { Public declarations }
    ValidPin:boolean;
    PinCode:string;
  end;

var
  PinForm: TPinForm;

implementation

{$R *.dfm}

function TPinForm.String2Pin(s:string):string;
var digits:boolean;
    i,e1,e2:integer;
    d1,d2,d:word;
begin
result:='';
digits:=true;
if length(s)=10 then
   begin
   for i:=1 to 10 do if pos(copy(s,i,1),'0123456789') = 0 then digits:=false;
   if digits then
      for i:= 1 to 5 do
         begin
         val(copy(s,i*2-1,1),d1,e1);
         val(copy(s,i*2,1),d2,e2);
         d:=d1*16+d2;
         showmessage(inttostr(d));
         result:=result+chr(d); // 5 bcd digits;
         result:=#$0A + #$0B + #$0C + result; // 8 bytes required;
         ValidPin:=true;
         end
      else
         MessageDlg('Invalid Pin', mtwarning,[mbOk], 0);
    end
  else
    MessageDlg('Invalid Pin', mtwarning,[mbOk], 0);
end;

procedure TPinForm.FormShow(Sender: TObject);
begin
ValidPin:=false;
end;

procedure TPinForm.BitBtn1Click(Sender: TObject);
begin
PinCode:='';
if RadioButton1.Checked then
   begin
   PinCode := #$1C+#$13+#$7B+#$05+#$22+#$B7+#$B0+#$D2; //PanelCard
   ValidPin:=true;
   end
  else if RadioButton2.Checked then
          begin
          PinCode := #198+#207+#160+#106+#135+#20+#188+#212;  // TrussCard
          ValidPin:=true;
          end
        else if PinForm.RadioButton3.Checked then
          PinCode := String2Pin(Edit1.Text);
if ValidPin and (PinCode <> '') then Close;
end;

end.
