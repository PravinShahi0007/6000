{*******************************************************************************
* Unit      : frmCipherTest                                                    *
********************************************************************************
* Purpose   : Provides a testing harness for TSM encryption components         *
********************************************************************************
* Copyright : This unit is copyright TSM Inc. 1999                             *
*             This source code may not be distributed to third parties in      *
*             or in part without the written permission of TSM Inc.            *
*             All rights reserved. Liability limited to replacement of         *
*             this original source code in the case of loss or damage because  *
*             the use or misuse of this software.                              *
********************************************************************************
* Version   : 25.02.98  - 1.0   Original unit                                  *
*             10.08.98  - 1.10  Tidied up                                      *
*             22.01.99  - 1.14  Tidied up and added streams and blocks         *
*******************************************************************************}

unit frmctest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,StdCtrls,
  DES, ExtCtrls;

{*******************************************************************************
* Type      : TfrmCipherTest                                                   *
********************************************************************************
* Purpose   : Defines the form                                                 *
*******************************************************************************}
type
  TfrmCipherTest = class(TForm)
    grpText: TGroupBox;
    btnDecrypt: TButton;
    btnEncrypt: TButton;
    edtTestText: TEdit;
    lblTestText: TLabel;
    grpFile: TGroupBox;
    btnFileEncrypt: TButton;
    odlFileEnc: TOpenDialog;
    sdlFileEnc: TSaveDialog;
    btnFileDecrypt: TButton;
    odlFileDec: TOpenDialog;
    sdlFileDec: TSaveDialog;
    edtVersion: TEdit;
    lblVersion: TLabel;
    Bevel1: TBevel;
    grpStream: TGroupBox;
    lblStreamTest: TLabel;
    edtStreamTest: TEdit;
    btnStreamEncrypt: TButton;
    btnStreamDecrypt: TButton;
    grpCipherMode: TGroupBox;
    rdbECB: TRadioButton;
    rdbCBC: TRadioButton;
    rdbCFB: TRadioButton;
    rdbOFB: TRadioButton;
    grpCBCMAC: TGroupBox;
    lblCBCMAC: TLabel;
    btmMakeMAC: TButton;
    edtCBCMAC: TEdit;
    grpBlock: TGroupBox;
    edtKeyBytes1: TEdit;
    lblBlockKey: TLabel;
    edtKeyBytes2: TEdit;
    edtPlainBytes1: TEdit;
    edtPlainBytes2: TEdit;
    edtCipherBytes1: TEdit;
    edtCipherBytes2: TEdit;
    lblPlainText: TLabel;
    lblCipherText: TLabel;
    btnBlockEnc: TButton;
    btnBlockDec: TButton;
    DES1: TDES;
    grpTimeTrial: TGroupBox;
    lblSpeedDisp: TLabel;
    lblSpeed: TLabel;
    lblKBs: TLabel;
    btnTestSpeed: TButton;
    procedure btnFileEncryptClick(Sender: TObject);
    procedure btnEncryptClick(Sender: TObject);
    procedure btnDecryptClick(Sender: TObject);
    procedure btnFileDecryptClick(Sender: TObject);
    procedure rdbECBClick(Sender: TObject);
    procedure rdbCBCClick(Sender: TObject);
    procedure rdbCFBClick(Sender: TObject);
    procedure rdbOFBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnStreamEncryptClick(Sender: TObject);
    procedure btnStreamDecryptClick(Sender: TObject);
    procedure btnBlockEncClick(Sender: TObject);
    procedure btmMakeMACClick(Sender: TObject);
    procedure btnBlockDecClick(Sender: TObject);
    procedure btnTestSpeedClick(Sender: TObject);
  private
    procedure ParseHalfBlock(const StringToParse: string;
                             var   KeyBytes: array of Byte;
                             const Offset: integer);
    function ConvertNibble(Nibble: Char): integer;
  end;


var
  frmCipherTest: TfrmCipherTest;

implementation

{$R *.DFM}

