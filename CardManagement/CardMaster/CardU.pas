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
    SW12   : Word;
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
    CardID: AnsiString;
    MachineTotal : AnsiString;
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

function CardErrorToString(ErrorCode: Word): string;
begin
  case ErrorCode of
    $9000: result := 'OK';
    $9100: result := 'OK';
    $6200: result := 'State of non-volatile memory unchanged';
    $6281: result := 'State of non-volatile memory unchanged. Part of returned data may be corrupted.';
    $6282: result := 'State of non-volatile memory unchanged. End of file/record reached before reading Le bytes.';
    $6283: result := 'State of non-volatile memory unchanged. Selected file invalidated.';
    $6284: result := 'State of non-volatile memory unchanged. FCI not formatted.';

    $6300: result := 'State of non-volatile memory changed.';
    $6381: result := 'State of non-volatile memory changed. File filled up by the last write.';

    $6400: result := 'State of non-volatile memory unchanged.';
    $6500: result := 'State of non-volatile memory changed.';
    $6581: result := 'State of non-volatile memory changed. Memory Failure.';

    $6700: result := 'Wrong length.';
    $6800: result := 'Functions in CLA not supported.';
    $6881: result := 'Functions in CLA not supported. Logical channel not supported.';
    $6882: result := 'Functions in CLA not supported. Secure messaging not supported.';

    $6900: result := 'Command not allowed. ';
    $6981: result := 'Command not allowed. Command incompatible with file structure.';
    $6982: result := 'Command not allowed. Security status not satisfied.';
    $6983: result := 'Command not allowed. Authentication method blocked.';
    $6984: result := 'Command not allowed. Referenced data invalidated.';
    $6985: result := 'Command not allowed. Conditions of use not satisfied.';
    $6986: result := 'Command not allowed. Command not allowed (no current EF).';
    $6987: result := 'Command not allowed. Expected SM data objects missing.';
    $6988: result := 'Command not allowed. SM data objects incorrect.';

    $6A00: result := 'Wrong parameters P1 or P2.';
    $6A80: result := 'Wrong parameter. Incorrect parameters in the data field.';
    $6A81: result := 'Wrong parameter. Function not supported.';
    $6A82: result := 'Wrong parameter. File not found.';
    $6A83: result := 'Wrong parameter. Record not found.';
    $6A84: result := 'Wrong parameter. Not enough memory space in the file.';
    $6A85: result := 'Wrong parameter. Lc inconsistent with TLV structure.';
    $6A86: result := 'Wrong parameters P1 or P2.';
    $6A87: result := 'Wrong parameter. Lc inconsistent with P1-P2.';
    $6A88: result := 'Wrong parameter. Referenced data not found.';

    $6B00: result := 'Wrong parameters P1 or P2.';
    $6D00: result := 'Instruction code not supported or invalid.';
    $6E00: result := 'Class byte not supported.';
    $6F00: result := 'Unknown error.';
  else begin
      case (ErrorCode shr 8) and $FF of
        $61: result := IntToStr(ErrorCode and $FF) + ' response bytes are still available.';
        $63:
          begin
            result := 'State of non-volatile memory changed.';
            if (ErrorCode and $F0) = $C0 then
            begin
              result :=result +#10#13+ 'You have try wrong card on this machine';
              result :=result +#10#13+ 'Remaining retry counter now is ' + IntToStr(ErrorCode and $0F);
              result :=result +#10#13+ 'Be careful, every wrong try will decrease 1 counter';
              result :=result +#10#13+ 'If remaining retry counter decrease to 0, the card will blocked';
            end;
          end;
        $64: result := 'State of non-volatile memory unchanged.';
        $6C: result := 'Wrong length Le: ' + IntToStr((ErrorCode and $FF)) + ' expected.';
        $90: result := 'OK. ' + IntToStr((ErrorCode and $FF)) + ' response byte(s) available';
        $91: result := 'DESFire specific error code: ' { + DESFireStatusToString(ErrorCode and $FF) };
        $9F: result := 'OK. ' + IntToStr((ErrorCode and $FF)) + ' response byte(s) available';
      else result := 'Unknown error code.';
      end;
    end;
  end;
end;


function TCard.DecryptMT: longint;
// *Returns integer of the decrypted MT (machine total for steel)
var
  ts        : AnsiString;
  SeedText  : AnsiString;
  Key128    : TKey128;
begin
  SeedText := String(FloatToStr(exp(pi)));
  GenerateLMDKey(Key128, Sizeof(Key128), SeedText);
  ts := TripleDESEncryptStringEx(MachineTotal, Key128, False); // decrypt
  result := StrToInt(ts);
end;

procedure TCard.EncryptMT(mt: longint);
// *encrypts mt into machinetotal string (machine total for steel)
const
  Spaces = '            ';
var
  ts       : AnsiString;
  SeedText : AnsiString;
  Key128   : TKey128;
