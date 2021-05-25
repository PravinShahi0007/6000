unit CardU;

interface
{$ifdef TRUSS} {$IFDEF PANEL}
  {$MESSAGE FATAL 'TRUSS + PANEL'}
{$ENDIF} {$ENDIF}
{$ifndef TRUSS} {$IFnDEF PANEL}
  {$MESSAGE FATAL '-TRUSS + -PANEL'}
{$ENDIF} {$ENDIF}

uses Windows, dialogs, sysutils, classes, DES;

Type
  ECardException=class(exception)
  end;
  ECardEmpty=class(ECardException)
  end;
  EAlienCard=class(ECardException)
  end;
  ECardReadError=class(ECardException)
  end;
  ECardUpdateError=class(ECardException)
  end;
type
  ctcarray = array [1 .. 2] of byte;

  TCard = class(TComponent)

  private type
    //smartcard DLL definitions
    TCTInit = function(Ctn, Pn: word): Smallint; stdcall;
    TCTClose = function(Ctn: word): Smallint; stdcall;
    TCTData = function(Ctn: word; var Dad, Sad: byte; Lc: uint16; Cmd: pansiChar; var Lr: uint16; Rsp: pansiChar): Smallint; stdcall;
  private var
    FDES: TDES;
    DLLHandle: THandle;
    DLLName: PChar;

    // smartcard DLL function pointers
    CTInit: TCTInit;
    CTData: TCTData;
    CTClose: TCTClose;

   { TODO make these locals}
    sw1, sw2: byte;
    cmdlen : uint16;
    ctc: ctcarray;
    data, resp: ansistring;
    cmdptr, rspptr: pansiChar;
    Sad, Dad, cla, ins, p1, p2, Lc, le: byte;
    Lr: uint16;
    Cmd: array[1 .. 100] of byte;
    Rsp: array [1 .. 300] of byte;
  private
    function GetOSName: string;
    procedure SelectDLL;
    procedure OpenReader;
    procedure Checkcard;
    function BuildMacBlocks(tag: byte; ctc: ctcarray; hdr, si: ansistring; var so: ansistring): Integer;
    procedure ReadCounter;
    procedure ReadCTC;
    procedure  ReadID;
    procedure UpdatecardTotal;
    procedure VerifyPIN;
  public
    CardID: ansistring;
     machinetotal: string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CheckCardOK: boolean;
  { TODO: make these private }
    function DecryptMT: longint;
    procedure EncryptMT(mt: Integer);
    function CloseReader: boolean;
    procedure SetCard(N: integer);
  end;

//var Card: TCard; // singleton

implementation

uses LbCipher, lbString;

function TCard.DecryptMT: longint;
// *Returns integer of the decrypted MT (machine total for steel)
var
  ts, seedtext: ansistring;
  Key128: TKey128;
begin
  seedtext := string(floattostr(exp(pi)));
  GenerateLMDKey(Key128, Sizeof(Key128), seedtext);
  ts := TripleDESEncryptStringEx(machinetotal, Key128, false); // decrypt
  result := strtoint(ts);
end;

destructor TCard.Destroy;
begin
  FreeLibrary(DLLHandle);
  FDes.Burn; // released
  inherited;
end;

procedure TCard.EncryptMT(mt: longint);
// *encrypts mt into machinetotal string (machine total for steel)
const
  spaces = '            ';
var
  ts, seedtext: ansistring;
  Key128: TKey128;
begin
  ts := string(inttostr(mt));
  ts := copy(spaces, 1, 12 - length(ts)) + ts;
  seedtext := string(floattostr(exp(pi)));
  GenerateLMDKey(Key128, Sizeof(Key128), seedtext);
  machinetotal := TripleDESEncryptStringEx(ts, Key128, true); // encrypt
end;

constructor TCard.Create(AOwner: TComponent);
begin
  inherited;
  FDES := TDes.Create(self);
  FDES. CipherMode := ECB;
  FDES. StringMode := smEncode;
  SelectDLL;
  { Initialize MT (machine total) and CD (card delta) encrypted vars }
  EncryptMT(0); // 3DES for machinetotal & carddelta
end;

function TCard.GetOSName: string;
// *Returns OS name as string - used for s/card dll selection
var
  OsInfo: TOSVERSIONINFO;
begin
  OsInfo.dwOSVersionInfoSize := Sizeof(TOSVERSIONINFO);
  GetVersionEx(OsInfo);
  case OsInfo.dwPlatformId of
    VER_PLATFORM_WIN32s:
      result := 'Win16'; { Windows 3.1 }
    VER_PLATFORM_WIN32_WINDOWS:
      result := 'Win16'; { Windows 95 }
    VER_PLATFORM_WIN32_NT:
      begin
        Case OsInfo.dwMajorVersion of
          5:
            result := 'Win32'; { Windows 2000(minor=0), XP(minor=1) }
        else
          result := 'Win32' { Windows NT }
        end;
      end;
  end;
