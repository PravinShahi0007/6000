unit RegU;

{
Routines for Registration and Activation codes
}

interface
{$WARN SYMBOL_PLATFORM OFF}
uses
  Windows, SysUtils,
  Classes, Forms,
  Dialogs;

  function LocaleStrFromFloat(f: Double): AnsiString;
  function CheckReg: Bool;

implementation

uses
  DCPBlowfish, DCPSha1,
  VersionU, WallGlobal;

var
  sRg: string;     //reg string
  sRegFilename: string;

function HasValidChars(s: ShortString): Bool;
var
  i: Integer;
  ValidChars: set of AnsiChar;
begin
  Result := False;
  if Length(s) <> 8 then
    exit;
  ValidChars := ['0'..'9', 'a'..'f', 'A'..'F'];
  for i:=1 to 8 do
    if not CharInSet(s[i], ValidChars)then
      exit;
  Result := True;
end;

//* Gets a hash from a real number, the hash is a fomatted date-time string
//* otherwise the application changes the words to the word at the user's locale
function LocaleStrFromFloat(f: Double): AnsiString;
const
  HASH_FORMAT_STR = 'dmmyyyyhnnssddddzzza/p';
var
  AFormatSettings: TFormatSettings;
begin
  GetLocaleFormatSettings($1409,  AFormatSettings);   //use NZ as the LocaleID
  Result := RawByteString(FormatDateTime(HASH_FORMAT_STR, f, AFormatSettings));
end;

procedure WriteRegFile(AReg: string);
var
  fs: TFileStream;
  StrStream: TStringStream;
  Cipher: TDCP_blowfish;
  s: string[8];
  iAttributes: Integer;
begin
  s := RawByteString(AReg);
  if not HasValidChars(s)then
    exit;
  if FileExists(sRegFilename)then
    DeleteFile(sRegFilename);
  StrStream := TStringStream.Create(s);
  try
    fs := TFilestream.Create(sRegFilename, fmCreate);
    try
      Cipher := TDCP_blowfish.Create(nil);
      try
        Cipher.InitStr( LocaleStrFromFloat(3.1415), TDCP_sha1 );
        fs.Position := 0;  StrStream.Position := 0;
        Cipher.EncryptStream(StrStream, fs, StrStream.Size);
        Cipher.Burn;
      finally
        Cipher.Free;
      end;
    finally
      fs.Free;
    end;
  finally
    StrStream.Free;
  end;

  try
    iAttributes := FileGetAttr(sRegFilename); //Get File Attributes
    iAttributes := iAttributes or faHidden;  //add the Hidden attribute
    FileSetAttr(sRegFilename, iAttributes);  //and set the new Attributes Returns 0 = Success
  except
    //
  end;
end;

procedure ReadRegFile;
var
  fs: TFileStream;
  StrStream: TStringStream;
  Cipher: TDCP_blowfish;
  s: string;
  nAct, nVol, nReg, nRegReadOnly, nRegPanelOnly: Cardinal;
begin
  sRg := '';
  if not FileExists(sRegFilename)then
    exit;
  Cipher := TDCP_blowfish.Create(nil);
  try
    Cipher.InitStr( LocaleStrFromFloat(3.1415), TDCP_sha1 );
    fs := TFileStream.Create(sRegFilename, fmOpenRead);
    try
      StrStream := TStringStream.Create(s);
      try
        Cipher.DecryptStream(fs, StrStream, fs.Size);
        sRg := StrStream.DataString;
        Cipher.Burn;
      finally
        StrStream.Free;
      end;
    finally
      fs.Free;
    end;
  finally
    Cipher.Free;
  end;

  nAct := High(Cardinal) - GetVolNum + Sqr(GetBuildNumber);
  nVol := High(Cardinal) - nAct + Sqr(GetBuildNumber);
  if nAct > nVol then
    nReg := nAct - nVol
  else
    nReg := nVol - nAct;
  try
    if not SameText(IntToHex(nReg, 8), sRg) then
    begin
      nRegReadOnly := (nReg div 3) + 5;     //try the readonly number
      bReadOnly := SameText(IntToHex(nRegReadOnly, 8), sRg);
      if not bReadOnly then
      begin
        nRegPanelOnly := (nReg div 5) + 3;     //try the panel only number
        if SameText(IntToHex(nRegPanelOnly, 8), sRg) then
        begin
          bShowTrusses := False;
          bShowTrussTools := False;
          bPanelOnly := True;
        end
        else
          sRg := '';
      end;
    end;
  except
    sRg := '';
  end;
end;

function CheckReg: Bool;
const
  MSG = 'Your Activation code is:' + #13#10
      + #9+ '%s' + #13#10
      + 'Please enter your serial number';
var
  s: string;
begin
  //debug reg no.
  //InputQuery('Registration', format(MSG, [ActivationCode]), sRg);

  Result := False;

  sRegFilename := ExtractFilePath(ParamStr(0)) + 'reg.dat';
  ReadRegFile;
  if sRg = '' then
  begin
    if not InputQuery('Registration', format(MSG, [ActivationCode]), s)then
      exit;
    if s <> '' then
    begin
      WriteRegFile(s);
      ReadRegFile;
    end
    else
      exit;
  end;

  Result := sRg <> '';
end;

END.
