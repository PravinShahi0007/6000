unit UpdateFormU;
{
Form to display and for user to select program update options
Author - Bruce
}
interface

uses
  Windows, Messages, SysUtils,
  Variants, Classes, Graphics,
  Controls, Forms,
  CommCtrl,
  Dialogs, ComCtrls, Buttons, StdCtrls;

type
  TfrmUpdate = class(TForm)
    sBar: TStatusBar;
    pBar: TProgressBar;
    btnGetZip: TSpeedButton;
    btnGetChangesFile: TSpeedButton;
    btnSelfUpdate: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure sBarResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGetZipClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGetChangesFileClick(Sender: TObject);
    procedure btnSelfUpdateClick(Sender: TObject);
  private     { Private declarations }
    procedure GetUpdateInfo;
    procedure ShowDownloadProgress(BytesDone, TotalBytes: Cardinal);
    procedure ShowDownloadStatus(Code: Cardinal; Msg: string);
    procedure DoSelfUpdate;
    procedure ShowFailedMessage;
  public
    class function Exec: integer; static;
  end;

implementation
{$R *.dfm}

uses
  Download,
  IniFiles,
  ShellAPI,
  GlobalU,
  UpdateUtilsU, SplashScreenU;

const
//  sHomeSite='http://www.scottsdalesteelframes.com/update/';
  sHomeSite='https://www.scsonline.co.nz:444/updates/other/softwareupdates/';
  VER_FILENAME='UpdateApp.txt';
  UPDATER_EXE = 'SCSUpdater.exe';
  sDOWNLOAD_FAILED='Download failed';

var
  sUpdateVer: string='';
  sUpdateFileName: string='';
  sZipFileName: string='';
  sChangesFileName: string='';
  Download1: TDownload;
  bAborted: Bool=False;
  cMajor, cMinor, cRelease, cBuild,                 //Current
  uMajor, uMinor, uRelease, uBuild: Integer;        //Update Site

class function  TfrmUpdate.Exec: integer;
begin
//*Check SCS website for s/ware update
//*Gives users the option of downloading a new exe file, or latest changes file data
  //* Dynamically create and destroy the form
  with TfrmUpdate.Create(nil)do
  begin
    try
      result :=ShowModal;
    finally
      Free;
    end;
  end;
end;

//* Returns true if the website has a newer version
function VersionWasUpdated: Boolean;
begin
  Result := False;
  if (cMajor < uMajor) then
    Exit(True)
  else if (cMajor=uMajor) then
  begin
     if (cMinor < uMinor) then
       Exit(True)
     else if (cMinor = uMinor) then
     begin
       if (cRelease < uRelease) then
         Exit(True)
       else if (cRelease = uRelease) then
         Result := (cBuild < uBuild);
     end;
  end;
end;

//* Read the text file on the website and retreive the latest version number
procedure GetUpdateInfoFromWebFile(AFileName: TFilename);
var
  AppName: string;
begin
  AppName := 'ScotRF-Truss';
  if bFrames then
    AppName := 'ScotRF-Panel';
  if not FileExists(AFileName)then
    exit;
  with TIniFile.Create(AFileName)do
  begin
    try
      sUpdateVer := ReadString(AppName, 'Version', '');
      sUpdateFileName := ReadString(AppName, 'UpdateFileName', ''); {*** !! TDownload.URL is CASE-SENSITIVE !! ***}
      sZipFileName := ReadString(AppName, 'FileName', '');
      sChangesFileName := ReadString(AppName, 'Changes', '');
    finally
      Free;
    end;
  end;
end;

//* eg '1.4.1065.3687' Major.Minor.Release.Build
//* if it is just 3 sets of numbers, like 2.1.60
//* the last number is 0, ie sBuild:='0'
procedure DecodeVersionString(s: string; var sMajor, sMinor, sRelease, sBuild: string);
var
  p: Integer;
  //-----------------------------------------------
  procedure ChopStringAtDot(var sFirstPart: string);
  begin
    p := pos('.', s);
    sFirstPart := s;
    if (p > 0)then
    begin
      sFirstPart := copy(s, 1, pred(p));
      s := copy(s, succ(p), Length(s)-p);
    end
    else
      s := '0';
  end;
  //-----------------------------------------------
