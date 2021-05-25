unit WinUtils;

interface
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

uses Windows, sysUtils, Forms, classes, shlObj, FileCtrl, Dialogs, ComObj, ActiveX
, DCPBlowfish, DCPSha1, zLib, math, StrUtils, RegularExpressions;

function GetLogingDataDirectory: String;
function PickADirectory(ACaption: string; var Directory: string; AFileName: string= ''): Boolean;
function ScsProgramDataPath: string;
function ScsTempDataPath: string;
function GetUserName: string;
function GetDomainName: string;
function GetComputerName: string;
function GetSpecialFolderPath(folder: Integer): string; overload;
function MyDocuments: string;
procedure ods(S: string); overload;// output debug string
procedure ods(const AFormat: string; const Args: array of const); overload;
function isTrue(S: string): boolean;
function TF(AValue: boolean): string;
function DateToYMDStr(ADate: tDateTime): string;
function DelimitedStrLeft(const s: string; ASeparator: char): string;
function DelimitedStrRight(const s: string; ASeparator: char): string;
function LogFileName(AFolder: string; ADate: tDateTime): string;
function StrToDate(S: String): TDateTime;
function StrToTime(S: String): TDateTime;
function calcDuration(s0,s1: string): double;
function TimeStr(ATime: TTime): string; overload;
function TimeStr: string;overload;
function GetFileVersion: string;
function GetReleaseNumber: Integer;
procedure getAppVersion(var sMajor, sMinor, sRelease, sBuild: string);
function HexToInt(s: string): longword;
procedure ExecNonModalApp(const exeName,command: string;  var procInfo:TProcessInformation);
function CreateGuid: string;
procedure Check(bTest: boolean; AText: string);
function CtrlKeyDown: Boolean;
function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): string; overload;
procedure DecryptAndSave(anEP2File: String);
Function ExtractBetween(const Value, A, B: string): string;


type
  EValidationError=class(exception) end;
  TFormHelper = class helper for TForm
  public
    Procedure SetDialogPos(ADialog: TForm);
  end;

implementation

procedure ods(S: string);
begin
  outputdebugstring(@S[1]);
end;

procedure ods(const AFormat: string; const Args: array of const);
begin
  ods(format(AFormat, Args));
end;

function isTrue(S: string):boolean;
begin
  result:=(s='1') or (s='T') or sameText(s,'TRUE')
end;

function TF(AValue: boolean): string;
begin
  if AValue then exit('True');
  exit('False');
end;

function DateToYMDStr(ADate: tDateTime): string;
begin
  result := formatDateTime('yyyy-mm-dd', ADate);
end;

function StrToDate(S: String): TDateTime;
var FS: TFormatSettings;
begin
  FillChar(FS, sizeof(FS), 0);
  FS.DateSeparator := '-';
  FS.ShortDateFormat := 'yyyy-mm-dd';
  result := StrToDateDef(S, 0, FS);
end;

function LogFileName(AFolder: string; ADate: tDateTime): string;
begin
  result := format('%sScotRF Production %s.log',[IncludeTrailingBackslash(AFolder),DateToYMDStr(ADate)]);
end;

function TimeStr(ATime: TTime): string;
begin
  result := formatDateTime('hh:nn:ss', ATime);
end;

function TimeStr: string;
begin
  result := TimeStr(now);
end;

function StrToTime(S: String): TDateTime;
begin
  s:=StringReplace(s,'.',':',[]);
  result := sysUtils.StrToTime(S);
end;

function calcDuration(s0,s1: string): double;
var
  t0,t1: Double;
begin
  try
      t0:=StrToTime(s0);
      t1:=StrToTime(s1);
      result:=t1-t0;
  except
    Result :=0;
  end;
end;

function GetSpecialFolderPath(folder: Integer): string;
var
  path: array[0 .. MAX_PATH] of char;
begin
  if SUCCEEDED(SHGetFolderPath(0, folder, 0, SHGFP_TYPE_CURRENT, path)) then
    result := path
  else
    result := 'C:\';
end;

function SCSx86ProgramFiles: string;
begin
  result := GetSpecialFolderPath(CSIDL_PROGRAM_FILESX86)+ '\SCS\';
end;

