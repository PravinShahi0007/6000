unit UnitScotDashBoard;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.Menus, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, Winapi.Messages,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdActns, Vcl.ActnList, Vcl.ToolWin,
  Vcl.ImgList, System.ImageList, System.Actions,
  Vcl.WinXPickers, Vcl.WinXCalendars, Datasnap.DSCommon, DBXJSON, JSON,
  UnitLiveRollFormer, System.Generics.Collections, Vcl.DBCtrls;

type

  TChildType = (ctRFLiveStatus, ctDashboard, ctRFHistoryChart, ctSiteProduction, ctJobProduction, ctJobLive, ctLoadEP2, ctSettings);

  TFormScotDashBoard = class(TForm)
    MainMenuMainForm: TMainMenu;
    File1: TMenuItem;
    Window1: TMenuItem;
    Help1: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowTileItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    WindowMinimizeItem: TMenuItem;
    StatusBar: TStatusBar;
    ActionListMainForm: TActionList;
    FileExit1: TAction;
    WindowCascade1: TWindowCascade;
    WindowTileHorizontal1: TWindowTileHorizontal;
    WindowArrangeAll1: TWindowArrange;
    WindowMinimizeAll1: TWindowMinimizeAll;
    HelpAbout1: TAction;
    FileClose1: TWindowClose;
    WindowTileVertical1: TWindowTileVertical;
    WindowTileItem2: TMenuItem;
    ToolBarMain: TToolBar;
    ToolButtonProduction: TToolButton;
    ToolButton7: TToolButton;
    ToolButtonCascade: TToolButton;
    ToolButtonVertical: TToolButton;
    ImageListMainForm: TImageList;
    ActionRefreshData: TAction;
    ToolButtonProjects: TToolButton;
    ActionLoadEP2: TAction;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    CalendarPickerStart: TCalendarPicker;
    CalendarPickerEnd: TCalendarPicker;
    ToolButtonRFMonitor: TToolButton;
    ClientCallback_ChannelManager: TDSClientCallbackChannelManager;
    ActionSettings: TAction;
    ActionProduction: TAction;
    ActionRFMonitor: TAction;
    ActionProjects: TAction;
    Settings1: TMenuItem;
    ActionRFMonitor1: TMenuItem;
    Production1: TMenuItem;
    RollFormerStatus1: TMenuItem;
    ActionRFHIstory: TAction;
    MenuRFHIstory: TMenuItem;
    ToolButtonRFHistory: TToolButton;
    ToolButtonHorizontal: TToolButton;
    ToolButtonRefreshData: TToolButton;
    ToolButton1: TToolButton;
    ActionLoadJobWithoutAssignToMachine: TAction;
    ClientCallback_ChannelManagerLiveJob: TDSClientCallbackChannelManager;
    procedure ActionProductionExecute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure FileNew2Execute(Sender: TObject);
    procedure ActionProjectsExecute(Sender: TObject);
    procedure ActionLoadEP2Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CalendarPickerEndChange(Sender: TObject);
    procedure CalendarPickerStartChange(Sender: TObject);
    procedure ActionRFMonitorExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionSettingsExecute(Sender: TObject);
    procedure ActionRFHIstoryExecute(Sender: TObject);
    procedure ActionRefreshDataExecute(Sender: TObject);
    procedure ActionLoadJobWithoutAssignToMachineExecute(Sender: TObject);
  private
    { Private declarations }
    FDashboardCallBackName : String;
    FJobLiveCallBackName   : String;
    procedure CreateMDIChild(aChildType: TChildType);
    function ChildFormExists(aForm : tForm): boolean;
  public
    { Public declarations }
  end;

var
  FormScotDashBoard: TFormScotDashBoard;

implementation

{$R *.dfm}

uses UnitCHILDWIN, UnitAbout, UnitChildRFStatus,
  UnitChildJobStatus, UnitChildLoadEP2, UnitDMLoadEP2Files, UnitDMDesignJob,
  UnitDMRFStatus, DateUtils, UnitRFLiveStatus, DataSnap.DSSession,
  ScotRFTypes, UnitSettings, PBThreadedSplashscreenU, SplashScreenU,
  UnitChildRFHistory, UnitRemoteDBClass, UnitChildJobStatusLive;

