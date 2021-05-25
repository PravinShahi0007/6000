{*******************************************************************************
* Unit      : TDES                                                             *
********************************************************************************
* Purpose   : Encapulates the DES cipher cipher with various cipher modes      *
********************************************************************************
* Copyright : This component is copyright TSM Inc. 1999                        *
*             This source code may not be distributed to third parties in      *
*             or in part without the written permission of TSM Inc.            *
*             All rights reserved. Liability limited to replacement of         *
*             this original source code in the case of loss or damage because  *
*             the use or misuse of this software.                              *
********************************************************************************
* Version   : 25.02.98  - 1.0   Original component                             *
*             08.03.98  - 1.01  Additional cipher modes added                  *
*             08.04.98  - 1.02  Fix OFB mode                                   *
*             20.07.98  - 1.03  Added base64 encoding to en/decrypt string     *
*             13.08.98  - 1.03a Changed GetVersion to deliver reg info         *
*             15.08.98  - 1.10  Delphi4 / CBC MAC support added                *
*             05.10.98  - 1.11  Added Stream functionality                     *
*             22.01.99  - 1.14  Error in En- & Decrypt file/ stream resolved   *
*             26.03.99  - 1.14a Init error in "InitialiseString" fixed         *
********************************************************************************
* Switches  : REGISTERED - Compiles in the registered mode (without nag msg.)  *
*             COMPONENT  - Compiles as a VCL component (otherwise unit)        *
*             COMMANDLINE- Allows override of mode from command line compiler  *
*******************************************************************************}

{$R-} {$A-} {$Q-}
{$ifdef VER125}
     // fix for CB4
     {$define VER120}
{$endif}
{$ifdef VER130}
     // fix for Delphi5
     {$define VER120}
{$endif}

{$ifndef COMMANDLINE}        // Commanline overrides the follwing presets
     {$define NOTREGISTERED} //(NOTREGISTERED, FREEWARE, REGISTERED)
     {$define COMPONENT}     //(COMPONENT, OBJECT)
{$endif}

  {**************************************************************************
  ************ This section of code implements the 64 bit limit *************
  ************ imposed by the Wassennar agreement. The key is   *************
  ************ limited to 64 bits. Should you be in a country   *************
  ************ where the Wassennar agreement is not in force,   *************
  ************ undefine the WASSENAAR_LIMITED variable.         *************
  **************************************************************************}
{$define UNLIMITED}          // WASSENAAR_LIMITED, UNLIMITED

unit des;

interface

uses
     Classes, SysUtils;

const
     {general constants}
     BLOCKSIZE       = 8;    // DES has an 8 byte block
     BUFFERSIZE      = 4096; // the buffer for file encryption



{*******************************************************************************
* Type      : LongWord (only for D2/D3/CB3)                                    *
********************************************************************************
* Purpose   : Defines the Longword type. This is native for D4,D5,CB4          *
*******************************************************************************}
{$ifndef VER120}
type LongWord = Integer;
{$endif}

{*******************************************************************************
* Type      : PInteger                                                         *
********************************************************************************
* Purpose   : Defines the pointer to the LongWordType                          *
*******************************************************************************}
type PInteger  = ^LongWord;

{*******************************************************************************
* Type      : TIntArray                                                        *
********************************************************************************
* Purpose   : Defines an array large enough for all purposes                   *
*******************************************************************************}
type TIntArray = array[0..1023] of LongWord;

{*******************************************************************************
* Type      : PIntArray                                                        *
********************************************************************************
* Purpose   : Defines the pointer to the IntArray type                         *
*******************************************************************************}
type PIntArray = ^TIntArray;

{*******************************************************************************
* Type      : EKeyError                                                        *
********************************************************************************
* Purpose   : Exception raised when key setup incomplete for a given mode      *
*******************************************************************************}
type EKeyError = class(Exception);

{*******************************************************************************
* Type      : EFileError                                                       *
********************************************************************************
* Purpose   : Exception raised when file manipulation creates an error         *
*******************************************************************************}
type EFileError = class(Exception);

{*******************************************************************************
* Type      : EInputError                                                      *
********************************************************************************
* Purpose   : Exception raised when the input string for decryptstring suspect *
*******************************************************************************}
type EInputError = class(Exception);

{*******************************************************************************
* Type      : TBlock                                                           *
********************************************************************************
* Purpose   : Defines the basic element of enc/decryption                      *
*******************************************************************************}
type TBlock = array[0..(BLOCKSIZE - 1)] of Byte;

{*******************************************************************************
* Type      : PBlock                                                           *
********************************************************************************
* Purpose   : Pointer to the type TBlock                                       *
*******************************************************************************}
type PBlock  = ^TBlock;

{*******************************************************************************
* Type      : TDES_ctx                                                         *
********************************************************************************
* Purpose   : Defines context variable for TDES                                *
*******************************************************************************}
type Tdes_ctx = record
     KeyInit:         Boolean;  // Shows if the password has been initialised
     IVInit:          Boolean;  // Shows if the IV has been initialised
     IV:              TBlock;
     ct:              TBlock;

     FEncKey:         array [0..31] of LongWord;
     FDecKey:         array [0..31] of LongWord;

     case Integer of
          0: (ByteBuffer: TBlock);
          1: (LongBuffer: array[0..1] of LongInt);
end; {Tdes_ctx}

{*******************************************************************************
* Type      : TCiphermode                                                      *
********************************************************************************
* Purpose   : Defines possible modes for TDES                                  *
*******************************************************************************}
type TCipherMode = (CBC, ECB, CFB, OFB);

{*******************************************************************************
* Type      : TStringMode                                                      *
********************************************************************************
* Purpose   : Defines possible string modes for the En/Decrypt string          *
*******************************************************************************}
type TStringMode = (smEncode, smNormal);

{*******************************************************************************
* Type      : TDES                                                             *
********************************************************************************
* Purpose   : Defines TDES                                                     *
*******************************************************************************}
{$ifdef COMPONENT}
type TDES = class(TComponent)
{$else}
type TDES = class(TObject)
{$endif}
  private
     ctx:           Tdes_ctx;

     // buffer for larger encryptions
     FBuffer:      array[0..BUFFERSIZE+BLOCKSIZE] of BYTE; {Local Copy of Data}
     PtrBuffer:    PBlock;
     FCipherMode:  TCipherMode;
     FStringMode:  TStringMode;

     // these routines link to the core block routines of the algorithm
     procedure     DES_Core_Key_Setup(const KeyToSet: TBlock);
     procedure     DES_Core_Block_Encrypt;
     procedure     DES_Core_Block_Decrypt;
     procedure     DES_core_make_key(const Data: array of Byte; Key: PInteger; Reverse: Boolean);

     // Internal encryption primitives
     procedure     EncryptBuffer(const Len: integer);
     procedure     DecryptBuffer(const Len: integer);
     procedure     EncryptBlockMode;
     procedure     DecryptBlockMode;

     // Base64 functions
     function      EncodeString(InputString: ansistring): ansistring;
     function      DecodeString(InputString: ansistring): ansistring;

     // Implemnetation primitives
     procedure     CheckKeys;
  public
     // these calls are used to load the key and the IV
     procedure     InitialiseString(const Key: ansistring);
     procedure     InitialiseByte(const Key: array of byte; Keylength: integer);
     procedure     LoadIVString(const IVString: ansistring);
     procedure     LoadIVByte(const IVByte: array of Byte; IVLength: integer);

     // These calls perform the operation using the mode specified in CipherMode
     procedure     EncBlock(const Input: TBlock; var Output: TBlock);
     procedure     DecBlock(const Input: TBlock; var Output: TBlock);
     procedure     EncFile(const InputFileName: string; OutputFileName: string);
     procedure     DecFile(const InputFileName: string; OutputFileName: string);
     procedure     EncStream(const Input: TStream; const Output: TStream);
     procedure     DecStream(const Input: TStream; const Output: TStream);
     procedure     EncString(const Input: ansistring; var Output: ansistring);
     procedure     DecString(const Input: ansistring; var Output: ansistring);

     // this returns the CBC-MAC of the data put through DES
     procedure     CBCMACBlock(var MAC:TBlock);
     procedure     CBCMACString(var MAC: ansistring);

     // Burn clears any sensitive information
     procedure     Burn;

     // returns the version of the component
     function      GetVersion: ansistring;

  {$ifdef COMPONENT}
  published
     property      CipherMode:   TCipherMode read FCipherMode write FCipherMode;
     property      StringMode:   TStringMode read FStringMode write FStringMode;
  {$else}
     procedure     SetCipherMode(const Value: TCipherMode);
     function      GetCipherMode: TCipherMode;
     procedure     SetStringMode(const Value: TStringMode);
     function      GetStringMode: TStringMode;
  {$endif}