function ScsProgramDataPath: string;
begin
  result := GetSpecialFolderPath(CSIDL_COMMON_APPDATA or CSIDL_FLAG_CREATE)+ '\Scottsdale\';
  ForceDirectories(result);
end;

function ScsTempDataPath: string;
begin
  result := GetSpecialFolderPath(CSIDL_APPDATA)+ '\Scottsdale\';
  ForceDirectories(result);
end;


function MyDocuments: string;
begin
  result := GetSpecialFolderPath(CSIDL_MYDOCUMENTS);
end;

function PickADirectory(ACaption: string; var Directory: string; AFileName: string= ''): Boolean;
var SelectFolderDialog: TFileOpenDialog;
begin
  if CheckWin32Version(6) then //vista+
  begin
    SelectFolderDialog := TFileOpenDialog.Create(nil);
    with SelectFolderDialog do
      try
        ClientGuid := '{23F85899-7480-47A8-9880-25851BFD94F1}';
        Options := [fdoPickFolders];
        Title := ACaption;
        DefaultFolder := Directory;
        Filename := AFileName;
        result := Execute;
        if result then
          Directory := Filename;
      finally
        Free;
      end;
  end
  else
    result := SelectDirectory(ACaption, '', Directory, [sdNewFolder, sdNewUI]);
end;

function ProperCase(const s: string) :string;
var i: integer;
    isFirst: Boolean;
begin
  result:=LowerCase(s);
  isFirst:=true;
  for i := 1 to length(s) do
  begin
    if isFirst then result[i]:=UpCase(s[i]);
    isFirst := not CharInSet(result[i],['a'..'z','A'..'Z']);
  end;
end;

Procedure GetDomainAndUserName(out Domain : string; out User : string);
var
   hToken   : THandle;
   ptiUser  : PSIDAndAttributes;
   cbti     : DWORD;
   snu      : SID_NAME_USE;
   UserLength,domainLength: DWORD;
begin
  ptiUser := nil;
  try
    if (not OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, hToken)) then
            exit;
    // Obtain the size of the user information in the token.
    if (GetTokenInformation(hToken, TokenUser, nil, 0, cbti)) then
         Exit;         // Call should have failed due to zero-length buffer.
    if (GetLastError() <> ERROR_INSUFFICIENT_BUFFER) then
         Exit;    // Call should have failed due to zero-length buffer.

    // Allocate buffer for user information in the token.
    ptiUser :=  HeapAlloc(GetProcessHeap(), 0, cbti);
    if (ptiUser= nil) then
       Exit;
    // Retrieve the user information from the token.
    if ( not GetTokenInformation(hToken, TokenUser, ptiUser, cbti, cbti)) then
       Exit;
    // Retrieve user name and domain name based on user's SID.
    setlength(user,255);
    UserLength:=255;
    setlength(domain,255);
    domainLength:=255;
    if ( not LookupAccountSid(nil, ptiUser.Sid, pchar(User), UserLength,
          pchar(domain), domainLength, snu)) then
       Exit;
    setlength(domain,strlen(pchar(domain)));  // fix dynamic string length
    setlength(User,strlen(pchar(User)));  // fix dynamic string length
  finally
    if (hToken <> 0) then
       CloseHandle(hToken);
    if (ptiUser <> nil) then
       HeapFree(GetProcessHeap(), 0, ptiUser);
  end;
end;

function GetUserName: string;
var domain: string;
begin
  GetDomainAndUserName(Domain, Result);
end;

function GetDomainName: string;
var UserName: string;
begin
  GetDomainAndUserName(Result,UserName);
end;

function GetComputerName: string;
var nSize: DWORD;
begin
  nSize:=240;
  setlength(result,nSize);
  if windows.getComputerName(pchar(result),nSize) then
    setlength(result,strlen(pchar(result)))
  else
    result:='<unknown>';
end;

function getUser :string;   // get logon ID, tidied
var i: integer;
begin
  result:=GetUserName;
  for i := 1 to length(Result) do
    if CharInSet(result[i],['.','_']) then
      result[i]:=' ';
  result :=  ProperCase(Result);
end;


function GetVerInfo(sInfo: string): string;
const
  FILE_INFO = 'StringFileInfo\140904E4\';