function TFormScotDashBoard.ChildFormExists(aForm : TForm): boolean;
var loop: integer;
begin
  Result := false;
  for loop := 0 to MDIChildCount - 1 do
    if MDIChildren[Loop] = aForm then
    begin
      Result := true;
      Break;
    end;
end;

procedure TFormScotDashBoard.CalendarPickerEndChange(Sender: TObject);
begin
  if Not Assigned(DMDesignJob) then
    Exit;
  DMDesignJob.EndTime      := EndOfTheDay(CalendarPickerEnd.Date);
  DMRFStatus.EndTime       := EndOfTheDay(CalendarPickerEnd.Date);
end;

procedure TFormScotDashBoard.CalendarPickerStartChange(Sender: TObject);
begin
  if Not Assigned(DMDesignJob) then
    Exit;
  DMDesignJob.StartTime    := StartOfTheDay(CalendarPickerStart.Date);
  DMRFStatus.StartTime     := StartOfTheDay(CalendarPickerStart.Date);
end;

procedure TFormScotDashBoard.CreateMDIChild(aChildType: TChildType);
begin
  if Assigned(MDIChildJobStatus) then
  begin
    MDIChildJobStatus.ToolBarJobStatus.Visible  := aChildType=ctJobProduction;
    MDIChildJobStatus.ToolBarRollFormer.Visible := aChildType=ctJobProduction;
  end;
  case aChildType of
    ctRFLiveStatus   : begin
                         IF not ChildFormExists(MDIChildRFLiveStatus) then
                           MDIChildRFLiveStatus := TMDIChildRFLiveStatus.Create(nil)
                         else
                           MDIChildRFLiveStatus.BringToFront;
                       end;
    ctDashboard      : begin
                         IF not ChildFormExists(MDIChildRFStatus) then
                           MDIChildRFStatus:=TMDIChildRFStatus.Create(Application)
                         else
                           MDIChildRFStatus.BringToFront;
                        end;
    ctJobLive        : Begin
                         IF not ChildFormExists(MDIChildCurrentJobProcessing) then
                           MDIChildCurrentJobProcessing:=TMDIChildCurrentJobProcessing.Create(Self)
                         else
                           MDIChildCurrentJobProcessing.BringToFront;
                       End;
    ctJobProduction  : begin
                         IF not ChildFormExists(MDIChildJobStatus) then
                           MDIChildJobStatus:=TMDIChildJobStatus.Create(Self)
                         else
                           MDIChildJobStatus.BringToFront;
                       end;

    ctRFHistoryChart : Begin
                         IF not ChildFormExists(MDIChildRFHistory) then
                           MDIChildRFHistory:=TMDIChildRFHistory.Create(Application)
                         else
                           MDIChildRFHistory.BringToFront;
                       End;
    ctLoadEP2        : TMDIChildLoadEP2.Create(Application);
    ctSettings       : TMDIChildSettings.Create(Application);
  end;
end;

procedure TFormScotDashBoard.ActionLoadEP2Execute(Sender: TObject);
var
  aOpenDialog: TFileOpenDialog;
begin
  aOpenDialog := TFileOpenDialog.Create(self);
  try
    aOpenDialog.Title := 'Select EP2/TX? File Folder to Import';
    aOpenDialog.Options := [fdoPickFolders];
    if aOpenDialog.Execute then
      DMLoadEP2Files.LoadEP2Files(aOpenDialog.FileName, DMDesignJob.FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsInteger);
    DMDesignJob.GetJOB;
    DMDesignJob.GetEP2FILE;
    DMDesignJob.FDMemTableJOB.Last;
    DMDesignJob.FDMemTableEP2FILE.Last;
  finally
    FreeAndNil(aOpenDialog);
  end;
end;

procedure TFormScotDashBoard.ActionLoadJobWithoutAssignToMachineExecute(
  Sender: TObject);
var
  aOpenDialog: TFileOpenDialog;
