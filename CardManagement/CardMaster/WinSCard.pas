unit WinSCard;

// http://www.codelooker.com/codec/6087SmartCard2/WinSCard.pas.html

{******************************************************************}
{                                                                  }
{ Borland Delphi Runtime Library                                   }
{ PCSC interface unit                                              }
{                                                                  }
{ Portions created by Microsoft are                                }
{ Copyright (C) 1996 Microsoft Corporation.                        }
{ All Rights Reserved.                                             }
{                                                                  }
{ The original file is: WinSCard.h                                 }
{ The original Pascal code is: WinSCard.pas                        }
{ The initial developer of the Pascal code is Chris Dickerson      }
{ (chrisd@tsc.com).                                                }
{                                                                  }
{ Obtained through:                                                }
{                                                                  }
{ Joint Endeavour of Delphi Innovators (Project JEDI)              }
{                                                                  }
{ You may retrieve the latest version of this file at the Project  }
{ JEDI home page, located at http://delphi-jedi.org                }
{                                                                  }
{ The contents of this file are used with permission, subject to   }
{ the Mozilla Public License Version 1.1 (the "License"); you may  }
{ not use this file except in compliance with the License. You may }
{ obtain a copy of the License at                                  }
{ http://www.mozilla.org/MPL/MPL-1.1.html                          }
{                                                                  }
{ Software distributed under the License is distributed on an      }
{ "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or   }
{ implied. See the License for the specific language governing     }
{ rights and limitations under the License.                        }
{                                                                  }
{******************************************************************}

// 12/9/2017  MKL  Prototype for SCardGetStatusChange() fixed
// 12/9/2017  MKL  Switch to unicode

{$DEFINE UNICODE}
{-DEFINE WinSCard_LINKONREQUEST}

interface

uses
   Windows;
{$IFDEF WinSCard_LINKONREQUEST}
  {$DEFINE WinSCard_DYNLINK}
{$ENDIF}

type
   LPCGUID = ^GUID;
   {$EXTERNALSYM LPCGUID}
   GUID = record
      Data1: LongInt;
      Data2: Integer;
      Data3: Integer;
      Data4: array[0..7] of Byte;
   end;
   {$EXTERNALSYM GUID}

(*

Copyright (c) 1996  Microsoft Corporation

Module Name:

    WinSCard

Abstract:

    This header file provides the definitions and symbols necessary for an
    Application or Smart Card Service Provider to access the Smartcard
    Subsystem.

Environment:

    Win32

Notes:

*)

var
   LPCBYTE: PUChar;
   {$EXTERNALSYM LPCBYTE}

   LPCVOID: Pointer;  { VOID *LPCVOID; }
   {$EXTERNALSYM LPCVOID}

type
   PSCARD_IO_REQUEST = ^SCARD_IO_REQUEST;
   {$EXTERNALSYM PSCARD_IO_REQUEST}
   SCARD_IO_REQUEST = record
      dwProtocol: DWORD;    { Protocol identifier }
      dbPciLength: DWORD;   { Protocol Control Information Length }
   end;
   {$EXTERNALSYM SCARD_IO_REQUEST}

//
////////////////////////////////////////////////////////////////////////////////
//
//  Service Manager Access Services
//
//      The following services are used to manage user and terminal contexts for
//      Smart Cards.
//
type
   SCARDCONTEXT = DWORD;
   {$EXTERNALSYM SCARDCONTEXT}
   SCARDHANDLE = DWORD;
   {$EXTERNALSYM SCARDHANDLE}

var
   PSCARDCONTEXT, LPSCARDCONTEXT: ^SCARDCONTEXT; { SCARDCONTEXT * }
   {$EXTERNALSYM PSCARDCONTEXT}
   {$EXTERNALSYM LPSCARDCONTEXT}

   PSCARDHANDLE, LPSCARDHANDLE: ^SCARDHANDLE; { SCARDHANDLE * }
   {$EXTERNALSYM PSCARDHANDLE}
   {$EXTERNALSYM LPSCARDHANDLE}

const
   SCARD_AUTOALLOCATE  = DWORD(-1);
   {$EXTERNALSYM SCARD_AUTOALLOCATE}

   SCARD_SCOPE_USER = 0;                 // The context is a user context, and any
   {$EXTERNALSYM SCARD_SCOPE_USER}       // database operations are performed within the
                                         // domain of the user.
   SCARD_SCOPE_TERMINAL = 1;             // The context is that of the current terminal,
   {$EXTERNALSYM SCARD_SCOPE_TERMINAL}   // and any database operations are performed
                                         // within the domain of that terminal.  (The
                                         // calling application must have appropriate
                                         // access permissions for any database actions.)
   SCARD_SCOPE_SYSTEM = 2;               // The context is the system context, and any
   {$EXTERNALSYM SCARD_SCOPE_SYSTEM}     // database operations are performed within the
                                         // domain of the system.  (The calling
                                         // application must have appropriate access
                                         // permissions for any database actions.)



{$IFDEF WinSCard_DYNLINK}
type
   TSCardEstablishContext = function (dwScope: DWORD; pvReserved1: Pointer; pvReserved2: Pointer;
                                      phContext: Pointer): LongInt; stdcall;
   TSCardReleaseContext = function (hContext: LongInt): LongInt; stdcall;
   TSCardIsValidContext = function (hContext: LongInt): LongInt; stdcall;
{$ELSE}
   function SCardEstablishContext(dwScope: DWORD; pvReserved1: Pointer; pvReserved2: Pointer;
                                  phContext: Pointer): LongInt; stdcall;
   {$EXTERNALSYM SCardEstablishContext}
   function SCardReleaseContext(hContext: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardReleaseContext}
   function SCardIsValidContext(hContext: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardIsValidContext}
{$ENDIF}


//
////////////////////////////////////////////////////////////////////////////////
//
//  Smart Card Database Management Services
//
//      The following services provide for managing the Smart Card Database.
//

const
   SCARD_ALL_READERS     =  'SCard$AllReaders' + Chr(0) + Chr(0);
   {$EXTERNALSYM SCARD_ALL_READERS}
   SCARD_DEFAULT_READERS =  'SCard$DefaultReaders' + Chr(0) + Chr(0);
   {$EXTERNALSYM SCARD_DEFAULT_READERS}
   SCARD_LOCAL_READERS   =  'SCard$LocalReaders' + Chr(0) + Chr(0);
   {$EXTERNALSYM SCARD_LOCAL_READERS}
   SCARD_SYSTEM_READERS  =  'SCard$SystemReaders' + Chr(0) + Chr(0);
   {$EXTERNALSYM SCARD_SYSTEM_READERS}

   SCARD_PROVIDER_PRIMARY = 1;   // Primary Provider Id
   {$EXTERNALSYM SCARD_PROVIDER_PRIMARY}
   SCARD_PROVIDER_CSP     = 2;   // Crypto Service Provider Id
   {$EXTERNALSYM SCARD_PROVIDER_CSP}

//
// Database Reader routines
//

{$IFDEF WinSCard_DYNLINK}
type
   TSCardListReaderGroupsA = function (hContext: LongInt; mszGroups: LPStr; var pcchGroups: LongInt): LongInt; stdcall;
   TSCardListReaderGroupsW = function (hContext: LongInt; mszGroups: LPWStr; var pcchGroups: LongInt): LongInt; stdcall;

   {$IFDEF UNICODE}
      TSCardListReaderGroups = TSCardListReaderGroupsW;
   {$ELSE}
      TSCardListReaderGroups = TSCardListReaderGroupsA;
   {$ENDIF}

   TSCardListReadersA = function (SCARDCONTEXT: LongInt; mszGroups: LPStr; mszReaders: LPStr;
                                  var pcchReaders: LongInt): LongInt; stdcall;
   TSCardListReadersW = function (SCARDCONTEXT: LongInt; mszGroups: LPWStr; mszReaders: LPWStr;
                                  var pcchReaders: LongInt): LongInt; stdcall;

   {$IFDEF UNICODE}
      TSCardListReaders = TSCardListReadersW;
   {$ELSE}
      TSCardListReaders = TSCardListReadersA;
   {$ENDIF}

   TSCardListCardsA = function (hContext: LongInt; var pbAtr: Byte; var rgguidInterfaces: GUID;
                                cguidInterfaceCount: LongInt; mszCards: LPStr; var pcchCards: LongInt): LongInt; stdcall;
   TSCardListCardsW = function (hContext: LongInt; var pbAtr: Byte; var rgguidInterfaces: GUID;
                                cguidInterfaceCount: LongInt; mszCards: LPWStr; var pcchCards: LongInt): LongInt; stdcall;

   {$IFDEF UNICODE}
      TSCardListCards = TSCardListCardsW;
   {$ELSE}
      TSCardListCards = TSCardListCardsA;
   {$ENDIF}

{$ELSE}
   function SCardListReaderGroupsA(hContext: LongInt; mszGroups: LPStr; var pcchGroups: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardListReaderGroupsA}
   function SCardListReaderGroupsW(hContext: LongInt; mszGroups: LPWStr; var pcchGroups: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardListReaderGroupsW}

   function SCardListReadersA(SCARDCONTEXT: LongInt; mszGroups: LPStr; mszReaders: LPStr;
                              var pcchReaders: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardListReadersA}
   function SCardListReadersW(SCARDCONTEXT: LongInt; mszGroups: LPWStr; mszReaders: LPWStr;
                              var pcchReaders: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardListReadersW}

   function SCardListCardsA(hContext: LongInt; var pbAtr: Byte; var rgguidInterfaces: GUID;
                            cguidInterfaceCount: LongInt; mszCards: LPStr; var pcchCards: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardListCardsA}
   function SCardListCardsW(hContext: LongInt; var pbAtr: Byte; var rgguidInterfaces: GUID;
                            cguidInterfaceCount: LongInt; mszCards: LPWStr; var pcchCards: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardListCardsW}

{$ENDIF}

//
// NOTE:    The routine SCardListCards name differs from the PC/SC definition.
//          It should be:
//
//              extern WINSCARDAPI LONG WINAPI
//              SCardListCardTypes(
//                  IN      SCARDCONTEXT hContext,
//                  IN      LPCBYTE pbAtr,
//                  IN      LPCGUID rgquidInterfaces,
//                  IN      DWORD cguidInterfaceCount,
//                  OUT     LPTSTR mszCards,
//                  IN OUT  LPDWORD pcchCards);
//
//          Here's a work-around MACRO:
//#define SCardListCardTypes SCardListCards

{$IFDEF WinSCard_DYNLINK}
type
   TSCardListCardTypes = TSCardListCardsA;

   TSCardListInterfacesA = function (hContext: LongInt; szCard: LPStr; var pguidInterfaces: GUID;
                                     var pcguidInterfaces: LongInt): LongInt; stdcall;
   TSCardListInterfacesW = function (hContext: LongInt; szCard: LPWStr; var pguidInterfaces: GUID;
                                     var pcguidInterfaces: LongInt): LongInt; stdcall;

   {$IFDEF UNICODE}
      TSCardListInterfaces = TSCardListInterfacesW;
   {$ELSE}
      TSCardListInterfaces = TSCardListInterfacesA;
   {$ENDIF}

   TSCardGetProviderIdA = function (hContext: LongInt; szCard: LPStr; var pguidProviderId: GUID): LongInt; stdcall;
   TSCardGetProviderIdW = function (hContext: LongInt; szCard: LPWStr; var pguidProviderId: GUID): LongInt; stdcall;

   {$IFDEF UNICODE}
      TSCardGetProviderId = TSCardGetProviderIdW;
   {$ELSE}
      TSCardGetProviderId = TSCardGetProviderIdA;
   {$ENDIF}
{$ELSE}
   function SCardListInterfacesA(hContext: LongInt; szCard: LPStr; var pguidInterfaces: GUID;
                                 var pcguidInterfaces: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardListInterfacesA}
   function SCardListInterfacesW(hContext: LongInt; szCard: LPWStr; var pguidInterfaces: GUID;
                                 var pcguidInterfaces: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardListInterfacesW}

   function SCardGetProviderIdA(hContext: LongInt; szCard: LPStr; var pguidProviderId: GUID): LongInt; stdcall;
   {$EXTERNALSYM SCardGetProviderIdA}
   function SCardGetProviderIdW(hContext: LongInt; szCard: LPWStr; var pguidProviderId: GUID): LongInt; stdcall;
   {$EXTERNALSYM SCardGetProviderIdW}

{$ENDIF}

//
// NOTE:    The routine SCardGetProviderId in this implementation uses GUIDs.
//          The PC/SC definition uses BYTEs.
//

{$IFDEF WinSCard_DYNLINK}
type
   TSCardGetCardTypeProviderNameA = function (hContext: LongInt; szCardName: LPStr; dwProviderId: LongInt;
                                              szProvider: LPStr; var pcchProvider: LongInt): LongInt; stdcall;
   TSCardGetCardTypeProviderNameW = function (hContext: LongInt; szCardName: LPWStr; dwProviderId: LongInt;
                                              szProvider: LPWStr; var pcchProvider: LongInt): LongInt; stdcall;

   {$IFDEF UNICODE}
      TSCardGetCardTypeProviderName = TSCardGetCardTypeProviderNameW;
   {$ELSE}
      TSCardGetCardTypeProviderName = TSCardGetCardTypeProviderNameA;
   {$ENDIF}
{$ELSE}
   function SCardGetCardTypeProviderNameA(hContext: LongInt; szCardName: LPStr; dwProviderId: LongInt;
                                          szProvider: LPStr; var pcchProvider: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardGetCardTypeProviderNameA}
   function SCardGetCardTypeProviderNameW(hContext: LongInt; szCardName: LPWStr; dwProviderId: LongInt;
                                          szProvider: LPWStr; var pcchProvider: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardGetCardTypeProviderNameW}
{$ENDIF}


//
// NOTE:    This routine is an extension to the PC/SC definitions.
//


//
// Database Writer routines
//

{$IFDEF WinSCard_DYNLINK}
type
   TSCardIntroduceReaderGroupA = function (hContext: LongInt; szGroupName: LPStr): LongInt; stdcall;
   TSCardIntroduceReaderGroupW = function (hContext: LongInt; szGroupName: LPWStr): LongInt; stdcall;

   {$IFDEF UNICODE}
      TSCardIntroduceReaderGroup = TSCardIntroduceReaderGroupW;
   {$ELSE}
      TSCardIntroduceReaderGroup = TSCardIntroduceReaderGroupA;
   {$ENDIF}

   TSCardForgetReaderGroupA = function (hContext: LongInt; szGroupName: LPStr): LongInt; stdcall;
   TSCardForgetReaderGroupW = function (hContext: LongInt; szGroupName: LPWStr): LongInt; stdcall;
   {$IFDEF UNICODE}
      TSCardForgetReaderGroup = TSCardForgetReaderGroupW;
   {$ELSE}
      TSCardForgetReaderGroup = TSCardForgetReaderGroupA;
   {$ENDIF}

   TSCardIntroduceReaderA = function (hContext: LongInt; szReadeName: LPStr; szDeviceName: LPStr): LongInt; stdcall;
   TSCardIntroduceReaderW = function (hContext: LongInt; szReadeName: LPWStr; szDeviceName: LPWStr): LongInt; stdcall;
   {$IFDEF UNICODE}
      TSCardIntroduceReader = TSCardIntroduceReaderW;
   {$ELSE}
      TSCardIntroduceReader = TSCardIntroduceReaderA;
   {$ENDIF}

   TSCardForgetReaderA = function (hContext: LongInt; szReaderName: LPStr): LongInt; stdcall;
   TSCardForgetReaderW = function (hContext: LongInt; szReaderName: LPWStr): LongInt; stdcall;
   {$IFDEF UNICODE}
      TSCardForgetReader = TSCardForgetReaderW;
   {$ELSE}
      TSCardForgetReader = TSCardForgetReaderA;
   {$ENDIF}

   TSCardAddReaderToGroupA = function (hContext: LongInt; szReaderName: LPStr; szGroupName: LPStr): LongInt; stdcall;
   TSCardAddReaderToGroupW = function (hContext: LongInt; szReaderName: LPWStr; szGroupName: LPWStr): LongInt; stdcall;
   {$IFDEF UNICODE}
      TSCardAddReaderToGroup = TSCardAddReaderToGroupW;
   {$ELSE}
      TSCardAddReaderToGroup = TSCardAddReaderToGroupA;
   {$ENDIF}

   TSCardRemoveReaderFromGroupA = function (hContext: LongInt; szReaderName: LPStr; szGroupName: LPStr): LongInt; stdcall;
   TSCardRemoveReaderFromGroupW = function (hContext: LongInt; szReaderName: LPWStr; szGroupName: LPWStr): LongInt; stdcall;
   {$IFDEF UNICODE}
      TSCardRemoveReaderFromGroup = TSCardRemoveReaderFromGroupW;
   {$ELSE}
      TSCardRemoveReaderFromGroup = TSCardRemoveReaderFromGroupA;
   {$ENDIF}

   TSCardIntroduceCardTypeA = function (hContext: LongInt; szCardName: LPStr; var pguidPrimaryProvider: GUID;
                                        var pguidInterfaces: GUID; dwInterfaceCount: LongInt; pbAtr: LPStr;
                                        pbAtrMask: LPStr; cbAtrLen: LongInt): LongInt; stdcall;
   TSCardIntroduceCardTypeW = function (hContext: LongInt; szCardName: LPWStr; var pguidPrimaryProvider: GUID;
                                        var pguidInterfaces: GUID; dwInterfaceCount: LongInt; pbAtr: LPWStr;
                                        pbAtrMask: LPWStr; cbAtrLen: LongInt): LongInt; stdcall;

   {$IFDEF UNICODE}
      TSCardIntroduceCardType = TSCardIntroduceCardTypeW;
   {$ELSE}
      TSCardIntroduceCardType = TSCardIntroduceCardTypeA;
   {$ENDIF}

   TSCardSetCardTypeProviderNameA = function (hContext: LongInt; szCardName: LPStr; dwProviderId: LongInt;
                                              szProvider: LPStr): LongInt; stdcall;
   TSCardSetCardTypeProviderNameW = function (hContext: LongInt; szCardName: LPWStr; dwProviderId: LongInt;
                                              szProvider: LPWStr): LongInt; stdcall;
   {$IFDEF UNICODE}
      TSCardSetCardTypeProviderName = TSCardSetCardTypeProviderNameW;
   {$ELSE}
      TSCardSetCardTypeProviderName = TSCardSetCardTypeProviderNameA;
   {$ENDIF}
{$ELSE}
   function SCardIntroduceReaderGroupA(hContext: LongInt; szGroupName: LPStr): LongInt; stdcall;
   {$EXTERNALSYM SCardIntroduceReaderGroupA}
   function SCardIntroduceReaderGroupW(hContext: LongInt; szGroupName: LPWStr): LongInt; stdcall;
   {$EXTERNALSYM SCardIntroduceReaderGroupW}

   function SCardForgetReaderGroupA(hContext: LongInt; szGroupName: LPStr): LongInt; stdcall;
   {$EXTERNALSYM SCardForgetReaderGroupA}
   function SCardForgetReaderGroupW(hContext: LongInt; szGroupName: LPWStr): LongInt; stdcall;
   {$EXTERNALSYM SCardForgetReaderGroupW}

   function SCardIntroduceReaderA(hContext: LongInt; szReadeName: LPStr; szDeviceName: LPStr): LongInt; stdcall;
   {$EXTERNALSYM SCardIntroduceReaderA}
   function SCardIntroduceReaderW(hContext: LongInt; szReadeName: LPWStr; szDeviceName: LPWStr): LongInt; stdcall;
   {$EXTERNALSYM SCardIntroduceReaderW}

   function SCardForgetReaderA(hContext: LongInt; szReaderName: LPStr): LongInt; stdcall;
   {$EXTERNALSYM SCardForgetReaderA}
   function SCardForgetReaderW(hContext: LongInt; szReaderName: LPWStr): LongInt; stdcall;
   {$EXTERNALSYM SCardForgetReaderW}

   function SCardAddReaderToGroupA(hContext: LongInt; szReaderName: LPStr; szGroupName: LPStr): LongInt; stdcall;
   {$EXTERNALSYM SCardAddReaderToGroupA}
   function SCardAddReaderToGroupW(hContext: LongInt; szReaderName: LPWStr; szGroupName: LPWStr): LongInt; stdcall;
   {$EXTERNALSYM SCardAddReaderToGroupW}

   function SCardRemoveReaderFromGroupA(hContext: LongInt; szReaderName: LPStr; szGroupName: LPStr): LongInt; stdcall;
   {$EXTERNALSYM SCardRemoveReaderFromGroupA}
   function SCardRemoveReaderFromGroupW(hContext: LongInt; szReaderName: LPWStr; szGroupName: LPWStr): LongInt; stdcall;
   {$EXTERNALSYM SCardRemoveReaderFromGroupW}

   function SCardIntroduceCardTypeA(hContext: LongInt; szCardName: LPStr; var pguidPrimaryProvider: GUID;
                                    var pguidInterfaces: GUID; dwInterfaceCount: LongInt; pbAtr: LPStr;
                                    pbAtrMask: LPStr; cbAtrLen: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardIntroduceCardTypeA}
   function SCardIntroduceCardTypeW(hContext: LongInt; szCardName: LPWStr; var pguidPrimaryProvider: GUID;
                                    var pguidInterfaces: GUID; dwInterfaceCount: LongInt; pbAtr: LPWStr;
                                    pbAtrMask: LPWStr; cbAtrLen: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardIntroduceCardTypeW}

   function SCardSetCardTypeProviderNameA(hContext: LongInt; szCardName: LPStr; dwProviderId: LongInt;
                                          szProvider: LPStr): LongInt; stdcall;
   {$EXTERNALSYM SCardSetCardTypeProviderNameA}
   function SCardSetCardTypeProviderNameW(hContext: LongInt; szCardName: LPWStr; dwProviderId: LongInt;
                                          szProvider: LPWStr): LongInt; stdcall;
   {$EXTERNALSYM SCardSetCardTypeProviderNameW}
{$ENDIF}

//
// NOTE:    This routine is an extention to the PC/SC specifications.
//

{$IFDEF WinSCard_DYNLINK}
type
   TSCardForgetCardTypeA = function (hContext: LongInt; szCardName: LPStr): LongInt; stdcall;
   TSCardForgetCardTypeW = function (hContext: LongInt; szCardName: LPWStr): LongInt; stdcall;

   {$IFDEF UNICODE}
      TSCardForgetCardType = TSCardForgetCardTypeW;
   {$ELSE}
      TSCardForgetCardType = TSCardForgetCardTypeA;
   {$ENDIF}
{$ELSE}
   function SCardForgetCardTypeA(hContext: LongInt; szCardName: LPStr): LongInt; stdcall;
   {$EXTERNALSYM SCardForgetCardTypeA}
   function SCardForgetCardTypeW(hContext: LongInt; szCardName: LPWStr): LongInt; stdcall;
   {$EXTERNALSYM SCardForgetCardTypeW}
{$ENDIF}

//
////////////////////////////////////////////////////////////////////////////////
//
//  Service Manager Support Routines
//
//      The following services are supplied to simplify the use of the Service
//      Manager API.
//

{$IFDEF WinSCard_DYNLINK}
type
   TSCardFreeMemory = function (hContext: LongInt; pvMem: LongInt): LongInt; stdcall;

   TSCardAccessStartedEvent = function: LongInt; stdcall;

   TSCardReleaseStartedEvent = function: LongInt; stdcall;
{$ELSE}
   function SCardFreeMemory(hContext: LongInt; pvMem: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardFreeMemory}

   function SCardAccessStartedEvent: LongInt; stdcall;
   {$EXTERNALSYM SCardAccessStartedEvent}

   function SCardReleaseStartedEvent: LongInt; stdcall;
   {$EXTERNALSYM SCardReleaseStartedEvent}
{$ENDIF}

//
////////////////////////////////////////////////////////////////////////////////
//
//  Reader Services
//
//      The following services supply means for tracking cards within readers.
//

type
   LPSCARD_READERSTATEA = ^SCARD_READERSTATEA;
   {$EXTERNALSYM LPSCARD_READERSTATEA}
   PSCARD_READERSTATEA = ^SCARD_READERSTATEA;
   {$EXTERNALSYM PSCARD_READERSTATEA}

   SCARD_READERSTATEA = record

// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED
// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED

      szReader:       LPCSTR;       { the reader name from SCardListReaders }

// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED
// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED

      pvUserData:     Pointer;      { user defined data }
      dwCurrentState: LongInt;      { current state of reader at time of call }
      dwEventState:   LongInt;      { state of reader after state change }
      cbAtr:          LongInt;      { Number of bytes in the returned ATR }
      rgbAtr: array[0..35] of Byte; { Atr of inserted card, (extra alignment bytes) }
   end;
   {$EXTERNALSYM SCARD_READERSTATEA}

   LPSCARD_READERSTATEW = ^SCARD_READERSTATEW;
   {$EXTERNALSYM LPSCARD_READERSTATEW}
   PSCARD_READERSTATEW = ^SCARD_READERSTATEW;
   {$EXTERNALSYM PSCARD_READERSTATEW}
   SCARD_READERSTATEW = record
      szReader: LPCWStr;                { reader name }
      pvUserData: Pointer;              { user defined data }
      dwCurrentState: LongInt;          { current state of reader at time of call }
      dwEventState: LongInt;            { state of reader after state change }
      cbAtr: LongInt;                   { Number of bytes in the returned ATR }
      rgbAtr: array[0..35] of Byte;     { Atr of inserted card, (extra alignment bytes) }
   end;
   {$EXTERNALSYM SCARD_READERSTATEW}

{$IFDEF UNICODE}
   SCARD_READERSTATE = SCARD_READERSTATEW;
   PSCARD_READERSTATE = PSCARD_READERSTATEW;
   LPSCARD_READERSTATE = LPSCARD_READERSTATEW;
{$ELSE}
   SCARD_READERSTATE = SCARD_READERSTATEA;
   PSCARD_READERSTATE = PSCARD_READERSTATEA;
   LPSCARD_READERSTATE = LPSCARD_READERSTATEA;
{$ENDIF}
{$EXTERNALSYM SCARD_READERSTATE}
{$EXTERNALSYM PSCARD_READERSTATE}
{$EXTERNALSYM LPSCARD_READERSTATE}

const
   SCARD_STATE_UNAWARE = $0;                // The application is unaware of the
   {$EXTERNALSYM SCARD_STATE_UNAWARE}       // current state, and would like to
                                            // know.  The use of this value
                                            // results in an immediate return
                                            // from state transition monitoring
                                            // services.  This is represented by
                                            // all bits set to zero.
   SCARD_STATE_IGNORE  = $1;                // The application requested that
   {$EXTERNALSYM SCARD_STATE_IGNORE}        // this reader be ignored.  No other
                                            // bits will be set.
   SCARD_STATE_CHANGED = $2;                // This implies that there is a
   {$EXTERNALSYM SCARD_STATE_CHANGED}       // difference between the state
                                            // believed by the application, and
                                            // the state known by the Service
                                            // Manager.  When this bit is set,
                                            // the application may assume a
                                            // significant state change has
                                            // occurred on this reader.
   SCARD_STATE_UNKNOWN = $4;                // This implies that the given
   {$EXTERNALSYM SCARD_STATE_UNKNOWN}       // reader name is not recognized by
                                            // the Service Manager.  If this bit
                                            // is set, then SCARD_STATE_CHANGED
                                            // and SCARD_STATE_IGNORE will also
                                            // be set.
   SCARD_STATE_UNAVAILABLE = $8;            // This implies that the actual
   {$EXTERNALSYM SCARD_STATE_UNAVAILABLE}   // state of this reader is not
                                            // available.  If this bit is set,
                                            // then all the following bits are
                                            // clear.
   SCARD_STATE_EMPTY = $10;                 // This implies that there is not
   {$EXTERNALSYM SCARD_STATE_EMPTY}         // card in the reader.  If this bit
                                            // is set, all the following bits
                                            // will be clear.
   SCARD_STATE_PRESENT = $20;               // This implies that there is a card
   {$EXTERNALSYM SCARD_STATE_PRESENT}       // in the reader.
   SCARD_STATE_ATRMATCH = $40;              // This implies that there is a card
   {$EXTERNALSYM SCARD_STATE_ATRMATCH}      // in the reader with an ATR
                                            // matching one of the target cards.
                                            // If this bit is set,
                                            // SCARD_STATE_PRESENT will also be
                                            // set.  This bit is only returned
                                            // on the SCardLocateCard() service.
   SCARD_STATE_EXCLUSIVE = $80;             // This implies that the card in the
   {$EXTERNALSYM SCARD_STATE_EXCLUSIVE}     // reader is allocated for exclusive
                                            // use by another application.  If
                                            // this bit is set,
                                            // SCARD_STATE_PRESENT will also be
                                            // set.
   SCARD_STATE_INUSE = $100;                // This implies that the card in the
   {$EXTERNALSYM SCARD_STATE_INUSE}         // reader is in use by one or more
                                            // other applications, but may be
                                            // connected to in shared mode.  If
                                            // this bit is set,
                                            // SCARD_STATE_PRESENT will also be
                                            // set.
   SCARD_STATE_MUTE = $200;                 // This implies that the card in the
   {$EXTERNALSYM SCARD_STATE_MUTE}          // reader is unresponsive or not
                                            // supported by the reader or
                                            // software.
   SCARD_STATE_UNPOWERED = $400;            // This implies that the card in the
   {$EXTERNALSYM SCARD_STATE_UNPOWERED}     // reader has not been powered up.

{$IFDEF WinSCard_DYNLINK}
type
   TSCardLocateCardsA = function (hContext: LongInt; mszCards: LPStr; var rgReaderStates: PSCARD_READERSTATEA;
                                  cReaders: LongInt): LongInt; stdcall;
   TSCardLocateCardsW = function (hContext: LongInt; mszCards: LPWStr; var rgReaderStates: PSCARD_READERSTATEW;
                                  cReaders: LongInt): LongInt; stdcall;

   {$IFDEF UNICODE}
      TSCardLocateCards = TSCardLocateCardsW;
   {$ELSE}
      TSCardLocateCards = TSCardLocateCardsA;
   {$ENDIF}
{$ELSE}
   function SCardLocateCardsA(hContext: LongInt; mszCards: LPStr; var rgReaderStates: PSCARD_READERSTATEA;
                              cReaders: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardLocateCardsA}
   function SCardLocateCardsW(hContext: LongInt; mszCards: LPWStr; var rgReaderStates: PSCARD_READERSTATEW;
                              cReaders: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardLocateCardsW}
{$ENDIF}

type
   PSCARD_ATRMASK = ^SCARD_ATRMASK;
   {$EXTERNALSYM PSCARD_ATRMASK}
   LPSCARD_ATRMASK = ^SCARD_ATRMASK;
   {$EXTERNALSYM LPSCARD_ATRMASK}
   SCARD_ATRMASK = record
      cbArt: DWORD;                  // Number of bytes in the ATR and the mask.
      rgbAtr: array[0..35] of Byte;  // Atr of card (extra alignment bytes)
      rgbMask: array[0..35] of Byte; // Mask for the Atr (extra alignment bytes)
   end;
   {$EXTERNALSYM SCARD_ATRMASK}

{$IFDEF WinSCard_DYNLINK}
type
   TSCardLocateCardsByATRA = function (hContext: LongInt; rgAtrMasks: LPSCARD_ATRMASK; cAtrs: DWORD;
                                       var rgReaderStates: SCARD_READERSTATEA; cReaders: DWORD): LongInt; stdcall;
   TSCardLocateCardsByATRW = function (hContext: LongInt; rgAtrMasks: LPSCARD_ATRMASK; cAtrs: DWORD;
                                       var rgReaderStates: SCARD_READERSTATEW; cReaders: DWORD): LongInt; stdcall;

   {$IFDEF UNICODE}
      TSCardLocateCardsByATR = TSCardLocateCardsByATRW;
   {$ELSE}
      TSCardLocateCardsByATR = TSCardLocateCardsByATRA;
   {$ENDIF}

   TSCardGetStatusChangeA = function (hContext: LongInt; dwTimeout: LongInt; var rgReaderStates: PSCARD_READERSTATEA;
                                      cReaders: DWORD): LongInt; stdcall;
   TSCardGetStatusChangeW = function (hContext: LongInt; dwTimeout: LongInt; var rgReaderStates: PSCARD_READERSTATEW;
                                      cReaders: LongInt): LongInt; stdcall;
   {$IFDEF UNICODE}
      TSCardGetStatusChange = TSCardGetStatusChangeW;
   {$ELSE}
      TSCardGetStatusChange = TSCardGetStatusChangeA;
   {$ENDIF}

   TSCardCancel = function (hContext: LongInt): LongInt; stdcall;
{$ELSE}
   function SCardLocateCardsByATRA(hContext: LongInt; rgAtrMasks: LPSCARD_ATRMASK; cAtrs: DWORD;
                                   var rgReaderStates: SCARD_READERSTATEA; cReaders: DWORD): LongInt; stdcall;
   {$EXTERNALSYM SCardLocateCardsByATRA}
   function SCardLocateCardsByATRW(hContext: LongInt; rgAtrMasks: LPSCARD_ATRMASK; cAtrs: DWORD;
                                   var rgReaderStates: SCARD_READERSTATEW; cReaders: DWORD): LongInt; stdcall;
   {$EXTERNALSYM SCardLocateCardsByATRW}

// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED
// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED

   function SCardGetStatusChangeA(    hContext:       SCARDCONTEXT;
                                      dwTimeout:      LongInt;
     //                               var rgReaderStates: array of SCARD_READERSTATEA; - does not work - MKL
                                      rgReaderStates: LPSCARD_READERSTATE;
                                      cReaders:       LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardGetStatusChangeA}

// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED
// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED

   function SCardGetStatusChangeW(hContext: LongInt; dwTimeout: LongInt;
     //                               var rgReaderStates: array of SCARD_READERSTATEA; - does not work - MKL
                                      rgReaderStates: LPSCARD_READERSTATE;
                                  cReaders: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardGetStatusChangeW}
   function SCardCancel (hContext: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardCancel}
{$ENDIF}

//
////////////////////////////////////////////////////////////////////////////////
//
//  Card/Reader Communication Services
//
//      The following services provide means for communication with the card.
//

const
   SCARD_SHARE_EXCLUSIVE = 1;            // This application is not willing to share this
   {$EXTERNALSYM SCARD_SHARE_EXCLUSIVE}  // card with other applications.
   SCARD_SHARE_SHARED = 2;               // This application is willing to share this
   {$EXTERNALSYM SCARD_SHARE_SHARED}     // card with other applications.
   SCARD_SHARE_DIRECT = 3;               // This application demands direct control of
   {$EXTERNALSYM SCARD_SHARE_DIRECT}     // the reader, so it is not available to other
                                         // applications.

   SCARD_LEAVE_CARD = 0;                 // Don't do anything special on close
   {$EXTERNALSYM SCARD_LEAVE_CARD}
   SCARD_RESET_CARD = 1;                 // Reset the card on close
   {$EXTERNALSYM SCARD_RESET_CARD}
   SCARD_UNPOWER_CARD = 2;               // Power down the card on close
   {$EXTERNALSYM SCARD_UNPOWER_CARD}
   SCARD_EJECT_CARD = 3;                 // Eject the card on close
   {$EXTERNALSYM SCARD_EJECT_CARD}

{$IFDEF WinSCard_DYNLINK}
type
   TSCardConnectA = function (hContext: LongInt; szReader: LPStr; dwShareMode: LongInt; dwPreferredProtocols: LongInt;
                              var phCard: LongInt; pdwActiveProtocol: PDword): LongInt; stdcall;
   TSCardConnectW = function (hContext: LongInt; szReader: LPWStr; dwShareMode: LongInt; dwPreferredProtocols: LongInt;
                              var phCard: LongInt; pdwActiveProtocol: PDword): LongInt; stdcall;
   {$IFDEF UNICODE}
      TSCardConnect = TSCardConnectW;
   {$ELSE}
      TSCardConnect = TSCardConnectA;
   {$ENDIF}

   TSCardReconnect = function (hCard: LongInt; dwShareMode: LongInt; dwPreferredProtocols: LongInt;
                               dwInitialization: LongInt; var pdwActiveProtocol: LongInt): LongInt; stdcall;

   TSCardDisconnect = function (hCard: LongInt; dwDisposition: LongInt): LongInt; stdcall;

   TSCardBeginTransaction = function (hCard: LongInt): LongInt; stdcall;

   TSCardEndTransaction = function (hCard: LongInt; dwDisposition: LongInt): LongInt; stdcall;
{$ELSE}
   function SCardConnectA(hContext: LongInt; szReader: LPStr; dwShareMode: LongInt; dwPreferredProtocols: LongInt;
                          var phCard: LongInt; pdwActiveProtocol: PDword): LongInt; stdcall;
   {$EXTERNALSYM SCardConnectA}
   function SCardConnectW(hContext: LongInt; szReader: LPWStr; dwShareMode: LongInt; dwPreferredProtocols: LongInt;
                          var phCard: LongInt; pdwActiveProtocol: PDword): LongInt; stdcall;
   {$EXTERNALSYM SCardConnectW}

//   function SCardReconnect(hCard: LongInt; dwShareMode: LongInt; dwPreferredProtocols: LongInt;
//                           dwInitialization: LongInt; var pdwActiveProtocol: LongInt): LongInt; stdcall;
   function SCardReconnect(hCard: LongInt; dwShareMode: LongInt; dwPreferredProtocols: LongInt;
                           dwInitialization: LongInt; pdwActiveProtocol: PDword): LongInt; stdcall;
   {$EXTERNALSYM SCardReconnect}

   function SCardDisconnect(hCard: LongInt; dwDisposition: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardDisconnect}

   function SCardBeginTransaction(hCard: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardBeginTransaction}

   function SCardEndTransaction(hCard: LongInt; dwDisposition: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardEndTransaction}
{$ENDIF}

//
// NOTE:    This call corresponds to the PC/SC SCARDCOMM::Cancel routine,
//          terminating a blocked SCardBeginTransaction service.
//

//
// NOTE:    SCardState is an obsolete routine.  PC/SC has replaced it with
//          SCardStatus.
//

{$IFDEF WinSCard_DYNLINK}
type
   TSCardStatusA = function (hCard: LongInt; mszReaderNames: LPStr; var pcchReaderLen: LongInt; var pdwState: LongInt;
                             pdwProtocol: PDWord; pbAtr: PByte; var pcbAtrLen: LongInt): LongInt; stdcall;
   TSCardStatusW = function (hCard: LongInt; mszReaderNames: LPWStr; var pcchReaderLen: LongInt; var pdwState: LongInt;
                             pdwProtocol: PDWord; pbAtr: PByte; var pcbAtrLen: LongInt): LongInt; stdcall;
   {$IFDEF UNICODE}
      TSCardStatus = TSCardStatusW;
   {$ELSE}
      TSCardStatus = TSCardStatusA;
   {$ENDIF}

   TSCardTransmit = function (hCard: LongInt; pioSendPci: Pointer; pbSendBuffer: PByte;
                              dwSendLength: DWORD; pioRecvPci: Pointer; pbRecvBuffer: PByte;
                              pcbRecvLength: PDWord): LongInt; stdcall;
{$ELSE}
   function SCardStatusA(hCard: LongInt; mszReaderNames: LPStr; var pcchReaderLen: LongInt; var pdwState: LongInt;
                         pdwProtocol: PDWord; pbAtr: PByte; var pcbAtrLen: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardStatusA}
   function SCardStatusW(hCard: LongInt; mszReaderNames: LPWStr; var pcchReaderLen: LongInt; var pdwState: LongInt;
                         pdwProtocol: PDWord; pbAtr: PByte; var pcbAtrLen: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardStatusW}

   function SCardTransmit(hCard: LongInt; pioSendPci: Pointer; pbSendBuffer: PByte;
                          dwSendLength: DWORD; pioRecvPci: Pointer; pbRecvBuffer: PByte;
                          pcbRecvLength: PDWord): LongInt; stdcall;
   {$EXTERNALSYM SCardTransmit}
{$ENDIF}

//
////////////////////////////////////////////////////////////////////////////////
//
//  Reader Control Routines
//
//      The following services provide for direct, low-level manipulation of the
//      reader by the calling application allowing it control over the
//      attributes of the communications with the card.
//
{$IFDEF WinSCard_DYNLINK}
type
   TSCardControl = function (hCard: LongInt; dwControlCode: LongInt; var pvInBuffer: PByte; cbInBufferSize: LongInt;
                             var pvOutBuffer: PByte; cbOutBufferSize: LongInt;
                             var pcbBytesReturned: LongInt): LongInt; stdcall;

   TSCardGetAttrib = function (hCard: LongInt; dwAttrId: LongInt; var pbAttr: PByte; var pcbAttrLen: LongInt): LongInt; stdcall;
{$ELSE}
   function SCardControl(hCard: LongInt; dwControlCode: LongInt; var pvInBuffer: PByte; cbInBufferSize: LongInt;
                         var pvOutBuffer: PByte; cbOutBufferSize: LongInt;
                         var pcbBytesReturned: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardControl}

// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED
// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED

   function SCardGetAttrib(hCard: LongInt; dwAttrId: LongInt; pbAttr: PByte; pcbAttrLen: PDWord): LongInt; stdcall;
   {$EXTERNALSYM SCardGetAttrib}

// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED
// CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED CHANGED

{$ENDIF}

//
// NOTE:    The routine SCardGetAttrib's name differs from the PC/SC definition.
//          It should be:
//
//              extern WINSCARDAPI LONG WINAPI
//              SCardGetReaderCapabilities(
//                  IN SCARDHANDLE hCard,
//                  IN DWORD dwTag,
//                  OUT LPBYTE pbAttr,
//                  IN OUT LPDWORD pcbAttrLen);
//
//          Here's a work-around MACRO:
{$IFDEF WinSCard_DYNLINK}
type
   TSCardGetReaderCapabilities = TSCardGetAttrib;

   TSCardSetAttrib = function (hCard: LongInt; dwAttrId: LongInt; var pbAttr: PByte; cbAttrLen: LongInt): LongInt; stdcall;
{$ELSE}
   function SCardSetAttrib(hCard: LongInt; dwAttrId: LongInt; var pbAttr: PByte; cbAttrLen: LongInt): LongInt; stdcall;
   {$EXTERNALSYM SCardSetAttrib}
{$ENDIF}

//
// NOTE:    The routine SCardSetAttrib's name differs from the PC/SC definition.
//          It should be:
//
//              extern WINSCARDAPI LONG WINAPI
//              SCardSetReaderCapabilities(
//                  IN SCARDHANDLE hCard,
//                  IN DWORD dwTag,
//                  OUT LPBYTE pbAttr,
//                  IN OUT LPDWORD pcbAttrLen);
//
//          Here's a work-around MACRO:
{$IFDEF WinSCard_DYNLINK}
type
   TSCardSetReaderCapabilities = TSCardSetAttrib;
{$ENDIF}

//
////////////////////////////////////////////////////////////////////////////////
//
//  Smart Card Dialog definitions
//
//      The following section contains structures and  exported function
//      declarations for the Smart Card Common Dialog dialog.
//

// Defined constants
// Flags
const
   SC_DLG_MINIMAL_UI = $01;
   {$EXTERNALSYM SC_DLG_MINIMAL_UI}
   SC_DLG_NO_UI = $02;
   {$EXTERNALSYM SC_DLG_NO_UI}
   SC_DLG_FORCE_UI = $04;
   {$EXTERNALSYM SC_DLG_FORCE_UI}

   SCERR_NOCARDNAME = $4000;
   {$EXTERNALSYM SCERR_NOCARDNAME}
   SCERR_NOGUIDS = $8000;
   {$EXTERNALSYM SCERR_NOGUIDS}

type
   LPOCNCONNPROCA = function(hSCardContext: LongInt; hCard: LPStr; pvUserData: Pointer): DWORD; cdecl;
   {$EXTERNALSYM LPOCNCONNPROCA}
   LPOCNCONNPROCW = function(hSCardContext: LongInt; hCard: LPWStr; pvUserData: Pointer): DWORD; cdecl;
   {$EXTERNALSYM LPOCNCONNPROCW}
   {$IFDEF UNICODE}
      LPOCNCONNPROC = LPOCNCONNPROCW;
   {$ELSE}
      LPOCNCONNPROC = LPOCNCONNPROCA;
   {$ENDIF}
   {$EXTERNALSYM LPOCNCONNPROC}

   LPOCNCHKPROC = function(hContext: LongInt; hCard: LPStr; pvUserData: Pointer): Bool; cdecl;
   {$EXTERNALSYM LPOCNCHKPROC}
   LPOCNDSCPROC = procedure(hContext: LongInt; hCard: LPStr; pvUserData: Pointer); cdecl;
   {$EXTERNALSYM LPOCNDSCPROC}

//
// OPENCARD_SEARCH_CRITERIA: In order to specify a user-extended search,
// lpfnCheck must not be NULL.  Moreover, the connection to be made to the
// card before performing the callback must be indicated by either providing
// lpfnConnect and lpfnDisconnect OR by setting dwShareMode.
// If both the connection callbacks and dwShareMode are non-NULL, the callbacks
// will be used.
//

   POPENCARD_SEARCH_CRITERIAA = ^OPENCARD_SEARCH_CRITERIAA;
   {$EXTERNALSYM POPENCARD_SEARCH_CRITERIAA}
   LPOPENCARD_SEARCH_CRITERIAA = ^OPENCARD_SEARCH_CRITERIAA;
   {$EXTERNALSYM LPOPENCARD_SEARCH_CRITERIAA}
   OPENCARD_SEARCH_CRITERIAA = record
      dwStructSize: DWORD;
      lpstrGroupNames: LPSTR;        // OPTIONAL reader groups to include in
      nMaxGroupNames: DWORD;         //          search.  NULL defaults to
                                     //          SCard$DefaultReaders
      rgguidInterfaces: LPCGUID;     // OPTIONAL requested interfaces
      cguidInterfaces: DWORD;        //          supported by card's SSP
      lpstrCardNames: LPSTR;         // OPTIONAL requested card names; all cards w/
      nMaxCardNames: DWORD;          //          matching ATRs will be accepted
      lpfnCheck: LPOCNCHKPROC;       // OPTIONAL if NULL no user check will be performed.
      lpfnConnect: LPOCNCONNPROCA;   // OPTIONAL if lpfnConnect is provided,
      lpfnDisconnect: LPOCNDSCPROC;  //          lpfnDisconnect must also be set.
      pvUserData: Pointer;           // OPTIONAL parameter to callbacks
      dwShareMode: DWORD;            // OPTIONAL must be set if lpfnCheck is not null
      dwPreferredProtocols: DWORD;   // OPTIONAL
   end;
   {$EXTERNALSYM OPENCARD_SEARCH_CRITERIAA}

   POPENCARD_SEARCH_CRITERIAW = ^OPENCARD_SEARCH_CRITERIAW;
   {$EXTERNALSYM POPENCARD_SEARCH_CRITERIAW}
   LPOPENCARD_SEARCH_CRITERIAW = ^OPENCARD_SEARCH_CRITERIAW;
   {$EXTERNALSYM LPOPENCARD_SEARCH_CRITERIAW}
   OPENCARD_SEARCH_CRITERIAW = record
      dwStructSize: DWORD;
      lpstrGroupNames: LPWSTR;       // OPTIONAL reader groups to include in
      nMaxGroupNames: DWORD;         //          search.  NULL defaults to
                                     //          SCard$DefaultReaders
      rgguidInterfaces: LPCGUID;     // OPTIONAL requested interfaces
      cguidInterfaces: DWORD;        //          supported by card's SSP
      lpstrCardNames: LPWSTR;        // OPTIONAL requested card names; all cards w/
      nMaxCardNames: DWORD;          //          matching ATRs will be accepted
      lpfnCheck: LPOCNCHKPROC;       // OPTIONAL if NULL no user check will be performed.
      lpfnConnect: LPOCNCONNPROCA;   // OPTIONAL if lpfnConnect is provided,
      lpfnDisconnect: LPOCNDSCPROC;  //          lpfnDisconnect must also be set.
      pvUserData: Pointer;           // OPTIONAL parameter to callbacks
      dwShareMode: DWORD;            // OPTIONAL must be set if lpfnCheck is not null
      dwPreferredProtocols: DWORD;   // OPTIONAL
   end;
   {$EXTERNALSYM OPENCARD_SEARCH_CRITERIAW}

   {$IFDEF UNICODE}
      OPENCARD_SEARCH_CRITERIA = OPENCARD_SEARCH_CRITERIAW;
      POPENCARD_SEARCH_CRITERIA = POPENCARD_SEARCH_CRITERIAW;
      LPOPENCARD_SEARCH_CRITERIA = LPOPENCARD_SEARCH_CRITERIAW;
   {$ELSE}
      OPENCARD_SEARCH_CRITERIA = OPENCARD_SEARCH_CRITERIAA;
      POPENCARD_SEARCH_CRITERIA = POPENCARD_SEARCH_CRITERIAA;
      LPOPENCARD_SEARCH_CRITERIA = LPOPENCARD_SEARCH_CRITERIAA;
   {$ENDIF}
   {$EXTERNALSYM OPENCARD_SEARCH_CRITERIA}
   {$EXTERNALSYM POPENCARD_SEARCH_CRITERIA}
   {$EXTERNALSYM LPOPENCARD_SEARCH_CRITERIA}

//
// OPENCARDNAME_EX: used by SCardUIDlgSelectCard; replaces obsolete OPENCARDNAME
//
   POPENCARDNAME_EXA = ^OPENCARDNAME_EXA;
   {$EXTERNALSYM POPENCARDNAME_EXA}
   LPOPENCARDNAME_EXA = ^OPENCARDNAME_EXA;
   {$EXTERNALSYM LPOPENCARDNAME_EXA}
   OPENCARDNAME_EXA = record
      dwStructSize: DWORD;           // REQUIRED
      hSCardContext: SCARDCONTEXT;   // REQUIRED
      hwndOwner: HWND;               // OPTIONAL
      dwFlags: DWORD;                // OPTIONAL -- default is SC_DLG_MINIMAL_UI
      lpstrTitle: LPCSTR;            // OPTIONAL
      lpstrSearchDesc: LPCSTR;       // OPTIONAL (eg. "Please insert your  smart card.")
      hIcon: HICON;                  // OPTIONAL 32x32 icon for your brand insignia
      pOpenCardSearchCriteria: POPENCARD_SEARCH_CRITERIAA ; // OPTIONAL
      lpfnConnect: LPOCNCONNPROCA;   // OPTIONAL - performed on successful selection
      pvUserData: Pointer;           // OPTIONAL parameter to lpfnConnect
      dwShareMode: DWORD;            // OPTIONAL - if lpfnConnect is NULL, dwShareMode and
      dwPreferredProtocols: DWORD;   // OPTIONAL dwPreferredProtocols will be used to
                                     //          connect to the selected card
      lpstrRdr: LPSTR;               // REQUIRED [IN|OUT] Name of selected reader
      nMaxRdr: DWORD;                // REQUIRED [IN|OUT]
      lpstrCard: LPSTR;              // REQUIRED [IN|OUT] Name of selected card
      nMaxCard: DWORD;               // REQUIRED [IN|OUT]
      dwActiveProtocol: DWORD;       // [OUT] set only if dwShareMode not NULL
      hCardHandle: SCARDHANDLE;      // [OUT] set if a card connection was indicated
   end;
   {$EXTERNALSYM OPENCARDNAME_EXA}

   POPENCARDNAME_EXW = ^OPENCARDNAME_EXW;
   {$EXTERNALSYM POPENCARDNAME_EXW}
   LPOPENCARDNAME_EXW = ^OPENCARDNAME_EXW;
   {$EXTERNALSYM LPOPENCARDNAME_EXW}
   OPENCARDNAME_EXW = record
      dwStructSize: DWORD;           // REQUIRED
      hSCardContext: SCARDCONTEXT;   // REQUIRED
      hwndOwner: HWND;               // OPTIONAL
      dwFlags: DWORD;                // OPTIONAL -- default is SC_DLG_MINIMAL_UI
      lpstrTitle: LPCWSTR;           // OPTIONAL
      lpstrSearchDesc: LPCWSTR;      // OPTIONAL (eg. "Please insert your  smart card.")
      hIcon: HICON;                  // OPTIONAL 32x32 icon for your brand insignia
      pOpenCardSearchCriteria: POPENCARD_SEARCH_CRITERIAW ; // OPTIONAL
      lpfnConnect: LPOCNCONNPROCW;   // OPTIONAL - performed on successful selection
      pvUserData: Pointer;           // OPTIONAL parameter to lpfnConnect
      dwShareMode: DWORD;            // OPTIONAL - if lpfnConnect is NULL, dwShareMode and
      dwPreferredProtocols: DWORD;   // OPTIONAL dwPreferredProtocols will be used to
                                     //          connect to the selected card
      lpstrRdr: LPWSTR;              // REQUIRED [IN|OUT] Name of selected reader
      nMaxRdr: DWORD;                // REQUIRED [IN|OUT]
      lpstrCard: LPWSTR;             // REQUIRED [IN|OUT] Name of selected card
      nMaxCard: DWORD;               // REQUIRED [IN|OUT]
      dwActiveProtocol: DWORD;       // [OUT] set only if dwShareMode not NULL
      hCardHandle: SCARDHANDLE;      // [OUT] set if a card connection was indicated
   end;
   {$EXTERNALSYM OPENCARDNAME_EXW}

   {$IFDEF UNICODE}
      OPENCARDNAME_EX = OPENCARDNAME_EXW;
      POPENCARDNAME_EX = POPENCARDNAME_EXW;
      LPOPENCARDNAME_EX = LPOPENCARDNAME_EXW;
   {$ELSE}
      OPENCARDNAME_EX = OPENCARDNAME_EXA;
      POPENCARDNAME_EX = POPENCARDNAME_EXA;
      LPOPENCARDNAME_EX = LPOPENCARDNAME_EXA;
   {$ENDIF}
   {$EXTERNALSYM OPENCARDNAME_EX}
   {$EXTERNALSYM POPENCARDNAME_EX}
   {$EXTERNALSYM LPOPENCARDNAME_EX}

//
// SCardUIDlgSelectCard replaces GetOpenCardName
//
{$IFDEF WinSCard_DYNLINK}
type
   TSCardUIDlgSelectCardA = function(pDlgStruc: LPOPENCARDNAME_EXA): LongInt; stdcall;
   TSCardUIDlgSelectCardW = function(pDlgStruc: LPOPENCARDNAME_EXW): LongInt; stdcall;
   {$IFDEF UNICODE}
      TSCardUIDlgSelectCard = TSCardUIDlgSelectCardW;
   {$ELSE}
      TSCardUIDlgSelectCard = TSCardUIDlgSelectCardA;
   {$ENDIF}
{$ELSE}
   // These are not exported by the DLL no point defining them and causing errors
   // function SCardUIDlgSelectCardA(pDlgStruc: LPOPENCARDNAME_EXA): LongInt; stdcall;
   // function SCardUIDlgSelectCardW(pDlgStruc: LPOPENCARDNAME_EXW): LongInt; stdcall;
{$ENDIF}

//
// "Smart Card Common Dialog" definitions for backwards compatibility
//  with the Smart Card Base Services SDK version 1.0
//

type
   POPENCARDNAMEA = ^OPENCARDNAMEA;
   {$EXTERNALSYM POPENCARDNAMEA}
   LPOPENCARDNAMEA = ^OPENCARDNAMEA;
   {$EXTERNALSYM LPOPENCARDNAMEA}
   OPENCARDNAMEA = record
      dwStructSize: DWORD;
      hwndOwner: HWND;
      hSCardContext: SCARDCONTEXT;
      lpstrGroupNames: LPSTR;
      nMaxGroupNames: DWORD;
      lpstrCardNames: LPSTR;
      nMaxCardNames: DWORD;
      rgguidInterfaces: LPCGUID;
      cguidInterfaces: DWORD;
      lpstrRdr: LPSTR;
      nMaxRdr: DWORD;
      lpstrCard: LPSTR;
      nMaxCard: DWORD;
      lpstrTitle: LPCSTR;
      dwFlags: DWORD;
      pvUserData: Pointer;
      dwShareMode: DWORD;
      dwPreferredProtocols: DWORD;
      dwActiveProtocol: DWORD;
      lpfnConnect: LPOCNCONNPROCA;
      lpfnCheck: LPOCNCHKPROC;
      lpfnDisconnect: LPOCNDSCPROC;
      hCardHandle: SCARDHANDLE;
   end;
   {$EXTERNALSYM OPENCARDNAMEA}

   POPENCARDNAMEW = ^OPENCARDNAMEW;
   {$EXTERNALSYM POPENCARDNAMEW}
   LPOPENCARDNAMEW = ^OPENCARDNAMEW;
   {$EXTERNALSYM LPOPENCARDNAMEW}
   OPENCARDNAMEW = record
      dwStructSize: DWORD;
      hwndOwner: HWND;
      hSCardContext: SCARDCONTEXT;
      lpstrGroupNames: LPWSTR;
      nMaxGroupNames: DWORD;
      lpstrCardNames: LPWSTR;
      nMaxCardNames: DWORD;
      rgguidInterfaces: LPCGUID;
      cguidInterfaces: DWORD;
      lpstrRdr: LPWSTR;
      nMaxRdr: DWORD;
      lpstrCard: LPWSTR;
      nMaxCard: DWORD;
      lpstrTitle: LPCWSTR;
      dwFlags: DWORD;
      pvUserData: Pointer;
      dwShareMode: DWORD;
      dwPreferredProtocols: DWORD;
      dwActiveProtocol: DWORD;
      lpfnConnect: LPOCNCONNPROCW;
      lpfnCheck: LPOCNCHKPROC;
      lpfnDisconnect: LPOCNDSCPROC;
      hCardHandle: SCARDHANDLE;
   end;
   {$EXTERNALSYM OPENCARDNAMEW}

   {$IFDEF UNICODE}
      OPENCARDNAME = OPENCARDNAMEW;
      POPENCARDNAME = POPENCARDNAMEW;
      LPOPENCARDNAME = LPOPENCARDNAMEW;
   {$ELSE}
      OPENCARDNAME = OPENCARDNAMEA;
      POPENCARDNAME = POPENCARDNAMEA;
      LPOPENCARDNAME = LPOPENCARDNAMEA;
   {$ENDIF}
   {$EXTERNALSYM OPENCARDNAME}
   {$EXTERNALSYM POPENCARDNAME}
   {$EXTERNALSYM LPOPENCARDNAME}

{$IFDEF WinSCard_DYNLINK}
var
   SCardEstablishContext:          TSCardEstablishContext = nil;
   SCardReleaseContext:            TSCardReleaseContext = nil;
   SCardListReaderGroups:          TSCardListReaderGroups = nil;
   SCardListReaders:               TSCardListReaders = nil;
   SCardListCards:                 TSCardListCards = nil;
   SCardListInterfaces:            TSCardListInterfaces = nil;
   SCardGetProviderId:             TSCardGetProviderId = nil;
   SCardGetCardTypeProviderName:   TSCardGetCardTypeProviderName = nil;
   SCardIntroduceReaderGroup:      TSCardIntroduceReaderGroup = nil;
   SCardForgetReaderGroup:         TSCardForgetReaderGroup = nil;
   SCardIntroduceReader:           TSCardIntroduceReader = nil;
   SCardForgetReader:              TSCardForgetReader = nil;
   SCardAddReaderToGroup:          TSCardAddReaderToGroup = nil;
   SCardRemoveReaderFromGroup:     TSCardRemoveReaderFromGroup = nil;
   SCardIntroduceCardType:         TSCardIntroduceCardType = nil;
   SCardSetCardTypeProviderName:   TSCardSetCardTypeProviderName = nil;
   SCardForgetCardType:            TSCardForgetCardType = nil;
   SCardFreeMemory:                TSCardFreeMemory = nil;
   SCardLocateCards:               TSCardLocateCards = nil;
   SCardGetStatusChange:           TSCardGetStatusChange = nil;
   SCardCancel:                    TSCardCancel = nil;
   SCardConnect:                   TSCardConnect = nil;
   SCardReconnect:                 TSCardReconnect = nil;
   SCardDisconnect:                TSCardDisconnect = nil;
   SCardBeginTransaction:          TSCardBeginTransaction = nil;
   SCardEndTransaction:            TSCardEndTransaction = nil;
   SCardStatus:                    TSCardStatus = nil;
   SCardTransmit:                  TSCardTransmit = nil;
   SCardControl:                   TSCardControl = nil;
   SCardGetAttrib:                 TSCardGetAttrib = nil;
   SCardSetAttrib:                 TSCardSetAttrib = nil;
   SCardIsValidContext:            TSCardIsValidContext = nil;
   SCardLocateCardsByATR:          TSCardLocateCardsByATR = nil;
   SCardAccessStartedEvent:        TSCardAccessStartedEvent = nil;
   SCardReleaseStartedEvent:       TSCardReleaseStartedEvent = nil;
   bPCSCLoaded: Boolean;
   hWinscardDLL: THandle;

   { load PC/SC DLL, pass variable for handle to unload DLL later }
   function PCSCLoadDLL: Boolean;
   {$EXTERNALSYM PCSCLoadDLL}
   procedure PCSCUnloadDLL;
   {$EXTERNALSYM PCSCUnloadDLL}
{$ENDIF}

implementation

{$IFDEF WinSCard_DYNLINK}
procedure PCSCUnloadDLL;
begin
   if hWinscardDLL <> 0 then
      FreeLibrary(hWinscardDLL);
end;

function PCSCLoadDLL: Boolean;
begin

   if hWinscardDLL = 0 then
      hWinscardDLL := LoadLibrary('winscard.dll');
   if hWinscardDLL = 0 then
   begin
      messagebox(0,' LoadLibrary winscard.dll FAIL','',0);
      Result := False;
      Exit;
   end;

(* WindowsXP winscard.dll
   8/23/2001   0:00          93,184  winscard.dll
   Exports from WinSCard.dll
   63 exported name(s), 63 export addresse(s).  Ordinal base is 1.
    Ord. Hint Name
    ---- ---- ----
       1 0000 ClassInstall32
       2 0001 SCardAccessNewReaderEvent *New
       5 0002 SCardAccessStartedEvent
       6 0003 SCardAddReaderToGroupA
       7 0004 SCardAddReaderToGroupW
       8 0005 SCardBeginTransaction
       9 0006 SCardCancel
      10 0007 SCardConnectA
      11 0008 SCardConnectW
      12 0009 SCardControl
      13 000A SCardDisconnect
      14 000B SCardEndTransaction
      15 000C SCardEstablishContext
      16 000D SCardForgetCardTypeA
      17 000E SCardForgetCardTypeW
      18 000F SCardForgetReaderA
      19 0010 SCardForgetReaderGroupA
      20 0011 SCardForgetReaderGroupW
      21 0012 SCardForgetReaderW
      22 0013 SCardFreeMemory
      23 0014 SCardGetAttrib
      24 0015 SCardGetCardTypeProviderNameA
      25 0016 SCardGetCardTypeProviderNameW
      26 0017 SCardGetProviderIdA
      27 0018 SCardGetProviderIdW
      28 0019 SCardGetStatusChangeA
      29 001A SCardGetStatusChangeW
      30 001B SCardIntroduceCardTypeA
      31 001C SCardIntroduceCardTypeW
      32 001D SCardIntroduceReaderA
      33 001E SCardIntroduceReaderGroupA
      34 001F SCardIntroduceReaderGroupW
      35 0020 SCardIntroduceReaderW
      36 0021 SCardIsValidContext
      37 0022 SCardListCardsA
      38 0023 SCardListCardsW
      39 0024 SCardListInterfacesA
      40 0025 SCardListInterfacesW
      41 0026 SCardListReaderGroupsA
      42 0027 SCardListReaderGroupsW
      43 0028 SCardListReadersA
      44 0029 SCardListReadersW
      45 002A SCardLocateCardsA
      46 002B SCardLocateCardsByATRA
      47 002C SCardLocateCardsByATRW
      48 002D SCardLocateCardsW
      49 002E SCardReconnect
       3 002F SCardReleaseAllEvents *New
      50 0030 SCardReleaseContext
       4 0031 SCardReleaseNewReaderEvent *New
      51 0032 SCardReleaseStartedEvent
      52 0033 SCardRemoveReaderFromGroupA
      53 0034 SCardRemoveReaderFromGroupW
      54 0035 SCardSetAttrib
      55 0036 SCardSetCardTypeProviderNameA
      56 0037 SCardSetCardTypeProviderNameW
      57 0038 SCardState *New
      58 0039 SCardStatusA
      59 003A SCardStatusW
      60 003B SCardTransmit
      61 003C g_rgSCardRawPci
      62 003D g_rgSCardT0Pci
      63 003E g_rgSCardT1Pci
    *)

   @SCardEstablishContext        := GetProcAddress(hWinscardDLL, 'SCardEstablishContext');
   @SCardReleaseContext          := GetProcAddress(hWinscardDLL, 'SCardReleaseContext');
   @SCardListReaderGroups        := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardListReaderGroupsW'{$ELSE}'SCardListReaderGroupsA'{$ENDIF});
   @SCardListReaders             := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardListReadersW'{$ELSE}'SCardListReadersA'{$ENDIF});
   @SCardListCards               := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardListCardsW'{$ELSE}'SCardListCardsA'{$ENDIF});
   @SCardListInterfaces          := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardListInterfacesW'{$ELSE}'SCardListInterfacesALib'{$ENDIF}); {SCardListInterfacesALib - alib?}
   @SCardGetProviderId           := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardGetProviderIdW'{$ELSE}'SCardGetProviderIdA'{$ENDIF});
   @SCardGetCardTypeProviderName := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardGetCardTypeProviderNameW'{$ELSE}'SCardGetCardTypeProviderNameA'{$ENDIF});
   @SCardIntroduceReaderGroup    := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardIntroduceReaderGroupW'{$ELSE}'SCardIntroduceReaderGroupA'{$ENDIF});
   @SCardForgetReaderGroup       := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardForgetReaderGroupW'{$ELSE}'SCardForgetReaderGroupA'{$ENDIF});
   @SCardIntroduceReader         := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardIntroduceReaderW'{$ELSE}'SCardIntroduceReaderA'{$ENDIF});
   @SCardForgetReader            := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardForgetReaderW'{$ELSE}'SCardForgetReaderA'{$ENDIF});
   @SCardAddReaderToGroup        := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardAddReaderToGroupW'{$ELSE}'SCardAddReaderToGroupA'{$ENDIF});
   @SCardRemoveReaderFromGroup   := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardRemoveReaderFromGroupW'{$ELSE}'SCardRemoveReaderFromGroupA'{$ENDIF});
   @SCardIntroduceCardType       := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardIntroduceCardTypeW'{$ELSE}'SCardIntroduceCardTypeA'{$ENDIF});
   @SCardSetCardTypeProviderName := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardSetCardTypeProviderNameW'{$ELSE}'SCardSetCardTypeProviderNameA'{$ENDIF});
   @SCardForgetCardType          := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardForgetCardTypeW'{$ELSE}'SCardForgetCardTypeA'{$ENDIF});
   @SCardFreeMemory              := GetProcAddress(hWinscardDLL, 'SCardFreeMemory');
   @SCardLocateCards             := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardLocateCardsW'{$ELSE}'SCardLocateCardsA'{$ENDIF});
   @SCardGetStatusChange         := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardGetStatusChangeW'{$ELSE}'SCardGetStatusChangeA'{$ENDIF});
   @SCardCancel                  := GetProcAddress(hWinscardDLL, 'SCardCancel');
   @SCardConnect                 := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardConnectW'{$ELSE}'SCardConnectA'{$ENDIF});
   @SCardReconnect               := GetProcAddress(hWinscardDLL, 'SCardReconnect');
   @SCardDisconnect              := GetProcAddress(hWinscardDLL, 'SCardDisconnect');
   @SCardBeginTransaction        := GetProcAddress(hWinscardDLL, 'SCardBeginTransaction');
   @SCardEndTransaction          := GetProcAddress(hWinscardDLL, 'SCardEndTransaction');
   @SCardStatus                  := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardStatusW'{$ELSE}'SCardStatusA'{$ENDIF});
   @SCardTransmit                := GetProcAddress(hWinscardDLL, 'SCardTransmit');
   @SCardControl                 := GetProcAddress(hWinscardDLL, 'SCardControl');
   @SCardGetAttrib               := GetProcAddress(hWinscardDLL, 'SCardGetAttrib');
   @SCardSetAttrib               := GetProcAddress(hWinscardDLL, 'SCardSetAttrib');
   @SCardIsValidContext          := GetProcAddress(hWinscardDLL, 'SCardIsValidContext');
   @SCardLocateCardsByATR        := GetProcAddress(hWinscardDLL, {$IFDEF UNICODE}'SCardLocateCardsByATRW'{$ELSE}'SCardLocateCardsByATRA'{$ENDIF});
   @SCardAccessStartedEvent      := GetProcAddress(hWinscardDLL, 'SCardAccessStartedEvent');
   @SCardReleaseStartedEvent     := GetProcAddress(hWinscardDLL, 'SCardReleaseStartedEvent');

   Result := True;

end;
{$ELSE}
const
   WinSCardDLL = 'winscard.dll';

   function SCardEstablishContext;           external WinSCardDLL name 'SCardEstablishContext';
   function SCardReleaseContext;             external WinSCardDLL name 'SCardReleaseContext';
   function SCardListReaderGroupsW;          external WinSCardDLL name 'SCardListReaderGroupsW';
   function SCardListReaderGroupsA;          external WinSCardDLL name 'SCardListReaderGroupsA';
   function SCardListReadersW;               external WinSCardDLL name 'SCardListReadersW';
   function SCardListReadersA;               external WinSCardDLL name 'SCardListReadersA';
   function SCardListCardsW;                 external WinSCardDLL name 'SCardListCardsW';
   function SCardListCardsA;                 external WinSCardDLL name 'SCardListCardsA';
   function SCardListInterfacesW;            external WinSCardDLL name 'SCardListInterfacesW';
   function SCardListInterfacesA;            external WinSCardDLL name 'SCardListInterfacesA';
   function SCardGetProviderIdW;             external WinSCardDLL name 'SCardGetProviderIdW';
   function SCardGetProviderIdA;             external WinSCardDLL name 'SCardGetProviderIdA';
   function SCardGetCardTypeProviderNameW;   external WinSCardDLL name 'SCardGetCardTypeProviderNameW';
   function SCardGetCardTypeProviderNameA;   external WinSCardDLL name 'SCardGetCardTypeProviderNameA';
   function SCardIntroduceReaderGroupW;      external WinSCardDLL name 'SCardIntroduceReaderGroupW';
   function SCardIntroduceReaderGroupA;      external WinSCardDLL name 'SCardIntroduceReaderGroupA';
   function SCardForgetReaderGroupW;         external WinSCardDLL name 'SCardForgetReaderGroupW';
   function SCardForgetReaderGroupA;         external WinSCardDLL name 'SCardForgetReaderGroupA';
   function SCardIntroduceReaderW;           external WinSCardDLL name 'SCardIntroduceReaderW';
   function SCardIntroduceReaderA;           external WinSCardDLL name 'SCardIntroduceReaderA';
   function SCardForgetReaderW;              external WinSCardDLL name 'SCardForgetReaderW';
   function SCardForgetReaderA;              external WinSCardDLL name 'SCardForgetReaderA';
   function SCardAddReaderToGroupW;          external WinSCardDLL name 'SCardAddReaderToGroupW';
   function SCardAddReaderToGroupA;          external WinSCardDLL name 'SCardAddReaderToGroupA';
   function SCardRemoveReaderFromGroupW;     external WinSCardDLL name 'SCardRemoveReaderFromGroupW';
   function SCardRemoveReaderFromGroupA;     external WinSCardDLL name 'SCardRemoveReaderFromGroupA';
   function SCardIntroduceCardTypeW;         external WinSCardDLL name 'SCardIntroduceCardTypeW';
   function SCardIntroduceCardTypeA;         external WinSCardDLL name 'SCardIntroduceCardTypeA';
   function SCardSetCardTypeProviderNameW;   external WinSCardDLL name 'SCardSetCardTypeProviderNameW';
   function SCardSetCardTypeProviderNameA;   external WinSCardDLL name 'SCardSetCardTypeProviderNameA';
   function SCardForgetCardTypeW;            external WinSCardDLL name 'SCardForgetCardTypeW';
   function SCardForgetCardTypeA;            external WinSCardDLL name 'SCardForgetCardTypeA';
   function SCardFreeMemory;                 external WinSCardDLL name 'SCardFreeMemory';
   function SCardLocateCardsW;               external WinSCardDLL name 'SCardLocateCardsW';
   function SCardLocateCardsA;               external WinSCardDLL name 'SCardLocateCardsA';
   function SCardGetStatusChangeW;           external WinSCardDLL name 'SCardGetStatusChangeW';
   function SCardGetStatusChangeA;           external WinSCardDLL name 'SCardGetStatusChangeA';
   function SCardCancel;                     external WinSCardDLL name 'SCardCancel';
   function SCardConnectW;                   external WinSCardDLL name 'SCardConnectW';
   function SCardConnectA;                   external WinSCardDLL name 'SCardConnectA';
   function SCardReconnect;                  external WinSCardDLL name 'SCardReconnect';
   function SCardDisconnect;                 external WinSCardDLL name 'SCardDisconnect';
   function SCardBeginTransaction;           external WinSCardDLL name 'SCardBeginTransaction';
   function SCardEndTransaction;             external WinSCardDLL name 'SCardEndTransaction';
   function SCardStatusW;                    external WinSCardDLL name 'SCardStatusW';
   function SCardStatusA;                    external WinSCardDLL name 'SCardStatusA';
   function SCardTransmit;                   external WinSCardDLL name 'SCardTransmit';
   function SCardControl;                    external WinSCardDLL name 'SCardControl';
   function SCardGetAttrib;                  external WinSCardDLL name 'SCardGetAttrib';
   function SCardSetAttrib;                  external WinSCardDLL name 'SCardSetAttrib';
   function SCardIsValidContext;             external WinSCardDLL name 'SCardIsValidContext';
   function SCardLocateCardsByATRW;          external WinSCardDLL name 'SCardLocateCardsByATRW';
   function SCardLocateCardsByATRA;          external WinSCardDLL name 'SCardLocateCardsByATRA';
   function SCardAccessStartedEvent;         external WinSCardDLL name 'SCardAccessStartedEvent';
   function SCardReleaseStartedEvent;        external WinSCardDLL name 'SCardReleaseStartedEvent';
{$ENDIF}




(*************************************************************************************************************
 Scard Error Values
    ErrSCardInternal               ErrorCode = 0x80100001 /* An internal consistency check failed. */
    ErrSCardCancelled              ErrorCode = 0x80100002 /* The action was cancelled by an SCardCancel request. */
    ErrSCardInvalidHandle          ErrorCode = 0x80100003 /* The supplied handle was invalid. */
    ErrSCardInvalidParameter       ErrorCode = 0x80100004 /* One or more of the supplied parameters could not be properly interpreted. */
    ErrSCardInvalidTarget          ErrorCode = 0x80100005 /* Registry startup information is missing or invalid. */
    ErrSCardNoMemory               ErrorCode = 0x80100006 /* Not enough memory available to complete this command. */
    ErrSCardWaitedTooLong          ErrorCode = 0x80100007 /* An internal consistency timer has expired. */
    ErrSCardInsufficientBuffer     ErrorCode = 0x80100008 /* The data buffer to receive returned data is too small for the returned data. */
    ErrScardUnknownReader          ErrorCode = 0x80100009 /* The specified reader name is not recognized. */
    ErrSCardTimeout                ErrorCode = 0x8010000A /* The user-specified timeout value has expired. */
    ErrSCardSharingViolation       ErrorCode = 0x8010000B /* The smart card cannot be accessed because of other connections outstanding. */
    ErrSCardNoSmartCard            ErrorCode = 0x8010000C /* The operation requires a Smart Card, but no Smart Card is currently in the device. */
    ErrSCardUnknownCard            ErrorCode = 0x8010000D /* The specified smart card name is not recognized. */
    ErrSCardCannotDispose          ErrorCode = 0x8010000E /* The system could not dispose of the media in the requested manner. */
    ErrSCardProtoMismatch          ErrorCode = 0x8010000F /* The requested protocols are incompatible with the protocol currently in use with the smart card. */
    ErrSCardNotReady               ErrorCode = 0x80100010 /* The reader or smart card is not ready to accept commands. */
    ErrSCardInvalidValue           ErrorCode = 0x80100011 /* One or more of the supplied parameters values could not be properly interpreted. */
    ErrSCardSystemCancelled        ErrorCode = 0x80100012 /* The action was cancelled by the system, presumably to log off or shut down. */
    ErrSCardCommError              ErrorCode = 0x80100013 /* An internal communications error has been detected. */
    ErrScardUnknownError           ErrorCode = 0x80100014 /* An internal error has been detected, but the source is unknown. */
    ErrSCardInvalidATR             ErrorCode = 0x80100015 /* An ATR obtained from the registry is not a valid ATR string. */
    ErrSCardNotTransacted          ErrorCode = 0x80100016 /* An attempt was made to end a non-existent transaction. */
    ErrSCardReaderUnavailable      ErrorCode = 0x80100017 /* The specified reader is not currently available for use. */
    ErrSCardShutdown               ErrorCode = 0x80100018 /* The operation has been aborted to allow the server application to exit. */
    ErrSCardPCITooSmall            ErrorCode = 0x80100019 /* The PCI Receive buffer was too small. */
    ErrSCardReaderUnsupported      ErrorCode = 0x8010001A /* The reader driver does not meet minimal requirements for support. */
    ErrSCardDuplicateReader        ErrorCode = 0x8010001B /* The reader driver did not produce a unique reader name. */
    ErrSCardCardUnsupported        ErrorCode = 0x8010001C /* The smart card does not meet minimal requirements for support. */
    ErrScardNoService              ErrorCode = 0x8010001D /* The Smart card resource manager is not running. */
    ErrSCardServiceStopped         ErrorCode = 0x8010001E /* The Smart card resource manager has shut down. */
    ErrSCardUnexpected             ErrorCode = 0x8010001F /* An unexpected card error has occurred. */
    ErrSCardUnsupportedFeature     ErrorCode = 0x8010001F /* This smart card does not support the requested feature. */
    ErrSCardICCInstallation        ErrorCode = 0x80100020 /* No primary provider can be found for the smart card. */
    ErrSCardICCCreateOrder         ErrorCode = 0x80100021 /* The requested order of object creation is not supported. */
    ErrSCardDirNotFound            ErrorCode = 0x80100023 /* The identified directory does not exist in the smart card. */
    ErrSCardFileNotFound           ErrorCode = 0x80100024 /* The identified file does not exist in the smart card. */
    ErrSCardNoDir                  ErrorCode = 0x80100025 /* The supplied path does not represent a smart card directory. */
    ErrSCardNoFile                 ErrorCode = 0x80100026 /* The supplied path does not represent a smart card file. */
    ErrScardNoAccess               ErrorCode = 0x80100027 /* Access is denied to this file. */
    ErrSCardWriteTooMany           ErrorCode = 0x80100028 /* The smart card does not have enough memory to store the information. */
    ErrSCardBadSeek                ErrorCode = 0x80100029 /* There was an error trying to set the smart card file object pointer. */
    ErrSCardInvalidCHV             ErrorCode = 0x8010002A /* The supplied PIN is incorrect. */
    ErrSCardUnknownResMNG          ErrorCode = 0x8010002B /* An unrecognized error code was returned from a layered component. */
    ErrSCardNoSuchCertificate      ErrorCode = 0x8010002C /* The requested certificate does not exist. */
    ErrSCardCertificateUnavailable ErrorCode = 0x8010002D /* The requested certificate could not be obtained. */
    ErrSCardNoReadersAvailable     ErrorCode = 0x8010002E /* Cannot find a smart card reader. */
    ErrSCardCommDataLost           ErrorCode = 0x8010002F /* A communications error with the smart card has been detected. Retry the operation. */
    ErrScardNoKeyContainer         ErrorCode = 0x80100030 /* The requested key container does not exist on the smart card. */
    ErrSCardServerTooBusy          ErrorCode = 0x80100031 /* The Smart Card Resource Manager is too busy to complete this operation. */
    ErrSCardUnsupportedCard        ErrorCode = 0x80100065 /* The reader cannot communicate with the card, due to ATR string configuration conflicts. */
    ErrSCardUnresponsiveCard       ErrorCode = 0x80100066 /* The smart card is not responding to a reset. */
    ErrSCardUnpoweredCard          ErrorCode = 0x80100067 /* Power has been removed from the smart card, so that further communication is not possible. */
    ErrSCardResetCard              ErrorCode = 0x80100068 /* The smart card has been reset, so any shared state information is invalid. */
    ErrSCardRemovedCard            ErrorCode = 0x80100069 /* The smart card has been removed, so further communication is not possible. */
    ErrSCardSecurityViolation      ErrorCode = 0x8010006A /* Access was denied because of a security violation. */
    ErrSCardWrongCHV               ErrorCode = 0x8010006B /* The card cannot be accessed because the wrong PIN was presented. */
    ErrSCardCHVBlocked             ErrorCode = 0x8010006C /* The card cannot be accessed because the maximum number of PIN entry attempts has been reached. */
    ErrSCardEOF                    ErrorCode = 0x8010006D /* The end of the smart card file has been reached. */
    ErrSCardCancelledByUser        ErrorCode = 0x8010006E /* The user pressed "Cancel" on a Smart Card Selection Dialog. */
    ErrSCardCardNotAuthenticated   ErrorCode = 0x8010006F /* No PIN was presented to the smart card. */
****************************************************************************************************************************)

{$IFDEF WinSCard_DYNLINK}
initialization
   bPCSCLoaded := PCSCLoadDLL;

finalization
   PCSCUnloadDll;
{$ENDIF}

end.





