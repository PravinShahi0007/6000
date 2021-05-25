unit pause;
{
Form to display 'PAUSE' when RF is paused by tool button or Screen pause button
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  Tpauseform = class(TForm)
    Label1: TLabel;
  private
  public
  end;

  var
  pauseform: Tpauseform;

implementation
{$R *.dfm}

end.
