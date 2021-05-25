program CardMaster;

uses
  Forms,
  sysutils,
  Windows,
  MainU in 'MainU.pas' {Main},
  CardAPIU in 'CardAPIU.pas' {CardApi: TDataModule},
  InputDetailU in 'InputDetailU.pas' {InputDetail},
  FormatDetailU in 'FormatDetailU.pas' {FormatDetail},
  CardNewU in 'CardNewU.pas',
  WinUtils in 'WinUtils.pas',
  PasswordU in 'PasswordU.pas' {pwdForm},
  WinSCard in 'WinSCard.pas',
  CardU in 'CardU.pas',
  OldMetresU in 'OldMetresU.pas' {frmOldMetres};

{$R *.res}

begin
  try
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    CardApi:= TCardApi.create(nil);
    CardApi.Initialise;
    Application.CreateForm(TMain, Main);
    Application.Run;
  except
    on e: exception do
        messagebox(0,pchar(e.classname + ' ' + e.message),'',0);

  end;
end.