end;

procedure TCard.SelectDLL;
// *Selects DLL based on OsType string
var OSType: string;
begin
  OSType := GetOSName;
  if OSType = 'Win32' then
    DLLName := 'Ctpcsc.dll'
  else
    DLLName := 'Ctscrw95.dll';
  DLLHandle := LoadLibrary(DLLName);
  try
    if DLLHandle > 0 then
    begin
      @CTInit := GetProcAddress(DLLHandle, 'CT_init');
      @CTClose := GetProcAddress(DLLHandle, 'CT_close');
      @CTData := GetProcAddress(DLLHandle, 'CT_data');
    end
    else
      MessageDlg('Error: ' + DLLName + ' not found', mtInformation, [mbOK], 0);
  finally
  end;
end;

procedure TCard.OpenReader;
// *Open s/card reader using dll calls
var
  res: Smallint;
begin
  res := CTInit(0, 0);
  if res<>0 then
    raise ECardReadError.Create('open reader');
  // ky11:=63; ky12:=201; ky9:=152; ky10:=183;
end;

function TCard.CloseReader: boolean;
// *Closes s/card reader
var
  res: Smallint;
begin
  res := CTClose(0);
  result := res = 0;
end;

procedure TCard.Checkcard;
var
  i: word;
  res: Smallint;
begin
  Dad := 1;
  Sad := 2;
  cla := $20;
  ins := $10;
  p1 := 1;
  p2 := 1;
  Lc := 0;
  le := 0;
  cmdlen := 4;
  data := #0;

  Cmd[1] := cla;
  Cmd[2] := ins;
  Cmd[3] := p1;
  Cmd[4] := p2;
  Cmd[5] := Lc;
  for i := 1 to length(data) do
    Cmd[5 + i] := ord(data[i]);
  Cmd[6 + length(data)] := le;
  Lr := 15;
  resp := '';
  sw1 := 0;
  sw2 := 0;
  Fillchar(Rsp, Sizeof(Rsp), 32);

  cmdptr := addr(Cmd);
  rspptr := addr(Rsp);
  res := CTData(0, Dad, Sad, cmdlen, cmdptr, Lr, rspptr);

  if (res = 0) and
     (Lr >= 2) then
  begin
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    for i := 1 to Lr - 2 do
      resp := resp + ansichar(Rsp[i]);
    if (sw1 <> $90) or (sw2 <> 1) then
      raise ECardReadError.Create('');
  end
  else
    raise ECardReadError.Create('');
end;

function TCard.BuildMacBlocks(tag: byte; ctc: ctcarray; hdr, si: ansistring; var so: ansistring): Integer;
// *Builds so data blk. See GemPlus s/card manual
var
  bc, i: Integer;
  ts: ansistring;

  function pad(tag, n: byte): ansistring;
  const
    padding = #$80 + #0 + #0 + #0 + #0 + #0 + #0 + #0;
  begin
    if n = 0 then
      result := ansichar(tag) + copy(ansistring(padding), 1, 7)
    else
      result := copy(padding, 1, n);
  end;

begin { of BuildMacBlocks }
  so := '';
  ts := si;
  bc := 0;
  so := ansichar(tag) + ansichar(ctc[1]) + ansichar(ctc[2]) + hdr;
  inc(bc);
  if length(ts) > 7 then
  begin
    for i := 1 to (length(si) div 7) do
    begin
      so := so + ansichar(tag) + copy(ts, 1, 7);
      delete(ts, 1, 7);
    end;
    so := so + ansichar(tag) + ts + pad(tag, 7 - length(ts));
    bc := bc + length(si) div 7 + 1;
  end
  else
  begin
    so := so + ansichar(tag) + si + pad(tag, 7 - length(si));
    inc(bc);
    if length(si) = 7 then
      inc(bc);
  end;
  result := bc;
end;

procedure TCard.ReadCounter;
var
  i: word;
  res: Smallint;
  // *Reads the steel counter from s/card
  // *String data is also xor encrypted, to avoid user read of totals, outside SCS s/ware
  // *value is always stored in metres, and converted to feet if imperial
  // *See GemPlus manual for cmd data structures

