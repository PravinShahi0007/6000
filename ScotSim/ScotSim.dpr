program ScotSim;

uses
  Forms,
  mainU in 'mainU.pas' {frmMain},
  GlobalU in 'GlobalU.pas',
  UtilsU in 'UtilsU.pas',
  RectPropertiesForm in 'RectPropertiesForm.pas' {frmRectProperties},
  USettings in 'USettings.pas' {FormSettings},
  Entityunit in 'Entityunit.pas' {EntityForm},
  AdjustForJointsU in 'AdjustForJointsU.pas',
  OGLTextU in 'OGLTextU.pas',
  AboutU in 'AboutU.pas' {frmAbout},
  FontSettingsU in 'FontSettingsU.pas' {frmFontSettings},
  HoleAutoFormU in 'HoleAutoFormU.pas' {frmHoleAuto},
  ErrorsFormU in 'ErrorsFormU.pas' {frmErrors},
  UnitsU in 'UnitsU.pas',
  UpdateFormU in 'UpdateFormU.pas' {frmUpdate},
  HoleAuto_TLB in 'HoleAuto_TLB.pas',
  AddOpFormU in 'AddOpFormU.pas' {frmAddOperation},
  TranslateU in 'TranslateU.pas',
  UndoU in 'UndoU.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TFormSettings, FormSettings);
  Application.CreateForm(TEntityForm, EntityForm);
  Application.Run;
end.
