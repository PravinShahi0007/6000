unit HoleAuto_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 17244 $
// File generated on 27/04/2010 2:16:42 p.m. from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\Bruce\Documents\RAD Studio\Projects D2010\SCS\HoleAuto\035\HoleAuto (1)
// LIBID: {CA1E2FF8-CDAE-4EB9-B58C-91DD9F275EE7}
// LCID: 0
// Helpfile:
// HelpString: HoleAuto Library v2.36
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  HoleAutoMajorVersion = 2;
  HoleAutoMinorVersion = 36;

  LIBID_HoleAuto: TGUID = '{CA1E2FF8-CDAE-4EB9-B58C-91DD9F275EE7}';

  IID_IHoleFinder: TGUID = '{7546148D-9DA1-40F8-907E-116535CF7614}';
  IID_IHoleFinder2: TGUID = '{86C406C5-DA62-4696-91D8-8BA65BEFE626}';
  CLASS_HoleFinder: TGUID = '{A628F289-3E6E-499E-B937-37EECF1D249E}';
  CLASS_HoleFinder2: TGUID = '{29BA2B61-6177-4A1A-A611-CDA4BBDC357E}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IHoleFinder = interface;
  IHoleFinderDisp = dispinterface;
  IHoleFinder2 = interface;
  IHoleFinder2Disp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  HoleFinder = IHoleFinder;
  HoleFinder2 = IHoleFinder2;


// *********************************************************************//
// Interface: IHoleFinder
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7546148D-9DA1-40F8-907E-116535CF7614}
// *********************************************************************//
  IHoleFinder = interface(IDispatch)
    ['{7546148D-9DA1-40F8-907E-116535CF7614}']
    function InitJoining(fJointGap: Double; fMinEndDist: Double; fFlgHoleDist: Double;
                         fLipHoleDist: Double): HResult; safecall;
    function FindHole(var Trapezium1: OleVariant; var Trapezium2: OleVariant; out Hole: OleVariant): HResult; safecall;
    function Get_ShortBottomHorz: WordBool; safecall;
    procedure Set_ShortBottomHorz(Value: WordBool); safecall;
    property ShortBottomHorz: WordBool read Get_ShortBottomHorz write Set_ShortBottomHorz;
  end;

// *********************************************************************//
// DispIntf:  IHoleFinderDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {7546148D-9DA1-40F8-907E-116535CF7614}
// *********************************************************************//
  IHoleFinderDisp = dispinterface
    ['{7546148D-9DA1-40F8-907E-116535CF7614}']
    function InitJoining(fJointGap: Double; fMinEndDist: Double; fFlgHoleDist: Double;
                         fLipHoleDist: Double): HResult; dispid 1;
    function FindHole(var Trapezium1: OleVariant; var Trapezium2: OleVariant; out Hole: OleVariant): HResult; dispid 2;
    property ShortBottomHorz: WordBool dispid 3;
  end;

// *********************************************************************//
// Interface: IHoleFinder2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {86C406C5-DA62-4696-91D8-8BA65BEFE626}
// *********************************************************************//
  IHoleFinder2 = interface(IHoleFinder)
    ['{86C406C5-DA62-4696-91D8-8BA65BEFE626}']
    function Get_SettingsFile: PWideChar; safecall;
    procedure Set_SettingsFile(Value: PWideChar); safecall;
    function Find(var T1: OleVariant; var T2: OleVariant; out p: OleVariant): HResult; safecall;
    function Get_MajorVersion: Integer; safecall;
    function Get_MinorVersion: Integer; safecall;
    property SettingsFile: PWideChar read Get_SettingsFile write Set_SettingsFile;
    property MajorVersion: Integer read Get_MajorVersion;
    property MinorVersion: Integer read Get_MinorVersion;
  end;

// *********************************************************************//
// DispIntf:  IHoleFinder2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {86C406C5-DA62-4696-91D8-8BA65BEFE626}
// *********************************************************************//
  IHoleFinder2Disp = dispinterface
    ['{86C406C5-DA62-4696-91D8-8BA65BEFE626}']
    property SettingsFile: string dispid 201;
    function Find(var T1: OleVariant; var T2: OleVariant; out p: OleVariant): HResult; dispid 202;
    property MajorVersion: Integer readonly dispid 203;
    property MinorVersion: Integer readonly dispid 204;
    function InitJoining(fJointGap: Double; fMinEndDist: Double; fFlgHoleDist: Double;
                         fLipHoleDist: Double): HResult; dispid 1;
    function FindHole(var Trapezium1: OleVariant;
                      var Trapezium2: OleVariant;
                      out Hole: OleVariant): HResult; dispid 2;
    property ShortBottomHorz: WordBool dispid 3;
  end;

// *********************************************************************//
// The Class CoHoleFinder provides a Create and CreateRemote method to
// create instances of the default interface IHoleFinder exposed by
// the CoClass HoleFinder. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoHoleFinder = class
    class function Create: IHoleFinder;
    class function CreateRemote(const MachineName: string): IHoleFinder;
  end;

// *********************************************************************//
// The Class CoHoleFinder2 provides a Create and CreateRemote method to
// create instances of the default interface IHoleFinder2 exposed by
// the CoClass HoleFinder2. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoHoleFinder2 = class
    class function Create: IHoleFinder2;
    class function CreateRemote(const MachineName: string): IHoleFinder2;
  end;

implementation

uses ComObj;

class function CoHoleFinder.Create: IHoleFinder;
begin
  Result := CreateComObject(CLASS_HoleFinder) as IHoleFinder;
end;

class function CoHoleFinder.CreateRemote(const MachineName: string): IHoleFinder;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_HoleFinder) as IHoleFinder;
end;

class function CoHoleFinder2.Create: IHoleFinder2;
begin
  Result := CreateComObject(CLASS_HoleFinder2) as IHoleFinder2;
end;

class function CoHoleFinder2.CreateRemote(const MachineName: string): IHoleFinder2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_HoleFinder2) as IHoleFinder2;
end;

end.