var
  n, Len: DWORD;
  Buf, Value: PChar;
  Buffer: array[0..260] of Char;
begin
  Result := '';
  GetModuleFileName(0, Buffer, Length(Buffer)); // Application.ExeName;
  n := GetFileVersionInfoSize(@Buffer[0], n);
  Buf := AllocMem(n);
  try
    GetFileVersionInfo(@Buffer[0], 0, n, Buf);
    if VerQueryValue(Buf, PChar(FILE_INFO + sInfo), Pointer(Value), Len) then
      Result := Value;
  finally
    FreeMem(Buf, n);
  end;
end;

function GetFileVersion: string;
begin
  Result := GetVerInfo('FileVersion');
end;

//* eg '1.4.1065.3687' Major.Minor.Release.Build
procedure getAppVersion(var sMajor, sMinor, sRelease, sBuild: string);
var
  s: string;

  //-----------------------------------------------
  procedure ChopStringAtDot(var sFirstPart: string);
  var  p: Integer;
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

function GetReleaseNumber: Integer;
var
  sMajor, sMinor, sRelease, sBuild: string;
begin
  try
    getAppVersion(sMajor, sMinor, sRelease, sBuild);
    Result := StrToInt(sRelease);
  except
    Result := 0;
  end;
end;

function HexToInt(s: string):            longword;

//* Converts Hex string to longint
var
  b: byte;
  c: char;
begin
  result := 0;
  s := uppercase(s);
  for b := 1 to length(s) do
  begin
    result := result * 16;
    c := s[b];
    case c of
      '0' .. '9': inc(result, ord(c) - ord('0'));
      'A' .. 'F': inc(result, ord(c) - ord('A') + 10);
    else
      raise EConvertError.Create('No Hex-Number');
    end;
  end;
end;
procedure ExecNonModalApp(const exeName,command: string;                          var procInfo:TProcessInformation);
{ Noe return status: all errors raise an exception }
var commandLine: string;
    startupinfo: tStartupinfo;
