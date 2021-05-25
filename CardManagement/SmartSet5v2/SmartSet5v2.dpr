program SmartSet5v2;

uses
  Forms,
  UnitSmartSetMain in 'UnitSmartSetMain.pas' {FormSmartSet},
  VersionU in 'VersionU.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'SteelCard';
  Application.CreateForm(TFormSmartSet, FormSmartSet);
  Application.Run;
end.
