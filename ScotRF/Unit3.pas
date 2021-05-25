unit Unit3;

{
 Value entry form for entering machine manual distance move value
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, units, winUtils;

type
  TDlgMove = class(TForm)
    Label1: TLabel;
    editdist: TEdit;
    bnOK: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure bnOKClick(Sender: TObject);
  private
    function getLength: double;
  public
    property Length: double read getLength;
  end;

var DlgMove: TDlgMove;

implementation

{$R *.DFM}

procedure TDlgMove.FormShow(Sender: TObject);
begin
  Activecontrol := editdist;
end;

function TDlgMove.getLength: double;
begin
  result := strToFloatDef(UnitsIn(editdist.text), 0);
end;

procedure TDlgMove.bnOKClick(Sender: TObject);
begin
  check(Length>0,'Invalid Length');
  modalResult:=mrOK
end;

end.
