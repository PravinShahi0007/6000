unit UpdateFormU;

{
Form to allow the user to check the website for updates,
and to download the changes file, or any available update.
}

interface

uses
  Windows, Messages, SysUtils,
  Variants, Classes, Graphics,
  Controls, Forms,
  CommCtrl,
  ComObj,
  Dialogs, ComCtrls, Buttons, StdCtrls;

type
  TfrmUpdate = class(TForm)
    sBar: TStatusBar;
    pBar: TProgressBar;
    btnSelfUpdate: TSpeedButton;
    btnGetChangesFile: TSpeedButton;
    btnGetZip: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure sBarResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSelfUpdateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGetChangesFileClick(Sender: TObject);
    procedure btnGetZipClick(Sender: TObject);
  private     { Private declarations }
    procedure GetUpdateInfo;
    procedure ShowDownloadProgress(BytesDone, TotalBytes: Cardinal);
    procedure ShowDownloadStatus(Code: Cardinal; Msg: string);
    procedure DoSelfUpdate;
    procedure ShowFailedMessage;

  public     { Public declarations }

  end;

  function GetFileVersion: string;
  //function GetCopyright: string;
  function HoleAutoJoinAdjustStr: string;

var
  frmUpdate: TfrmUpdate;

implementation

uses
  ShellAPI,
  Download, IniFiles, UpdateUtilsU, TranslateU;

const
  //sHomeSite='http://www.scottsdalesteelframes.com/update/';   //was 'http://www.scottsdale.co.nz/UpdateApp/';
  //sHomeSite='file:///C:/Program%20Files/Borland/Delphi7/Projects/DownloadFile/TestUpdateApp/';
  HOMESITE='https://www.scsonline.co.nz:444/updates/other/softwareupdates/';
  VER_FILENAME='UpdateApp.txt';
  UPDATER_EXE = 'SCSUpdater.exe';
  sDOWNLOAD_FAILED='Download failed';

var
  fUpdateVer: Single=0;
  fCurrentVer: Single;
  sUpdateFileName: string='';
  sZipFileName: string='';
  sChangesFileName: string='';
  Download1: TDownload;
  bAborted: Bool=False;

{$R *.dfm}

function GetVerInfo(sApp, sInfo: string): string;
const
  FILE_INFO = 'StringFileInfo\140904E4\';
var
  n, Len: DWORD;
  Buf, Value: PChar;
begin
  Result := 'unknown';
  if (sApp='')then
    exit;
  if(not FileExists(sApp))then
  begin
    Result := 'not found';
    exit;
  end;
  n := GetFileVersionInfoSize(PChar(sApp), n);
  Buf := AllocMem(n);
  try
    GetFileVersionInfo(PChar(sApp), 0, n, Buf);
    if VerQueryValue(Buf, PChar(FILE_INFO + sInfo), Pointer(Value), Len) then
      Result := Value;
  finally
    FreeMem(Buf, n);
  end;
end;

function GetFileVersion: string;
begin
  Result := GetVerInfo(Application.ExeName, 'FileVersion');
end;

function HoleAutoJoinAdjustStr: string;
const
  HOLE_AUTO_KEY = 'CLSID\{A628F289-3E6E-499E-B937-37EECF1D249E}\InprocServer32';
var
  sHoleAuto: string;
begin
  sHoleAuto := GetRegStringValue(HOLE_AUTO_KEY, '');
  Result := GetVerInfo(sHoleAuto, 'JoiningVersion');
end;

             {
function GetCopyright: string;
begin
  Result := GetVerInfo(Application.ExeName, 'LegalCopyright');
end;          }

//* eg '1.4.1065.3687' Major.Minor.Release.Build
procedure DecodeVersion(var sMajor, sMinor, sRelease, sBuild: string);
var
  s: string;
  p: Integer;
  //-----------------------------------------------
  procedure ChopStringAtDot(var sFirstPart: string);
  begin
    p := pos('.', s);
    if (p > 0)then
    begin
      sFirstPart := copy(s, 1, pred(p));
      s := copy(s, succ(p), Length(s)-p);
    end;
  end;
  //-----------------------------------------------
begin
  s := GetFileVersion;
  ChopStringAtDot(sMajor);
  ChopStringAtDot(sMinor);
  ChopStringAtDot(sRelease);
  sBuild := s;
end;

function GetMinorVerNumber: Single;
var
  sMajor, sMinor, sRelease, sBuild: string;
begin
  try
    DecodeVersion(sMajor, sMinor, sRelease, sBuild);
    Result := StrToFloat(sMinor);
  except
    Result := 0;
  end;