begin

  FillChar(procInfo, SizeOf(procInfo), 0);
  if not fileExists(exeName) then
    raise exception.create('No such file '+ exeName);
  commandLine:= exeName+' '+command;
  fillchar( STARTUPINFO, sizeof( STARTUPINFO), #0);
  fillchar( procInfo, sizeof( procInfo), #0);
  if not createProcess( pchar(exeName),
                  pchar(commandLine),
                  nil,
                  nil,
                  false,
                  0,// flags
                  nil,
                  'c:\', // start dir
                  STARTUPINFO,
                  procInfo) then
      exception.create('Create process failed ('+inttostr(getLastError)+')');
  if procInfo.hProcess=0 then
      exception.create('Create process failed - no handle');
end;

function DelimitedStrLeft(const s: string; ASeparator: char): string;
var
  P: Integer;
begin
  P := AnsiPos(ASeparator, S);
  if (P <> 0) then
    result:= Copy(S, 1, P - 1)
  else
    result:='';
end;

function DelimitedStrRight(const s: string; ASeparator: char): string;
var
  P: Integer;
begin
  P := AnsiPos(ASeparator, S);
  if (P <> 0) then
    result:= Copy(S, P+1,MaxInt)
  else
    result:='';
end;

{ TFormHelper }

procedure TFormHelper.SetDialogPos(ADialog: TForm);
const
  xOffset = 32;
  yOffset = 40;
begin
  //  set a position relative to parent form
  ADialog.Left := self.left + xOffset;
  ADialog.Top := self.top + yOffset;
end;

function CreateGuid: string;
var
   ID: TGUID;
begin
   Result := '';
   if CoCreateGuid(ID) = S_OK then
     Result := GUIDToString(ID);
end;

procedure Check(bTest: boolean; AText: string);
begin
  if not bTest then
    raise EValidationError.Create(AText);
end;

function CtrlKeyDown: Boolean;
var
  Shift: TShiftState;
begin
  Shift := KeyboardStateToShiftState;
  Result := ssCtrl in Shift;
end;

function GetLogingDataDirectory: String;
begin
  Result := GetSpecialFolderPath(CSIDL_APPDATA, False);
  if Result[Length(Result)] <> '\' then
    Result := Result + '\';
  Result := Result + ChangeFileExt('Scottsdale\Loging', '')+ '\';
  if not DirectoryExists(Result) then
    CreateDir(Result);
end;

function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): string;

{ Gets path of special system folders
  Call this routine as follows:
  GetSpecialFolderPath (CSIDL_PERSONAL, false)
        returns folder as result

  CSIDL_DESKTOP                       = $0000;  <desktop>
  CSIDL_INTERNET                      = $0001;  Internet Explorer (icon on desktop)
  CSIDL_PROGRAMS                      = $0002;  Start Menu\Programs
  CSIDL_CONTROLS                      = $0003;  My Computer\Control Panel
  CSIDL_PRINTERS                      = $0004;  My Computer\Printers
  CSIDL_PERSONAL                      = $0005;  My Documents.  This is equivalent to CSIDL_MYDOCUMENTS in XP and above
  CSIDL_FAVORITES                     = $0006;  <user name>\Favorites
  CSIDL_STARTUP                       = $0007;  Start Menu\Programs\Startup
  CSIDL_RECENT                        = $0008;  <user name>\Recent
  CSIDL_SENDTO                        = $0009;  <user name>\SendTo
  CSIDL_BITBUCKET                     = $000a;  <desktop>\Recycle Bin
  CSIDL_STARTMENU                     = $000b;  <user name>\Start Menu
  CSIDL_MYDOCUMENTS                   = $000c;  logical "My Documents" desktop icon
  CSIDL_MYMUSIC                       = $000d;  "My Music" folder
  CSIDL_MYVIDEO                       = $000e;  "My Video" folder
  CSIDL_DESKTOPDIRECTORY              = $0010;  <user name>\Desktop
  CSIDL_DRIVES                        = $0011;  My Computer
  CSIDL_NETWORK                       = $0012;  Network Neighborhood (My Network Places)
  CSIDL_NETHOOD                       = $0013;  <user name>\nethood
  CSIDL_FONTS                         = $0014;  windows\fonts
  CSIDL_TEMPLATES                     = $0015;
  CSIDL_COMMON_STARTMENU              = $0016;  All Users\Start Menu
  CSIDL_COMMON_PROGRAMS               = $0017;  All Users\Start Menu\Programs
  CSIDL_COMMON_STARTUP                = $0018;  All Users\Startup
  CSIDL_COMMON_DESKTOPDIRECTORY       = $0019;  All Users\Desktop
  CSIDL_APPDATA                       = $001a;  <user name>\Application Data
  CSIDL_PRINTHOOD                     = $001b;  <user name>\PrintHood
  CSIDL_LOCAL_APPDATA                 = $001c;  <user name>\Local Settings\Application Data (non roaming)
  CSIDL_ALTSTARTUP                    = $001d;  non localized startup
  CSIDL_COMMON_ALTSTARTUP             = $001e;  non localized common startup
  CSIDL_COMMON_FAVORITES              = $001f;   CSIDL_INTERNET_CACHE                = $0020;
  CSIDL_COOKIES                       = $0021;
  CSIDL_HISTORY                       = $0022;
  CSIDL_COMMON_APPDATA                = $0023;  All Users\Application Data
  CSIDL_WINDOWS                       = $0024;  GetWindowsDirectory()
  CSIDL_SYSTEM                        = $0025;  GetSystemDirectory()
  CSIDL_PROGRAM_FILES                 = $0026;  C:\Program Files
  CSIDL_MYPICTURES                    = $0027;  C:\Program Files\My Pictures
  CSIDL_PROFILE                       = $0028;  USERPROFILE
  CSIDL_SYSTEMX86                     = $0029;  x86 system directory on RISC
  CSIDL_PROGRAM_FILESX86              = $002a;  x86 C:\Program Files on RISC
  CSIDL_PROGRAM_FILES_COMMON          = $002b;  C:\Program Files\Common
  CSIDL_PROGRAM_FILES_COMMONX86       = $002c;  x86 C:\Program Files\Common on RISC
  CSIDL_COMMON_TEMPLATES              = $002d;  All Users\Templates
  CSIDL_COMMON_DOCUMENTS              = $002e;  All Users\Documents
  CSIDL_COMMON_ADMINTOOLS             = $002f;  All Users\Start Menu\Programs\Administrative Tools
  CSIDL_ADMINTOOLS                    = $0030;  <user name>\Start Menu\Programs\Administrative Tools
  CSIDL_CONNECTIONS                   = $0031;  Network and Dial-up Connections
  CSIDL_COMMON_MUSIC                  = $0035;  All Users\My Music
  CSIDL_COMMON_PICTURES               = $0036;  All Users\My Pictures
  CSIDL_COMMON_VIDEO                  = $0037;  All Users\My Video
  CSIDL_RESOURCES                     = $0038;  Resource Directory
  CSIDL_RESOURCES_LOCALIZED           = $0039;  Localized Resource Directory
  CSIDL_COMMON_OEM_LINKS              = $003a;  Links to All Users OEM specific apps
  CSIDL_CDBURN_AREA                   = $003b;  USERPROFILE\Local Settings\Application Data\Microsoft\CD Burning
  CSIDL_COMPUTERSNEARME               = $003d;  Computers Near Me (computered from Workgroup membership)
  CSIDL_PROFILES                      = $003e;
}
var
   FilePath: array [0..255] of char;

begin
 SHGetSpecialFolderPath(0, @FilePath[0], FOLDER, CanCreate);
 Result := FilePath;
end;

function LocaleStrFromFloat(f: double): ansistring;
const
  HASH_FORMAT_STR = 'dmmyyyyhnnssddddzzza/p';
var
  AFormatSettings: TFormatSettings;
begin
  GetLocaleFormatSettings($1409, AFormatSettings); // use NZ as the LocaleID
  result := RawByteString(FormatDateTime(HASH_FORMAT_STR, f, AFormatSettings));
end;


procedure DecryptAndSave(anEP2File: String);
var
  BlowFish: TDCP_Blowfish;
  DecryptStream       : TMemoryStream;
  EncryptStream       : TFileStream;
  DeCompressionStream : TStream;
  DestinationStream   : TStream;
  SourceStream        : TStream;
  EP2TempPath : String;
begin
  BlowFish := TDCP_Blowfish.Create(nil);
  BlowFish.InitStr(LocaleStrFromFloat(2.718), TDCP_Sha1);
  EncryptStream := TFileStream.Create(anEP2File, fmOpenRead);
  DecryptStream := TMemoryStream.Create;
  Blowfish.DecryptStream(EncryptStream, DecryptStream, EncryptStream.Size);
  Blowfish.Burn;
  EncryptStream.Free;
  DecryptStream.Position := 0;
  EP2TempPath   := ScsTempDataPath;
  DecryptStream.SaveToFile(EP2TempPath+'ep2temp.zlib');
  DecryptStream.Free;
  BlowFish.Free;
  SourceStream := TFileStream.Create(EP2TempPath+'ep2temp.zlib', fmOpenRead);
  try
    DeCompressionStream := TDecompressionStream.Create(SourceStream);
    try
      DestinationStream := TFileStream.Create(EP2TempPath+'ep2temp.txt', fmCreate);
      try
        DestinationStream.CopyFrom(DeCompressionStream, 0);
      finally
        FreeAndNil(DestinationStream);
      end;
    finally
      FreeAndNil(DeCompressionStream);
    end;
  finally
    FreeAndNil(SourceStream);
  end;
end;


Function ExtractBetween(const Value, A, B: string): string;
var
  aPos, bPos: Integer;
begin
  result := '';
  aPos := Pos(A, Value);
  if aPos > 0 then begin
    aPos := aPos + Length(A);
    bPos := PosEx(B, Value, aPos);
    if bPos > 0 then begin
      result := Copy(Value, aPos, bPos - aPos);
    end;
  end;
end;

//Answer with regular expression
function ExtractStringBetweenDelims(Input : String; Delim1, Delim2 : String) : String;
var
  Pattern : String;
  RegEx   : TRegEx;
  Match   : TMatch;
begin
 Result := '';
 Pattern := Format('^%s(.*?)%s$', [Delim1, Delim2]);
 RegEx := TRegEx.Create(Pattern);
 Match := RegEx.Match(Input);
 if Match.Success and (Match.Groups.Count > 1) then
   Result := Match.Groups[1].Value;
end;

END.