begin
  Dad := 0;
  Sad := 2; { p2=sfi 20:2 28:3 }
  cla := 0;
  ins := $B2;
  p1 := 1;
  p2 := 20;
  Lc := 24;
  le := 0;
  cmdlen := 5;
  // dad:=0; sad:=2;          {p2=sfi 20:2 28:3}
  // cla:=0; ins:=$B2; p1:=1; p2:=20; lc:=8; le:=0; cmdlen:=5;
  data := #0;
  Cmd[1] := cla;
  Cmd[2] := ins;
  Cmd[3] := p1;
  Cmd[4] := p2;
  Cmd[5] := Lc;
  for i := 1 to length(data) do
    Cmd[5 + i] := ord(data[i]);
  Cmd[6 + length(data)] := le;
  Fillchar(Rsp, Sizeof(Rsp), 32);
  Lr := 35;
  resp := '';
  sw1 := 0;
  sw2 := 0;

  cmdptr := addr(Cmd);
  rspptr := addr(Rsp);
  res := CTData(0, Dad, Sad, cmdlen, cmdptr, Lr, rspptr);
  if (res = 0) and
     (Lr >= 2) then
  begin
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    for i := 1 to Lr - 2 do
      resp := resp + ansichar(Rsp[i]);
    if (sw1 <> $90) or (sw2 <> 0) then
      raise ECardReadError.Create('');
    machinetotal := resp; // encrypted card total
  end
  else
    raise ECardReadError.Create('');
end;

procedure TCard.ReadID;
// *Returns s/card ID (programmed user name)
// *See GemPlus manual for cmd data structures
var
  i: word;
  res: Smallint;
begin
  Dad := 0;
  Sad := 2; { p2=sfi 20:2 28:3 }
  cla := 0;
  ins := $B2;
  p1 := 1;
  p2 := 28;
  Lc := 24;
  le := 0;
  cmdlen := 5;
  data := #0;

  Cmd[1] := cla;
  Cmd[2] := ins;
  Cmd[3] := p1;
  Cmd[4] := p2;
  Cmd[5] := Lc;
  for i := 1 to length(data) do
    Cmd[5 + i] := ord(data[i]);
  Cmd[6 + length(data)] := le;
  Lr := 35;
  CardID := '';
  sw1 := 0;
  sw2 := 0;
  Fillchar(Rsp, Sizeof(Rsp), 32);

  cmdptr := addr(Cmd);
  rspptr := addr(Rsp);
  res := CTData(0, Dad, Sad, cmdlen, cmdptr, Lr, rspptr);
  if (res = 0) and (Lr >= 2) then
  begin
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    if (sw1 <> $90) or (sw2 <> 0) then
      raise ECardReadError.Create('');
  end else
    raise ECardReadError.Create('');

  for i := 1 to Lr - 2 do
    CardID := CardID + ansichar(Rsp[i]);
end;

procedure TCard.UpdatecardTotal;
// *Updates s/card steel total
// *Generates keys mathematically
// *data is encrypted in 3DES for s/card to decrypt
// *See GemPlus manual for cmd data structures
const
  zeros = #0 + #0 + #0 + #0 + #0 + #0 + #0 + #0;
var
  key1,key2, hdr, si, so, s: ansistring;
  bc: byte;
  i: Integer;
  blk1, blk2: tblock;
  res: Smallint;
  ts, seedtext: ansistring;
  Key128: TKey128;
  tag: byte;
  mac: ansistring;


  function XorBlks(b1, b2: tblock): tblock;
  // *XOR 2 arrays
  var
    ts: tblock;
    i: Integer;
  begin
    for i := 0 to 7 do
      ts[i] := b1[i] xor b2[i];
    result := ts;
  end;

  function StrtoBlk(s: ansistring): tblock;
  // *Convert string into integer array
  var
    i: Integer;
    inblk: tblock;
  begin
    for i := 0 to 7 do
      inblk[i] := ord(s[i + 1]);
    result := inblk;
  end;

  function BlktoStr(b: tblock): ansistring;
  // *Convert Integer array -> string
  var
    i: Integer;
  begin
    s := '00000000';
    for i := 0 to 7 do
      s[i + 1] := ansichar(b[i]);
    result := s;
  end;

