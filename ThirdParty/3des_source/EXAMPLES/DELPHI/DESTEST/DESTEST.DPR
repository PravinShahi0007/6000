program DEStest;

uses
  Forms,
  frmctest in 'frmctest.pas' {frmCipherTest};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmCipherTest, frmCipherTest);
  Application.Run;
end.