begin
  ts := String(IntTostr(mt));
  ts := copy(Spaces, 1, 12 - length(ts)) + ts;
  SeedText := String(FloatToStr(exp(pi)));
  GenerateLMDKey(Key128, Sizeof(Key128), SeedText);
  MachineTotal := TripleDESEncryptStringEx(ts, Key128, True); // encrypt
end;

destructor TCard.Destroy;
begin
  FreeLibrary(DLLHandle);
  FDes.Burn; // released
  inherited;
end;

constructor TCard.Create(AOwner: TComponent);
begin
  inherited;
  FDES := TDes.Create(self);
  FDES.CipherMode := ECB;
  FDES.StringMode := smEncode;
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
// *Open Smart Card reader using dll calls
var
  res: Smallint;
begin
  res := CTInit(0, 0);
  if res<>0 then
    raise ECardReadError.Create('open reader');
  // ky11:=63; ky12:=201; ky9:=152; ky10:=183;
end;

function TCard.CloseReader: boolean;
// *Closes Smart Card reader
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
  if (res = 0) and (Lr >= 2) then
  begin
    SW12 := ((PByteArray(rspptr)^[Lr - 2]) shl 8) or PByteArray(rspptr)^[Lr - 1];
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    for i := 1 to Lr - 2 do
      resp := resp + AnsiChar(Rsp[i]);
    if (sw1 <> $90) or (sw2 <> 1) then
    Begin
      raise Exception.Create(CardErrorToString(SW12));
    End;
  end
  else
    raise ECardReadError.Create('');
end;

function TCard.BuildMacBlocks(tag: byte; ctc: ctcarray; hdr, si: ansistring; var so: ansistring): Integer;
// *Builds so data blk. See GemPlus s/card manual
var
  bc  : Integer;
  i   : Integer;
  ts  : AnsiString;

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
  so := AnsiChar(tag) + AnsiChar(ctc[1]) + AnsiChar(ctc[2]) + hdr;
  inc(bc);
  if Length(ts) > 7 then
  begin
    for i := 1 to (Length(si) div 7) do
    begin
      so := so + AnsiChar(tag) + copy(ts, 1, 7);
      delete(ts, 1, 7);
    end;
    so := so + AnsiChar(tag) + ts + pad(tag, 7 - Length(ts));
    bc := bc + Length(si) div 7 + 1;
  end
  else
  begin
    so := so + AnsiChar(tag) + si + pad(tag, 7 - Length(si));
    inc(bc);
    if Length(si) = 7 then
      inc(bc);
  end;
  result := bc;
end;

procedure TCard.ReadCounter;
var
  i   : Word;
  res : SmallInt;
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
  if (res = 0) and (Lr >= 2) then
  begin
    SW12 := ((PByteArray(rspptr)^[Lr - 2]) shl 8) or PByteArray(rspptr)^[Lr - 1];
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    for i := 1 to Lr - 2 do
      resp := resp + AnsiChar(Rsp[i]);
    if (sw1 <> $90) or (sw2 <> 0) then
      raise Exception.Create(CardErrorToString(SW12));
    MachineTotal := resp; // encrypted card total
  end
  else
    raise ECardReadError.Create('');
end;

procedure TCard.ReadID;
// *Returns s/card ID (programmed user name)
// *See GemPlus manual for cmd data structures
var
  i   : Word;
  res : SmallInt;
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
    SW12 := ((PByteArray(rspptr)^[Lr - 2]) shl 8) or PByteArray(rspptr)^[Lr - 1];
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    if (sw1 <> $90) or (sw2 <> 0) then
    Begin
      raise Exception.Create(CardErrorToString(SW12));
    End;
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
  key1     : AnsiString;
  key2     : AnsiString;
  hdr      : AnsiString;
  si       : AnsiString;
  so       : AnsiString;
  s        : AnsiString;
  bc       : Byte;
  i        : Integer;
  blk1     : TBlock;
  blk2     : TBlock;
  res      : Smallint;
  ts       : AnsiString;
  seedtext : AnsiString;
  Key128   : TKey128;
  tag      : Byte;
  mac      : AnsiString;


  function XorBlks(b1, b2: TBlock): TBlock;
  // *XOR 2 arrays
  var
    ts : TBlock;
    i  : Integer;
  begin
    for i := 0 to 7 do
      ts[i] := b1[i] xor b2[i];
    result := ts;
  end;

  function StrToBlk(s: AnsiString): TBlock;
  // *Convert string into integer array
  var
    i     : Integer;
    inblk : TBlock;
  begin
    for i := 0 to 7 do
      inblk[i] := ord(s[i + 1]);
    result := inblk;
  end;

  function BlktoStr(b: TBlock): AnsiString;
  // *Convert Integer array -> string
  var
    i: Integer;
  begin
    s := '00000000';
    For i := 0 to 7 do
      s[i + 1] := AnsiChar(b[i]);
    result := s;
  end;

