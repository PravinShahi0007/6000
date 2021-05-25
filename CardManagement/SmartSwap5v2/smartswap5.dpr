program smartswap5;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  VersionU in 'VersionU.pas',
  RegU in 'RegU.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
