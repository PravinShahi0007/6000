
unit CardAcos3ConfigU;

interface

uses SysUtils, Classes, winUtils, lbCipher, cardBaseU;

const
  KEYLEN = 8;
  // KEY IDs for Submit Code command (ref. 6.4)
  KEY_AC1 = 1;
  KEY_AC2 = 2;
  KEY_AC3 = 3;
  KEY_AC4 = 4;
  KEY_AC5 = 5;
  KEY_PIN = 6;
  KEY_IC = 7;

const
  // Values for Select File command (ref. 3.3)
  // System files
  FILE_MCU_ID   = $00FF; // MCU_ID
  FILE_MFG      = $01FF; //
  FILE_PERS     = $02FF; // Personalization File
  FILE_SECURITY = $03FF;
  FILE_FIILEDEF = $04FF; // file definitions (User File Management)
  FILE_ACC      = $05FF; // ACCOUNT
  FILE_ACS      = $06FF; // Account Security
  FILE_ATR      = $07FF;
  // SCS files
  FILE_IDENTITY = $0A00; // INFO FILE
  FILE_CONTROL  = $0A01; // Data control FILE
  FILE_DATA     = $0A02; // Data FILE

// KEY for RECORDS in the Security File (0 based) (ref. 3.3.4)
// also used as parameter type for TAcosConfig.AcosKey[] etc
type TKEY_RECID=(
  KEYREC_IC = 0,
  KEYREC_PIN = 1,
  KEYREC_KC_LO= 2,
  KEYREC_KT_LO= 3,
  KEYREC_RNDSEED=4,
  KEYREC_AC1 = 5,
  KEYREC_AC2 = 6,
  KEYREC_AC3 = 7,
  KEYREC_AC4 = 8,
  KEYREC_AC5 = 9 ,
  KEYREC_RETRY_CNT = 10,
  KEYREC_RETRY_SCN = 11,
  KEYREC_KC_HI= 12,
  KEYREC_KT_HI=13);

const
  // read/write security attibutes bit masks  (ref. 3.4.1)
  SM_READ = $40;       // record file , Read requires SM
  SM_WRITE = $20;      // record file , Write requires SM
  SM_READWRITE = $60;  // record file , Read/Write      requires SM

const
  CURRENTSCHEMA=2;
{$A-}

type
  MCU_Rec= packed record            // ref 3.3.1
    Serial: Uint64;
    tag: array [0..4] of ansichar;  // 'ACOS3'
    Version: UInt16;
    Capacity: byte;
  end;

  MFG_Rec= packed record              // ref 3.3.2
    case Integer of                   // 2 x 8 byte records
      0: (MFG_Bit: boolean;           // bit7=M fuse bit, 6=IN_AV_MAC flag, bit 5=REC No. flag
          A_Bit: boolean;
          B_Bit: boolean; );
      1: (Bytes: array [0..15] of byte);
  end;

  PF_Rec= packed record              // ref 3.3.3
    case Integer of                  // 3 x 4 byte records
      0: (OptionsRegister: byte;
          SecurityRegister: byte;
          NFiles: uint8;
          P_Status: byte;
          unused: array [0..3] of byte;
          R3: UInt32; );
      1: (Data: array [0..2] of UInt32; );
  end;


// User File Definition Block (ref.3.4.1)
type
  TFileSpec = packed record
    RecLen: Byte;
    NRec: Byte;
    ReadSecurity: Byte;
    WriteSecurity: Byte;
    ID: Uint16;
    AccessFlags: Byte;
  end;
Type

  TUserIdentity = packed record
    User:   array[0..15] of ansichar;
    Domain: array[0..15] of ansichar;
    TimeStamp: TTimeStamp;
  end;

  TIdentityRec = packed record
    Spare1: Cardinal;
    SerialNumber: Cardinal;
    Product: array[0..7] of ansichar;          // 'SCSTRUSS' / 'SCSPANEL'
    Issuer: TUserIdentity;
    IssuedTo: array[0..15] of ansichar;
    ChargeScheme: TChargeType;
    Schema: uint8; // SCS Schema
    Fill: array[0..53] of byte; // pad to 128 bytes
  end;

   TControlRec = packed record
    Spare1: Cardinal;
    Issuer: TUserIdentity;
    CurrentRec: UInt16;
    Fill: array[0..81] of byte;  // pad to 128 bytes
   end;

   TSCSDataRec= packed record
    LastUpdate: TUserIdentity;
    MetresBfwd: Integer;
    MetresIssued: Integer;
    MetresRemaining: Integer;
    WriteCount: Integer;
    Expiry:  Cardinal; // TDate;
    PrevRec: UInt16;
    Spare1: array[0..9] of byte;
    // 72 bytes
   end;

Type
  TAcosKey = array [0 .. KEYLEN - 1] of Byte;

  TAcosConfig = class
  strict private
    KeySeed: array[TKEY_RECID] of int64;
    function key_key: UINT32; inline;
    function getkey(ID: TKEY_RECID):TAcosKey;
  public const
    NFiles = 3;
  private
  protected
    Domain,User: string;
  public
    FileSpec: Array [0 .. NFiles] of TFileSpec;
    Constructor Create;
    function Kt: TKey128;
    function Kc: TKey128;
    property AcosKey[ID: TKEY_RECID]: TAcosKey read getkey;
    function GetIssuerInfo: TUserIdentity;
  end;