begin { of UpdateCardTotal }
  // Smart Card Keys
  // ==============================================================================
  { Compiler directive to select encryption for panels or trusses }
{$IFDEF Panel}
  // ScotRF panel keys
  // ==============================
  ts := String(FloatToStr(sqrt(sin(ln(pi))))); // Panel Card version 5
  SeedText := String(FloatToStr(pi * pi * pi));
  GenerateLMDKey(Key128, Sizeof(Key128), SeedText);
  ts := TripleDESEncryptStringEx(ts, Key128, true);
{$ELSE}
  ts := FloatToStr(cos(sqr(ln(pi * pi))));
  SeedText := FloatToStr(exp(pi * pi)); // Truss Card version 5
  GenerateLMDKey(Key128, Sizeof(Key128), SeedText);
  ts := TripleDESEncryptStringEx(ts, Key128, true);
{$ENDIF}
  data := MachineTotal;

  tag    := $81; { lc=8 or 24 }
  Dad    := 0;
  Sad    := 2; { p2=sfi 20:2 28:3 }
  cla    := 4;
  ins    := $DC;
  p1     := 1;
  p2     := 20;
  Lc     := $20;
  le     := $20;
  cmdlen := 37;
  key1   := copy(ts, 1, 8);
  key2   := copy(ts, 9, 8);
  ts     := 'fjfdsfdsygrh'; { overwrite key }

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

  hdr  := AnsiChar(cla) + AnsiChar(ins) + AnsiChar(p1) + AnsiChar(p2) + AnsiChar(Lc);
  si   := data;
  bc   := BuildMacBlocks(tag, ctc, hdr, si, so);
  blk1 := StrtoBlk(zeros);
  for i := 1 to bc - 1 do { des for blks 1 .. n-1 }
  begin
    blk2 := StrToBlk(copy(so, 1, 8));
    blk1 := XorBlks(blk1, blk2);
    delete(so, 1, 8);
    FDES.initialiseString(key1);
    FDES.EncBlock(blk1, blk2);
    blk1 := blk2;
  end;
  { 3des for blk n }
  // if length(so) <> 8 then showmessage('Internal security error');
  blk2 := StrToBlk(copy(so, 1, 8));
  blk1 := XorBlks(blk1, blk2);
  FDES.InitialiseString(key1);
  FDES.EncBlock(blk1, blk2);
  blk1 := blk2;
  FDES.InitialiseString(key2);
  FDES.DecBlock(blk1, blk2);
  blk1 := blk2;
  FDES.initialiseString(key1);
  FDES.EncBlock(blk1, blk2);
  blk1 := blk2;
  mac := BlkToStr(blk1); { BuildCmd }

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
  FillChar(Rsp, Sizeof(Rsp), 32);
  cmdptr := addr(Cmd);
  rspptr := addr(Rsp);
  res := CTData(0, Dad, Sad, cmdlen, cmdptr, Lr, rspptr);
  if (res = 0) or (lr>=2) then
  begin
    SW12 := ((PByteArray(rspptr)^[Lr - 2]) shl 8) or PByteArray(rspptr)^[Lr - 1];
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    if (sw1 <> $61) or (sw2 <> 10) then
      raise Exception.Create(CardErrorToString(SW12));
  end
  else
    raise ECardUpdateError.Create('card update failed, NOT((res = 0) or (lr>=2))');

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
  Lc := 8; // verify
//  Lc := 0;  //check count

  le := 0;
  cmdlen := 13;
{$IFDEF Truss}
  data := #$7A + #$55 + #$FF + #$C5 + #$02 + #$D7 + #$27 + #$82;  // TrussCard v 5
{$ELSE}
  data := #$AC + #$E3 + #$1B + #$A5 + #$C2 + #$D7 + #$20 + #$52;  // PanelCard v 5
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
  if (res = 0) and (Lr >= 2) then
  begin
    SW12 := ((PByteArray(rspptr)^[Lr - 2]) shl 8) or PByteArray(rspptr)^[Lr - 1];
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    if (sw1 <>$90) or (sw2 <>0) then
      raise Exception.Create(CardErrorToString(SW12));
  end
  else
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
  I    : Word;
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
  if (res = 0) and (lr>=2)  then
  begin
    SW12 := ((PByteArray(rspptr)^[Lr - 2]) shl 8) or PByteArray(rspptr)^[Lr - 1];
    sw1 := ord(Rsp[Lr - 1]);
    sw2 := ord(Rsp[Lr]);
    if (sw1 <> $90) or (sw2 <> 0) then
    Begin
      raise Exception.Create(CardErrorToString(SW12));
    End;
  end
  else
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
// verify Pin removed due to frequent bad-cards being reported by customers
 VerifyPIN;
    ReadCounter;
    ReadID;

{$IFNDEF RELEASE}
//   setcard(1000); {$message warn 'SETCARD'}
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
