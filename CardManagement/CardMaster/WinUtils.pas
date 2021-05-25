unit WinUtils;

interface
{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}

uses Windows, sysUtils, shlObj, FileCtrl, Dialogs, ComObj, ActiveX;

function PickADirectory(ACaption: string; var Directory: string; AFileName: string= ''): Boolean;
function ScsProgramDataPath: string;
function GetUserName: string;
function GetDomainName: string;
Procedure GetDomainAndUserName(out Domain : string; out User : string);
function GetComputerName: string;
function GetSpecialFolderPath(folder: Integer): string;
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
function CreateGuid: string;
var
   ID: TGUID;
begin
   Result := '';
   if CoCreateGuid(ID) = S_OK then
     Result := GUIDToString(ID);
end;

END.
