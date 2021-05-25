unit VersionU;
{
Unit to get program version no.
Author - Bruce
}

interface

uses
  Windows, SysUtils, Forms;

  function GetFileVersion: string;
  //procedure DecodeVersion(var sMajor, sMinor, sRelease, sBuild: string);
  function GetReleaseNumber: Single;
  function GetBuildNumber: Word;
  function GetVolNum: Cardinal;
  function ActivationCode: string;

implementation

{sInfo can be:
       CompanyName
       FileDescription
       FileVersion
       InternalName
       LegalCopyright
       OriginalFilename
       ProductName
       ProductVersion
above are predefined Win32 API strings,
I guess other Keys can be included if these are in the EXE VerInfo
}
function GetVerInfo(sInfo: string): string;
const
  FILE_INFO = 'StringFileInfo\140904E4\';
var
  s: string;
  n, Len: DWORD;
  Buf, Value: PChar;
begin
  Result := '';
  s := Application.ExeName;
  n := GetFileVersionInfoSize(PChar(S), n);
  Buf := AllocMem(n);
  try
    GetFileVersionInfo(PChar(s), 0, n, Buf);
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

function GetReleaseNumber: Single;
var
  sMajor, sMinor, sRelease, sBuild: string;
begin
  try
    DecodeVersion(sMajor, sMinor, sRelease, sBuild);
    Result := StrToFloat(sRelease);
  except
    Result := 0;
  end;
end;

//not dynamic, just here for encryption
function GetBuildNumber: Word;
begin
  Result := 8250;
end;

//was called ... function GetHDDSerial: Cardinal;
function GetVolNum: Cardinal;
var
  a, b: DWORD;
  Buffer: array [0..255] of Char;
 { Drive: Char;
  s: string;         }
begin
  //GetVolumeInformation('c:\', Buffer, SizeOf(Buffer), @Result, a, b, nil, 0);

  //Better to look for HDD letters?????  like ...
  //Get the first HDD found
  {
  s := '';
  for Drive := 'a' to 'z' do
  begin
    s := Drive + ':\';
    if GetDriveType(PChar(s)) = DRIVE_FIXED then
      break;
  end;
  if s = '' then
    s := 'c:\';
  GetVolumeInformation(PChar(s), Buffer, SizeOf(Buffer), @Result, a, b, nil, 0);
  }
  GetVolumeInformation(nil, Buffer, SizeOf(Buffer), @Result, a, b, nil, 0);
end;

function ActivationCode: string;
var
  s: string;
begin
  s := IntToHex( High(Cardinal) - GetVolNum + Sqr(GetBuildNumber), 8);
  Result := LowerCase( IntToHex(GetBuildNumber, 4) + '-' + s );
end;

END.