var
  SCSConfig: TAcosConfig;

implementation
uses
  System.AnsiStrings;

{ TAcosConfig }

{$RANGECHECKS OFF}
{$WARNINGS OFF}
constructor TAcosConfig.Create;
begin
//  GetDomainAndUserName(Domain, User);

// KEY DEFINITIONS
//  - AC3,AC4,AC5, PIN not used
//  - Issuer Card only in cardmaster

  KeySeed[KEYREC_AC1]   := $6CBFE219F124D282;
  KeySeed[KEYREC_AC2]   := $8680B7890B76BDB2;
  KeySeed[KEYREC_AC3]   := $F6B05DF771A5B5D8;
  KeySeed[KEYREC_AC4]   := $121004AF423AD770;
  KeySeed[KEYREC_AC5]   := $D4275C6FD3EE8E30;
  {$IFDEF CARDMASTER}
  KeySeed[KEYREC_PIN]   := $57451023F1CBE0B4;
  KeySeed[KEYREC_IC]    := $1C1EF42FA40384F0;
  {$ENDIF}
  KeySeed[KEYREC_KC_LO] := $9ECEFB43CDB9F854;
  KeySeed[KEYREC_KC_HI] := $DA9B099F82FDB020;
  KeySeed[KEYREC_KT_LO] := $0AA9031733A56F78;
  KeySeed[KEYREC_KT_HI] := $29D0D83B2273292C;

{$WARNINGS ON}

// FILE DEFINITIONS
// current read/write capability requires data length that is a multiple of 8
// ergo, the file record length should also be a multiple of 8
// actual record lengths exceed the length of the Delphi record definitions
  with FileSpec[0] do
  begin
    ID            := FILE_IDENTITY; // INFO FILE
    RecLen        := sizeof(TIdentityRec);
    NRec          := 1;
    ReadSecurity  := $00; // Public
    WriteSecurity := $80; // Issuer Code
    AccessFlags   := $00; // record-file, no secure messaging
  end;
  with FileSpec[1] do
  begin
    ID            := FILE_CONTROL; // Control FILE
    RecLen        := sizeof(TControlRec);
    NRec          := 1;
    ReadSecurity  := $00; // Public
    WriteSecurity := $02; // AC1
    AccessFlags   := SM_READWRITE; // record-file, secure messaging
  end;
  with FileSpec[2] do
  begin
    ID            := $0A02; // Data FILE
    RecLen        := sizeof(TSCSDataRec);
    NRec          := 100;
    ReadSecurity  := $04; // AC2
    WriteSecurity := $04; // AC2
    AccessFlags   := SM_READWRITE; // record-file, secure messaging
  end;
end;

function TAcosConfig.Kt: TKey128;
var
  k: array [0 .. 1] of TAcosKey absolute result;
begin
  k[0] := AcosKey[KEYREC_KT_LO];
  k[1] := AcosKey[KEYREC_KT_HI];
end;

function TAcosConfig.Kc: TKey128;
var
  k: array [0 .. 1] of TAcosKey absolute result;
begin
  k[0] := AcosKey[KEYREC_KC_LO];
  k[1] := AcosKey[KEYREC_KC_HI];
end;

function TAcosConfig.getkey(ID: TKEY_RECID): TAcosKey;
var W: array[0..1] of UInt32 absolute result;
begin
// in order to hinder hacking, only the key-seed appears in the code and dynamic memory.
// the actual key is created here and will only appear momentarily on the stack
  int64(result) := KeySeed[ID];
  W[1] := W[1] XOR key_key
end;

function TAcosConfig.key_key: UINT32;
begin
  result := $9EF42FA3;
end;

function TAcosConfig.GetIssuerInfo: TUserIdentity;  //deprecated('cache domain & user');
var
  AString: ansiString;
begin
  fillchar(result, sizeof(result),0);
  AString:= rawbyteString(User);
  System.AnsiStrings.StrPLCopy(@result.User, AString, sizeof(result.User));
  AString:= rawbyteString(Domain);
  System.AnsiStrings.StrPLCopy(@result.Domain, AString, sizeof(result.Domain));
  result.TimeStamp := DateTimeToTimeStamp(Now);
end;



(* development-only methods to create some keys

function randomKey: string;
var
  N: integer;
begin
  N      := Random(MAXINT);
  result := IntToHex(N, 8);
  N      := Random(MAXINT);
  result := '$' + result + IntToHex(N, 8);
end;

procedure MakeRandomKeyFile;
var
  keys: tStringlist;
  i: integer;
begin
  randomize;
  keys := tStringlist.Create;
  try
    for i := 0 to 99 do
      keys.add(format('%d %s', [i, randomKey]));
    keys.saveToFile('KEYGEN.TXT');
  finally
    keys.Free;
  end;
end;
*)
initialization

// MakeRandomKeyFile;
SCSConfig := TAcosConfig.Create;

end.