end;

{$ifdef COMPONENT}
procedure Register;
{$endif}

implementation

uses Windows, Dialogs;

const
     // new implementation
{this is set to SwapInt for <= 386 and BSwapInt >= 486 CPU, don't modify}
  SwapInteger       : function(Value: LongWord): LongWord  = nil;


     RELVER = '1.15';        // Version number
     LIT_COMPNAME            = 'DES';
     LIT_KEY_NOT_SET         = LIT_COMPNAME + ': Key not set';
     LIT_IV_NOT_SET          = LIT_COMPNAME + ': IV not set';
     LIT_KEY_LENGTH          = LIT_COMPNAME + ': Key must be between 1 and 8 bytes';
     LIT_INFILE_NOT_FOUND    = LIT_COMPNAME + ': Input file not found';
     LIT_CBC_NOT_SET         = LIT_COMPNAME + ': Mode must be CBC for CBCMAC';
     LIT_OUTFILE_OPEN_ERROR  = LIT_COMPNAME + ': Could not open output file';
     LIT_OUTFILE_WRITE_ERROR = LIT_COMPNAME + ': Error writing output file';
     LIT_INPUT_LENGTH        = LIT_COMPNAME + ': Input not valid - too short';
     LIT_BASE64CNV           = LIT_COMPNAME + ': Error converting from Base64 - invalid character';

     DES_Data: array[0..7, 0..63] of LongWord = (
    ($00200000,$04200002,$04000802,$00000000,$00000800,$04000802,$00200802,$04200800,
     $04200802,$00200000,$00000000,$04000002,$00000002,$04000000,$04200002,$00000802,
     $04000800,$00200802,$00200002,$04000800,$04000002,$04200000,$04200800,$00200002,
     $04200000,$00000800,$00000802,$04200802,$00200800,$00000002,$04000000,$00200800,
     $04000000,$00200800,$00200000,$04000802,$04000802,$04200002,$04200002,$00000002,
     $00200002,$04000000,$04000800,$00200000,$04200800,$00000802,$00200802,$04200800,
     $00000802,$04000002,$04200802,$04200000,$00200800,$00000000,$00000002,$04200802,
     $00000000,$00200802,$04200000,$00000800,$04000002,$04000800,$00000800,$00200002),
    ($00000100,$02080100,$02080000,$42000100,$00080000,$00000100,$40000000,$02080000,
     $40080100,$00080000,$02000100,$40080100,$42000100,$42080000,$00080100,$40000000,
     $02000000,$40080000,$40080000,$00000000,$40000100,$42080100,$42080100,$02000100,
     $42080000,$40000100,$00000000,$42000000,$02080100,$02000000,$42000000,$00080100,
     $00080000,$42000100,$00000100,$02000000,$40000000,$02080000,$42000100,$40080100,
     $02000100,$40000000,$42080000,$02080100,$40080100,$00000100,$02000000,$42080000,
     $42080100,$00080100,$42000000,$42080100,$02080000,$00000000,$40080000,$42000000,
     $00080100,$02000100,$40000100,$00080000,$00000000,$40080000,$02080100,$40000100),
    ($00000208,$08020200,$00000000,$08020008,$08000200,$00000000,$00020208,$08000200,
     $00020008,$08000008,$08000008,$00020000,$08020208,$00020008,$08020000,$00000208,
     $08000000,$00000008,$08020200,$00000200,$00020200,$08020000,$08020008,$00020208,
     $08000208,$00020200,$00020000,$08000208,$00000008,$08020208,$00000200,$08000000,
     $08020200,$08000000,$00020008,$00000208,$00020000,$08020200,$08000200,$00000000,
     $00000200,$00020008,$08020208,$08000200,$08000008,$00000200,$00000000,$08020008,
     $08000208,$00020000,$08000000,$08020208,$00000008,$00020208,$00020200,$08000008,
     $08020000,$08000208,$00000208,$08020000,$00020208,$00000008,$08020008,$00020200),
    ($01010400,$00000000,$00010000,$01010404,$01010004,$00010404,$00000004,$00010000,
     $00000400,$01010400,$01010404,$00000400,$01000404,$01010004,$01000000,$00000004,
     $00000404,$01000400,$01000400,$00010400,$00010400,$01010000,$01010000,$01000404,
     $00010004,$01000004,$01000004,$00010004,$00000000,$00000404,$00010404,$01000000,
     $00010000,$01010404,$00000004,$01010000,$01010400,$01000000,$01000000,$00000400,
     $01010004,$00010000,$00010400,$01000004,$00000400,$00000004,$01000404,$00010404,
     $01010404,$00010004,$01010000,$01000404,$01000004,$00000404,$00010404,$01010400,
     $00000404,$01000400,$01000400,$00000000,$00010004,$00010400,$00000000,$01010004),
    ($10001040,$00001000,$00040000,$10041040,$10000000,$10001040,$00000040,$10000000,
     $00040040,$10040000,$10041040,$00041000,$10041000,$00041040,$00001000,$00000040,
     $10040000,$10000040,$10001000,$00001040,$00041000,$00040040,$10040040,$10041000,
     $00001040,$00000000,$00000000,$10040040,$10000040,$10001000,$00041040,$00040000,
     $00041040,$00040000,$10041000,$00001000,$00000040,$10040040,$00001000,$00041040,
     $10001000,$00000040,$10000040,$10040000,$10040040,$10000000,$00040000,$10001040,
     $00000000,$10041040,$00040040,$10000040,$10040000,$10001000,$10001040,$00000000,
     $10041040,$00041000,$00041000,$00001040,$00001040,$00040040,$10000000,$10041000),
    ($20000010,$20400000,$00004000,$20404010,$20400000,$00000010,$20404010,$00400000,
     $20004000,$00404010,$00400000,$20000010,$00400010,$20004000,$20000000,$00004010,
     $00000000,$00400010,$20004010,$00004000,$00404000,$20004010,$00000010,$20400010,
     $20400010,$00000000,$00404010,$20404000,$00004010,$00404000,$20404000,$20000000,
     $20004000,$00000010,$20400010,$00404000,$20404010,$00400000,$00004010,$20000010,
     $00400000,$20004000,$20000000,$00004010,$20000010,$20404010,$00404000,$20400000,
     $00404010,$20404000,$00000000,$20400010,$00000010,$00004000,$20400000,$00404010,
     $00004000,$00400010,$20004010,$00000000,$20404000,$20000000,$00400010,$20004010),
    ($00802001,$00002081,$00002081,$00000080,$00802080,$00800081,$00800001,$00002001,
     $00000000,$00802000,$00802000,$00802081,$00000081,$00000000,$00800080,$00800001,
     $00000001,$00002000,$00800000,$00802001,$00000080,$00800000,$00002001,$00002080,
     $00800081,$00000001,$00002080,$00800080,$00002000,$00802080,$00802081,$00000081,
     $00800080,$00800001,$00802000,$00802081,$00000081,$00000000,$00000000,$00802000,
     $00002080,$00800080,$00800081,$00000001,$00802001,$00002081,$00002081,$00000080,
     $00802081,$00000081,$00000001,$00002000,$00800001,$00002001,$00802080,$00800081,
     $00002001,$00002080,$00800000,$00802001,$00000080,$00800000,$00002000,$00802080),
    ($80108020,$80008000,$00008000,$00108020,$00100000,$00000020,$80100020,$80008020,
     $80000020,$80108020,$80108000,$80000000,$80008000,$00100000,$00000020,$80100020,
     $00108000,$00100020,$80008020,$00000000,$80000000,$00008000,$00108020,$80100000,
     $00100020,$80000020,$00000000,$00108000,$00008020,$80108000,$80100000,$00008020,
     $00000000,$00108020,$80100020,$00100000,$80008020,$80100000,$80108000,$00008000,
     $80100000,$80008000,$00000020,$80108020,$00108020,$00000020,$00008000,$80000000,
     $00008020,$80108000,$00100000,$80000020,$00100020,$80008020,$80000020,$00100020,
     $00108000,$00000000,$80008000,$00008020,$80000000,$80100020,$80108020,$00108000));

     DES_PC1: array[0..55] of Byte =
    (56, 48, 40, 32, 24, 16,  8,  0, 57, 49, 41, 33, 25, 17,
      9,  1, 58, 50, 42, 34, 26,	18, 10,  2, 59, 51, 43, 35,
     62, 54, 46, 38, 30, 22, 14,	 6, 61, 53, 45, 37, 29, 21,
     13,  5, 60, 52, 44, 36, 28,	20, 12,  4, 27, 19, 11,  3);

     DES_PC2: array[0..47] of Byte =
    (13, 16, 10, 23,  0,  4,  2, 27, 14,  5, 20,  9,
     22, 18, 11,  3, 25,  7, 15,  6, 26, 19, 12,  1,
     40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47,
     43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 28, 31);


{*******************************************************************************
* Table     : BinToAsc                                                         *
********************************************************************************
* Purpose   : The encode table used by Base64 encoding                         *
*******************************************************************************}
     BinToAsc : Array [0..63] of ansiChar =
          ('+', '-','0','1','2','3','4','5','6','7',
           '8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',
           'P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d',
           'e','f','g','h','i','j','k','l','m','n','o','p','q','r','s',
           't','u','v','w','x','y','z');

{$ifdef COMPONENT}
{*******************************************************************************
* Procedure : Register                                                         *
********************************************************************************
* Purpose   : Declares the component to the Delhpi IDE (in component mode only)*
********************************************************************************
* Paramters : 'Crypto' : the name of the Tab under which the component should  *
*             appear                                                           *
*             'TDES' The name of the component in the tab. Must match the      *
*             declared type name                                               *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure Register;
begin
     RegisterComponents('Crypto', [TDES]);
end; {Register}
{$endif}

{*******************************************************************************
* Procedure : EncodeString                                                     *
********************************************************************************
* Purpose   : Encodes the binary string into a base64 representation to avoid  *
*             problems with nulls in the encoded string                        *
********************************************************************************
* Paramters : Input - the string to be encoded                                 *
********************************************************************************
* Returns   : the encoded string                                               *
*******************************************************************************}
function TDES.EncodeString(InputString: ansistring): ansistring;
var
     Counter:      integer;
     ReturnString: ansistring;
     b:            Byte;
     i:            integer;
     last:         byte;
     Flush:        Boolean;
     LengthInput:  integer;
begin
     Counter := 0;
     ReturnString := '';
     Flush := False;
     last := 0;

     // deal with flushing the partial byte at the end of the string
     if (Length(InputString) mod 3) <> 0 then
     begin
          InputString := InputString + ansiChar(0);
          // flush controls the last byte mod 3
          Flush := True;
     end; {if}

     LengthInput := Length(InputString);
     i := 1;
     while (i <= LengthInput) do
     begin
          if i <= LengthInput then
          begin
               b := Ord(InputString[i]);
          end
          else
          begin
               b := 0;
          end; {if}

          case Counter of
          0:
               begin
                    ReturnString := ReturnString + BinToAsc[(b shr 2)];
                    last := b;
               end;
          1:
               begin
                    ReturnString := ReturnString + BinToAsc[((last and $3) shl 4) or ((b and $F0) shr 4) ];
                    last := b;
               end;
          2:
               begin
                    ReturnString := ReturnString + BinToAsc[((last and $F) shl 2) or ((b and $C0) shr 6)];
                    if not (Flush and (i = LengthInput)) then
                    begin
                         ReturnString := ReturnString + BinToAsc[(b and $3F)];
                    end;
                    last := 0;
               end;
          end; {case}

          Inc(Counter);
          if Counter = 3 then
          begin
               Counter := 0;
          end;

          Inc(i);
     end; {while}

     Result := ReturnString;
end; {EncodeString}

{*******************************************************************************
* Procedure : DecodeString                                                     *
********************************************************************************
* Purpose   : Decodes the binary string into a base64 representation to avoid  *
*             problems with nulls in the encoded string                        *
********************************************************************************
* Paramters : Input - the string to be decoded                                 *
********************************************************************************
* Returns   : the decoded string                                               *
*******************************************************************************}
function TDES.DecodeString(InputString: ansistring): ansistring;
     function  DecodeBase64(b: byte): byte;
     {*******************************************************************************
     * Procedure : DecodeBase64                                                     *
     ********************************************************************************
     * Purpose   : Decodes a byte from the Base64 string                            *
     ********************************************************************************
     * Paramters : b - the byte to be decoded                                       *
     ********************************************************************************
     * Returns   : the decoded byte                                                 *
     *******************************************************************************}
     begin
          if (b >= Ord('0')) and (b <= Ord('9')) then
          begin
               Result := b - Ord('0') + 2;
               Exit;
          end;
          if (b >= Ord('A')) and (b <= Ord('Z')) then
          begin
               Result := b - Ord('A') + 12;
               Exit;
          end;
          if (b >= Ord('a')) and (b <= Ord('z')) then
          begin
               Result := b - Ord('a') + 38;
               Exit;
          end;
          if b = Ord('+') then
          begin
               Result := 0;
               Exit;
          end;
          if b = Ord('-') then
          begin
               Result := 1;
               Exit;
          end;

          // Default result if the char is not recognised
          raise EConvertError.Create(LIT_BASE64CNV);
     end; {DecodeBase64}
var
     Counter:      integer;
     ReturnString: ansistring;
     c:            ansiChar;
     last:         byte;
     this:         byte;
     i:            integer;
begin
     Counter := 0;
     ReturnString := '';
     last := 0;

     for i := 1 to Length(InputString) do
     begin
          c := InputString[i];
          case Counter of
          0:
               begin
                    last := DecodeBase64(Ord(c)) shl 2;
               end;
          1:
               begin
                    this := DecodeBase64(Ord(c));
                    ReturnString := ReturnString + ansiChar((last or (this shr 4)) and $ff);
                    last := this shl 4;
               end;
          2:
               begin
                    this := DecodeBase64(Ord(c));
                    ReturnString := ReturnString + ansiChar((last or (this shr 2)) and $ff);
                    last := this shl 6;
               end;
          3:
               begin
                    this := DecodeBase64(Ord(c));
                    ReturnString := ReturnString + ansiChar((last or this) and $ff);
                    last := 0;
               end;
          end; {case}

          Inc(Counter);
          if Counter = 4 then
          begin
               Counter := 0;
          end; {if}
     end; {for}

     Result := ReturnString;
end; {DecodeString}

{*******************************************************************************
* Procedure : GetVersion                                                       *
********************************************************************************
* Purpose   : Returns the internal version number of the component             *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : String - the version number expressed as a string                *
*******************************************************************************}
function TDES.GetVersion;
begin
     // return the version string
     Result := LIT_COMPNAME + ' ' + RELVER;

     {$ifdef REGISTERED}
     Result := Result + ' Registered';
     {$endif}
     {$ifdef NOTREGISTERED}
     Result := Result + ' Unregistered';
     {$endif}
     {$ifdef FREEWARE}
     Result := Result + ' Freeware';
     {$endif}
end; {GetVersion}

{$ifndef COMPONENT}
{*******************************************************************************
* Procedure : SetCipherMode                                                    *
********************************************************************************
* Purpose   : Sets the ciphermode when defined as an object                    *
********************************************************************************
* Paramters : 'Value' : The new cipher mode to be set                          *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TDES.SetCipherMode(const Value: TCipherMode);
begin
     FCipherMode := Value;
end; {SetCipherMode}
{$endif}

{*******************************************************************************
* Procedure : InitialiseString                                                 *
********************************************************************************
* Purpose   : Loads the passphrase into the context block                      *
********************************************************************************
* Paramters : 'Key' - the string which holds the key                           *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TDES.InitialiseString(const Key: ansistring);
var
     KeyArray: TBlock;
     i: integer;
begin
     // clear the context
     FillChar(ctx.ct, Sizeof(ctx.ct), #0);
     FillChar(ctx.ByteBuffer, Sizeof(ctx.ByteBuffer), #0);
     FillChar(KeyArray, Sizeof(KeyArray), #0);

     {**************************************************************************
     ************ This section of code implements the 64 bit limit *************
     ************ imposed by the Wassennar agreement. The key is   *************
     ************ limited to 64 bits. Should you be in a country   *************
     ************ where the Wassennar agreement is not in force,   *************
     ************ undefine the WASSENAAR_LIMITED variable.         *************
     **************************************************************************}

     {$ifdef WASSENAAR_LIMITED}
     // turn the key string into a key array
     for i := 1 to Length(Key) do
     begin
          KeyArray[(i-1) mod 8] := Ord(Key[i]);
     end; {for}
     {$else}
     // turn the key string into a key array
     for i := 1 to Length(Key) do
     begin
          KeyArray[(i-1) mod 8] := Ord(Key[i]);
     end; {for}
     {$endif}
     // and perform the initialisation with the concatenated string
     DES_Core_Key_Setup(KeyArray);

     // mark the context as initialised
     ctx.KeyInit := True;
end; {InitialiseString}

{*******************************************************************************
* Procedure : InitialiseByte                                                   *
********************************************************************************
* Purpose   : Loads the passphrase into the context block                      *
********************************************************************************
* Paramters : 'Key' - array of bytes which holds the key                       *
*             'KeyLength' - the number of bytes in the array which are to be   *
*             read to load the key - need not be the same as the length of the *
*             array                                                            *
********************************************************************************
* Returns   : 'OK' if the operation was a success, otherwise an error code     *
*******************************************************************************}
procedure TDES.InitialiseByte(const Key: array of Byte; KeyLength: integer);
var
     KeyArray: TBlock;
     i: integer;
begin
     // clear the context
     FillChar(ctx.ct, Sizeof(ctx.ct), #0);
     FillChar(ctx.ByteBuffer, Sizeof(ctx.ByteBuffer), #0);
     FillChar(KeyArray, Sizeof(KeyArray), #0);

     {**************************************************************************
     ************ This section of code implements the 64 bit limit *************
     ************ imposed by the Wassennar agreement. The key is   *************
     ************ limited to 64 bits. Should you be in a country   *************
     ************ where the Wassennar agreement is not in force,   *************
     ************ undefine the WASSENAAR_LIMITED variable.         *************
     **************************************************************************}

     {$ifdef WASSENAAR_LIMITED}
     // buffer the passed key into the key array to make sure that
     // it is padded with something defined (just in case)
     for i := 0 to KeyLength-1 do
     begin
          KeyArray[i mod 8] := Key[i];
     end; {for}
     {$else}
     // buffer the passed key into the key array to make sure that
     // it is padded with something defined (just in case)
     for i := 0 to KeyLength-1 do
     begin
          KeyArray[i mod 8] := Key[i];
     end; {for}
     {$endif}

     // and perform the initialisation with the concatenated string
     DES_Core_Key_Setup(KeyArray);

     // mark the context as initialised
     ctx.KeyInit := True;
end; {InitialiseByte}

{*******************************************************************************
* Procedure : LoadIVString                                                     *
********************************************************************************
* Purpose   : Loads the Initialisation Vector                                  *
*             Note: this is only necessary for modes other than ECB            *
********************************************************************************
* Paramters : 'IVString' - the string which holds the IV to be set             *
********************************************************************************
* Returns   : None - (Null IVs are also valid)                                 *
*******************************************************************************}
procedure TDES.LoadIVString(Const IVString: ansistring);
var
     i: integer;
begin
     // clear the IV in the context
     FillChar(ctx.IV, BLOCKSIZE, #0);

     // wrap the IV string into the 16 bytes of the IV block using xor
     for i := 1 to Length(IVString) do
     begin
          ctx.IV[(i-1) and (BLOCKSIZE - 1)] := ctx.IV[(i-1) and (BLOCKSIZE - 1)] xor Ord(IVString[i]);
     end; {for i}

     // mark the IV as being initialised
     ctx.IVInit := True;
end; {LoadIVString}

{*******************************************************************************
* Procedure : LoadIVByte                                                       *
********************************************************************************
* Purpose   : Loads the Initialisation Vector                                  *
*             Note: this is only necessary for modes other than ECB            *
********************************************************************************
* Paramters : 'IVByte' - the array of bytes which holds the IV to be set       *
********************************************************************************
* Returns   : None - (Null IVs are also valid)                                 *
*******************************************************************************}
procedure TDES.LoadIVByte(const IVByte: array of Byte; IVLength: integer);
var
     i: integer;
begin
     // clear the IV in the context
     FillChar(ctx.ByteBuffer, BLOCKSIZE, #0);

     // wrap the IV string into the 8 bytes of the IV block using xor
     for i := 1 to IVLength do
     begin
          ctx.ByteBuffer[(i-1) and (BLOCKSIZE - 1)] := ctx.ByteBuffer[(i-1) and (BLOCKSIZE - 1)] xor IVByte[i];
     end; {for i}

     // mark the IV as being initialised
     ctx.IVInit := True;
end; {LoadIVByte}

{*******************************************************************************
* Procedure : EncryptBlock                                                     *
********************************************************************************
* Purpose   : Encrypts the contents of the block usint the key (and possibly   *
*             the IV) previously set.                                          *
********************************************************************************
* Paramters : 'Input'  the block to be encrypted                               *
*           : 'Output' the encrypted block                                     *
********************************************************************************
* Returns   : OK if successful, otherwise error code                           *
*******************************************************************************}
procedure TDES.EncBlock(const Input: TBlock; var Output: TBlock);
begin
     // check that we have a keys and IV
     CheckKeys;

     // copy the input to the context blockbuffer
     ctx.ByteBuffer := Input;

     // perform the encryption on the context
     EncryptBlockMode;

     // copy the context back to the blockbuffer
     Output := ctx.ByteBuffer;
end; {EncryptBlock}

{*******************************************************************************
* Procedure : DecryptBlock                                                     *
********************************************************************************
* Purpose   : Decrypts the contents of the block usint the key (and possibly   *
*             the IV) previously set.                                          *
********************************************************************************
* Paramters : 'Input'  the encrypted block to be decrypted                     *
*           : 'Output' the decrypted block                                     *
********************************************************************************
* Returns   : OK if successful, otherwise error code                           *
*******************************************************************************}
procedure TDES.DecBlock(const Input: TBlock; var Output: TBlock);
begin
     // check that we have a keys and IV
     CheckKeys;

     // copy the input to the context blockbuffer
     ctx.ByteBuffer := Input;

     // perform the decryption
     DecryptBlockMode;

     // copy the context back to the blockbuffer
     Output := ctx.ByteBuffer;
end; {DecryptBlock}

{*******************************************************************************
* Procedure : EncryptBuffer                                                    *
********************************************************************************
* Purpose   : Encrypts the contents of the buffer using the key (and possibly  *
*             the IV) previously set. Does not take care of any padding.       *
********************************************************************************
* Paramters : 'Len' the number of bytes in the buffer                          *
********************************************************************************
* Returns   : OK if successful, otherwise error code                           *
*******************************************************************************}
procedure TDES.EncryptBuffer(const Len: integer);
var
     Index: integer;
begin
     // check that we have a keys and IV
     CheckKeys;

     // index is the pointer to the current position in the buffer
     Index := 0;

     // PtrBuffer points to the address of the buffer
     PtrBuffer := @FBuffer;

     // for every block in the buffer
     repeat
          // move one block from the buffer contents into the context
          Move(FBuffer[Index], ctx.ByteBuffer, BLOCKSIZE);

          // encrypt the context
          EncryptBlockMode;

          // move the block back
          Move(ctx.ByteBuffer, PtrBuffer^[Index], BLOCKSIZE);

          // increment the pointer
          Inc(Index,BLOCKSIZE);
     until Index = Len;
end; {EncryptBuffer}

{*******************************************************************************
* Procedure : DecryptBuffer                                                    *
********************************************************************************
* Purpose   : Decrypts the contents of the buffer usint the key (and possibly  *
*             the IV) previously set.                                          *
********************************************************************************
* Paramters : 'Len' the number of bytes in the buffer                          *
********************************************************************************
* Returns   : OK if successful, otherwise error code                           *
*******************************************************************************}
procedure TDES.DecryptBuffer(const Len: integer);
var
     Index: integer;
begin
     // check that we have a keys and IV
     CheckKeys;

     // index is the pointer to the current position in the buffer
     Index := 0;

     // PtrBuffer points to the address of the buffer
     PtrBuffer := @FBuffer;

     // for every block in the buffer
     repeat
          // move one block from the buffer contents into the context
          Move(FBuffer[Index], ctx.ByteBuffer, BLOCKSIZE);

          // decrypt the context
          DecryptBlockMode;

          // move the block back
          Move(ctx.ByteBuffer, PtrBuffer^[Index], BLOCKSIZE);

          // increment the pointer
          Inc(Index,BLOCKSIZE);
     until Index = Len;
end; {DecryptBuffer}

{*******************************************************************************
* Procedure : EncryptFile                                                      *
********************************************************************************
* Purpose   : Encrypts InputFile to OutputFile using the Key (and possibly     *
*             the IV) previously set.                                          *
********************************************************************************
* Paramters : 'InputFileName' the plaintext file                               *
*             'OutputFileName' the ciphertext file                             *
********************************************************************************
* Returns   : OK if successful, otherwise error code                           *
*******************************************************************************}
procedure TDES.EncFile(const InputFileName: string; OutputFileName: string);
var
     InputFile, OutputFile: File;
     NumWrite, NumRead: integer;
     Pad: integer;
     Index: integer;
begin
     // check that we have a keys and IV
     CheckKeys;

     // open the input file
     try
          AssignFile(InputFile, InputFileName);
     except
          // we could not open the input file for some reason
          // so exit gracefully with an error code
          raise EFileError.Create(LIT_INFILE_NOT_FOUND);
          Exit;
     end;

     // reset the input file
     FileMode := 0;
     Reset(InputFile, 1);

     // open the output file
     try
          AssignFile(OutputFile, OutputFileName);
     except
          // we could not open the output file for some reason
          // so exit gracefully with an error code
          raise EFileError.Create(LIT_OUTFILE_OPEN_ERROR);
          Exit;
     end;

     // reset the output file for writing
     Rewrite(OutputFile, 1);

     // this is the main loop of EncryptFile. We read (for performance reasons) a block
     // at a time and encrypt the block. This minimises the accesses to the disk
     repeat
          // Read an input block
          BlockRead(InputFile,FBuffer,BUFFERSIZE, NumRead);

          //Pad the input to a multiple of 64bits(8BYTES) with Nulls at the end of the file
          if EOF(InputFile) then
          begin
               // pad the last block
               // if we have a zero padding, expand this to a full 8 byte block
               Pad := BLOCKSIZE - (NumRead mod BLOCKSIZE);
               Index := Pad;

               // add the pad bytes to the buffer
               while Index <> 0 do
               begin
                    FBuffer[NumRead] := Pad;
                    Inc(NumRead);
                    Dec(Index);
               end; {while Index}
          end; {if EOF}

          // encrypt the buffer
          EncryptBuffer(NumRead);

          // write the block to the output file
          BlockWrite(OutputFile, FBuffer, NumRead, NumWrite);

          // if NumRead <> NumWrite, it is probable that the disk is full
          if NumRead <> NumWrite then
          begin
               // there was an error writing the output file
               // exit with the error code
               raise EFileError.Create(LIT_OUTFILE_WRITE_ERROR);
               Exit;
          end; {if NumRead <> NumWrite}
     until EOF(InputFile) or (NumWrite <> NumRead); {repeat}

     // close the files
     CloseFile(InputFile);
     CloseFile(OutputFile);
end; {EncryptFile}

{*******************************************************************************
* Procedure : DecryptFile                                                      *
********************************************************************************
* Purpose   : Decrypts InputFile to OutputFile using the Key (and possibly     *
*             the IV) previously set.                                          *
********************************************************************************
* Paramters : 'InputFileName' the ciphertext file                              *
*             'OutputFileName' the plaintext file                              *
********************************************************************************
* Returns   : OK if successful, otherwise error code                           *
*******************************************************************************}
procedure TDES.DecFile(const InputFileName: string; OutputFileName: string);
var
     InputFile, OutputFile: File;
     NumWrite, NumRead: integer;
begin
     // check that we have a keys and IV
     CheckKeys;

     // open the input file
     try
          AssignFile(InputFile, InputFileName);
     except
          // we could not open the input file for some reason
          // so exit gracefully with an error code
          raise EFileError.Create(LIT_INFILE_NOT_FOUND);
          Exit;
     end;

     // reset the input file
     FileMode := 0;
     Reset(InputFile, 1);

     // open the output file
     try
          AssignFile(OutputFile, OutputFileName);
     except
          // we could not open the output file for some reason
          // so exit gracefully with an error code
          raise EFileError.Create(LIT_OUTFILE_OPEN_ERROR);
          Exit;
     end;

     // reset the output file
     Rewrite(OutputFile, 1);

     // this is the main loop of DecryptFile. We read (for performance reasons) a block
     // at a time and encrypt the block. This minimises the accesses to the disk
     repeat
          // Read an input block
          BlockRead(InputFile,FBuffer,BUFFERSIZE, NumRead);

          //Call DecryptBuffer to handle the actual decryption
          DecryptBuffer(NumRead);

          //Put in OutputFile, trimming out the final padding as necessary
          if EOF(InputFile) then
          begin
               // deal with the case that the file is a multiple of BUFFERLENGTH long
               NumRead := NumRead - FBuffer[NumRead-1];
          end;

          // write the block to the output file
          BlockWrite(OutputFile,FBuffer, NumRead, NumWrite);

          // if NumRead <> NumWrite, it is probable that the disk is full
          if NumRead <> NumWrite then
          begin
               // there was an error writing the output file
               // exit with the error code
               raise EFileError.Create(LIT_OUTFILE_WRITE_ERROR);
               Exit;
          end; {if NumRead <> NumWrite}
     until EOF(InputFile) or (NumWrite <> NumRead);

     // close the files
     CloseFile(InputFile);
     CloseFile(OutputFile);
end; {DecryptFile}

{*******************************************************************************
* Procedure : EncryptStream                                                    *
********************************************************************************
* Purpose   : Encrypts the contents of the stream using the key (and possibly  *
*             the IV) previously set. Takes care of padding the stream.         *
********************************************************************************
* Paramters : 'Input'  the stream to be encrypted                              *
*           : 'Output' the encrypted stream                                    *
********************************************************************************
* Returns   : OK if successful, otherwise error code                           *
*******************************************************************************}
procedure TDES.EncStream(const Input: TStream; const Output: TStream);
var
     i: integer;
     j: integer;
     k: integer;
     RemainingData: integer;
begin
     // Input.Size contains the length of the stream in bytes and in *not*
     // updated by reading the stream (i.e. it is not a pointer to the position
     // in the stream.
     RemainingData := Input.Size;

     // reset the stream positions
     Input.Seek(0, soFromBeginning);
     Output.Seek(0, soFromBeginning);

     // check for zero length strings
     if Input.Size = 0 then
     begin
          // don't need to do anything
          Exit;
     end;

     // deal with the whole BUFFERSIZE sections first
     // get the number of BUFFERSIZE sections to process, and process them
     i := RemainingData div BUFFERSIZE;
     while i > 0 do
     begin
          Input.Read(FBuffer, BUFFERSIZE);
          Dec(RemainingData, BUFFERSIZE);

          EncryptBuffer(BUFFERSIZE);

          Output.Write(FBuffer, BUFFERSIZE);
          Dec(i);
     end;

     // now deal with the final (incomplete) block of length BUFFERSIZE
     // this must be padded to ensure a sucessful decryption

     // read in the partial block
     Input.Read(FBuffer, RemainingData);

     // get the amount of padding and add it
     i := BLOCKSIZE - (RemainingData mod BLOCKSIZE);

     // and the position to write it to in the buffer
     j := RemainingData;

     // pad to a full block at the end of the input
     k := i;
     while k > 0 do
     begin
          FBuffer[j] := i;
          Dec(k);
          Inc(j);
     end; {while k}

     // encrypt the partial block
     EncryptBuffer(j);

     // write to the output stream
     Output.Write(FBuffer, j);
end; {EncryptStream}

{*******************************************************************************
* Procedure : DecryptStream                                                    *
********************************************************************************
* Purpose   : Decrypts the contents of the stream using the key (and possibly  *
*             the IV) previously set. Unpads the stream.                       *
********************************************************************************
* Paramters : 'Input'  the stream to be decrypted                              *
*           : 'Output' the decrypted stream                                    *
********************************************************************************
* Returns   : OK if successful, otherwise error code                           *
*******************************************************************************}
procedure TDES.DecStream(const Input: TStream; const Output: TStream);
var
     i: integer;
     RemainingData: integer;
begin
     // Input.Size contains the length of the stream in bytes and in *not*
     // updated by reading the stream (i.e. it is not a pointer to the position
     // in the stream.
     RemainingData := Input.Size;

     // reset the stream positions
     Input.Seek(0, soFromBeginning);
     Output.Seek(0, soFromBeginning);

     // check for zero length strings
     if Input.Size = 0 then
     begin
          // don't need to do anything
          Exit;
     end;

     // deal with the whole BUFFERSIZE sections first
     // get the number of BUFFERSIZE sections to process, and process them
     i := RemainingData div BUFFERSIZE;
     while i > 0 do
     begin
          Input.Read(FBuffer, BUFFERSIZE);
          Dec(RemainingData, BUFFERSIZE);

          DecryptBuffer(BUFFERSIZE);

          Output.Write(FBuffer, BUFFERSIZE);
          Dec(i);
     end;

     // now deal with the final (incomplete) block of length BUFFERSIZE
     // this must be padded to ensure a sucessful decryption

     // read in the partial block
     Input.Read(FBuffer, RemainingData);

     // decrypt the partial block
     DecryptBuffer(RemainingData);

     // get the length of the padding
     i := FBuffer[RemainingData-1];

     // write the data excluding the i bytes of padding
     Output.Write(FBuffer, RemainingData-i);
end; {DecryptStream}

{*******************************************************************************
* Procedure : EncryptString                                                    *
********************************************************************************
* Purpose   : Encrypts the contents of the string usint the key (and possibly  *
*             the IV) previously set.                                          *
********************************************************************************
* Paramters : 'Input'  the string to be encrypted                              *
*           : 'Output' the encrypted string                                    *
********************************************************************************
* Returns   : OK if successful, otherwise error code                           *
*******************************************************************************}
procedure TDES.EncString(const Input: ansistring; var Output: ansistring);
var
     i: longint;
     j: longint;
     s: ansistring;
begin
     // check that we have a keys and IV
     CheckKeys;

     // initialise the output string
     Output := '';

     // check for zero length strings
     if Length(Input) = 0 then
     begin
          // don't need to do anything
          Exit;
     end;

     // load the input into the buffer
     s := Input;

     // Pad the input string to a multiple of BLOCKSIZE bytes.
     j := Length(s) + 1;
     i := BLOCKSIZE - (Length(s) mod BLOCKSIZE);
     SetLength(s, Length(s)+i);
     SetLength(Output, Length(s));

     // add the pad bytes to the end of the string
     while j <= Length(s) do
     begin
          s[j] := ansiChar(i);
          inc(j);
     end; {while j}

     // initialise the counters
     j := 1;
     i := 1;

     // and step through the string
     while i < length(s) do
     begin
          // copy the next bytes into the context block buffer
          Move(s[i], ctx.ByteBuffer, BLOCKSIZE);
          Inc(i, BLOCKSIZE);

          // perform the encryption of the context
          EncryptBlockMode;

          // copy the block into the output string
          Move(ctx.ByteBuffer, Output[j], BLOCKSIZE);
          Inc(j, BLOCKSIZE);
     end; {while j}

     // encode the string if required
     if FStringMode = smEncode then
     begin
          Output := EncodeString(Output);
     end;
end; {EncryptString}

{*******************************************************************************
* Procedure : DecryptString                                                    *
********************************************************************************
* Purpose   : Decrypts the contents of the string usint the key (and possibly  *
*             the IV) previously set.                                          *
********************************************************************************
* Paramters : 'Input'  the encrypted string to be decrypted                    *
*           : 'Output' the decrypted string                                    *
********************************************************************************
* Returns   : OK if successful, otherwise error code                           *
*******************************************************************************}
procedure TDES.DecString(const Input: ansistring; var Output: ansistring);
var
     i: longint;
     j: longint;
     s: ansistring;
     InputTemp: ansistring;
begin
     // check that we have a keys and IV
     CheckKeys;

     // initialise the output string
     Output := '';

     // check for zero length strings
     if Length(Input) = 0 then
     begin
          // don't need to do anything
          Exit;
     end;

     // decode the string if required
     if FStringMode = smEncode then
     begin
          InputTemp := DecodeString(Input);
     end
     else
     begin
          InputTemp := Input;
     end;

     // check that the input is long enough
     if Length(InputTemp) < BLOCKSIZE then
     begin
          raise EInputError.Create(LIT_INPUT_LENGTH);
     end; {if Length}

     // initialise the working string
     s := '';

     // preset the length of the ´working string
     SetLength(s, Length(InputTemp));

     // initialise the counters
     i := 1;
     j := 1;

     // and step through the string
     while i < (Length(InputTemp)) do
     begin
          // copy the next bytes into the context block buffer
          Move(InputTemp[j], ctx.ByteBuffer, BLOCKSIZE);
          Inc(j, BLOCKSIZE);

          // perform the decryption of the context
          DecryptBlockMode;

          // copy the block into the output string
          Move(ctx.ByteBuffer, s[i], BLOCKSIZE);
          Inc(i, BLOCKSIZE);
     end; {while i}

     // Unpad Plain Text string
     // Last byte is number of pad bytes
     i := ord(s[Length(s)]);
     if (i > 0) and (i <= BLOCKSIZE) then
     begin
          Output := Copy(s, 1,Length(s) - i);
     end
     else
     begin
          Output := Copy(s, 1,Length(s) - 1);
     end; {if (i>0) and}
end; {DecryptString}

{*******************************************************************************
* Procedure : CBCMACBlock                                                      *
********************************************************************************
* Purpose   : Returns the MAC of the data which has passed through the cipher  *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : The MAC as a TBlock                                              *
*******************************************************************************}
procedure TDES.CBCMACBlock(var MAC: TBlock);
begin
     // pre initialise the MAC
     FillChar(MAC, Sizeof(MAC), #0);

     // check that the formalities are in order
     if FCipherMode <> CBC then
     begin
          // we can only reasonably produce a MAC in CBC mode
          raise EKeyError.Create(LIT_CBC_NOT_SET);
          Exit;
     end; {if}

     // check that we have the key and IV
     CheckKeys;

     MAC := ctx.IV;
end; {CBCMACBlock}

{*******************************************************************************
* Procedure : CBCMACstring                                                     *
********************************************************************************
* Purpose   : Returns the MAC of the data which has passed through the cipher  *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : The MAC as a string                                              *
*******************************************************************************}
procedure TDES.CBCMACString(var MAC: ansiString);
var
     MACTemp: TBlock;
     i: integer;
begin
     CBCMACBlock(MACTemp);

     MAC := '';

     for i := 0 to BLOCKSIZE-1 do
     begin
          MAC := MAC + IntToHex(MACTemp[i],2);
     end; {for}
end; {CBCMACString}


{*******************************************************************************
******************************** utility routines ******************************
*******************************************************************************}


{*******************************************************************************
* Procedure : Burn                                                             *
********************************************************************************
* Purpose   : Clears the context of any sensitive information                  *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TDES.Burn;
begin
     // reset the whole context
     FillChar(ctx, SizeOf(ctx), #0);
     // reset the boolean members
     ctx.KeyInit := False;
     ctx.IVInit := False;
end; {Burn}

{*******************************************************************************
* Procedure : EncryptBlockMode                                                 *
********************************************************************************
* Purpose   : Encrypts the contents of the context buffer, using the           *
*             currently selected encryption mode.                              *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TDES.EncryptBlockMode;
var
     i: integer;
begin
     // perform the operation using the current mode
     case FCipherMode of
     CBC:
          begin
               // xor the input block with the previous IV
               for i := 0 to BLOCKSIZE-1 do
               begin
                    ctx.ByteBuffer[i] := ctx.ByteBuffer[i] xor ctx.IV[i];
               end; {for i}

               // perform the encryption on the block
               DES_Core_Block_Encrypt;

               // copy the ciphertext to the IV
               Move (ctx.ByteBuffer, ctx.IV, BLOCKSIZE);
          end; {CBC}
     ECB:
          begin
               // ECB Mode has no preprocessing
               // perform the encryption on the block
               DES_Core_Block_Encrypt;
          end; {ECB}
     CFB:
          begin
               // Encipher the current IV to give the next IV
               Move (ctx.ByteBuffer, ctx.ct, BLOCKSIZE);
               Move (ctx.IV, ctx.ByteBuffer, BLOCKSIZE);

               // perform the encryption on the block
               DES_Core_Block_Encrypt;

               Move(ctx.ByteBuffer, ctx.IV, BLOCKSIZE);
               Move (ctx.ct, ctx.ByteBuffer, BLOCKSIZE);

               // and xor the plaintext with the IV to get the ciphertext
               for i := 0 to BLOCKSIZE-1 do
               begin
                    ctx.ByteBuffer[i] := ctx.ByteBuffer[i] xor ctx.IV[i];
               end; {for i}

               // feed the ciphertext back into the IV
               Move (ctx.ByteBuffer, ctx.IV, BLOCKSIZE);
          end; {CFB}
     OFB:
          begin
               // encrypt the previous IV to get the new IV
               Move (ctx.ByteBuffer, ctx.ct, BLOCKSIZE);
               Move (ctx.IV, ctx.ByteBuffer, BLOCKSIZE);

               // perform the encryption on the block
               DES_Core_Block_Encrypt;

               // move the IV back
               Move (ctx.ByteBuffer, ctx.IV, BLOCKSIZE);

               // the ciphertext is the plaintext xor IV
               for i := 0 to BLOCKSIZE-1 do
               begin
                    ctx.ByteBuffer[i] := ctx.ct[i] xor ctx.IV[i];
               end; {for i}
          end; {OFB}
     end;
end;

{*******************************************************************************
* Procedure : DecryptBlockMode                                                 *
********************************************************************************
* Purpose   : Decrypts the contents of the context buffer, using the           *
*             currently selected encryption mode.                              *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TDES.DecryptBlockMode;
var
     i: integer;
begin
     // perform the operation using the current mode
     case FCipherMode of
     CBC:
          begin
               // preserve the ciphertext in ct
               Move(ctx.ByteBuffer, ctx.ct, BLOCKSIZE);

               // perform the decryption on the block
               DES_Core_Block_Decrypt;

               // the plaintext is the ciphertext xor IV
               for i := 0 to BLOCKSIZE-1 do
               begin
                    ctx.ByteBuffer[i] := ctx.ByteBuffer[i] xor ctx.IV[i];
               end; {for i}

               // copy the ciphertext to the IV
               Move(ctx.ct, ctx.IV, BLOCKSIZE);
          end;
     ECB:
          begin
               // no preprocessing required
               // perform the decryption on the block
               DES_Core_Block_Decrypt;
          end;
     CFB:
          begin
               // Encipher the current IV to give the next IV
               // note that encipher is used
               Move (ctx.ByteBuffer, ctx.ct, BLOCKSIZE);
               Move (ctx.IV, ctx.ByteBuffer, BLOCKSIZE);

               // perform the encryption on the IV
               DES_Core_Block_Encrypt;

               Move(ctx.ByteBuffer, ctx.IV, BLOCKSIZE);
               Move (ctx.ct, ctx.ByteBuffer, BLOCKSIZE);

               // and xor the plaintext with the IV to get the ciphertext
               for i := 0 to BLOCKSIZE-1 do
               begin
                    ctx.ByteBuffer[i] := ctx.ByteBuffer[i] xor ctx.IV[i];
               end;

               // feed the ciphertext back into the IV
               Move (ctx.ct, ctx.IV, BLOCKSIZE);
          end; {CFB}
     OFB:
          begin
               // encrypt the previous IV to get the new IV
               // note that encipher is used
               Move (ctx.ByteBuffer, ctx.ct, BLOCKSIZE);
               Move (ctx.IV, ctx.ByteBuffer, BLOCKSIZE);

               // perform the encryption on the IV
               DES_Core_Block_Encrypt;

               // move the IV back
               Move (ctx.ByteBuffer, ctx.IV, BLOCKSIZE);

               // the plaintext is the ciphertext xor IV
               for i := 0 to BLOCKSIZE-1 do
               begin
                    ctx.ByteBuffer[i] := ctx.ct[i] xor ctx.IV[i];
               end; {for i}
          end; {OFB}
     end; {case}
end; {DecryptBlockMode}

{*******************************************************************************
* Procedure : CheckKeys                                                        *
********************************************************************************
* Purpose   : Checks that a valid key has been set before an encryption or     *
*             decryption. If the mode is not ECB, check the IV as well.        *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TDES.CheckKeys;
begin
     // check that we have a key
     if not ctx.KeyInit then
     begin
          // if not, we cannot perform the encryption
          // exit with error code
          raise EKeyError.Create(LIT_KEY_NOT_SET);
          Exit;
     end; {if not ctx.Init}

     // for modes other than ECB we also require an IV
     // check that this has been set if the mode is not ECB
     if FCipherMode <> ECB then
     begin
          // mode is not ECB
          if not ctx.IVInit then
          begin
               // if not, we cannot perform the encryption
               // exit with error code
               raise EKeyError.Create(LIT_IV_NOT_SET);
               Exit;
          end; {if not ctx.IVInit}
     end; {if FCipherMode}
end; {TDES.CheckKeys}


{******************************************************************}
{******************************************************************}
{****** the following functions encapsulate the DES algorithm *****}
{******************************************************************}
{******************************************************************}


{*******************************************************************************
* Procedure : DES_Func                                                         *
********************************************************************************
* Purpose   : The central engine of the DES algorithm                          *
********************************************************************************
* Paramters : Data - The block to be encrypted                                 *
*             Key - the key for the encryption                                 *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure DES_Func(Data: PIntArray; Key: PInteger); register;
var
     L: LongWord;
     R: LongWord;
     X: LongWord;
     Y: LongWord;
     i: LongWord;
begin
     // perform the initial endianness swap
     L := SwapInteger(Data[0]);
     R := SwapInteger(Data[1]);

     X := (L shr  4 xor R) and $0F0F0F0F;
     R := R xor X;
     L := L xor X shl  4;
     X := (L shr 16 xor R) and $0000FFFF;
     R := R xor X;
     L := L xor X shl 16;
     X := (R shr  2 xor L) and $33333333;
     L := L xor X;
     R := R xor X shl  2;
     X := (R shr  8 xor L) and $00FF00FF;
     L := L xor X;
     R := R xor X shl  8;

     R := R shl 1 or R shr 31;
     X := (L xor R) and $AAAAAAAA;
     R := R xor X;
     L := L xor X;
     L := L shl 1 or L shr 31;

     for I := 0 to 7 do
     begin
          X := (R shl 28 or R shr 4) xor Key^;
          Inc(Key);
          Y := R xor Key^;                     Inc(Key);
          L := L xor (DES_Data[0, X        and $3F] or DES_Data[1, X shr  8 and $3F] or
                      DES_Data[2, X shr 16 and $3F] or DES_Data[3, X shr 24 and $3F] or
                      DES_Data[4, Y        and $3F] or DES_Data[5, Y shr  8 and $3F] or
                      DES_Data[6, Y shr 16 and $3F] or DES_Data[7, Y shr 24 and $3F]);

          X := (L shl 28 or L shr 4) xor Key^;
          Inc(Key);
          Y := L xor Key^;
          Inc(Key);
          R := R xor (DES_Data[0, X        and $3F] or DES_Data[1, X shr  8 and $3F] or
                      DES_Data[2, X shr 16 and $3F] or DES_Data[3, X shr 24 and $3F] or
                      DES_Data[4, Y        and $3F] or DES_Data[5, Y shr  8 and $3F] or
                      DES_Data[6, Y shr 16 and $3F] or DES_Data[7, Y shr 24 and $3F]);
     end;

     R := R shl 31 or R shr 1;
     X := (L xor R) and $AAAAAAAA;
     R := R xor X;
     L := L xor X;
     L := L shl 31 or L shr 1;

     X := (L shr  8 xor R) and $00FF00FF; R := R xor X; L := L xor X shl  8;
     X := (L shr  2 xor R) and $33333333; R := R xor X; L := L xor X shl  2;
     X := (R shr 16 xor L) and $0000FFFF; L := L xor X; R := R xor X shl 16;
     X := (R shr  4 xor L) and $0F0F0F0F; L := L xor X; R := R xor X shl  4;

     Data[0] := SwapInteger(R);
     Data[1] := SwapInteger(L);
end; {DES_Func}

{*******************************************************************************
* Procedure : DES_Core_Key_Setup                                               *
********************************************************************************
* Purpose   : Loads the KeyToSet into the context                              *
********************************************************************************
* Paramters : 'KeyToSet' - the keyblock to be loaded                           *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TDES.DES_Core_Key_Setup(const KeyToSet: TBlock);
var
     K: array[0..7] of Byte;
begin
  FillChar(K, SizeOf(K), 0);
  Move(KeyToSet, K, 8);
  DES_core_make_key(K, @ctx.FEncKey, False);
  DES_core_make_key(K, @ctx.FDecKey, True);
  FillChar(K, SizeOf(K), 0);
end; {DES_Core_Key_Setup}

{*******************************************************************************
* Procedure : DES_Core_Block_Encrypt                                           *
********************************************************************************
* Purpose   : The block currently held in the buffer is enciphered with the    *
*             key held in the context.                                         *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TDES.DES_Core_Block_Encrypt;
begin
     DES_Func(@ctx.ByteBuffer, @ctx.FEncKey);
end;{TDES.DES_Core_Block_Encrypt}

{*******************************************************************************
* Procedure : DES_Core_Block_Decrypt                                           *
********************************************************************************
* Purpose   : The block currently held in the buffer is deciphered with the    *
*             key held in the context.                                         *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TDES.DES_Core_Block_Decrypt;
begin
     DES_Func(@ctx.ByteBuffer, @ctx.FDecKey);
end;{TDES.DES_Core_Block_Encrypt}

{*******************************************************************************
* Procedure : DES_core_make_key                                                *
********************************************************************************
* Purpose   : Makes either an encryption or a decryption key out of the key    *
*             material                                                         *
********************************************************************************
* Paramters : Data - Key material                                              *
*             Key - the computed key array                                     *
*             Reverse - False for encryption, True for decryption              *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TDES.DES_core_make_key(const Data: array of Byte; Key: PInteger; Reverse: Boolean);
const
     ROT: array[0..15] of Byte = (1,2,4,6,8,10,12,14,15,17,19,21,23,25,27,28);
var
     I: LongWord;
     J: LongWord;
     L: LongWord;
     M: LongWord;
     N: LongWord;
     PC_M: array[0..55] of Byte;
     PC_R: array[0..55] of Byte;
     K: array[0..31] of LongWord;
begin
     FillChar(K, SizeOf(K), 0);
     for I := 0 to 55 do
     begin
          if Data[DES_PC1[I] shr 3] and ($80 shr (DES_PC1[I] and $07)) <> 0 then
          begin
               PC_M[I] := 1
          end
          else
          begin
               PC_M[I] := 0;
          end;
     end;

     for I := 0 to 15 do
     begin
          if Reverse then
          begin
               M := (15 - I) shl 1
          end
          else
          begin
               M := I shl 1;
          end;

          N := M + 1;

          for J := 0 to 27 do
          begin
               L := J + ROT[I];
               if L < 28 then PC_R[J] := PC_M[L] else PC_R[J] := PC_M[L - 28];
          end;

          for J := 28 to 55 do
          begin
               L := J + ROT[I];
               if L < 56 then PC_R[J] := PC_M[L] else PC_R[J] := PC_M[L - 28];
          end;

          L := $1000000;

          for J := 0 to 23 do
          begin
               L := L shr 1;
               if PC_R[DES_PC2[J     ]] <> 0 then K[M] := K[M] or L;
               if PC_R[DES_PC2[J + 24]] <> 0 then K[N] := K[N] or L;
          end;
     end;

     for I := 0 to 15 do
     begin
          M := I shl 1; N := M + 1;
          Key^ := K[M] and $00FC0000 shl  6 or
                  K[M] and $00000FC0 shl 10 or
                  K[N] and $00FC0000 shr 10 or
                  K[N] and $00000FC0 shr  6;
          Inc(Key);
          Key^ := K[M] and $0003F000 shl 12 or
                  K[M] and $0000003F shl 16 or
                  K[N] and $0003F000 shr  4 or
                  K[N] and $0000003F;
          Inc(Key);
     end;
end;

function GetCPUType: Integer; assembler;
asm
         PUSH   EBX
         PUSH   ECX
         PUSH   EDX
         MOV    EBX,ESP
         AND    ESP,0FFFFFFFCh
         PUSHFD
         PUSHFD
         POP    EAX
         MOV    ECX,EAX
         XOR    EAX,40000h
         PUSH   EAX
         POPFD
         PUSHFD
         POP    EAX
         XOR    EAX,ECX
         MOV    EAX,3
         JE     @Exit
         PUSHFD
         POP    EAX
         MOV    ECX,EAX
         XOR    EAX,200000h
         PUSH   EAX
         POPFD
         PUSHFD
         POP    EAX
         XOR    EAX,ECX
         MOV    EAX,4
         JE     @Exit
         PUSH   EBX
         MOV    EAX,1
         DB     0Fh,0A2h      //CPUID
         MOV    AL,AH
         AND    EAX,0Fh
         POP    EBX
@Exit:   POPFD
         MOV    ESP,EBX
         POP    EDX
         POP    ECX
         POP    EBX
end;

function SwapInt(Value: LongWord): LongWord; assembler; register;
asm
       XCHG  AH,AL
       ROL   EAX,16
       XCHG  AH,AL
end;

function BSwapInt(Value: LongWord): LongWord; assembler; register;
asm
       BSWAP  EAX
end;

initialization
  if GetCPUType > 3 then
  begin
    SwapInteger := BSwapInt;
  end
  else
  begin
    SwapInteger := SwapInt;
  end;


end.

