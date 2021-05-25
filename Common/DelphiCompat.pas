unit DelphiCompat;

interface

uses Windows, Sysutils, Classes;

{$IFNDEF UNICODE}   // UNICODE in Delphi 2009 or higher only
type
  UnicodeString  = WideString;
  PUnicodeString = PWideString;

  RawByteString  = AnsiString;
  PRawByteString = PAnsiString;

const
  varUString = 256;
  varStr = varString;

function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean; overload;
function CharInSet(C: WideChar; const CharSet: TSysCharSet): Boolean; overload;

{$ELSE}
const
  varStr = varUString;
{$ENDIF}

implementation

{$IFNDEF UNICODE}   // UNICODE in Delphi 2009 or higher only

function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean;
begin
  Result := C in CharSet;
end;

function CharInSet(C: WideChar; const CharSet: TSysCharSet): Boolean;
begin
  Result := AnsiChar(C) in CharSet;
end;

{$ENDIF}

end.