begin
  ChopStringAtDot(sMajor);
  ChopStringAtDot(sMinor);
  ChopStringAtDot(sRelease);
  sBuild := s;
end;

//* Website version numbers
procedure GetUpdateVersionNumbers;
var
  sMajor, sMinor, sRelease, sBuild: string;
begin
  DecodeVersionString(sUpdateVer, sMajor, sMinor, sRelease, sBuild);
  uMajor := StrToInt(sMajor);
  uMinor := StrToInt(sMinor);
  uRelease := StrToInt(sRelease);
  uBuild := StrToInt(sBuild);
end;

function GetFileVersionX(FileName: string): String;
var
	Size, Size2: DWord;
  AMajor, AMinor, ARelease, ABuild: Word;
	Pt, Pt2: Pointer;
begin
	Result := '';
	// Get version information size in exe file
	Size := GetFileVersionInfoSize(PChar(FileName), Size2);
	// Make sure there is version information in the first place
	if Size > 0 then
	begin
		GetMem(Pt, Size);
		try
			if GetFileVersionInfo(PChar(FileName), 0, Size, Pt) then
			begin
			if VerQueryValue(Pt, '\', Pt2, Size2) then
				with TVSFixedFileInfo(Pt2^) do
				begin
					AMajor := HiWord(dwFileVersionMS);
					AMinor := LoWord(dwFileVersionMS);
					ARelease := HiWord(dwFileVersionLS);
					ABuild := LoWord(dwFileVersionLS);
				end;
			end;
		finally
			FreeMem(Pt, Size);
		end;
	end; // if Size > 0

  //Major version number
  Result := Format('%d.', [AMajor]);
  //Minor version number
  if AMinor <= 9 then
    Result := Result + Format('0%d.', [AMinor])
  else
    Result := Result + Format('%d.', [AMinor]);
  //Release version number
  if ARelease <= 9 then
    Result := Result + Format('0%d.', [ARelease])
  else
    Result := Result + Format('%d.', [ARelease]);
  //Build version number
  if ABuild <= 9 then
    Result := Result + Format('0%d', [ABuild])
  else
    Result := Result + Format('%d', [ABuild]);

  if Result='' then
		Result := 'Version information not included in this file';
end;

//* Current version numbers
procedure GetVersionNumbers;
var
  sCurrentVersion,
  sMajor, sMinor, sRelease, sBuild: string;
begin
  sCurrentVersion := GetFileVersionX(Application.ExeName);
  DecodeVersionString(sCurrentVersion, sMajor, sMinor, sRelease, sBuild);
  cMajor := StrToInt(sMajor);
  cMinor := StrToInt(sMinor);
  cRelease := StrToInt(sRelease);
  cBuild := StrToInt(sBuild);
end;

//* Return the user's temp directory path
function GetTempDirectory: string;
var
  TempDir: array[0..MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, @TempDir);
  Result := StrPas(TempDir);
end;

//* Check the website for an update
//* If there is an update available, enable the Get Update button
//* Otherwise display one of the 4 info strings
procedure TfrmUpdate.GetUpdateInfo;
const
  VER_FILENAME='UpdateApp.txt';
  sNO_UPDATE_INFO='No update information available';
  sHAVE_LATEST_VER='You have the latest version';
  sUPDATE_AVAILABLE='Update available';
  sUPDATE_INFO_NOT_FOUND='Update information not found';
var
  sDestPath: string;
begin
  sDestPath := GetTempDirectory;
  Download1.URL := sHomeSite + VER_FILENAME;
  Download1.DestinationFile := sDestPath + VER_FILENAME;
  Download1.OnStatus := nil;
  Download1.OnDownloadProgress := nil;

  if Download1.DownloadFile then
    GetUpdateInfoFromWebFile(Download1.DestinationFile)
  else begin
    sBar.Panels[1].Text := sNO_UPDATE_INFO;
    exit;
  end;
  btnGetChangesFile.Enabled := sChangesFileName<>'';
  DeleteFile(Download1.DestinationFile);

  GetUpdateVersionNumbers;

  //showmessage(inttostr(cMajor)+'.'+inttostr(cMinor)+'.'+inttostr(cRelease));
  //showmessage(inttostr(uMajor)+'.'+inttostr(uMinor)+'.'+inttostr(uRelease));


  if (sUpdateVer = '')and(sUpdateFileName = '')and(sZipFileName = '')then
  begin
    sBar.Panels[1].Text := sUPDATE_INFO_NOT_FOUND;
    exit;
  end;

  if not VersionWasUpdated then
  begin
    sBar.Panels[1].Text := sHAVE_LATEST_VER;
    exit;
  end;

  btnSelfUpdate.Enabled := (sUpdateFileName <> '');
  btnGetZip.Enabled := (sZipFileName <> '');
  sBar.Panels[1].Text := sUPDATE_AVAILABLE;
end;

//* Initialise
procedure TfrmUpdate.FormCreate(Sender: TObject);
begin
  GetVersionNumbers;
  //showmessage(inttostr(cMajor)+'.'+inttostr(cMinor)+'.'+inttostr(cRelease));
  pBar.Parent := sBar;
  pBar.Position := 0;
  SendMessage(pBar.Handle, PBM_SETBARCOLOR, 0, clBlue);
  Download1 := TDownload.Create(Application);
end;

//* Update the display of the progress bar in the status bar
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

//* Check the website
procedure TfrmUpdate.FormShow(Sender: TObject);
begin
  //sBar.Panels[0].Width := 0;
  sBarResize(Sender);
  GetUpdateInfo;
end;

//* Display how much of the download has taken place
procedure TfrmUpdate.ShowDownloadProgress(BytesDone, TotalBytes: Cardinal);
begin
  pBar.Max := TotalBytes;
  pBar.Position := BytesDone;

  if TotalBytes = 0 then
    TotalBytes := 1;

  sBar.Panels[1].Text := format( 'Downloaded %0.f %%' , [(BytesDone / TotalBytes)*100]);
  Repaint;
end;

//* Display download status messages
procedure TfrmUpdate.ShowDownloadStatus(Code: Cardinal; Msg: string);
begin
  sBar.Panels[1].Text := DownloadStatusCodeToStr(Code);
end;

//* Open an information message dialog with the AMsg string showing
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

//* Inform the user what to do with the saved zip update
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

//* Attempt to get the update
procedure TfrmUpdate.btnGetZipClick(Sender: TObject);
begin
  if (not VersionWasUpdated) or(sZipFileName = '') then
    exit;
  //See where the user wants to save it
  with TSaveDialog.Create(Application)do
  begin
    try
      Options := [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing];
      Title := 'Save the Update to';
      FileName := sZipFileName;
      if Execute then
      begin
        Download1.URL := sHomeSite + sZipFileName;
        Download1.DestinationFile := FileName;
        Download1.OnDownloadProgress := ShowDownloadProgress;
        Download1.OnStatus := ShowDownloadStatus;
        btnGetZip.Enabled := False;
        if not Download1.DownloadFile then
        begin
          sBar.Panels[1].Text := sDOWNLOAD_FAILED;
          ShowInfoMessage(sDOWNLOAD_FAILED);
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

procedure TfrmUpdate.ShowFailedMessage;
begin
  sBar.Panels[1].Text := sDOWNLOAD_FAILED;
  ShowInfoMessage(sDOWNLOAD_FAILED);
end;

procedure TfrmUpdate.DoSelfUpdate;
var
  sUpdaterExe: string;
begin
  Download1.OnDownloadProgress := ShowDownloadProgress;
  Download1.OnStatus := ShowDownloadStatus;

  //Download the Updater exe
  Download1.URL := sHomeSite + UPDATER_EXE;
  sUpdaterExe := ExtractFilePath(ParamStr(0)) + UPDATER_EXE;
  Download1.DestinationFile := sUpdaterExe;
  if not Download1.DownloadFile then
  begin
    ShowFailedMessage;
    exit;
  end;

  //Download the update
  Download1.URL := sHomeSite + sUpdateFileName;
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

//* Clean up
procedure TfrmUpdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Download1.Free;
end;

//* Attempt to get the file which documents the changes in the latest update
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
        Download1.URL := sHomeSite + sChangesFileName;
        Download1.DestinationFile := FileName;
        Download1.OnDownloadProgress := ShowDownloadProgress;
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
