unit itemhelp;
{
Item help form for manual design editor
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TItemhelpform = class(TForm)
    Memo1: TMemo;
    bnClose: TBitBtn;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Itemhelpform: TItemhelpform;

implementation

{$R *.DFM}

procedure TItemhelpform.FormCreate(Sender: TObject);
begin
  {$IFDEF PANEL}
  Memo2.Visible:=false;
  Caption:='Panel Design Syntax'
  {$ELSE}
  Memo1.Visible:=false;
  bnClose.Top:= Memo2.Top+Memo2.Height+8;
  Caption:='Truss Design Syntax'
  {$ENDIF}
end;

end.