{*******************************************************************************
* Procedure : btnEncryptClick                                                  *
********************************************************************************
* Purpose   : Encrypts a the line of text in the edit box                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.btnEncryptClick(Sender: TObject);
var
     Tempstr: string;
begin
     DES1.LoadIVString('Init Vector');
     DES1.InitialiseString('Pass Phrase');

     // encrypt the string
     DES1.EncString(edtTestText.Text, TempStr);

     // and copy it back to the edit box
     edtTestText.Text := TempStr;

     // destroy sensitive information
     DES1.Burn;
end; {btnEncryptClick}

{*******************************************************************************
* Procedure : btnDecryptClick                                                  *
********************************************************************************
* Purpose   : Decrypts a the line of text in the edit box                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.btnDecryptClick(Sender: TObject);
var
     Tempstr: string;
begin
     DES1.InitialiseString('Pass Phrase');
     DES1.LoadIVString('Init Vector');

     // decrypt the string
     DES1.DecString(edtTestText.Text,Tempstr);

     // and copy it back into the edit box
     edtTestText.Text := TempStr;

     // destroy sensitive information
     DES1.Burn;
end; {btnDecryptClick}

{*******************************************************************************
* Procedure : btnFileEncryptClick                                              *
********************************************************************************
* Purpose   : Selects a file to encrypt and encrypts it to the specified       *
*             destination file                                                 *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.btnFileEncryptClick(Sender: TObject);
begin
     DES1.LoadIVString('Init Vector');
     DES1.InitialiseString('Pass Phrase');

     // check if a source and destination file has been selected
     if odlFileEnc.Execute and sdlFileEnc.Execute then
     begin
          // perform the encryption
          DES1.EncFile(odlFileEnc.FileName, sdlFileEnc.FileName);
     end; {if}

     // destroy sensitive information
     DES1.Burn;
end; {btnFileEncryptClick}

{*******************************************************************************
* Procedure : btnFileDecryptClick                                              *
********************************************************************************
* Purpose   : Selects a file to decrypt and decrypts it to the specified       *
*             destination file                                                 *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.btnFileDecryptClick(Sender: TObject);
begin
     DES1.LoadIVString('Init Vector');
     DES1.InitialiseString('Pass Phrase');

     // check if a source and destination file has been selected
     if odlFileDec.Execute and sdlFileDec.Execute then
     begin
          // perform the decryption
          DES1.DecFile(odlFileDec.FileName, sdlFileDec.FileName);
     end;

     // destroy sensitive information
     DES1.Burn;
end; {btnFileDecryptClick}

{*******************************************************************************
* Procedure : rdbECBClick                                                      *
********************************************************************************
* Purpose   : Sets the cipher mode to ECB                                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.rdbECBClick(Sender: TObject);
begin
     DES1.CipherMode := ECB;
end; {rdbECBClick}

{*******************************************************************************
* Procedure : rdbCBCClick                                                      *
********************************************************************************
* Purpose   : Sets the cipher mode to CBC                                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.rdbCBCClick(Sender: TObject);
begin
     DES1.CipherMode := CBC;
end; {rdbCBCClick}

{*******************************************************************************
* Procedure : rdbCFBClick                                                      *
********************************************************************************
* Purpose   : Sets the cipher mode to CFB                                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.rdbCFBClick(Sender: TObject);
begin
     DES1.CipherMode := CFB;
end; {rdbCFBClick}

{*******************************************************************************
* Procedure : rdbOFBClick                                                      *
********************************************************************************
* Purpose   : Sets the cipher mode to OFB                                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.rdbOFBClick(Sender: TObject);
begin
     DES1.CipherMode := OFB;
end; {rdbOFBClick}

{*******************************************************************************
* Procedure : FormCreate                                                       *
********************************************************************************
* Purpose   : Retrieves the cipher version and set the cipher mode to ECB      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.FormCreate(Sender: TObject);
begin
     edtVersion.Text := DES1.GetVersion;
     rdbECBClick(Self);
end; {FormCreate}

{*******************************************************************************
* Procedure : btnStreamEncryptClick                                            *
********************************************************************************
* Purpose   : Decrypts the contents of the text box using stream methods and   *
*             places the result back in the edit box                           *
*             **NOTE** Because we are dealing with strings and displaying them *
*             in an edit box, the encryption can sometimes contain binary zero *
*             which will cause an incorrect decryption. (This is why we often  *
*             use the Base64 option in encrypt and decrypt string functions)   *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.btnStreamEncryptClick(Sender: TObject);
var
     InStream: TMemoryStream;
     OutStream: TMemoryStream;
     TempString: string;
begin
     // set the keys
     DES1.LoadIVString('Init Vector');
     DES1.InitialiseString('Pass Phrase');

     // create the streams
     InStream := TMemoryStream.Create;
     OutStream := TMemoryStream.Create;

     // read the text into the stream - going through a tempstring avoids type problems
     TempString := edtStreamTest.Text;
     InStream.WriteBuffer(TempString[1], Length(TempString));

     // perform the encryption
     DES1.EncStream(InStream, OutStream);

     // read the string back out of the stream and display it
     OutStream.Seek(0, soFromBeginning);
     SetLength(TempString, OutStream.Size);
     OutStream.ReadBuffer(TempString[1], OutStream.Size);
     edtStreamTest.Text := TempString;

     // burn sensitive information
     DES1.Burn;
end; {btnStreamEncryptClick}

{*******************************************************************************
* Procedure : btnStreamDecryptClick                                            *
********************************************************************************
* Purpose   : Decrypts the contents of the text box using stream methods and   *
*             places the result back in the edit box                           *
*             **NOTE** Because we are dealing with strings and displaying them *
*             in an edit box, the encryption can sometimes contain binary zero *
*             which will cause an incorrect decryption. (This is why we often  *
*             use the Base64 option in encrypt and decrypt string functions)   *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.btnStreamDecryptClick(Sender: TObject);
var
     InStream: TMemoryStream;
     OutStream: TMemoryStream;
     TempString: string;
begin
     // set the keys
     DES1.InitialiseString('Pass Phrase');
     DES1.LoadIVString('Init Vector');

     // create the streams
     InStream := TMemoryStream.Create;
     OutStream := TMemoryStream.Create;

     // read the text into the stream - going through a tempstring avoids type problems
     TempString := edtStreamTest.Text;
     InStream.WriteBuffer(TempString[1], Length(TempString));

     // perform the decryption
     DES1.DecStream(InStream, OutStream);

     // read the string back out of the stream and display it
     OutStream.Seek(0, soFromBeginning);
     SetLength(TempString, OutStream.Size);
     OutStream.ReadBuffer(TempString[1], OutStream.Size);
     edtStreamTest.Text := TempString;

     // burn sensitive information
     DES1.Burn;
end; {btnStreamDecryptClick}

{*******************************************************************************
* Procedure : btmMakeMACClick                                                  *
********************************************************************************
* Purpose   : creates the CBC-MAC 'text to encrypt' edit box                   *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.btmMakeMACClick(Sender: TObject);
var
     TempString: String;
begin
     // set the key and IV up
     DES1.InitialiseString('CBC-MAC secret key');
     DES1.LoadIVString('CBC-MAC secret Init Vector');

     // load the data into the internal RC6 registers
     // the result of the encryption can be thrown away
     // or better, the mac can be produced during the encryption
     // and simply read out at the end
     DES1.EncString(edtTestText.Text, TempString);

     // see if we are in CBC mode (needed for CBC-MAC)
     try
          DES1.CBCMACString(TempString);
     except
          // if we are in the wrong mode, show an error
          ShowMessage('You must set the mode to CBC to produce a CBC-MAC!');
          Exit;
     end;

     // burn the DES internal information
     DES1.Burn;

     // show the CBC-MAC
     edtCBCMAC.Text := TempString;
end; {btnMakeMACClick}

{*******************************************************************************
* Procedure : btnBlockEncClick                                                 *
********************************************************************************
* Purpose   : converts the hexedecimal numbers into binary and performs an     *
*             encryption, converting again to hex before display               *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.btnBlockEncClick(Sender: TObject);
var
     KeyBytes: array[0..15] of Byte;
     KeyLength: integer;
     InputBlock: TBlock;
     OutputBlock: TBlock;
     i: integer;
begin
     // Convert the keybytes text into bytes
     ParseHalfBlock(edtKeyBytes1.Text, KeyBytes, 0);
     ParseHalfBlock(edtKeyBytes2.Text, KeyBytes, 4);
     KeyLength := 8;

     // set the key
     DES1.InitialiseByte(KeyBytes, KeyLength);

     // Convert the plain Bytes
     ParseHalfBlock(edtPlainBytes1.Text, KeyBytes, 0);
     ParseHalfBlock(edtPlainBytes2.Text, KeyBytes, 4);

     // move into the TBlock
     Move(KeyBytes[0], InputBlock, BLOCKSIZE);

     // do the encryption
     DES1.EncBlock(InputBlock, OutputBlock);

     // show the result
     edtCipherBytes1.Text := '';
     edtCipherBytes2.Text := '';

     for i := 0 to 3 do
     begin
          edtCipherBytes1.Text := edtCipherBytes1.Text + IntToHex(OutputBlock[i],2);
          edtCipherBytes2.Text := edtCipherBytes2.Text + IntToHex(OutputBlock[i+4],2);
     end;

     //  burn the information
     DES1.Burn;
end; {btnBlockEncClick}

{*******************************************************************************
* Procedure : btnBlockDecClick                                                 *
********************************************************************************
* Purpose   : converts the hexedecimal numbers into binary and performs an     *
*             decryption, converting again to hex before display               *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.btnBlockDecClick(Sender: TObject);
var
     KeyBytes: array[0..15] of Byte;
     KeyLength: integer;
     InputBlock: TBlock;
     OutputBlock: TBlock;
     i: integer;
begin
     // Convert the keybytes text into bytes
     ParseHalfBlock(edtKeyBytes1.Text, KeyBytes, 0);
     ParseHalfBlock(edtKeyBytes2.Text, KeyBytes, 4);
     KeyLength := 8;

     // set the key
     DES1.InitialiseByte(KeyBytes, KeyLength);

     // Convert the plain Bytes
     ParseHalfBlock(edtCipherBytes1.Text, KeyBytes, 0);
     ParseHalfBlock(edtCipherBytes2.Text, KeyBytes, 4);

     // move into the TBlock
     Move(KeyBytes[0], InputBlock, BLOCKSIZE);

     // do the encryption
     DES1.DecBlock(InputBlock, OutputBlock);

     // show the result
     edtPlainBytes1.Text := '';
     edtPlainBytes2.Text := '';

     for i := 0 to 3 do
     begin
          edtPlainBytes1.Text := edtPlainBytes1.Text + IntToHex(OutputBlock[i],2);
          edtPlainBytes2.Text := edtPlainBytes2.Text + IntToHex(OutputBlock[i+4],2);
     end;

     //  burn the information
     DES1.Burn;
end; {btnBlockDecClick}

{*******************************************************************************
* Procedure : ParseHalfBlock                                                   *
********************************************************************************
* Purpose   : converts 32 bits of hexedecimal into a 32 bit binary integer,    *
*             and writes it into the KeyBytes array at the given offset        *
********************************************************************************
* Paramters : StringToParse - the 8 digit string to be converted               *
*             KeyBytes - array of Byte which holds the key                     *
*             Offset - the offset in the key array which will be written       *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************}
procedure TfrmCipherTest.ParseHalfBlock(const StringToParse: string;
                                        var   KeyBytes: array of Byte;
                                        const Offset: integer);
var
     i: integer;
     Pos: integer;
     TempString: string;
begin
     // check the validity of the string - first the length
     if Length(StringtoParse) <> 8 then
     begin
          raise Exception.Create('Half block hex string has wrong length');
          Exit;
     end;

     // set the pointer in the key array
     Pos := Offset;

     // convert to upper case
     TempString := UpperCase(StringToParse);

     // parse the string
     for i := 0 to 3 do
     begin
          KeyBytes[Pos+i] := ConvertNibble(TempString[(i*2)+1])*16 +
                             ConvertNibble(TempString[(i*2)+2]);
     end;

end; {ParseHalfBlock}

{*******************************************************************************
* Procedure : ConvertNibble                                                    *
********************************************************************************
* Purpose   : converts a nibble into a decimal equivalent. Input must be upper *
*             case                                                             *
********************************************************************************
* Paramters : Nibble - Hex digit to be converted (0-9, A-F)                    *
********************************************************************************
* Returns   : the decimal value of the hex digit (0-15)                        *
*******************************************************************************}
function TfrmCipherTest.ConvertNibble(Nibble: Char): integer;
const
     HexDigits: set of '0'..'Z' = ['0'..'9', 'A'..'F'];
begin
     if not (Nibble in HexDigits) then
     begin
          Raise Exception.Create('Invalid hex character in input string');
          Exit;
     end;

     Result := Ord(Nibble) - Ord('0');
     if Result > 9 then
     begin
          Result := Result -7;
     end;
end; {ConvertNibble}

{*******************************************************************************
* Procedure : btnTestSpeedClick                                                *
********************************************************************************
* Purpose   : performs a speed check on the encryption algorithm using the     *
*             EncryptBlock method                                              *
********************************************************************************
* Paramters : Nibble - Hex digit to be converted (0-9, A-F)                    *
********************************************************************************
* Returns   : the decimal value of the hex digit (0-15)                        *
*******************************************************************************}
procedure TfrmCipherTest.btnTestSpeedClick(Sender: TObject);
var
     StartTime: TDateTime;
     LengthTime: TDateTime;
     Hour: word;
     Min: word;
     Sec: word;
     MSec: word;
     i: Longint;
     Input: TBlock;
     Output: TBLock;
begin
     // test the speed of the encryption
     DES1.InitialiseString('This is a temp key');
     DES1.CipherMode := ECB;
     StartTime := Now;
     FillChar(Input, Sizeof(Input), #0);
     lblSpeed.Caption := 'Working';
     lblSpeed.Repaint;

     // perform the loop
     for i := 0 to 79999 do
     begin
          DES1.EncBlock(Input, Output);
     end;

     LengthTime := Now - StartTime;

     DecodeTime(LengthTime, Hour, Min, Sec, MSec);
     LengthTime := (Hour*3600000 + Min*60000 + Sec*1000 + MSec);

     // we have encryped 640kb data
     lblSpeed.Caption := IntToStr(Trunc(640000/LengthTime));
end; {TfrmCipherTest.btnTestSpeedClick}

end.

