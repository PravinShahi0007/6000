//---------------------------------------------------------------------------
#ifndef frmTestH
#define frmTestH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>
#include <Dialogs.hpp>
#include "des.hpp"

//---------------------------------------------------------------------------
class TfrmTestDes : public TForm
{
__published:	// IDE-managed Components
    TGroupBox *grpText;
    TBevel *Bevel1;
    TLabel *lblTestText;
    TLabel *lblVersion;
    TButton *btnDecrypt;
    TButton *btnEncrypt;
    TEdit *edtTestText;
    TEdit *edtVersion;
    TGroupBox *grpFile;
    TButton *btnFileEncrypt;
    TButton *btnFileDecrypt;
    TGroupBox *grpStream;
    TLabel *lblStreamTest;
    TEdit *edtStreamTest;
    TButton *btnStreamEncrypt;
    TButton *btnStreamDecrypt;
    TGroupBox *grpCipherMode;
    TRadioButton *rdbECB;
    TRadioButton *rdbCBC;
    TRadioButton *rdbCFB;
    TRadioButton *rdbOFB;
    TGroupBox *grpCBCMAC;
    TLabel *lblCBCMAC;
    TButton *btmMakeMAC;
    TEdit *edtCBCMAC;
    TGroupBox *grpBlock;
    TLabel *lblBlockKey;
    TLabel *lblPlainText;
    TLabel *lblCipherText;
    TEdit *edtKeyBytes1;
    TEdit *edtKeyBytes2;
    TEdit *edtPlainBytes1;
    TEdit *edtPlainBytes2;
    TEdit *edtCipherBytes1;
    TEdit *edtCipherBytes2;
    TButton *btnBlockEnc;
    TButton *btnBlockDec;
    TGroupBox *grpTimeTrial;
    TLabel *lblSpeedDisp;
    TLabel *lblSpeed;
    TLabel *lblKBs;
    TButton *btnTestSpeed;
    TOpenDialog *odlFileEnc;
    TSaveDialog *sdlFileEnc;
    TOpenDialog *odlFileDec;
    TSaveDialog *sdlFileDec;
        TDES *DES1;
    void __fastcall btnEncryptClick(TObject *Sender);
    void __fastcall btnDecryptClick(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall btnFileEncryptClick(TObject *Sender);
    void __fastcall btnFileDecryptClick(TObject *Sender);
    void __fastcall btnTestSpeedClick(TObject *Sender);
    void __fastcall btnStreamEncryptClick(TObject *Sender);
    void __fastcall btnStreamDecryptClick(TObject *Sender);
    void __fastcall btmMakeMACClick(TObject *Sender);
    void __fastcall rdbECBClick(TObject *Sender);
    void __fastcall rdbCBCClick(TObject *Sender);
    void __fastcall rdbCFBClick(TObject *Sender);
    void __fastcall rdbOFBClick(TObject *Sender);
    void __fastcall btnBlockEncClick(TObject *Sender);
    void __fastcall btnBlockDecClick(TObject *Sender);
private:	// User declarations
public:		// User declarations
    __fastcall TfrmTestDes(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TfrmTestDes *frmTestDes;
//---------------------------------------------------------------------------
#endif
