//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "frmTest.h"
#include "alloc.h"
#include <stdlib.h>
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TfrmTestDes *frmTestDes;
//---------------------------------------------------------------------------
__fastcall TfrmTestDes::TfrmTestDes(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------


/*******************************************************************************
* Procedure : btnEncryptClick                                                  *
********************************************************************************
* Purpose   : Encrypts a the line of text in the edit box                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::btnEncryptClick(TObject *Sender)
{
     AnsiString TempString;

     DES1->LoadIVString("Init Vector");
     DES1->InitialiseString("Pass Phrase");

     // encrypt the string
     DES1->EncString(edtTestText->Text, TempString);

     // and copy it back to the edit box
     edtTestText->Text = TempString;

     // destroy sensitive information
     DES1->Burn();
}
//---------------------------------------------------------------------------

/*******************************************************************************
* Procedure : btnDecryptClick                                                  *
********************************************************************************
* Purpose   : Decrypts a the line of text in the edit box                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::btnDecryptClick(TObject *Sender)
{
     AnsiString TempString;

     DES1->LoadIVString("Init Vector");
     DES1->InitialiseString("Pass Phrase");

     // encrypt the string
     DES1->DecString(edtTestText->Text, TempString);

     // and copy it back to the edit box
     edtTestText->Text = TempString;

     // destroy sensitive information
     DES1->Burn();
}
//---------------------------------------------------------------------------

/*******************************************************************************
* Procedure : FormCreate                                                       *
********************************************************************************
* Purpose   : Retrieves the cipher version and set the cipher mode to ECB      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::FormCreate(TObject *Sender)
{
     edtVersion->Text = DES1->GetVersion();
     //rdbECBClick(Self);
}
//---------------------------------------------------------------------------

/*******************************************************************************
* Procedure : btnFileEncryptClick                                              *
********************************************************************************
* Purpose   : Selects a file to encrypt and encrypts it to the specified       *
*             destination file                                                 *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::btnFileEncryptClick(TObject *Sender)
{
     DES1->LoadIVString("Init Vector");
     DES1->InitialiseString("Pass Phrase");

     // check if a source and destination file has been selected
     if ((odlFileEnc->Execute()) && (sdlFileEnc->Execute()))
     {
          // perform the encryption
          DES1->EncFile(odlFileEnc->FileName, sdlFileEnc->FileName);
     }

     // destroy sensitive information
     DES1->Burn();
}
//---------------------------------------------------------------------------

/*******************************************************************************
* Procedure : btnFileDecryptClick                                              *
********************************************************************************
* Purpose   : Selects a file to decrypt and decrypts it to the specified       *
*             destination file                                                 *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::btnFileDecryptClick(TObject *Sender)
{
     DES1->LoadIVString("Init Vector");
     DES1->InitialiseString("Pass Phrase");

     // check if a source and destination file has been selected
     if ((odlFileDec->Execute()) && (sdlFileDec->Execute()))
     {
          // perform the decryption
          DES1->DecFile(odlFileDec->FileName, sdlFileDec->FileName);
     }

     // destroy sensitive information
     DES1->Burn();
}
//---------------------------------------------------------------------------

/*******************************************************************************
* Procedure : btnTestSpeedClick                                                *
********************************************************************************
* Purpose   : performs a speed check on the encryption algorithm using the     *
*             EncryptBlock method                                              *
********************************************************************************
* Paramters : Nibble - Hex digit to be converted (0-9, A-F)                    *
********************************************************************************
* Returns   : the decimal value of the hex digit (0-15)                        *
*******************************************************************************/
void __fastcall TfrmTestDes::btnTestSpeedClick(TObject *Sender)
{
    TDateTime StartTime;
    TDateTime LengthTime;
    Word Hour;
    Word Min;
    Word Sec;
    Word MSec;
    TBlock Input = {0,0,0,0,0,0,0,0};
    TBlock Output = {0,0,0,0,0,0,0,0};

     // test the speed of the encryption
     DES1->InitialiseString("This is a temp key");
     DES1->CipherMode = ECB;
     StartTime = Now();
     lblSpeed->Caption = "Working";
     lblSpeed->Repaint();

     // perform the loop
     for (int i = 0 ; i < 800000 ; i++)
     {
          DES1->EncBlock(Input, Output);
     }

     LengthTime = Now() - StartTime;

     DecodeTime(LengthTime, Hour, Min, Sec, MSec);
     LengthTime = (Hour*3600000 + Min*60000 + Sec*1000 + MSec);

     // we have encryped 6400kb data
     lblSpeed->Caption = IntToStr((int)(6400000/LengthTime));
}
//---------------------------------------------------------------------------

/*******************************************************************************
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
*******************************************************************************/
void __fastcall TfrmTestDes::btnStreamEncryptClick(TObject *Sender)
{
     char* TempString;

     // set the keys
     DES1->LoadIVString("Init Vector");
     DES1->InitialiseString("Pass Phrase");

     // create the streams
     TMemoryStream *InStream = new TMemoryStream;
     TMemoryStream *OutStream = new TMemoryStream;

     // read the text into the stream - going through a tempstring avoids type problems
     InStream->WriteBuffer(edtStreamTest->Text.c_str(), StrLen(edtStreamTest->Text.c_str()));

     // perform the encryption
     DES1->EncStream(InStream, OutStream);

     // read the string back out of the stream and display it
     OutStream->Seek(0, soFromBeginning);
     TempString = (char *) malloc(OutStream->Size + 1);
     OutStream->ReadBuffer(TempString, OutStream->Size);

     // set the end of the string
     TempString[OutStream->Size] = 0;

     // copy to the edit box
     edtStreamTest->Text = AnsiString(TempString);

     // burn sensitive information
     DES1->Burn();

     // delete the allocated objects
     free (TempString);
     delete InStream;
     delete OutStream;
}
//---------------------------------------------------------------------------

/*******************************************************************************
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
*******************************************************************************/
void __fastcall TfrmTestDes::btnStreamDecryptClick(TObject *Sender)
{
     char* TempString;

     // set the keys
     DES1->LoadIVString("Init Vector");
     DES1->InitialiseString("Pass Phrase");

     // create the streams
     TMemoryStream *InStream = new TMemoryStream;
     TMemoryStream *OutStream = new TMemoryStream;

     // read the text into the stream - going through a tempstring avoids type problems
     InStream->WriteBuffer(edtStreamTest->Text.c_str(), StrLen(edtStreamTest->Text.c_str()));

     // perform the encryption
     DES1->DecStream(InStream, OutStream);

     // read the string back out of the stream and display it
     OutStream->Seek(0, soFromBeginning);
     TempString = (char *) malloc(OutStream->Size + 1);
     OutStream->ReadBuffer(TempString, OutStream->Size);

     // set the end of the string
     TempString[OutStream->Size] = 0;

     // copy to the edit box
     edtStreamTest->Text = AnsiString(TempString);

     // burn sensitive information
     DES1->Burn();

     // delete the allocated objects
     free (TempString);
     delete InStream;
     delete OutStream;
}
//---------------------------------------------------------------------------

/*******************************************************************************
* Procedure : btmMakeMACClick                                                  *
********************************************************************************
* Purpose   : creates the CBC-MAC 'text to encrypt' edit box                   *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::btmMakeMACClick(TObject *Sender)
{
     AnsiString TempString;

     // set the key and IV up
     DES1->InitialiseString("CBC-MAC secret key");
     DES1->LoadIVString("CBC-MAC secret Init Vector");

     // load the data into the internal RC6 registers
     // the result of the encryption can be thrown away
     // or better, the mac can be produced during the encryption
     // and simply read out at the end
     DES1->EncString(edtTestText->Text, TempString);

     // see if we are in CBC mode (needed for CBC-MAC)
     try
     {
          DES1->CBCMACString(TempString);

          // burn the blowfish internal information
          DES1->Burn();

          // show the CBC-MAC
          edtCBCMAC->Text = TempString;
     }
     catch(...)
     {
          // if we are in the wrong mode, show an error
          ShowMessage("You must set the mode to CBC to produce a CBC-MAC!");
     }
}
//---------------------------------------------------------------------------

/*******************************************************************************
* Procedure : rdbECBClick                                                      *
********************************************************************************
* Purpose   : Sets the cipher mode to ECB                                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::rdbECBClick(TObject *Sender)
{
     DES1->CipherMode = ECB;
}
//---------------------------------------------------------------------------

/*******************************************************************************
* Procedure : rdbCBCClick                                                      *
********************************************************************************
* Purpose   : Sets the cipher mode to CBC                                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::rdbCBCClick(TObject *Sender)
{
     DES1->CipherMode = CBC;
}
//---------------------------------------------------------------------------

/*******************************************************************************
* Procedure : rdbCFBClick                                                      *
********************************************************************************
* Purpose   : Sets the cipher mode to CFB                                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::rdbCFBClick(TObject *Sender)
{
     DES1->CipherMode = CFB;
}
//---------------------------------------------------------------------------

/*******************************************************************************
* Procedure : rdbOFBClick                                                      *
********************************************************************************
* Purpose   : Sets the cipher mode to OFB                                      *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::rdbOFBClick(TObject *Sender)
{
     DES1->CipherMode = OFB;
}
//---------------------------------------------------------------------------
/*******************************************************************************
* Procedure : btnBlockEncClick                                                 *
********************************************************************************
* Purpose   : converts the hexedecimal numbers into binary and performs an     *
*             encryption, converting again to hex before display               *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::btnBlockEncClick(TObject *Sender)
{
     unsigned char KeyBytes[16];
     char* TempNibble;
     int i;
     int KeyLength;
     TBlock Input;
     TBlock Output;

     // get enough working space
     TempNibble = (char *) malloc(16);

     // get the bytes of the first block of the key
     for ( i = 0 ; i < 4 ; i++)
     {
          TempNibble[0] = '$';
          TempNibble[1] = edtKeyBytes1->Text.c_str()[i*2];
          TempNibble[2] = edtKeyBytes1->Text.c_str()[i*2+1];
          TempNibble[3] = 0;
          KeyBytes[i] = (short) StrToInt(TempNibble);
     }

     // get the bytes of the second block of the key
     for ( i = 0 ; i < 4 ; i++)
     {
          TempNibble[0] = '$';
          TempNibble[1] = edtKeyBytes2->Text.c_str()[i*2];
          TempNibble[2] = edtKeyBytes2->Text.c_str()[i*2+1];
          TempNibble[3] = 0;
          KeyBytes[i+4] = (short) StrToInt(TempNibble);
     }

     KeyLength = 8;


     // load the key into DES
     // NOTE: The middle parameter is automatically inserted by the conversion
     // from Delphi to C++Builder and should be passed with the same value as the
     // third parameter
     DES1->InitialiseByte(KeyBytes, KeyLength, KeyLength);


     // get the bytes of the first block of the plaintext
     for ( i = 0 ; i < 4 ; i++)
     {
          TempNibble[0] = '$';
          TempNibble[1] = edtPlainBytes1->Text.c_str()[i*2];
          TempNibble[2] = edtPlainBytes1->Text.c_str()[i*2+1];
          TempNibble[3] = 0;
          Input[i] = (short) StrToInt(TempNibble);
     }

     // get the bytes of the second block of the plaintext
     for ( i = 0 ; i < 4 ; i++)
     {
          TempNibble[0] = '$';
          TempNibble[1] = edtPlainBytes2->Text.c_str()[i*2];
          TempNibble[2] = edtPlainBytes2->Text.c_str()[i*2+1];
          TempNibble[3] = 0;
          Input[i+4] = (short) StrToInt(TempNibble);
     }

     // perform the encryption
     DES1->EncBlock(Input, Output);

     // show the result
     edtCipherBytes1->Text = IntToHex(Output[0],2) + IntToHex(Output[1],2) +
                             IntToHex(Output[2],2) + IntToHex(Output[3],2);

     edtCipherBytes2->Text = IntToHex(Output[4],2) + IntToHex(Output[5],2) +
                             IntToHex(Output[6],2) + IntToHex(Output[7],2);

     // clean up
     free(TempNibble);
}
//---------------------------------------------------------------------------

/*******************************************************************************
* Procedure : btnBlockDecClick                                                 *
********************************************************************************
* Purpose   : converts the hexedecimal numbers into binary and performs an     *
*             decryption, converting again to hex before display               *
********************************************************************************
* Paramters : None                                                             *
********************************************************************************
* Returns   : None                                                             *
*******************************************************************************/
void __fastcall TfrmTestDes::btnBlockDecClick(TObject *Sender)
{
     unsigned char KeyBytes[16];
     char* TempNibble;
     int i;
     int KeyLength;
     TBlock Input;
     TBlock Output;

     // get enough working space
     TempNibble = (char *) malloc(16);

     // get the bytes of the first block of the key
     for ( i = 0 ; i < 4 ; i++)
     {
          TempNibble[0] = '$';
          TempNibble[1] = edtKeyBytes1->Text.c_str()[i*2];
          TempNibble[2] = edtKeyBytes1->Text.c_str()[i*2+1];
          TempNibble[3] = 0;
          KeyBytes[i] = (short) StrToInt(TempNibble) ;
     }

     // get the bytes of the second block of the key
     for ( i = 0 ; i < 4 ; i++)
     {
          TempNibble[0] = '$';
          TempNibble[1] = edtKeyBytes2->Text.c_str()[i*2];
          TempNibble[2] = edtKeyBytes2->Text.c_str()[i*2+1];
          TempNibble[3] = 0;
          KeyBytes[i+4] = (short) StrToInt(TempNibble) ;
     }

     KeyLength = 8;

     // load the key into DES
     // NOTE: The middle parameter is automatically inserted by the conversion
     // from Delphi to C++Builder and should be passed with the same value as the
     // third parameter
     DES1->InitialiseByte(KeyBytes, KeyLength, KeyLength);


     // get the bytes of the first block of the ciphertext
     for ( i = 0 ; i < 4 ; i++)
     {
          TempNibble[0] = '$';
          TempNibble[1] = edtCipherBytes1->Text.c_str()[i*2];
          TempNibble[2] = edtCipherBytes1->Text.c_str()[i*2+1];
          TempNibble[3] = 0;
          Input[i] = (short) StrToInt(TempNibble) ;
     }

     // get the bytes of the second block of the ciphertext
     for ( i = 0 ; i < 4 ; i++)
     {
          TempNibble[0] = '$';
          TempNibble[1] = edtCipherBytes2->Text.c_str()[i*2];
          TempNibble[2] = edtCipherBytes2->Text.c_str()[i*2+1];
          TempNibble[3] = 0;
          Input[i+4] = (short) StrToInt(TempNibble);
     }

     // perform the encryption
     DES1->DecBlock(Input, Output);

     // show the result
     edtPlainBytes1->Text = IntToHex(Output[0],2) + IntToHex(Output[1],2) +
                             IntToHex(Output[2],2) + IntToHex(Output[3],2);

     edtPlainBytes2->Text = IntToHex(Output[4],2) + IntToHex(Output[5],2) +
                             IntToHex(Output[6],2) + IntToHex(Output[7],2);

     // clean up
     free(TempNibble);
}
//---------------------------------------------------------------------------