begin { of UpdateCardTotal }
  // s/card keys
  // ==============================================================================
  { Compiler directive to select encryption for panels or trusses }
{$IFDEF Panel}
  // ScotRF panel keys
  // ==============================
{$IFDEF Version5Card}
  ts := string(floattostr(sqrt(sin(ln(pi))))); // Panel Card version 5
  seedtext := string(floattostr(pi * pi * pi));
{$ELSE}
  ts := string(floattostr(sqrt(ln(pi)))); // Panel Card version 4
  seedtext := string(floattostr(pi * pi));
{$ENDIF}
  GenerateLMDKey(Key128, Sizeof(Key128), seedtext);
  ts := TripleDESEncryptStringEx(ts, Key128, true);
{$ELSE}
{$IFDEF Version5Card}
  ts := floattostr(cos(sqr(ln(pi * pi))));
  seedtext := floattostr(exp(pi * pi)); // Truss Card version 5
{$ELSE}
  ts := floattostr(cos((ln(pi))));
  seedtext := floattostr(exp(pi)); // Truss Card version 4
{$ENDIF}
  GenerateLMDKey(Key128, Sizeof(Key128), seedtext);
  ts := TripleDESEncryptStringEx(ts, Key128, true);
{$ENDIF}
  data := machinetotal;

  tag := $81; { lc=8 or 24 }
  Dad := 0;
  Sad := 2; { p2=sfi 20:2 28:3 }
  cla := 4;
  ins := $DC;
  p1 := 1;
  p2 := 20;
  Lc := $20;
  le := $20;
  cmdlen := 37;
  key1 := copy(ts, 1, 8);
  key2 := copy(ts, 9, 8);
  ts := 'fjfdsfdsygrh'; { overwrite key }

  if ctc[2] < 255 then
    inc(ctc[2])
  else
  begin
    inc(ctc[1]);
    ctc[2] := 0;
  end;
  mac := ''; { build mac blocks from fields }

  // =================================================
  // key1:=#104+#41+#218+#127+#4+#139+#205+#57; //xor'd
  // xorwith(key1,'P#8!s0+?');
  // =================================================

  hdr := ansichar(cla) + ansichar(ins) + ansichar(p1) + ansichar(p2) + ansichar(Lc);
  si := data;
  bc := BuildMacBlocks(tag, ctc, hdr, si, so);
  blk1 := StrtoBlk(zeros);
  for i := 1 to bc - 1 do { des for blks 1 .. n-1 }
  begin
    blk2 := StrtoBlk(copy(so, 1, 8));
    blk1 := XorBlks(blk1, blk2);
    delete(so, 1, 8);
    FDES.initialiseString(key1);
    FDES.EncBlock(blk1, blk2);
    blk1 := blk2;
  end;
  { 3des for blk n }
  // if length(so) <> 8 then showmessage('Internal security error');
  blk2 := StrtoBlk(copy(so, 1, 8));
  blk1 := XorBlks(blk1, blk2);
  FDES.initialiseString(key1);
  FDES.EncBlock(blk1, blk2);
  blk1 := blk2;
  FDES.initialiseString(key2);
  FDES.DecBlock(blk1, blk2);
  blk1 := blk2;
  FDES.initialiseString(key1);
  FDES.EncBlock(blk1, blk2);
  blk1 := blk2;
  mac := BlktoStr(blk1); { BuildCmd }

  Cmd[1] := cla;
  Cmd[2] := ins;
  Cmd[3] := p1;
  Cmd[4] := p2;
  Cmd[5] := Lc;
  for i := 1 to length(si) do
    Cmd[5 + i] := ord(si[i]);
  for i := 1 to length(mac) do
    Cmd[length(si) + 5 + i] := ord(mac[i]);
  Cmd[6 + length(data) + length(si)] := le;
  Lr := 100;
  resp := '';
  sw1 := 0;
  sw2 := 0;
  Fillchar(Rsp, Sizeof(Rsp), 32);

  cmdptr := addr(Cmd);
  rspptr := addr(Rsp);
  res := CTData(0, Dad, Sad, cmdlen, cmdptr, Lr, rspptr);
  if (res = 0) or (lr>=2) then
  begin
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    if (sw1 <> $61) or (sw2 <> 10) then
      raise ECardUpdateError .Create('card update failed');
  end else
    raise ECardUpdateError.Create('card update failed');

  key1 := 'Scottsdale'; // clr keys
  key2 := '(C)opyright 2011';
end;

procedure TCard.VerifyPIN;
// *Returns true if s/card PIN is valid for truss or panel
// *PIN is held in secret key file on card
// *See GemPlus manual for cmd data structures
var
  i: word;
  res: Smallint;