end;

procedure GetUpdateInfoFromWebFile(AFileName: TFilename);
const
  APP_NAME = 'ScotSim';  //'TrussSim';
begin
  if not FileExists(AFileName)then
    exit;
  with TIniFile.Create(AFileName)do
  begin
    try
      fUpdateVer := ReadFloat(APP_NAME, 'Version', 0);
      sUpdateFileName := ReadString(APP_NAME, 'UpdateFileName', ''); {*** !! TDownload.URL is CASE-SENSITIVE !! ***}
      sZipFileName := ReadString(APP_NAME, 'FileName', '');
      sChangesFileName := ReadString(APP_NAME, 'Changes', '');
    finally
      Free;
    end;
  end;
end;

function GetTempDirectory: string;
var
  TempDir: array[0..MAX_PATH] of Char;
begin 
  GetTempPath(MAX_PATH, @TempDir);
  Result := StrPas(TempDir);
end;

procedure TfrmUpdate.GetUpdateInfo;
const
  sNO_UPDATE_INFO='No update information available';
  sHAVE_LATEST_VER='You have the latest version';
  sUPDATE_AVAILABLE='Update available';
  sUPDATE_INFO_NOT_FOUND='Update information not found';
var
  sDestPath: string;
begin
    sDestPath := GetTempDirectory;
    Download1.URL := HOMESITE + VER_FILENAME;
    Download1.DestinationFile := sDestPath + VER_FILENAME;
    Download1.OnStatus := nil;
    Download1.OnProgress := nil;

    if Download1.DownloadFile then
      GetUpdateInfoFromWebFile(Download1.DestinationFile)
    else begin
      sBar.Panels[1].Text := sNO_UPDATE_INFO;
      exit;
    end;
    btnGetChangesFile.Enabled := (sChangesFileName <> '');
    DeleteFile(Download1.DestinationFile);

    if (fUpdateVer = 0)and(sUpdateFileName = '')and(sZipFileName = '')then
    begin
      sBar.Panels[1].Text := sUPDATE_INFO_NOT_FOUND;
      exit;
    end;
    if (fUpdateVer <= fCurrentVer)then
    begin
      sBar.Panels[1].Text := sHAVE_LATEST_VER;
      exit;
    end;

  btnSelfUpdate.Enabled := (sUpdateFileName <> '');
  btnGetZip.Enabled := (sZipFileName <> '');
  sBar.Panels[1].Text := sUPDATE_AVAILABLE;
  //sBar.Panels[0].Width := 75;
end;


procedure TfrmUpdate.FormCreate(Sender: TObject);
begin
  fCurrentVer := GetMinorVerNumber;

  pBar.Parent := sBar;
  pBar.Position := 0;
  SendMessage(pBar.Handle, PBM_SETBARCOLOR, 0, clBlue);

  Download1 := TDownload.Create(Application);

  TranslateForm(Self);
end;

procedure TfrmUpdate.sBarResize(Sender: TObject);
var
  r: TRect;
begin
  //SB_GETRECT needs Unit CommCtrl

  sBar.Perform(SB_GETRECT, 0, Integer(@r));  //Panels[0]
  pBar.Top    := r.Top;                  //set size of
  pBar.Left   := r.Left;                 //Progressbar to
  pBar.Width  := r.Right - r.Left;       //fit with panel
  pBar.Height := r.Bottom - r.Top;
end;

procedure TfrmUpdate.FormShow(Sender: TObject);
begin
  //sBar.Panels[0].Width := 0;
  sBarResize(Sender);

  Screen.Cursor := crHourGlass;
  try
    GetUpdateInfo;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmUpdate.ShowDownloadProgress(BytesDone, TotalBytes: Cardinal);
begin
  pBar.Max := TotalBytes;
  pBar.Position := BytesDone;

  if TotalBytes = 0 then
    TotalBytes :=1;

  sBar.Panels[1].Text := format( 'Downloaded %0.f %%' , [(BytesDone / TotalBytes)*100]);
  Repaint;
end;

procedure TfrmUpdate.ShowDownloadStatus(Code: Cardinal; Msg: string);
begin
  sBar.Panels[1].Text := DownloadStatusCodeToStr(Code);
end;

procedure ShowInfoMessage(AMsg: string);
begin
  with CreateMessageDialog(AMsg, mtInformation, [mbOK])do
  begin
    Color := clInfoBk;
    Font.Color := clInfoText;
    try
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure ShowUpdateMessage;
const
  sINSTALL_MSG = 'Update Saved.'#13#10#13#10
               + 'To install the update:'#13#10
               + #9'* Close this program, and'#13#10
               + #9'* Unzip the downloaded file to the program''s folder, then'#13#10
               + #9'* Restart the program';
