unit UpdateUtilsU;

interface

uses
  SysUtils, Classes,
  DCPBlowfish,
  DCPSha1,
  ZLib;

  procedure DecryptAndDecompressFile(SrcFile, TgtFile: TFileName);

implementation

const
  HASH_STR: AnsiString = 'Scottsdale';

procedure DecryptStream(InStream, OutStream: TStream);
var
  Cipher: TDCP_blowfish;
begin
  Cipher := TDCP_blowfish.Create(nil);
  try
    Cipher.InitStr( HASH_STR, TDCP_sha1 );
    OutStream.Position := 0;  InStream.Position := 0;
    Cipher.DecryptStream(InStream, OutStream, InStream.Size);
    Cipher.Burn;
  finally
    Cipher.Free;
  end;
end;

procedure DecompressStream(InStream, OutStream: TStream);
const
  READ_SIZE = 4096;     //1024
var
  ds: TDecompressionStream;
  buffer: array[0..pred(READ_SIZE)]of Byte;
  nRead: Integer;
begin
  InStream.Position := 0;
  ds := TDecompressionStream.Create(InStream);
  try
    OutStream.Position := 0;
    repeat
      nRead := ds.Read(buffer, READ_SIZE);
      OutStream.Write(buffer, nRead);
    until nRead=0;
  finally
    ds.Free;
  end;
end;

procedure DecryptAndDecompressFile(SrcFile, TgtFile: TFileName);
var
  InFileStream, OutFileStream: TFileStream;
  ms: TMemoryStream;
begin
  if not FileExists(SrcFile)then
    exit;
  InFileStream := TFileStream.Create(SrcFile, fmOpenRead);
  try
    ms := TMemoryStream.Create;
    try
      DecryptStream(InFileStream, ms);
      OutFileStream := TFileStream.Create(TgtFile, fmCreate);
      try
        DecompressStream(ms, OutFileStream);
      finally
        OutFileStream.Free;
      end;
    finally
      ms.Free;
    end;
  finally
    InFileStream.Free;
  end;
end;

END.
