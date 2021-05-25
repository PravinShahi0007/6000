// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'des.pas' rev: 4.00

#ifndef desHPP
#define desHPP

#pragma delphiheader begin
#pragma option push -w-
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Des
{
//-- type declarations -------------------------------------------------------
typedef unsigned *PInteger;

typedef unsigned TIntArray[1024];

typedef unsigned *PIntArray;

class DELPHICLASS EKeyError;
#pragma pack(push, 1)
class PASCALIMPLEMENTATION EKeyError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall EKeyError(const AnsiString Msg) : Sysutils::Exception(Msg)
		 { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EKeyError(const AnsiString Msg, const System::TVarRec * 
		Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EKeyError(int Ident, Extended Dummy) : Sysutils::Exception(
		Ident, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EKeyError(int Ident, const System::TVarRec * Args, const 
		int Args_Size) : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EKeyError(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(
		Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EKeyError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EKeyError(int Ident, int AHelpContext) : Sysutils::Exception(
		Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EKeyError(int Ident, const System::TVarRec * Args
		, const int Args_Size, int AHelpContext) : Sysutils::Exception(Ident, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EKeyError(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS EFileError;
#pragma pack(push, 1)
class PASCALIMPLEMENTATION EFileError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall EFileError(const AnsiString Msg) : Sysutils::Exception(Msg
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EFileError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EFileError(int Ident, Extended Dummy) : Sysutils::Exception(
		Ident, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EFileError(int Ident, const System::TVarRec * Args, 
		const int Args_Size) : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EFileError(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(
		Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EFileError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EFileError(int Ident, int AHelpContext) : Sysutils::Exception(
		Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EFileError(int Ident, const System::TVarRec * Args
		, const int Args_Size, int AHelpContext) : Sysutils::Exception(Ident, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EFileError(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

class DELPHICLASS EInputError;
#pragma pack(push, 1)
class PASCALIMPLEMENTATION EInputError : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	#pragma option push -w-inl
	/* Exception.Create */ inline __fastcall EInputError(const AnsiString Msg) : Sysutils::Exception(Msg
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EInputError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EInputError(int Ident, Extended Dummy) : Sysutils::Exception(
		Ident, Dummy) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EInputError(int Ident, const System::TVarRec * Args, 
		const int Args_Size) : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EInputError(const AnsiString Msg, int AHelpContext) : 
		Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EInputError(const AnsiString Msg, const System::TVarRec 
		* Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EInputError(int Ident, int AHelpContext) : Sysutils::Exception(
		Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EInputError(int Ident, const System::TVarRec * Args
		, const int Args_Size, int AHelpContext) : Sysutils::Exception(Ident, Args, Args_Size, AHelpContext
		) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EInputError(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

typedef Byte TBlock[8];

typedef Byte *PBlock;

#pragma pack(push, 1)
struct Tdes_ctx
{
	bool KeyInit;
	bool IVInit;
	Byte IV[8];
	Byte ct[8];
	unsigned FEncKey[32];
	unsigned FDecKey[32];
	union
	{
		struct 
		{
			int LongBuffer[2];
			
		};
		struct 
		{
			Byte ByteBuffer[8];
			
		};
		
	};
} ;
#pragma pack(pop)

#pragma option push -b-
enum TCipherMode { CBC, ECB, CFB, OFB };
#pragma option pop

#pragma option push -b-
enum TStringMode { smEncode, smNormal };
#pragma option pop

class DELPHICLASS TDES;
#pragma pack(push, 1)
class PASCALIMPLEMENTATION TDES : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Tdes_ctx ctx;
	Byte FBuffer[4105];
	Byte *PtrBuffer;
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
	AnsiString __fastcall EncodeString(AnsiString InputString);
	AnsiString __fastcall DecodeString(AnsiString InputString);
	void __fastcall CheckKeys(void);
	
public:
	void __fastcall InitialiseString(const AnsiString Key);
	void __fastcall InitialiseByte(const Byte * Key, const int Key_Size, int Keylength);
	void __fastcall LoadIVString(const AnsiString IVString);
	void __fastcall LoadIVByte(const Byte * IVByte, const int IVByte_Size, int IVLength);
	void __fastcall EncBlock(const Byte * Input, Byte * Output);
	void __fastcall DecBlock(const Byte * Input, Byte * Output);
	void __fastcall EncFile(const AnsiString InputFileName, AnsiString OutputFileName);
	void __fastcall DecFile(const AnsiString InputFileName, AnsiString OutputFileName);
	void __fastcall EncStream(const Classes::TStream* Input, const Classes::TStream* Output);
	void __fastcall DecStream(const Classes::TStream* Input, const Classes::TStream* Output);
	void __fastcall EncString(const AnsiString Input, AnsiString &Output);
	void __fastcall DecString(const AnsiString Input, AnsiString &Output);
	void __fastcall CBCMACBlock(Byte * MAC);
	void __fastcall CBCMACString(AnsiString &MAC);
	void __fastcall Burn(void);
	AnsiString __fastcall GetVersion();
	
__published:
	__property TCipherMode CipherMode = {read=FCipherMode, write=FCipherMode, nodefault};
	__property TStringMode StringMode = {read=FStringMode, write=FStringMode, nodefault};
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TDES(Classes::TComponent* AOwner) : Classes::TComponent(
		AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TDES(void) { }
	#pragma option pop
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const Shortint BLOCKSIZE = 0x8;
static const Word BUFFERSIZE = 0x1000;
extern PACKAGE void __fastcall Register(void);

}	/* namespace Des */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Des;
#endif
#pragma option pop	// -w-

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// des