begin
  Dad := 0;
  Sad := 2;
  cla := $0;
  ins := $20;
  p1 := 0;
  p2 := 0;
  Lc := 8;
  le := 0;
  cmdlen := 13;
{$IFDEF Truss}
{$IFDEF Version5Card}
  data := #$7A + #$55 + #$FF + #$C5 + #$02 + #$D7 + #$27 + #$82;
  // TrussCard v 5
{$ELSE}
  data := #198 + #207 + #160 + #106 + #135 + #20 + #188 + #212;
  // TrussCard v 3 and 4
{$ENDIF}
{$ELSE}
{$IFDEF Version5Card}
  data := #$AC + #$E3 + #$1B + #$A5 + #$C2 + #$D7 + #$20 + #$52;
  // PanelCard v 5
{$ELSE}
  data := #$1C + #$13 + #$7B + #05 + #$22 + #$B7 + #$B0 + #$D2;
  // PanelCard v 3 and 4
{$ENDIF}
{$ENDIF}
  Cmd[1] := cla;
  Cmd[2] := ins;
  Cmd[3] := p1;
  Cmd[4] := p2;
  Cmd[5] := Lc;
  for i := 1 to length(data) do
    Cmd[5 + i] := ord(data[i]);
  Cmd[6 + length(data)] := le;
  Lr := 10;
  resp := '';
  sw1 := 0;
  sw2 := 0;
  Fillchar(Rsp, Sizeof(Rsp), 32);
  cmdptr := addr(Cmd);
  rspptr := addr(Rsp);

  res := CTData(0, Dad, Sad, cmdlen, cmdptr, Lr, rspptr);
  if (res = 0) and
     (Lr >= 2) then
  begin
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    if (sw1 <>$90) or (sw2 <>0) then
      raise EAlienCard.Create('Invalid Scottsdale Card');
  end else
     raise ECardReadError.Create('');
end;

procedure TCard.ReadCTC;
// *Read the CTC from the card
// *This is used as a transaction counter for s/card updates
// *See GemPlus manual for cmd data structures
const
  zeros = #0 + #0 + #0 + #0 + #0 + #0 + #0 + #0;
var
  res: Smallint;
  i: word;
begin
  Dad := 0;
  Sad := 2;
  cla := $80;
  ins := $BE;
  p1 := $27;
  p2 := 1;
  Lc := 8;
  le := 0;
  cmdlen := 13;
  data := zeros;
  Cmd[1] := cla;
  Cmd[2] := ins;
  Cmd[3] := p1;
  Cmd[4] := p2;
  Cmd[5] := Lc;
  for i := 1 to length(data) do
    Cmd[5 + i] := ord(data[i]);
  Cmd[6 + length(data)] := le;
  Lr := 30;
  resp := '';
  sw1 := 0;
  sw2 := 0;
  Fillchar(Rsp, Sizeof(Rsp), 32);
  cmdptr := addr(Cmd);
  rspptr := addr(Rsp);
  res := CTData(0, Dad, Sad, cmdlen, cmdptr, Lr, rspptr);
  if res = 0 then
  begin
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
  end;
  if sw1 <> $61 then
   raise ECardReadError.Create('');
  Dad := 0;
  Sad := 2;
  cla := 0;
  ins := $C0;
  p1 := 0;
  p2 := 0;
  Lc := sw2;
  le := sw2;
  cmdlen := 5;

  Cmd[1] := cla;
  Cmd[2] := ins;
  Cmd[3] := p1;
  Cmd[4] := p2;
  Cmd[5] := Lc;
  for i := 1 to length(data) do
    Cmd[5 + i] := ord(data[i]);
  Cmd[6 + length(data)] := le;
  Lr := 50;
  resp := '';
  sw1 := 0;
  sw2 := 0;
  Fillchar(Rsp, Sizeof(Rsp), 32);
  cmdptr := addr(Cmd);
  rspptr := addr(Rsp);

  res := CTData(0, Dad, Sad, cmdlen, cmdptr, Lr, rspptr);
  if (res = 0) and
     (lr>=2)  then
  begin
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    if (sw1 <> $90) or (sw2 <> 0) then
      raise ECardReadError.Create('');
  end else
    raise ECardReadError.Create('');


  ctc[1] := ord(Rsp[1]);
  ctc[2] := ord(Rsp[2]);
end;

procedure TCard.SetCard(N: integer);
begin
  ReadCounter;
  EncryptMT(N);
  ReadCTC;
  UpdatecardTotal;
end;

function TCard.CheckCardOK: boolean;
begin
  CloseReader;
  // Check for valid card, valid pin & OK rad of the card total
  // all errors generate an exception
  try
    OpenReader;
    Checkcard;
//    VerifyPIN;
    ReadCounter;
    ReadID;

{$IFNDEF RELEASE}
//  setcard(10000); {$message warn 'SETCARD'}
{$ENDIF}
    result := true;
  except
    on e:ECardException do
    begin
//      showmessage (e.ClassName+' '+e.Message);
      result:=false;
    end;
  end;
end;

initialization
end.