begin
  if not bAborted then
    ShowInfoMessage(sINSTALL_MSG);
end;

procedure TfrmUpdate.ShowFailedMessage;
begin
  sBar.Panels[1].Text := sDOWNLOAD_FAILED;
  ShowInfoMessage(sDOWNLOAD_FAILED);
end;

procedure TfrmUpdate.DoSelfUpdate;
var
  sUpdaterExe: string;
begin
  Download1.OnProgress := ShowDownloadProgress;
  Download1.OnStatus := ShowDownloadStatus;

  //Download the Updater exe
  Download1.URL := HOMESITE + UPDATER_EXE;
  sUpdaterExe := ExtractFilePath(ParamStr(0)) + UPDATER_EXE;
  Download1.DestinationFile := sUpdaterExe;
  if not Download1.DownloadFile then
  begin
    ShowFailedMessage;
    exit;
  end;

  //Download the update
  Download1.URL := HOMESITE + sUpdateFileName;
  Download1.DestinationFile := ExtractFilePath(ParamStr(0)) + sUpdateFileName;

  btnSelfUpdate.Enabled := False;
  if not Download1.DownloadFile then
  begin
    ShowFailedMessage;
    exit;
  end
  else begin
    DecryptAndDecompressFile(Download1.DestinationFile, ChangeFileExt(ParamStr(0), '.new'));
    if DeleteFile(Download1.DestinationFile)then
      ShellExecute(Handle, 'open', PChar('"' + sUpdaterExe + '"'),
                                   PChar('"' + ParamStr(0) + '"'),
                                   nil, SW_SHOWNORMAL);
  end;
end;

procedure CleanupSelfUpdateFiles;
var
  sUpdaterExe: string;
begin
  sUpdaterExe := ExtractFilePath(ParamStr(0)) + UPDATER_EXE;
  if FileExists(sUpdaterExe)then
    DeleteFile(sUpdaterExe);
end;

procedure TfrmUpdate.btnGetZipClick(Sender: TObject);
begin
  if (fUpdateVer <= fCurrentVer)or(sZipFileName = '') then
    exit;
  //See where the user wants to save it
  with TSaveDialog.Create(Application)do
  begin
    try
      Options := [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing];
      Title := 'Save the update to';
      FileName := sZipFileName;
      if Execute then
      begin
        Download1.URL := HOMESITE + sZipFileName;
        Download1.DestinationFile := FileName;
        Download1.OnProgress := ShowDownloadProgress;
        Download1.OnStatus := ShowDownloadStatus;
        //btnGetZip.Enabled := False;
        if not Download1.DownloadFile then
        begin
          sBar.Panels[1].Text := sDOWNLOAD_FAILED;
          ShowMessage(sDOWNLOAD_FAILED);
          exit;
        end
        else
          ShowUpdateMessage;
      end;
    finally
      Free;
    end;
  end;
  Close;
end;

procedure TfrmUpdate.btnSelfUpdateClick(Sender: TObject);
begin
  DoSelfUpdate;
end;

procedure TfrmUpdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Download1.Free;
end;

procedure TfrmUpdate.btnGetChangesFileClick(Sender: TObject);
const
  sSAVED = 'Changes file saved';
  MSG    = sSAVED + ' to'#13#10'%s';
  sDOWNLOAD_CHANGES_FAILED='Failed to get the changes file';
begin
  //See where the user wants to save it
  with TSaveDialog.Create(Application)do
  begin
    try
      Options := [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing];
      Title := 'Save the Changes File to';
      FileName := sChangesFileName;
      if Execute then
      begin
        Download1.URL := HOMESITE + sChangesFileName;
        Download1.DestinationFile := FileName;
        Download1.OnProgress := ShowDownloadProgress;
        Download1.OnStatus := ShowDownloadStatus;
        if not Download1.DownloadFile then
        begin
          sBar.Panels[1].Text := sDOWNLOAD_CHANGES_FAILED;
          ShowInfoMessage(sDOWNLOAD_CHANGES_FAILED);
          exit;
        end
        else begin
          sBar.Panels[1].Text := sSAVED;
          ShowInfoMessage(format(MSG, [Download1.DestinationFile]));
        end;
      end;
    finally
      pBar.Position := 0;
      Free;
    end;
  end;
end;

initialization
  CleanupSelfUpdateFiles;

END.
