// Borland C++ Builder
// Copyright (c) 1995, 1998 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'des.pas' rev: 3.00

#ifndef desHPP
#define desHPP
#include <SysUtils.hpp>
#include <Classes.hpp>
#include <SysInit.hpp>
#include <System.hpp>

//-- user supplied -----------------------------------------------------------

namespace Des
{
//-- type declarations -------------------------------------------------------
typedef int LongWord;

typedef int *PInteger;

typedef int TIntArray[1024];

typedef TIntArray *PIntArray;

class DELPHICLASS EKeyError;
class PASCALIMPLEMENTATION EKeyError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ __fastcall EKeyError(const System::AnsiString Msg) : Sysutils::Exception(Msg
		) { }
	/* Exception.CreateFmt */ __fastcall EKeyError(const System::AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ __fastcall EKeyError(int Ident, Extended Dummy) : Sysutils::Exception(Ident
		, Dummy) { }
	/* Exception.CreateResFmt */ __fastcall EKeyError(int Ident, const System::TVarRec * Args, const int 
		Args_Size) : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ __fastcall EKeyError(const System::AnsiString Msg, int AHelpContext) : Sysutils::
		Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ __fastcall EKeyError(const System::AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext
		) { }
	/* Exception.CreateResHelp */ __fastcall EKeyError(int Ident, int AHelpContext) : Sysutils::Exception(
		Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ __fastcall EKeyError(int Ident, const System::TVarRec * Args, const 
		int Args_Size, int AHelpContext) : Sysutils::Exception(Ident, Args, Args_Size, AHelpContext) { }
	
public:
	/* TObject.Destroy */ __fastcall virtual ~EKeyError(void) { }
	
};

class DELPHICLASS EFileError;
class PASCALIMPLEMENTATION EFileError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ __fastcall EFileError(const System::AnsiString Msg) : Sysutils::Exception(Msg
		) { }
	/* Exception.CreateFmt */ __fastcall EFileError(const System::AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ __fastcall EFileError(int Ident, Extended Dummy) : Sysutils::Exception(Ident
		, Dummy) { }
	/* Exception.CreateResFmt */ __fastcall EFileError(int Ident, const System::TVarRec * Args, const int 
		Args_Size) : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ __fastcall EFileError(const System::AnsiString Msg, int AHelpContext) : 
		Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ __fastcall EFileError(const System::AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext
		) { }
	/* Exception.CreateResHelp */ __fastcall EFileError(int Ident, int AHelpContext) : Sysutils::Exception(
		Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ __fastcall EFileError(int Ident, const System::TVarRec * Args, const 
		int Args_Size, int AHelpContext) : Sysutils::Exception(Ident, Args, Args_Size, AHelpContext) { }
	
public:
	/* TObject.Destroy */ __fastcall virtual ~EFileError(void) { }
	
};

class DELPHICLASS EInputError;
class PASCALIMPLEMENTATION EInputError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ __fastcall EInputError(const System::AnsiString Msg) : Sysutils::Exception(Msg
		) { }
	/* Exception.CreateFmt */ __fastcall EInputError(const System::AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ __fastcall EInputError(int Ident, Extended Dummy) : Sysutils::Exception(Ident
		, Dummy) { }
	/* Exception.CreateResFmt */ __fastcall EInputError(int Ident, const System::TVarRec * Args, const 
		int Args_Size) : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ __fastcall EInputError(const System::AnsiString Msg, int AHelpContext) : 
		Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ __fastcall EInputError(const System::AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext
		) { }
	/* Exception.CreateResHelp */ __fastcall EInputError(int Ident, int AHelpContext) : Sysutils::Exception(
		Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ __fastcall EInputError(int Ident, const System::TVarRec * Args, const 
		int Args_Size, int AHelpContext) : Sysutils::Exception(Ident, Args, Args_Size, AHelpContext) { }
	
public:
	/* TObject.Destroy */ __fastcall virtual ~EInputError(void) { }
	
};

typedef Byte TBlock[8];

typedef TBlock *PBlock;

#pragma pack(push, 1)
struct Tdes_ctx
{
	bool KeyInit;
	bool IVInit;
	Byte IV[8];
	Byte ct[8];
	int FEncKey[32];
	int FDecKey[32];
	union
	{
		int LongBuffer[2];
		Byte ByteBuffer[8];
		
	};
} ;
#pragma pack(pop)

enum TCipherMode { CBC, ECB, CFB, OFB };

enum TStringMode { smEncode, smNormal };

class DELPHICLASS TDES;
class PASCALIMPLEMENTATION TDES : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Tdes_ctx ctx;
	Byte FBuffer[4105];
	TBlock *PtrBuffer;
	TCipherMode FCipherMode;
	TStringMode FStringMode;
	void __fastcall DES_Core_Key_Setup(const Byte * KeyToSet);
	void __fastcall DES_Core_Block_Encrypt(void);
	void __fastcall DES_Core_Block_Decrypt(void);
	void __fastcall DES_core_make_key(const Byte * Data, const int Data_Size, PInteger Key, bool Reverse
		);
	void __fastcall EncryptBuffer(const int Len);
	void __fastcall DecryptBuffer(const int Len);
	void __fastcall EncryptBlockMode(void);
	void __fastcall DecryptBlockMode(void);
	System::AnsiString __fastcall EncodeString(System::AnsiString InputString);
	System::AnsiString __fastcall DecodeString(System::AnsiString InputString);
	void __fastcall CheckKeys(void);
	
public:
	void __fastcall InitialiseString(const System::AnsiString Key);
	void __fastcall InitialiseByte(const Byte * Key, const int Key_Size, int Keylength);
	void __fastcall LoadIVString(const System::AnsiString IVString);
	void __fastcall LoadIVByte(const Byte * IVByte, const int IVByte_Size, int IVLength);
	void __fastcall EncBlock(const Byte * Input, Byte * Output);
	void __fastcall DecBlock(const Byte * Input, Byte * Output);
	void __fastcall EncFile(const System::AnsiString InputFileName, System::AnsiString OutputFileName);
		
	void __fastcall DecFile(const System::AnsiString InputFileName, System::AnsiString OutputFileName);
		
	void __fastcall EncStream(const Classes::TStream* Input, const Classes::TStream* Output);
	void __fastcall DecStream(const Classes::TStream* Input, const Classes::TStream* Output);
	void __fastcall EncString(const System::AnsiString Input, System::AnsiString &Output);
	void __fastcall DecString(const System::AnsiString Input, System::AnsiString &Output);
	void __fastcall CBCMACBlock(Byte * MAC);
	void __fastcall CBCMACString(System::AnsiString &MAC);
	void __fastcall Burn(void);
	System::AnsiString __fastcall GetVersion(void);
	
__published:
	__property TCipherMode CipherMode = {read=FCipherMode, write=FCipherMode, nodefault};
	__property TStringMode StringMode = {read=FStringMode, write=FStringMode, nodefault};
public:
	/* TComponent.Create */ __fastcall virtual TDES(Classes::TComponent* AOwner) : Classes::TComponent(
		AOwner) { }
	/* TComponent.Destroy */ __fastcall virtual ~TDES(void) { }
	
};

//-- var, const, procedure ---------------------------------------------------
#define BLOCKSIZE (Byte)(8)
#define BUFFERSIZE (Word)(4096)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Des */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Des;
#endif
//-- end unit ----------------------------------------------------------------
#endif	// des