begin
  aOpenDialog := TFileOpenDialog.Create(self);
  try
    aOpenDialog.Title := 'Select EP2/TX? File Folder to Import';
    aOpenDialog.Options := [fdoPickFolders];
    if aOpenDialog.Execute then
      DMLoadEP2Files.LoadEP2Files(aOpenDialog.FileName, 0);
    DMDesignJob.GetJOB;
    DMDesignJob.GetEP2FILE;
    DMDesignJob.FDMemTableJOB.Last;
    DMDesignJob.FDMemTableEP2FILE.Last;
  finally
    FreeAndNil(aOpenDialog);
  end;
end;

procedure TFormScotDashBoard.ActionProjectsExecute(Sender: TObject);
begin
  CreateMDIChild( ctJobProduction );
end;

procedure TFormScotDashBoard.ActionRefreshDataExecute(Sender: TObject);
begin
  DMDesignJob.RefreshData(Sender);
end;

procedure TFormScotDashBoard.ActionRFHIstoryExecute(Sender: TObject);
begin
  CreateMDIChild( ctRFHistoryChart );
end;

procedure TFormScotDashBoard.ActionRFMonitorExecute(Sender: TObject);
begin
  CreateMDIChild( ctRFLiveStatus );
end;

procedure TFormScotDashBoard.ActionProductionExecute(Sender: TObject);
begin
  CreateMDIChild( ctDashboard );
end;

procedure TFormScotDashBoard.ActionSettingsExecute(Sender: TObject);
begin
  CreateMDIChild( ctSettings );
end;

procedure TFormScotDashBoard.FileNew2Execute(Sender: TObject);
begin
  CreateMDIChild( ctSiteProduction );
end;

procedure TFormScotDashBoard.FormCreate(Sender: TObject);
begin
  DMScotServer := TRemoteDB.Create;
  Caption := 'Dashboard     ' + SplashScreenU.GetFileVersion(Application.ExeName);
  if TRemoteDB(DMScotServer).DMRemoteDB.SCSServerConnected then
  begin
    Application.CreateForm(TDMLoadEP2Files, DMLoadEP2Files);
    Application.CreateForm(TDMDesignJob,    DMDesignJob);
    Application.CreateForm(TDMRFStatus,     DMRFStatus);

    FDashboardCallBackName                    := TDSTunnelSession.GenerateSessionId;
    ClientCallback_ChannelManager.ManagerId   := TDSTunnelSession.GenerateSessionId;
    ClientCallback_ChannelManager.DSHostname  := G_Settings.general_Server;
    ClientCallback_ChannelManager.DSPort      := G_Settings.general_Port;
    ClientCallback_ChannelManager.ChannelName := DashboardChannelName;
    ClientCallback_ChannelManager.RegisterCallback(FDashboardCallBackName, TDashBoardCallback.Create );

    FJobLiveCallBackName                             := TDSTunnelSession.GenerateSessionId;
    ClientCallback_ChannelManagerLiveJob.ManagerId   := TDSTunnelSession.GenerateSessionId;
    ClientCallback_ChannelManagerLiveJob.DSHostname  := G_Settings.general_Server;
    ClientCallback_ChannelManagerLiveJob.DSPort      := G_Settings.general_Port;
    ClientCallback_ChannelManagerLiveJob.ChannelName := JobLiveChannelName;
    ClientCallback_ChannelManagerLiveJob.RegisterCallback(FJobLiveCallBackName, TJobLiveCallback.Create );


    CalendarPickerStart.Date := Now-14;
    CalendarPickerEnd.Date   := Now;
  end
  else
  begin
    ActionProduction.Enabled := False;
    ActionRFMonitor.Enabled  := False;
    ActionProjects.Enabled   := False;
    ShowMessage('Cannot connect to server check server configuration please');
  end;
end;

procedure TFormScotDashBoard.FormShow(Sender: TObject);
begin
  MDIChildRFLiveStatus := TMDIChildRFLiveStatus.Create(Application);
end;

procedure TFormScotDashBoard.HelpAbout1Execute(Sender: TObject);
var
  anAboutBox : TFormAboutBox;
begin
  anAboutBox := TFormAboutBox.Create(nil);
  Try
    anAboutBox.ShowModal;
  Finally
    FreeAndNil(anAboutBox);
  End;
end;

procedure TFormScotDashBoard.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

end.
