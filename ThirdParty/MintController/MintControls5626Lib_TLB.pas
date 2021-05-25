unit MintControls5626Lib_TLB;

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
// File generated on 12/19/2010 8:52:54 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\PROGRA~2\MINTMA~1\MID34F~1.OCX (1)
// LIBID: {01A1F601-2D64-4BBF-B76F-B68F33C86478}
// LCID: 0
// Helpfile: C:\PROGRA~2\MINTMA~1\MintControls.hlp
// HelpString: Mint Controls Build 5626
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// Errors:
//   Hint: Member 'In' of '_DMintControllerCtrl' changed to 'In_'
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  MintControls5626LibMajorVersion = 1;
  MintControls5626LibMinorVersion = 0;

  LIBID_MintControls5626Lib: TGUID = '{01A1F601-2D64-4BBF-B76F-B68F33C86478}';

  DIID__DMintControllerCtrl: TGUID = '{A34120BA-5643-4730-83C0-82F2D8DD416C}';
  DIID__DMintControllerEvents: TGUID = '{A8A56C0C-FF29-4C7D-9418-EA321AF9A467}';
  CLASS_MintController: TGUID = '{69CBC9D5-0C78-4CC8-A33C-67B332D3D6BD}';
  DIID__DCommandPromptCtrl: TGUID = '{03D90033-7F46-4D59-96B6-A4CE30437D5F}';
  DIID__DCommandPromptEvents: TGUID = '{402C4323-20C7-4FB4-9612-F1C4579336D9}';
  CLASS_MintCommandPrompt: TGUID = '{2E23F631-82D8-4C5C-A435-39667062B271}';
  DIID__DMintTerminal: TGUID = '{246FF878-870C-4AFD-9119-BA835A85C20E}';
  DIID__DMintTerminalEvents: TGUID = '{B023086C-06BC-4637-AB9D-FBCC4A6826DA}';
  CLASS_MintTerminal: TGUID = '{A157F972-3078-4679-8C9B-3C8AB49369A0}';
  DIID_ISinkForServerEvents: TGUID = '{66B03FD3-2A76-4CB2-9634-F6F44AC752DD}';
  CLASS_SinkForServerEvents: TGUID = '{36716D57-1751-474A-A8A6-5F78AA1ACA5A}';
  DIID_IOCXSerialEventSink: TGUID = '{3C3B44B3-1DD8-4AE9-888B-B7547499E9D5}';
  CLASS_OCXSerialEventSink: TGUID = '{35022C4C-587B-4EDE-A98B-2741D3345EE1}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum MTFactoryDefaultParamType
type
  MTFactoryDefaultParamType = TOleEnum;
const
  fdNormal = $00000000;
  fdAll = $00000001;
  fdSystem = $00000002;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _DMintControllerCtrl = dispinterface;
  _DMintControllerEvents = dispinterface;
  _DCommandPromptCtrl = dispinterface;
  _DCommandPromptEvents = dispinterface;
  _DMintTerminal = dispinterface;
  _DMintTerminalEvents = dispinterface;
  ISinkForServerEvents = dispinterface;
  IOCXSerialEventSink = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  MintController = _DMintControllerCtrl;
  MintCommandPrompt = _DCommandPromptCtrl;
  MintTerminal = _DMintTerminal;
  SinkForServerEvents = ISinkForServerEvents;
  OCXSerialEventSink = IOCXSerialEventSink;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}
  PInteger1 = ^Integer; {*}
  PSmallint1 = ^Smallint; {*}
  PWideString1 = ^WideString; {*}
  PSingle1 = ^Single; {*}
  PWordBool1 = ^WordBool; {*}
  PTDateTime1 = ^TDateTime; {*}


// *********************************************************************//
// DispIntf:  _DMintControllerCtrl
// Flags:     (4112) Hidden Dispatchable
// GUID:      {A34120BA-5643-4730-83C0-82F2D8DD416C}
// *********************************************************************//
  _DMintControllerCtrl = dispinterface
    ['{A34120BA-5643-4730-83C0-82F2D8DD416C}']
    procedure DoLocate(nTerminalID: Integer; nColumn: Smallint; nRow: Smallint); dispid 179;
    procedure DoPrint(nTermID: Integer; const str: WideString); dispid 195;
    procedure DoUpdateEPLFirmware(const sFilename: WideString); dispid 211;
    procedure DoMintCommandEx(nCommand: Smallint; vParam: OleVariant); dispid 182;
    procedure DoMintBreak; dispid 180;
    procedure DoKnife(nAxis: Smallint); dispid 178;
    procedure DoUpdateBootloader(const bstrBootloader: WideString); dispid 209;
    procedure DoUpdateFirmwareAtSpeed(const szFilename: WideString; nSpeed: Integer); dispid 213;
    procedure DoUpdatePLXEEPROM(const lpszFile: WideString); dispid 217;
    procedure DoUpdateFirmware(const szFilename: WideString); dispid 212;
    procedure DoUpdateCommsFirmware(const szFilename: WideString); dispid 210;
    procedure DoSystemDefaults; dispid 208;
    procedure DoMintCommand(nCommand: Smallint); dispid 181;
    procedure DoParameterSave; dispid 190;
    procedure DoParameterTableDownload(const lpszFile: WideString); dispid 191;
    procedure DoMintFileDownload(const szFilename: WideString); dispid 183;
    procedure DoPLCDefault(nLevel: Smallint); dispid 193;
    procedure DoPopRedirect; dispid 194;
    procedure DoParameterTableUpload(const lpszFile: WideString); dispid 192;
    procedure DoGo3(nAxis1: Smallint; nAxis2: Smallint; nAxis3: Smallint); dispid 172;
    procedure DoGo4(nAxis1: Smallint; nAxis2: Smallint; nAxis3: Smallint; nAxis4: Smallint); dispid 173;
    procedure DoInstallMintSystemFile(const szFilename: WideString); dispid 177;
    procedure DoH2ParameterTableCloneRestore(const sFilename: WideString); dispid 175;
    procedure DoInitCompilerInfo; dispid 176;
    procedure DoH2ParameterTableCloneSave(const sFilename: WideString); dispid 174;
    procedure DoWait(lTime: Integer); dispid 218;
    procedure DoCaptureTrigger; dispid 139;
    procedure DoClearErrorLog; dispid 140;
    procedure DoCaptureChannelUpload(nChannel: Smallint; var pvData: OleVariant; nSize: Smallint); dispid 138;
    procedure DoResetAll; dispid 202;
    procedure DoSerialClearError(var plError: Integer); dispid 203;
    procedure DoGo2(nAxis1: Smallint; nAxis2: Smallint); dispid 171;
    procedure DoControllerReset; dispid 145;
    procedure DoDataFileDownload(const lpszFile: WideString); dispid 146;
    procedure DoCompRefLogReset; dispid 144;
    procedure DoCancel(nAxis: Smallint); dispid 136;
    procedure DoCancelAll; dispid 137;
    procedure DoCls(nTerminalID: Integer); dispid 141;
    procedure DoSerialClearReceiveBuffer; dispid 204;
    procedure DoSymbolTableUpload(const szFilename: WideString); dispid 207;
    procedure DoRemotePDOOut(nBus: Smallint; lCOBID: Integer; nPDOLength: Smallint; 
                             nBank0Data: Integer; nBank1Data: Integer); dispid 199;
    procedure DoRemoteReset(nCANBus: Smallint; nNodeId: Smallint); dispid 200;
    procedure DoUpdateLanguagePack(const sFilename: WideString); dispid 216;
    procedure DoUpdateAndProgramFirmware(const bstrFirmware: WideString; nSpeed: Integer; 
                                         nMinBuildNumber: Smallint); dispid 214;
    procedure DoUpdateFPGA(const szFilename: WideString); dispid 215;
    procedure DoReset(nAxis: Smallint); dispid 201;
    procedure DoSerialClearTransmitBuffer; dispid 205;
    procedure DoStop(nAxis: Smallint); dispid 206;
    procedure DoPushRedirect(nBus: Integer; nNode: Integer); dispid 198;
    procedure DoProcessorReset; dispid 196;
    procedure DoProcessorResetParam(nParameter: Smallint); dispid 197;
    property AccelSensorKInt[nAxis: Smallint]: Single dispid 403;
    property AccelSensorKProp[nAxis: Smallint]: Single dispid 404;
    property AccelScaleUnits[nAxis: Smallint]: WideString dispid 399;
    property AccelSensorEnable[nAxis: Smallint]: WordBool dispid 401;
    property ADCErrorMode[nAxis: Smallint]: Smallint dispid 421;
    property ADCError[nAxis: Smallint]: Integer readonly dispid 420;
    property AccelSensorFilterFreq[nAxis: Smallint]: Single dispid 402;
    property AccelSensorVelErrorFatal[nAxis: Smallint]: Single dispid 411;
    property AccelSensorDelay[nAxis: Smallint]: Smallint dispid 400;
    property AccelSensorScale[nAxis: Smallint]: Single dispid 407;
    property AccelSensorVelError[nAxis: Smallint]: Single readonly dispid 410;
    property AccelSensorOffset[nAxis: Smallint]: Single dispid 406;
    property AccelSensorMode[nAxis: Smallint]: Smallint dispid 405;
    property AccelSensorVel[nAxis: Smallint]: Single readonly dispid 409;
    property AccelSensorType[nAxis: Smallint]: Smallint dispid 408;
    property ADCDeadbandOffset[nChannel: Smallint]: Single dispid 419;
    property ADCDeadband[nChannel: Smallint]: Single dispid 417;
    property ActiveEventCodes[nEvent: Smallint]: OleVariant readonly dispid 415;
    property ADC[nChannel: Smallint]: Single readonly dispid 416;
    property AccelTimeMax[nAxis: Smallint]: Integer dispid 414;
    property ADCDeadbandHysteresis[nChannel: Smallint]: Single dispid 418;
    procedure DoMintFileUpload(const szFilename: WideString); dispid 184;
    procedure DoMintRun; dispid 185;
    procedure DoNVRAMUpload(const lpszFile: WideString); dispid 189;
    procedure DoNodeScan(nCANBus: Smallint; nNode: Smallint); dispid 187;
    procedure DoNVRAMDownload(const lpszFile: WideString); dispid 188;
    procedure DoMultipleCommandsBegin; dispid 186;
    property AccelSensorVelErrorMode[nAxis: Smallint]: Smallint dispid 412;
    property ADCMax[nChannel: Smallint]: Single dispid 424;
    property ADCGain[nChannel: Smallint]: Single dispid 423;
    property ADCFilter[nChannel: Smallint]: Single dispid 422;
    property AccelTime[nAxis: Smallint]: Integer dispid 413;
    procedure DoCompileMintProgram(const bstrSource: WideString; const bstrDest: WideString; 
                                   nCompilerFlags: Integer); dispid 142;
    procedure SetControllerProdInfo(const lpszControllerType: WideString; 
                                    const lpszControllerVersion: WideString; 
                                    const lpszSerialNumber: WideString; nFuncRev: Smallint; 
                                    nBoardType: Smallint; nPowerCycles: Integer; nNoAxes: Smallint; 
                                    nExpCards: Smallint); dispid 312;
    procedure GetCPLDInfo(nBoard: Smallint; var pnDecodeCPLD: Smallint; var pnIOCPLD: Smallint; 
                          var parrASIC: OleVariant); dispid 313;
    procedure GetControllerProdInfo(var pszType: WideString; var pszVersion: WideString; 
                                    var pszSerial: WideString; var pnFnRev: Smallint; 
                                    var pnBoardType: Smallint; var plPowerCycles: Integer; 
                                    var pnAxes: Smallint; var pnExpCards: Smallint); dispid 311;
    procedure GetCommsRead(nAddress: Smallint; var pfValue: Single); dispid 303;
    procedure SetCommsWrite(nAddress: Smallint; fValue: Single); dispid 304;
    procedure SetCommsWriteMultipleHCP2(nNode: Smallint; nAddress: Smallint; vValues: OleVariant); dispid 308;
    procedure CamTable(nAxis: Smallint; fPosArray: OleVariant; fLengthArray: OleVariant); dispid 294;
    procedure GetCapturedData(const sFilename: WideString; bExtrapolateFollowingError: WordBool; 
                              bExtrapolateVelocity: WordBool; bShowProgress: WordBool); dispid 295;
    procedure CamSegment(nAxis: Smallint; nTable: Smallint; nStartSegment: Integer; 
                         fSegmentArray: OleVariant); dispid 293;
    procedure GetCompRefCalcs(var pnParamA: Smallint; var pnParamB: Smallint; var pulARaw: Integer; 
                              var pfA: Single; var pfAGain: Single; var pfAFunction: Single; 
                              var plBRaw: Integer; var pfB: Single; var pfBGain: Single; 
                              var pfBFunction: Single; var pfCOperator: Single; 
                              var pfCFunction: Single); dispid 309;
    procedure GetCompRefLog(var pnParamA: Smallint; var pnParamB: Smallint; var pfCRMax: Single; 
                            var pfMaxALog: Single; var pfMaxBLog: Single; var pfCRMin: Single; 
                            var pfMinALog: Single; var pfMinBLog: Single); dispid 310;
    procedure GetCommsMapList(nIndex: Smallint; var pnMode: Smallint; var pnParameter: Smallint; 
                              var pstrName: WideString); dispid 302;
    procedure SetCommsWriteMultiple(nAddress: Smallint; fValues: OleVariant); dispid 305;
    procedure SetAbsEncoderLinearMotorInfo(nAxis: Smallint; const bstrCatalogNumber: WideString; 
                                           const bstrSpecNumber: WideString; 
                                           const bstrManufactureDate: WideString; 
                                           fMotorRatedCurrent: Single; fMotorPeakCurrent: Single; 
                                           fMotorPeakDuration: Single; fMotorFlux: Single; 
                                           fStatorResistance: Single; fStatorInductance: Single; 
                                           fMaxLinearSpeed: Single; fMotorPolePitch: Single; 
                                           fInertia: Single; fDamping: Single); dispid 272;
    procedure GetAPIDefnTableForController(bForceUpload: WordBool; var pbstrPath: WideString); dispid 276;
    procedure GetAPIValueEx(nTable: Smallint; nFamily: Smallint; nIndex: Smallint; 
                            vArgs: OleVariant; var pvCurrentValue: OleVariant; 
                            var pvMin: OleVariant; var pvMax: OleVariant; 
                            var pvDefault: OleVariant; var psUnits: WideString; 
                            var pnDataType: Smallint); dispid 277;
    procedure SetVirtualControllerLink; dispid 269;
    procedure SetUSBControllerLink(nNode: Smallint); dispid 267;
    procedure SetUSBDeviceLink(const bstrLinkName: WideString); dispid 268;
    procedure GetBusProcessDataTelegram(nBus: Smallint; bIn: WordBool; var pnControlWord: Integer; 
                                        var pvRawData: OleVariant; var pvFloatData: OleVariant); dispid 290;
    procedure GetCommsReadHCP2(nNode: Smallint; nAddress: Smallint; var pfValue: Single); dispid 306;
    procedure SetCommsWriteHCP2(nNode: Smallint; nAddress: Smallint; fValue: Single); dispid 307;
    procedure SetAbsEncoderRotaryMotorInfo(nAxis: Smallint; const strCatalogNumber: WideString; 
                                           const strSpecNumber: WideString; 
                                           const strManufactureDate: WideString; 
                                           fMotorRatedCurrent: Single; fMotorPeakCurrent: Single; 
                                           fMotorPeakDuration: Single; fMotorFlux: Single; 
                                           fStatorResistance: Single; fStatorInductance: Single; 
                                           nMaxRotarySpeed: Smallint; nMotorPoles: Smallint; 
                                           fInertia: Single; fDamping: Single); dispid 275;
    procedure GetAbsEncoderRotaryInfo(nAxis: Smallint; var pnFeedbackType: Smallint; 
                                      var pbstrSerialNumber: WideString; 
                                      var pbstrProgramVersion: WideString; 
                                      var pbstrPartNumber: WideString; var pnTypeNumber: Smallint; 
                                      var plAbsCountsPerRev: Integer; var pnCyclesPerRev: Smallint; 
                                      var pnMaxRotarySpeed: Smallint; var pnAbsCountBits: Smallint; 
                                      var plMinCountsPerRev: Integer; 
                                      var plMaxCountsPerRev: Integer; var pnNumTurns: Smallint); dispid 273;
    procedure GetAbsEncoderRotaryMotorInfo(nAxis: Smallint; var pbstrCatalogNumber: WideString; 
                                           var pbstrSpecNumber: WideString; 
                                           var pbstrManufactureDate: WideString; 
                                           var pfMotorRatedCurrent: Single; 
                                           var pfMotorPeakCurrent: Single; 
                                           var pfMotorPeakDuration: Single; 
                                           var pfMotorFlux: Single; var pfStatorResistance: Single; 
                                           var pfStatorInductance: Single; 
                                           var pnMaxRotarySpeed: Smallint; 
                                           var pnMotorPoles: Smallint; var pfInertia: Single; 
                                           var pfDamping: Single); dispid 274;
    procedure SetBusReceiveTelegram(nBus: Smallint; nCountWords: Smallint; vData: OleVariant); dispid 291;
    procedure SetControllerTarget(nTarget: Smallint); dispid 239;
    procedure InstallUnknownEventHandler(bInstall: WordBool); dispid 237;
    procedure InstallUSBDeviceChangedHandler(hWnd: Integer; var phNotification: Integer); dispid 238;
    procedure InstallTimerEventHandler(bInstall: WordBool); dispid 236;
    procedure SetDSPControllerLink(nNode: Smallint; nPort: Smallint; lBaudRate: Integer; 
                                   bOpenPort: WordBool); dispid 240;
    procedure SetEthernetControllerLink(const sLinkName: WideString); dispid 241;
    procedure InstallBusMessageEventHandler(bInstall: WordBool); dispid 221;
    procedure InstallAxisIdleEventHandler(bInstall: WordBool); dispid 219;
    procedure InstallBusEventHandler(bInstall: WordBool); dispid 220;
    procedure InstallNetDataEventHandler(bInstall: WordBool); dispid 230;
    procedure InstallCommsEventHandler(bInstall: WordBool); dispid 222;
    procedure InstallDPREventHandler(bInstall: WordBool); dispid 223;
    procedure InstallSerialReceiveEventHandler(bInstall: WordBool); dispid 232;
    procedure GetCommsMapInfo(var pnSize: Smallint; var pnBase: Smallint; var pnChannels: Smallint); dispid 301;
    procedure CircleA(nXAxis: Smallint; nYAxis: Smallint; fXCentre: Single; fYCentre: Single; 
                      fAngle: Single); dispid 299;
    procedure GetCaptureModeParameterObject(nChannel: Smallint; var pnBus: Smallint; 
                                            var pnNode: Smallint; var pnIndex: Smallint; 
                                            var pnSubIndex: Smallint; var pnType: Smallint); dispid 297;
    procedure CamBoxData(nCamBox: Smallint; nOutput: Smallint; nSource: Smallint; 
                         nChannel: Smallint; nTime: Smallint; newValue: OleVariant); dispid 292;
    procedure GetCaptureInfo(var pnNumPoints: Smallint; var pnFirstElement: Smallint); dispid 296;
    procedure CircleR(nXAxis: Smallint; nYAxis: Smallint; fXCentre: Single; fYCentre: Single; 
                      fAngle: Single); dispid 300;
    procedure InstallTerminalReceiveEventHandler(bInstall: WordBool); dispid 235;
    procedure InstallStopEventHandler(bInstall: WordBool); dispid 233;
    procedure InstallResetEventHandler(bInstall: WordBool); dispid 231;
    procedure SetCaptureModeParameterObject(nChannel: Smallint; nBus: Smallint; nNode: Smallint; 
                                            nIndex: Smallint; nSubIndex: Smallint; nType: Smallint); dispid 298;
    procedure SetSerialControllerLink(nType: Smallint; nNode: Smallint; nPort: Smallint; 
                                      lBaudRate: Integer; bOpenPort: WordBool); dispid 266;
    procedure InstallStopSwitchEventHandler(bInstall: WordBool); dispid 234;
    procedure DoFactoryDefaults; dispid 162;
    procedure DoEventPend(nEventType: Smallint; nEventData1: Integer; nEventData2: Integer); dispid 160;
    procedure DoEventUnPend(nEventType: Smallint; nEventData1: Integer; nEventData2: Integer); dispid 161;
    procedure DoDataFileUpload(const lpszFile: WideString; bArraysOnly: WordBool); dispid 147;
    procedure DoFactoryDefaultsParam(nType: Smallint); dispid 163;
    procedure DoFileDelete(const sFilename: WideString); dispid 164;
    procedure DoFileUpload(const sSourceName: WideString; nType: Smallint; 
                           const sDestPath: WideString); dispid 168;
    procedure DoFileSystemDownload(const lpszSource: WideString); dispid 166;
    procedure DoFileSystemUpload(const lpszDest: WideString); dispid 167;
    procedure DoFileDownload(const sSourcePath: WideString; const sDestName: WideString; 
                             nDestType: Smallint); dispid 165;
    procedure DoGo(nNumberOfAxes: Smallint; nAxisArray: OleVariant); dispid 169;
    procedure DoGo1(nAxis1: Smallint); dispid 170;
    procedure DoAutotune(nAxis: Smallint; nOp: Smallint); dispid 131;
    procedure DoAPIValueTableUpload(nTable: Smallint; const lpszFile: WideString); dispid 128;
    procedure DoAPIDefinitionTableUpload(const szFilename: WideString); dispid 126;
    procedure DoAbort; dispid 124;
    procedure DoCompileMintProgramOffline(const bstrSource: WideString; const bstrDest: WideString; 
                                          nTarget: Smallint; nCompilerVersion: Smallint; 
                                          const bstrSymbolTable: WideString; nCompileFlags: Integer); dispid 143;
    procedure DoCANBusReset(nCANBus: Smallint); dispid 135;
    procedure DoAPIValueTableDownload(nTable: Smallint; const lpszFile: WideString); dispid 127;
    procedure DoCamPhase(nAxis: Smallint; nIndex: Smallint; nSegments: Smallint; fdeltaMSD: Single); dispid 134;
    procedure DoAutotuneAbort; dispid 132;
    procedure DoAPIValueTableUploadPartial(nTable: Smallint; const lpszAPIDefnTable: WideString; 
                                           const lpszOutputFile: WideString); dispid 130;
    procedure DoADCOffsetTrim(nChannel: Smallint); dispid 125;
    procedure DoAPIValueTableUploadCSV(nTable: Smallint; const sFilename: WideString); dispid 129;
    procedure DoBusReset(nBus: Smallint); dispid 133;
    procedure DoErrorClear(nGroup: Smallint; nData: Integer); dispid 159;
    procedure GetBusMuxCycleConfig(nBus: Smallint; nNode: Smallint; var pnMuxRatio: Smallint; 
                                   var pvNodes: OleVariant); dispid 284;
    procedure GetBusProcessDataInfo(nBusID: Smallint; bIn: WordBool; var pnCountModes: Smallint; 
                                    var pnCountChannels: Smallint); dispid 288;
    procedure GetBusProcessDataList(nBus: Smallint; bIn: WordBool; nIndex: Smallint; 
                                    var pnMode: Smallint; var pnParam: Smallint; 
                                    var pstrName: WideString); dispid 289;
    procedure Blend(nAxis: Smallint); dispid 281;
    procedure SetAsyncError(lPresent: Integer; lMisc: Integer; lAxisErrorArray: OleVariant; 
                            lAxisWarningArray: OleVariant); dispid 279;
    procedure GetAutotuneParamLimits(nParam: Smallint; var pfDefault: Single; var pfMin: Single; 
                                     var pfMax: Single); dispid 280;
    procedure GetAsyncError(var plPresent: Integer; var plMisc: Integer; 
                            var plAxisErrorArray: OleVariant; var plAxisWarningArray: OleVariant); dispid 278;
    procedure GetAbsEncoderLinearInfo(nAxis: Smallint; var pnFeedbackType: Smallint; 
                                      var pbstrSerialNumber: WideString; 
                                      var pbstrProgramVersion: WideString; 
                                      var pbstrPartNumber: WideString; var pnTypeNumber: Smallint; 
                                      var plAbsLinearResolution: Integer; 
                                      var plLinearCycleLength: Integer; 
                                      var plMaxLinearSpeed: Integer; var pnAbsCountBits: Smallint; 
                                      var plMinLinearResolution: Integer; 
                                      var plMaxLinearResolution: Integer); dispid 270;
    procedure GetAbsEncoderLinearMotorInfo(nAxis: Smallint; var pbstrCatalogNumber: WideString; 
                                           var pbstrSpecNumber: WideString; 
                                           var pbstrManufactureDate: WideString; 
                                           var pfMotorRatedCurrent: Single; 
                                           var pfMotorPeakCurrent: Single; 
                                           var pfMotorPeakDuration: Single; 
                                           var pfMotorFlux: Single; var pfStatorResistance: Single; 
                                           var pfStatorInductance: Single; 
                                           var pfMaxLinearSpeed: Single; 
                                           var pfMotorPolePitch: Single; var pfInertia: Single; 
                                           var pfDamping: Single); dispid 271;
    procedure SetBusPDOMapConfig(nBus: Smallint; nNode: Smallint; bIn: WordBool; 
                                 nPeerNode: Smallint; nStartSlot: Smallint; nEndSlot: Smallint); dispid 287;
    procedure SetBusMuxCycleConfig(nBus: Smallint; nNode: Smallint; nMuxRatio: Smallint; 
                                   vNodes: OleVariant); dispid 285;
    procedure GetBusPDOMapConfig(nBus: Smallint; nNode: Smallint; bIn: WordBool; 
                                 nPeerNode: Smallint; var pnStartSlot: Smallint; 
                                 var pnEndSlot: Smallint); dispid 286;
    procedure GetBusMessageInfo(nBus: Smallint; var pnTime: Integer; var pnIdentifier: Smallint; 
                                var pvData: OleVariant); dispid 283;
    procedure DoDefault(nAxis: Smallint); dispid 148;
    procedure DoDefaultAll; dispid 149;
    procedure DoDownloadMintSystemFile(const strName: WideString); dispid 153;
    procedure DoDeviceClose; dispid 151;
    procedure DoDeviceOpen; dispid 152;
    procedure DoDeleteDataObjects; dispid 150;
    procedure DoDPREvent(nCode: Smallint); dispid 154;
    procedure DoDriveMacroDownload(const lpszFile: WideString); dispid 155;
    procedure GetBusCommandTelegram(nBus: Smallint; var pnRXControlWord: Integer; 
                                    var pnRXDataWord: Integer; var pfRXData: Single; 
                                    var pnTXControlWord: Integer; var pnTXDataWord: Integer; 
                                    var pfTXData: Single); dispid 282;
    procedure DoDriveMacroUpload(const sFilename: WideString); dispid 157;
    procedure DoEEPROMUpload(nDeviceID: Smallint; const sFilename: WideString); dispid 158;
    procedure DoDriveMacroSourceUpload(const lpszFile: WideString; nFlags: Integer); dispid 156;
    procedure mmSetPWMPolarity(nNodeId: Smallint; nPolarity: Smallint); dispid 383;
    procedure mmSetBiDirectionalMotor(nNodeId: Smallint; nMotor: Smallint; nDirection: Smallint; 
                                      nOnTime: Integer; bEnable: WordBool); dispid 384;
    procedure mmGetPWMPolarity(nNodeId: Smallint; var pnPolarity: Smallint); dispid 382;
    procedure mmGetPWMErrorTime(nNodeId: Smallint; var pnErrorTime: Integer); dispid 374;
    procedure mmSetPWMErrorTime(nNodeId: Smallint; nErrorTime: Integer); dispid 375;
    procedure mmSetPWMOnTime(nNodeId: Smallint; nChannel: Smallint; nOnTime: Integer); dispid 379;
    procedure VectorR(nNumberOfAxes: Smallint; nAxesArray: OleVariant; fPosArray: OleVariant); dispid 365;
    procedure debugGetBurnInParameter(nParam: Smallint; var pfValue: Single); dispid 366;
    procedure VectorA(nNumberOfAxes: Smallint; nAxesArray: OleVariant; fPosArray: OleVariant); dispid 364;
    procedure mmGetPWMPeriod(nNodeId: Smallint; var pnPeriod: Integer); dispid 380;
    procedure mmSetPWMPeriod(nNodeId: Smallint; nPeriod: Integer); dispid 381;
    procedure mmSetPWMErrors(nNodeId: Smallint; nErrors: Integer); dispid 373;
    procedure mmGetPWMMode(nNodeId: Smallint; var pnMode: Smallint); dispid 376;
    property RelayOut[nBank: Smallint]: Integer dispid 1007;
    property RelayOutX[nRelay: Smallint]: WordBool dispid 1009;
    property RemoteADC[nCANBus: Smallint; nNode: Smallint; nChannel: Smallint]: Single readonly dispid 1010;
    property PWMOnTime[nAxis: Smallint]: Smallint dispid 1004;
    property ReadKey[nTermID: Integer]: Smallint readonly dispid 1005;
    procedure mmSetPWMMode(nNodeId: Smallint; nMode: Smallint); dispid 377;
    procedure mmGetPWMOnTime(nNodeId: Smallint; nChannel: Smallint; var pnOnTime: Integer); dispid 378;
    property RemoteADCDelta[nCANBus: Smallint; nNode: Smallint; nChannel: Smallint]: Smallint dispid 1011;
    property RelayOutputBankSetup[nBank: Smallint]: Smallint dispid 1008;
    procedure TransmitICMCommand(vFrontStruct: OleVariant; var pvInOut: OleVariant); dispid 362;
    property AccelJerkTime[nAxis: Smallint]: Integer dispid 397;
    property AccelJerk[nAxis: Smallint]: Single dispid 396;
    property AccelScaleFactor[nAxis: Smallint]: Single dispid 398;
    property AbortMode[nAxis: Smallint]: Smallint dispid 387;
    procedure mmSetMotorPair(nNodeId: Smallint; nMotor: Smallint; nDirection: Smallint; 
                             nMotor1OnTime: Integer; nMotor2OnTime: Integer; bEnable: WordBool); dispid 386;
    property AbsEncoderSinOffset[nAxis: Smallint]: Smallint dispid 392;
    property AbsEncoder[nAxis: Smallint]: Integer readonly dispid 388;
    property AbsEncoderCosOffset[nAxis: Smallint]: Smallint dispid 389;
    property AbsEncoderTurns[nChannel: Smallint]: Integer dispid 393;
    procedure mmGetPWMErrors(nNodeId: Smallint; var pnErrors: Integer); dispid 372;
    procedure mmGetPWMEnable(nNodeId: Smallint; nChannel: Smallint; var pnEnable: Smallint); dispid 370;
    procedure mmGetPWMBraking(nNodeId: Smallint; var pnBraking: Smallint); dispid 368;
    procedure GetTriggerPoints(var pvTriggered: OleVariant; var pvXPos: OleVariant; 
                               var pvYPos: OleVariant); dispid 363;
    procedure debugSetBurnInParameter(nParam: Smallint; fValue: Single); dispid 367;
    procedure mmSetPWMEnable(nNodeId: Smallint; nChannel: Smallint; nEnable: Smallint); dispid 371;
    property AccelDemand[nAxis: Smallint]: Single readonly dispid 395;
    property Accel[nAxis: Smallint]: Single dispid 394;
    procedure mmSetPWMBraking(nNodeId: Smallint; nBraking: Smallint); dispid 369;
    procedure mmSetUniDirectionalMotor(nNodeId: Smallint; nMotor: Smallint; nDirection: Smallint; 
                                       nOnTime: Integer; bEnable: WordBool); dispid 385;
    property PresetSelectorInput[nAxis: Smallint]: Smallint dispid 1000;
    property PresetTriggerInput[nAxis: Smallint]: Smallint dispid 1001;
    property ProfileMode[nAxis: Smallint]: Smallint dispid 1002;
    property PresetJogDirection[nPreset: Smallint]: Smallint dispid 992;
    property PresetIndexSource[nAxis: Smallint]: Smallint dispid 989;
    property PresetMoveParameter[nPreset: Smallint; nParam: Smallint]: Single dispid 996;
    property PresetInputsMax[nAxis: Smallint]: Smallint dispid 990;
    property PresetInputState[nAxis: Smallint]: Smallint readonly dispid 991;
    property PresetMoveType[nPreset: Smallint; nParam: Smallint]: Smallint dispid 999;
    property RemoteStatus[nCANBus: Smallint; nNode: Smallint]: Smallint dispid 1040;
    property ResetInput[nAxis: Smallint]: Smallint dispid 1041;
    property RevCountDeadband[nAxis: Smallint]: Smallint dispid 1042;
    property ScaleFactor[nAxis: Smallint]: Single dispid 1043;
    property PresetMovePosition[nPreset: Smallint]: Single dispid 997;
    property PresetMoveSpeed[nPreset: Smallint]: Single dispid 998;
    property RemoteEncoder[nCANBus: Smallint; nNode: Smallint; nChannel: Smallint]: Integer dispid 1018;
    property RemoteError[nCANBus: Smallint; nNode: Smallint]: Smallint readonly dispid 1019;
    property RemoteDebounce[nCANBus: Smallint; nNode: Smallint]: Smallint dispid 1016;
    property RemoteComms[nBus: Smallint; nNode: Smallint; nIndex: Smallint]: Single dispid 1013;
    property RemoteDAC[nCANBus: Smallint; nNode: Smallint; nChannel: Smallint]: Single dispid 1015;
    property Relay[nBank: Smallint]: WordBool dispid 1006;
    property RemoteEmergencyMessage[nCANBus: Smallint; nNode: Smallint]: Smallint readonly dispid 1017;
    property PresetMoveHomeType[nPreset: Smallint]: Smallint dispid 995;
    property PresetJogSpeed[nPreset: Smallint]: Single dispid 993;
    property PresetMoveEnable[nAxis: Smallint]: WordBool dispid 994;
    property RemoteCommsInteger[nBus: Smallint; nNode: Smallint; nIndex: Smallint]: Integer dispid 1014;
    property RemoteBaud[nCANBus: Smallint]: Integer writeonly dispid 1012;
    property PulseOutX[nChannel: Smallint]: Integer writeonly dispid 1003;
    property ADCMode[nChannel: Smallint]: Smallint dispid 426;
    property ADCMin[nChannel: Smallint]: Single dispid 425;
    property AnalogOutputSetup[nChannel: Smallint]: Smallint dispid 431;
    property ADCMonitor[nAxis: Smallint]: Integer dispid 427;
    property ADCTimeConstant[nChannel: Smallint]: Single dispid 429;
    property ADCOffset[nChannel: Smallint]: Single dispid 428;
    property AnalogInputSetup[nChannel: Smallint]: Smallint dispid 430;
    property AutoStartMode[nAxis: Smallint]: Smallint dispid 435;
    property AutoHomeMode[nAxis: Smallint]: Smallint dispid 434;
    property APIValue[nTable: Smallint; nFamily: Smallint; nIndex: Smallint; vArgs: OleVariant]: OleVariant dispid 433;
    procedure PrecisionTable(nAxisOrChannel: Smallint; fForwardArray: OleVariant; 
                             fReverseArray: OleVariant); dispid 344;
    procedure PresetCancel(nAxis: Smallint; nPreset: Smallint); dispid 345;
    property AuxDAC[nChannel: Smallint]: Single dispid 437;
    property AutotuneParam[nParam: Smallint]: Single dispid 436;
    property APIArgumentValues[nTable: Smallint; nArgument: Smallint]: OleVariant readonly dispid 432;
    property AuxDACMode[nChannel: Smallint]: Smallint dispid 438;
    property AuxEncoderMode[nAuxChannel: Smallint]: Smallint dispid 440;
    property AuxEncoderScale[nAuxChannel: Smallint]: Single dispid 442;
    property AuxEncoder[nAuxChannel: Smallint]: Single dispid 439;
    property AuxEncoderPreScale[nAuxChannel: Smallint]: Integer dispid 441;
    property AuxEncoderSpeed[nAuxChannel: Smallint]: Single dispid 443;
    property AuxEncoderVel[nAuxChannel: Smallint]: Single readonly dispid 444;
    property AuxEncoderWrap[nAuxChannel: Smallint]: Single dispid 445;
    property AuxEncoderZeroLatchMode[nAuxChannel: Smallint]: Smallint dispid 447;
    property AuxEncoderZeroEnable[nAuxChannel: Smallint]: WordBool writeonly dispid 446;
    property AuxEncoderZeroPosition[nAuxChannel: Smallint]: Single readonly dispid 448;
    property AuxEncoderZLatch[nAuxChannel: Smallint]: WordBool readonly dispid 449;
    property AxisADC[nAxis: Smallint]: Smallint dispid 451;
    property AverageVel[nAxis: Smallint]: Single readonly dispid 450;
    procedure SetMappedDevice(nType: Smallint; nLocalChannel: Smallint; nBus: Smallint; 
                              nNode: Smallint; nRemoteChannel: Smallint); dispid 333;
    procedure HelixA(nXAxis: Smallint; nYAxis: Smallint; nZAxis: Smallint; fXCentre: Single; 
                     fYCentre: Single; fAngle: Single; fZPos: Single); dispid 325;
    procedure SetDriveUnitProductionData(const strCatalogNumber: WideString; 
                                         const strSerialNumber: WideString; 
                                         const strBuildDate: WideString; nRevCode: Smallint; 
                                         nBetaBuild: Smallint; nDemoUnit: Smallint); dispid 317;
    procedure DoMoveFiducial(nXAxis: Smallint; nYAxis: Smallint; nCountMoves: Smallint; 
                             vPosData: OleVariant; vWindowData: OleVariant; 
                             nOutputChannel: Smallint; nOutputBit0: Smallint; 
                             nOutputBit1: Smallint; nMinTime: Smallint; fFiducialSpeed: Single; 
                             nMode: Smallint; nPulseTime: Smallint; nDwellTime: Smallint); dispid 336;
    procedure GetMappedRemoteDevice(nType: Smallint; nLocalChannel: Smallint; var pnBus: Smallint; 
                                    var pnNode: Smallint; var pnRemoteNode: Smallint; 
                                    var pnRemoteChannel: Smallint); dispid 334;
    procedure GetMappedDevice(nType: Smallint; nLocalChannel: Smallint; var pnBus: Smallint; 
                              var pnNode: Smallint; var pnRemoteChannel: Smallint); dispid 332;
    procedure GetDriveMacroNonEmpty(lFlags: Integer; var pbNonEmpty: WordBool); dispid 315;
    procedure SetDriveUnitProductionDataOld(const strCatalogNumber: WideString; 
                                            const strSerialNumber: WideString; 
                                            const strBuildDate: WideString; 
                                            const strRepairDate: WideString); dispid 319;
    procedure GetFileSystemEntry(nIndex: Smallint; var pbstrName: WideString; var pnType: Smallint; 
                                 var plSize: Integer); dispid 323;
    procedure GetDriveUnitProductionDataOld(var strCatalogNumber: WideString; 
                                            var strSerialNumber: WideString; 
                                            var strBuildDate: WideString; 
                                            var strRepairDate: WideString); dispid 318;
    procedure GetDriveUnitProductionData(var strCatalogNumber: WideString; 
                                         var strSerialNumber: WideString; 
                                         var strBuildDate: WideString; var pnRevCode: Smallint; 
                                         var pnBetaBuild: Smallint; var pnDemoUnit: Smallint); dispid 316;
    procedure SetDCFSection(nBus: Smallint; nNode: Smallint); dispid 314;
    procedure SetMappedRemoteDevice(nType: Smallint; nLocalChannel: Smallint; nBus: Smallint; 
                                    nNode: Smallint; nRemoteNode: Smallint; nRemoteChannel: Smallint); dispid 335;
    property AbsEncoderOffset[nAxis: Smallint]: Integer dispid 390;
    procedure GetSymbolTableForController(bForceUpload: WordBool; var pBstrSymbolTable: WideString); dispid 361;
    property AbsEncoderSinGain[nAxis: Smallint]: Smallint dispid 391;
    procedure HelixR(nXAxis: Smallint; nYAxis: Smallint; nZAxis: Smallint; fXCentre: Single; 
                     fYCentre: Single; fAngle: Single; fZPos: Single); dispid 326;
    procedure GetHiperfaceInfo(nAxis: Smallint; var bstrSerialNumber: WideString; 
                               var bstrProgramVersion: WideString; var nType: Smallint; 
                               var lAbsCountsPerRev: Integer; var nCyclesPerRev: Smallint; 
                               var nNumTurns: Smallint); dispid 327;
    procedure SetMACAddress(nAddress1: Smallint; nAddress2: Smallint; nAddress3: Smallint; 
                            nAddress4: Smallint; nAddress5: Smallint; nAddress6: Smallint); dispid 331;
    procedure SetLongStop(nAxis: Smallint; fMax: Single; fMin: Single; nState: Smallint); dispid 329;
    procedure GetMACAddress(var pnAddress1: Smallint; var pnAddress2: Smallint; 
                            var pnAddress3: Smallint; var pnAddress4: Smallint; 
                            var pnAddress5: Smallint; var pnAddress6: Smallint); dispid 330;
    procedure GetListData(nListId: Smallint; nIndex: Smallint; var pbSupported: WordBool; 
                          var pbFloat: WordBool; var pnEnum: Smallint; var pnChMin: Smallint; 
                          var pnChMax: Smallint; var pnChType: Smallint; var psLabel: WideString); dispid 328;
    procedure GetFirmwareInfo(var pnReleaseCandidate: Smallint; var pnBuildOption: Smallint; 
                              var pbstrCustomer: WideString); dispid 324;
    procedure SetPCBProductionData(nPCB: Smallint; ucType: Smallint; ucArtworkRevision: Smallint; 
                                   ucFunctionalRevision: Smallint; ucManufacturer: Smallint; 
                                   unModState: Integer; const bstrSerialNumber: WideString; 
                                   const strPLD1Type: WideString; ucPLD1Revision: Smallint; 
                                   const strPLD2Type: WideString; ucPLD2Revision: Smallint); dispid 341;
    procedure GetPLCTask(nChannel: Smallint; var pbEnable: WordBool; var pnCondition1: Smallint; 
                         var pnParameter1: Smallint; var pnOperator: Smallint; 
                         var pnCondition2: Smallint; var pnParameter2: Smallint; 
                         var pnAction: Smallint; var pnActionParameter: Smallint); dispid 342;
    procedure GetPCBProductionData(nPCB: Smallint; var ucType: Smallint; 
                                   var ucArtworkRevision: Smallint; 
                                   var ucFunctionalRevision: Smallint; 
                                   var ucManufacturer: Smallint; var unModState: Integer; 
                                   var bstrSerialNumber: WideString; var bstrPLD1Type: WideString; 
                                   var ucPLD1Revision: Smallint; var bstrPLD2Type: WideString; 
                                   var ucPLD2Revision: Smallint); dispid 340;
    procedure GetSentinel(nChannel: Smallint; var pnSource: Smallint; var pnParameter: Smallint; 
                          var pnMode: Smallint; var pbAbsolute: WordBool; var pfValueLow: Single; 
                          var pfValueHigh: Single); dispid 356;
    procedure SetSentinel(nChannel: Smallint; nSource: Smallint; nParameter: Smallint; 
                          nMode: Smallint; bAbsolute: WordBool; fValueLow: Single; 
                          fValueHigh: Single); dispid 357;
    procedure GetPresetMoveData(nPreset: Smallint; nAccelFormat: Smallint; 
                                var pnPresetType: Smallint; var pnPresetSubType: Smallint; 
                                var pfPresetPosition: Single; var pfPresetSpeed: Single; 
                                var pfPresetAccel: Single; var pfPresetDecel: Single); dispid 349;
    procedure PresetJog(nAxis: Smallint; nPreset: Smallint; fSpeed: Single; fAccel: Single; 
                        fDecel: Single); dispid 347;
    procedure PresetMoveA(nAxis: Smallint; nPreset: Smallint; fMove: Single; fSpeed: Single; 
                          fAccel: Single; fDecel: Single); dispid 348;
    procedure PresetHome(nAxis: Smallint; nPreset: Smallint; nMode: Smallint; fSpeed: Single; 
                         fAccel: Single; fDecel: Single); dispid 346;
    procedure GetOptionCardProdInfo(nCard: Smallint; var pnType: Smallint; var pnVersion: Smallint; 
                                    var pbstrVersion1: WideString; 
                                    var pbstrSerialNumber1: WideString; 
                                    var pbstrVersion2: WideString; 
                                    var pbstrSerialNumber2: WideString; var pnAxes: Smallint); dispid 338;
    procedure SetOptionCardProdInfo(nCard: Smallint; nType: Smallint; nVersion: Smallint; 
                                    const bstrVersion1: WideString; 
                                    const bstrSerialNumber1: WideString; 
                                    const bstrVersion2: WideString; 
                                    const bstrSerialNumber2: WideString; nAxes: Smallint); dispid 339;
    procedure SetPLCTask(nChannel: Smallint; bEnable: WordBool; nCondition1: Smallint; 
                         nParameter1: Smallint; nOperator: Smallint; nCondition2: Smallint; 
                         nParameter2: Smallint; nAction: Smallint; nActionParameter: Smallint); dispid 343;
    procedure SplineSegment(nAxis: Smallint; nTable: Smallint; nStartSegment: Integer; 
                            fSegmentArray: OleVariant); dispid 358;
    procedure SetMultipleInterpolatedMoves(pfData: OleVariant); dispid 337;
    procedure PresetSpeedRef(nAxis: Smallint; nPreset: Smallint; fSpeed: Single; fAccel: Single; 
                             fDecel: Single); dispid 353;
    procedure PresetStop(nAxis: Smallint; nPreset: Smallint); dispid 354;
    procedure GetFileSystemDetails(var pnVersion: Smallint; var pnNumFiles: Smallint; 
                                   var plTotalSpace: Integer; var plUsedSpace: Integer); dispid 322;
    procedure GetErrorLogEntry(nIndex: Smallint; var pnAxis: Smallint; var pnType: Smallint; 
                               var pnCode: Integer; var pnSeconds: Integer; var pnTicks: Smallint); dispid 320;
    procedure GetErrorLogEntryRTC(nIndex: Smallint; var pnAxis: Smallint; var pnType: Smallint; 
                                  var plCode: Integer; var pDate: TDateTime); dispid 321;
    procedure PresetTorqueRef(nAxis: Smallint; nPreset: Smallint; fTorque: Single; fAccel: Single; 
                              fDecel: Single); dispid 355;
    procedure SplineTable(nAxis: Smallint; fPosArray: OleVariant; fVelArray: OleVariant; 
                          fLengthArray: OleVariant); dispid 359;
    procedure GetStaticInfo(nStaticHandle: Integer; var pnType: Smallint; var pnSize: Integer; 
                            var pnOffset: Integer; var pbstrTask: WideString; 
                            var pbstrVariable: WideString); dispid 360;
    procedure PresetPos(nAxis: Smallint; nPreset: Smallint; fPos: Single); dispid 352;
    procedure PresetMoveR(nAxis: Smallint; nPreset: Smallint; fMove: Single; fSpeed: Single; 
                          fAccel: Single; fDecel: Single); dispid 350;
    procedure PresetMoveSuspend(nAxis: Smallint; nPreset: Smallint); dispid 351;
    property AxisPosEncoder[nAxis: Smallint]: Smallint dispid 460;
    property AxisSyncDelay[nAxis: Smallint]: Integer dispid 463;
    property AxisWarning[nAxis: Smallint]: Integer dispid 465;
    property AxisStatus[nAxis: Smallint]: Integer readonly dispid 461;
    property AxisVelEncoder[nAxis: Smallint]: Smallint dispid 464;
    property AxisPDOutput[nAxis: Smallint]: Smallint dispid 459;
    property AxisDAC[nAxis: Smallint]: Smallint dispid 454;
    property AxisWarningDisable[nAxis: Smallint]: Integer dispid 466;
    property AxisStatusWord[nAxis: Smallint]: Smallint readonly dispid 462;
    property Cam[nAxis: Smallint]: Smallint dispid 494;
    property CamAmplitude[nAxis: Smallint]: Single dispid 495;
    property CamEnd[nAxis: Smallint]: Integer dispid 497;
    property CamBox[nCamBox: Smallint]: Smallint dispid 496;
    property CamIndex[nAxis: Smallint]: Integer readonly dispid 498;
    property BusBaud[nBusID: Smallint]: Integer dispid 478;
    property CamStart[nAxis: Smallint]: Integer dispid 500;
    property CamPhaseStatus[nAxis: Smallint]: Smallint readonly dispid 499;
    property AxisError[nAxis: Smallint]: Integer dispid 455;
    property BurnInParameter[nParam: Smallint]: Single dispid 477;
    property BridgeCompEnable[nAxis: Smallint]: WordBool dispid 473;
    property BridgeErrorVoltage[nAxis: Smallint]: Single dispid 475;
    property BacklashInterval[nAxis: Smallint]: Smallint dispid 468;
    property BacklashMode[nAxis: Smallint]: Smallint dispid 469;
    property BufferDepth[nBuffer: Smallint; nParam: Smallint]: Integer dispid 476;
    property Boost[nAxis: Smallint]: WordBool dispid 472;
    property BridgeErrorCurrent[nAxis: Smallint]: Single dispid 474;
    property AxisNode[nAxis: Smallint]: Smallint readonly dispid 458;
    property AxisChannel[nAxis: Smallint]: Smallint dispid 453;
    property AxisMode[nAxis: Smallint]: Integer readonly dispid 457;
    property AxisErrorLogMask[nAxis: Smallint]: Integer dispid 456;
    property BusProcessDataInterval[nBusID: Smallint]: Smallint dispid 488;
    property BusProcessData[nBus: Smallint; bIn: WordBool; nChannel: Smallint]: Smallint dispid 487;
    property BusPDOMapContent[nBus: Smallint; nNode: Smallint; bIn: WordBool; nPeerNode: Smallint; 
                              nSlot: Smallint]: OleVariant dispid 486;
    property DriveSpeedFatal[nAxis: Smallint]: Single dispid 630;
    property DriveSpeedMax[nAxis: Smallint]: Single dispid 631;
    property BusTelegramDiagnosticStrings[nBusID: Smallint]: OleVariant readonly dispid 493;
    property BusState[nBusID: Smallint]: Smallint readonly dispid 491;
    property BusProcessDataParameter[nBus: Smallint; bIn: WordBool; nChannel: Smallint]: Smallint dispid 489;
    property BusTelegramDiagnostics[nBusID: Smallint]: OleVariant readonly dispid 492;
    property DriveSpeedMaxRPM[nAxis: Smallint]: Smallint dispid 633;
    property DriveRatingZone[nAxis: Smallint]: Smallint dispid 628;
    property DriveRatingZoneInfo[nAxis: Smallint; nZone: Smallint; nParam: Smallint]: Single readonly dispid 629;
    property EEPROMData[nAddress: Smallint]: Smallint dispid 638;
    property DriveUnderloadWarning[nAxis: Smallint]: Single dispid 636;
    property DriveVolts[nAxis: Smallint]: Single readonly dispid 637;
    property DriveSpeedMaxmmps[nAxis: Smallint]: Single dispid 632;
    property DriveRatedCurrent[nAxis: Smallint]: Single readonly dispid 626;
    property DriveRatedHorsePower[nAxis: Smallint]: Single readonly dispid 627;
    property BusProtocol[nBus: Smallint]: Smallint readonly dispid 490;
    property CANBaud[nCANBus: Smallint]: Integer dispid 501;
    property CANBusState[nCANBus: Smallint]: Smallint readonly dispid 502;
    property CaptureAxis[nChannel: Smallint]: Smallint dispid 505;
    property CANEventInfo[nCANBus: Smallint]: Smallint readonly dispid 504;
    property CANEvent[nCANBus: Smallint]: Smallint readonly dispid 503;
    property CaptureHSMode[nChannel: Smallint]: Smallint dispid 506;
    property CaptureMode[nChannel: Smallint]: Smallint dispid 507;
    property CaptureModeParameter[nAxis: Smallint]: Smallint dispid 508;
    property BusCommandMask[nFieldbus: Smallint]: Smallint dispid 480;
    property BusBaudsSupported[nBus: Smallint]: OleVariant readonly dispid 479;
    property BusCycleRate[nBus: Smallint]: Smallint dispid 481;
    property BusMessageMode[nBus: Smallint]: Smallint dispid 484;
    property BusEventInfo[nBusID: Smallint]: Smallint readonly dispid 483;
    property BusEvent[nBusID: Smallint]: Smallint readonly dispid 482;
    property BusNode[nBus: Smallint]: Smallint dispid 485;
    property Backlash[nAxis: Smallint]: Single dispid 467;
    property CaptureProgress[bPostTrigger: WordBool]: Smallint readonly dispid 511;
    property CaptureTriggerAbsolute[nTrigger: Smallint]: WordBool dispid 512;
    property CapturePoint[nChannel: Smallint; nIndex: Smallint]: Single readonly dispid 510;
    property CommandRefSource[nAxis: Smallint]: Smallint dispid 519;
    property CommandRefSourceParameter[nAxis: Smallint]: Smallint dispid 520;
    property CaptureTriggerSource[nTrigger: Smallint]: Smallint dispid 515;
    property CaptureTriggerMode[nTrigger: Smallint]: Smallint dispid 514;
    property CaptureModeName[nChannel: Smallint]: WideString readonly dispid 509;
    property CompareMode[nAxis: Smallint]: Smallint dispid 534;
    property Coil[nCoil: Smallint]: WordBool dispid 518;
    property CurrentLimit[nAxis: Smallint]: Single dispid 553;
    property ControlRefSourceStartup[nAxis: Smallint]: Smallint dispid 551;
    property CurrentDemand[nAxis: Smallint; nChannel: Smallint]: Single readonly dispid 552;
    property Commissioned[nAxis: Smallint]: WordBool dispid 521;
    property ChannelType[nChannel: Smallint]: Smallint readonly dispid 517;
    property CaptureTriggerValue[nTrigger: Smallint]: Single dispid 516;
    property CaptureTriggerChannel[nTrigger: Smallint]: Smallint dispid 513;
    property CommsInteger[nIndex: Smallint]: Integer dispid 524;
    property Comms[nIndex: Smallint]: Single dispid 522;
    property CommsControllerData[nEnum: Smallint; nParam: Smallint]: OleVariant readonly dispid 523;
    property CommsMultiple[nIndex: Smallint; nCount: Smallint]: OleVariant dispid 528;
    property CommsMapDataType[nAxis: Smallint]: Smallint dispid 525;
    property CommsMapParameter[nIndex: Smallint]: Smallint dispid 527;
    property CommsMapMode[nIndex: Smallint]: Smallint dispid 526;
    property CompareEnable[nOutput: Smallint]: WordBool dispid 532;
    property CommsTestParameter[nParameter: Smallint]: Single dispid 531;
    property CommsRemote[nNode: Smallint; nIndex: Smallint]: Single dispid 530;
    property CommsMultipleRemote[nNode: Smallint; nIndex: Smallint; nCount: Smallint]: OleVariant dispid 529;
    property CompareLatch[nAxis: Smallint]: Smallint dispid 533;
    property ControllerData[nEnum: Smallint; nParam: Smallint]: OleVariant readonly dispid 545;
    property ControlMode[nAxis: Smallint]: Smallint dispid 546;
    property ContourAngle[nAxis: Smallint]: Single dispid 541;
    property ControlModeStartup[nAxis: Smallint]: Smallint dispid 547;
    property CompareOutput[nAxis: Smallint]: Smallint dispid 535;
    property Config[nAxis: Smallint]: Smallint dispid 537;
    property ComparePos[nAxis: Smallint; nRegister: Smallint]: Single dispid 536;
    property ContourRatio[nAxis1: Smallint; nAxis2: Smallint]: Single dispid 544;
    property BlendMode[nAxis: Smallint]: Smallint dispid 471;
    property BlendDistance[nAxis: Smallint]: Single dispid 470;
    property ContourParameter[nAxis: Smallint; nParam: Smallint]: Single dispid 543;
    property ContourMode[nAxis: Smallint]: Smallint dispid 542;
    property ConnectStatus[nCANBus: Smallint; nFromNode: Smallint]: Smallint readonly dispid 540;
    property DAC[nChannel: Smallint]: Single dispid 555;
    property ControlRefSource[nAxis: Smallint]: Smallint dispid 550;
    property DACMonitorAxis[nChannel: Smallint]: Smallint dispid 559;
    property DACMonitorAbsolute[nChannel: Smallint]: Smallint dispid 558;
    property CurrentMeas[nAxis: Smallint; nChannel: Smallint]: Single readonly dispid 554;
    property ControlRefChannel[nAxis: Smallint]: Smallint dispid 549;
    property ControlRate[nAxis: Smallint; nChannel: Smallint]: Integer dispid 548;
    property DACMonitorGain[nChannel: Smallint]: Single dispid 560;
    property Connect[nCANBus: Smallint; nFromNode: Smallint; nToNode: Smallint]: Smallint dispid 538;
    property DACMode[nChannel: Smallint]: Smallint dispid 557;
    property ConnectInfo[nBus: Smallint; nFromNode: Smallint]: OleVariant readonly dispid 539;
    property DACLimitMax[nChannel: Smallint]: Single dispid 556;
    property Effort[nAxis: Smallint]: Single readonly dispid 639;
    property DriveData[nTransaction: Smallint]: Smallint dispid 600;
    property DriveEnable[nAxis: Smallint]: WordBool dispid 601;
    property DriveFault[nAxis: Smallint]: Smallint readonly dispid 609;
    property DriveFeedbackSource[nAxis: Smallint]: Smallint dispid 610;
    property DriveEnableOutput[nAxis: Smallint]: Smallint dispid 604;
    property DriveEnableMode[nAxis: Smallint]: Smallint dispid 603;
    property DriveBusUnderVolts[nAxis: Smallint]: Smallint dispid 598;
    property DriveBusVolts[nAxis: Smallint]: Single readonly dispid 599;
    property DriveErrorLogMask[nAxis: Smallint]: Integer dispid 607;
    property DiagnosticString[nChannel: Smallint]: WideString dispid 590;
    property DiagnosticParameter[nGroup: Smallint; nParameter: Smallint]: Single dispid 589;
    property DriveErrorString[nErrorCode: Smallint]: WideString readonly dispid 608;
    property DriveOkOutput[nAxis: Smallint]: Smallint dispid 611;
    property DriveError[nAxis: Smallint]: Smallint dispid 606;
    property DriveEnableSwitch[nAxis: Smallint]: WordBool readonly dispid 605;
    property DriveEnableInputMode[nAxis: Smallint]: Smallint dispid 602;
    property DACMonitorModeParameter[nChannel: Smallint]: Smallint dispid 562;
    property DACMonitorMode[nChannel: Smallint]: Smallint dispid 561;
    property DACRamp[nChannel: Smallint]: Integer dispid 566;
    property DACMonitorOffset[nChannel: Smallint]: Single dispid 563;
    property DACOffset[nChannel: Smallint]: Single dispid 565;
    property DACMonitorScale[nChannel: Smallint]: Single dispid 564;
    property DBExtAvgPower[nAxis: Smallint]: Single dispid 570;
    property DBEnable[nAxis: Smallint]: WordBool dispid 569;
    property DBDelay[nAxis: Smallint; nChannel: Smallint]: Single dispid 568;
    property DBConfig[nAxis: Smallint]: Smallint dispid 567;
    property DecelTime[nAxis: Smallint]: Integer dispid 585;
    property DBExtPeakPower[nAxis: Smallint]: Single dispid 572;
    property DBExtPeakDuration[nAxis: Smallint]: Single dispid 571;
    procedure SetNullLink; dispid 261;
    procedure SetOfflineDSPControllerLink(nType: Smallint; nVersion: Integer; nNode: Smallint; 
                                          nPort: Smallint; lBaudRate: Integer; bOpenPort: WordBool); dispid 262;
    procedure SetNextMoveE100Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                  bOpenPort: WordBool); dispid 254;
    procedure SetRouteToDCFLink(const lpszFilePath: WideString); dispid 264;
    procedure SetSC610Link(nNode: Smallint; nPort: Smallint; lBaudRate: Integer; bOpenPort: WordBool); dispid 265;
    procedure SetRouteFromDCFLink(const lpszFilePath: WideString); dispid 263;
    procedure SetFadalAmpLink(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                              bOpenPort: WordBool); dispid 243;
    procedure SetFlexDrive2Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                bOpenPort: WordBool); dispid 244;
    procedure SetH2USBLink(nNodeNumber: Smallint); dispid 248;
    procedure SetH2SerialLink(nNode: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                              bOpenPort: WordBool); dispid 246;
    procedure SetH2USBDeviceLink(const szDeviceLink: WideString); dispid 247;
    procedure SetFlexPlusDrive2Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                    bOpenPort: WordBool); dispid 245;
    procedure SetNextMoveSTLink(nNode: Smallint; nPort: Smallint; lBaudRate: Integer; 
                                bOpenPort: WordBool); dispid 260;
    procedure InstallKnifeEventHandler(bInstall: WordBool); dispid 227;
    procedure InstallFastInEventHandler(bInstall: WordBool); dispid 225;
    procedure InstallInputEventHandler(bInstall: WordBool); dispid 226;
    procedure InstallErrorEventHandler(bInstall: WordBool); dispid 224;
    procedure InstallLatchEventHandler(bInstall: WordBool); dispid 228;
    procedure InstallMoveBufferLowEventHandler(bInstall: WordBool); dispid 229;
    procedure SetNextMovePCI1Link(nNodeNumber: Smallint; nCardNumber: Smallint); dispid 257;
    procedure SetNextMoveESLink(nNode: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                bOpenPort: WordBool); dispid 255;
    procedure SetNextMoveESBLink(nNode: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                 bOpenPort: WordBool); dispid 256;
    procedure SetEuroFlexLink(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                              bOpenPort: WordBool); dispid 242;
    procedure SetNextMovePCIFastLink(nNodeNumber: Smallint; nCardNumber: Smallint); dispid 258;
    procedure SetNextMovePCI2FastLink(nNodeNumber: Smallint; nCardNumber: Smallint); dispid 259;
    procedure SetNextMoveBXLink(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                bOpenPort: WordBool); dispid 252;
    property DigitalInputBankSetup[nBank: Smallint]: Smallint dispid 591;
    property DiagnosticIndexedParameter[nGroup: Smallint; nCaptureIndex: Smallint; 
                                        nGDIPIndex: Smallint]: Single dispid 587;
    property DriveBusOverVolts[nAxis: Smallint]: Smallint dispid 596;
    property DriveBusNominalVolts[nAxis: Smallint]: Smallint readonly dispid 595;
    property DiagnosticIndexedString[nChannel: Smallint; nIndex: Smallint]: WideString readonly dispid 588;
    property DecelTimeMax[nAxis: Smallint]: Integer dispid 586;
    property DriveBusTConst[nAxis: Smallint]: Single dispid 597;
    procedure SetMicroFlexLink(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                               bOpenPort: WordBool); dispid 250;
    property AxisBus[nAxis: Smallint]: Smallint readonly dispid 452;
    property DPRFloat[nAddress: Smallint]: Single dispid 593;
    procedure SetNextMoveBX2Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                 bOpenPort: WordBool); dispid 253;
    procedure SetMintDrive2Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                bOpenPort: WordBool); dispid 251;
    procedure SetMicroFlexE100Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                   bOpenPort: WordBool); dispid 249;
    property DigitalOutputBankSetup[nBank: Smallint]: Smallint dispid 592;
    property DPRLong[nAddress: Smallint]: Integer dispid 594;
    property EncoderVel[nChannel: Smallint]: Single readonly dispid 658;
    property EncoderType[nChannel: Smallint]: Smallint dispid 657;
    property EncoderTestMode[nChannel: Smallint]: Integer dispid 656;
    property EncoderWrap[nChannel: Smallint]: Single dispid 659;
    property DriveParameter[nTable: Smallint; nParameter: Smallint]: OleVariant dispid 619;
    property DriveOverloadWarning[nAxis: Smallint]: Single dispid 618;
    property EnableSwitch[nAxis: Smallint]: WordBool readonly dispid 640;
    property DriveParameterFloat[nTable: Smallint; nParameter: Smallint]: Single dispid 620;
    property EncoderSetup[nChannel: Smallint]: Smallint dispid 654;
    property ErrorMask[nAxis: Smallint]: Integer dispid 668;
    property ErrorList[nGroup: Smallint; nData: Integer]: OleVariant readonly dispid 666;
    property ErrorInputMode[nAxis: Smallint]: Smallint dispid 665;
    property ErrorBitmapStrings[nType: Smallint]: OleVariant readonly dispid 662;
    property ErrorInput[nAxis: Smallint]: Smallint dispid 664;
    property ErrorLogString[nType: Smallint; nErrorCode: Integer]: WideString readonly dispid 667;
    property EncoderScale[nChannel: Smallint]: Single dispid 653;
    property EncoderZLatch[nChannel: Smallint]: WordBool readonly dispid 660;
    property EncoderStatus[nChannel: Smallint]: Smallint readonly dispid 655;
    property DriveParameterInteger[nTable: Smallint; nParameter: Smallint]: Integer dispid 621;
    property DriveOverloadGain[nAxis: Smallint]: Single dispid 616;
    property DrivePWMMode[nAxis: Smallint]: Smallint dispid 625;
    property DriveTestParameter[nParam: Smallint]: Single dispid 635;
    property DriveOverloadMode[nAxis: Smallint]: Smallint dispid 617;
    property DriveOverloadFatal[nAxis: Smallint]: Single dispid 615;
    property DriveSpeedMin[nAxis: Smallint]: Single dispid 634;
    property DrivePeakCurrent[nAxis: Smallint]: Single readonly dispid 622;
    property DrivePWMFreq[nAxis: Smallint]: Single readonly dispid 624;
    property DrivePeakDuration[nAxis: Smallint]: Single readonly dispid 623;
    property DriveOperatingMode[nAxis: Smallint]: Smallint dispid 612;
    property DriveOperatingZone[nAxis: Smallint]: Smallint dispid 613;
    property DriveOverloadArea[nAxis: Smallint]: Single readonly dispid 614;
    property DBExtR[nAxis: Smallint]: Single dispid 573;
    property DBExtTripInput[nAxis: Smallint]: Smallint dispid 575;
    property DBMode[nAxis: Smallint]: Smallint dispid 577;
    property DBExtThermalTimeConst[nAxis: Smallint]: Single dispid 574;
    property DBFreq[nAxis: Smallint]: Single dispid 576;
    property EncoderOutChannel[nChannel: Smallint]: Smallint dispid 649;
    property DBOverloadMode[nAxis: Smallint]: Smallint dispid 578;
    property DBSwitchingVolts[nAxis: Smallint]: Single dispid 579;
    property Decel[nAxis: Smallint]: Single dispid 582;
    property DBVoltsLimit[nAxis: Smallint]: Single dispid 581;
    property DBVolts[nAxis: Smallint]: Smallint readonly dispid 580;
    property DecelJerk[nAxis: Smallint]: Single dispid 583;
    property DecelJerkTime[nAxis: Smallint]: Integer dispid 584;
    property EncoderMode[nChannel: Smallint]: Smallint dispid 648;
    property EncoderLinesIn[nAxis: Smallint]: Integer dispid 646;
    property EncoderFilterType[nEncoderChannel: Smallint]: Smallint dispid 645;
    property EncoderFilterDepth[nEncoderChannel: Smallint]: Smallint dispid 644;
    property Encoder[nChannel: Smallint]: Single dispid 641;
    property ErrorDecel[nAxis: Smallint]: Single dispid 663;
    property ErrData[nIndex: Smallint]: Integer readonly dispid 661;
    property EncoderResolution[nChannel: Smallint]: Integer dispid 652;
    property EncoderPreScale[nChannel: Smallint]: Integer dispid 651;
    property EncoderLinesOut[nAxis: Smallint]: Integer dispid 647;
    property EncoderOutResolution[nChannel: Smallint]: Integer dispid 650;
    property EncoderCycleSize[nAxis: Smallint]: Integer dispid 643;
    property EncoderCount[nAxis: Smallint]: Smallint readonly dispid 642;
    property HomeBackoff[nAxis: Smallint]: Single dispid 724;
    property HomeCreepSpeed[nAxis: Smallint]: Single dispid 725;
    property HomeDecel[nAxis: Smallint]: Single dispid 726;
    property FastAuxLatchEdge[nAxis: Smallint]: WordBool dispid 679;
    property FastAuxLatchMode[nAxis: Smallint]: Smallint dispid 680;
    property FastAuxSelect[nAxis: Smallint]: Smallint dispid 681;
    property FastEnable[nAxis: Smallint]: Smallint writeonly dispid 682;
    property HomeAccel[nAxis: Smallint]: Single dispid 723;
    property HomeSpeed[nAxis: Smallint]: Single dispid 733;
    property HomeInput[nAxis: Smallint]: Smallint dispid 727;
    property HomeStatus[nAxis: Smallint]: WordBool dispid 734;
    property HomeSwitch[nAxis: Smallint]: WordBool readonly dispid 735;
    property HomeSources[nAxis: Smallint]: Smallint readonly dispid 732;
    property HoldingRegister[nRegister: Integer]: Integer dispid 720;
    property HoldSwitch[nAxis: Smallint]: Smallint readonly dispid 721;
    property Home[nAxis: Smallint]: Smallint dispid 722;
    property FastEncoder[nAxis: Smallint]: Single readonly dispid 683;
    property FastAuxLatchDistance[nAxis: Smallint]: Single dispid 678;
    property ErrorSwitch[nAxis: Smallint]: WordBool readonly dispid 674;
    property FastAuxEnable[nAxis: Smallint]: Smallint writeonly dispid 675;
    property ErrorString[nErrorCode: Integer]: WideString readonly dispid 673;
    property FastAuxLatch[nAxis: Smallint]: WordBool readonly dispid 677;
    property FolErrorWarning[nAxis: Smallint]: Single dispid 699;
    property FolErrorFatal[nAxis: Smallint]: Single dispid 697;
    property FastAuxEncoder[nAxis: Smallint]: Single readonly dispid 676;
    property FastLatchMode[nAxis: Smallint]: Smallint dispid 687;
    property FolErrorMode[nAxis: Smallint]: Smallint dispid 698;
    property ErrorMaskCode[nCode: Integer; nData: Integer]: WordBool dispid 669;
    property FastLatch[nAxis: Smallint]: WordBool readonly dispid 684;
    property FastLatchDistance[nAxis: Smallint]: Single dispid 685;
    property FastLatchEdge[nAxis: Smallint]: WordBool dispid 686;
    property ErrorReadNext[nGroup: Smallint; nData: Integer]: WordBool readonly dispid 672;
    property ErrorPresent[nGroup: Smallint; nData: Integer]: WordBool readonly dispid 670;
    property ErrorReadCode[nGroup: Smallint; nData: Integer]: WordBool readonly dispid 671;
    property GroupMaster[nCANBus: Smallint; nGroup: Smallint]: Smallint dispid 713;
    property GroupMasterStatus[nCANBus: Smallint; nGroup: Smallint]: Smallint readonly dispid 714;
    property Group[nCANBus: Smallint; nGroup: Smallint; nNodeId: Smallint]: Smallint dispid 710;
    property MotorRs[nAxis: Smallint]: Single dispid 878;
    property MotorSlipFreq[nAxis: Smallint]: Single dispid 879;
    property HallReverseAngle[nAxis: Smallint; nSextant: Smallint]: Single dispid 718;
    property HallTable[nAxis: Smallint; nState: Smallint]: Smallint dispid 719;
    property GroupComms[nCANBus: Smallint; nGroup: Smallint; nIndex: Smallint]: Single writeonly dispid 711;
    property GroupInfo[nBus: Smallint; nNode: Smallint]: Smallint readonly dispid 712;
    property GroupStatus[nCANBus: Smallint; nGroup: Smallint]: Smallint readonly dispid 715;
    property MotorRotorLeakageInd[nAxis: Smallint]: Single dispid 876;
    property MotorRotorRes[nAxis: Smallint]: Single dispid 877;
    property MotorResolverOffset[nAxis: Smallint]: Single dispid 874;
    property MotorTemperatureInput[nAxis: Smallint]: Smallint dispid 886;
    property MotorSpeedMaxmmps[nAxis: Smallint]: Single dispid 881;
    property MotorSpecNumber[nAxis: Smallint]: WideString dispid 880;
    property MotorResolverSpeed[nAxis: Smallint]: Single dispid 875;
    property Hall[nAxis: Smallint]: Smallint readonly dispid 716;
    property HomePhase[nAxis: Smallint]: Smallint readonly dispid 729;
    property HomePos[nAxis: Smallint]: Single readonly dispid 730;
    property FrictionCompensationTConst[nAxis: Smallint]: Single dispid 707;
    property Gearing[nAxis: Smallint]: Single dispid 708;
    property HomeOffset[nAxis: Smallint]: Single dispid 728;
    property HomeRefPos[nAxis: Smallint]: Single dispid 731;
    property GearingMode[nAxis: Smallint]: Smallint dispid 709;
    property FrictionCompensation[nAxis: Smallint]: Single dispid 705;
    property FrictionCompensationSpeed[nAxis: Smallint]: Single dispid 706;
    property HallForwardAngle[nAxis: Smallint; nSextant: Smallint]: Single dispid 717;
    property FollowNumerator[nAxis: Smallint]: Single dispid 703;
    property Freq[nAxis: Smallint]: Single dispid 704;
    property KITrack[nAxis: Smallint]: Smallint dispid 786;
    property KIntMode[nAxis: Smallint]: Smallint dispid 784;
    property KVel[nAxis: Smallint]: Single dispid 790;
    property KIProp[nAxis: Smallint]: Single dispid 785;
    property KVDerivTConst[nAxis: Smallint]: Single dispid 789;
    property KProp[nAxis: Smallint]: Single dispid 787;
    property KVProp[nAxis: Smallint]: Single dispid 795;
    property KVelFF[nAxis: Smallint]: Single dispid 791;
    property KVFilterLevel[nAxis: Smallint]: Smallint dispid 792;
    property KVInt[nAxis: Smallint]: Single dispid 793;
    property KVTrack[nAxis: Smallint]: Smallint dispid 797;
    property KVMeas[nAxis: Smallint]: Single dispid 794;
    property KVTime[nAxis: Smallint]: Single dispid 796;
    property KVDeriv[nAxis: Smallint]: Single dispid 788;
    property HTAChannel[nAxis: Smallint]: Smallint dispid 738;
    property HTADamping[nAxis: Smallint]: Single dispid 739;
    property HomeType[nAxis: Smallint]: Smallint dispid 736;
    property IdleVel[nAxis: Smallint]: Single dispid 749;
    property HTAKProp[nAxis: Smallint]: Single dispid 743;
    property HTAFilter[nAxis: Smallint]: Single dispid 741;
    property HTAKInt[nAxis: Smallint]: Single dispid 742;
    property HTA[nAxis: Smallint]: Single dispid 737;
    property IdleTime[nAxis: Smallint]: Smallint dispid 748;
    property IdlePos[nAxis: Smallint]: Single dispid 746;
    property Idle[nAxis: Smallint]: WordBool readonly dispid 744;
    property IdleMode[nAxis: Smallint]: Smallint dispid 745;
    property IMask[nBank: Smallint]: Integer dispid 750;
    property IdleSettlingTime[nAxis: Smallint]: Integer readonly dispid 747;
    property FeedrateParameter[nAxis: Smallint; nOverride: Smallint]: Single dispid 693;
    property FirmwareComponentVersion[nComponent: Smallint]: Single readonly dispid 694;
    property Fly[nAxis: Smallint]: Single writeonly dispid 695;
    property FastSelect[nAxis: Smallint]: Smallint dispid 689;
    property FeedrateMode[nAxis: Smallint]: Smallint dispid 691;
    property KFInt[nAxis: Smallint]: Single dispid 778;
    property KFProp[nAxis: Smallint]: Single dispid 779;
    property FeedrateOverride[nAxis: Smallint]: Single dispid 692;
    property FastPos[nAxis: Smallint]: Single readonly dispid 688;
    property FollowMode[nAxis: Smallint]: Smallint dispid 702;
    property Follow[nAxis: Smallint]: Single dispid 700;
    property Feedrate[nAxis: Smallint]: Single dispid 690;
    property FollowDenom[nAxis: Smallint]: Single dispid 701;
    property FolError[nAxis: Smallint]: Single readonly dispid 696;
    property JogDuration[nAxis: Smallint]: Integer dispid 770;
    property JogSpeed[nAxis: Smallint]: Single dispid 772;
    property KASInt[nAxis: Smallint]: Single dispid 775;
    property JogDecelTimeMax[nAxis: Smallint]: Integer dispid 769;
    property KAccel[nAxis: Smallint]: Single dispid 774;
    property KIntLimit[nAxis: Smallint]: Single dispid 783;
    property KASProp[nAxis: Smallint]: Single dispid 776;
    property JogTime[nAxis: Smallint]: Integer readonly dispid 773;
    property JogMode[nAxis: Smallint]: Smallint dispid 771;
    property KFTime[nAxis: Smallint]: Single dispid 780;
    property KInt[nAxis: Smallint]: Single dispid 782;
    property KDeriv[nAxis: Smallint]: Single dispid 777;
    property KIInt[nAxis: Smallint]: Single dispid 781;
    property MotorStatorRes[nAxis: Smallint]: Single dispid 885;
    property LatchSourceChannel[nLatchChannel: Smallint]: Smallint dispid 809;
    property LatchInhibitValue[nLatchChannel: Smallint]: Single dispid 804;
    property KnifeMode[nAxis: Smallint]: Smallint dispid 799;
    property LatchTriggerEdge[nLatchChannel: Smallint]: Smallint dispid 811;
    property LatchSource[nLatchChannel: Smallint]: Smallint dispid 808;
    property KnifeMasterAxis[nAxis: Smallint]: Smallint dispid 798;
    property KnifeStatus[nAxis: Smallint]: Smallint dispid 800;
    property LatchTriggerChannel[nLatchChannel: Smallint]: Smallint dispid 810;
    property MotorFluxMax[nAxis: Smallint]: Single dispid 850;
    property LatchSetup[nDeviceType: Smallint; nChannel: Smallint]: Smallint dispid 806;
    property LatchSetupMultiple[nDeviceType: Smallint; nChannel: Smallint]: OleVariant dispid 807;
    property MotorFluxMin[nAxis: Smallint]: Single dispid 851;
    property MotorFlux[nAxis: Smallint]: Single dispid 849;
    property LatchMode[nLatchChannel: Smallint]: Smallint dispid 805;
    property LatchInhibitTime[nLatchChannel: Smallint]: Integer dispid 803;
    property MasterDistance[nAxis: Smallint]: Single dispid 824;
    property MasterSource[nAxis: Smallint]: Smallint dispid 825;
    property MaxAccel[nAxis: Smallint]: Single dispid 826;
    property MaxDecel[nAxis: Smallint]: Single dispid 827;
    property LimitForwardInput[nAxis: Smallint]: Smallint dispid 816;
    property LatchTriggerMode[nLatchChannel: Smallint]: Smallint dispid 812;
    property ListOf[nListOf: Smallint; nParameter: Smallint]: OleVariant dispid 820;
    property Limit[nAxis: Smallint]: WordBool readonly dispid 814;
    property LimitForward[nAxis: Smallint]: WordBool readonly dispid 815;
    property LatchEnable[nLatchChannel: Smallint]: WordBool dispid 802;
    property Latch[nLatchChannel: Smallint]: WordBool readonly dispid 801;
    property LoadDamping[nAxis: Smallint]: Single dispid 821;
    property LoadInertia[nAxis: Smallint]: Single dispid 822;
    property MasterChannel[nAxis: Smallint]: Smallint dispid 823;
    property MintExtendedStatus[nCommand: Smallint; vData: OleVariant]: Integer readonly dispid 830;
    property MaxSpeed[nAxis: Smallint]: Single dispid 828;
    property MotorBrake[nAxis: Smallint]: WordBool writeonly dispid 836;
    property MintExpressions[vLHS: OleVariant]: OleVariant dispid 829;
    property MotorBaseVolts[nAxis: Smallint]: Single dispid 835;
    property ModuleName[nModuleID: Smallint]: WideString readonly dispid 832;
    property MintStatus[nCommand: Smallint]: Integer readonly dispid 831;
    property MotorBaseFreq[nAxis: Smallint]: Single dispid 834;
    property MotorDirection[nAxis: Smallint]: Smallint dispid 842;
    property MotorBrakeDelay[nAxis: Smallint; nChannel: Smallint]: Smallint dispid 837;
    property MotorBrakeMode[nAxis: Smallint]: Smallint dispid 838;
    property MotorBrakeOutput[nAxis: Smallint]: Smallint dispid 839;
    property MotorEncoderLines[nAxis: Smallint]: Integer dispid 843;
    property MotorCatalogNumber[nAxis: Smallint]: WideString dispid 841;
    property MotorBrakeStatus[nAxis: Smallint]: Smallint readonly dispid 840;
    property MonitorParameter[nGroup: Smallint; nMode: Smallint; nParameter: Smallint]: Integer readonly dispid 833;
    property MotorFeedbackAngle[nAxis: Smallint]: Single readonly dispid 846;
    property MotorFeedbackOffset[nAxis: Smallint]: Single dispid 847;
    property MotorLs[nAxis: Smallint]: Single dispid 856;
    property MotorMagCurrent[nAxis: Smallint]: Single dispid 857;
    property MotorFluxTConst[nAxis: Smallint]: Single dispid 852;
    property MotorFeedbackStatus[nAxis: Smallint]: Smallint readonly dispid 848;
    property MotorFeedback[nAxis: Smallint]: Smallint dispid 844;
    property MotorFeedbackAlignment[nAxis: Smallint]: Single dispid 845;
    property MotorLinearEncoderResolution[nAxis: Smallint]: Integer dispid 854;
    property MotorLinearPolePitch[nAxis: Smallint]: Single dispid 855;
    property MotorMagCurrentCoeff[nAxis: Smallint; nChannel: Smallint]: Single dispid 858;
    property MotorInstabilityFreq[nAxis: Smallint]: Single dispid 853;
    property LatchValue[nLatchChannel: Smallint]: Single readonly dispid 813;
    property MotorRatedCurrent[nAxis: Smallint]: Single dispid 868;
    property MotorRatedSpeed[nAxis: Smallint]: Single dispid 870;
    property MotorRatedFreq[nAxis: Smallint]: Single dispid 869;
    property MotorPowerMeasured[nAxis: Smallint]: Single readonly dispid 867;
    property MotorRatedSpeedmmps[nAxis: Smallint]: Single dispid 871;
    property MotorRatedSpeedRPM[nAxis: Smallint]: Integer dispid 872;
    property MotorRatedVolts[nAxis: Smallint]: Single dispid 873;
    property NetInteger[nIndex: Smallint]: Integer dispid 909;
    property NodeType[nCANBus: Smallint; nNode: Smallint]: Smallint dispid 912;
    property NetIntegerMultiple[nIndex: Smallint; nElements: Smallint]: OleVariant dispid 910;
    property NodeLive[nCANBus: Smallint; nNode: Smallint]: WordBool readonly dispid 911;
    property NetFloatMultiple[nIndex: Smallint; nElements: Smallint]: OleVariant dispid 908;
    property NodeTypeExtended[nBus: Smallint; nNode: Smallint]: OleVariant dispid 913;
    property NumberOf[nItem: Smallint]: Smallint dispid 914;
    property NumberOfExtended[nItem: Smallint; nParameter: Smallint]: Smallint dispid 915;
    property MotorPoles[nAxis: Smallint]: Smallint dispid 866;
    property MotorStatorLeakageInd[nAxis: Smallint]: Single dispid 884;
    property MotorSpeedMaxRPM[nAxis: Smallint]: Smallint dispid 882;
    property MotorStabilityGain[nAxis: Smallint]: Single dispid 883;
    property MotorTemperatureMode[nAxis: Smallint]: Smallint dispid 887;
    property MotorPeakCurrent[nAxis: Smallint]: Single dispid 864;
    property MotorMagCurrentMax[nAxis: Smallint]: Single dispid 859;
    property MotorMagCurrentMin[nAxis: Smallint]: Single dispid 860;
    property MotorMagInd[nAxis: Smallint]: Single dispid 861;
    property MotorOverloadArea[nAxis: Smallint]: Single readonly dispid 862;
    property MotorOverloadMode[nAxis: Smallint]: Smallint dispid 863;
    property MotorPeakDuration[nAxis: Smallint]: Single dispid 865;
    property NetFloat[nIndex: Smallint]: Single dispid 907;
    property MoveRTest[nAxis: Smallint; nParam: Smallint]: Single dispid 904;
    property MoveDwell[nAxis: Smallint]: Integer writeonly dispid 899;
    property MoveR[nAxis: Smallint]: Single writeonly dispid 903;
    property MultipleCommandsExecute[nFlags: Integer]: OleVariant readonly dispid 906;
    property MotorType[nAxis: Smallint]: Smallint dispid 890;
    property MoveA[nAxis: Smallint]: Single writeonly dispid 891;
    property MoveStatus[nAxis: Smallint]: Smallint readonly dispid 905;
    property MoveBufferSize[nAxis: Smallint]: Smallint dispid 896;
    property MoveCorrection[nAxis: Smallint]: Single writeonly dispid 898;
    property LimitMode[nAxis: Smallint]: Smallint dispid 817;
    property LimitReverseInput[nAxis: Smallint]: Smallint dispid 819;
    property MoveOutX[nAxis: Smallint; nChannel: Smallint]: WordBool writeonly dispid 901;
    property MovePulseOutX[nAxis: Smallint; nChannel: Smallint]: Integer writeonly dispid 902;
    property MoveBufferStatus[nAxis: Smallint]: Smallint readonly dispid 897;
    property LimitReverse[nAxis: Smallint]: WordBool readonly dispid 818;
    property MoveOut[nAxis: Smallint; nOutputBank: Smallint]: Integer writeonly dispid 900;
    property MotorTemperatureSwitch[nAxis: Smallint]: WordBool readonly dispid 888;
    property OffsetDistance[nAxis: Smallint]: Single dispid 919;
    property OkToLoadMove[nNumberOfAxes: Smallint; nAxisArray: OleVariant]: WordBool readonly dispid 922;
    property OptionCardBus[nSlot: Smallint]: Smallint readonly dispid 923;
    property NVFloat[nAddress: Smallint]: Single dispid 916;
    property NVLong[nAddress: Smallint]: Integer dispid 917;
    property OffsetStatus[nAxis: Smallint]: Smallint readonly dispid 921;
    property OptionCardNetworkAddress[nSlot: Smallint]: Integer dispid 924;
    property OffsetMode[nAxis: Smallint]: Smallint dispid 920;
    property MoveBufferLow[nAxis: Smallint]: Smallint dispid 895;
    property MotorTestMode[nParam: Smallint]: Single dispid 889;
    property MoveBufferFree[nAxis: Smallint]: Smallint readonly dispid 892;
    property Offset[nAxis: Smallint]: Single writeonly dispid 918;
    property MoveBufferID[nAxis: Smallint]: Integer dispid 893;
    property MoveBufferIDLast[nAxis: Smallint]: Integer readonly dispid 894;
    property PosRef[nAxis: Smallint]: Single dispid 963;
    property PosRemaining[nAxis: Smallint]: Single readonly dispid 964;
    property PLXData[nAddress: Smallint]: Integer dispid 958;
    property PosDemand[nAxis: Smallint]: Single dispid 961;
    property PosWrap[nAxis: Smallint]: Single dispid 974;
    property PrecisionSourceChannel[nAxisOrChannel: Smallint]: Smallint dispid 983;
    property PresetAccel[nPreset: Smallint; nFmt: Smallint]: Single dispid 984;
    property PositionControlLooptime[nAxis: Smallint]: Smallint dispid 962;
    property PLCTaskStatus[nChannel: Smallint]: Smallint readonly dispid 957;
    property PosTrimGain[nAxis: Smallint]: Single dispid 973;
    property PosScaleUnits[nAxis: Smallint]: WideString dispid 970;
    property PosRolloverTarget[nAxis: Smallint]: Integer readonly dispid 967;
    property Pos[nAxis: Smallint]: Single dispid 959;
    property PosAchieved[nAxis: Smallint]: WordBool readonly dispid 960;
    property PosTarget[nAxis: Smallint]: Single readonly dispid 971;
    property PosTargetLast[nAxis: Smallint]: Single readonly dispid 972;
    property PosRollover[nAxis: Smallint]: Integer dispid 965;
    property PowerReadyInput[nParam: Smallint]: Smallint dispid 976;
    property PrecisionAxis[nAxisOrChannel: Smallint]: Smallint dispid 978;
    property PrecisionMode[nAxisOrChannel: Smallint]: Smallint dispid 980;
    property PowerReadyOutput[nParam: Smallint]: Smallint dispid 977;
    property PowerbaseParameter[nParam: Smallint]: Single dispid 975;
    property PrecisionIncrement[nAxisOrChannel: Smallint]: Single dispid 979;
    property OutputMonitorModeParameter[nOutput: Smallint]: Smallint dispid 935;
    property PrecisionOffset[nAxisOrChannel: Smallint]: Single dispid 981;
    property PresetDecel[nPreset: Smallint; nFmt: Smallint]: Single dispid 985;
    property PresetIndex[nAxis: Smallint]: Smallint dispid 987;
    property PrecisionSource[nAxisOrChannel: Smallint]: Smallint dispid 982;
    property PresetDwellTime[nAxis: Smallint]: Integer dispid 986;
    property PresetIndexMode[nAxis: Smallint]: Smallint dispid 988;
    property SuspendSwitch[nAxis: Smallint]: WordBool readonly dispid 1115;
    property Temperature[nChannel: Smallint]: Single readonly dispid 1116;
    property TorqueFilterBand[nAxis: Smallint; nStage: Smallint]: Single dispid 1127;
    property TemperatureLimitWarning[nChannel: Smallint]: Single readonly dispid 1118;
    property TerminalAddress[nTerminalID: Integer]: Smallint dispid 1119;
    property SuspendInput[nAxis: Smallint]: Smallint dispid 1114;
    property TorqueRefEnable[nAxis: Smallint]: WordBool dispid 1135;
    property TorqueRefErrorFallTime[nAxis: Smallint]: Single dispid 1136;
    property TorqueRefFallTime[nAxis: Smallint]: Single dispid 1137;
    property TemperatureLimitFatal[nChannel: Smallint]: Single readonly dispid 1117;
    property Torque[nAxis: Smallint]: Single dispid 1125;
    property StopSwitch[nAxis: Smallint]: WordBool readonly dispid 1112;
    property TimeScale[nAxis: Smallint]: Single dispid 1124;
    property StopMode[nAxis: Smallint]: Smallint dispid 1111;
    property Suspend[nAxis: Smallint]: Smallint dispid 1113;
    property StopInputMode[nAxis: Smallint]: Smallint dispid 1110;
    property TorqueRefRiseTime[nAxis: Smallint]: Single dispid 1138;
    property TorqueRef[nAxis: Smallint]: Single dispid 1134;
    property TorqueLimitNeg[nAxis: Smallint]: Single dispid 1131;
    property TorqueLimitPos[nAxis: Smallint]: Single dispid 1132;
    property TorqueProvingMode[nAxis: Smallint]: Smallint dispid 1133;
    property PosScaleFactor[nAxis: Smallint]: Single dispid 969;
    property PosRolloverDemand[nAxis: Smallint]: Integer readonly dispid 966;
    property PosRolloverTargetLast[nAxis: Smallint]: Integer readonly dispid 968;
    property TorqueFilterFreq[nAxis: Smallint; nStage: Smallint]: Single dispid 1129;
    property TorqueRefSource[nAxis: Smallint]: Smallint dispid 1139;
    property TriggerChannel[nAxis: Smallint]: Smallint dispid 1140;
    property TriggerCompensation[nAxis: Smallint]: Single dispid 1141;
    property TorqueFilterType[nAxis: Smallint; nStage: Smallint]: Smallint dispid 1130;
    property TorqueFilterDepth[nAxis: Smallint; nStage: Smallint]: Single dispid 1128;
    property RemoteNumberOf[nBus: Smallint; nNode: Smallint; nItem: Smallint]: Smallint dispid 1028;
    property RemoteInBank[nCANBus: Smallint; nNode: Smallint; nBank: Smallint]: Integer readonly dispid 1022;
    property RemoteInhibitTime[nBus: Smallint]: Smallint dispid 1023;
    property RemoteOut[nCANBus: Smallint; nNode: Smallint]: Integer dispid 1032;
    property RemoteOutBank[nCANBus: Smallint; nNode: Smallint; nBank: Smallint]: Integer dispid 1033;
    property RemoteIn[nCANBus: Smallint; nNode: Smallint]: Integer readonly dispid 1021;
    property RemoteInputActiveLevel[nCANBus: Smallint; nNode: Smallint]: Integer dispid 1024;
    property RemoteMode[nCANBus: Smallint; nNode: Smallint]: Smallint dispid 1026;
    property RemoteEStop[nCANBus: Smallint; nNode: Smallint]: WordBool dispid 1020;
    property RemoteOutputError[nCANBus: Smallint; nNode: Smallint]: Integer dispid 1035;
    property RemoteObjectFloat[nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                               nSubIndex: Smallint]: Single dispid 1030;
    property RemoteObjectString[nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                nSubIndex: Smallint]: WideString dispid 1031;
    property PhaseSearchInput[nAxis: Smallint]: Smallint dispid 946;
    property PhaseSearchMode[nAxis: Smallint]: Smallint dispid 947;
    property RemoteOutputActiveLevel[nCANBus: Smallint; nNode: Smallint]: Integer dispid 1034;
    property RemoteObject[nBus: Smallint; nNode: Smallint; nIndex: Smallint; nSubIndex: Smallint; 
                          nVarType: Smallint]: Integer dispid 1029;
    property RemoteNode[nCANBus: Smallint]: Smallint writeonly dispid 1027;
    property SentinelLatch[nChannel: Smallint]: WordBool readonly dispid 1048;
    property SentinelPeriod[nSentinelChannel: Smallint]: Integer dispid 1049;
    property SentinelSource[nSentinelChannel: Smallint]: Smallint dispid 1050;
    property SentinelActionParameter[nSentinelChannel: Smallint]: Smallint dispid 1047;
    property RemoteOutX[nCANBus: Smallint; nNode: Smallint; nOutput: Smallint]: WordBool dispid 1036;
    property RemotePDOIn[nBus: Smallint; lCOBID: Integer; nBank: Smallint]: Integer readonly dispid 1037;
    property RemotePDOMode[nBus: Smallint; nNode: Smallint]: Smallint dispid 1038;
    property RemotePDOValid[nBus: Smallint; nNode: Smallint]: WordBool readonly dispid 1039;
    property SentinelAction[nSentinelChannel: Smallint]: Smallint dispid 1045;
    property RemoteInX[nCANBus: Smallint; nNode: Smallint; nInput: Smallint]: WordBool readonly dispid 1025;
    property ScaleUnits[nAxis: Smallint; nChannel: Smallint]: Smallint dispid 1044;
    property SentinelActionMode[nSentinelChannel: Smallint]: Smallint dispid 1046;
    property OptionCardNetworkStatus[nSlot: Smallint]: Smallint readonly dispid 925;
    property OptionCardObjectFloat[nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                   lAttribute: Integer; nType: Smallint]: Single dispid 927;
    property OptionCardObjectString[nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                    lAttribute: Integer; nType: Smallint]: WideString dispid 928;
    property OptionCardObjectInteger[nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                     lAttribute: Integer; nType: Smallint]: Integer dispid 926;
    property OptionCardStatus[nSlot: Smallint]: Smallint readonly dispid 929;
    property OptionCardType[nSlot: Smallint]: Smallint readonly dispid 930;
    property OptionCardVersion[nSlot: Smallint; nItem: Smallint]: Smallint readonly dispid 931;
    property Out[nBank: Smallint]: Integer dispid 932;
    property OutputMonitorMode[nOutput: Smallint]: Smallint dispid 934;
    property OutX[nOutput: Smallint]: WordBool dispid 937;
    property ParameterValuesSubset[nSubset: Smallint; nParameter: Smallint]: OleVariant readonly dispid 940;
    property OutputType[nOutput: Smallint]: Smallint readonly dispid 936;
    property OutputActiveLevel[nBank: Smallint]: Integer dispid 933;
    property ParameterListString[nParameter: Smallint; nEnumeration: Smallint]: WideString readonly dispid 938;
    property ParameterNumberSubset[nSubset: Smallint]: OleVariant readonly dispid 939;
    property ParamSaveMode[nChannel: Smallint]: WordBool dispid 941;
    property PDOLossMode[nAxis: Smallint]: Smallint dispid 942;
    property PhaseSearchCurrent[nAxis: Smallint]: Single dispid 945;
    property PhaseSearchBackoff[nAxis: Smallint]: Smallint dispid 943;
    property PhaseSearchSpeed[nAxis: Smallint]: Smallint dispid 949;
    property PhaseSearchBandwidth[nAxis: Smallint]: Single dispid 944;
    property PhaseSearchOutput[nAxis: Smallint]: Smallint dispid 948;
    property PLCOperator[nChannel: Smallint; nConditionNo: Smallint]: Smallint dispid 954;
    property PhaseSearchStatus[nAxis: Smallint]: WordBool readonly dispid 950;
    property PhaseSearchTravel[nAxis: Smallint]: Smallint dispid 951;
    property PLCCondition[nChannel: Smallint; nConditionNo: Smallint]: Smallint dispid 952;
    property PLCTaskData[nChannel: Smallint; var pnCondition1: Smallint; var pnParam1: Smallint; 
                         var pnOperator: Smallint; var pnCondition2: Smallint; 
                         var pnParam2: Smallint]: WordBool readonly dispid 956;
    property PLCEnableAction[nChannel: Smallint]: WordBool dispid 953;
    property PLCParameter[nChannel: Smallint; nConditionNo: Smallint]: Smallint dispid 955;
    property TorqueDemand[nAxis: Smallint]: Single readonly dispid 1126;
    property StopInput[nAxis: Smallint]: Smallint dispid 1109;
    property StepperScale[nChannel: Smallint]: Single dispid 1106;
    property StepperIO[nAxis: Smallint]: Smallint dispid 1104;
    property StepperWrap[nChannel: Smallint]: Single dispid 1108;
    property SplineStart[nAxis: Smallint]: Integer dispid 1097;
    property SplineSuspendTime[nAxis: Smallint]: Integer dispid 1098;
    property StepperVel[nChannel: Smallint]: Single readonly dispid 1107;
    property Stepper[nChannel: Smallint]: Single dispid 1102;
    property StepperDelay[nChannel: Smallint]: Single dispid 1103;
    property SpeedRefDecelTime[nAxis: Smallint]: Single dispid 1087;
    property SpeedRefAccelTime[nAxis: Smallint]: Single dispid 1084;
    property SpeedRefDecelJerkEndTime[nAxis: Smallint]: Single dispid 1085;
    property SpeedRefDecelJerkStartTime[nAxis: Smallint]: Single dispid 1086;
    property StepperMode[nChannel: Smallint]: Smallint dispid 1105;
    property Spline[nAxis: Smallint]: Smallint dispid 1094;
    property SplineEnd[nAxis: Smallint]: Integer dispid 1095;
    property SoftLimitReverse[nAxis: Smallint]: Single dispid 1064;
    property SoftwareDiagnostic[nParam1: Smallint; nParam2: Smallint]: Integer readonly dispid 1065;
    property SerialBaud[nPort: Smallint]: Integer dispid 1059;
    property SoftLimitForward[nAxis: Smallint]: Single dispid 1062;
    property SentinelTriggerValueInteger[nSentinelChannel: Smallint; nSentinelBand: Smallint]: Integer dispid 1058;
    property SentinelSource2[nSentinelChannel: Smallint]: Smallint dispid 1052;
    property SentinelSource2Parameter[nSentinelChannel: Smallint]: Smallint dispid 1053;
    property SoftLimitMode[nAxis: Smallint]: Smallint dispid 1063;
    property SRamp[nAxis: Smallint]: Single dispid 1100;
    property StaticHandle[const lpszTask: WideString; const lpszVariable: WideString]: Integer readonly dispid 1101;
    property SplineIndex[nAxis: Smallint]: Integer readonly dispid 1096;
    property SerialBaudsSupported[nChannel: Smallint]: OleVariant readonly dispid 1060;
    property Sextant[nAxis: Smallint]: Smallint dispid 1061;
    property SplineTime[nAxis: Smallint]: Integer dispid 1099;
    property JogAwayOffset[nAxis: Smallint]: Single readonly dispid 767;
    property InState[nBank: Smallint]: Integer readonly dispid 760;
    property InputActiveLevel[nBank: Smallint]: Integer dispid 755;
    property JogAway[nAxis: Smallint]: Smallint dispid 766;
    property IncR[nAxis: Smallint]: Single writeonly dispid 753;
    property InKey[nTerminalID: Integer]: Smallint readonly dispid 754;
    property InputDebounce[nBank: Smallint]: Smallint dispid 756;
    property IncA[nAxis: Smallint]: Single writeonly dispid 752;
    property JogCommand[nAxis: Smallint]: Smallint dispid 768;
    property In_[nBank: Smallint]: Integer readonly dispid 751;
    property Jog[nAxis: Smallint]: Single dispid 764;
    property HTADeadband[nAxis: Smallint]: Single dispid 740;
    property InX[nInput: Smallint]: WordBool readonly dispid 763;
    property JogAccelTimeMax[nAxis: Smallint]: Integer dispid 765;
    property InStateX[nInput: Smallint]: WordBool readonly dispid 761;
    property InternalData[nEnum1: Smallint; nEnum2: Smallint]: OleVariant readonly dispid 762;
    property InputNegTrigger[nBank: Smallint]: Integer dispid 758;
    property SpeedTestRefAccelTime[nAxis: Smallint]: Single dispid 1092;
    property SpeedTestRefDecelTime[nAxis: Smallint]: Single dispid 1093;
    property SpeedTestRef[nAxis: Smallint]: Single dispid 1091;
    property SpeedRefAccelJerkEndTime[nAxis: Smallint]: Single dispid 1081;
    property SpeedRefAccelJerkStartTime[nAxis: Smallint]: Single dispid 1082;
    property SpeedRefAccelSource[nAxis: Smallint]: Smallint dispid 1083;
    property InputMode[nBank: Smallint]: Integer dispid 757;
    property SpeedRefErrorDecelTime[nAxis: Smallint]: Single dispid 1089;
    property InputPosTrigger[nBank: Smallint]: Integer dispid 759;
    property SpeedRefEnable[nAxis: Smallint]: WordBool dispid 1088;
    property SpeedRefSource[nAxis: Smallint]: Smallint dispid 1090;
    property VFThreePointFreq[nAxis: Smallint]: Single dispid 1167;
    property VFThreePointMode[nAxis: Smallint]: Smallint dispid 1168;
    property TriggerValue[nAxis: Smallint]: Single dispid 1145;
    property UserMotion[nAxis: Smallint]: Smallint writeonly dispid 1146;
    property VelScaleFactor[nAxis: Smallint]: Single dispid 1158;
    property ZeroSpeedDeadband[nAxis: Smallint]: Single dispid 1171;
    property VFProfile[nAxis: Smallint]: Single dispid 1165;
    property VFSlipCompensationMode[nAxis: Smallint]: Smallint dispid 1166;
    property TriggerMode[nAxis: Smallint]: Smallint dispid 1143;
    property TriggerSource[nAxis: Smallint]: Smallint dispid 1144;
    property VelFatalMode[nAxis: Smallint]: Smallint dispid 1156;
    property UserTimeUnits[nAxis: Smallint]: WideString dispid 1148;
    property UserPositionUnits[nAxis: Smallint]: WideString dispid 1147;
    property TriggerInput[nAxis: Smallint]: Smallint dispid 1142;
    procedure AboutBox; dispid -552;
    property VFDeadband[nAxis: Smallint; nChannel: Smallint]: Single dispid 1163;
    property TerminalMode[nTerminalID: Integer]: Smallint dispid 1121;
    property TerminalPort[nTerminalID: Integer]: Smallint dispid 1122;
    property VFDeadbandCentreFreq[nAxis: Smallint; nChannel: Smallint]: Single dispid 1164;
    property VFBoostTransitionMode[nAxis: Smallint]: Smallint dispid 1162;
    property TerminalXoff[nTerminalID: Integer]: WordBool writeonly dispid 1123;
    property TerminalDevice[nTerminalID: Integer]: Smallint dispid 1120;
    property VelSetpointMax[nAxis: Smallint]: Single dispid 1160;
    property VFThreePointVolts[nAxis: Smallint]: Single dispid 1169;
    property VoltageDemand[nAxis: Smallint; nChannel: Smallint]: Single readonly dispid 1170;
    property VelScaleUnits[nAxis: Smallint]: WideString dispid 1159;
    property VelSetpointMin[nAxis: Smallint]: Single dispid 1161;
    property SpeedMeasured[nAxis: Smallint]: Single readonly dispid 1075;
    property SpeedObserverK1[nAxis: Smallint]: Single dispid 1077;
    property SpeedObserverKJ[nAxis: Smallint]: Single dispid 1079;
    property SpeedFilterType[nAxis: Smallint]: Smallint dispid 1074;
    property SpeedObserverK2[nAxis: Smallint]: Single dispid 1078;
    property SpeedFilterRipple[nAxis: Smallint]: Single dispid 1073;
    property SpeedRef[nAxis: Smallint]: Single dispid 1080;
    property SpeedObserverEnable[nAxis: Smallint]: WordBool dispid 1076;
    property SentinelState[nSentinelChannel: Smallint]: Smallint readonly dispid 1054;
    property SentinelTriggerMode[nSentinelChannel: Smallint]: Smallint dispid 1056;
    property SentinelTriggerValueFloat[nSentinelChannel: Smallint; nSentinelBand: Smallint]: Single dispid 1057;
    property SentinelSourceParameter[nSentinelChannel: Smallint]: Smallint dispid 1051;
    property Speed[nAxis: Smallint]: Single dispid 1066;
    property SentinelTriggerAbsolute[nSentinelChannel: Smallint]: WordBool dispid 1055;
    property SpeedError[nAxis: Smallint]: Single readonly dispid 1068;
    property VariableData[const bstrTaskName: WideString; const bstrVarName: WideString]: OleVariant dispid 1149;
    property VectorAngle[nAxisX: Smallint; nAxisY: Smallint]: Single readonly dispid 1150;
    property Vel[nAxis: Smallint]: Single readonly dispid 1151;
    property VelDemand[nAxis: Smallint]: Single readonly dispid 1152;
    property VelDemandPath[nAxis: Smallint]: Single readonly dispid 1153;
    property VelRef[nAxis: Smallint]: Single dispid 1157;
    property VelFatal[nAxis: Smallint]: Single dispid 1155;
    property VelError[nAxis: Smallint]: Single readonly dispid 1154;
    property SpeedDemand[nAxis: Smallint]: Single dispid 1067;
    property SpeedFilterBand[nAxis: Smallint]: Single dispid 1070;
    property SpeedErrorFatal[nAxis: Smallint]: Single dispid 1069;
    property SpeedFilterFreq[nAxis: Smallint]: Single dispid 1071;
    property SpeedFilterPoles[nAxis: Smallint]: Smallint dispid 1072;
    property USBDriverVersion: WideString dispid 123;
    property USBDeviceList: OleVariant dispid 122;
    property TimerEvent: Integer dispid 121;
    property Time: Integer dispid 120;
    property SystemState: Smallint dispid 119;
    property SystemSeconds: Single dispid 118;
    property SupportsMint: WordBool dispid 117;
    property ServerVersion: WideString dispid 116;
    property SerialHandshakeMode: Smallint dispid 115;
    property SerialChar: Smallint dispid 114;
    property SerialBufferUsage: Smallint dispid 113;
    property ScanOverrunLimit: Smallint dispid 112;
    property ReleaseBuild: WordBool dispid 111;
    property RealTimeClock: TDateTime dispid 110;
    property RAMTest: Smallint dispid 109;
    property PWMPeriod: Smallint dispid 108;
    property PulseDirMode: Smallint dispid 107;
    property PulseCounter: Integer dispid 106;
    property ProfileTime: Smallint dispid 105;
    property ProductSerialNumber: WideString dispid 104;
    property ProductCatalogNumber: WideString dispid 103;
    property PresetTriggerInputOld: Smallint dispid 102;
    property PresetSelectorInputOld: Smallint dispid 101;
    property PresetMoveEnableOld: Smallint dispid 100;
    property PresetInputStateOld: Smallint dispid 99;
    property PresetInputsMaxOld: Smallint dispid 98;
    property PresetIndexSourceOld: Smallint dispid 97;
    property PresetIndexModeOld: Smallint dispid 96;
    property PresetIndexOld: Smallint dispid 95;
    property PresetDwellTimeOld: Integer dispid 94;
    property PortSpeed: Integer dispid 93;
    property PortNumber: Smallint dispid 92;
    property PLCTime: Smallint dispid 91;
    property PLCStatus: Integer dispid 90;
    property PLCGearFactor: Smallint dispid 89;
    property PLCEnable: WordBool dispid 88;
    property PLCAutoEnable: WordBool dispid 87;
    property PlatformName: WideString dispid 86;
    property Platform: Integer dispid 85;
    property ParameterTableVersion: Integer dispid 84;
    property NodeNumber: Smallint dispid 83;
    property Node: Smallint dispid 82;
    property MiscErrorDisable: Integer dispid 81;
    property MiscError: Integer dispid 80;
    property MintLineExecuting: Integer dispid 79;
    property MintExecuting: WordBool dispid 78;
    property MILErrorOffsetGlobal: Smallint dispid 77;
    property Looptime: Smallint dispid 76;
    property LogTXEnabled: WordBool dispid 75;
    property LogRXEnabled: WordBool dispid 74;
    property LogFilename: WideString dispid 73;
    property LogCommsErrors: WordBool dispid 72;
    property Lifetime: Integer dispid 71;
    property LEDDisplay: Integer dispid 70;
    property LED: Smallint dispid 69;
    property LanguagePack: WideString dispid 68;
    property Language: WideString dispid 67;
    property KeypadFirmwareVersion: WideString dispid 66;
    property InterfaceID: WideString dispid 65;
    property InitWarning: Integer dispid 64;
    property InitError: Integer dispid 63;
    property ICMChannel: Smallint dispid 62;
    property H2USBDeviceList: OleVariant dispid 61;
    property GlobalErrorOutput: Smallint dispid 60;
    property FirmwareVersion: WideString dispid 59;
    property FirmwareMintVMBuild: Smallint dispid 58;
    property FirmwareCRC: Integer dispid 57;
    property FeedbackFaultEnable: Smallint dispid 56;
    property ExtendedEventData: OleVariant dispid 55;
    property EventPending: Integer dispid 54;
    property EventDisable: Integer dispid 53;
    property EventActive: Integer dispid 52;
    property ErrString: WideString dispid 51;
    property ErrParamIndex: Smallint dispid 50;
    property ErrParamFamily: Smallint dispid 49;
    property ErrLine: Integer dispid 48;
    property ErrCode: Integer dispid 47;
    property EncoderZActiveLevel: WordBool dispid 46;
    property EncoderStates: Smallint dispid 45;
    property EEPROMSaveBufferStatus: WordBool dispid 44;
    property DriveUsedDate: WideString dispid 43;
    property DriveUsed: Smallint dispid 42;
    property DriveTestMode: Smallint dispid 41;
    property DriveFeedback: Smallint dispid 40;
    property DriveFaultMask: Integer dispid 39;
    property DIPSwitches: Smallint dispid 38;
    property DeviceOpen: WordBool dispid 37;
    property CustomerID: Smallint dispid 36;
    property CPUClockSpeed: Single dispid 35;
    property CountStatics: Integer dispid 34;
    property ControllerType: Smallint dispid 33;
    property ControllerPresent: WordBool dispid 32;
    property ControllerID: WideString dispid 31;
    property CommsTestMode: Smallint dispid 30;
    property CommsSync: WordBool dispid 29;
    property CommsMode: Smallint dispid 28;
    property CardNumber: Smallint dispid 27;
    property CaptureStatus: Smallint dispid 26;
    property CapturePreTriggerDuration: Integer dispid 25;
    property CapturePeriod: Integer dispid 24;
    property CaptureNumPoints: Smallint dispid 23;
    property CaptureInterval: Smallint dispid 22;
    property CaptureEventDelay: Smallint dispid 21;
    property CaptureEventAxis: Smallint dispid 20;
    property CaptureEvent: Smallint dispid 19;
    property CaptureDuration: Integer dispid 18;
    property CaptureCommand: Smallint dispid 17;
    property CaptureBufferSize: Integer dispid 16;
    property Capture: Smallint dispid 15;
    property BusEnable: WordBool dispid 14;
    property BufferChars: OleVariant dispid 13;
    property BootloaderDetails: WideString dispid 12;
    property BootloaderBaudsSupported: OleVariant dispid 11;
    property BetaBuild: WordBool dispid 10;
    property BaldorDebug: WordBool dispid 9;
    property AutotuneStatus: Smallint dispid 8;
    property AutotuneError: Smallint dispid 7;
    property AsyncErrorPresent: WordBool dispid 6;
    property AppDataWritePermission: WordBool dispid 5;
    property APIValueWriteMode: Smallint dispid 4;
    property ActiveRS485Node: Smallint dispid 3;
    property AAABuild: Integer dispid 2;
    property ShowProgressDialogs: WordBool dispid 1;
  end;

// *********************************************************************//
// DispIntf:  _DMintControllerEvents
// Flags:     (4096) Dispatchable
// GUID:      {A8A56C0C-FF29-4C7D-9418-EA321AF9A467}
// *********************************************************************//
  _DMintControllerEvents = dispinterface
    ['{A8A56C0C-FF29-4C7D-9418-EA321AF9A467}']
    procedure SerialReceiveEvent; dispid 1;
    procedure TimerEvent(nTimer: Smallint); dispid 2;
    procedure FastInEvent(nBank: Smallint; lActivatedInputs: Integer); dispid 3;
    procedure ErrorEvent; dispid 4;
    procedure BusEvent(nBusMap: Integer); dispid 5;
    procedure StopSwitchEvent; dispid 6;
    procedure InputEvent(nBank: Smallint; lActivatedInputs: Integer); dispid 7;
    procedure CommsEvent(lCommsEvent: Integer); dispid 8;
    procedure AxisIdleEvent(nAxisBitPattern: Smallint); dispid 9;
    procedure MoveBufferLowEvent(nAxisBitPattern: Smallint); dispid 10;
    procedure DPREvent(nCode: Smallint); dispid 11;
    procedure UnknownEvent(nCode: Smallint); dispid 12;
    procedure ResetEvent(nCode: Smallint); dispid 13;
    procedure KnifeEvent(nAxisBitPattern: Smallint); dispid 14;
    procedure MoveBufferFull(var bRetry: WordBool); dispid 15;
    procedure USBDeviceDisconnect; dispid 16;
    procedure LatchEvent(nLatchChannel: Smallint); dispid 17;
    procedure BusMessageEvent(nBusMap: Integer); dispid 18;
    procedure TerminalReceiveEvent; dispid 19;
    procedure StopEvent(nAxis: Integer); dispid 20;
    procedure NetDataEvent(lNetDataEvent: Integer); dispid 21;
  end;

// *********************************************************************//
// DispIntf:  _DCommandPromptCtrl
// Flags:     (4112) Hidden Dispatchable
// GUID:      {03D90033-7F46-4D59-96B6-A4CE30437D5F}
// *********************************************************************//
  _DCommandPromptCtrl = dispinterface
    ['{03D90033-7F46-4D59-96B6-A4CE30437D5F}']
    procedure SetSerialControllerLink(nControllerType: Smallint; nNode: Smallint; nPort: Smallint; 
                                      nSpeed: Integer; bOpenPort: WordBool); dispid 10;
    procedure setPCIControllerLink(nControllerType: Smallint; nNode: Smallint; nCard: Smallint); dispid 9;
    procedure setMintControllerID(const sID: WideString); dispid 2;
    procedure setCompiler(nVersion: Integer); dispid 4;
    procedure setSymbolTable(const sTable: WideString); dispid 3;
    procedure AboutBox; dispid -552;
    procedure SetEthernetControllerLink(const lpszAddress: WideString); dispid 8;
    procedure DisplayMacroEditor; dispid 7;
    procedure getContextKeyword(var psKeyword: WideString); dispid 5;
    procedure SetUSBControllerLink(nNode: Smallint); dispid 11;
    procedure setMintController(const pController: IUnknown); dispid 6;
    property OverType: WordBool dispid 1;
    property BorderStyle: Smallint dispid -504;
    property ForeColor: OLE_COLOR dispid -513;
    property Font: IFontDisp dispid -512;
    property BackColor: OLE_COLOR dispid -501;
  end;

// *********************************************************************//
// DispIntf:  _DCommandPromptEvents
// Flags:     (4096) Dispatchable
// GUID:      {402C4323-20C7-4FB4-9612-F1C4579336D9}
// *********************************************************************//
  _DCommandPromptEvents = dispinterface
    ['{402C4323-20C7-4FB4-9612-F1C4579336D9}']
  end;

// *********************************************************************//
// DispIntf:  _DMintTerminal
// Flags:     (4112) Hidden Dispatchable
// GUID:      {246FF878-870C-4AFD-9119-BA835A85C20E}
// *********************************************************************//
  _DMintTerminal = dispinterface
    ['{246FF878-870C-4AFD-9119-BA835A85C20E}']
    procedure AboutBox; dispid -552;
    procedure SetUSBControllerLink(nNode: Smallint); dispid 11;
    procedure SetSerialControllerLink(nControllerType: Smallint; nNode: Smallint; nPort: Smallint; 
                                      nSpeed: Integer; bOpenPort: WordBool); dispid 10;
    procedure setPCIControllerLink(nControllerType: Smallint; nNode: Smallint; nCard: Smallint); dispid 9;
    procedure SetEthernetControllerLink(const lpszAddress: WideString); dispid 8;
    procedure setMintController(const pController: IUnknown); dispid 7;
    procedure setMintControllerID(const sID: WideString); dispid 6;
    property BackColor: OLE_COLOR dispid -501;
    property ForeColor: OLE_COLOR dispid -513;
    property TerminalText: WideString dispid 5;
    property Columns: Smallint dispid 4;
    property Lines: Smallint dispid 3;
    property TerminalFont: IFontDisp dispid 2;
    property AutoFit: WordBool dispid 1;
  end;

// *********************************************************************//
// DispIntf:  _DMintTerminalEvents
// Flags:     (4096) Dispatchable
// GUID:      {B023086C-06BC-4637-AB9D-FBCC4A6826DA}
// *********************************************************************//
  _DMintTerminalEvents = dispinterface
    ['{B023086C-06BC-4637-AB9D-FBCC4A6826DA}']
    procedure KeyPress(var KeyAscii: Smallint); dispid -603;
  end;

// *********************************************************************//
// DispIntf:  ISinkForServerEvents
// Flags:     (4096) Dispatchable
// GUID:      {66B03FD3-2A76-4CB2-9634-F6F44AC752DD}
// *********************************************************************//
  ISinkForServerEvents = dispinterface
    ['{66B03FD3-2A76-4CB2-9634-F6F44AC752DD}']
  end;

// *********************************************************************//
// DispIntf:  IOCXSerialEventSink
// Flags:     (4096) Dispatchable
// GUID:      {3C3B44B3-1DD8-4AE9-888B-B7547499E9D5}
// *********************************************************************//
  IOCXSerialEventSink = dispinterface
    ['{3C3B44B3-1DD8-4AE9-888B-B7547499E9D5}']
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMintController
// Help String      : Mint Controller Build 5626
// Default Interface: _DMintControllerCtrl
// Def. Intf. DISP? : Yes
// Event   Interface: _DMintControllerEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TMintControllerTimerEvent = procedure(ASender: TObject; nTimer: Smallint) of object;
  TMintControllerFastInEvent = procedure(ASender: TObject; nBank: Smallint; 
                                                           lActivatedInputs: Integer) of object;
  TMintControllerBusEvent = procedure(ASender: TObject; nBusMap: Integer) of object;
  TMintControllerInputEvent = procedure(ASender: TObject; nBank: Smallint; lActivatedInputs: Integer) of object;
  TMintControllerCommsEvent = procedure(ASender: TObject; lCommsEvent: Integer) of object;
  TMintControllerAxisIdleEvent = procedure(ASender: TObject; nAxisBitPattern: Smallint) of object;
  TMintControllerMoveBufferLowEvent = procedure(ASender: TObject; nAxisBitPattern: Smallint) of object;
  TMintControllerDPREvent = procedure(ASender: TObject; nCode: Smallint) of object;
  TMintControllerUnknownEvent = procedure(ASender: TObject; nCode: Smallint) of object;
  TMintControllerResetEvent = procedure(ASender: TObject; nCode: Smallint) of object;
  TMintControllerKnifeEvent = procedure(ASender: TObject; nAxisBitPattern: Smallint) of object;
  TMintControllerMoveBufferFull = procedure(ASender: TObject; var bRetry: WordBool) of object;
  TMintControllerLatchEvent = procedure(ASender: TObject; nLatchChannel: Smallint) of object;
  TMintControllerBusMessageEvent = procedure(ASender: TObject; nBusMap: Integer) of object;
  TMintControllerStopEvent = procedure(ASender: TObject; nAxis: Integer) of object;
  TMintControllerNetDataEvent = procedure(ASender: TObject; lNetDataEvent: Integer) of object;

  TMintController = class(TOleControl)
  private
    FOnSerialReceiveEvent: TNotifyEvent;
    FOnTimerEvent: TMintControllerTimerEvent;
    FOnFastInEvent: TMintControllerFastInEvent;
    FOnErrorEvent: TNotifyEvent;
    FOnBusEvent: TMintControllerBusEvent;
    FOnStopSwitchEvent: TNotifyEvent;
    FOnInputEvent: TMintControllerInputEvent;
    FOnCommsEvent: TMintControllerCommsEvent;
    FOnAxisIdleEvent: TMintControllerAxisIdleEvent;
    FOnMoveBufferLowEvent: TMintControllerMoveBufferLowEvent;
    FOnDPREvent: TMintControllerDPREvent;
    FOnUnknownEvent: TMintControllerUnknownEvent;
    FOnResetEvent: TMintControllerResetEvent;
    FOnKnifeEvent: TMintControllerKnifeEvent;
    FOnMoveBufferFull: TMintControllerMoveBufferFull;
    FOnUSBDeviceDisconnect: TNotifyEvent;
    FOnLatchEvent: TMintControllerLatchEvent;
    FOnBusMessageEvent: TMintControllerBusMessageEvent;
    FOnTerminalReceiveEvent: TNotifyEvent;
    FOnStopEvent: TMintControllerStopEvent;
    FOnNetDataEvent: TMintControllerNetDataEvent;
    FIntf: _DMintControllerCtrl;
    function  GetControlInterface: _DMintControllerCtrl;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    procedure Set_AccelSensorKInt(nAxis: Smallint; Param2: Single);
    function Get_AccelSensorKProp(nAxis: Smallint): Single;
    function Get_AccelSensorKInt(nAxis: Smallint): Single;
    function Get_AccelScaleUnits(nAxis: Smallint): WideString;
    procedure Set_AccelScaleUnits(nAxis: Smallint; const Param2: WideString);
    procedure Set_AccelSensorEnable(nAxis: Smallint; Param2: WordBool);
    function Get_ADCErrorMode(nAxis: Smallint): Smallint;
    procedure Set_ADCErrorMode(nAxis: Smallint; Param2: Smallint);
    function Get_ADCError(nAxis: Smallint): Integer;
    function Get_AccelSensorFilterFreq(nAxis: Smallint): Single;
    procedure Set_AccelSensorFilterFreq(nAxis: Smallint; Param2: Single);
    procedure Set_AccelSensorVelErrorFatal(nAxis: Smallint; Param2: Single);
    function Get_AccelSensorDelay(nAxis: Smallint): Smallint;
    procedure Set_AccelSensorScale(nAxis: Smallint; Param2: Single);
    function Get_AccelSensorVelError(nAxis: Smallint): Single;
    function Get_AccelSensorVelErrorFatal(nAxis: Smallint): Single;
    function Get_AccelSensorOffset(nAxis: Smallint): Single;
    function Get_AccelSensorMode(nAxis: Smallint): Smallint;
    procedure Set_AccelSensorMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_AccelSensorKProp(nAxis: Smallint; Param2: Single);
    procedure Set_AccelSensorDelay(nAxis: Smallint; Param2: Smallint);
    function Get_AccelSensorEnable(nAxis: Smallint): WordBool;
    function Get_AccelSensorVel(nAxis: Smallint): Single;
    function Get_AccelSensorType(nAxis: Smallint): Smallint;
    procedure Set_AccelSensorType(nAxis: Smallint; Param2: Smallint);
    function Get_ADCDeadbandOffset(nChannel: Smallint): Single;
    function Get_ADCDeadband(nChannel: Smallint): Single;
    function Get_ActiveEventCodes(nEvent: Smallint): OleVariant;
    function Get_ADC(nChannel: Smallint): Single;
    procedure Set_AccelTimeMax(nAxis: Smallint; Param2: Integer);
    procedure Set_ADCDeadband(nChannel: Smallint; Param2: Single);
    function Get_ADCDeadbandHysteresis(nChannel: Smallint): Single;
    procedure Set_AccelSensorVelErrorMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_ADCMax(nChannel: Smallint; Param2: Single);
    procedure Set_ADCGain(nChannel: Smallint; Param2: Single);
    procedure Set_ADCFilter(nChannel: Smallint; Param2: Single);
    procedure Set_ADCDeadbandOffset(nChannel: Smallint; Param2: Single);
    function Get_ADCFilter(nChannel: Smallint): Single;
    function Get_ADCMax(nChannel: Smallint): Single;
    function Get_AccelTimeMax(nAxis: Smallint): Integer;
    function Get_AccelTime(nAxis: Smallint): Integer;
    function Get_AccelSensorVelErrorMode(nAxis: Smallint): Smallint;
    function Get_ADCGain(nChannel: Smallint): Single;
    procedure Set_ADCDeadbandHysteresis(nChannel: Smallint; Param2: Single);
    procedure Set_AccelTime(nAxis: Smallint; Param2: Integer);
    function Get_AccelSensorScale(nAxis: Smallint): Single;
    procedure Set_RelayOut(nBank: Smallint; Param2: Integer);
    procedure Set_RelayOutX(nRelay: Smallint; Param2: WordBool);
    function Get_RemoteADC(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint): Single;
    function Get_PWMOnTime(nAxis: Smallint): Smallint;
    procedure Set_PWMOnTime(nAxis: Smallint; Param2: Smallint);
    function Get_ReadKey(nTermID: Integer): Smallint;
    function Get_RelayOutX(nRelay: Smallint): WordBool;
    function Get_RemoteADCDelta(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint): Smallint;
    function Get_RelayOutputBankSetup(nBank: Smallint): Smallint;
    procedure Set_RelayOutputBankSetup(nBank: Smallint; Param2: Smallint);
    procedure Set_AccelJerkTime(nAxis: Smallint; Param2: Integer);
    procedure Set_AccelJerk(nAxis: Smallint; Param2: Single);
    function Get_AccelJerkTime(nAxis: Smallint): Integer;
    function Get_AccelJerk(nAxis: Smallint): Single;
    function Get_AccelScaleFactor(nAxis: Smallint): Single;
    procedure Set_AccelScaleFactor(nAxis: Smallint; Param2: Single);
    procedure Set_AbortMode(nAxis: Smallint; Param2: Smallint);
    function Get_AbortMode(nAxis: Smallint): Smallint;
    procedure Set_AbsEncoderSinOffset(nAxis: Smallint; Param2: Smallint);
    function Get_AbsEncoder(nAxis: Smallint): Integer;
    function Get_AbsEncoderCosOffset(nAxis: Smallint): Smallint;
    procedure Set_AbsEncoderTurns(nChannel: Smallint; Param2: Integer);
    function Get_AccelDemand(nAxis: Smallint): Single;
    function Get_Accel(nAxis: Smallint): Single;
    function Get_AbsEncoderTurns(nChannel: Smallint): Integer;
    procedure Set_Accel(nAxis: Smallint; Param2: Single);
    function Get_PresetSelectorInput(nAxis: Smallint): Smallint;
    procedure Set_PresetSelectorInput(nAxis: Smallint; Param2: Smallint);
    function Get_PresetTriggerInput(nAxis: Smallint): Smallint;
    procedure Set_PresetTriggerInput(nAxis: Smallint; Param2: Smallint);
    function Get_ProfileMode(nAxis: Smallint): Smallint;
    procedure Set_ProfileMode(nAxis: Smallint; Param2: Smallint);
    function Get_PresetJogDirection(nPreset: Smallint): Smallint;
    function Get_PresetIndexSource(nAxis: Smallint): Smallint;
    procedure Set_PresetIndexSource(nAxis: Smallint; Param2: Smallint);
    function Get_PresetMoveParameter(nPreset: Smallint; nParam: Smallint): Single;
    procedure Set_PresetInputsMax(nAxis: Smallint; Param2: Smallint);
    function Get_PresetInputState(nAxis: Smallint): Smallint;
    procedure Set_PresetMoveType(nPreset: Smallint; nParam: Smallint; Param3: Smallint);
    procedure Set_RemoteStatus(nCANBus: Smallint; nNode: Smallint; Param3: Smallint);
    function Get_ResetInput(nAxis: Smallint): Smallint;
    procedure Set_ResetInput(nAxis: Smallint; Param2: Smallint);
    function Get_RevCountDeadband(nAxis: Smallint): Smallint;
    procedure Set_RevCountDeadband(nAxis: Smallint; Param2: Smallint);
    function Get_ScaleFactor(nAxis: Smallint): Single;
    procedure Set_PresetMoveParameter(nPreset: Smallint; nParam: Smallint; Param3: Single);
    function Get_PresetMovePosition(nPreset: Smallint): Single;
    procedure Set_PresetMovePosition(nPreset: Smallint; Param2: Single);
    function Get_PresetMoveSpeed(nPreset: Smallint): Single;
    procedure Set_PresetMoveSpeed(nPreset: Smallint; Param2: Single);
    function Get_PresetMoveType(nPreset: Smallint; nParam: Smallint): Smallint;
    function Get_PresetInputsMax(nAxis: Smallint): Smallint;
    procedure Set_RemoteEncoder(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint; 
                                Param4: Integer);
    function Get_RemoteError(nCANBus: Smallint; nNode: Smallint): Smallint;
    function Get_RemoteDebounce(nCANBus: Smallint; nNode: Smallint): Smallint;
    procedure Set_RemoteComms(nBus: Smallint; nNode: Smallint; nIndex: Smallint; Param4: Single);
    procedure Set_RemoteDAC(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint; Param4: Single);
    function Get_RemoteEncoder(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint): Integer;
    function Get_Relay(nBank: Smallint): WordBool;
    procedure Set_Relay(nBank: Smallint; Param2: WordBool);
    function Get_RelayOut(nBank: Smallint): Integer;
    procedure Set_RemoteDebounce(nCANBus: Smallint; nNode: Smallint; Param3: Smallint);
    function Get_RemoteEmergencyMessage(nCANBus: Smallint; nNode: Smallint): Smallint;
    procedure Set_RemoteADCDelta(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint; 
                                 Param4: Smallint);
    function Get_RemoteComms(nBus: Smallint; nNode: Smallint; nIndex: Smallint): Single;
    procedure Set_PresetMoveHomeType(nPreset: Smallint; Param2: Smallint);
    function Get_PresetJogSpeed(nPreset: Smallint): Single;
    procedure Set_PresetJogSpeed(nPreset: Smallint; Param2: Single);
    procedure Set_PresetJogDirection(nPreset: Smallint; Param2: Smallint);
    procedure Set_PresetMoveEnable(nAxis: Smallint; Param2: WordBool);
    function Get_PresetMoveHomeType(nPreset: Smallint): Smallint;
    procedure Set_RemoteCommsInteger(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                     Param4: Integer);
    function Get_RemoteDAC(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint): Single;
    procedure Set_RemoteBaud(nCANBus: Smallint; Param2: Integer);
    function Get_PresetMoveEnable(nAxis: Smallint): WordBool;
    procedure Set_PulseOutX(nChannel: Smallint; Param2: Integer);
    function Get_RemoteCommsInteger(nBus: Smallint; nNode: Smallint; nIndex: Smallint): Integer;
    procedure Set_AbsEncoderCosOffset(nAxis: Smallint; Param2: Smallint);
    procedure Set_ADCMode(nChannel: Smallint; Param2: Smallint);
    procedure Set_ADCMin(nChannel: Smallint; Param2: Single);
    function Get_ADCMode(nChannel: Smallint): Smallint;
    function Get_AnalogOutputSetup(nChannel: Smallint): Smallint;
    function Get_ADCMonitor(nAxis: Smallint): Integer;
    procedure Set_ADCMonitor(nAxis: Smallint; Param2: Integer);
    procedure Set_ADCTimeConstant(nChannel: Smallint; Param2: Single);
    procedure Set_ADCOffset(nChannel: Smallint; Param2: Single);
    function Get_ADCTimeConstant(nChannel: Smallint): Single;
    function Get_ADCOffset(nChannel: Smallint): Single;
    function Get_AnalogInputSetup(nChannel: Smallint): Smallint;
    procedure Set_AnalogInputSetup(nChannel: Smallint; Param2: Smallint);
    procedure Set_AutoStartMode(nAxis: Smallint; Param2: Smallint);
    function Get_AutoHomeMode(nAxis: Smallint): Smallint;
    function Get_APIValue(nTable: Smallint; nFamily: Smallint; nIndex: Smallint; vArgs: OleVariant): OleVariant;
    procedure Set_AnalogOutputSetup(nChannel: Smallint; Param2: Smallint);
    procedure Set_APIValue(nTable: Smallint; nFamily: Smallint; nIndex: Smallint; 
                           vArgs: OleVariant; Param5: OleVariant);
    function Get_AuxDAC(nChannel: Smallint): Single;
    function Get_AutotuneParam(nParam: Smallint): Single;
    function Get_AutoStartMode(nAxis: Smallint): Smallint;
    function Get_APIArgumentValues(nTable: Smallint; nArgument: Smallint): OleVariant;
    procedure Set_AutoHomeMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_AutotuneParam(nParam: Smallint; Param2: Single);
    procedure Set_AuxDAC(nChannel: Smallint; Param2: Single);
    procedure Set_AuxDACMode(nChannel: Smallint; Param2: Smallint);
    procedure Set_AuxEncoderMode(nAuxChannel: Smallint; Param2: Smallint);
    procedure Set_AuxEncoderScale(nAuxChannel: Smallint; Param2: Single);
    function Get_AuxEncoderMode(nAuxChannel: Smallint): Smallint;
    function Get_AuxEncoder(nAuxChannel: Smallint): Single;
    function Get_AuxDACMode(nChannel: Smallint): Smallint;
    procedure Set_AuxEncoderPreScale(nAuxChannel: Smallint; Param2: Integer);
    function Get_ADCMin(nChannel: Smallint): Single;
    procedure Set_AccelSensorOffset(nAxis: Smallint; Param2: Single);
    function Get_AuxEncoderSpeed(nAuxChannel: Smallint): Single;
    function Get_AuxEncoderScale(nAuxChannel: Smallint): Single;
    function Get_AuxEncoderPreScale(nAuxChannel: Smallint): Integer;
    procedure Set_AuxEncoder(nAuxChannel: Smallint; Param2: Single);
    function Get_AuxEncoderVel(nAuxChannel: Smallint): Single;
    function Get_AuxEncoderWrap(nAuxChannel: Smallint): Single;
    procedure Set_AuxEncoderZeroLatchMode(nAuxChannel: Smallint; Param2: Smallint);
    procedure Set_AuxEncoderZeroEnable(nAuxChannel: Smallint; Param2: WordBool);
    function Get_AuxEncoderZeroLatchMode(nAuxChannel: Smallint): Smallint;
    procedure Set_AuxEncoderWrap(nAuxChannel: Smallint; Param2: Single);
    function Get_AuxEncoderZeroPosition(nAuxChannel: Smallint): Single;
    function Get_AuxEncoderZLatch(nAuxChannel: Smallint): WordBool;
    procedure Set_AuxEncoderSpeed(nAuxChannel: Smallint; Param2: Single);
    function Get_AxisADC(nAxis: Smallint): Smallint;
    procedure Set_AxisADC(nAxis: Smallint; Param2: Smallint);
    function Get_AverageVel(nAxis: Smallint): Single;
    function Get_AbsEncoderOffset(nAxis: Smallint): Integer;
    procedure Set_AbsEncoderOffset(nAxis: Smallint; Param2: Integer);
    procedure Set_AbsEncoderSinGain(nAxis: Smallint; Param2: Smallint);
    function Get_AbsEncoderSinOffset(nAxis: Smallint): Smallint;
    function Get_AbsEncoderSinGain(nAxis: Smallint): Smallint;
    procedure Set_AxisPosEncoder(nAxis: Smallint; Param2: Smallint);
    procedure Set_AxisSyncDelay(nAxis: Smallint; Param2: Integer);
    procedure Set_AxisWarning(nAxis: Smallint; Param2: Integer);
    function Get_AxisSyncDelay(nAxis: Smallint): Integer;
    function Get_AxisStatus(nAxis: Smallint): Integer;
    function Get_AxisPosEncoder(nAxis: Smallint): Smallint;
    procedure Set_AxisVelEncoder(nAxis: Smallint; Param2: Smallint);
    procedure Set_AxisPDOutput(nAxis: Smallint; Param2: Smallint);
    procedure Set_AxisDAC(nAxis: Smallint; Param2: Smallint);
    function Get_AxisWarningDisable(nAxis: Smallint): Integer;
    function Get_AxisWarning(nAxis: Smallint): Integer;
    function Get_AxisVelEncoder(nAxis: Smallint): Smallint;
    function Get_AxisStatusWord(nAxis: Smallint): Smallint;
    procedure Set_Cam(nAxis: Smallint; Param2: Smallint);
    function Get_CamAmplitude(nAxis: Smallint): Single;
    function Get_CamEnd(nAxis: Smallint): Integer;
    function Get_CamBox(nCamBox: Smallint): Smallint;
    procedure Set_CamBox(nCamBox: Smallint; Param2: Smallint);
    procedure Set_CamAmplitude(nAxis: Smallint; Param2: Single);
    procedure Set_CamEnd(nAxis: Smallint; Param2: Integer);
    function Get_CamIndex(nAxis: Smallint): Integer;
    procedure Set_BusBaud(nBusID: Smallint; Param2: Integer);
    function Get_CamStart(nAxis: Smallint): Integer;
    procedure Set_CamStart(nAxis: Smallint; Param2: Integer);
    function Get_CamPhaseStatus(nAxis: Smallint): Smallint;
    function Get_AxisError(nAxis: Smallint): Integer;
    procedure Set_BurnInParameter(nParam: Smallint; Param2: Single);
    function Get_BusBaud(nBusID: Smallint): Integer;
    function Get_BurnInParameter(nParam: Smallint): Single;
    function Get_BridgeCompEnable(nAxis: Smallint): WordBool;
    procedure Set_BridgeCompEnable(nAxis: Smallint; Param2: WordBool);
    procedure Set_BridgeErrorVoltage(nAxis: Smallint; Param2: Single);
    procedure Set_BacklashInterval(nAxis: Smallint; Param2: Smallint);
    function Get_BacklashMode(nAxis: Smallint): Smallint;
    function Get_BacklashInterval(nAxis: Smallint): Smallint;
    function Get_BufferDepth(nBuffer: Smallint; nParam: Smallint): Integer;
    procedure Set_BufferDepth(nBuffer: Smallint; nParam: Smallint; Param3: Integer);
    procedure Set_Boost(nAxis: Smallint; Param2: WordBool);
    function Get_BridgeErrorCurrent(nAxis: Smallint): Single;
    procedure Set_AxisError(nAxis: Smallint; Param2: Integer);
    function Get_AxisNode(nAxis: Smallint): Smallint;
    function Get_AxisPDOutput(nAxis: Smallint): Smallint;
    function Get_AxisDAC(nAxis: Smallint): Smallint;
    function Get_AxisChannel(nAxis: Smallint): Smallint;
    procedure Set_AxisChannel(nAxis: Smallint; Param2: Smallint);
    procedure Set_AxisWarningDisable(nAxis: Smallint; Param2: Integer);
    procedure Set_BridgeErrorCurrent(nAxis: Smallint; Param2: Single);
    function Get_BridgeErrorVoltage(nAxis: Smallint): Single;
    function Get_AxisMode(nAxis: Smallint): Integer;
    function Get_AxisErrorLogMask(nAxis: Smallint): Integer;
    procedure Set_AxisErrorLogMask(nAxis: Smallint; Param2: Integer);
    procedure Set_BusProcessDataInterval(nBusID: Smallint; Param2: Smallint);
    procedure Set_BusProcessData(nBus: Smallint; bIn: WordBool; nChannel: Smallint; Param4: Smallint);
    procedure Set_BusPDOMapContent(nBus: Smallint; nNode: Smallint; bIn: WordBool; 
                                   nPeerNode: Smallint; nSlot: Smallint; Param6: OleVariant);
    procedure Set_DriveSpeedFatal(nAxis: Smallint; Param2: Single);
    function Get_DriveSpeedMax(nAxis: Smallint): Single;
    function Get_BusProcessDataInterval(nBusID: Smallint): Smallint;
    function Get_BusTelegramDiagnosticStrings(nBusID: Smallint): OleVariant;
    function Get_BusState(nBusID: Smallint): Smallint;
    procedure Set_BusProcessDataParameter(nBus: Smallint; bIn: WordBool; nChannel: Smallint; 
                                          Param4: Smallint);
    function Get_BusProcessData(nBus: Smallint; bIn: WordBool; nChannel: Smallint): Smallint;
    function Get_BusProcessDataParameter(nBus: Smallint; bIn: WordBool; nChannel: Smallint): Smallint;
    function Get_BusTelegramDiagnostics(nBusID: Smallint): OleVariant;
    procedure Set_DriveSpeedMax(nAxis: Smallint; Param2: Single);
    function Get_DriveSpeedMaxRPM(nAxis: Smallint): Smallint;
    procedure Set_DriveRatingZone(nAxis: Smallint; Param2: Smallint);
    function Get_DriveRatingZoneInfo(nAxis: Smallint; nZone: Smallint; nParam: Smallint): Single;
    function Get_EEPROMData(nAddress: Smallint): Smallint;
    procedure Set_DriveUnderloadWarning(nAxis: Smallint; Param2: Single);
    function Get_DriveVolts(nAxis: Smallint): Single;
    function Get_DriveSpeedFatal(nAxis: Smallint): Single;
    function Get_DriveSpeedMaxmmps(nAxis: Smallint): Single;
    procedure Set_DriveSpeedMaxmmps(nAxis: Smallint; Param2: Single);
    function Get_DriveRatingZone(nAxis: Smallint): Smallint;
    function Get_DriveRatedCurrent(nAxis: Smallint): Single;
    function Get_DriveRatedHorsePower(nAxis: Smallint): Single;
    function Get_BusProtocol(nBus: Smallint): Smallint;
    procedure Set_CANBaud(nCANBus: Smallint; Param2: Integer);
    function Get_CANBusState(nCANBus: Smallint): Smallint;
    procedure Set_CaptureAxis(nChannel: Smallint; Param2: Smallint);
    function Get_CANEventInfo(nCANBus: Smallint): Smallint;
    function Get_CaptureAxis(nChannel: Smallint): Smallint;
    function Get_CANEvent(nCANBus: Smallint): Smallint;
    function Get_CaptureHSMode(nChannel: Smallint): Smallint;
    procedure Set_CaptureHSMode(nChannel: Smallint; Param2: Smallint);
    function Get_CANBaud(nCANBus: Smallint): Integer;
    procedure Set_CaptureMode(nChannel: Smallint; Param2: Smallint);
    function Get_CaptureModeParameter(nAxis: Smallint): Smallint;
    function Get_CaptureMode(nChannel: Smallint): Smallint;
    function Get_Cam(nAxis: Smallint): Smallint;
    procedure Set_BusCommandMask(nFieldbus: Smallint; Param2: Smallint);
    function Get_BusBaudsSupported(nBus: Smallint): OleVariant;
    function Get_BusCommandMask(nFieldbus: Smallint): Smallint;
    function Get_BusPDOMapContent(nBus: Smallint; nNode: Smallint; bIn: WordBool; 
                                  nPeerNode: Smallint; nSlot: Smallint): OleVariant;
    function Get_BusCycleRate(nBus: Smallint): Smallint;
    procedure Set_BusCycleRate(nBus: Smallint; Param2: Smallint);
    procedure Set_BusMessageMode(nBus: Smallint; Param2: Smallint);
    function Get_BusEventInfo(nBusID: Smallint): Smallint;
    function Get_BusMessageMode(nBus: Smallint): Smallint;
    function Get_BusEvent(nBusID: Smallint): Smallint;
    function Get_BusNode(nBus: Smallint): Smallint;
    procedure Set_BusNode(nBus: Smallint; Param2: Smallint);
    function Get_Backlash(nAxis: Smallint): Single;
    function Get_CaptureProgress(bPostTrigger: WordBool): Smallint;
    function Get_CaptureTriggerAbsolute(nTrigger: Smallint): WordBool;
    function Get_CapturePoint(nChannel: Smallint; nIndex: Smallint): Single;
    procedure Set_CommandRefSource(nAxis: Smallint; Param2: Smallint);
    function Get_CommandRefSourceParameter(nAxis: Smallint): Smallint;
    procedure Set_CaptureTriggerSource(nTrigger: Smallint; Param2: Smallint);
    procedure Set_CaptureTriggerMode(nTrigger: Smallint; Param2: Smallint);
    function Get_CaptureTriggerSource(nTrigger: Smallint): Smallint;
    function Get_CaptureTriggerMode(nTrigger: Smallint): Smallint;
    procedure Set_CaptureModeParameter(nAxis: Smallint; Param2: Smallint);
    function Get_CaptureModeName(nChannel: Smallint): WideString;
    procedure Set_CaptureTriggerAbsolute(nTrigger: Smallint; Param2: WordBool);
    procedure Set_CommandRefSourceParameter(nAxis: Smallint; Param2: Smallint);
    procedure Set_CompareMode(nAxis: Smallint; Param2: Smallint);
    function Get_Coil(nCoil: Smallint): WordBool;
    procedure Set_Coil(nCoil: Smallint; Param2: WordBool);
    function Get_CurrentLimit(nAxis: Smallint): Single;
    procedure Set_ControlRefSourceStartup(nAxis: Smallint; Param2: Smallint);
    function Get_CurrentDemand(nAxis: Smallint; nChannel: Smallint): Single;
    function Get_CommandRefSource(nAxis: Smallint): Smallint;
    function Get_Commissioned(nAxis: Smallint): WordBool;
    procedure Set_Commissioned(nAxis: Smallint; Param2: WordBool);
    function Get_ChannelType(nChannel: Smallint): Smallint;
    function Get_CaptureTriggerValue(nTrigger: Smallint): Single;
    procedure Set_CaptureTriggerValue(nTrigger: Smallint; Param2: Single);
    function Get_CaptureTriggerChannel(nTrigger: Smallint): Smallint;
    function Get_CommsInteger(nIndex: Smallint): Integer;
    procedure Set_Comms(nIndex: Smallint; Param2: Single);
    function Get_CommsControllerData(nEnum: Smallint; nParam: Smallint): OleVariant;
    procedure Set_CommsMultiple(nIndex: Smallint; nCount: Smallint; Param3: OleVariant);
    procedure Set_CommsInteger(nIndex: Smallint; Param2: Integer);
    function Get_CommsMapDataType(nAxis: Smallint): Smallint;
    function Get_CommsMapParameter(nIndex: Smallint): Smallint;
    function Get_CommsMapMode(nIndex: Smallint): Smallint;
    procedure Set_CommsMapMode(nIndex: Smallint; Param2: Smallint);
    procedure Set_CommsMapDataType(nAxis: Smallint; Param2: Smallint);
    procedure Set_CommsMapParameter(nIndex: Smallint; Param2: Smallint);
    function Get_CommsMultiple(nIndex: Smallint; nCount: Smallint): OleVariant;
    procedure Set_CompareEnable(nOutput: Smallint; Param2: WordBool);
    function Get_CommsTestParameter(nParameter: Smallint): Single;
    function Get_CommsRemote(nNode: Smallint; nIndex: Smallint): Single;
    function Get_CommsMultipleRemote(nNode: Smallint; nIndex: Smallint; nCount: Smallint): OleVariant;
    procedure Set_CaptureTriggerChannel(nTrigger: Smallint; Param2: Smallint);
    function Get_Comms(nIndex: Smallint): Single;
    procedure Set_CommsRemote(nNode: Smallint; nIndex: Smallint; Param3: Single);
    function Get_CompareMode(nAxis: Smallint): Smallint;
    function Get_CompareLatch(nAxis: Smallint): Smallint;
    function Get_CompareEnable(nOutput: Smallint): WordBool;
    procedure Set_CommsMultipleRemote(nNode: Smallint; nIndex: Smallint; nCount: Smallint; 
                                      Param4: OleVariant);
    procedure Set_CommsTestParameter(nParameter: Smallint; Param2: Single);
    procedure Set_CompareLatch(nAxis: Smallint; Param2: Smallint);
    function Get_ControllerData(nEnum: Smallint; nParam: Smallint): OleVariant;
    function Get_ControlMode(nAxis: Smallint): Smallint;
    procedure Set_ContourAngle(nAxis: Smallint; Param2: Single);
    function Get_ControlModeStartup(nAxis: Smallint): Smallint;
    procedure Set_ControlModeStartup(nAxis: Smallint; Param2: Smallint);
    procedure Set_ControlMode(nAxis: Smallint; Param2: Smallint);
    function Get_CompareOutput(nAxis: Smallint): Smallint;
    procedure Set_CompareOutput(nAxis: Smallint; Param2: Smallint);
    procedure Set_Config(nAxis: Smallint; Param2: Smallint);
    procedure Set_ComparePos(nAxis: Smallint; nRegister: Smallint; Param3: Single);
    function Get_Config(nAxis: Smallint): Smallint;
    function Get_ComparePos(nAxis: Smallint; nRegister: Smallint): Single;
    procedure Set_ContourRatio(nAxis1: Smallint; nAxis2: Smallint; Param3: Single);
    function Get_Boost(nAxis: Smallint): WordBool;
    function Get_BlendMode(nAxis: Smallint): Smallint;
    function Get_BlendDistance(nAxis: Smallint): Single;
    procedure Set_Backlash(nAxis: Smallint; Param2: Single);
    procedure Set_BacklashMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_BlendMode(nAxis: Smallint; Param2: Smallint);
    function Get_ContourParameter(nAxis: Smallint; nParam: Smallint): Single;
    function Get_ContourMode(nAxis: Smallint): Smallint;
    procedure Set_ContourMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_BlendDistance(nAxis: Smallint; Param2: Single);
    procedure Set_ContourParameter(nAxis: Smallint; nParam: Smallint; Param3: Single);
    function Get_ContourRatio(nAxis1: Smallint; nAxis2: Smallint): Single;
    function Get_ConnectStatus(nCANBus: Smallint; nFromNode: Smallint): Smallint;
    function Get_DAC(nChannel: Smallint): Single;
    function Get_ControlRefSource(nAxis: Smallint): Smallint;
    procedure Set_ControlRefSource(nAxis: Smallint; Param2: Smallint);
    procedure Set_DACMonitorAxis(nChannel: Smallint; Param2: Smallint);
    procedure Set_DACMonitorAbsolute(nChannel: Smallint; Param2: Smallint);
    function Get_DACMonitorAxis(nChannel: Smallint): Smallint;
    function Get_ControlRefSourceStartup(nAxis: Smallint): Smallint;
    procedure Set_CurrentLimit(nAxis: Smallint; Param2: Single);
    function Get_CurrentMeas(nAxis: Smallint; nChannel: Smallint): Single;
    procedure Set_ControlRefChannel(nAxis: Smallint; Param2: Smallint);
    procedure Set_ControlRate(nAxis: Smallint; nChannel: Smallint; Param3: Integer);
    function Get_ControlRefChannel(nAxis: Smallint): Smallint;
    procedure Set_DACMonitorGain(nChannel: Smallint; Param2: Single);
    procedure Set_Connect(nCANBus: Smallint; nFromNode: Smallint; nToNode: Smallint; 
                          Param4: Smallint);
    function Get_ControlRate(nAxis: Smallint; nChannel: Smallint): Integer;
    function Get_DACMode(nChannel: Smallint): Smallint;
    function Get_ContourAngle(nAxis: Smallint): Single;
    function Get_ConnectInfo(nBus: Smallint; nFromNode: Smallint): OleVariant;
    function Get_Connect(nCANBus: Smallint; nFromNode: Smallint; nToNode: Smallint): Smallint;
    function Get_DACLimitMax(nChannel: Smallint): Single;
    function Get_DACMonitorAbsolute(nChannel: Smallint): Smallint;
    function Get_DACMonitorGain(nChannel: Smallint): Single;
    procedure Set_DACMode(nChannel: Smallint; Param2: Smallint);
    procedure Set_DACLimitMax(nChannel: Smallint; Param2: Single);
    procedure Set_DAC(nChannel: Smallint; Param2: Single);
    function Get_Effort(nAxis: Smallint): Single;
    procedure Set_DriveData(nTransaction: Smallint; Param2: Smallint);
    function Get_DriveEnable(nAxis: Smallint): WordBool;
    function Get_DriveData(nTransaction: Smallint): Smallint;
    function Get_DriveFault(nAxis: Smallint): Smallint;
    function Get_DriveFeedbackSource(nAxis: Smallint): Smallint;
    procedure Set_DriveEnableOutput(nAxis: Smallint; Param2: Smallint);
    procedure Set_DriveEnableMode(nAxis: Smallint; Param2: Smallint);
    function Get_DriveEnableOutput(nAxis: Smallint): Smallint;
    function Get_DriveEnableMode(nAxis: Smallint): Smallint;
    procedure Set_DriveBusUnderVolts(nAxis: Smallint; Param2: Smallint);
    function Get_DriveBusVolts(nAxis: Smallint): Single;
    procedure Set_DriveEnable(nAxis: Smallint; Param2: WordBool);
    procedure Set_DriveFeedbackSource(nAxis: Smallint; Param2: Smallint);
    function Get_DriveBusUnderVolts(nAxis: Smallint): Smallint;
    function Get_DriveErrorLogMask(nAxis: Smallint): Integer;
    procedure Set_DriveErrorLogMask(nAxis: Smallint; Param2: Integer);
    function Get_DiagnosticString(nChannel: Smallint): WideString;
    function Get_DiagnosticParameter(nGroup: Smallint; nParameter: Smallint): Single;
    procedure Set_DiagnosticParameter(nGroup: Smallint; nParameter: Smallint; Param3: Single);
    function Get_DriveErrorString(nErrorCode: Smallint): WideString;
    function Get_DriveOkOutput(nAxis: Smallint): Smallint;
    procedure Set_DriveOkOutput(nAxis: Smallint; Param2: Smallint);
    procedure Set_DriveError(nAxis: Smallint; Param2: Smallint);
    function Get_DriveEnableSwitch(nAxis: Smallint): WordBool;
    function Get_DriveError(nAxis: Smallint): Smallint;
    function Get_DriveEnableInputMode(nAxis: Smallint): Smallint;
    function Get_DACMonitorModeParameter(nChannel: Smallint): Smallint;
    function Get_DACMonitorMode(nChannel: Smallint): Smallint;
    procedure Set_DACMonitorMode(nChannel: Smallint; Param2: Smallint);
    procedure Set_DACRamp(nChannel: Smallint; Param2: Integer);
    procedure Set_DACMonitorModeParameter(nChannel: Smallint; Param2: Smallint);
    function Get_DACMonitorOffset(nChannel: Smallint): Single;
    function Get_DACOffset(nChannel: Smallint): Single;
    function Get_DACMonitorScale(nChannel: Smallint): Single;
    procedure Set_DACMonitorScale(nChannel: Smallint; Param2: Single);
    procedure Set_DACMonitorOffset(nChannel: Smallint; Param2: Single);
    procedure Set_DACOffset(nChannel: Smallint; Param2: Single);
    function Get_DACRamp(nChannel: Smallint): Integer;
    procedure Set_DBExtAvgPower(nAxis: Smallint; Param2: Single);
    function Get_DBEnable(nAxis: Smallint): WordBool;
    function Get_DBDelay(nAxis: Smallint; nChannel: Smallint): Single;
    function Get_DBConfig(nAxis: Smallint): Smallint;
    procedure Set_DriveEnableInputMode(nAxis: Smallint; Param2: Smallint);
    function Get_DecelTime(nAxis: Smallint): Integer;
    procedure Set_DBDelay(nAxis: Smallint; nChannel: Smallint; Param3: Single);
    function Get_DBExtPeakPower(nAxis: Smallint): Single;
    function Get_DBExtPeakDuration(nAxis: Smallint): Single;
    function Get_DBExtAvgPower(nAxis: Smallint): Single;
    procedure Set_DBConfig(nAxis: Smallint; Param2: Smallint);
    procedure Set_DBEnable(nAxis: Smallint; Param2: WordBool);
    procedure Set_DBExtPeakDuration(nAxis: Smallint; Param2: Single);
    procedure Set_DigitalInputBankSetup(nBank: Smallint; Param2: Smallint);
    function Get_DiagnosticIndexedParameter(nGroup: Smallint; nCaptureIndex: Smallint; 
                                            nGDIPIndex: Smallint): Single;
    procedure Set_DiagnosticIndexedParameter(nGroup: Smallint; nCaptureIndex: Smallint; 
                                             nGDIPIndex: Smallint; Param4: Single);
    procedure Set_DriveBusOverVolts(nAxis: Smallint; Param2: Smallint);
    function Get_DriveBusNominalVolts(nAxis: Smallint): Smallint;
    function Get_DriveBusOverVolts(nAxis: Smallint): Smallint;
    function Get_DiagnosticIndexedString(nChannel: Smallint; nIndex: Smallint): WideString;
    procedure Set_DiagnosticString(nChannel: Smallint; const Param2: WideString);
    function Get_DigitalInputBankSetup(nBank: Smallint): Smallint;
    procedure Set_DecelTimeMax(nAxis: Smallint; Param2: Integer);
    procedure Set_DecelTime(nAxis: Smallint; Param2: Integer);
    function Get_DecelTimeMax(nAxis: Smallint): Integer;
    procedure Set_DriveBusTConst(nAxis: Smallint; Param2: Single);
    function Get_AxisBus(nAxis: Smallint): Smallint;
    procedure Set_DPRFloat(nAddress: Smallint; Param2: Single);
    procedure Set_DigitalOutputBankSetup(nBank: Smallint; Param2: Smallint);
    procedure Set_DPRLong(nAddress: Smallint; Param2: Integer);
    function Get_DriveBusTConst(nAxis: Smallint): Single;
    function Get_DPRLong(nAddress: Smallint): Integer;
    function Get_DPRFloat(nAddress: Smallint): Single;
    function Get_DigitalOutputBankSetup(nBank: Smallint): Smallint;
    procedure Set_DBExtPeakPower(nAxis: Smallint; Param2: Single);
    function Get_EncoderVel(nChannel: Smallint): Single;
    function Get_EncoderType(nChannel: Smallint): Smallint;
    procedure Set_EncoderType(nChannel: Smallint; Param2: Smallint);
    procedure Set_EncoderTestMode(nChannel: Smallint; Param2: Integer);
    function Get_EncoderWrap(nChannel: Smallint): Single;
    procedure Set_EncoderWrap(nChannel: Smallint; Param2: Single);
    procedure Set_DriveParameter(nTable: Smallint; nParameter: Smallint; Param3: OleVariant);
    procedure Set_DriveOverloadWarning(nAxis: Smallint; Param2: Single);
    function Get_DriveParameter(nTable: Smallint; nParameter: Smallint): OleVariant;
    function Get_EnableSwitch(nAxis: Smallint): WordBool;
    function Get_DriveParameterFloat(nTable: Smallint; nParameter: Smallint): Single;
    procedure Set_DriveParameterFloat(nTable: Smallint; nParameter: Smallint; Param3: Single);
    function Get_EncoderSetup(nChannel: Smallint): Smallint;
    function Get_ErrorMask(nAxis: Smallint): Integer;
    function Get_ErrorList(nGroup: Smallint; nData: Integer): OleVariant;
    function Get_ErrorInputMode(nAxis: Smallint): Smallint;
    function Get_ErrorBitmapStrings(nType: Smallint): OleVariant;
    procedure Set_ErrorInput(nAxis: Smallint; Param2: Smallint);
    function Get_ErrorLogString(nType: Smallint; nErrorCode: Integer): WideString;
    function Get_EncoderTestMode(nChannel: Smallint): Integer;
    procedure Set_EncoderSetup(nChannel: Smallint; Param2: Smallint);
    procedure Set_EncoderScale(nChannel: Smallint; Param2: Single);
    procedure Set_ErrorInputMode(nAxis: Smallint; Param2: Smallint);
    function Get_EncoderZLatch(nChannel: Smallint): WordBool;
    function Get_EncoderStatus(nChannel: Smallint): Smallint;
    function Get_DriveParameterInteger(nTable: Smallint; nParameter: Smallint): Integer;
    function Get_DriveOverloadGain(nAxis: Smallint): Single;
    procedure Set_DrivePWMMode(nAxis: Smallint; Param2: Smallint);
    function Get_DriveTestParameter(nParam: Smallint): Single;
    procedure Set_DriveOverloadMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_DriveOverloadGain(nAxis: Smallint; Param2: Single);
    procedure Set_DriveOverloadFatal(nAxis: Smallint; Param2: Single);
    function Get_DriveSpeedMin(nAxis: Smallint): Single;
    function Get_DriveUnderloadWarning(nAxis: Smallint): Single;
    procedure Set_EEPROMData(nAddress: Smallint; Param2: Smallint);
    procedure Set_DriveTestParameter(nParam: Smallint; Param2: Single);
    procedure Set_DriveSpeedMin(nAxis: Smallint; Param2: Single);
    procedure Set_DriveSpeedMaxRPM(nAxis: Smallint; Param2: Smallint);
    function Get_DriveOverloadMode(nAxis: Smallint): Smallint;
    procedure Set_DriveParameterInteger(nTable: Smallint; nParameter: Smallint; Param3: Integer);
    function Get_DrivePeakCurrent(nAxis: Smallint): Single;
    function Get_DriveOverloadWarning(nAxis: Smallint): Single;
    function Get_DrivePWMFreq(nAxis: Smallint): Single;
    function Get_DrivePWMMode(nAxis: Smallint): Smallint;
    function Get_DrivePeakDuration(nAxis: Smallint): Single;
    function Get_DriveOperatingMode(nAxis: Smallint): Smallint;
    procedure Set_DriveOperatingMode(nAxis: Smallint; Param2: Smallint);
    function Get_DriveOverloadFatal(nAxis: Smallint): Single;
    procedure Set_DriveOperatingZone(nAxis: Smallint; Param2: Smallint);
    function Get_DriveOverloadArea(nAxis: Smallint): Single;
    function Get_DriveOperatingZone(nAxis: Smallint): Smallint;
    procedure Set_DBExtR(nAxis: Smallint; Param2: Single);
    procedure Set_DBExtTripInput(nAxis: Smallint; Param2: Smallint);
    procedure Set_DBMode(nAxis: Smallint; Param2: Smallint);
    function Get_DBExtTripInput(nAxis: Smallint): Smallint;
    function Get_DBExtThermalTimeConst(nAxis: Smallint): Single;
    function Get_DBExtR(nAxis: Smallint): Single;
    procedure Set_DBFreq(nAxis: Smallint; Param2: Single);
    function Get_EncoderOutChannel(nChannel: Smallint): Smallint;
    procedure Set_EncoderOutChannel(nChannel: Smallint; Param2: Smallint);
    function Get_DBOverloadMode(nAxis: Smallint): Smallint;
    function Get_DBMode(nAxis: Smallint): Smallint;
    function Get_DBFreq(nAxis: Smallint): Single;
    procedure Set_DBExtThermalTimeConst(nAxis: Smallint; Param2: Single);
    function Get_DBSwitchingVolts(nAxis: Smallint): Single;
    procedure Set_DBSwitchingVolts(nAxis: Smallint; Param2: Single);
    function Get_Decel(nAxis: Smallint): Single;
    function Get_DBVoltsLimit(nAxis: Smallint): Single;
    procedure Set_DBVoltsLimit(nAxis: Smallint; Param2: Single);
    function Get_DBVolts(nAxis: Smallint): Smallint;
    procedure Set_Decel(nAxis: Smallint; Param2: Single);
    function Get_DecelJerk(nAxis: Smallint): Single;
    procedure Set_DBOverloadMode(nAxis: Smallint; Param2: Smallint);
    function Get_DecelJerkTime(nAxis: Smallint): Integer;
    procedure Set_DecelJerkTime(nAxis: Smallint; Param2: Integer);
    procedure Set_DecelJerk(nAxis: Smallint; Param2: Single);
    procedure Set_EncoderMode(nChannel: Smallint; Param2: Smallint);
    procedure Set_EncoderLinesIn(nAxis: Smallint; Param2: Integer);
    procedure Set_EncoderFilterType(nEncoderChannel: Smallint; Param2: Smallint);
    procedure Set_EncoderFilterDepth(nEncoderChannel: Smallint; Param2: Smallint);
    procedure Set_Encoder(nChannel: Smallint; Param2: Single);
    function Get_EncoderFilterDepth(nEncoderChannel: Smallint): Smallint;
    function Get_EncoderLinesIn(nAxis: Smallint): Integer;
    function Get_ErrorInput(nAxis: Smallint): Smallint;
    function Get_ErrorDecel(nAxis: Smallint): Single;
    function Get_ErrData(nIndex: Smallint): Integer;
    function Get_EncoderFilterType(nEncoderChannel: Smallint): Smallint;
    function Get_EncoderScale(nChannel: Smallint): Single;
    procedure Set_ErrorDecel(nAxis: Smallint; Param2: Single);
    function Get_Encoder(nChannel: Smallint): Single;
    function Get_EncoderResolution(nChannel: Smallint): Integer;
    procedure Set_EncoderResolution(nChannel: Smallint; Param2: Integer);
    procedure Set_EncoderPreScale(nChannel: Smallint; Param2: Integer);
    procedure Set_EncoderLinesOut(nAxis: Smallint; Param2: Integer);
    function Get_EncoderMode(nChannel: Smallint): Smallint;
    function Get_EncoderOutResolution(nChannel: Smallint): Integer;
    function Get_EncoderCycleSize(nAxis: Smallint): Integer;
    procedure Set_EncoderCycleSize(nAxis: Smallint; Param2: Integer);
    function Get_EncoderCount(nAxis: Smallint): Smallint;
    procedure Set_EncoderOutResolution(nChannel: Smallint; Param2: Integer);
    function Get_EncoderPreScale(nChannel: Smallint): Integer;
    function Get_EncoderLinesOut(nAxis: Smallint): Integer;
    function Get_RemoteStatus(nCANBus: Smallint; nNode: Smallint): Smallint;
    function Get_HomeBackoff(nAxis: Smallint): Single;
    procedure Set_HomeBackoff(nAxis: Smallint; Param2: Single);
    function Get_HomeCreepSpeed(nAxis: Smallint): Single;
    procedure Set_HomeCreepSpeed(nAxis: Smallint; Param2: Single);
    function Get_HomeDecel(nAxis: Smallint): Single;
    procedure Set_HomeDecel(nAxis: Smallint; Param2: Single);
    procedure Set_FastAuxLatchEdge(nAxis: Smallint; Param2: WordBool);
    function Get_FastAuxLatchMode(nAxis: Smallint): Smallint;
    procedure Set_FastAuxLatchMode(nAxis: Smallint; Param2: Smallint);
    function Get_FastAuxSelect(nAxis: Smallint): Smallint;
    procedure Set_FastAuxSelect(nAxis: Smallint; Param2: Smallint);
    procedure Set_FastEnable(nAxis: Smallint; Param2: Smallint);
    procedure Set_HomeAccel(nAxis: Smallint; Param2: Single);
    function Get_HomeSpeed(nAxis: Smallint): Single;
    procedure Set_HomeSpeed(nAxis: Smallint; Param2: Single);
    function Get_HomeInput(nAxis: Smallint): Smallint;
    procedure Set_HomeStatus(nAxis: Smallint; Param2: WordBool);
    function Get_HomeSwitch(nAxis: Smallint): WordBool;
    function Get_HomeSources(nAxis: Smallint): Smallint;
    function Get_HoldingRegister(nRegister: Integer): Integer;
    procedure Set_HoldingRegister(nRegister: Integer; Param2: Integer);
    function Get_HoldSwitch(nAxis: Smallint): Smallint;
    function Get_Home(nAxis: Smallint): Smallint;
    procedure Set_Home(nAxis: Smallint; Param2: Smallint);
    function Get_HomeAccel(nAxis: Smallint): Single;
    function Get_FastEncoder(nAxis: Smallint): Single;
    procedure Set_FastAuxLatchDistance(nAxis: Smallint; Param2: Single);
    function Get_ErrorSwitch(nAxis: Smallint): WordBool;
    procedure Set_FastAuxEnable(nAxis: Smallint; Param2: Smallint);
    function Get_ErrorString(nErrorCode: Integer): WideString;
    function Get_FastAuxLatch(nAxis: Smallint): WordBool;
    function Get_FastAuxLatchDistance(nAxis: Smallint): Single;
    function Get_FolErrorWarning(nAxis: Smallint): Single;
    procedure Set_FolErrorWarning(nAxis: Smallint; Param2: Single);
    function Get_FolErrorFatal(nAxis: Smallint): Single;
    function Get_FastAuxEncoder(nAxis: Smallint): Single;
    procedure Set_FastLatchMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_FolErrorMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_ErrorMaskCode(nCode: Integer; nData: Integer; Param3: WordBool);
    function Get_FastLatch(nAxis: Smallint): WordBool;
    function Get_FastLatchDistance(nAxis: Smallint): Single;
    procedure Set_FastLatchDistance(nAxis: Smallint; Param2: Single);
    function Get_FastLatchEdge(nAxis: Smallint): WordBool;
    procedure Set_FastLatchEdge(nAxis: Smallint; Param2: WordBool);
    function Get_FastLatchMode(nAxis: Smallint): Smallint;
    function Get_ErrorReadNext(nGroup: Smallint; nData: Integer): WordBool;
    procedure Set_ErrorMask(nAxis: Smallint; Param2: Integer);
    function Get_ErrorMaskCode(nCode: Integer; nData: Integer): WordBool;
    function Get_FastAuxLatchEdge(nAxis: Smallint): WordBool;
    function Get_ErrorPresent(nGroup: Smallint; nData: Integer): WordBool;
    function Get_ErrorReadCode(nGroup: Smallint; nData: Integer): WordBool;
    procedure Set_GroupMaster(nCANBus: Smallint; nGroup: Smallint; Param3: Smallint);
    function Get_GroupMasterStatus(nCANBus: Smallint; nGroup: Smallint): Smallint;
    procedure Set_Group(nCANBus: Smallint; nGroup: Smallint; nNodeId: Smallint; Param4: Smallint);
    procedure Set_MotorRs(nAxis: Smallint; Param2: Single);
    function Get_MotorSlipFreq(nAxis: Smallint): Single;
    function Get_GroupMaster(nCANBus: Smallint; nGroup: Smallint): Smallint;
    function Get_HallReverseAngle(nAxis: Smallint; nSextant: Smallint): Single;
    procedure Set_HallReverseAngle(nAxis: Smallint; nSextant: Smallint; Param3: Single);
    function Get_HallTable(nAxis: Smallint; nState: Smallint): Smallint;
    procedure Set_GroupComms(nCANBus: Smallint; nGroup: Smallint; nIndex: Smallint; Param4: Single);
    function Get_GroupInfo(nBus: Smallint; nNode: Smallint): Smallint;
    function Get_GroupStatus(nCANBus: Smallint; nGroup: Smallint): Smallint;
    function Get_MotorRs(nAxis: Smallint): Single;
    procedure Set_MotorRotorLeakageInd(nAxis: Smallint; Param2: Single);
    function Get_MotorRotorRes(nAxis: Smallint): Single;
    procedure Set_MotorResolverOffset(nAxis: Smallint; Param2: Single);
    function Get_MotorTemperatureInput(nAxis: Smallint): Smallint;
    function Get_MotorSpeedMaxmmps(nAxis: Smallint): Single;
    function Get_MotorRotorLeakageInd(nAxis: Smallint): Single;
    procedure Set_MotorSlipFreq(nAxis: Smallint; Param2: Single);
    function Get_MotorSpecNumber(nAxis: Smallint): WideString;
    procedure Set_MotorSpecNumber(nAxis: Smallint; const Param2: WideString);
    function Get_MotorResolverSpeed(nAxis: Smallint): Single;
    procedure Set_MotorResolverSpeed(nAxis: Smallint; Param2: Single);
    procedure Set_MotorRotorRes(nAxis: Smallint; Param2: Single);
    function Get_Hall(nAxis: Smallint): Smallint;
    procedure Set_HallTable(nAxis: Smallint; nState: Smallint; Param3: Smallint);
    function Get_HomePhase(nAxis: Smallint): Smallint;
    function Get_HomePos(nAxis: Smallint): Single;
    function Get_FrictionCompensationTConst(nAxis: Smallint): Single;
    procedure Set_FrictionCompensationTConst(nAxis: Smallint; Param2: Single);
    function Get_Gearing(nAxis: Smallint): Single;
    procedure Set_HomeOffset(nAxis: Smallint; Param2: Single);
    procedure Set_HomeRefPos(nAxis: Smallint; Param2: Single);
    function Get_HomeStatus(nAxis: Smallint): WordBool;
    function Get_HomeRefPos(nAxis: Smallint): Single;
    procedure Set_HomeInput(nAxis: Smallint; Param2: Smallint);
    function Get_HomeOffset(nAxis: Smallint): Single;
    procedure Set_GearingMode(nAxis: Smallint; Param2: Smallint);
    function Get_FrictionCompensation(nAxis: Smallint): Single;
    procedure Set_FrictionCompensation(nAxis: Smallint; Param2: Single);
    function Get_FrictionCompensationSpeed(nAxis: Smallint): Single;
    function Get_HallForwardAngle(nAxis: Smallint; nSextant: Smallint): Single;
    procedure Set_HallForwardAngle(nAxis: Smallint; nSextant: Smallint; Param3: Single);
    function Get_Group(nCANBus: Smallint; nGroup: Smallint; nNodeId: Smallint): Smallint;
    procedure Set_FrictionCompensationSpeed(nAxis: Smallint; Param2: Single);
    procedure Set_Gearing(nAxis: Smallint; Param2: Single);
    function Get_GearingMode(nAxis: Smallint): Smallint;
    procedure Set_FollowNumerator(nAxis: Smallint; Param2: Single);
    function Get_Freq(nAxis: Smallint): Single;
    procedure Set_Freq(nAxis: Smallint; Param2: Single);
    procedure Set_FolErrorFatal(nAxis: Smallint; Param2: Single);
    procedure Set_KITrack(nAxis: Smallint; Param2: Smallint);
    function Get_KIntMode(nAxis: Smallint): Smallint;
    procedure Set_KIntMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_KVel(nAxis: Smallint; Param2: Single);
    procedure Set_KIProp(nAxis: Smallint; Param2: Single);
    function Get_KITrack(nAxis: Smallint): Smallint;
    procedure Set_KVDerivTConst(nAxis: Smallint; Param2: Single);
    function Get_KVel(nAxis: Smallint): Single;
    procedure Set_KProp(nAxis: Smallint; Param2: Single);
    function Get_KIProp(nAxis: Smallint): Single;
    function Get_KProp(nAxis: Smallint): Single;
    function Get_KVDerivTConst(nAxis: Smallint): Single;
    procedure Set_KVProp(nAxis: Smallint; Param2: Single);
    function Get_KVelFF(nAxis: Smallint): Single;
    procedure Set_KVelFF(nAxis: Smallint; Param2: Single);
    function Get_KVFilterLevel(nAxis: Smallint): Smallint;
    procedure Set_KVFilterLevel(nAxis: Smallint; Param2: Smallint);
    function Get_KVInt(nAxis: Smallint): Single;
    procedure Set_KVInt(nAxis: Smallint; Param2: Single);
    function Get_KVTrack(nAxis: Smallint): Smallint;
    procedure Set_KVMeas(nAxis: Smallint; Param2: Single);
    function Get_KVProp(nAxis: Smallint): Single;
    function Get_KVMeas(nAxis: Smallint): Single;
    function Get_KVTime(nAxis: Smallint): Single;
    procedure Set_KVTime(nAxis: Smallint; Param2: Single);
    function Get_KVDeriv(nAxis: Smallint): Single;
    procedure Set_HTAChannel(nAxis: Smallint; Param2: Smallint);
    function Get_HTADamping(nAxis: Smallint): Single;
    procedure Set_HomeType(nAxis: Smallint; Param2: Smallint);
    function Get_IdleVel(nAxis: Smallint): Single;
    function Get_HTAKProp(nAxis: Smallint): Single;
    function Get_HTAChannel(nAxis: Smallint): Smallint;
    procedure Set_HTAFilter(nAxis: Smallint; Param2: Single);
    function Get_HTAKInt(nAxis: Smallint): Single;
    procedure Set_HTAKInt(nAxis: Smallint; Param2: Single);
    function Get_HTA(nAxis: Smallint): Single;
    procedure Set_HTA(nAxis: Smallint; Param2: Single);
    procedure Set_HTADamping(nAxis: Smallint; Param2: Single);
    procedure Set_IdleTime(nAxis: Smallint; Param2: Smallint);
    procedure Set_IdlePos(nAxis: Smallint; Param2: Single);
    procedure Set_HTAKProp(nAxis: Smallint; Param2: Single);
    function Get_Idle(nAxis: Smallint): WordBool;
    procedure Set_KVDeriv(nAxis: Smallint; Param2: Single);
    procedure Set_IdleMode(nAxis: Smallint; Param2: Smallint);
    function Get_IdlePos(nAxis: Smallint): Single;
    function Get_IMask(nBank: Smallint): Integer;
    procedure Set_IMask(nBank: Smallint; Param2: Integer);
    function Get_IdleTime(nAxis: Smallint): Smallint;
    function Get_IdleMode(nAxis: Smallint): Smallint;
    function Get_IdleSettlingTime(nAxis: Smallint): Integer;
    procedure Set_IdleVel(nAxis: Smallint; Param2: Single);
    procedure Set_FeedrateParameter(nAxis: Smallint; nOverride: Smallint; Param3: Single);
    function Get_FirmwareComponentVersion(nComponent: Smallint): Single;
    procedure Set_Fly(nAxis: Smallint; Param2: Single);
    function Get_FastSelect(nAxis: Smallint): Smallint;
    procedure Set_FastSelect(nAxis: Smallint; Param2: Smallint);
    procedure Set_FeedrateMode(nAxis: Smallint; Param2: Smallint);
    function Get_HomeType(nAxis: Smallint): Smallint;
    procedure Set_KFInt(nAxis: Smallint; Param2: Single);
    function Get_KFProp(nAxis: Smallint): Single;
    function Get_FeedrateOverride(nAxis: Smallint): Single;
    procedure Set_FeedrateOverride(nAxis: Smallint; Param2: Single);
    function Get_FeedrateParameter(nAxis: Smallint; nOverride: Smallint): Single;
    function Get_FastPos(nAxis: Smallint): Single;
    procedure Set_FollowMode(nAxis: Smallint; Param2: Smallint);
    function Get_FollowNumerator(nAxis: Smallint): Single;
    procedure Set_Follow(nAxis: Smallint; Param2: Single);
    function Get_FolErrorMode(nAxis: Smallint): Smallint;
    function Get_Follow(nAxis: Smallint): Single;
    function Get_FollowMode(nAxis: Smallint): Smallint;
    function Get_Feedrate(nAxis: Smallint): Single;
    procedure Set_Feedrate(nAxis: Smallint; Param2: Single);
    function Get_FeedrateMode(nAxis: Smallint): Smallint;
    function Get_FollowDenom(nAxis: Smallint): Single;
    procedure Set_FollowDenom(nAxis: Smallint; Param2: Single);
    function Get_FolError(nAxis: Smallint): Single;
    procedure Set_KFProp(nAxis: Smallint; Param2: Single);
    procedure Set_JogDuration(nAxis: Smallint; Param2: Integer);
    procedure Set_JogSpeed(nAxis: Smallint; Param2: Single);
    function Get_KASInt(nAxis: Smallint): Single;
    function Get_JogSpeed(nAxis: Smallint): Single;
    procedure Set_JogDecelTimeMax(nAxis: Smallint; Param2: Integer);
    function Get_JogDuration(nAxis: Smallint): Integer;
    function Get_KAccel(nAxis: Smallint): Single;
    procedure Set_KAccel(nAxis: Smallint; Param2: Single);
    procedure Set_KIntLimit(nAxis: Smallint; Param2: Single);
    procedure Set_KASInt(nAxis: Smallint; Param2: Single);
    function Get_KASProp(nAxis: Smallint): Single;
    function Get_JogTime(nAxis: Smallint): Integer;
    procedure Set_JogMode(nAxis: Smallint; Param2: Smallint);
    function Get_KFTime(nAxis: Smallint): Single;
    function Get_KInt(nAxis: Smallint): Single;
    procedure Set_KInt(nAxis: Smallint; Param2: Single);
    function Get_KDeriv(nAxis: Smallint): Single;
    procedure Set_KDeriv(nAxis: Smallint; Param2: Single);
    function Get_KFInt(nAxis: Smallint): Single;
    procedure Set_KIInt(nAxis: Smallint; Param2: Single);
    procedure Set_KASProp(nAxis: Smallint; Param2: Single);
    function Get_JogMode(nAxis: Smallint): Smallint;
    function Get_KIntLimit(nAxis: Smallint): Single;
    procedure Set_KFTime(nAxis: Smallint; Param2: Single);
    function Get_KIInt(nAxis: Smallint): Single;
    procedure Set_MotorStatorRes(nAxis: Smallint; Param2: Single);
    procedure Set_LatchSourceChannel(nLatchChannel: Smallint; Param2: Smallint);
    procedure Set_LatchInhibitValue(nLatchChannel: Smallint; Param2: Single);
    function Get_KnifeMode(nAxis: Smallint): Smallint;
    function Get_LatchTriggerEdge(nLatchChannel: Smallint): Smallint;
    procedure Set_LatchSource(nLatchChannel: Smallint; Param2: Smallint);
    function Get_LatchSourceChannel(nLatchChannel: Smallint): Smallint;
    function Get_KnifeMasterAxis(nAxis: Smallint): Smallint;
    procedure Set_KnifeMasterAxis(nAxis: Smallint; Param2: Smallint);
    procedure Set_KnifeStatus(nAxis: Smallint; Param2: Smallint);
    procedure Set_KnifeMode(nAxis: Smallint; Param2: Smallint);
    function Get_KnifeStatus(nAxis: Smallint): Smallint;
    procedure Set_KVTrack(nAxis: Smallint; Param2: Smallint);
    procedure Set_LatchTriggerChannel(nLatchChannel: Smallint; Param2: Smallint);
    function Get_MotorFluxMax(nAxis: Smallint): Single;
    procedure Set_LatchSetup(nDeviceType: Smallint; nChannel: Smallint; Param3: Smallint);
    function Get_LatchSetupMultiple(nDeviceType: Smallint; nChannel: Smallint): OleVariant;
    procedure Set_MotorFluxMin(nAxis: Smallint; Param2: Single);
    function Get_MotorFlux(nAxis: Smallint): Single;
    procedure Set_MotorFlux(nAxis: Smallint; Param2: Single);
    function Get_LatchSetup(nDeviceType: Smallint; nChannel: Smallint): Smallint;
    function Get_LatchSource(nLatchChannel: Smallint): Smallint;
    function Get_LatchTriggerChannel(nLatchChannel: Smallint): Smallint;
    procedure Set_LatchSetupMultiple(nDeviceType: Smallint; nChannel: Smallint; Param3: OleVariant);
    function Get_LatchMode(nLatchChannel: Smallint): Smallint;
    procedure Set_LatchMode(nLatchChannel: Smallint; Param2: Smallint);
    function Get_LatchInhibitTime(nLatchChannel: Smallint): Integer;
    procedure Set_MasterDistance(nAxis: Smallint; Param2: Single);
    function Get_MasterSource(nAxis: Smallint): Smallint;
    procedure Set_MasterSource(nAxis: Smallint; Param2: Smallint);
    function Get_MaxAccel(nAxis: Smallint): Single;
    procedure Set_MaxAccel(nAxis: Smallint; Param2: Single);
    function Get_MaxDecel(nAxis: Smallint): Single;
    function Get_LimitForwardInput(nAxis: Smallint): Smallint;
    function Get_LatchTriggerMode(nLatchChannel: Smallint): Smallint;
    procedure Set_LatchTriggerMode(nLatchChannel: Smallint; Param2: Smallint);
    procedure Set_ListOf(nListOf: Smallint; nParameter: Smallint; Param3: OleVariant);
    function Get_Limit(nAxis: Smallint): WordBool;
    function Get_LimitForward(nAxis: Smallint): WordBool;
    function Get_MasterDistance(nAxis: Smallint): Single;
    function Get_LatchEnable(nLatchChannel: Smallint): WordBool;
    procedure Set_LatchEnable(nLatchChannel: Smallint; Param2: WordBool);
    procedure Set_LatchTriggerEdge(nLatchChannel: Smallint; Param2: Smallint);
    procedure Set_LatchInhibitTime(nLatchChannel: Smallint; Param2: Integer);
    function Get_LatchInhibitValue(nLatchChannel: Smallint): Single;
    function Get_Latch(nLatchChannel: Smallint): WordBool;
    function Get_LoadDamping(nAxis: Smallint): Single;
    procedure Set_LoadDamping(nAxis: Smallint; Param2: Single);
    function Get_LoadInertia(nAxis: Smallint): Single;
    procedure Set_LoadInertia(nAxis: Smallint; Param2: Single);
    function Get_MasterChannel(nAxis: Smallint): Smallint;
    procedure Set_MasterChannel(nAxis: Smallint; Param2: Smallint);
    function Get_MintExtendedStatus(nCommand: Smallint; vData: OleVariant): Integer;
    procedure Set_MaxDecel(nAxis: Smallint; Param2: Single);
    function Get_MaxSpeed(nAxis: Smallint): Single;
    procedure Set_MotorBrake(nAxis: Smallint; Param2: WordBool);
    function Get_MintExpressions(vLHS: OleVariant): OleVariant;
    procedure Set_MintExpressions(vLHS: OleVariant; Param2: OleVariant);
    function Get_MotorBaseVolts(nAxis: Smallint): Single;
    procedure Set_MotorBaseVolts(nAxis: Smallint; Param2: Single);
    function Get_ModuleName(nModuleID: Smallint): WideString;
    procedure Set_MaxSpeed(nAxis: Smallint; Param2: Single);
    function Get_MintStatus(nCommand: Smallint): Integer;
    procedure Set_MotorBaseFreq(nAxis: Smallint; Param2: Single);
    function Get_MotorDirection(nAxis: Smallint): Smallint;
    function Get_MotorBrakeDelay(nAxis: Smallint; nChannel: Smallint): Smallint;
    procedure Set_MotorBrakeDelay(nAxis: Smallint; nChannel: Smallint; Param3: Smallint);
    function Get_MotorBrakeMode(nAxis: Smallint): Smallint;
    procedure Set_MotorBrakeMode(nAxis: Smallint; Param2: Smallint);
    function Get_MotorBrakeOutput(nAxis: Smallint): Smallint;
    procedure Set_MotorBrakeOutput(nAxis: Smallint; Param2: Smallint);
    procedure Set_MotorEncoderLines(nAxis: Smallint; Param2: Integer);
    function Get_MotorCatalogNumber(nAxis: Smallint): WideString;
    procedure Set_MotorCatalogNumber(nAxis: Smallint; const Param2: WideString);
    function Get_MotorBrakeStatus(nAxis: Smallint): Smallint;
    procedure Set_MotorDirection(nAxis: Smallint; Param2: Smallint);
    function Get_MotorEncoderLines(nAxis: Smallint): Integer;
    function Get_MonitorParameter(nGroup: Smallint; nMode: Smallint; nParameter: Smallint): Integer;
    function Get_MotorFeedbackAngle(nAxis: Smallint): Single;
    function Get_MotorFeedbackOffset(nAxis: Smallint): Single;
    procedure Set_MotorFeedbackOffset(nAxis: Smallint; Param2: Single);
    procedure Set_MotorLs(nAxis: Smallint; Param2: Single);
    function Get_MotorMagCurrent(nAxis: Smallint): Single;
    function Get_MotorFluxTConst(nAxis: Smallint): Single;
    function Get_MotorFeedbackStatus(nAxis: Smallint): Smallint;
    procedure Set_MotorFluxMax(nAxis: Smallint; Param2: Single);
    function Get_MotorFluxMin(nAxis: Smallint): Single;
    procedure Set_MotorFeedback(nAxis: Smallint; Param2: Smallint);
    function Get_MotorFeedbackAlignment(nAxis: Smallint): Single;
    procedure Set_MotorFeedbackAlignment(nAxis: Smallint; Param2: Single);
    function Get_MotorLs(nAxis: Smallint): Single;
    procedure Set_MotorLinearEncoderResolution(nAxis: Smallint; Param2: Integer);
    function Get_MotorLinearPolePitch(nAxis: Smallint): Single;
    procedure Set_MotorFluxTConst(nAxis: Smallint; Param2: Single);
    function Get_MotorBaseFreq(nAxis: Smallint): Single;
    function Get_MotorFeedback(nAxis: Smallint): Smallint;
    function Get_MotorLinearEncoderResolution(nAxis: Smallint): Integer;
    procedure Set_MotorMagCurrent(nAxis: Smallint; Param2: Single);
    function Get_MotorMagCurrentCoeff(nAxis: Smallint; nChannel: Smallint): Single;
    procedure Set_MotorMagCurrentCoeff(nAxis: Smallint; nChannel: Smallint; Param3: Single);
    function Get_MotorInstabilityFreq(nAxis: Smallint): Single;
    procedure Set_MotorInstabilityFreq(nAxis: Smallint; Param2: Single);
    procedure Set_MotorLinearPolePitch(nAxis: Smallint; Param2: Single);
    function Get_LatchValue(nLatchChannel: Smallint): Single;
    function Get_MotorRatedCurrent(nAxis: Smallint): Single;
    procedure Set_MotorRatedCurrent(nAxis: Smallint; Param2: Single);
    procedure Set_MotorRatedSpeed(nAxis: Smallint; Param2: Single);
    procedure Set_MotorRatedFreq(nAxis: Smallint; Param2: Single);
    function Get_MotorRatedSpeed(nAxis: Smallint): Single;
    function Get_MotorPowerMeasured(nAxis: Smallint): Single;
    function Get_MotorRatedSpeedmmps(nAxis: Smallint): Single;
    procedure Set_MotorRatedSpeedmmps(nAxis: Smallint; Param2: Single);
    function Get_MotorRatedSpeedRPM(nAxis: Smallint): Integer;
    procedure Set_MotorRatedSpeedRPM(nAxis: Smallint; Param2: Integer);
    function Get_MotorRatedVolts(nAxis: Smallint): Single;
    procedure Set_MotorRatedVolts(nAxis: Smallint; Param2: Single);
    function Get_MotorRatedFreq(nAxis: Smallint): Single;
    function Get_NetInteger(nIndex: Smallint): Integer;
    procedure Set_NetInteger(nIndex: Smallint; Param2: Integer);
    function Get_NodeType(nCANBus: Smallint; nNode: Smallint): Smallint;
    procedure Set_NetIntegerMultiple(nIndex: Smallint; nElements: Smallint; Param3: OleVariant);
    function Get_NodeLive(nCANBus: Smallint; nNode: Smallint): WordBool;
    procedure Set_NetFloatMultiple(nIndex: Smallint; nElements: Smallint; Param3: OleVariant);
    procedure Set_NodeType(nCANBus: Smallint; nNode: Smallint; Param3: Smallint);
    function Get_NodeTypeExtended(nBus: Smallint; nNode: Smallint): OleVariant;
    procedure Set_NodeTypeExtended(nBus: Smallint; nNode: Smallint; Param3: OleVariant);
    function Get_NumberOf(nItem: Smallint): Smallint;
    procedure Set_NumberOf(nItem: Smallint; Param2: Smallint);
    function Get_NumberOfExtended(nItem: Smallint; nParameter: Smallint): Smallint;
    procedure Set_MotorPoles(nAxis: Smallint; Param2: Smallint);
    function Get_MotorStatorLeakageInd(nAxis: Smallint): Single;
    procedure Set_MotorSpeedMaxmmps(nAxis: Smallint; Param2: Single);
    function Get_MotorSpeedMaxRPM(nAxis: Smallint): Smallint;
    function Get_MotorResolverOffset(nAxis: Smallint): Single;
    function Get_MotorStabilityGain(nAxis: Smallint): Single;
    procedure Set_MotorStabilityGain(nAxis: Smallint; Param2: Single);
    function Get_MotorTemperatureMode(nAxis: Smallint): Smallint;
    procedure Set_MotorTemperatureMode(nAxis: Smallint; Param2: Smallint);
    function Get_MotorStatorRes(nAxis: Smallint): Single;
    procedure Set_MotorSpeedMaxRPM(nAxis: Smallint; Param2: Smallint);
    procedure Set_MotorStatorLeakageInd(nAxis: Smallint; Param2: Single);
    procedure Set_MotorTemperatureInput(nAxis: Smallint; Param2: Smallint);
    procedure Set_MotorPeakCurrent(nAxis: Smallint; Param2: Single);
    procedure Set_MotorMagCurrentMax(nAxis: Smallint; Param2: Single);
    function Get_MotorMagCurrentMin(nAxis: Smallint): Single;
    procedure Set_MotorMagCurrentMin(nAxis: Smallint; Param2: Single);
    function Get_MotorMagInd(nAxis: Smallint): Single;
    procedure Set_MotorMagInd(nAxis: Smallint; Param2: Single);
    function Get_MotorOverloadArea(nAxis: Smallint): Single;
    function Get_MotorPoles(nAxis: Smallint): Smallint;
    procedure Set_MotorOverloadMode(nAxis: Smallint; Param2: Smallint);
    function Get_MotorPeakCurrent(nAxis: Smallint): Single;
    function Get_MotorOverloadMode(nAxis: Smallint): Smallint;
    function Get_MotorPeakDuration(nAxis: Smallint): Single;
    procedure Set_MotorPeakDuration(nAxis: Smallint; Param2: Single);
    function Get_NetFloat(nIndex: Smallint): Single;
    procedure Set_NetFloat(nIndex: Smallint; Param2: Single);
    function Get_MoveRTest(nAxis: Smallint; nParam: Smallint): Single;
    procedure Set_MoveDwell(nAxis: Smallint; Param2: Integer);
    procedure Set_MoveR(nAxis: Smallint; Param2: Single);
    function Get_MultipleCommandsExecute(nFlags: Integer): OleVariant;
    function Get_MotorType(nAxis: Smallint): Smallint;
    procedure Set_MotorType(nAxis: Smallint; Param2: Smallint);
    procedure Set_MoveA(nAxis: Smallint; Param2: Single);
    procedure Set_MoveRTest(nAxis: Smallint; nParam: Smallint; Param3: Single);
    function Get_MoveStatus(nAxis: Smallint): Smallint;
    procedure Set_MoveBufferSize(nAxis: Smallint; Param2: Smallint);
    procedure Set_MoveCorrection(nAxis: Smallint; Param2: Single);
    function Get_ListOf(nListOf: Smallint; nParameter: Smallint): OleVariant;
    function Get_LimitMode(nAxis: Smallint): Smallint;
    procedure Set_LimitMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_LimitForwardInput(nAxis: Smallint; Param2: Smallint);
    function Get_LimitReverseInput(nAxis: Smallint): Smallint;
    procedure Set_LimitReverseInput(nAxis: Smallint; Param2: Smallint);
    procedure Set_MoveOutX(nAxis: Smallint; nChannel: Smallint; Param3: WordBool);
    procedure Set_MovePulseOutX(nAxis: Smallint; nChannel: Smallint; Param3: Integer);
    function Get_MoveBufferStatus(nAxis: Smallint): Smallint;
    function Get_LimitReverse(nAxis: Smallint): WordBool;
    function Get_MotorMagCurrentMax(nAxis: Smallint): Single;
    procedure Set_MoveOut(nAxis: Smallint; nOutputBank: Smallint; Param3: Integer);
    function Get_MotorTemperatureSwitch(nAxis: Smallint): WordBool;
    procedure Set_OffsetDistance(nAxis: Smallint; Param2: Single);
    function Get_OkToLoadMove(nNumberOfAxes: Smallint; nAxisArray: OleVariant): WordBool;
    function Get_OptionCardBus(nSlot: Smallint): Smallint;
    function Get_NVFloat(nAddress: Smallint): Single;
    procedure Set_NVFloat(nAddress: Smallint; Param2: Single);
    function Get_NVLong(nAddress: Smallint): Integer;
    function Get_OffsetStatus(nAxis: Smallint): Smallint;
    procedure Set_NumberOfExtended(nItem: Smallint; nParameter: Smallint; Param3: Smallint);
    function Get_NetIntegerMultiple(nIndex: Smallint; nElements: Smallint): OleVariant;
    function Get_OptionCardNetworkAddress(nSlot: Smallint): Integer;
    function Get_OffsetMode(nAxis: Smallint): Smallint;
    procedure Set_OffsetMode(nAxis: Smallint; Param2: Smallint);
    function Get_OffsetDistance(nAxis: Smallint): Single;
    function Get_MoveBufferLow(nAxis: Smallint): Smallint;
    procedure Set_MoveBufferLow(nAxis: Smallint; Param2: Smallint);
    function Get_MoveBufferSize(nAxis: Smallint): Smallint;
    function Get_MotorTestMode(nParam: Smallint): Single;
    procedure Set_MotorTestMode(nParam: Smallint; Param2: Single);
    function Get_MoveBufferFree(nAxis: Smallint): Smallint;
    function Get_NetFloatMultiple(nIndex: Smallint; nElements: Smallint): OleVariant;
    procedure Set_NVLong(nAddress: Smallint; Param2: Integer);
    procedure Set_Offset(nAxis: Smallint; Param2: Single);
    function Get_MoveBufferID(nAxis: Smallint): Integer;
    procedure Set_MoveBufferID(nAxis: Smallint; Param2: Integer);
    function Get_MoveBufferIDLast(nAxis: Smallint): Integer;
    function Get_PosRef(nAxis: Smallint): Single;
    procedure Set_PosRef(nAxis: Smallint; Param2: Single);
    function Get_PosRemaining(nAxis: Smallint): Single;
    function Get_PLXData(nAddress: Smallint): Integer;
    procedure Set_PLXData(nAddress: Smallint; Param2: Integer);
    function Get_PosDemand(nAxis: Smallint): Single;
    procedure Set_PosWrap(nAxis: Smallint; Param2: Single);
    procedure Set_PrecisionSourceChannel(nAxisOrChannel: Smallint; Param2: Smallint);
    function Get_PresetAccel(nPreset: Smallint; nFmt: Smallint): Single;
    procedure Set_PosDemand(nAxis: Smallint; Param2: Single);
    function Get_PositionControlLooptime(nAxis: Smallint): Smallint;
    procedure Set_PositionControlLooptime(nAxis: Smallint; Param2: Smallint);
    function Get_PLCTaskStatus(nChannel: Smallint): Smallint;
    procedure Set_PosTrimGain(nAxis: Smallint; Param2: Single);
    function Get_PosWrap(nAxis: Smallint): Single;
    procedure Set_PosScaleUnits(nAxis: Smallint; const Param2: WideString);
    function Get_PosRolloverTarget(nAxis: Smallint): Integer;
    function Get_PosScaleUnits(nAxis: Smallint): WideString;
    function Get_PosTrimGain(nAxis: Smallint): Single;
    function Get_Pos(nAxis: Smallint): Single;
    procedure Set_Pos(nAxis: Smallint; Param2: Single);
    function Get_PosAchieved(nAxis: Smallint): WordBool;
    function Get_PosTarget(nAxis: Smallint): Single;
    function Get_PosTargetLast(nAxis: Smallint): Single;
    function Get_PosRollover(nAxis: Smallint): Integer;
    procedure Set_PresetAccel(nPreset: Smallint; nFmt: Smallint; Param3: Single);
    function Get_PowerReadyInput(nParam: Smallint): Smallint;
    function Get_PrecisionAxis(nAxisOrChannel: Smallint): Smallint;
    function Get_PrecisionMode(nAxisOrChannel: Smallint): Smallint;
    procedure Set_PowerReadyOutput(nParam: Smallint; Param2: Smallint);
    function Get_PowerbaseParameter(nParam: Smallint): Single;
    procedure Set_PowerbaseParameter(nParam: Smallint; Param2: Single);
    function Get_PrecisionIncrement(nAxisOrChannel: Smallint): Single;
    procedure Set_PrecisionIncrement(nAxisOrChannel: Smallint; Param2: Single);
    function Get_OutputMonitorModeParameter(nOutput: Smallint): Smallint;
    procedure Set_PrecisionMode(nAxisOrChannel: Smallint; Param2: Smallint);
    function Get_PrecisionOffset(nAxisOrChannel: Smallint): Single;
    procedure Set_PrecisionAxis(nAxisOrChannel: Smallint; Param2: Smallint);
    function Get_PowerReadyOutput(nParam: Smallint): Smallint;
    function Get_PresetDecel(nPreset: Smallint; nFmt: Smallint): Single;
    function Get_PresetIndex(nAxis: Smallint): Smallint;
    procedure Set_PresetIndex(nAxis: Smallint; Param2: Smallint);
    function Get_PrecisionSource(nAxisOrChannel: Smallint): Smallint;
    procedure Set_PrecisionSource(nAxisOrChannel: Smallint; Param2: Smallint);
    function Get_PrecisionSourceChannel(nAxisOrChannel: Smallint): Smallint;
    procedure Set_PresetDwellTime(nAxis: Smallint; Param2: Integer);
    procedure Set_PrecisionOffset(nAxisOrChannel: Smallint; Param2: Single);
    procedure Set_PowerReadyInput(nParam: Smallint; Param2: Smallint);
    function Get_PresetIndexMode(nAxis: Smallint): Smallint;
    procedure Set_PresetDecel(nPreset: Smallint; nFmt: Smallint; Param3: Single);
    function Get_PresetDwellTime(nAxis: Smallint): Integer;
    function Get_SuspendSwitch(nAxis: Smallint): WordBool;
    function Get_Temperature(nChannel: Smallint): Single;
    procedure Set_TorqueFilterBand(nAxis: Smallint; nStage: Smallint; Param3: Single);
    function Get_TemperatureLimitWarning(nChannel: Smallint): Single;
    function Get_TerminalAddress(nTerminalID: Integer): Smallint;
    procedure Set_SuspendInput(nAxis: Smallint; Param2: Smallint);
    function Get_TorqueRefEnable(nAxis: Smallint): WordBool;
    procedure Set_TorqueRefEnable(nAxis: Smallint; Param2: WordBool);
    function Get_TorqueRefErrorFallTime(nAxis: Smallint): Single;
    procedure Set_TorqueRefErrorFallTime(nAxis: Smallint; Param2: Single);
    function Get_TorqueRefFallTime(nAxis: Smallint): Single;
    procedure Set_TorqueRefFallTime(nAxis: Smallint; Param2: Single);
    function Get_TemperatureLimitFatal(nChannel: Smallint): Single;
    function Get_Torque(nAxis: Smallint): Single;
    procedure Set_TerminalAddress(nTerminalID: Integer; Param2: Smallint);
    function Get_StopSwitch(nAxis: Smallint): WordBool;
    function Get_TorqueFilterBand(nAxis: Smallint; nStage: Smallint): Single;
    function Get_TimeScale(nAxis: Smallint): Single;
    procedure Set_TimeScale(nAxis: Smallint; Param2: Single);
    function Get_StopMode(nAxis: Smallint): Smallint;
    procedure Set_StopMode(nAxis: Smallint; Param2: Smallint);
    function Get_SuspendInput(nAxis: Smallint): Smallint;
    function Get_Suspend(nAxis: Smallint): Smallint;
    procedure Set_Suspend(nAxis: Smallint; Param2: Smallint);
    procedure Set_StopInputMode(nAxis: Smallint; Param2: Smallint);
    function Get_TorqueRefRiseTime(nAxis: Smallint): Single;
    function Get_TorqueRef(nAxis: Smallint): Single;
    procedure Set_TorqueLimitNeg(nAxis: Smallint; Param2: Single);
    function Get_TorqueLimitPos(nAxis: Smallint): Single;
    function Get_TorqueLimitNeg(nAxis: Smallint): Single;
    function Get_TorqueProvingMode(nAxis: Smallint): Smallint;
    procedure Set_TorqueProvingMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_PosScaleFactor(nAxis: Smallint; Param2: Single);
    procedure Set_PosRollover(nAxis: Smallint; Param2: Integer);
    function Get_PosRolloverDemand(nAxis: Smallint): Integer;
    procedure Set_TorqueLimitPos(nAxis: Smallint; Param2: Single);
    function Get_PosRolloverTargetLast(nAxis: Smallint): Integer;
    function Get_PosScaleFactor(nAxis: Smallint): Single;
    function Get_TorqueFilterFreq(nAxis: Smallint; nStage: Smallint): Single;
    procedure Set_TorqueRefRiseTime(nAxis: Smallint; Param2: Single);
    function Get_TorqueRefSource(nAxis: Smallint): Smallint;
    procedure Set_TorqueRefSource(nAxis: Smallint; Param2: Smallint);
    function Get_TriggerChannel(nAxis: Smallint): Smallint;
    procedure Set_TriggerChannel(nAxis: Smallint; Param2: Smallint);
    function Get_TriggerCompensation(nAxis: Smallint): Single;
    procedure Set_TorqueFilterType(nAxis: Smallint; nStage: Smallint; Param3: Smallint);
    function Get_TorqueFilterDepth(nAxis: Smallint; nStage: Smallint): Single;
    procedure Set_TorqueFilterDepth(nAxis: Smallint; nStage: Smallint; Param3: Single);
    procedure Set_TorqueRef(nAxis: Smallint; Param2: Single);
    procedure Set_TorqueFilterFreq(nAxis: Smallint; nStage: Smallint; Param3: Single);
    function Get_TorqueFilterType(nAxis: Smallint; nStage: Smallint): Smallint;
    procedure Set_OutputMonitorModeParameter(nOutput: Smallint; Param2: Smallint);
    procedure Set_RemoteNumberOf(nBus: Smallint; nNode: Smallint; nItem: Smallint; Param4: Smallint);
    function Get_RemoteInBank(nCANBus: Smallint; nNode: Smallint; nBank: Smallint): Integer;
    function Get_RemoteInhibitTime(nBus: Smallint): Smallint;
    procedure Set_RemoteOut(nCANBus: Smallint; nNode: Smallint; Param3: Integer);
    function Get_RemoteOutBank(nCANBus: Smallint; nNode: Smallint; nBank: Smallint): Integer;
    procedure Set_RemoteOutBank(nCANBus: Smallint; nNode: Smallint; nBank: Smallint; Param4: Integer);
    function Get_RemoteIn(nCANBus: Smallint; nNode: Smallint): Integer;
    function Get_RemoteInputActiveLevel(nCANBus: Smallint; nNode: Smallint): Integer;
    procedure Set_RemoteMode(nCANBus: Smallint; nNode: Smallint; Param3: Smallint);
    procedure Set_RemoteInhibitTime(nBus: Smallint; Param2: Smallint);
    function Get_RemoteEStop(nCANBus: Smallint; nNode: Smallint): WordBool;
    procedure Set_RemoteEStop(nCANBus: Smallint; nNode: Smallint; Param3: WordBool);
    function Get_RemoteOutputError(nCANBus: Smallint; nNode: Smallint): Integer;
    procedure Set_RemoteObjectFloat(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                    nSubIndex: Smallint; Param5: Single);
    function Get_RemoteObjectString(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                    nSubIndex: Smallint): WideString;
    procedure Set_RemoteObjectString(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                     nSubIndex: Smallint; const Param5: WideString);
    procedure Set_PhaseSearchInput(nAxis: Smallint; Param2: Smallint);
    function Get_PhaseSearchMode(nAxis: Smallint): Smallint;
    procedure Set_PresetIndexMode(nAxis: Smallint; Param2: Smallint);
    function Get_RemoteOut(nCANBus: Smallint; nNode: Smallint): Integer;
    function Get_RemoteOutputActiveLevel(nCANBus: Smallint; nNode: Smallint): Integer;
    procedure Set_RemoteOutputActiveLevel(nCANBus: Smallint; nNode: Smallint; Param3: Integer);
    function Get_RemoteObject(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                              nSubIndex: Smallint; nVarType: Smallint): Integer;
    procedure Set_RemoteObject(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                               nSubIndex: Smallint; nVarType: Smallint; Param6: Integer);
    function Get_RemoteObjectFloat(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                   nSubIndex: Smallint): Single;
    procedure Set_RemoteNode(nCANBus: Smallint; Param2: Smallint);
    function Get_SentinelLatch(nChannel: Smallint): WordBool;
    function Get_SentinelPeriod(nSentinelChannel: Smallint): Integer;
    procedure Set_ScaleFactor(nAxis: Smallint; Param2: Single);
    function Get_SentinelSource(nSentinelChannel: Smallint): Smallint;
    procedure Set_SentinelSource(nSentinelChannel: Smallint; Param2: Smallint);
    procedure Set_SentinelActionParameter(nSentinelChannel: Smallint; Param2: Smallint);
    function Get_RemoteOutX(nCANBus: Smallint; nNode: Smallint; nOutput: Smallint): WordBool;
    procedure Set_RemoteOutX(nCANBus: Smallint; nNode: Smallint; nOutput: Smallint; Param4: WordBool);
    function Get_RemotePDOIn(nBus: Smallint; lCOBID: Integer; nBank: Smallint): Integer;
    function Get_RemotePDOMode(nBus: Smallint; nNode: Smallint): Smallint;
    procedure Set_RemotePDOMode(nBus: Smallint; nNode: Smallint; Param3: Smallint);
    function Get_RemotePDOValid(nBus: Smallint; nNode: Smallint): WordBool;
    procedure Set_SentinelPeriod(nSentinelChannel: Smallint; Param2: Integer);
    function Get_RemoteMode(nCANBus: Smallint; nNode: Smallint): Smallint;
    procedure Set_RemoteOutputError(nCANBus: Smallint; nNode: Smallint; Param3: Integer);
    procedure Set_SentinelAction(nSentinelChannel: Smallint; Param2: Smallint);
    function Get_RemoteNumberOf(nBus: Smallint; nNode: Smallint; nItem: Smallint): Smallint;
    procedure Set_RemoteInputActiveLevel(nCANBus: Smallint; nNode: Smallint; Param3: Integer);
    function Get_RemoteInX(nCANBus: Smallint; nNode: Smallint; nInput: Smallint): WordBool;
    procedure Set_ScaleUnits(nAxis: Smallint; nChannel: Smallint; Param3: Smallint);
    function Get_SentinelAction(nSentinelChannel: Smallint): Smallint;
    function Get_SentinelActionParameter(nSentinelChannel: Smallint): Smallint;
    function Get_SentinelActionMode(nSentinelChannel: Smallint): Smallint;
    procedure Set_SentinelActionMode(nSentinelChannel: Smallint; Param2: Smallint);
    function Get_ScaleUnits(nAxis: Smallint; nChannel: Smallint): Smallint;
    function Get_OptionCardNetworkStatus(nSlot: Smallint): Smallint;
    function Get_OptionCardObjectFloat(nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                       lAttribute: Integer; nType: Smallint): Single;
    function Get_OptionCardObjectString(nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                        lAttribute: Integer; nType: Smallint): WideString;
    function Get_OptionCardObjectInteger(nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                         lAttribute: Integer; nType: Smallint): Integer;
    procedure Set_OptionCardObjectInteger(nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                          lAttribute: Integer; nType: Smallint; Param6: Integer);
    procedure Set_OptionCardNetworkAddress(nSlot: Smallint; Param2: Integer);
    procedure Set_OptionCardObjectString(nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                         lAttribute: Integer; nType: Smallint; 
                                         const Param6: WideString);
    function Get_OptionCardStatus(nSlot: Smallint): Smallint;
    function Get_OptionCardType(nSlot: Smallint): Smallint;
    function Get_OptionCardVersion(nSlot: Smallint; nItem: Smallint): Smallint;
    function Get_Out(nBank: Smallint): Integer;
    procedure Set_Out(nBank: Smallint; Param2: Integer);
    procedure Set_OptionCardObjectFloat(nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                        lAttribute: Integer; nType: Smallint; Param6: Single);
    procedure Set_OutputMonitorMode(nOutput: Smallint; Param2: Smallint);
    function Get_OutX(nOutput: Smallint): WordBool;
    function Get_ParameterValuesSubset(nSubset: Smallint; nParameter: Smallint): OleVariant;
    function Get_OutputType(nOutput: Smallint): Smallint;
    procedure Set_OutputActiveLevel(nBank: Smallint; Param2: Integer);
    function Get_OutputMonitorMode(nOutput: Smallint): Smallint;
    function Get_ParameterListString(nParameter: Smallint; nEnumeration: Smallint): WideString;
    function Get_ParameterNumberSubset(nSubset: Smallint): OleVariant;
    function Get_OutputActiveLevel(nBank: Smallint): Integer;
    function Get_ParamSaveMode(nChannel: Smallint): WordBool;
    procedure Set_ParamSaveMode(nChannel: Smallint; Param2: WordBool);
    procedure Set_OutX(nOutput: Smallint; Param2: WordBool);
    function Get_PDOLossMode(nAxis: Smallint): Smallint;
    function Get_PhaseSearchCurrent(nAxis: Smallint): Single;
    procedure Set_PDOLossMode(nAxis: Smallint; Param2: Smallint);
    function Get_PhaseSearchBackoff(nAxis: Smallint): Smallint;
    function Get_PhaseSearchSpeed(nAxis: Smallint): Smallint;
    function Get_PhaseSearchBandwidth(nAxis: Smallint): Single;
    procedure Set_PhaseSearchBandwidth(nAxis: Smallint; Param2: Single);
    function Get_PhaseSearchOutput(nAxis: Smallint): Smallint;
    procedure Set_PhaseSearchOutput(nAxis: Smallint; Param2: Smallint);
    function Get_PhaseSearchInput(nAxis: Smallint): Smallint;
    procedure Set_PhaseSearchBackoff(nAxis: Smallint; Param2: Smallint);
    procedure Set_PhaseSearchCurrent(nAxis: Smallint; Param2: Single);
    procedure Set_PhaseSearchMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_PLCOperator(nChannel: Smallint; nConditionNo: Smallint; Param3: Smallint);
    procedure Set_PhaseSearchSpeed(nAxis: Smallint; Param2: Smallint);
    function Get_PhaseSearchStatus(nAxis: Smallint): WordBool;
    function Get_PhaseSearchTravel(nAxis: Smallint): Smallint;
    procedure Set_PhaseSearchTravel(nAxis: Smallint; Param2: Smallint);
    function Get_PLCCondition(nChannel: Smallint; nConditionNo: Smallint): Smallint;
    procedure Set_PLCCondition(nChannel: Smallint; nConditionNo: Smallint; Param3: Smallint);
    function Get_PLCTaskData(nChannel: Smallint; var pnCondition1: Smallint; 
                             var pnParam1: Smallint; var pnOperator: Smallint; 
                             var pnCondition2: Smallint; var pnParam2: Smallint): WordBool;
    procedure Set_PLCEnableAction(nChannel: Smallint; Param2: WordBool);
    function Get_PLCOperator(nChannel: Smallint; nConditionNo: Smallint): Smallint;
    function Get_PLCEnableAction(nChannel: Smallint): WordBool;
    function Get_PLCParameter(nChannel: Smallint; nConditionNo: Smallint): Smallint;
    procedure Set_PLCParameter(nChannel: Smallint; nConditionNo: Smallint; Param3: Smallint);
    function Get_TorqueDemand(nAxis: Smallint): Single;
    function Get_StopInput(nAxis: Smallint): Smallint;
    procedure Set_StopInput(nAxis: Smallint; Param2: Smallint);
    procedure Set_StepperScale(nChannel: Smallint; Param2: Single);
    function Get_StepperIO(nAxis: Smallint): Smallint;
    function Get_StepperScale(nChannel: Smallint): Single;
    procedure Set_StepperWrap(nChannel: Smallint; Param2: Single);
    function Get_SplineStart(nAxis: Smallint): Integer;
    procedure Set_SplineStart(nAxis: Smallint; Param2: Integer);
    function Get_SplineSuspendTime(nAxis: Smallint): Integer;
    function Get_StepperVel(nChannel: Smallint): Single;
    function Get_StepperWrap(nChannel: Smallint): Single;
    procedure Set_Stepper(nChannel: Smallint; Param2: Single);
    procedure Set_StepperDelay(nChannel: Smallint; Param2: Single);
    function Get_SpeedRefDecelTime(nAxis: Smallint): Single;
    procedure Set_SpeedRefAccelTime(nAxis: Smallint; Param2: Single);
    function Get_SpeedRefDecelJerkEndTime(nAxis: Smallint): Single;
    function Get_SpeedRefAccelTime(nAxis: Smallint): Single;
    function Get_SpeedRefDecelJerkStartTime(nAxis: Smallint): Single;
    procedure Set_SpeedRefDecelJerkStartTime(nAxis: Smallint; Param2: Single);
    function Get_StepperMode(nChannel: Smallint): Smallint;
    procedure Set_StepperMode(nChannel: Smallint; Param2: Smallint);
    function Get_StepperDelay(nChannel: Smallint): Single;
    procedure Set_SpeedRefDecelJerkEndTime(nAxis: Smallint; Param2: Single);
    procedure Set_Spline(nAxis: Smallint; Param2: Smallint);
    procedure Set_StepperIO(nAxis: Smallint; Param2: Smallint);
    function Get_SplineEnd(nAxis: Smallint): Integer;
    function Get_SoftLimitReverse(nAxis: Smallint): Single;
    procedure Set_SoftLimitReverse(nAxis: Smallint; Param2: Single);
    function Get_SoftwareDiagnostic(nParam1: Smallint; nParam2: Smallint): Integer;
    function Get_SerialBaud(nPort: Smallint): Integer;
    procedure Set_SerialBaud(nPort: Smallint; Param2: Integer);
    function Get_SoftLimitForward(nAxis: Smallint): Single;
    function Get_SentinelTriggerValueInteger(nSentinelChannel: Smallint; nSentinelBand: Smallint): Integer;
    procedure Set_SentinelSource2(nSentinelChannel: Smallint; Param2: Smallint);
    function Get_SentinelSource2Parameter(nSentinelChannel: Smallint): Smallint;
    procedure Set_SoftLimitForward(nAxis: Smallint; Param2: Single);
    function Get_SoftLimitMode(nAxis: Smallint): Smallint;
    procedure Set_SoftLimitMode(nAxis: Smallint; Param2: Smallint);
    procedure Set_SentinelTriggerValueInteger(nSentinelChannel: Smallint; nSentinelBand: Smallint; 
                                              Param3: Integer);
    procedure Set_SRamp(nAxis: Smallint; Param2: Single);
    function Get_StaticHandle(const lpszTask: WideString; const lpszVariable: WideString): Integer;
    function Get_Stepper(nChannel: Smallint): Single;
    procedure Set_SplineEnd(nAxis: Smallint; Param2: Integer);
    function Get_SplineIndex(nAxis: Smallint): Integer;
    procedure Set_SplineSuspendTime(nAxis: Smallint; Param2: Integer);
    function Get_SerialBaudsSupported(nChannel: Smallint): OleVariant;
    function Get_Sextant(nAxis: Smallint): Smallint;
    procedure Set_Sextant(nAxis: Smallint; Param2: Smallint);
    function Get_SplineTime(nAxis: Smallint): Integer;
    procedure Set_SplineTime(nAxis: Smallint; Param2: Integer);
    function Get_SRamp(nAxis: Smallint): Single;
    function Get_JogAwayOffset(nAxis: Smallint): Single;
    function Get_InState(nBank: Smallint): Integer;
    function Get_InputActiveLevel(nBank: Smallint): Integer;
    function Get_JogDecelTimeMax(nAxis: Smallint): Integer;
    function Get_JogAway(nAxis: Smallint): Smallint;
    procedure Set_JogAway(nAxis: Smallint; Param2: Smallint);
    procedure Set_IncR(nAxis: Smallint; Param2: Single);
    function Get_InKey(nTerminalID: Integer): Smallint;
    procedure Set_InputDebounce(nBank: Smallint; Param2: Smallint);
    procedure Set_InputActiveLevel(nBank: Smallint; Param2: Integer);
    function Get_InputDebounce(nBank: Smallint): Smallint;
    procedure Set_IncA(nAxis: Smallint; Param2: Single);
    procedure Set_JogCommand(nAxis: Smallint; Param2: Smallint);
    function Get_In_(nBank: Smallint): Integer;
    function Get_Jog(nAxis: Smallint): Single;
    procedure Set_Jog(nAxis: Smallint; Param2: Single);
    function Get_HTADeadband(nAxis: Smallint): Single;
    procedure Set_HTADeadband(nAxis: Smallint; Param2: Single);
    function Get_HTAFilter(nAxis: Smallint): Single;
    function Get_InX(nInput: Smallint): WordBool;
    procedure Set_JogAccelTimeMax(nAxis: Smallint; Param2: Integer);
    function Get_JogCommand(nAxis: Smallint): Smallint;
    function Get_JogAccelTimeMax(nAxis: Smallint): Integer;
    function Get_InStateX(nInput: Smallint): WordBool;
    function Get_InternalData(nEnum1: Smallint; nEnum2: Smallint): OleVariant;
    procedure Set_InputNegTrigger(nBank: Smallint; Param2: Integer);
    function Get_SpeedTestRefAccelTime(nAxis: Smallint): Single;
    procedure Set_SpeedTestRefAccelTime(nAxis: Smallint; Param2: Single);
    procedure Set_SpeedRefDecelTime(nAxis: Smallint; Param2: Single);
    procedure Set_SpeedTestRefDecelTime(nAxis: Smallint; Param2: Single);
    function Get_Spline(nAxis: Smallint): Smallint;
    procedure Set_SpeedTestRef(nAxis: Smallint; Param2: Single);
    function Get_SpeedRefAccelJerkEndTime(nAxis: Smallint): Single;
    procedure Set_SpeedRefAccelJerkEndTime(nAxis: Smallint; Param2: Single);
    function Get_SpeedRefAccelJerkStartTime(nAxis: Smallint): Single;
    procedure Set_SpeedRefAccelJerkStartTime(nAxis: Smallint; Param2: Single);
    function Get_SpeedRefAccelSource(nAxis: Smallint): Smallint;
    procedure Set_SpeedRefAccelSource(nAxis: Smallint; Param2: Smallint);
    function Get_SpeedTestRefDecelTime(nAxis: Smallint): Single;
    procedure Set_InputMode(nBank: Smallint; Param2: Integer);
    function Get_InputNegTrigger(nBank: Smallint): Integer;
    procedure Set_SpeedRefErrorDecelTime(nAxis: Smallint; Param2: Single);
    function Get_InputPosTrigger(nBank: Smallint): Integer;
    procedure Set_InputPosTrigger(nBank: Smallint; Param2: Integer);
    function Get_InputMode(nBank: Smallint): Integer;
    procedure Set_SpeedRefEnable(nAxis: Smallint; Param2: WordBool);
    function Get_SpeedRefErrorDecelTime(nAxis: Smallint): Single;
    function Get_SpeedTestRef(nAxis: Smallint): Single;
    function Get_SpeedRefSource(nAxis: Smallint): Smallint;
    procedure Set_SpeedRefSource(nAxis: Smallint; Param2: Smallint);
    function Get_SpeedRefEnable(nAxis: Smallint): WordBool;
    procedure Set_SentinelSource2Parameter(nSentinelChannel: Smallint; Param2: Smallint);
    function Get_VFThreePointFreq(nAxis: Smallint): Single;
    procedure Set_VFThreePointFreq(nAxis: Smallint; Param2: Single);
    function Get_VFThreePointMode(nAxis: Smallint): Smallint;
    procedure Set_TriggerValue(nAxis: Smallint; Param2: Single);
    procedure Set_UserMotion(nAxis: Smallint; Param2: Smallint);
    function Get_VelScaleFactor(nAxis: Smallint): Single;
    procedure Set_VFThreePointMode(nAxis: Smallint; Param2: Smallint);
    function Get_ZeroSpeedDeadband(nAxis: Smallint): Single;
    procedure Set_ZeroSpeedDeadband(nAxis: Smallint; Param2: Single);
    procedure Set_VFProfile(nAxis: Smallint; Param2: Single);
    function Get_VFSlipCompensationMode(nAxis: Smallint): Smallint;
    procedure Set_VFSlipCompensationMode(nAxis: Smallint; Param2: Smallint);
    function Get_TriggerValue(nAxis: Smallint): Single;
    procedure Set_TriggerMode(nAxis: Smallint; Param2: Smallint);
    function Get_TriggerSource(nAxis: Smallint): Smallint;
    procedure Set_TriggerCompensation(nAxis: Smallint; Param2: Single);
    function Get_VelFatalMode(nAxis: Smallint): Smallint;
    procedure Set_UserTimeUnits(nAxis: Smallint; const Param2: WideString);
    function Get_TriggerMode(nAxis: Smallint): Smallint;
    function Get_UserPositionUnits(nAxis: Smallint): WideString;
    procedure Set_UserPositionUnits(nAxis: Smallint; const Param2: WideString);
    function Get_UserTimeUnits(nAxis: Smallint): WideString;
    function Get_TriggerInput(nAxis: Smallint): Smallint;
    procedure Set_TriggerInput(nAxis: Smallint; Param2: Smallint);
    procedure Set_TriggerSource(nAxis: Smallint; Param2: Smallint);
    function Get_VFDeadband(nAxis: Smallint; nChannel: Smallint): Single;
    procedure Set_TerminalMode(nTerminalID: Integer; Param2: Smallint);
    function Get_TerminalPort(nTerminalID: Integer): Smallint;
    procedure Set_VFDeadbandCentreFreq(nAxis: Smallint; nChannel: Smallint; Param3: Single);
    function Get_VFBoostTransitionMode(nAxis: Smallint): Smallint;
    procedure Set_VFBoostTransitionMode(nAxis: Smallint; Param2: Smallint);
    function Get_TerminalMode(nTerminalID: Integer): Smallint;
    procedure Set_TerminalXoff(nTerminalID: Integer; Param2: WordBool);
    procedure Set_Torque(nAxis: Smallint; Param2: Single);
    procedure Set_TerminalPort(nTerminalID: Integer; Param2: Smallint);
    function Get_TerminalDevice(nTerminalID: Integer): Smallint;
    procedure Set_TerminalDevice(nTerminalID: Integer; Param2: Smallint);
    function Get_VFDeadbandCentreFreq(nAxis: Smallint; nChannel: Smallint): Single;
    function Get_VFProfile(nAxis: Smallint): Single;
    function Get_VelSetpointMax(nAxis: Smallint): Single;
    procedure Set_VelSetpointMax(nAxis: Smallint; Param2: Single);
    function Get_VFThreePointVolts(nAxis: Smallint): Single;
    procedure Set_VFThreePointVolts(nAxis: Smallint; Param2: Single);
    function Get_VoltageDemand(nAxis: Smallint; nChannel: Smallint): Single;
    procedure Set_VelScaleUnits(nAxis: Smallint; const Param2: WideString);
    procedure Set_VelSetpointMin(nAxis: Smallint; Param2: Single);
    procedure Set_VFDeadband(nAxis: Smallint; nChannel: Smallint; Param3: Single);
    function Get_VelSetpointMin(nAxis: Smallint): Single;
    procedure Set_VelScaleFactor(nAxis: Smallint; Param2: Single);
    function Get_VelScaleUnits(nAxis: Smallint): WideString;
    function Get_SpeedMeasured(nAxis: Smallint): Single;
    procedure Set_SpeedObserverK1(nAxis: Smallint; Param2: Single);
    procedure Set_SpeedObserverKJ(nAxis: Smallint; Param2: Single);
    function Get_SpeedObserverK1(nAxis: Smallint): Single;
    function Get_SpeedFilterType(nAxis: Smallint): Smallint;
    procedure Set_SpeedFilterType(nAxis: Smallint; Param2: Smallint);
    procedure Set_SpeedObserverK2(nAxis: Smallint; Param2: Single);
    function Get_SpeedObserverKJ(nAxis: Smallint): Single;
    procedure Set_SpeedFilterRipple(nAxis: Smallint; Param2: Single);
    function Get_SpeedRef(nAxis: Smallint): Single;
    procedure Set_SpeedRef(nAxis: Smallint; Param2: Single);
    function Get_SpeedObserverK2(nAxis: Smallint): Single;
    procedure Set_SpeedObserverEnable(nAxis: Smallint; Param2: WordBool);
    function Get_SentinelState(nSentinelChannel: Smallint): Smallint;
    procedure Set_SentinelTriggerMode(nSentinelChannel: Smallint; Param2: Smallint);
    function Get_SentinelTriggerValueFloat(nSentinelChannel: Smallint; nSentinelBand: Smallint): Single;
    function Get_SentinelSourceParameter(nSentinelChannel: Smallint): Smallint;
    procedure Set_SentinelSourceParameter(nSentinelChannel: Smallint; Param2: Smallint);
    function Get_SentinelSource2(nSentinelChannel: Smallint): Smallint;
    function Get_SentinelTriggerMode(nSentinelChannel: Smallint): Smallint;
    function Get_Speed(nAxis: Smallint): Single;
    function Get_SpeedObserverEnable(nAxis: Smallint): WordBool;
    procedure Set_SentinelTriggerValueFloat(nSentinelChannel: Smallint; nSentinelBand: Smallint; 
                                            Param3: Single);
    function Get_SentinelTriggerAbsolute(nSentinelChannel: Smallint): WordBool;
    procedure Set_SentinelTriggerAbsolute(nSentinelChannel: Smallint; Param2: WordBool);
    function Get_SpeedError(nAxis: Smallint): Single;
    function Get_VariableData(const bstrTaskName: WideString; const bstrVarName: WideString): OleVariant;
    procedure Set_VariableData(const bstrTaskName: WideString; const bstrVarName: WideString; 
                               Param3: OleVariant);
    function Get_VectorAngle(nAxisX: Smallint; nAxisY: Smallint): Single;
    function Get_Vel(nAxis: Smallint): Single;
    function Get_VelDemand(nAxis: Smallint): Single;
    function Get_VelDemandPath(nAxis: Smallint): Single;
    procedure Set_VelRef(nAxis: Smallint; Param2: Single);
    function Get_VelFatal(nAxis: Smallint): Single;
    procedure Set_VelFatal(nAxis: Smallint; Param2: Single);
    function Get_VelError(nAxis: Smallint): Single;
    procedure Set_VelFatalMode(nAxis: Smallint; Param2: Smallint);
    function Get_VelRef(nAxis: Smallint): Single;
    function Get_StopInputMode(nAxis: Smallint): Smallint;
    function Get_SpeedDemand(nAxis: Smallint): Single;
    procedure Set_SpeedDemand(nAxis: Smallint; Param2: Single);
    function Get_SpeedFilterBand(nAxis: Smallint): Single;
    function Get_SpeedErrorFatal(nAxis: Smallint): Single;
    procedure Set_SpeedErrorFatal(nAxis: Smallint; Param2: Single);
    procedure Set_Speed(nAxis: Smallint; Param2: Single);
    procedure Set_SpeedFilterBand(nAxis: Smallint; Param2: Single);
    function Get_SpeedFilterFreq(nAxis: Smallint): Single;
    procedure Set_SpeedFilterFreq(nAxis: Smallint; Param2: Single);
    function Get_SpeedFilterPoles(nAxis: Smallint): Smallint;
    procedure Set_SpeedFilterPoles(nAxis: Smallint; Param2: Smallint);
    function Get_SpeedFilterRipple(nAxis: Smallint): Single;
    function Get_USBDeviceList: OleVariant;
    procedure Set_USBDeviceList(Value: OleVariant);
    function Get_H2USBDeviceList: OleVariant;
    procedure Set_H2USBDeviceList(Value: OleVariant);
    function Get_ExtendedEventData: OleVariant;
    procedure Set_ExtendedEventData(Value: OleVariant);
    function Get_BufferChars: OleVariant;
    procedure Set_BufferChars(Value: OleVariant);
    function Get_BootloaderBaudsSupported: OleVariant;
    procedure Set_BootloaderBaudsSupported(Value: OleVariant);
  public
    procedure DoLocate(nTerminalID: Integer; nColumn: Smallint; nRow: Smallint);
    procedure DoPrint(nTermID: Integer; const str: WideString);
    procedure DoUpdateEPLFirmware(const sFilename: WideString);
    procedure DoMintCommandEx(nCommand: Smallint; vParam: OleVariant);
    procedure DoMintBreak;
    procedure DoKnife(nAxis: Smallint);
    procedure DoUpdateBootloader(const bstrBootloader: WideString);
    procedure DoUpdateFirmwareAtSpeed(const szFilename: WideString; nSpeed: Integer);
    procedure DoUpdatePLXEEPROM(const lpszFile: WideString);
    procedure DoUpdateFirmware(const szFilename: WideString);
    procedure DoUpdateCommsFirmware(const szFilename: WideString);
    procedure DoSystemDefaults;
    procedure DoMintCommand(nCommand: Smallint);
    procedure DoParameterSave;
    procedure DoParameterTableDownload(const lpszFile: WideString);
    procedure DoMintFileDownload(const szFilename: WideString);
    procedure DoPLCDefault(nLevel: Smallint);
    procedure DoPopRedirect;
    procedure DoParameterTableUpload(const lpszFile: WideString);
    procedure DoGo3(nAxis1: Smallint; nAxis2: Smallint; nAxis3: Smallint);
    procedure DoGo4(nAxis1: Smallint; nAxis2: Smallint; nAxis3: Smallint; nAxis4: Smallint);
    procedure DoInstallMintSystemFile(const szFilename: WideString);
    procedure DoH2ParameterTableCloneRestore(const sFilename: WideString);
    procedure DoInitCompilerInfo;
    procedure DoH2ParameterTableCloneSave(const sFilename: WideString);
    procedure DoWait(lTime: Integer);
    procedure DoCaptureTrigger;
    procedure DoClearErrorLog;
    procedure DoCaptureChannelUpload(nChannel: Smallint; var pvData: OleVariant; nSize: Smallint);
    procedure DoResetAll;
    procedure DoSerialClearError(var plError: Integer);
    procedure DoGo2(nAxis1: Smallint; nAxis2: Smallint);
    procedure DoControllerReset;
    procedure DoDataFileDownload(const lpszFile: WideString);
    procedure DoCompRefLogReset;
    procedure DoCancel(nAxis: Smallint);
    procedure DoCancelAll;
    procedure DoCls(nTerminalID: Integer);
    procedure DoSerialClearReceiveBuffer;
    procedure DoSymbolTableUpload(const szFilename: WideString);
    procedure DoRemotePDOOut(nBus: Smallint; lCOBID: Integer; nPDOLength: Smallint; 
                             nBank0Data: Integer; nBank1Data: Integer);
    procedure DoRemoteReset(nCANBus: Smallint; nNodeId: Smallint);
    procedure DoUpdateLanguagePack(const sFilename: WideString);
    procedure DoUpdateAndProgramFirmware(const bstrFirmware: WideString; nSpeed: Integer; 
                                         nMinBuildNumber: Smallint);
    procedure DoUpdateFPGA(const szFilename: WideString);
    procedure DoReset(nAxis: Smallint);
    procedure DoSerialClearTransmitBuffer;
    procedure DoStop(nAxis: Smallint);
    procedure DoPushRedirect(nBus: Integer; nNode: Integer);
    procedure DoProcessorReset;
    procedure DoProcessorResetParam(nParameter: Smallint);
    procedure DoMintFileUpload(const szFilename: WideString);
    procedure DoMintRun;
    procedure DoNVRAMUpload(const lpszFile: WideString);
    procedure DoNodeScan(nCANBus: Smallint; nNode: Smallint);
    procedure DoNVRAMDownload(const lpszFile: WideString);
    procedure DoMultipleCommandsBegin;
    procedure DoCompileMintProgram(const bstrSource: WideString; const bstrDest: WideString; 
                                   nCompilerFlags: Integer);
    procedure SetControllerProdInfo(const lpszControllerType: WideString; 
                                    const lpszControllerVersion: WideString; 
                                    const lpszSerialNumber: WideString; nFuncRev: Smallint; 
                                    nBoardType: Smallint; nPowerCycles: Integer; nNoAxes: Smallint; 
                                    nExpCards: Smallint);
    procedure GetCPLDInfo(nBoard: Smallint; var pnDecodeCPLD: Smallint; var pnIOCPLD: Smallint; 
                          var parrASIC: OleVariant);
    procedure GetControllerProdInfo(var pszType: WideString; var pszVersion: WideString; 
                                    var pszSerial: WideString; var pnFnRev: Smallint; 
                                    var pnBoardType: Smallint; var plPowerCycles: Integer; 
                                    var pnAxes: Smallint; var pnExpCards: Smallint);
    procedure GetCommsRead(nAddress: Smallint; var pfValue: Single);
    procedure SetCommsWrite(nAddress: Smallint; fValue: Single);
    procedure SetCommsWriteMultipleHCP2(nNode: Smallint; nAddress: Smallint; vValues: OleVariant);
    procedure CamTable(nAxis: Smallint; fPosArray: OleVariant; fLengthArray: OleVariant);
    procedure GetCapturedData(const sFilename: WideString; bExtrapolateFollowingError: WordBool; 
                              bExtrapolateVelocity: WordBool; bShowProgress: WordBool);
    procedure CamSegment(nAxis: Smallint; nTable: Smallint; nStartSegment: Integer; 
                         fSegmentArray: OleVariant);
    procedure GetCompRefCalcs(var pnParamA: Smallint; var pnParamB: Smallint; var pulARaw: Integer; 
                              var pfA: Single; var pfAGain: Single; var pfAFunction: Single; 
                              var plBRaw: Integer; var pfB: Single; var pfBGain: Single; 
                              var pfBFunction: Single; var pfCOperator: Single; 
                              var pfCFunction: Single);
    procedure GetCompRefLog(var pnParamA: Smallint; var pnParamB: Smallint; var pfCRMax: Single; 
                            var pfMaxALog: Single; var pfMaxBLog: Single; var pfCRMin: Single; 
                            var pfMinALog: Single; var pfMinBLog: Single);
    procedure GetCommsMapList(nIndex: Smallint; var pnMode: Smallint; var pnParameter: Smallint; 
                              var pstrName: WideString);
    procedure SetCommsWriteMultiple(nAddress: Smallint; fValues: OleVariant);
    procedure SetAbsEncoderLinearMotorInfo(nAxis: Smallint; const bstrCatalogNumber: WideString; 
                                           const bstrSpecNumber: WideString; 
                                           const bstrManufactureDate: WideString; 
                                           fMotorRatedCurrent: Single; fMotorPeakCurrent: Single; 
                                           fMotorPeakDuration: Single; fMotorFlux: Single; 
                                           fStatorResistance: Single; fStatorInductance: Single; 
                                           fMaxLinearSpeed: Single; fMotorPolePitch: Single; 
                                           fInertia: Single; fDamping: Single);
    procedure GetAPIDefnTableForController(bForceUpload: WordBool; var pbstrPath: WideString);
    procedure GetAPIValueEx(nTable: Smallint; nFamily: Smallint; nIndex: Smallint; 
                            vArgs: OleVariant; var pvCurrentValue: OleVariant; 
                            var pvMin: OleVariant; var pvMax: OleVariant; 
                            var pvDefault: OleVariant; var psUnits: WideString; 
                            var pnDataType: Smallint);
    procedure SetVirtualControllerLink;
    procedure SetUSBControllerLink(nNode: Smallint);
    procedure SetUSBDeviceLink(const bstrLinkName: WideString);
    procedure GetBusProcessDataTelegram(nBus: Smallint; bIn: WordBool; var pnControlWord: Integer; 
                                        var pvRawData: OleVariant; var pvFloatData: OleVariant);
    procedure GetCommsReadHCP2(nNode: Smallint; nAddress: Smallint; var pfValue: Single);
    procedure SetCommsWriteHCP2(nNode: Smallint; nAddress: Smallint; fValue: Single);
    procedure SetAbsEncoderRotaryMotorInfo(nAxis: Smallint; const strCatalogNumber: WideString; 
                                           const strSpecNumber: WideString; 
                                           const strManufactureDate: WideString; 
                                           fMotorRatedCurrent: Single; fMotorPeakCurrent: Single; 
                                           fMotorPeakDuration: Single; fMotorFlux: Single; 
                                           fStatorResistance: Single; fStatorInductance: Single; 
                                           nMaxRotarySpeed: Smallint; nMotorPoles: Smallint; 
                                           fInertia: Single; fDamping: Single);
    procedure GetAbsEncoderRotaryInfo(nAxis: Smallint; var pnFeedbackType: Smallint; 
                                      var pbstrSerialNumber: WideString; 
                                      var pbstrProgramVersion: WideString; 
                                      var pbstrPartNumber: WideString; var pnTypeNumber: Smallint; 
                                      var plAbsCountsPerRev: Integer; var pnCyclesPerRev: Smallint; 
                                      var pnMaxRotarySpeed: Smallint; var pnAbsCountBits: Smallint; 
                                      var plMinCountsPerRev: Integer; 
                                      var plMaxCountsPerRev: Integer; var pnNumTurns: Smallint);
    procedure GetAbsEncoderRotaryMotorInfo(nAxis: Smallint; var pbstrCatalogNumber: WideString; 
                                           var pbstrSpecNumber: WideString; 
                                           var pbstrManufactureDate: WideString; 
                                           var pfMotorRatedCurrent: Single; 
                                           var pfMotorPeakCurrent: Single; 
                                           var pfMotorPeakDuration: Single; 
                                           var pfMotorFlux: Single; var pfStatorResistance: Single; 
                                           var pfStatorInductance: Single; 
                                           var pnMaxRotarySpeed: Smallint; 
                                           var pnMotorPoles: Smallint; var pfInertia: Single; 
                                           var pfDamping: Single);
    procedure SetBusReceiveTelegram(nBus: Smallint; nCountWords: Smallint; vData: OleVariant);
    procedure SetControllerTarget(nTarget: Smallint);
    procedure InstallUnknownEventHandler(bInstall: WordBool);
    procedure InstallUSBDeviceChangedHandler(hWnd: Integer; var phNotification: Integer);
    procedure InstallTimerEventHandler(bInstall: WordBool);
    procedure SetDSPControllerLink(nNode: Smallint; nPort: Smallint; lBaudRate: Integer; 
                                   bOpenPort: WordBool);
    procedure SetEthernetControllerLink(const sLinkName: WideString);
    procedure InstallBusMessageEventHandler(bInstall: WordBool);
    procedure InstallAxisIdleEventHandler(bInstall: WordBool);
    procedure InstallBusEventHandler(bInstall: WordBool);
    procedure InstallNetDataEventHandler(bInstall: WordBool);
    procedure InstallCommsEventHandler(bInstall: WordBool);
    procedure InstallDPREventHandler(bInstall: WordBool);
    procedure InstallSerialReceiveEventHandler(bInstall: WordBool);
    procedure GetCommsMapInfo(var pnSize: Smallint; var pnBase: Smallint; var pnChannels: Smallint);
    procedure CircleA(nXAxis: Smallint; nYAxis: Smallint; fXCentre: Single; fYCentre: Single; 
                      fAngle: Single);
    procedure GetCaptureModeParameterObject(nChannel: Smallint; var pnBus: Smallint; 
                                            var pnNode: Smallint; var pnIndex: Smallint; 
                                            var pnSubIndex: Smallint; var pnType: Smallint);
    procedure CamBoxData(nCamBox: Smallint; nOutput: Smallint; nSource: Smallint; 
                         nChannel: Smallint; nTime: Smallint; newValue: OleVariant);
    procedure GetCaptureInfo(var pnNumPoints: Smallint; var pnFirstElement: Smallint);
    procedure CircleR(nXAxis: Smallint; nYAxis: Smallint; fXCentre: Single; fYCentre: Single; 
                      fAngle: Single);
    procedure InstallTerminalReceiveEventHandler(bInstall: WordBool);
    procedure InstallStopEventHandler(bInstall: WordBool);
    procedure InstallResetEventHandler(bInstall: WordBool);
    procedure SetCaptureModeParameterObject(nChannel: Smallint; nBus: Smallint; nNode: Smallint; 
                                            nIndex: Smallint; nSubIndex: Smallint; nType: Smallint);
    procedure SetSerialControllerLink(nType: Smallint; nNode: Smallint; nPort: Smallint; 
                                      lBaudRate: Integer; bOpenPort: WordBool);
    procedure InstallStopSwitchEventHandler(bInstall: WordBool);
    procedure DoFactoryDefaults;
    procedure DoEventPend(nEventType: Smallint; nEventData1: Integer; nEventData2: Integer);
    procedure DoEventUnPend(nEventType: Smallint; nEventData1: Integer; nEventData2: Integer);
    procedure DoDataFileUpload(const lpszFile: WideString; bArraysOnly: WordBool);
    procedure DoFactoryDefaultsParam(nType: Smallint);
    procedure DoFileDelete(const sFilename: WideString);
    procedure DoFileUpload(const sSourceName: WideString; nType: Smallint; 
                           const sDestPath: WideString);
    procedure DoFileSystemDownload(const lpszSource: WideString);
    procedure DoFileSystemUpload(const lpszDest: WideString);
    procedure DoFileDownload(const sSourcePath: WideString; const sDestName: WideString; 
                             nDestType: Smallint);
    procedure DoGo(nNumberOfAxes: Smallint; nAxisArray: OleVariant);
    procedure DoGo1(nAxis1: Smallint);
    procedure DoAutotune(nAxis: Smallint; nOp: Smallint);
    procedure DoAPIValueTableUpload(nTable: Smallint; const lpszFile: WideString);
    procedure DoAPIDefinitionTableUpload(const szFilename: WideString);
    procedure DoAbort;
    procedure DoCompileMintProgramOffline(const bstrSource: WideString; const bstrDest: WideString; 
                                          nTarget: Smallint; nCompilerVersion: Smallint; 
                                          const bstrSymbolTable: WideString; nCompileFlags: Integer);
    procedure DoCANBusReset(nCANBus: Smallint);
    procedure DoAPIValueTableDownload(nTable: Smallint; const lpszFile: WideString);
    procedure DoCamPhase(nAxis: Smallint; nIndex: Smallint; nSegments: Smallint; fdeltaMSD: Single);
    procedure DoAutotuneAbort;
    procedure DoAPIValueTableUploadPartial(nTable: Smallint; const lpszAPIDefnTable: WideString; 
                                           const lpszOutputFile: WideString);
    procedure DoADCOffsetTrim(nChannel: Smallint);
    procedure DoAPIValueTableUploadCSV(nTable: Smallint; const sFilename: WideString);
    procedure DoBusReset(nBus: Smallint);
    procedure DoErrorClear(nGroup: Smallint; nData: Integer);
    procedure GetBusMuxCycleConfig(nBus: Smallint; nNode: Smallint; var pnMuxRatio: Smallint; 
                                   var pvNodes: OleVariant);
    procedure GetBusProcessDataInfo(nBusID: Smallint; bIn: WordBool; var pnCountModes: Smallint; 
                                    var pnCountChannels: Smallint);
    procedure GetBusProcessDataList(nBus: Smallint; bIn: WordBool; nIndex: Smallint; 
                                    var pnMode: Smallint; var pnParam: Smallint; 
                                    var pstrName: WideString);
    procedure Blend(nAxis: Smallint);
    procedure SetAsyncError(lPresent: Integer; lMisc: Integer; lAxisErrorArray: OleVariant; 
                            lAxisWarningArray: OleVariant);
    procedure GetAutotuneParamLimits(nParam: Smallint; var pfDefault: Single; var pfMin: Single; 
                                     var pfMax: Single);
    procedure GetAsyncError(var plPresent: Integer; var plMisc: Integer; 
                            var plAxisErrorArray: OleVariant; var plAxisWarningArray: OleVariant);
    procedure GetAbsEncoderLinearInfo(nAxis: Smallint; var pnFeedbackType: Smallint; 
                                      var pbstrSerialNumber: WideString; 
                                      var pbstrProgramVersion: WideString; 
                                      var pbstrPartNumber: WideString; var pnTypeNumber: Smallint; 
                                      var plAbsLinearResolution: Integer; 
                                      var plLinearCycleLength: Integer; 
                                      var plMaxLinearSpeed: Integer; var pnAbsCountBits: Smallint; 
                                      var plMinLinearResolution: Integer; 
                                      var plMaxLinearResolution: Integer);
    procedure GetAbsEncoderLinearMotorInfo(nAxis: Smallint; var pbstrCatalogNumber: WideString; 
                                           var pbstrSpecNumber: WideString; 
                                           var pbstrManufactureDate: WideString; 
                                           var pfMotorRatedCurrent: Single; 
                                           var pfMotorPeakCurrent: Single; 
                                           var pfMotorPeakDuration: Single; 
                                           var pfMotorFlux: Single; var pfStatorResistance: Single; 
                                           var pfStatorInductance: Single; 
                                           var pfMaxLinearSpeed: Single; 
                                           var pfMotorPolePitch: Single; var pfInertia: Single; 
                                           var pfDamping: Single);
    procedure SetBusPDOMapConfig(nBus: Smallint; nNode: Smallint; bIn: WordBool; 
                                 nPeerNode: Smallint; nStartSlot: Smallint; nEndSlot: Smallint);
    procedure SetBusMuxCycleConfig(nBus: Smallint; nNode: Smallint; nMuxRatio: Smallint; 
                                   vNodes: OleVariant);
    procedure GetBusPDOMapConfig(nBus: Smallint; nNode: Smallint; bIn: WordBool; 
                                 nPeerNode: Smallint; var pnStartSlot: Smallint; 
                                 var pnEndSlot: Smallint);
    procedure GetBusMessageInfo(nBus: Smallint; var pnTime: Integer; var pnIdentifier: Smallint; 
                                var pvData: OleVariant);
    procedure DoDefault(nAxis: Smallint);
    procedure DoDefaultAll;
    procedure DoDownloadMintSystemFile(const strName: WideString);
    procedure DoDeviceClose;
    procedure DoDeviceOpen;
    procedure DoDeleteDataObjects;
    procedure DoDPREvent(nCode: Smallint);
    procedure DoDriveMacroDownload(const lpszFile: WideString);
    procedure GetBusCommandTelegram(nBus: Smallint; var pnRXControlWord: Integer; 
                                    var pnRXDataWord: Integer; var pfRXData: Single; 
                                    var pnTXControlWord: Integer; var pnTXDataWord: Integer; 
                                    var pfTXData: Single);
    procedure DoDriveMacroUpload(const sFilename: WideString);
    procedure DoEEPROMUpload(nDeviceID: Smallint; const sFilename: WideString);
    procedure DoDriveMacroSourceUpload(const lpszFile: WideString; nFlags: Integer);
    procedure mmSetPWMPolarity(nNodeId: Smallint; nPolarity: Smallint);
    procedure mmSetBiDirectionalMotor(nNodeId: Smallint; nMotor: Smallint; nDirection: Smallint; 
                                      nOnTime: Integer; bEnable: WordBool);
    procedure mmGetPWMPolarity(nNodeId: Smallint; var pnPolarity: Smallint);
    procedure mmGetPWMErrorTime(nNodeId: Smallint; var pnErrorTime: Integer);
    procedure mmSetPWMErrorTime(nNodeId: Smallint; nErrorTime: Integer);
    procedure mmSetPWMOnTime(nNodeId: Smallint; nChannel: Smallint; nOnTime: Integer);
    procedure VectorR(nNumberOfAxes: Smallint; nAxesArray: OleVariant; fPosArray: OleVariant);
    procedure debugGetBurnInParameter(nParam: Smallint; var pfValue: Single);
    procedure VectorA(nNumberOfAxes: Smallint; nAxesArray: OleVariant; fPosArray: OleVariant);
    procedure mmGetPWMPeriod(nNodeId: Smallint; var pnPeriod: Integer);
    procedure mmSetPWMPeriod(nNodeId: Smallint; nPeriod: Integer);
    procedure mmSetPWMErrors(nNodeId: Smallint; nErrors: Integer);
    procedure mmGetPWMMode(nNodeId: Smallint; var pnMode: Smallint);
    procedure mmSetPWMMode(nNodeId: Smallint; nMode: Smallint);
    procedure mmGetPWMOnTime(nNodeId: Smallint; nChannel: Smallint; var pnOnTime: Integer);
    procedure TransmitICMCommand(vFrontStruct: OleVariant; var pvInOut: OleVariant);
    procedure mmSetMotorPair(nNodeId: Smallint; nMotor: Smallint; nDirection: Smallint; 
                             nMotor1OnTime: Integer; nMotor2OnTime: Integer; bEnable: WordBool);
    procedure mmGetPWMErrors(nNodeId: Smallint; var pnErrors: Integer);
    procedure mmGetPWMEnable(nNodeId: Smallint; nChannel: Smallint; var pnEnable: Smallint);
    procedure mmGetPWMBraking(nNodeId: Smallint; var pnBraking: Smallint);
    procedure GetTriggerPoints(var pvTriggered: OleVariant; var pvXPos: OleVariant; 
                               var pvYPos: OleVariant);
    procedure debugSetBurnInParameter(nParam: Smallint; fValue: Single);
    procedure mmSetPWMEnable(nNodeId: Smallint; nChannel: Smallint; nEnable: Smallint);
    procedure mmSetPWMBraking(nNodeId: Smallint; nBraking: Smallint);
    procedure mmSetUniDirectionalMotor(nNodeId: Smallint; nMotor: Smallint; nDirection: Smallint; 
                                       nOnTime: Integer; bEnable: WordBool);
    procedure PrecisionTable(nAxisOrChannel: Smallint; fForwardArray: OleVariant; 
                             fReverseArray: OleVariant);
    procedure PresetCancel(nAxis: Smallint; nPreset: Smallint);
    procedure SetMappedDevice(nType: Smallint; nLocalChannel: Smallint; nBus: Smallint; 
                              nNode: Smallint; nRemoteChannel: Smallint);
    procedure HelixA(nXAxis: Smallint; nYAxis: Smallint; nZAxis: Smallint; fXCentre: Single; 
                     fYCentre: Single; fAngle: Single; fZPos: Single);
    procedure SetDriveUnitProductionData(const strCatalogNumber: WideString; 
                                         const strSerialNumber: WideString; 
                                         const strBuildDate: WideString; nRevCode: Smallint; 
                                         nBetaBuild: Smallint; nDemoUnit: Smallint);
    procedure DoMoveFiducial(nXAxis: Smallint; nYAxis: Smallint; nCountMoves: Smallint; 
                             vPosData: OleVariant; vWindowData: OleVariant; 
                             nOutputChannel: Smallint; nOutputBit0: Smallint; 
                             nOutputBit1: Smallint; nMinTime: Smallint; fFiducialSpeed: Single; 
                             nMode: Smallint; nPulseTime: Smallint; nDwellTime: Smallint);
    procedure GetMappedRemoteDevice(nType: Smallint; nLocalChannel: Smallint; var pnBus: Smallint; 
                                    var pnNode: Smallint; var pnRemoteNode: Smallint; 
                                    var pnRemoteChannel: Smallint);
    procedure GetMappedDevice(nType: Smallint; nLocalChannel: Smallint; var pnBus: Smallint; 
                              var pnNode: Smallint; var pnRemoteChannel: Smallint);
    procedure GetDriveMacroNonEmpty(lFlags: Integer; var pbNonEmpty: WordBool);
    procedure SetDriveUnitProductionDataOld(const strCatalogNumber: WideString; 
                                            const strSerialNumber: WideString; 
                                            const strBuildDate: WideString; 
                                            const strRepairDate: WideString);
    procedure GetFileSystemEntry(nIndex: Smallint; var pbstrName: WideString; var pnType: Smallint; 
                                 var plSize: Integer);
    procedure GetDriveUnitProductionDataOld(var strCatalogNumber: WideString; 
                                            var strSerialNumber: WideString; 
                                            var strBuildDate: WideString; 
                                            var strRepairDate: WideString);
    procedure GetDriveUnitProductionData(var strCatalogNumber: WideString; 
                                         var strSerialNumber: WideString; 
                                         var strBuildDate: WideString; var pnRevCode: Smallint; 
                                         var pnBetaBuild: Smallint; var pnDemoUnit: Smallint);
    procedure SetDCFSection(nBus: Smallint; nNode: Smallint);
    procedure SetMappedRemoteDevice(nType: Smallint; nLocalChannel: Smallint; nBus: Smallint; 
                                    nNode: Smallint; nRemoteNode: Smallint; nRemoteChannel: Smallint);
    procedure GetSymbolTableForController(bForceUpload: WordBool; var pBstrSymbolTable: WideString);
    procedure HelixR(nXAxis: Smallint; nYAxis: Smallint; nZAxis: Smallint; fXCentre: Single; 
                     fYCentre: Single; fAngle: Single; fZPos: Single);
    procedure GetHiperfaceInfo(nAxis: Smallint; var bstrSerialNumber: WideString; 
                               var bstrProgramVersion: WideString; var nType: Smallint; 
                               var lAbsCountsPerRev: Integer; var nCyclesPerRev: Smallint; 
                               var nNumTurns: Smallint);
    procedure SetMACAddress(nAddress1: Smallint; nAddress2: Smallint; nAddress3: Smallint; 
                            nAddress4: Smallint; nAddress5: Smallint; nAddress6: Smallint);
    procedure SetLongStop(nAxis: Smallint; fMax: Single; fMin: Single; nState: Smallint);
    procedure GetMACAddress(var pnAddress1: Smallint; var pnAddress2: Smallint; 
                            var pnAddress3: Smallint; var pnAddress4: Smallint; 
                            var pnAddress5: Smallint; var pnAddress6: Smallint);
    procedure GetListData(nListId: Smallint; nIndex: Smallint; var pbSupported: WordBool; 
                          var pbFloat: WordBool; var pnEnum: Smallint; var pnChMin: Smallint; 
                          var pnChMax: Smallint; var pnChType: Smallint; var psLabel: WideString);
    procedure GetFirmwareInfo(var pnReleaseCandidate: Smallint; var pnBuildOption: Smallint; 
                              var pbstrCustomer: WideString);
    procedure SetPCBProductionData(nPCB: Smallint; ucType: Smallint; ucArtworkRevision: Smallint; 
                                   ucFunctionalRevision: Smallint; ucManufacturer: Smallint; 
                                   unModState: Integer; const bstrSerialNumber: WideString; 
                                   const strPLD1Type: WideString; ucPLD1Revision: Smallint; 
                                   const strPLD2Type: WideString; ucPLD2Revision: Smallint);
    procedure GetPLCTask(nChannel: Smallint; var pbEnable: WordBool; var pnCondition1: Smallint; 
                         var pnParameter1: Smallint; var pnOperator: Smallint; 
                         var pnCondition2: Smallint; var pnParameter2: Smallint; 
                         var pnAction: Smallint; var pnActionParameter: Smallint);
    procedure GetPCBProductionData(nPCB: Smallint; var ucType: Smallint; 
                                   var ucArtworkRevision: Smallint; 
                                   var ucFunctionalRevision: Smallint; 
                                   var ucManufacturer: Smallint; var unModState: Integer; 
                                   var bstrSerialNumber: WideString; var bstrPLD1Type: WideString; 
                                   var ucPLD1Revision: Smallint; var bstrPLD2Type: WideString; 
                                   var ucPLD2Revision: Smallint);
    procedure GetSentinel(nChannel: Smallint; var pnSource: Smallint; var pnParameter: Smallint; 
                          var pnMode: Smallint; var pbAbsolute: WordBool; var pfValueLow: Single; 
                          var pfValueHigh: Single);
    procedure SetSentinel(nChannel: Smallint; nSource: Smallint; nParameter: Smallint; 
                          nMode: Smallint; bAbsolute: WordBool; fValueLow: Single; 
                          fValueHigh: Single);
    procedure GetPresetMoveData(nPreset: Smallint; nAccelFormat: Smallint; 
                                var pnPresetType: Smallint; var pnPresetSubType: Smallint; 
                                var pfPresetPosition: Single; var pfPresetSpeed: Single; 
                                var pfPresetAccel: Single; var pfPresetDecel: Single);
    procedure PresetJog(nAxis: Smallint; nPreset: Smallint; fSpeed: Single; fAccel: Single; 
                        fDecel: Single);
    procedure PresetMoveA(nAxis: Smallint; nPreset: Smallint; fMove: Single; fSpeed: Single; 
                          fAccel: Single; fDecel: Single);
    procedure PresetHome(nAxis: Smallint; nPreset: Smallint; nMode: Smallint; fSpeed: Single; 
                         fAccel: Single; fDecel: Single);
    procedure GetOptionCardProdInfo(nCard: Smallint; var pnType: Smallint; var pnVersion: Smallint; 
                                    var pbstrVersion1: WideString; 
                                    var pbstrSerialNumber1: WideString; 
                                    var pbstrVersion2: WideString; 
                                    var pbstrSerialNumber2: WideString; var pnAxes: Smallint);
    procedure SetOptionCardProdInfo(nCard: Smallint; nType: Smallint; nVersion: Smallint; 
                                    const bstrVersion1: WideString; 
                                    const bstrSerialNumber1: WideString; 
                                    const bstrVersion2: WideString; 
                                    const bstrSerialNumber2: WideString; nAxes: Smallint);
    procedure SetPLCTask(nChannel: Smallint; bEnable: WordBool; nCondition1: Smallint; 
                         nParameter1: Smallint; nOperator: Smallint; nCondition2: Smallint; 
                         nParameter2: Smallint; nAction: Smallint; nActionParameter: Smallint);
    procedure SplineSegment(nAxis: Smallint; nTable: Smallint; nStartSegment: Integer; 
                            fSegmentArray: OleVariant);
    procedure SetMultipleInterpolatedMoves(pfData: OleVariant);
    procedure PresetSpeedRef(nAxis: Smallint; nPreset: Smallint; fSpeed: Single; fAccel: Single; 
                             fDecel: Single);
    procedure PresetStop(nAxis: Smallint; nPreset: Smallint);
    procedure GetFileSystemDetails(var pnVersion: Smallint; var pnNumFiles: Smallint; 
                                   var plTotalSpace: Integer; var plUsedSpace: Integer);
    procedure GetErrorLogEntry(nIndex: Smallint; var pnAxis: Smallint; var pnType: Smallint; 
                               var pnCode: Integer; var pnSeconds: Integer; var pnTicks: Smallint);
    procedure GetErrorLogEntryRTC(nIndex: Smallint; var pnAxis: Smallint; var pnType: Smallint; 
                                  var plCode: Integer; var pDate: TDateTime);
    procedure PresetTorqueRef(nAxis: Smallint; nPreset: Smallint; fTorque: Single; fAccel: Single; 
                              fDecel: Single);
    procedure SplineTable(nAxis: Smallint; fPosArray: OleVariant; fVelArray: OleVariant; 
                          fLengthArray: OleVariant);
    procedure GetStaticInfo(nStaticHandle: Integer; var pnType: Smallint; var pnSize: Integer; 
                            var pnOffset: Integer; var pbstrTask: WideString; 
                            var pbstrVariable: WideString);
    procedure PresetPos(nAxis: Smallint; nPreset: Smallint; fPos: Single);
    procedure PresetMoveR(nAxis: Smallint; nPreset: Smallint; fMove: Single; fSpeed: Single; 
                          fAccel: Single; fDecel: Single);
    procedure PresetMoveSuspend(nAxis: Smallint; nPreset: Smallint);
    procedure SetNullLink;
    procedure SetOfflineDSPControllerLink(nType: Smallint; nVersion: Integer; nNode: Smallint; 
                                          nPort: Smallint; lBaudRate: Integer; bOpenPort: WordBool);
    procedure SetNextMoveE100Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                  bOpenPort: WordBool);
    procedure SetRouteToDCFLink(const lpszFilePath: WideString);
    procedure SetSC610Link(nNode: Smallint; nPort: Smallint; lBaudRate: Integer; bOpenPort: WordBool);
    procedure SetRouteFromDCFLink(const lpszFilePath: WideString);
    procedure SetFadalAmpLink(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                              bOpenPort: WordBool);
    procedure SetFlexDrive2Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                bOpenPort: WordBool);
    procedure SetH2USBLink(nNodeNumber: Smallint);
    procedure SetH2SerialLink(nNode: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                              bOpenPort: WordBool);
    procedure SetH2USBDeviceLink(const szDeviceLink: WideString);
    procedure SetFlexPlusDrive2Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                    bOpenPort: WordBool);
    procedure SetNextMoveSTLink(nNode: Smallint; nPort: Smallint; lBaudRate: Integer; 
                                bOpenPort: WordBool);
    procedure InstallKnifeEventHandler(bInstall: WordBool);
    procedure InstallFastInEventHandler(bInstall: WordBool);
    procedure InstallInputEventHandler(bInstall: WordBool);
    procedure InstallErrorEventHandler(bInstall: WordBool);
    procedure InstallLatchEventHandler(bInstall: WordBool);
    procedure InstallMoveBufferLowEventHandler(bInstall: WordBool);
    procedure SetNextMovePCI1Link(nNodeNumber: Smallint; nCardNumber: Smallint);
    procedure SetNextMoveESLink(nNode: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                bOpenPort: WordBool);
    procedure SetNextMoveESBLink(nNode: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                 bOpenPort: WordBool);
    procedure SetEuroFlexLink(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                              bOpenPort: WordBool);
    procedure SetNextMovePCIFastLink(nNodeNumber: Smallint; nCardNumber: Smallint);
    procedure SetNextMovePCI2FastLink(nNodeNumber: Smallint; nCardNumber: Smallint);
    procedure SetNextMoveBXLink(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                bOpenPort: WordBool);
    procedure SetMicroFlexLink(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                               bOpenPort: WordBool);
    procedure SetNextMoveBX2Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                 bOpenPort: WordBool);
    procedure SetMintDrive2Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                bOpenPort: WordBool);
    procedure SetMicroFlexE100Link(nNodeNumber: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                   bOpenPort: WordBool);
    procedure AboutBox;
    property  ControlInterface: _DMintControllerCtrl read GetControlInterface;
    property  DefaultInterface: _DMintControllerCtrl read GetControlInterface;
    property AccelSensorKInt[nAxis: Smallint]: Single read Get_AccelSensorKInt write Set_AccelSensorKInt;
    property AccelSensorKProp[nAxis: Smallint]: Single read Get_AccelSensorKProp write Set_AccelSensorKProp;
    property AccelScaleUnits[nAxis: Smallint]: WideString read Get_AccelScaleUnits write Set_AccelScaleUnits;
    property AccelSensorEnable[nAxis: Smallint]: WordBool read Get_AccelSensorEnable write Set_AccelSensorEnable;
    property ADCErrorMode[nAxis: Smallint]: Smallint read Get_ADCErrorMode write Set_ADCErrorMode;
    property ADCError[nAxis: Smallint]: Integer read Get_ADCError;
    property AccelSensorFilterFreq[nAxis: Smallint]: Single read Get_AccelSensorFilterFreq write Set_AccelSensorFilterFreq;
    property AccelSensorVelErrorFatal[nAxis: Smallint]: Single read Get_AccelSensorVelErrorFatal write Set_AccelSensorVelErrorFatal;
    property AccelSensorDelay[nAxis: Smallint]: Smallint read Get_AccelSensorDelay write Set_AccelSensorDelay;
    property AccelSensorScale[nAxis: Smallint]: Single read Get_AccelSensorScale write Set_AccelSensorScale;
    property AccelSensorVelError[nAxis: Smallint]: Single read Get_AccelSensorVelError;
    property AccelSensorOffset[nAxis: Smallint]: Single read Get_AccelSensorOffset write Set_AccelSensorOffset;
    property AccelSensorMode[nAxis: Smallint]: Smallint read Get_AccelSensorMode write Set_AccelSensorMode;
    property AccelSensorVel[nAxis: Smallint]: Single read Get_AccelSensorVel;
    property AccelSensorType[nAxis: Smallint]: Smallint read Get_AccelSensorType write Set_AccelSensorType;
    property ADCDeadbandOffset[nChannel: Smallint]: Single read Get_ADCDeadbandOffset write Set_ADCDeadbandOffset;
    property ADCDeadband[nChannel: Smallint]: Single read Get_ADCDeadband write Set_ADCDeadband;
    property ActiveEventCodes[nEvent: Smallint]: OleVariant read Get_ActiveEventCodes;
    property ADC[nChannel: Smallint]: Single read Get_ADC;
    property AccelTimeMax[nAxis: Smallint]: Integer read Get_AccelTimeMax write Set_AccelTimeMax;
    property ADCDeadbandHysteresis[nChannel: Smallint]: Single read Get_ADCDeadbandHysteresis write Set_ADCDeadbandHysteresis;
    property AccelSensorVelErrorMode[nAxis: Smallint]: Smallint read Get_AccelSensorVelErrorMode write Set_AccelSensorVelErrorMode;
    property ADCMax[nChannel: Smallint]: Single read Get_ADCMax write Set_ADCMax;
    property ADCGain[nChannel: Smallint]: Single read Get_ADCGain write Set_ADCGain;
    property ADCFilter[nChannel: Smallint]: Single read Get_ADCFilter write Set_ADCFilter;
    property AccelTime[nAxis: Smallint]: Integer read Get_AccelTime write Set_AccelTime;
    property RelayOut[nBank: Smallint]: Integer read Get_RelayOut write Set_RelayOut;
    property RelayOutX[nRelay: Smallint]: WordBool read Get_RelayOutX write Set_RelayOutX;
    property RemoteADC[nCANBus: Smallint; nNode: Smallint; nChannel: Smallint]: Single read Get_RemoteADC;
    property PWMOnTime[nAxis: Smallint]: Smallint read Get_PWMOnTime write Set_PWMOnTime;
    property ReadKey[nTermID: Integer]: Smallint read Get_ReadKey;
    property RemoteADCDelta[nCANBus: Smallint; nNode: Smallint; nChannel: Smallint]: Smallint read Get_RemoteADCDelta write Set_RemoteADCDelta;
    property RelayOutputBankSetup[nBank: Smallint]: Smallint read Get_RelayOutputBankSetup write Set_RelayOutputBankSetup;
    property AccelJerkTime[nAxis: Smallint]: Integer read Get_AccelJerkTime write Set_AccelJerkTime;
    property AccelJerk[nAxis: Smallint]: Single read Get_AccelJerk write Set_AccelJerk;
    property AccelScaleFactor[nAxis: Smallint]: Single read Get_AccelScaleFactor write Set_AccelScaleFactor;
    property AbortMode[nAxis: Smallint]: Smallint read Get_AbortMode write Set_AbortMode;
    property AbsEncoderSinOffset[nAxis: Smallint]: Smallint read Get_AbsEncoderSinOffset write Set_AbsEncoderSinOffset;
    property AbsEncoder[nAxis: Smallint]: Integer read Get_AbsEncoder;
    property AbsEncoderCosOffset[nAxis: Smallint]: Smallint read Get_AbsEncoderCosOffset write Set_AbsEncoderCosOffset;
    property AbsEncoderTurns[nChannel: Smallint]: Integer read Get_AbsEncoderTurns write Set_AbsEncoderTurns;
    property AccelDemand[nAxis: Smallint]: Single read Get_AccelDemand;
    property Accel[nAxis: Smallint]: Single read Get_Accel write Set_Accel;
    property PresetSelectorInput[nAxis: Smallint]: Smallint read Get_PresetSelectorInput write Set_PresetSelectorInput;
    property PresetTriggerInput[nAxis: Smallint]: Smallint read Get_PresetTriggerInput write Set_PresetTriggerInput;
    property ProfileMode[nAxis: Smallint]: Smallint read Get_ProfileMode write Set_ProfileMode;
    property PresetJogDirection[nPreset: Smallint]: Smallint read Get_PresetJogDirection write Set_PresetJogDirection;
    property PresetIndexSource[nAxis: Smallint]: Smallint read Get_PresetIndexSource write Set_PresetIndexSource;
    property PresetMoveParameter[nPreset: Smallint; nParam: Smallint]: Single read Get_PresetMoveParameter write Set_PresetMoveParameter;
    property PresetInputsMax[nAxis: Smallint]: Smallint read Get_PresetInputsMax write Set_PresetInputsMax;
    property PresetInputState[nAxis: Smallint]: Smallint read Get_PresetInputState;
    property PresetMoveType[nPreset: Smallint; nParam: Smallint]: Smallint read Get_PresetMoveType write Set_PresetMoveType;
    property RemoteStatus[nCANBus: Smallint; nNode: Smallint]: Smallint read Get_RemoteStatus write Set_RemoteStatus;
    property ResetInput[nAxis: Smallint]: Smallint read Get_ResetInput write Set_ResetInput;
    property RevCountDeadband[nAxis: Smallint]: Smallint read Get_RevCountDeadband write Set_RevCountDeadband;
    property ScaleFactor[nAxis: Smallint]: Single read Get_ScaleFactor write Set_ScaleFactor;
    property PresetMovePosition[nPreset: Smallint]: Single read Get_PresetMovePosition write Set_PresetMovePosition;
    property PresetMoveSpeed[nPreset: Smallint]: Single read Get_PresetMoveSpeed write Set_PresetMoveSpeed;
    property RemoteEncoder[nCANBus: Smallint; nNode: Smallint; nChannel: Smallint]: Integer read Get_RemoteEncoder write Set_RemoteEncoder;
    property RemoteError[nCANBus: Smallint; nNode: Smallint]: Smallint read Get_RemoteError;
    property RemoteDebounce[nCANBus: Smallint; nNode: Smallint]: Smallint read Get_RemoteDebounce write Set_RemoteDebounce;
    property RemoteComms[nBus: Smallint; nNode: Smallint; nIndex: Smallint]: Single read Get_RemoteComms write Set_RemoteComms;
    property RemoteDAC[nCANBus: Smallint; nNode: Smallint; nChannel: Smallint]: Single read Get_RemoteDAC write Set_RemoteDAC;
    property Relay[nBank: Smallint]: WordBool read Get_Relay write Set_Relay;
    property RemoteEmergencyMessage[nCANBus: Smallint; nNode: Smallint]: Smallint read Get_RemoteEmergencyMessage;
    property PresetMoveHomeType[nPreset: Smallint]: Smallint read Get_PresetMoveHomeType write Set_PresetMoveHomeType;
    property PresetJogSpeed[nPreset: Smallint]: Single read Get_PresetJogSpeed write Set_PresetJogSpeed;
    property PresetMoveEnable[nAxis: Smallint]: WordBool read Get_PresetMoveEnable write Set_PresetMoveEnable;
    property RemoteCommsInteger[nBus: Smallint; nNode: Smallint; nIndex: Smallint]: Integer read Get_RemoteCommsInteger write Set_RemoteCommsInteger;
    property RemoteBaud[nCANBus: Smallint]: Integer write Set_RemoteBaud;
    property PulseOutX[nChannel: Smallint]: Integer write Set_PulseOutX;
    property ADCMode[nChannel: Smallint]: Smallint read Get_ADCMode write Set_ADCMode;
    property ADCMin[nChannel: Smallint]: Single read Get_ADCMin write Set_ADCMin;
    property AnalogOutputSetup[nChannel: Smallint]: Smallint read Get_AnalogOutputSetup write Set_AnalogOutputSetup;
    property ADCMonitor[nAxis: Smallint]: Integer read Get_ADCMonitor write Set_ADCMonitor;
    property ADCTimeConstant[nChannel: Smallint]: Single read Get_ADCTimeConstant write Set_ADCTimeConstant;
    property ADCOffset[nChannel: Smallint]: Single read Get_ADCOffset write Set_ADCOffset;
    property AnalogInputSetup[nChannel: Smallint]: Smallint read Get_AnalogInputSetup write Set_AnalogInputSetup;
    property AutoStartMode[nAxis: Smallint]: Smallint read Get_AutoStartMode write Set_AutoStartMode;
    property AutoHomeMode[nAxis: Smallint]: Smallint read Get_AutoHomeMode write Set_AutoHomeMode;
    property APIValue[nTable: Smallint; nFamily: Smallint; nIndex: Smallint; vArgs: OleVariant]: OleVariant read Get_APIValue write Set_APIValue;
    property AuxDAC[nChannel: Smallint]: Single read Get_AuxDAC write Set_AuxDAC;
    property AutotuneParam[nParam: Smallint]: Single read Get_AutotuneParam write Set_AutotuneParam;
    property APIArgumentValues[nTable: Smallint; nArgument: Smallint]: OleVariant read Get_APIArgumentValues;
    property AuxDACMode[nChannel: Smallint]: Smallint read Get_AuxDACMode write Set_AuxDACMode;
    property AuxEncoderMode[nAuxChannel: Smallint]: Smallint read Get_AuxEncoderMode write Set_AuxEncoderMode;
    property AuxEncoderScale[nAuxChannel: Smallint]: Single read Get_AuxEncoderScale write Set_AuxEncoderScale;
    property AuxEncoder[nAuxChannel: Smallint]: Single read Get_AuxEncoder write Set_AuxEncoder;
    property AuxEncoderPreScale[nAuxChannel: Smallint]: Integer read Get_AuxEncoderPreScale write Set_AuxEncoderPreScale;
    property AuxEncoderSpeed[nAuxChannel: Smallint]: Single read Get_AuxEncoderSpeed write Set_AuxEncoderSpeed;
    property AuxEncoderVel[nAuxChannel: Smallint]: Single read Get_AuxEncoderVel;
    property AuxEncoderWrap[nAuxChannel: Smallint]: Single read Get_AuxEncoderWrap write Set_AuxEncoderWrap;
    property AuxEncoderZeroLatchMode[nAuxChannel: Smallint]: Smallint read Get_AuxEncoderZeroLatchMode write Set_AuxEncoderZeroLatchMode;
    property AuxEncoderZeroEnable[nAuxChannel: Smallint]: WordBool write Set_AuxEncoderZeroEnable;
    property AuxEncoderZeroPosition[nAuxChannel: Smallint]: Single read Get_AuxEncoderZeroPosition;
    property AuxEncoderZLatch[nAuxChannel: Smallint]: WordBool read Get_AuxEncoderZLatch;
    property AxisADC[nAxis: Smallint]: Smallint read Get_AxisADC write Set_AxisADC;
    property AverageVel[nAxis: Smallint]: Single read Get_AverageVel;
    property AbsEncoderOffset[nAxis: Smallint]: Integer read Get_AbsEncoderOffset write Set_AbsEncoderOffset;
    property AbsEncoderSinGain[nAxis: Smallint]: Smallint read Get_AbsEncoderSinGain write Set_AbsEncoderSinGain;
    property AxisPosEncoder[nAxis: Smallint]: Smallint read Get_AxisPosEncoder write Set_AxisPosEncoder;
    property AxisSyncDelay[nAxis: Smallint]: Integer read Get_AxisSyncDelay write Set_AxisSyncDelay;
    property AxisWarning[nAxis: Smallint]: Integer read Get_AxisWarning write Set_AxisWarning;
    property AxisStatus[nAxis: Smallint]: Integer read Get_AxisStatus;
    property AxisVelEncoder[nAxis: Smallint]: Smallint read Get_AxisVelEncoder write Set_AxisVelEncoder;
    property AxisPDOutput[nAxis: Smallint]: Smallint read Get_AxisPDOutput write Set_AxisPDOutput;
    property AxisDAC[nAxis: Smallint]: Smallint read Get_AxisDAC write Set_AxisDAC;
    property AxisWarningDisable[nAxis: Smallint]: Integer read Get_AxisWarningDisable write Set_AxisWarningDisable;
    property AxisStatusWord[nAxis: Smallint]: Smallint read Get_AxisStatusWord;
    property Cam[nAxis: Smallint]: Smallint read Get_Cam write Set_Cam;
    property CamAmplitude[nAxis: Smallint]: Single read Get_CamAmplitude write Set_CamAmplitude;
    property CamEnd[nAxis: Smallint]: Integer read Get_CamEnd write Set_CamEnd;
    property CamBox[nCamBox: Smallint]: Smallint read Get_CamBox write Set_CamBox;
    property CamIndex[nAxis: Smallint]: Integer read Get_CamIndex;
    property BusBaud[nBusID: Smallint]: Integer read Get_BusBaud write Set_BusBaud;
    property CamStart[nAxis: Smallint]: Integer read Get_CamStart write Set_CamStart;
    property CamPhaseStatus[nAxis: Smallint]: Smallint read Get_CamPhaseStatus;
    property AxisError[nAxis: Smallint]: Integer read Get_AxisError write Set_AxisError;
    property BurnInParameter[nParam: Smallint]: Single read Get_BurnInParameter write Set_BurnInParameter;
    property BridgeCompEnable[nAxis: Smallint]: WordBool read Get_BridgeCompEnable write Set_BridgeCompEnable;
    property BridgeErrorVoltage[nAxis: Smallint]: Single read Get_BridgeErrorVoltage write Set_BridgeErrorVoltage;
    property BacklashInterval[nAxis: Smallint]: Smallint read Get_BacklashInterval write Set_BacklashInterval;
    property BacklashMode[nAxis: Smallint]: Smallint read Get_BacklashMode write Set_BacklashMode;
    property BufferDepth[nBuffer: Smallint; nParam: Smallint]: Integer read Get_BufferDepth write Set_BufferDepth;
    property Boost[nAxis: Smallint]: WordBool read Get_Boost write Set_Boost;
    property BridgeErrorCurrent[nAxis: Smallint]: Single read Get_BridgeErrorCurrent write Set_BridgeErrorCurrent;
    property AxisNode[nAxis: Smallint]: Smallint read Get_AxisNode;
    property AxisChannel[nAxis: Smallint]: Smallint read Get_AxisChannel write Set_AxisChannel;
    property AxisMode[nAxis: Smallint]: Integer read Get_AxisMode;
    property AxisErrorLogMask[nAxis: Smallint]: Integer read Get_AxisErrorLogMask write Set_AxisErrorLogMask;
    property BusProcessDataInterval[nBusID: Smallint]: Smallint read Get_BusProcessDataInterval write Set_BusProcessDataInterval;
    property BusProcessData[nBus: Smallint; bIn: WordBool; nChannel: Smallint]: Smallint read Get_BusProcessData write Set_BusProcessData;
    property BusPDOMapContent[nBus: Smallint; nNode: Smallint; bIn: WordBool; nPeerNode: Smallint; 
                              nSlot: Smallint]: OleVariant read Get_BusPDOMapContent write Set_BusPDOMapContent;
    property DriveSpeedFatal[nAxis: Smallint]: Single read Get_DriveSpeedFatal write Set_DriveSpeedFatal;
    property DriveSpeedMax[nAxis: Smallint]: Single read Get_DriveSpeedMax write Set_DriveSpeedMax;
    property BusTelegramDiagnosticStrings[nBusID: Smallint]: OleVariant read Get_BusTelegramDiagnosticStrings;
    property BusState[nBusID: Smallint]: Smallint read Get_BusState;
    property BusProcessDataParameter[nBus: Smallint; bIn: WordBool; nChannel: Smallint]: Smallint read Get_BusProcessDataParameter write Set_BusProcessDataParameter;
    property BusTelegramDiagnostics[nBusID: Smallint]: OleVariant read Get_BusTelegramDiagnostics;
    property DriveSpeedMaxRPM[nAxis: Smallint]: Smallint read Get_DriveSpeedMaxRPM write Set_DriveSpeedMaxRPM;
    property DriveRatingZone[nAxis: Smallint]: Smallint read Get_DriveRatingZone write Set_DriveRatingZone;
    property DriveRatingZoneInfo[nAxis: Smallint; nZone: Smallint; nParam: Smallint]: Single read Get_DriveRatingZoneInfo;
    property EEPROMData[nAddress: Smallint]: Smallint read Get_EEPROMData write Set_EEPROMData;
    property DriveUnderloadWarning[nAxis: Smallint]: Single read Get_DriveUnderloadWarning write Set_DriveUnderloadWarning;
    property DriveVolts[nAxis: Smallint]: Single read Get_DriveVolts;
    property DriveSpeedMaxmmps[nAxis: Smallint]: Single read Get_DriveSpeedMaxmmps write Set_DriveSpeedMaxmmps;
    property DriveRatedCurrent[nAxis: Smallint]: Single read Get_DriveRatedCurrent;
    property DriveRatedHorsePower[nAxis: Smallint]: Single read Get_DriveRatedHorsePower;
    property BusProtocol[nBus: Smallint]: Smallint read Get_BusProtocol;
    property CANBaud[nCANBus: Smallint]: Integer read Get_CANBaud write Set_CANBaud;
    property CANBusState[nCANBus: Smallint]: Smallint read Get_CANBusState;
    property CaptureAxis[nChannel: Smallint]: Smallint read Get_CaptureAxis write Set_CaptureAxis;
    property CANEventInfo[nCANBus: Smallint]: Smallint read Get_CANEventInfo;
    property CANEvent[nCANBus: Smallint]: Smallint read Get_CANEvent;
    property CaptureHSMode[nChannel: Smallint]: Smallint read Get_CaptureHSMode write Set_CaptureHSMode;
    property CaptureMode[nChannel: Smallint]: Smallint read Get_CaptureMode write Set_CaptureMode;
    property CaptureModeParameter[nAxis: Smallint]: Smallint read Get_CaptureModeParameter write Set_CaptureModeParameter;
    property BusCommandMask[nFieldbus: Smallint]: Smallint read Get_BusCommandMask write Set_BusCommandMask;
    property BusBaudsSupported[nBus: Smallint]: OleVariant read Get_BusBaudsSupported;
    property BusCycleRate[nBus: Smallint]: Smallint read Get_BusCycleRate write Set_BusCycleRate;
    property BusMessageMode[nBus: Smallint]: Smallint read Get_BusMessageMode write Set_BusMessageMode;
    property BusEventInfo[nBusID: Smallint]: Smallint read Get_BusEventInfo;
    property BusEvent[nBusID: Smallint]: Smallint read Get_BusEvent;
    property BusNode[nBus: Smallint]: Smallint read Get_BusNode write Set_BusNode;
    property Backlash[nAxis: Smallint]: Single read Get_Backlash write Set_Backlash;
    property CaptureProgress[bPostTrigger: WordBool]: Smallint read Get_CaptureProgress;
    property CaptureTriggerAbsolute[nTrigger: Smallint]: WordBool read Get_CaptureTriggerAbsolute write Set_CaptureTriggerAbsolute;
    property CapturePoint[nChannel: Smallint; nIndex: Smallint]: Single read Get_CapturePoint;
    property CommandRefSource[nAxis: Smallint]: Smallint read Get_CommandRefSource write Set_CommandRefSource;
    property CommandRefSourceParameter[nAxis: Smallint]: Smallint read Get_CommandRefSourceParameter write Set_CommandRefSourceParameter;
    property CaptureTriggerSource[nTrigger: Smallint]: Smallint read Get_CaptureTriggerSource write Set_CaptureTriggerSource;
    property CaptureTriggerMode[nTrigger: Smallint]: Smallint read Get_CaptureTriggerMode write Set_CaptureTriggerMode;
    property CaptureModeName[nChannel: Smallint]: WideString read Get_CaptureModeName;
    property CompareMode[nAxis: Smallint]: Smallint read Get_CompareMode write Set_CompareMode;
    property Coil[nCoil: Smallint]: WordBool read Get_Coil write Set_Coil;
    property CurrentLimit[nAxis: Smallint]: Single read Get_CurrentLimit write Set_CurrentLimit;
    property ControlRefSourceStartup[nAxis: Smallint]: Smallint read Get_ControlRefSourceStartup write Set_ControlRefSourceStartup;
    property CurrentDemand[nAxis: Smallint; nChannel: Smallint]: Single read Get_CurrentDemand;
    property Commissioned[nAxis: Smallint]: WordBool read Get_Commissioned write Set_Commissioned;
    property ChannelType[nChannel: Smallint]: Smallint read Get_ChannelType;
    property CaptureTriggerValue[nTrigger: Smallint]: Single read Get_CaptureTriggerValue write Set_CaptureTriggerValue;
    property CaptureTriggerChannel[nTrigger: Smallint]: Smallint read Get_CaptureTriggerChannel write Set_CaptureTriggerChannel;
    property CommsInteger[nIndex: Smallint]: Integer read Get_CommsInteger write Set_CommsInteger;
    property Comms[nIndex: Smallint]: Single read Get_Comms write Set_Comms;
    property CommsControllerData[nEnum: Smallint; nParam: Smallint]: OleVariant read Get_CommsControllerData;
    property CommsMultiple[nIndex: Smallint; nCount: Smallint]: OleVariant read Get_CommsMultiple write Set_CommsMultiple;
    property CommsMapDataType[nAxis: Smallint]: Smallint read Get_CommsMapDataType write Set_CommsMapDataType;
    property CommsMapParameter[nIndex: Smallint]: Smallint read Get_CommsMapParameter write Set_CommsMapParameter;
    property CommsMapMode[nIndex: Smallint]: Smallint read Get_CommsMapMode write Set_CommsMapMode;
    property CompareEnable[nOutput: Smallint]: WordBool read Get_CompareEnable write Set_CompareEnable;
    property CommsTestParameter[nParameter: Smallint]: Single read Get_CommsTestParameter write Set_CommsTestParameter;
    property CommsRemote[nNode: Smallint; nIndex: Smallint]: Single read Get_CommsRemote write Set_CommsRemote;
    property CommsMultipleRemote[nNode: Smallint; nIndex: Smallint; nCount: Smallint]: OleVariant read Get_CommsMultipleRemote write Set_CommsMultipleRemote;
    property CompareLatch[nAxis: Smallint]: Smallint read Get_CompareLatch write Set_CompareLatch;
    property ControllerData[nEnum: Smallint; nParam: Smallint]: OleVariant read Get_ControllerData;
    property ControlMode[nAxis: Smallint]: Smallint read Get_ControlMode write Set_ControlMode;
    property ContourAngle[nAxis: Smallint]: Single read Get_ContourAngle write Set_ContourAngle;
    property ControlModeStartup[nAxis: Smallint]: Smallint read Get_ControlModeStartup write Set_ControlModeStartup;
    property CompareOutput[nAxis: Smallint]: Smallint read Get_CompareOutput write Set_CompareOutput;
    property Config[nAxis: Smallint]: Smallint read Get_Config write Set_Config;
    property ComparePos[nAxis: Smallint; nRegister: Smallint]: Single read Get_ComparePos write Set_ComparePos;
    property ContourRatio[nAxis1: Smallint; nAxis2: Smallint]: Single read Get_ContourRatio write Set_ContourRatio;
    property BlendMode[nAxis: Smallint]: Smallint read Get_BlendMode write Set_BlendMode;
    property BlendDistance[nAxis: Smallint]: Single read Get_BlendDistance write Set_BlendDistance;
    property ContourParameter[nAxis: Smallint; nParam: Smallint]: Single read Get_ContourParameter write Set_ContourParameter;
    property ContourMode[nAxis: Smallint]: Smallint read Get_ContourMode write Set_ContourMode;
    property ConnectStatus[nCANBus: Smallint; nFromNode: Smallint]: Smallint read Get_ConnectStatus;
    property DAC[nChannel: Smallint]: Single read Get_DAC write Set_DAC;
    property ControlRefSource[nAxis: Smallint]: Smallint read Get_ControlRefSource write Set_ControlRefSource;
    property DACMonitorAxis[nChannel: Smallint]: Smallint read Get_DACMonitorAxis write Set_DACMonitorAxis;
    property DACMonitorAbsolute[nChannel: Smallint]: Smallint read Get_DACMonitorAbsolute write Set_DACMonitorAbsolute;
    property CurrentMeas[nAxis: Smallint; nChannel: Smallint]: Single read Get_CurrentMeas;
    property ControlRefChannel[nAxis: Smallint]: Smallint read Get_ControlRefChannel write Set_ControlRefChannel;
    property ControlRate[nAxis: Smallint; nChannel: Smallint]: Integer read Get_ControlRate write Set_ControlRate;
    property DACMonitorGain[nChannel: Smallint]: Single read Get_DACMonitorGain write Set_DACMonitorGain;
    property Connect[nCANBus: Smallint; nFromNode: Smallint; nToNode: Smallint]: Smallint read Get_Connect write Set_Connect;
    property DACMode[nChannel: Smallint]: Smallint read Get_DACMode write Set_DACMode;
    property ConnectInfo[nBus: Smallint; nFromNode: Smallint]: OleVariant read Get_ConnectInfo;
    property DACLimitMax[nChannel: Smallint]: Single read Get_DACLimitMax write Set_DACLimitMax;
    property Effort[nAxis: Smallint]: Single read Get_Effort;
    property DriveData[nTransaction: Smallint]: Smallint read Get_DriveData write Set_DriveData;
    property DriveEnable[nAxis: Smallint]: WordBool read Get_DriveEnable write Set_DriveEnable;
    property DriveFault[nAxis: Smallint]: Smallint read Get_DriveFault;
    property DriveFeedbackSource[nAxis: Smallint]: Smallint read Get_DriveFeedbackSource write Set_DriveFeedbackSource;
    property DriveEnableOutput[nAxis: Smallint]: Smallint read Get_DriveEnableOutput write Set_DriveEnableOutput;
    property DriveEnableMode[nAxis: Smallint]: Smallint read Get_DriveEnableMode write Set_DriveEnableMode;
    property DriveBusUnderVolts[nAxis: Smallint]: Smallint read Get_DriveBusUnderVolts write Set_DriveBusUnderVolts;
    property DriveBusVolts[nAxis: Smallint]: Single read Get_DriveBusVolts;
    property DriveErrorLogMask[nAxis: Smallint]: Integer read Get_DriveErrorLogMask write Set_DriveErrorLogMask;
    property DiagnosticString[nChannel: Smallint]: WideString read Get_DiagnosticString write Set_DiagnosticString;
    property DiagnosticParameter[nGroup: Smallint; nParameter: Smallint]: Single read Get_DiagnosticParameter write Set_DiagnosticParameter;
    property DriveErrorString[nErrorCode: Smallint]: WideString read Get_DriveErrorString;
    property DriveOkOutput[nAxis: Smallint]: Smallint read Get_DriveOkOutput write Set_DriveOkOutput;
    property DriveError[nAxis: Smallint]: Smallint read Get_DriveError write Set_DriveError;
    property DriveEnableSwitch[nAxis: Smallint]: WordBool read Get_DriveEnableSwitch;
    property DriveEnableInputMode[nAxis: Smallint]: Smallint read Get_DriveEnableInputMode write Set_DriveEnableInputMode;
    property DACMonitorModeParameter[nChannel: Smallint]: Smallint read Get_DACMonitorModeParameter write Set_DACMonitorModeParameter;
    property DACMonitorMode[nChannel: Smallint]: Smallint read Get_DACMonitorMode write Set_DACMonitorMode;
    property DACRamp[nChannel: Smallint]: Integer read Get_DACRamp write Set_DACRamp;
    property DACMonitorOffset[nChannel: Smallint]: Single read Get_DACMonitorOffset write Set_DACMonitorOffset;
    property DACOffset[nChannel: Smallint]: Single read Get_DACOffset write Set_DACOffset;
    property DACMonitorScale[nChannel: Smallint]: Single read Get_DACMonitorScale write Set_DACMonitorScale;
    property DBExtAvgPower[nAxis: Smallint]: Single read Get_DBExtAvgPower write Set_DBExtAvgPower;
    property DBEnable[nAxis: Smallint]: WordBool read Get_DBEnable write Set_DBEnable;
    property DBDelay[nAxis: Smallint; nChannel: Smallint]: Single read Get_DBDelay write Set_DBDelay;
    property DBConfig[nAxis: Smallint]: Smallint read Get_DBConfig write Set_DBConfig;
    property DecelTime[nAxis: Smallint]: Integer read Get_DecelTime write Set_DecelTime;
    property DBExtPeakPower[nAxis: Smallint]: Single read Get_DBExtPeakPower write Set_DBExtPeakPower;
    property DBExtPeakDuration[nAxis: Smallint]: Single read Get_DBExtPeakDuration write Set_DBExtPeakDuration;
    property DigitalInputBankSetup[nBank: Smallint]: Smallint read Get_DigitalInputBankSetup write Set_DigitalInputBankSetup;
    property DiagnosticIndexedParameter[nGroup: Smallint; nCaptureIndex: Smallint; 
                                        nGDIPIndex: Smallint]: Single read Get_DiagnosticIndexedParameter write Set_DiagnosticIndexedParameter;
    property DriveBusOverVolts[nAxis: Smallint]: Smallint read Get_DriveBusOverVolts write Set_DriveBusOverVolts;
    property DriveBusNominalVolts[nAxis: Smallint]: Smallint read Get_DriveBusNominalVolts;
    property DiagnosticIndexedString[nChannel: Smallint; nIndex: Smallint]: WideString read Get_DiagnosticIndexedString;
    property DecelTimeMax[nAxis: Smallint]: Integer read Get_DecelTimeMax write Set_DecelTimeMax;
    property DriveBusTConst[nAxis: Smallint]: Single read Get_DriveBusTConst write Set_DriveBusTConst;
    property AxisBus[nAxis: Smallint]: Smallint read Get_AxisBus;
    property DPRFloat[nAddress: Smallint]: Single read Get_DPRFloat write Set_DPRFloat;
    property DigitalOutputBankSetup[nBank: Smallint]: Smallint read Get_DigitalOutputBankSetup write Set_DigitalOutputBankSetup;
    property DPRLong[nAddress: Smallint]: Integer read Get_DPRLong write Set_DPRLong;
    property EncoderVel[nChannel: Smallint]: Single read Get_EncoderVel;
    property EncoderType[nChannel: Smallint]: Smallint read Get_EncoderType write Set_EncoderType;
    property EncoderTestMode[nChannel: Smallint]: Integer read Get_EncoderTestMode write Set_EncoderTestMode;
    property EncoderWrap[nChannel: Smallint]: Single read Get_EncoderWrap write Set_EncoderWrap;
    property DriveParameter[nTable: Smallint; nParameter: Smallint]: OleVariant read Get_DriveParameter write Set_DriveParameter;
    property DriveOverloadWarning[nAxis: Smallint]: Single read Get_DriveOverloadWarning write Set_DriveOverloadWarning;
    property EnableSwitch[nAxis: Smallint]: WordBool read Get_EnableSwitch;
    property DriveParameterFloat[nTable: Smallint; nParameter: Smallint]: Single read Get_DriveParameterFloat write Set_DriveParameterFloat;
    property EncoderSetup[nChannel: Smallint]: Smallint read Get_EncoderSetup write Set_EncoderSetup;
    property ErrorMask[nAxis: Smallint]: Integer read Get_ErrorMask write Set_ErrorMask;
    property ErrorList[nGroup: Smallint; nData: Integer]: OleVariant read Get_ErrorList;
    property ErrorInputMode[nAxis: Smallint]: Smallint read Get_ErrorInputMode write Set_ErrorInputMode;
    property ErrorBitmapStrings[nType: Smallint]: OleVariant read Get_ErrorBitmapStrings;
    property ErrorInput[nAxis: Smallint]: Smallint read Get_ErrorInput write Set_ErrorInput;
    property ErrorLogString[nType: Smallint; nErrorCode: Integer]: WideString read Get_ErrorLogString;
    property EncoderScale[nChannel: Smallint]: Single read Get_EncoderScale write Set_EncoderScale;
    property EncoderZLatch[nChannel: Smallint]: WordBool read Get_EncoderZLatch;
    property EncoderStatus[nChannel: Smallint]: Smallint read Get_EncoderStatus;
    property DriveParameterInteger[nTable: Smallint; nParameter: Smallint]: Integer read Get_DriveParameterInteger write Set_DriveParameterInteger;
    property DriveOverloadGain[nAxis: Smallint]: Single read Get_DriveOverloadGain write Set_DriveOverloadGain;
    property DrivePWMMode[nAxis: Smallint]: Smallint read Get_DrivePWMMode write Set_DrivePWMMode;
    property DriveTestParameter[nParam: Smallint]: Single read Get_DriveTestParameter write Set_DriveTestParameter;
    property DriveOverloadMode[nAxis: Smallint]: Smallint read Get_DriveOverloadMode write Set_DriveOverloadMode;
    property DriveOverloadFatal[nAxis: Smallint]: Single read Get_DriveOverloadFatal write Set_DriveOverloadFatal;
    property DriveSpeedMin[nAxis: Smallint]: Single read Get_DriveSpeedMin write Set_DriveSpeedMin;
    property DrivePeakCurrent[nAxis: Smallint]: Single read Get_DrivePeakCurrent;
    property DrivePWMFreq[nAxis: Smallint]: Single read Get_DrivePWMFreq;
    property DrivePeakDuration[nAxis: Smallint]: Single read Get_DrivePeakDuration;
    property DriveOperatingMode[nAxis: Smallint]: Smallint read Get_DriveOperatingMode write Set_DriveOperatingMode;
    property DriveOperatingZone[nAxis: Smallint]: Smallint read Get_DriveOperatingZone write Set_DriveOperatingZone;
    property DriveOverloadArea[nAxis: Smallint]: Single read Get_DriveOverloadArea;
    property DBExtR[nAxis: Smallint]: Single read Get_DBExtR write Set_DBExtR;
    property DBExtTripInput[nAxis: Smallint]: Smallint read Get_DBExtTripInput write Set_DBExtTripInput;
    property DBMode[nAxis: Smallint]: Smallint read Get_DBMode write Set_DBMode;
    property DBExtThermalTimeConst[nAxis: Smallint]: Single read Get_DBExtThermalTimeConst write Set_DBExtThermalTimeConst;
    property DBFreq[nAxis: Smallint]: Single read Get_DBFreq write Set_DBFreq;
    property EncoderOutChannel[nChannel: Smallint]: Smallint read Get_EncoderOutChannel write Set_EncoderOutChannel;
    property DBOverloadMode[nAxis: Smallint]: Smallint read Get_DBOverloadMode write Set_DBOverloadMode;
    property DBSwitchingVolts[nAxis: Smallint]: Single read Get_DBSwitchingVolts write Set_DBSwitchingVolts;
    property Decel[nAxis: Smallint]: Single read Get_Decel write Set_Decel;
    property DBVoltsLimit[nAxis: Smallint]: Single read Get_DBVoltsLimit write Set_DBVoltsLimit;
    property DBVolts[nAxis: Smallint]: Smallint read Get_DBVolts;
    property DecelJerk[nAxis: Smallint]: Single read Get_DecelJerk write Set_DecelJerk;
    property DecelJerkTime[nAxis: Smallint]: Integer read Get_DecelJerkTime write Set_DecelJerkTime;
    property EncoderMode[nChannel: Smallint]: Smallint read Get_EncoderMode write Set_EncoderMode;
    property EncoderLinesIn[nAxis: Smallint]: Integer read Get_EncoderLinesIn write Set_EncoderLinesIn;
    property EncoderFilterType[nEncoderChannel: Smallint]: Smallint read Get_EncoderFilterType write Set_EncoderFilterType;
    property EncoderFilterDepth[nEncoderChannel: Smallint]: Smallint read Get_EncoderFilterDepth write Set_EncoderFilterDepth;
    property Encoder[nChannel: Smallint]: Single read Get_Encoder write Set_Encoder;
    property ErrorDecel[nAxis: Smallint]: Single read Get_ErrorDecel write Set_ErrorDecel;
    property ErrData[nIndex: Smallint]: Integer read Get_ErrData;
    property EncoderResolution[nChannel: Smallint]: Integer read Get_EncoderResolution write Set_EncoderResolution;
    property EncoderPreScale[nChannel: Smallint]: Integer read Get_EncoderPreScale write Set_EncoderPreScale;
    property EncoderLinesOut[nAxis: Smallint]: Integer read Get_EncoderLinesOut write Set_EncoderLinesOut;
    property EncoderOutResolution[nChannel: Smallint]: Integer read Get_EncoderOutResolution write Set_EncoderOutResolution;
    property EncoderCycleSize[nAxis: Smallint]: Integer read Get_EncoderCycleSize write Set_EncoderCycleSize;
    property EncoderCount[nAxis: Smallint]: Smallint read Get_EncoderCount;
    property HomeBackoff[nAxis: Smallint]: Single read Get_HomeBackoff write Set_HomeBackoff;
    property HomeCreepSpeed[nAxis: Smallint]: Single read Get_HomeCreepSpeed write Set_HomeCreepSpeed;
    property HomeDecel[nAxis: Smallint]: Single read Get_HomeDecel write Set_HomeDecel;
    property FastAuxLatchEdge[nAxis: Smallint]: WordBool read Get_FastAuxLatchEdge write Set_FastAuxLatchEdge;
    property FastAuxLatchMode[nAxis: Smallint]: Smallint read Get_FastAuxLatchMode write Set_FastAuxLatchMode;
    property FastAuxSelect[nAxis: Smallint]: Smallint read Get_FastAuxSelect write Set_FastAuxSelect;
    property FastEnable[nAxis: Smallint]: Smallint write Set_FastEnable;
    property HomeAccel[nAxis: Smallint]: Single read Get_HomeAccel write Set_HomeAccel;
    property HomeSpeed[nAxis: Smallint]: Single read Get_HomeSpeed write Set_HomeSpeed;
    property HomeInput[nAxis: Smallint]: Smallint read Get_HomeInput write Set_HomeInput;
    property HomeStatus[nAxis: Smallint]: WordBool read Get_HomeStatus write Set_HomeStatus;
    property HomeSwitch[nAxis: Smallint]: WordBool read Get_HomeSwitch;
    property HomeSources[nAxis: Smallint]: Smallint read Get_HomeSources;
    property HoldingRegister[nRegister: Integer]: Integer read Get_HoldingRegister write Set_HoldingRegister;
    property HoldSwitch[nAxis: Smallint]: Smallint read Get_HoldSwitch;
    property Home[nAxis: Smallint]: Smallint read Get_Home write Set_Home;
    property FastEncoder[nAxis: Smallint]: Single read Get_FastEncoder;
    property FastAuxLatchDistance[nAxis: Smallint]: Single read Get_FastAuxLatchDistance write Set_FastAuxLatchDistance;
    property ErrorSwitch[nAxis: Smallint]: WordBool read Get_ErrorSwitch;
    property FastAuxEnable[nAxis: Smallint]: Smallint write Set_FastAuxEnable;
    property ErrorString[nErrorCode: Integer]: WideString read Get_ErrorString;
    property FastAuxLatch[nAxis: Smallint]: WordBool read Get_FastAuxLatch;
    property FolErrorWarning[nAxis: Smallint]: Single read Get_FolErrorWarning write Set_FolErrorWarning;
    property FolErrorFatal[nAxis: Smallint]: Single read Get_FolErrorFatal write Set_FolErrorFatal;
    property FastAuxEncoder[nAxis: Smallint]: Single read Get_FastAuxEncoder;
    property FastLatchMode[nAxis: Smallint]: Smallint read Get_FastLatchMode write Set_FastLatchMode;
    property FolErrorMode[nAxis: Smallint]: Smallint read Get_FolErrorMode write Set_FolErrorMode;
    property ErrorMaskCode[nCode: Integer; nData: Integer]: WordBool read Get_ErrorMaskCode write Set_ErrorMaskCode;
    property FastLatch[nAxis: Smallint]: WordBool read Get_FastLatch;
    property FastLatchDistance[nAxis: Smallint]: Single read Get_FastLatchDistance write Set_FastLatchDistance;
    property FastLatchEdge[nAxis: Smallint]: WordBool read Get_FastLatchEdge write Set_FastLatchEdge;
    property ErrorReadNext[nGroup: Smallint; nData: Integer]: WordBool read Get_ErrorReadNext;
    property ErrorPresent[nGroup: Smallint; nData: Integer]: WordBool read Get_ErrorPresent;
    property ErrorReadCode[nGroup: Smallint; nData: Integer]: WordBool read Get_ErrorReadCode;
    property GroupMaster[nCANBus: Smallint; nGroup: Smallint]: Smallint read Get_GroupMaster write Set_GroupMaster;
    property GroupMasterStatus[nCANBus: Smallint; nGroup: Smallint]: Smallint read Get_GroupMasterStatus;
    property Group[nCANBus: Smallint; nGroup: Smallint; nNodeId: Smallint]: Smallint read Get_Group write Set_Group;
    property MotorRs[nAxis: Smallint]: Single read Get_MotorRs write Set_MotorRs;
    property MotorSlipFreq[nAxis: Smallint]: Single read Get_MotorSlipFreq write Set_MotorSlipFreq;
    property HallReverseAngle[nAxis: Smallint; nSextant: Smallint]: Single read Get_HallReverseAngle write Set_HallReverseAngle;
    property HallTable[nAxis: Smallint; nState: Smallint]: Smallint read Get_HallTable write Set_HallTable;
    property GroupComms[nCANBus: Smallint; nGroup: Smallint; nIndex: Smallint]: Single write Set_GroupComms;
    property GroupInfo[nBus: Smallint; nNode: Smallint]: Smallint read Get_GroupInfo;
    property GroupStatus[nCANBus: Smallint; nGroup: Smallint]: Smallint read Get_GroupStatus;
    property MotorRotorLeakageInd[nAxis: Smallint]: Single read Get_MotorRotorLeakageInd write Set_MotorRotorLeakageInd;
    property MotorRotorRes[nAxis: Smallint]: Single read Get_MotorRotorRes write Set_MotorRotorRes;
    property MotorResolverOffset[nAxis: Smallint]: Single read Get_MotorResolverOffset write Set_MotorResolverOffset;
    property MotorTemperatureInput[nAxis: Smallint]: Smallint read Get_MotorTemperatureInput write Set_MotorTemperatureInput;
    property MotorSpeedMaxmmps[nAxis: Smallint]: Single read Get_MotorSpeedMaxmmps write Set_MotorSpeedMaxmmps;
    property MotorSpecNumber[nAxis: Smallint]: WideString read Get_MotorSpecNumber write Set_MotorSpecNumber;
    property MotorResolverSpeed[nAxis: Smallint]: Single read Get_MotorResolverSpeed write Set_MotorResolverSpeed;
    property Hall[nAxis: Smallint]: Smallint read Get_Hall;
    property HomePhase[nAxis: Smallint]: Smallint read Get_HomePhase;
    property HomePos[nAxis: Smallint]: Single read Get_HomePos;
    property FrictionCompensationTConst[nAxis: Smallint]: Single read Get_FrictionCompensationTConst write Set_FrictionCompensationTConst;
    property Gearing[nAxis: Smallint]: Single read Get_Gearing write Set_Gearing;
    property HomeOffset[nAxis: Smallint]: Single read Get_HomeOffset write Set_HomeOffset;
    property HomeRefPos[nAxis: Smallint]: Single read Get_HomeRefPos write Set_HomeRefPos;
    property GearingMode[nAxis: Smallint]: Smallint read Get_GearingMode write Set_GearingMode;
    property FrictionCompensation[nAxis: Smallint]: Single read Get_FrictionCompensation write Set_FrictionCompensation;
    property FrictionCompensationSpeed[nAxis: Smallint]: Single read Get_FrictionCompensationSpeed write Set_FrictionCompensationSpeed;
    property HallForwardAngle[nAxis: Smallint; nSextant: Smallint]: Single read Get_HallForwardAngle write Set_HallForwardAngle;
    property FollowNumerator[nAxis: Smallint]: Single read Get_FollowNumerator write Set_FollowNumerator;
    property Freq[nAxis: Smallint]: Single read Get_Freq write Set_Freq;
    property KITrack[nAxis: Smallint]: Smallint read Get_KITrack write Set_KITrack;
    property KIntMode[nAxis: Smallint]: Smallint read Get_KIntMode write Set_KIntMode;
    property KVel[nAxis: Smallint]: Single read Get_KVel write Set_KVel;
    property KIProp[nAxis: Smallint]: Single read Get_KIProp write Set_KIProp;
    property KVDerivTConst[nAxis: Smallint]: Single read Get_KVDerivTConst write Set_KVDerivTConst;
    property KProp[nAxis: Smallint]: Single read Get_KProp write Set_KProp;
    property KVProp[nAxis: Smallint]: Single read Get_KVProp write Set_KVProp;
    property KVelFF[nAxis: Smallint]: Single read Get_KVelFF write Set_KVelFF;
    property KVFilterLevel[nAxis: Smallint]: Smallint read Get_KVFilterLevel write Set_KVFilterLevel;
    property KVInt[nAxis: Smallint]: Single read Get_KVInt write Set_KVInt;
    property KVTrack[nAxis: Smallint]: Smallint read Get_KVTrack write Set_KVTrack;
    property KVMeas[nAxis: Smallint]: Single read Get_KVMeas write Set_KVMeas;
    property KVTime[nAxis: Smallint]: Single read Get_KVTime write Set_KVTime;
    property KVDeriv[nAxis: Smallint]: Single read Get_KVDeriv write Set_KVDeriv;
    property HTAChannel[nAxis: Smallint]: Smallint read Get_HTAChannel write Set_HTAChannel;
    property HTADamping[nAxis: Smallint]: Single read Get_HTADamping write Set_HTADamping;
    property HomeType[nAxis: Smallint]: Smallint read Get_HomeType write Set_HomeType;
    property IdleVel[nAxis: Smallint]: Single read Get_IdleVel write Set_IdleVel;
    property HTAKProp[nAxis: Smallint]: Single read Get_HTAKProp write Set_HTAKProp;
    property HTAFilter[nAxis: Smallint]: Single read Get_HTAFilter write Set_HTAFilter;
    property HTAKInt[nAxis: Smallint]: Single read Get_HTAKInt write Set_HTAKInt;
    property HTA[nAxis: Smallint]: Single read Get_HTA write Set_HTA;
    property IdleTime[nAxis: Smallint]: Smallint read Get_IdleTime write Set_IdleTime;
    property IdlePos[nAxis: Smallint]: Single read Get_IdlePos write Set_IdlePos;
    property Idle[nAxis: Smallint]: WordBool read Get_Idle;
    property IdleMode[nAxis: Smallint]: Smallint read Get_IdleMode write Set_IdleMode;
    property IMask[nBank: Smallint]: Integer read Get_IMask write Set_IMask;
    property IdleSettlingTime[nAxis: Smallint]: Integer read Get_IdleSettlingTime;
    property FeedrateParameter[nAxis: Smallint; nOverride: Smallint]: Single read Get_FeedrateParameter write Set_FeedrateParameter;
    property FirmwareComponentVersion[nComponent: Smallint]: Single read Get_FirmwareComponentVersion;
    property Fly[nAxis: Smallint]: Single write Set_Fly;
    property FastSelect[nAxis: Smallint]: Smallint read Get_FastSelect write Set_FastSelect;
    property FeedrateMode[nAxis: Smallint]: Smallint read Get_FeedrateMode write Set_FeedrateMode;
    property KFInt[nAxis: Smallint]: Single read Get_KFInt write Set_KFInt;
    property KFProp[nAxis: Smallint]: Single read Get_KFProp write Set_KFProp;
    property FeedrateOverride[nAxis: Smallint]: Single read Get_FeedrateOverride write Set_FeedrateOverride;
    property FastPos[nAxis: Smallint]: Single read Get_FastPos;
    property FollowMode[nAxis: Smallint]: Smallint read Get_FollowMode write Set_FollowMode;
    property Follow[nAxis: Smallint]: Single read Get_Follow write Set_Follow;
    property Feedrate[nAxis: Smallint]: Single read Get_Feedrate write Set_Feedrate;
    property FollowDenom[nAxis: Smallint]: Single read Get_FollowDenom write Set_FollowDenom;
    property FolError[nAxis: Smallint]: Single read Get_FolError;
    property JogDuration[nAxis: Smallint]: Integer read Get_JogDuration write Set_JogDuration;
    property JogSpeed[nAxis: Smallint]: Single read Get_JogSpeed write Set_JogSpeed;
    property KASInt[nAxis: Smallint]: Single read Get_KASInt write Set_KASInt;
    property JogDecelTimeMax[nAxis: Smallint]: Integer read Get_JogDecelTimeMax write Set_JogDecelTimeMax;
    property KAccel[nAxis: Smallint]: Single read Get_KAccel write Set_KAccel;
    property KIntLimit[nAxis: Smallint]: Single read Get_KIntLimit write Set_KIntLimit;
    property KASProp[nAxis: Smallint]: Single read Get_KASProp write Set_KASProp;
    property JogTime[nAxis: Smallint]: Integer read Get_JogTime;
    property JogMode[nAxis: Smallint]: Smallint read Get_JogMode write Set_JogMode;
    property KFTime[nAxis: Smallint]: Single read Get_KFTime write Set_KFTime;
    property KInt[nAxis: Smallint]: Single read Get_KInt write Set_KInt;
    property KDeriv[nAxis: Smallint]: Single read Get_KDeriv write Set_KDeriv;
    property KIInt[nAxis: Smallint]: Single read Get_KIInt write Set_KIInt;
    property MotorStatorRes[nAxis: Smallint]: Single read Get_MotorStatorRes write Set_MotorStatorRes;
    property LatchSourceChannel[nLatchChannel: Smallint]: Smallint read Get_LatchSourceChannel write Set_LatchSourceChannel;
    property LatchInhibitValue[nLatchChannel: Smallint]: Single read Get_LatchInhibitValue write Set_LatchInhibitValue;
    property KnifeMode[nAxis: Smallint]: Smallint read Get_KnifeMode write Set_KnifeMode;
    property LatchTriggerEdge[nLatchChannel: Smallint]: Smallint read Get_LatchTriggerEdge write Set_LatchTriggerEdge;
    property LatchSource[nLatchChannel: Smallint]: Smallint read Get_LatchSource write Set_LatchSource;
    property KnifeMasterAxis[nAxis: Smallint]: Smallint read Get_KnifeMasterAxis write Set_KnifeMasterAxis;
    property KnifeStatus[nAxis: Smallint]: Smallint read Get_KnifeStatus write Set_KnifeStatus;
    property LatchTriggerChannel[nLatchChannel: Smallint]: Smallint read Get_LatchTriggerChannel write Set_LatchTriggerChannel;
    property MotorFluxMax[nAxis: Smallint]: Single read Get_MotorFluxMax write Set_MotorFluxMax;
    property LatchSetup[nDeviceType: Smallint; nChannel: Smallint]: Smallint read Get_LatchSetup write Set_LatchSetup;
    property LatchSetupMultiple[nDeviceType: Smallint; nChannel: Smallint]: OleVariant read Get_LatchSetupMultiple write Set_LatchSetupMultiple;
    property MotorFluxMin[nAxis: Smallint]: Single read Get_MotorFluxMin write Set_MotorFluxMin;
    property MotorFlux[nAxis: Smallint]: Single read Get_MotorFlux write Set_MotorFlux;
    property LatchMode[nLatchChannel: Smallint]: Smallint read Get_LatchMode write Set_LatchMode;
    property LatchInhibitTime[nLatchChannel: Smallint]: Integer read Get_LatchInhibitTime write Set_LatchInhibitTime;
    property MasterDistance[nAxis: Smallint]: Single read Get_MasterDistance write Set_MasterDistance;
    property MasterSource[nAxis: Smallint]: Smallint read Get_MasterSource write Set_MasterSource;
    property MaxAccel[nAxis: Smallint]: Single read Get_MaxAccel write Set_MaxAccel;
    property MaxDecel[nAxis: Smallint]: Single read Get_MaxDecel write Set_MaxDecel;
    property LimitForwardInput[nAxis: Smallint]: Smallint read Get_LimitForwardInput write Set_LimitForwardInput;
    property LatchTriggerMode[nLatchChannel: Smallint]: Smallint read Get_LatchTriggerMode write Set_LatchTriggerMode;
    property ListOf[nListOf: Smallint; nParameter: Smallint]: OleVariant read Get_ListOf write Set_ListOf;
    property Limit[nAxis: Smallint]: WordBool read Get_Limit;
    property LimitForward[nAxis: Smallint]: WordBool read Get_LimitForward;
    property LatchEnable[nLatchChannel: Smallint]: WordBool read Get_LatchEnable write Set_LatchEnable;
    property Latch[nLatchChannel: Smallint]: WordBool read Get_Latch;
    property LoadDamping[nAxis: Smallint]: Single read Get_LoadDamping write Set_LoadDamping;
    property LoadInertia[nAxis: Smallint]: Single read Get_LoadInertia write Set_LoadInertia;
    property MasterChannel[nAxis: Smallint]: Smallint read Get_MasterChannel write Set_MasterChannel;
    property MintExtendedStatus[nCommand: Smallint; vData: OleVariant]: Integer read Get_MintExtendedStatus;
    property MaxSpeed[nAxis: Smallint]: Single read Get_MaxSpeed write Set_MaxSpeed;
    property MotorBrake[nAxis: Smallint]: WordBool write Set_MotorBrake;
    property MintExpressions[vLHS: OleVariant]: OleVariant read Get_MintExpressions write Set_MintExpressions;
    property MotorBaseVolts[nAxis: Smallint]: Single read Get_MotorBaseVolts write Set_MotorBaseVolts;
    property ModuleName[nModuleID: Smallint]: WideString read Get_ModuleName;
    property MintStatus[nCommand: Smallint]: Integer read Get_MintStatus;
    property MotorBaseFreq[nAxis: Smallint]: Single read Get_MotorBaseFreq write Set_MotorBaseFreq;
    property MotorDirection[nAxis: Smallint]: Smallint read Get_MotorDirection write Set_MotorDirection;
    property MotorBrakeDelay[nAxis: Smallint; nChannel: Smallint]: Smallint read Get_MotorBrakeDelay write Set_MotorBrakeDelay;
    property MotorBrakeMode[nAxis: Smallint]: Smallint read Get_MotorBrakeMode write Set_MotorBrakeMode;
    property MotorBrakeOutput[nAxis: Smallint]: Smallint read Get_MotorBrakeOutput write Set_MotorBrakeOutput;
    property MotorEncoderLines[nAxis: Smallint]: Integer read Get_MotorEncoderLines write Set_MotorEncoderLines;
    property MotorCatalogNumber[nAxis: Smallint]: WideString read Get_MotorCatalogNumber write Set_MotorCatalogNumber;
    property MotorBrakeStatus[nAxis: Smallint]: Smallint read Get_MotorBrakeStatus;
    property MonitorParameter[nGroup: Smallint; nMode: Smallint; nParameter: Smallint]: Integer read Get_MonitorParameter;
    property MotorFeedbackAngle[nAxis: Smallint]: Single read Get_MotorFeedbackAngle;
    property MotorFeedbackOffset[nAxis: Smallint]: Single read Get_MotorFeedbackOffset write Set_MotorFeedbackOffset;
    property MotorLs[nAxis: Smallint]: Single read Get_MotorLs write Set_MotorLs;
    property MotorMagCurrent[nAxis: Smallint]: Single read Get_MotorMagCurrent write Set_MotorMagCurrent;
    property MotorFluxTConst[nAxis: Smallint]: Single read Get_MotorFluxTConst write Set_MotorFluxTConst;
    property MotorFeedbackStatus[nAxis: Smallint]: Smallint read Get_MotorFeedbackStatus;
    property MotorFeedback[nAxis: Smallint]: Smallint read Get_MotorFeedback write Set_MotorFeedback;
    property MotorFeedbackAlignment[nAxis: Smallint]: Single read Get_MotorFeedbackAlignment write Set_MotorFeedbackAlignment;
    property MotorLinearEncoderResolution[nAxis: Smallint]: Integer read Get_MotorLinearEncoderResolution write Set_MotorLinearEncoderResolution;
    property MotorLinearPolePitch[nAxis: Smallint]: Single read Get_MotorLinearPolePitch write Set_MotorLinearPolePitch;
    property MotorMagCurrentCoeff[nAxis: Smallint; nChannel: Smallint]: Single read Get_MotorMagCurrentCoeff write Set_MotorMagCurrentCoeff;
    property MotorInstabilityFreq[nAxis: Smallint]: Single read Get_MotorInstabilityFreq write Set_MotorInstabilityFreq;
    property LatchValue[nLatchChannel: Smallint]: Single read Get_LatchValue;
    property MotorRatedCurrent[nAxis: Smallint]: Single read Get_MotorRatedCurrent write Set_MotorRatedCurrent;
    property MotorRatedSpeed[nAxis: Smallint]: Single read Get_MotorRatedSpeed write Set_MotorRatedSpeed;
    property MotorRatedFreq[nAxis: Smallint]: Single read Get_MotorRatedFreq write Set_MotorRatedFreq;
    property MotorPowerMeasured[nAxis: Smallint]: Single read Get_MotorPowerMeasured;
    property MotorRatedSpeedmmps[nAxis: Smallint]: Single read Get_MotorRatedSpeedmmps write Set_MotorRatedSpeedmmps;
    property MotorRatedSpeedRPM[nAxis: Smallint]: Integer read Get_MotorRatedSpeedRPM write Set_MotorRatedSpeedRPM;
    property MotorRatedVolts[nAxis: Smallint]: Single read Get_MotorRatedVolts write Set_MotorRatedVolts;
    property NetInteger[nIndex: Smallint]: Integer read Get_NetInteger write Set_NetInteger;
    property NodeType[nCANBus: Smallint; nNode: Smallint]: Smallint read Get_NodeType write Set_NodeType;
    property NetIntegerMultiple[nIndex: Smallint; nElements: Smallint]: OleVariant read Get_NetIntegerMultiple write Set_NetIntegerMultiple;
    property NodeLive[nCANBus: Smallint; nNode: Smallint]: WordBool read Get_NodeLive;
    property NetFloatMultiple[nIndex: Smallint; nElements: Smallint]: OleVariant read Get_NetFloatMultiple write Set_NetFloatMultiple;
    property NodeTypeExtended[nBus: Smallint; nNode: Smallint]: OleVariant read Get_NodeTypeExtended write Set_NodeTypeExtended;
    property NumberOf[nItem: Smallint]: Smallint read Get_NumberOf write Set_NumberOf;
    property NumberOfExtended[nItem: Smallint; nParameter: Smallint]: Smallint read Get_NumberOfExtended write Set_NumberOfExtended;
    property MotorPoles[nAxis: Smallint]: Smallint read Get_MotorPoles write Set_MotorPoles;
    property MotorStatorLeakageInd[nAxis: Smallint]: Single read Get_MotorStatorLeakageInd write Set_MotorStatorLeakageInd;
    property MotorSpeedMaxRPM[nAxis: Smallint]: Smallint read Get_MotorSpeedMaxRPM write Set_MotorSpeedMaxRPM;
    property MotorStabilityGain[nAxis: Smallint]: Single read Get_MotorStabilityGain write Set_MotorStabilityGain;
    property MotorTemperatureMode[nAxis: Smallint]: Smallint read Get_MotorTemperatureMode write Set_MotorTemperatureMode;
    property MotorPeakCurrent[nAxis: Smallint]: Single read Get_MotorPeakCurrent write Set_MotorPeakCurrent;
    property MotorMagCurrentMax[nAxis: Smallint]: Single read Get_MotorMagCurrentMax write Set_MotorMagCurrentMax;
    property MotorMagCurrentMin[nAxis: Smallint]: Single read Get_MotorMagCurrentMin write Set_MotorMagCurrentMin;
    property MotorMagInd[nAxis: Smallint]: Single read Get_MotorMagInd write Set_MotorMagInd;
    property MotorOverloadArea[nAxis: Smallint]: Single read Get_MotorOverloadArea;
    property MotorOverloadMode[nAxis: Smallint]: Smallint read Get_MotorOverloadMode write Set_MotorOverloadMode;
    property MotorPeakDuration[nAxis: Smallint]: Single read Get_MotorPeakDuration write Set_MotorPeakDuration;
    property NetFloat[nIndex: Smallint]: Single read Get_NetFloat write Set_NetFloat;
    property MoveRTest[nAxis: Smallint; nParam: Smallint]: Single read Get_MoveRTest write Set_MoveRTest;
    property MoveDwell[nAxis: Smallint]: Integer write Set_MoveDwell;
    property MoveR[nAxis: Smallint]: Single write Set_MoveR;
    property MultipleCommandsExecute[nFlags: Integer]: OleVariant read Get_MultipleCommandsExecute;
    property MotorType[nAxis: Smallint]: Smallint read Get_MotorType write Set_MotorType;
    property MoveA[nAxis: Smallint]: Single write Set_MoveA;
    property MoveStatus[nAxis: Smallint]: Smallint read Get_MoveStatus;
    property MoveBufferSize[nAxis: Smallint]: Smallint read Get_MoveBufferSize write Set_MoveBufferSize;
    property MoveCorrection[nAxis: Smallint]: Single write Set_MoveCorrection;
    property LimitMode[nAxis: Smallint]: Smallint read Get_LimitMode write Set_LimitMode;
    property LimitReverseInput[nAxis: Smallint]: Smallint read Get_LimitReverseInput write Set_LimitReverseInput;
    property MoveOutX[nAxis: Smallint; nChannel: Smallint]: WordBool write Set_MoveOutX;
    property MovePulseOutX[nAxis: Smallint; nChannel: Smallint]: Integer write Set_MovePulseOutX;
    property MoveBufferStatus[nAxis: Smallint]: Smallint read Get_MoveBufferStatus;
    property LimitReverse[nAxis: Smallint]: WordBool read Get_LimitReverse;
    property MoveOut[nAxis: Smallint; nOutputBank: Smallint]: Integer write Set_MoveOut;
    property MotorTemperatureSwitch[nAxis: Smallint]: WordBool read Get_MotorTemperatureSwitch;
    property OffsetDistance[nAxis: Smallint]: Single read Get_OffsetDistance write Set_OffsetDistance;
    property OkToLoadMove[nNumberOfAxes: Smallint; nAxisArray: OleVariant]: WordBool read Get_OkToLoadMove;
    property OptionCardBus[nSlot: Smallint]: Smallint read Get_OptionCardBus;
    property NVFloat[nAddress: Smallint]: Single read Get_NVFloat write Set_NVFloat;
    property NVLong[nAddress: Smallint]: Integer read Get_NVLong write Set_NVLong;
    property OffsetStatus[nAxis: Smallint]: Smallint read Get_OffsetStatus;
    property OptionCardNetworkAddress[nSlot: Smallint]: Integer read Get_OptionCardNetworkAddress write Set_OptionCardNetworkAddress;
    property OffsetMode[nAxis: Smallint]: Smallint read Get_OffsetMode write Set_OffsetMode;
    property MoveBufferLow[nAxis: Smallint]: Smallint read Get_MoveBufferLow write Set_MoveBufferLow;
    property MotorTestMode[nParam: Smallint]: Single read Get_MotorTestMode write Set_MotorTestMode;
    property MoveBufferFree[nAxis: Smallint]: Smallint read Get_MoveBufferFree;
    property Offset[nAxis: Smallint]: Single write Set_Offset;
    property MoveBufferID[nAxis: Smallint]: Integer read Get_MoveBufferID write Set_MoveBufferID;
    property MoveBufferIDLast[nAxis: Smallint]: Integer read Get_MoveBufferIDLast;
    property PosRef[nAxis: Smallint]: Single read Get_PosRef write Set_PosRef;
    property PosRemaining[nAxis: Smallint]: Single read Get_PosRemaining;
    property PLXData[nAddress: Smallint]: Integer read Get_PLXData write Set_PLXData;
    property PosDemand[nAxis: Smallint]: Single read Get_PosDemand write Set_PosDemand;
    property PosWrap[nAxis: Smallint]: Single read Get_PosWrap write Set_PosWrap;
    property PrecisionSourceChannel[nAxisOrChannel: Smallint]: Smallint read Get_PrecisionSourceChannel write Set_PrecisionSourceChannel;
    property PresetAccel[nPreset: Smallint; nFmt: Smallint]: Single read Get_PresetAccel write Set_PresetAccel;
    property PositionControlLooptime[nAxis: Smallint]: Smallint read Get_PositionControlLooptime write Set_PositionControlLooptime;
    property PLCTaskStatus[nChannel: Smallint]: Smallint read Get_PLCTaskStatus;
    property PosTrimGain[nAxis: Smallint]: Single read Get_PosTrimGain write Set_PosTrimGain;
    property PosScaleUnits[nAxis: Smallint]: WideString read Get_PosScaleUnits write Set_PosScaleUnits;
    property PosRolloverTarget[nAxis: Smallint]: Integer read Get_PosRolloverTarget;
    property Pos[nAxis: Smallint]: Single read Get_Pos write Set_Pos;
    property PosAchieved[nAxis: Smallint]: WordBool read Get_PosAchieved;
    property PosTarget[nAxis: Smallint]: Single read Get_PosTarget;
    property PosTargetLast[nAxis: Smallint]: Single read Get_PosTargetLast;
    property PosRollover[nAxis: Smallint]: Integer read Get_PosRollover write Set_PosRollover;
    property PowerReadyInput[nParam: Smallint]: Smallint read Get_PowerReadyInput write Set_PowerReadyInput;
    property PrecisionAxis[nAxisOrChannel: Smallint]: Smallint read Get_PrecisionAxis write Set_PrecisionAxis;
    property PrecisionMode[nAxisOrChannel: Smallint]: Smallint read Get_PrecisionMode write Set_PrecisionMode;
    property PowerReadyOutput[nParam: Smallint]: Smallint read Get_PowerReadyOutput write Set_PowerReadyOutput;
    property PowerbaseParameter[nParam: Smallint]: Single read Get_PowerbaseParameter write Set_PowerbaseParameter;
    property PrecisionIncrement[nAxisOrChannel: Smallint]: Single read Get_PrecisionIncrement write Set_PrecisionIncrement;
    property OutputMonitorModeParameter[nOutput: Smallint]: Smallint read Get_OutputMonitorModeParameter write Set_OutputMonitorModeParameter;
    property PrecisionOffset[nAxisOrChannel: Smallint]: Single read Get_PrecisionOffset write Set_PrecisionOffset;
    property PresetDecel[nPreset: Smallint; nFmt: Smallint]: Single read Get_PresetDecel write Set_PresetDecel;
    property PresetIndex[nAxis: Smallint]: Smallint read Get_PresetIndex write Set_PresetIndex;
    property PrecisionSource[nAxisOrChannel: Smallint]: Smallint read Get_PrecisionSource write Set_PrecisionSource;
    property PresetDwellTime[nAxis: Smallint]: Integer read Get_PresetDwellTime write Set_PresetDwellTime;
    property PresetIndexMode[nAxis: Smallint]: Smallint read Get_PresetIndexMode write Set_PresetIndexMode;
    property SuspendSwitch[nAxis: Smallint]: WordBool read Get_SuspendSwitch;
    property Temperature[nChannel: Smallint]: Single read Get_Temperature;
    property TorqueFilterBand[nAxis: Smallint; nStage: Smallint]: Single read Get_TorqueFilterBand write Set_TorqueFilterBand;
    property TemperatureLimitWarning[nChannel: Smallint]: Single read Get_TemperatureLimitWarning;
    property TerminalAddress[nTerminalID: Integer]: Smallint read Get_TerminalAddress write Set_TerminalAddress;
    property SuspendInput[nAxis: Smallint]: Smallint read Get_SuspendInput write Set_SuspendInput;
    property TorqueRefEnable[nAxis: Smallint]: WordBool read Get_TorqueRefEnable write Set_TorqueRefEnable;
    property TorqueRefErrorFallTime[nAxis: Smallint]: Single read Get_TorqueRefErrorFallTime write Set_TorqueRefErrorFallTime;
    property TorqueRefFallTime[nAxis: Smallint]: Single read Get_TorqueRefFallTime write Set_TorqueRefFallTime;
    property TemperatureLimitFatal[nChannel: Smallint]: Single read Get_TemperatureLimitFatal;
    property Torque[nAxis: Smallint]: Single read Get_Torque write Set_Torque;
    property StopSwitch[nAxis: Smallint]: WordBool read Get_StopSwitch;
    property TimeScale[nAxis: Smallint]: Single read Get_TimeScale write Set_TimeScale;
    property StopMode[nAxis: Smallint]: Smallint read Get_StopMode write Set_StopMode;
    property Suspend[nAxis: Smallint]: Smallint read Get_Suspend write Set_Suspend;
    property StopInputMode[nAxis: Smallint]: Smallint read Get_StopInputMode write Set_StopInputMode;
    property TorqueRefRiseTime[nAxis: Smallint]: Single read Get_TorqueRefRiseTime write Set_TorqueRefRiseTime;
    property TorqueRef[nAxis: Smallint]: Single read Get_TorqueRef write Set_TorqueRef;
    property TorqueLimitNeg[nAxis: Smallint]: Single read Get_TorqueLimitNeg write Set_TorqueLimitNeg;
    property TorqueLimitPos[nAxis: Smallint]: Single read Get_TorqueLimitPos write Set_TorqueLimitPos;
    property TorqueProvingMode[nAxis: Smallint]: Smallint read Get_TorqueProvingMode write Set_TorqueProvingMode;
    property PosScaleFactor[nAxis: Smallint]: Single read Get_PosScaleFactor write Set_PosScaleFactor;
    property PosRolloverDemand[nAxis: Smallint]: Integer read Get_PosRolloverDemand;
    property PosRolloverTargetLast[nAxis: Smallint]: Integer read Get_PosRolloverTargetLast;
    property TorqueFilterFreq[nAxis: Smallint; nStage: Smallint]: Single read Get_TorqueFilterFreq write Set_TorqueFilterFreq;
    property TorqueRefSource[nAxis: Smallint]: Smallint read Get_TorqueRefSource write Set_TorqueRefSource;
    property TriggerChannel[nAxis: Smallint]: Smallint read Get_TriggerChannel write Set_TriggerChannel;
    property TriggerCompensation[nAxis: Smallint]: Single read Get_TriggerCompensation write Set_TriggerCompensation;
    property TorqueFilterType[nAxis: Smallint; nStage: Smallint]: Smallint read Get_TorqueFilterType write Set_TorqueFilterType;
    property TorqueFilterDepth[nAxis: Smallint; nStage: Smallint]: Single read Get_TorqueFilterDepth write Set_TorqueFilterDepth;
    property RemoteNumberOf[nBus: Smallint; nNode: Smallint; nItem: Smallint]: Smallint read Get_RemoteNumberOf write Set_RemoteNumberOf;
    property RemoteInBank[nCANBus: Smallint; nNode: Smallint; nBank: Smallint]: Integer read Get_RemoteInBank;
    property RemoteInhibitTime[nBus: Smallint]: Smallint read Get_RemoteInhibitTime write Set_RemoteInhibitTime;
    property RemoteOut[nCANBus: Smallint; nNode: Smallint]: Integer read Get_RemoteOut write Set_RemoteOut;
    property RemoteOutBank[nCANBus: Smallint; nNode: Smallint; nBank: Smallint]: Integer read Get_RemoteOutBank write Set_RemoteOutBank;
    property RemoteIn[nCANBus: Smallint; nNode: Smallint]: Integer read Get_RemoteIn;
    property RemoteInputActiveLevel[nCANBus: Smallint; nNode: Smallint]: Integer read Get_RemoteInputActiveLevel write Set_RemoteInputActiveLevel;
    property RemoteMode[nCANBus: Smallint; nNode: Smallint]: Smallint read Get_RemoteMode write Set_RemoteMode;
    property RemoteEStop[nCANBus: Smallint; nNode: Smallint]: WordBool read Get_RemoteEStop write Set_RemoteEStop;
    property RemoteOutputError[nCANBus: Smallint; nNode: Smallint]: Integer read Get_RemoteOutputError write Set_RemoteOutputError;
    property RemoteObjectFloat[nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                               nSubIndex: Smallint]: Single read Get_RemoteObjectFloat write Set_RemoteObjectFloat;
    property RemoteObjectString[nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                nSubIndex: Smallint]: WideString read Get_RemoteObjectString write Set_RemoteObjectString;
    property PhaseSearchInput[nAxis: Smallint]: Smallint read Get_PhaseSearchInput write Set_PhaseSearchInput;
    property PhaseSearchMode[nAxis: Smallint]: Smallint read Get_PhaseSearchMode write Set_PhaseSearchMode;
    property RemoteOutputActiveLevel[nCANBus: Smallint; nNode: Smallint]: Integer read Get_RemoteOutputActiveLevel write Set_RemoteOutputActiveLevel;
    property RemoteObject[nBus: Smallint; nNode: Smallint; nIndex: Smallint; nSubIndex: Smallint; 
                          nVarType: Smallint]: Integer read Get_RemoteObject write Set_RemoteObject;
    property RemoteNode[nCANBus: Smallint]: Smallint write Set_RemoteNode;
    property SentinelLatch[nChannel: Smallint]: WordBool read Get_SentinelLatch;
    property SentinelPeriod[nSentinelChannel: Smallint]: Integer read Get_SentinelPeriod write Set_SentinelPeriod;
    property SentinelSource[nSentinelChannel: Smallint]: Smallint read Get_SentinelSource write Set_SentinelSource;
    property SentinelActionParameter[nSentinelChannel: Smallint]: Smallint read Get_SentinelActionParameter write Set_SentinelActionParameter;
    property RemoteOutX[nCANBus: Smallint; nNode: Smallint; nOutput: Smallint]: WordBool read Get_RemoteOutX write Set_RemoteOutX;
    property RemotePDOIn[nBus: Smallint; lCOBID: Integer; nBank: Smallint]: Integer read Get_RemotePDOIn;
    property RemotePDOMode[nBus: Smallint; nNode: Smallint]: Smallint read Get_RemotePDOMode write Set_RemotePDOMode;
    property RemotePDOValid[nBus: Smallint; nNode: Smallint]: WordBool read Get_RemotePDOValid;
    property SentinelAction[nSentinelChannel: Smallint]: Smallint read Get_SentinelAction write Set_SentinelAction;
    property RemoteInX[nCANBus: Smallint; nNode: Smallint; nInput: Smallint]: WordBool read Get_RemoteInX;
    property ScaleUnits[nAxis: Smallint; nChannel: Smallint]: Smallint read Get_ScaleUnits write Set_ScaleUnits;
    property SentinelActionMode[nSentinelChannel: Smallint]: Smallint read Get_SentinelActionMode write Set_SentinelActionMode;
    property OptionCardNetworkStatus[nSlot: Smallint]: Smallint read Get_OptionCardNetworkStatus;
    property OptionCardObjectFloat[nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                   lAttribute: Integer; nType: Smallint]: Single read Get_OptionCardObjectFloat write Set_OptionCardObjectFloat;
    property OptionCardObjectString[nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                    lAttribute: Integer; nType: Smallint]: WideString read Get_OptionCardObjectString write Set_OptionCardObjectString;
    property OptionCardObjectInteger[nSlot: Smallint; nObject: Smallint; lInstance: Integer; 
                                     lAttribute: Integer; nType: Smallint]: Integer read Get_OptionCardObjectInteger write Set_OptionCardObjectInteger;
    property OptionCardStatus[nSlot: Smallint]: Smallint read Get_OptionCardStatus;
    property OptionCardType[nSlot: Smallint]: Smallint read Get_OptionCardType;
    property OptionCardVersion[nSlot: Smallint; nItem: Smallint]: Smallint read Get_OptionCardVersion;
    property Out[nBank: Smallint]: Integer read Get_Out write Set_Out;
    property OutputMonitorMode[nOutput: Smallint]: Smallint read Get_OutputMonitorMode write Set_OutputMonitorMode;
    property OutX[nOutput: Smallint]: WordBool read Get_OutX write Set_OutX;
    property ParameterValuesSubset[nSubset: Smallint; nParameter: Smallint]: OleVariant read Get_ParameterValuesSubset;
    property OutputType[nOutput: Smallint]: Smallint read Get_OutputType;
    property OutputActiveLevel[nBank: Smallint]: Integer read Get_OutputActiveLevel write Set_OutputActiveLevel;
    property ParameterListString[nParameter: Smallint; nEnumeration: Smallint]: WideString read Get_ParameterListString;
    property ParameterNumberSubset[nSubset: Smallint]: OleVariant read Get_ParameterNumberSubset;
    property ParamSaveMode[nChannel: Smallint]: WordBool read Get_ParamSaveMode write Set_ParamSaveMode;
    property PDOLossMode[nAxis: Smallint]: Smallint read Get_PDOLossMode write Set_PDOLossMode;
    property PhaseSearchCurrent[nAxis: Smallint]: Single read Get_PhaseSearchCurrent write Set_PhaseSearchCurrent;
    property PhaseSearchBackoff[nAxis: Smallint]: Smallint read Get_PhaseSearchBackoff write Set_PhaseSearchBackoff;
    property PhaseSearchSpeed[nAxis: Smallint]: Smallint read Get_PhaseSearchSpeed write Set_PhaseSearchSpeed;
    property PhaseSearchBandwidth[nAxis: Smallint]: Single read Get_PhaseSearchBandwidth write Set_PhaseSearchBandwidth;
    property PhaseSearchOutput[nAxis: Smallint]: Smallint read Get_PhaseSearchOutput write Set_PhaseSearchOutput;
    property PLCOperator[nChannel: Smallint; nConditionNo: Smallint]: Smallint read Get_PLCOperator write Set_PLCOperator;
    property PhaseSearchStatus[nAxis: Smallint]: WordBool read Get_PhaseSearchStatus;
    property PhaseSearchTravel[nAxis: Smallint]: Smallint read Get_PhaseSearchTravel write Set_PhaseSearchTravel;
    property PLCCondition[nChannel: Smallint; nConditionNo: Smallint]: Smallint read Get_PLCCondition write Set_PLCCondition;
    property PLCTaskData[nChannel: Smallint; var pnCondition1: Smallint; var pnParam1: Smallint; 
                         var pnOperator: Smallint; var pnCondition2: Smallint; 
                         var pnParam2: Smallint]: WordBool read Get_PLCTaskData;
    property PLCEnableAction[nChannel: Smallint]: WordBool read Get_PLCEnableAction write Set_PLCEnableAction;
    property PLCParameter[nChannel: Smallint; nConditionNo: Smallint]: Smallint read Get_PLCParameter write Set_PLCParameter;
    property TorqueDemand[nAxis: Smallint]: Single read Get_TorqueDemand;
    property StopInput[nAxis: Smallint]: Smallint read Get_StopInput write Set_StopInput;
    property StepperScale[nChannel: Smallint]: Single read Get_StepperScale write Set_StepperScale;
    property StepperIO[nAxis: Smallint]: Smallint read Get_StepperIO write Set_StepperIO;
    property StepperWrap[nChannel: Smallint]: Single read Get_StepperWrap write Set_StepperWrap;
    property SplineStart[nAxis: Smallint]: Integer read Get_SplineStart write Set_SplineStart;
    property SplineSuspendTime[nAxis: Smallint]: Integer read Get_SplineSuspendTime write Set_SplineSuspendTime;
    property StepperVel[nChannel: Smallint]: Single read Get_StepperVel;
    property Stepper[nChannel: Smallint]: Single read Get_Stepper write Set_Stepper;
    property StepperDelay[nChannel: Smallint]: Single read Get_StepperDelay write Set_StepperDelay;
    property SpeedRefDecelTime[nAxis: Smallint]: Single read Get_SpeedRefDecelTime write Set_SpeedRefDecelTime;
    property SpeedRefAccelTime[nAxis: Smallint]: Single read Get_SpeedRefAccelTime write Set_SpeedRefAccelTime;
    property SpeedRefDecelJerkEndTime[nAxis: Smallint]: Single read Get_SpeedRefDecelJerkEndTime write Set_SpeedRefDecelJerkEndTime;
    property SpeedRefDecelJerkStartTime[nAxis: Smallint]: Single read Get_SpeedRefDecelJerkStartTime write Set_SpeedRefDecelJerkStartTime;
    property StepperMode[nChannel: Smallint]: Smallint read Get_StepperMode write Set_StepperMode;
    property Spline[nAxis: Smallint]: Smallint read Get_Spline write Set_Spline;
    property SplineEnd[nAxis: Smallint]: Integer read Get_SplineEnd write Set_SplineEnd;
    property SoftLimitReverse[nAxis: Smallint]: Single read Get_SoftLimitReverse write Set_SoftLimitReverse;
    property SoftwareDiagnostic[nParam1: Smallint; nParam2: Smallint]: Integer read Get_SoftwareDiagnostic;
    property SerialBaud[nPort: Smallint]: Integer read Get_SerialBaud write Set_SerialBaud;
    property SoftLimitForward[nAxis: Smallint]: Single read Get_SoftLimitForward write Set_SoftLimitForward;
    property SentinelTriggerValueInteger[nSentinelChannel: Smallint; nSentinelBand: Smallint]: Integer read Get_SentinelTriggerValueInteger write Set_SentinelTriggerValueInteger;
    property SentinelSource2[nSentinelChannel: Smallint]: Smallint read Get_SentinelSource2 write Set_SentinelSource2;
    property SentinelSource2Parameter[nSentinelChannel: Smallint]: Smallint read Get_SentinelSource2Parameter write Set_SentinelSource2Parameter;
    property SoftLimitMode[nAxis: Smallint]: Smallint read Get_SoftLimitMode write Set_SoftLimitMode;
    property SRamp[nAxis: Smallint]: Single read Get_SRamp write Set_SRamp;
    property StaticHandle[const lpszTask: WideString; const lpszVariable: WideString]: Integer read Get_StaticHandle;
    property SplineIndex[nAxis: Smallint]: Integer read Get_SplineIndex;
    property SerialBaudsSupported[nChannel: Smallint]: OleVariant read Get_SerialBaudsSupported;
    property Sextant[nAxis: Smallint]: Smallint read Get_Sextant write Set_Sextant;
    property SplineTime[nAxis: Smallint]: Integer read Get_SplineTime write Set_SplineTime;
    property JogAwayOffset[nAxis: Smallint]: Single read Get_JogAwayOffset;
    property InState[nBank: Smallint]: Integer read Get_InState;
    property InputActiveLevel[nBank: Smallint]: Integer read Get_InputActiveLevel write Set_InputActiveLevel;
    property JogAway[nAxis: Smallint]: Smallint read Get_JogAway write Set_JogAway;
    property IncR[nAxis: Smallint]: Single write Set_IncR;
    property InKey[nTerminalID: Integer]: Smallint read Get_InKey;
    property InputDebounce[nBank: Smallint]: Smallint read Get_InputDebounce write Set_InputDebounce;
    property IncA[nAxis: Smallint]: Single write Set_IncA;
    property JogCommand[nAxis: Smallint]: Smallint read Get_JogCommand write Set_JogCommand;
    property In_[nBank: Smallint]: Integer read Get_In_;
    property Jog[nAxis: Smallint]: Single read Get_Jog write Set_Jog;
    property HTADeadband[nAxis: Smallint]: Single read Get_HTADeadband write Set_HTADeadband;
    property InX[nInput: Smallint]: WordBool read Get_InX;
    property JogAccelTimeMax[nAxis: Smallint]: Integer read Get_JogAccelTimeMax write Set_JogAccelTimeMax;
    property InStateX[nInput: Smallint]: WordBool read Get_InStateX;
    property InternalData[nEnum1: Smallint; nEnum2: Smallint]: OleVariant read Get_InternalData;
    property InputNegTrigger[nBank: Smallint]: Integer read Get_InputNegTrigger write Set_InputNegTrigger;
    property SpeedTestRefAccelTime[nAxis: Smallint]: Single read Get_SpeedTestRefAccelTime write Set_SpeedTestRefAccelTime;
    property SpeedTestRefDecelTime[nAxis: Smallint]: Single read Get_SpeedTestRefDecelTime write Set_SpeedTestRefDecelTime;
    property SpeedTestRef[nAxis: Smallint]: Single read Get_SpeedTestRef write Set_SpeedTestRef;
    property SpeedRefAccelJerkEndTime[nAxis: Smallint]: Single read Get_SpeedRefAccelJerkEndTime write Set_SpeedRefAccelJerkEndTime;
    property SpeedRefAccelJerkStartTime[nAxis: Smallint]: Single read Get_SpeedRefAccelJerkStartTime write Set_SpeedRefAccelJerkStartTime;
    property SpeedRefAccelSource[nAxis: Smallint]: Smallint read Get_SpeedRefAccelSource write Set_SpeedRefAccelSource;
    property InputMode[nBank: Smallint]: Integer read Get_InputMode write Set_InputMode;
    property SpeedRefErrorDecelTime[nAxis: Smallint]: Single read Get_SpeedRefErrorDecelTime write Set_SpeedRefErrorDecelTime;
    property InputPosTrigger[nBank: Smallint]: Integer read Get_InputPosTrigger write Set_InputPosTrigger;
    property SpeedRefEnable[nAxis: Smallint]: WordBool read Get_SpeedRefEnable write Set_SpeedRefEnable;
    property SpeedRefSource[nAxis: Smallint]: Smallint read Get_SpeedRefSource write Set_SpeedRefSource;
    property VFThreePointFreq[nAxis: Smallint]: Single read Get_VFThreePointFreq write Set_VFThreePointFreq;
    property VFThreePointMode[nAxis: Smallint]: Smallint read Get_VFThreePointMode write Set_VFThreePointMode;
    property TriggerValue[nAxis: Smallint]: Single read Get_TriggerValue write Set_TriggerValue;
    property UserMotion[nAxis: Smallint]: Smallint write Set_UserMotion;
    property VelScaleFactor[nAxis: Smallint]: Single read Get_VelScaleFactor write Set_VelScaleFactor;
    property ZeroSpeedDeadband[nAxis: Smallint]: Single read Get_ZeroSpeedDeadband write Set_ZeroSpeedDeadband;
    property VFProfile[nAxis: Smallint]: Single read Get_VFProfile write Set_VFProfile;
    property VFSlipCompensationMode[nAxis: Smallint]: Smallint read Get_VFSlipCompensationMode write Set_VFSlipCompensationMode;
    property TriggerMode[nAxis: Smallint]: Smallint read Get_TriggerMode write Set_TriggerMode;
    property TriggerSource[nAxis: Smallint]: Smallint read Get_TriggerSource write Set_TriggerSource;
    property VelFatalMode[nAxis: Smallint]: Smallint read Get_VelFatalMode write Set_VelFatalMode;
    property UserTimeUnits[nAxis: Smallint]: WideString read Get_UserTimeUnits write Set_UserTimeUnits;
    property UserPositionUnits[nAxis: Smallint]: WideString read Get_UserPositionUnits write Set_UserPositionUnits;
    property TriggerInput[nAxis: Smallint]: Smallint read Get_TriggerInput write Set_TriggerInput;
    property VFDeadband[nAxis: Smallint; nChannel: Smallint]: Single read Get_VFDeadband write Set_VFDeadband;
    property TerminalMode[nTerminalID: Integer]: Smallint read Get_TerminalMode write Set_TerminalMode;
    property TerminalPort[nTerminalID: Integer]: Smallint read Get_TerminalPort write Set_TerminalPort;
    property VFDeadbandCentreFreq[nAxis: Smallint; nChannel: Smallint]: Single read Get_VFDeadbandCentreFreq write Set_VFDeadbandCentreFreq;
    property VFBoostTransitionMode[nAxis: Smallint]: Smallint read Get_VFBoostTransitionMode write Set_VFBoostTransitionMode;
    property TerminalXoff[nTerminalID: Integer]: WordBool write Set_TerminalXoff;
    property TerminalDevice[nTerminalID: Integer]: Smallint read Get_TerminalDevice write Set_TerminalDevice;
    property VelSetpointMax[nAxis: Smallint]: Single read Get_VelSetpointMax write Set_VelSetpointMax;
    property VFThreePointVolts[nAxis: Smallint]: Single read Get_VFThreePointVolts write Set_VFThreePointVolts;
    property VoltageDemand[nAxis: Smallint; nChannel: Smallint]: Single read Get_VoltageDemand;
    property VelScaleUnits[nAxis: Smallint]: WideString read Get_VelScaleUnits write Set_VelScaleUnits;
    property VelSetpointMin[nAxis: Smallint]: Single read Get_VelSetpointMin write Set_VelSetpointMin;
    property SpeedMeasured[nAxis: Smallint]: Single read Get_SpeedMeasured;
    property SpeedObserverK1[nAxis: Smallint]: Single read Get_SpeedObserverK1 write Set_SpeedObserverK1;
    property SpeedObserverKJ[nAxis: Smallint]: Single read Get_SpeedObserverKJ write Set_SpeedObserverKJ;
    property SpeedFilterType[nAxis: Smallint]: Smallint read Get_SpeedFilterType write Set_SpeedFilterType;
    property SpeedObserverK2[nAxis: Smallint]: Single read Get_SpeedObserverK2 write Set_SpeedObserverK2;
    property SpeedFilterRipple[nAxis: Smallint]: Single read Get_SpeedFilterRipple write Set_SpeedFilterRipple;
    property SpeedRef[nAxis: Smallint]: Single read Get_SpeedRef write Set_SpeedRef;
    property SpeedObserverEnable[nAxis: Smallint]: WordBool read Get_SpeedObserverEnable write Set_SpeedObserverEnable;
    property SentinelState[nSentinelChannel: Smallint]: Smallint read Get_SentinelState;
    property SentinelTriggerMode[nSentinelChannel: Smallint]: Smallint read Get_SentinelTriggerMode write Set_SentinelTriggerMode;
    property SentinelTriggerValueFloat[nSentinelChannel: Smallint; nSentinelBand: Smallint]: Single read Get_SentinelTriggerValueFloat write Set_SentinelTriggerValueFloat;
    property SentinelSourceParameter[nSentinelChannel: Smallint]: Smallint read Get_SentinelSourceParameter write Set_SentinelSourceParameter;
    property Speed[nAxis: Smallint]: Single read Get_Speed write Set_Speed;
    property SentinelTriggerAbsolute[nSentinelChannel: Smallint]: WordBool read Get_SentinelTriggerAbsolute write Set_SentinelTriggerAbsolute;
    property SpeedError[nAxis: Smallint]: Single read Get_SpeedError;
    property VariableData[const bstrTaskName: WideString; const bstrVarName: WideString]: OleVariant read Get_VariableData write Set_VariableData;
    property VectorAngle[nAxisX: Smallint; nAxisY: Smallint]: Single read Get_VectorAngle;
    property Vel[nAxis: Smallint]: Single read Get_Vel;
    property VelDemand[nAxis: Smallint]: Single read Get_VelDemand;
    property VelDemandPath[nAxis: Smallint]: Single read Get_VelDemandPath;
    property VelRef[nAxis: Smallint]: Single read Get_VelRef write Set_VelRef;
    property VelFatal[nAxis: Smallint]: Single read Get_VelFatal write Set_VelFatal;
    property VelError[nAxis: Smallint]: Single read Get_VelError;
    property SpeedDemand[nAxis: Smallint]: Single read Get_SpeedDemand write Set_SpeedDemand;
    property SpeedFilterBand[nAxis: Smallint]: Single read Get_SpeedFilterBand write Set_SpeedFilterBand;
    property SpeedErrorFatal[nAxis: Smallint]: Single read Get_SpeedErrorFatal write Set_SpeedErrorFatal;
    property SpeedFilterFreq[nAxis: Smallint]: Single read Get_SpeedFilterFreq write Set_SpeedFilterFreq;
    property SpeedFilterPoles[nAxis: Smallint]: Smallint read Get_SpeedFilterPoles write Set_SpeedFilterPoles;
    property USBDeviceList: OleVariant index 122 read GetOleVariantProp write SetOleVariantProp;
    property H2USBDeviceList: OleVariant index 61 read GetOleVariantProp write SetOleVariantProp;
    property ExtendedEventData: OleVariant index 55 read GetOleVariantProp write SetOleVariantProp;
    property BufferChars: OleVariant index 13 read GetOleVariantProp write SetOleVariantProp;
    property BootloaderBaudsSupported: OleVariant index 11 read GetOleVariantProp write SetOleVariantProp;
  published
    property Anchors;
    property USBDriverVersion: WideString index 123 read GetWideStringProp write SetWideStringProp stored False;
    property TimerEvent: Integer index 121 read GetIntegerProp write SetIntegerProp stored False;
    property Time: Integer index 120 read GetIntegerProp write SetIntegerProp stored False;
    property SystemState: Smallint index 119 read GetSmallintProp write SetSmallintProp stored False;
    property SystemSeconds: Single index 118 read GetSingleProp write SetSingleProp stored False;
    property SupportsMint: WordBool index 117 read GetWordBoolProp write SetWordBoolProp stored False;
    property ServerVersion: WideString index 116 read GetWideStringProp write SetWideStringProp stored False;
    property SerialHandshakeMode: Smallint index 115 read GetSmallintProp write SetSmallintProp stored False;
    property SerialChar: Smallint index 114 read GetSmallintProp write SetSmallintProp stored False;
    property SerialBufferUsage: Smallint index 113 read GetSmallintProp write SetSmallintProp stored False;
    property ScanOverrunLimit: Smallint index 112 read GetSmallintProp write SetSmallintProp stored False;
    property ReleaseBuild: WordBool index 111 read GetWordBoolProp write SetWordBoolProp stored False;
    property RealTimeClock: TDateTime index 110 read GetTDateTimeProp write SetTDateTimeProp stored False;
    property RAMTest: Smallint index 109 read GetSmallintProp write SetSmallintProp stored False;
    property PWMPeriod: Smallint index 108 read GetSmallintProp write SetSmallintProp stored False;
    property PulseDirMode: Smallint index 107 read GetSmallintProp write SetSmallintProp stored False;
    property PulseCounter: Integer index 106 read GetIntegerProp write SetIntegerProp stored False;
    property ProfileTime: Smallint index 105 read GetSmallintProp write SetSmallintProp stored False;
    property ProductSerialNumber: WideString index 104 read GetWideStringProp write SetWideStringProp stored False;
    property ProductCatalogNumber: WideString index 103 read GetWideStringProp write SetWideStringProp stored False;
    property PresetTriggerInputOld: Smallint index 102 read GetSmallintProp write SetSmallintProp stored False;
    property PresetSelectorInputOld: Smallint index 101 read GetSmallintProp write SetSmallintProp stored False;
    property PresetMoveEnableOld: Smallint index 100 read GetSmallintProp write SetSmallintProp stored False;
    property PresetInputStateOld: Smallint index 99 read GetSmallintProp write SetSmallintProp stored False;
    property PresetInputsMaxOld: Smallint index 98 read GetSmallintProp write SetSmallintProp stored False;
    property PresetIndexSourceOld: Smallint index 97 read GetSmallintProp write SetSmallintProp stored False;
    property PresetIndexModeOld: Smallint index 96 read GetSmallintProp write SetSmallintProp stored False;
    property PresetIndexOld: Smallint index 95 read GetSmallintProp write SetSmallintProp stored False;
    property PresetDwellTimeOld: Integer index 94 read GetIntegerProp write SetIntegerProp stored False;
    property PortSpeed: Integer index 93 read GetIntegerProp write SetIntegerProp stored False;
    property PortNumber: Smallint index 92 read GetSmallintProp write SetSmallintProp stored False;
    property PLCTime: Smallint index 91 read GetSmallintProp write SetSmallintProp stored False;
    property PLCStatus: Integer index 90 read GetIntegerProp write SetIntegerProp stored False;
    property PLCGearFactor: Smallint index 89 read GetSmallintProp write SetSmallintProp stored False;
    property PLCEnable: WordBool index 88 read GetWordBoolProp write SetWordBoolProp stored False;
    property PLCAutoEnable: WordBool index 87 read GetWordBoolProp write SetWordBoolProp stored False;
    property PlatformName: WideString index 86 read GetWideStringProp write SetWideStringProp stored False;
    property Platform: Integer index 85 read GetIntegerProp write SetIntegerProp stored False;
    property ParameterTableVersion: Integer index 84 read GetIntegerProp write SetIntegerProp stored False;
    property NodeNumber: Smallint index 83 read GetSmallintProp write SetSmallintProp stored False;
    property Node: Smallint index 82 read GetSmallintProp write SetSmallintProp stored False;
    property MiscErrorDisable: Integer index 81 read GetIntegerProp write SetIntegerProp stored False;
    property MiscError: Integer index 80 read GetIntegerProp write SetIntegerProp stored False;
    property MintLineExecuting: Integer index 79 read GetIntegerProp write SetIntegerProp stored False;
    property MintExecuting: WordBool index 78 read GetWordBoolProp write SetWordBoolProp stored False;
    property MILErrorOffsetGlobal: Smallint index 77 read GetSmallintProp write SetSmallintProp stored False;
    property Looptime: Smallint index 76 read GetSmallintProp write SetSmallintProp stored False;
    property LogTXEnabled: WordBool index 75 read GetWordBoolProp write SetWordBoolProp stored False;
    property LogRXEnabled: WordBool index 74 read GetWordBoolProp write SetWordBoolProp stored False;
    property LogFilename: WideString index 73 read GetWideStringProp write SetWideStringProp stored False;
    property LogCommsErrors: WordBool index 72 read GetWordBoolProp write SetWordBoolProp stored False;
    property Lifetime: Integer index 71 read GetIntegerProp write SetIntegerProp stored False;
    property LEDDisplay: Integer index 70 read GetIntegerProp write SetIntegerProp stored False;
    property LED: Smallint index 69 read GetSmallintProp write SetSmallintProp stored False;
    property LanguagePack: WideString index 68 read GetWideStringProp write SetWideStringProp stored False;
    property Language: WideString index 67 read GetWideStringProp write SetWideStringProp stored False;
    property KeypadFirmwareVersion: WideString index 66 read GetWideStringProp write SetWideStringProp stored False;
    property InterfaceID: WideString index 65 read GetWideStringProp write SetWideStringProp stored False;
    property InitWarning: Integer index 64 read GetIntegerProp write SetIntegerProp stored False;
    property InitError: Integer index 63 read GetIntegerProp write SetIntegerProp stored False;
    property ICMChannel: Smallint index 62 read GetSmallintProp write SetSmallintProp stored False;
    property GlobalErrorOutput: Smallint index 60 read GetSmallintProp write SetSmallintProp stored False;
    property FirmwareVersion: WideString index 59 read GetWideStringProp write SetWideStringProp stored False;
    property FirmwareMintVMBuild: Smallint index 58 read GetSmallintProp write SetSmallintProp stored False;
    property FirmwareCRC: Integer index 57 read GetIntegerProp write SetIntegerProp stored False;
    property FeedbackFaultEnable: Smallint index 56 read GetSmallintProp write SetSmallintProp stored False;
    property EventPending: Integer index 54 read GetIntegerProp write SetIntegerProp stored False;
    property EventDisable: Integer index 53 read GetIntegerProp write SetIntegerProp stored False;
    property EventActive: Integer index 52 read GetIntegerProp write SetIntegerProp stored False;
    property ErrString: WideString index 51 read GetWideStringProp write SetWideStringProp stored False;
    property ErrParamIndex: Smallint index 50 read GetSmallintProp write SetSmallintProp stored False;
    property ErrParamFamily: Smallint index 49 read GetSmallintProp write SetSmallintProp stored False;
    property ErrLine: Integer index 48 read GetIntegerProp write SetIntegerProp stored False;
    property ErrCode: Integer index 47 read GetIntegerProp write SetIntegerProp stored False;
    property EncoderZActiveLevel: WordBool index 46 read GetWordBoolProp write SetWordBoolProp stored False;
    property EncoderStates: Smallint index 45 read GetSmallintProp write SetSmallintProp stored False;
    property EEPROMSaveBufferStatus: WordBool index 44 read GetWordBoolProp write SetWordBoolProp stored False;
    property DriveUsedDate: WideString index 43 read GetWideStringProp write SetWideStringProp stored False;
    property DriveUsed: Smallint index 42 read GetSmallintProp write SetSmallintProp stored False;
    property DriveTestMode: Smallint index 41 read GetSmallintProp write SetSmallintProp stored False;
    property DriveFeedback: Smallint index 40 read GetSmallintProp write SetSmallintProp stored False;
    property DriveFaultMask: Integer index 39 read GetIntegerProp write SetIntegerProp stored False;
    property DIPSwitches: Smallint index 38 read GetSmallintProp write SetSmallintProp stored False;
    property DeviceOpen: WordBool index 37 read GetWordBoolProp write SetWordBoolProp stored False;
    property CustomerID: Smallint index 36 read GetSmallintProp write SetSmallintProp stored False;
    property CPUClockSpeed: Single index 35 read GetSingleProp write SetSingleProp stored False;
    property CountStatics: Integer index 34 read GetIntegerProp write SetIntegerProp stored False;
    property ControllerType: Smallint index 33 read GetSmallintProp write SetSmallintProp stored False;
    property ControllerPresent: WordBool index 32 read GetWordBoolProp write SetWordBoolProp stored False;
    property ControllerID: WideString index 31 read GetWideStringProp write SetWideStringProp stored False;
    property CommsTestMode: Smallint index 30 read GetSmallintProp write SetSmallintProp stored False;
    property CommsSync: WordBool index 29 read GetWordBoolProp write SetWordBoolProp stored False;
    property CommsMode: Smallint index 28 read GetSmallintProp write SetSmallintProp stored False;
    property CardNumber: Smallint index 27 read GetSmallintProp write SetSmallintProp stored False;
    property CaptureStatus: Smallint index 26 read GetSmallintProp write SetSmallintProp stored False;
    property CapturePreTriggerDuration: Integer index 25 read GetIntegerProp write SetIntegerProp stored False;
    property CapturePeriod: Integer index 24 read GetIntegerProp write SetIntegerProp stored False;
    property CaptureNumPoints: Smallint index 23 read GetSmallintProp write SetSmallintProp stored False;
    property CaptureInterval: Smallint index 22 read GetSmallintProp write SetSmallintProp stored False;
    property CaptureEventDelay: Smallint index 21 read GetSmallintProp write SetSmallintProp stored False;
    property CaptureEventAxis: Smallint index 20 read GetSmallintProp write SetSmallintProp stored False;
    property CaptureEvent: Smallint index 19 read GetSmallintProp write SetSmallintProp stored False;
    property CaptureDuration: Integer index 18 read GetIntegerProp write SetIntegerProp stored False;
    property CaptureCommand: Smallint index 17 read GetSmallintProp write SetSmallintProp stored False;
    property CaptureBufferSize: Integer index 16 read GetIntegerProp write SetIntegerProp stored False;
    property Capture: Smallint index 15 read GetSmallintProp write SetSmallintProp stored False;
    property BusEnable: WordBool index 14 read GetWordBoolProp write SetWordBoolProp stored False;
    property BootloaderDetails: WideString index 12 read GetWideStringProp write SetWideStringProp stored False;
    property BetaBuild: WordBool index 10 read GetWordBoolProp write SetWordBoolProp stored False;
    property BaldorDebug: WordBool index 9 read GetWordBoolProp write SetWordBoolProp stored False;
    property AutotuneStatus: Smallint index 8 read GetSmallintProp write SetSmallintProp stored False;
    property AutotuneError: Smallint index 7 read GetSmallintProp write SetSmallintProp stored False;
    property AsyncErrorPresent: WordBool index 6 read GetWordBoolProp write SetWordBoolProp stored False;
    property AppDataWritePermission: WordBool index 5 read GetWordBoolProp write SetWordBoolProp stored False;
    property APIValueWriteMode: Smallint index 4 read GetSmallintProp write SetSmallintProp stored False;
    property ActiveRS485Node: Smallint index 3 read GetSmallintProp write SetSmallintProp stored False;
    property AAABuild: Integer index 2 read GetIntegerProp write SetIntegerProp stored False;
    property ShowProgressDialogs: WordBool index 1 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnSerialReceiveEvent: TNotifyEvent read FOnSerialReceiveEvent write FOnSerialReceiveEvent;
    property OnTimerEvent: TMintControllerTimerEvent read FOnTimerEvent write FOnTimerEvent;
    property OnFastInEvent: TMintControllerFastInEvent read FOnFastInEvent write FOnFastInEvent;
    property OnErrorEvent: TNotifyEvent read FOnErrorEvent write FOnErrorEvent;
    property OnBusEvent: TMintControllerBusEvent read FOnBusEvent write FOnBusEvent;
    property OnStopSwitchEvent: TNotifyEvent read FOnStopSwitchEvent write FOnStopSwitchEvent;
    property OnInputEvent: TMintControllerInputEvent read FOnInputEvent write FOnInputEvent;
    property OnCommsEvent: TMintControllerCommsEvent read FOnCommsEvent write FOnCommsEvent;
    property OnAxisIdleEvent: TMintControllerAxisIdleEvent read FOnAxisIdleEvent write FOnAxisIdleEvent;
    property OnMoveBufferLowEvent: TMintControllerMoveBufferLowEvent read FOnMoveBufferLowEvent write FOnMoveBufferLowEvent;
    property OnDPREvent: TMintControllerDPREvent read FOnDPREvent write FOnDPREvent;
    property OnUnknownEvent: TMintControllerUnknownEvent read FOnUnknownEvent write FOnUnknownEvent;
    property OnResetEvent: TMintControllerResetEvent read FOnResetEvent write FOnResetEvent;
    property OnKnifeEvent: TMintControllerKnifeEvent read FOnKnifeEvent write FOnKnifeEvent;
    property OnMoveBufferFull: TMintControllerMoveBufferFull read FOnMoveBufferFull write FOnMoveBufferFull;
    property OnUSBDeviceDisconnect: TNotifyEvent read FOnUSBDeviceDisconnect write FOnUSBDeviceDisconnect;
    property OnLatchEvent: TMintControllerLatchEvent read FOnLatchEvent write FOnLatchEvent;
    property OnBusMessageEvent: TMintControllerBusMessageEvent read FOnBusMessageEvent write FOnBusMessageEvent;
    property OnTerminalReceiveEvent: TNotifyEvent read FOnTerminalReceiveEvent write FOnTerminalReceiveEvent;
    property OnStopEvent: TMintControllerStopEvent read FOnStopEvent write FOnStopEvent;
    property OnNetDataEvent: TMintControllerNetDataEvent read FOnNetDataEvent write FOnNetDataEvent;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMintCommandPrompt
// Help String      : Mint Command Prompt Build 5626
// Default Interface: _DCommandPromptCtrl
// Def. Intf. DISP? : Yes
// Event   Interface: _DCommandPromptEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TMintCommandPrompt = class(TOleControl)
  private
    FIntf: _DCommandPromptCtrl;
    function  GetControlInterface: _DCommandPromptCtrl;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure SetSerialControllerLink(nControllerType: Smallint; nNode: Smallint; nPort: Smallint; 
                                      nSpeed: Integer; bOpenPort: WordBool);
    procedure setPCIControllerLink(nControllerType: Smallint; nNode: Smallint; nCard: Smallint);
    procedure setMintControllerID(const sID: WideString);
    procedure setCompiler(nVersion: Integer);
    procedure setSymbolTable(const sTable: WideString);
    procedure AboutBox;
    procedure SetEthernetControllerLink(const lpszAddress: WideString);
    procedure DisplayMacroEditor;
    procedure getContextKeyword(var psKeyword: WideString);
    procedure SetUSBControllerLink(nNode: Smallint);
    procedure setMintController(const pController: IUnknown);
    property  ControlInterface: _DCommandPromptCtrl read GetControlInterface;
    property  DefaultInterface: _DCommandPromptCtrl read GetControlInterface;
  published
    property Anchors;
    property  ParentColor;
    property  ParentFont;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property OverType: WordBool index 1 read GetWordBoolProp write SetWordBoolProp stored False;
    property BorderStyle: Smallint index -504 read GetSmallintProp write SetSmallintProp stored False;
    property ForeColor: TColor index -513 read GetTColorProp write SetTColorProp stored False;
    property Font: TFont index -512 read GetTFontProp write SetTFontProp stored False;
    property BackColor: TColor index -501 read GetTColorProp write SetTColorProp stored False;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TMintTerminal
// Help String      : Mint Terminal Build 5626
// Default Interface: _DMintTerminal
// Def. Intf. DISP? : Yes
// Event   Interface: _DMintTerminalEvents
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TMintTerminal = class(TOleControl)
  private
    FIntf: _DMintTerminal;
    function  GetControlInterface: _DMintTerminal;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    procedure AboutBox;
    procedure SetUSBControllerLink(nNode: Smallint);
    procedure SetSerialControllerLink(nControllerType: Smallint; nNode: Smallint; nPort: Smallint; 
                                      nSpeed: Integer; bOpenPort: WordBool);
    procedure setPCIControllerLink(nControllerType: Smallint; nNode: Smallint; nCard: Smallint);
    procedure SetEthernetControllerLink(const lpszAddress: WideString);
    procedure setMintController(const pController: IUnknown);
    procedure setMintControllerID(const sID: WideString);
    property  ControlInterface: _DMintTerminal read GetControlInterface;
    property  DefaultInterface: _DMintTerminal read GetControlInterface;
  published
    property Anchors;
    property  ParentColor;
    property  ParentFont;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property  OnKeyPress;
    property BackColor: TColor index -501 read GetTColorProp write SetTColorProp stored False;
    property ForeColor: TColor index -513 read GetTColorProp write SetTColorProp stored False;
    property TerminalText: WideString index 5 read GetWideStringProp write SetWideStringProp stored False;
    property Columns: Smallint index 4 read GetSmallintProp write SetSmallintProp stored False;
    property Lines: Smallint index 3 read GetSmallintProp write SetSmallintProp stored False;
    property TerminalFont: TFont index 2 read GetTFontProp write SetTFontProp stored False;
    property AutoFit: WordBool index 1 read GetWordBoolProp write SetWordBoolProp stored False;
  end;

// *********************************************************************//
// The Class CoSinkForServerEvents provides a Create and CreateRemote method to          
// create instances of the default interface ISinkForServerEvents exposed by              
// the CoClass SinkForServerEvents. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSinkForServerEvents = class
    class function Create: ISinkForServerEvents;
    class function CreateRemote(const MachineName: string): ISinkForServerEvents;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSinkForServerEvents
// Help String      : 
// Default Interface: ISinkForServerEvents
// Def. Intf. DISP? : Yes
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSinkForServerEventsProperties= class;
{$ENDIF}
  TSinkForServerEvents = class(TOleServer)
  private
    FIntf: ISinkForServerEvents;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TSinkForServerEventsProperties;
    function GetServerProperties: TSinkForServerEventsProperties;
{$ENDIF}
    function GetDefaultInterface: ISinkForServerEvents;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISinkForServerEvents);
    procedure Disconnect; override;
    property DefaultInterface: ISinkForServerEvents read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSinkForServerEventsProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TSinkForServerEvents
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TSinkForServerEventsProperties = class(TPersistent)
  private
    FServer:    TSinkForServerEvents;
    function    GetDefaultInterface: ISinkForServerEvents;
    constructor Create(AServer: TSinkForServerEvents);
  protected
  public
    property DefaultInterface: ISinkForServerEvents read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoOCXSerialEventSink provides a Create and CreateRemote method to          
// create instances of the default interface IOCXSerialEventSink exposed by              
// the CoClass OCXSerialEventSink. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoOCXSerialEventSink = class
    class function Create: IOCXSerialEventSink;
    class function CreateRemote(const MachineName: string): IOCXSerialEventSink;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TOCXSerialEventSink
// Help String      : 
// Default Interface: IOCXSerialEventSink
// Def. Intf. DISP? : Yes
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TOCXSerialEventSinkProperties= class;
{$ENDIF}
  TOCXSerialEventSink = class(TOleServer)
  private
    FIntf: IOCXSerialEventSink;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TOCXSerialEventSinkProperties;
    function GetServerProperties: TOCXSerialEventSinkProperties;
{$ENDIF}
    function GetDefaultInterface: IOCXSerialEventSink;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IOCXSerialEventSink);
    procedure Disconnect; override;
    property DefaultInterface: IOCXSerialEventSink read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TOCXSerialEventSinkProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TOCXSerialEventSink
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TOCXSerialEventSinkProperties = class(TPersistent)
  private
    FServer:    TOCXSerialEventSink;
    function    GetDefaultInterface: IOCXSerialEventSink;
    constructor Create(AServer: TOCXSerialEventSink);
  protected
  public
    property DefaultInterface: IOCXSerialEventSink read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TMintController.InitControlData;
const
  CEventDispIDs: array [0..20] of DWORD = (
    $00000001, $00000002, $00000003, $00000004, $00000005, $00000006,
    $00000007, $00000008, $00000009, $0000000A, $0000000B, $0000000C,
    $0000000D, $0000000E, $0000000F, $00000010, $00000011, $00000012,
    $00000013, $00000014, $00000015);
  CControlData: TControlData2 = (
    ClassID: '{69CBC9D5-0C78-4CC8-A33C-67B332D3D6BD}';
    EventIID: '{A8A56C0C-FF29-4C7D-9418-EA321AF9A467}';
    EventCount: 21;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnSerialReceiveEvent) - Cardinal(Self);
end;

procedure TMintController.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DMintControllerCtrl;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMintController.GetControlInterface: _DMintControllerCtrl;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TMintController.Set_AccelSensorKInt(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.AccelSensorKInt[nAxis] := Param2;
end;

function TMintController.Get_AccelSensorKProp(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AccelSensorKProp[nAxis];
end;

function TMintController.Get_AccelSensorKInt(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AccelSensorKInt[nAxis];
end;

function TMintController.Get_AccelScaleUnits(nAxis: Smallint): WideString;
begin
    Result := DefaultInterface.AccelScaleUnits[nAxis];
end;

procedure TMintController.Set_AccelScaleUnits(nAxis: Smallint; const Param2: WideString);
  { Warning: The property AccelScaleUnits has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AccelScaleUnits := Param2;
end;

procedure TMintController.Set_AccelSensorEnable(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.AccelSensorEnable[nAxis] := Param2;
end;

function TMintController.Get_ADCErrorMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.ADCErrorMode[nAxis];
end;

procedure TMintController.Set_ADCErrorMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.ADCErrorMode[nAxis] := Param2;
end;

function TMintController.Get_ADCError(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.ADCError[nAxis];
end;

function TMintController.Get_AccelSensorFilterFreq(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AccelSensorFilterFreq[nAxis];
end;

procedure TMintController.Set_AccelSensorFilterFreq(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.AccelSensorFilterFreq[nAxis] := Param2;
end;

procedure TMintController.Set_AccelSensorVelErrorFatal(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.AccelSensorVelErrorFatal[nAxis] := Param2;
end;

function TMintController.Get_AccelSensorDelay(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AccelSensorDelay[nAxis];
end;

procedure TMintController.Set_AccelSensorScale(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.AccelSensorScale[nAxis] := Param2;
end;

function TMintController.Get_AccelSensorVelError(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AccelSensorVelError[nAxis];
end;

function TMintController.Get_AccelSensorVelErrorFatal(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AccelSensorVelErrorFatal[nAxis];
end;

function TMintController.Get_AccelSensorOffset(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AccelSensorOffset[nAxis];
end;

function TMintController.Get_AccelSensorMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AccelSensorMode[nAxis];
end;

procedure TMintController.Set_AccelSensorMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AccelSensorMode[nAxis] := Param2;
end;

procedure TMintController.Set_AccelSensorKProp(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.AccelSensorKProp[nAxis] := Param2;
end;

procedure TMintController.Set_AccelSensorDelay(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AccelSensorDelay[nAxis] := Param2;
end;

function TMintController.Get_AccelSensorEnable(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.AccelSensorEnable[nAxis];
end;

function TMintController.Get_AccelSensorVel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AccelSensorVel[nAxis];
end;

function TMintController.Get_AccelSensorType(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AccelSensorType[nAxis];
end;

procedure TMintController.Set_AccelSensorType(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AccelSensorType[nAxis] := Param2;
end;

function TMintController.Get_ADCDeadbandOffset(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.ADCDeadbandOffset[nChannel];
end;

function TMintController.Get_ADCDeadband(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.ADCDeadband[nChannel];
end;

function TMintController.Get_ActiveEventCodes(nEvent: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ActiveEventCodes;
end;

function TMintController.Get_ADC(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.ADC[nChannel];
end;

procedure TMintController.Set_AccelTimeMax(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.AccelTimeMax[nAxis] := Param2;
end;

procedure TMintController.Set_ADCDeadband(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.ADCDeadband[nChannel] := Param2;
end;

function TMintController.Get_ADCDeadbandHysteresis(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.ADCDeadbandHysteresis[nChannel];
end;

procedure TMintController.Set_AccelSensorVelErrorMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AccelSensorVelErrorMode[nAxis] := Param2;
end;

procedure TMintController.Set_ADCMax(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.ADCMax[nChannel] := Param2;
end;

procedure TMintController.Set_ADCGain(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.ADCGain[nChannel] := Param2;
end;

procedure TMintController.Set_ADCFilter(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.ADCFilter[nChannel] := Param2;
end;

procedure TMintController.Set_ADCDeadbandOffset(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.ADCDeadbandOffset[nChannel] := Param2;
end;

function TMintController.Get_ADCFilter(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.ADCFilter[nChannel];
end;

function TMintController.Get_ADCMax(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.ADCMax[nChannel];
end;

function TMintController.Get_AccelTimeMax(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AccelTimeMax[nAxis];
end;

function TMintController.Get_AccelTime(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AccelTime[nAxis];
end;

function TMintController.Get_AccelSensorVelErrorMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AccelSensorVelErrorMode[nAxis];
end;

function TMintController.Get_ADCGain(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.ADCGain[nChannel];
end;

procedure TMintController.Set_ADCDeadbandHysteresis(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.ADCDeadbandHysteresis[nChannel] := Param2;
end;

procedure TMintController.Set_AccelTime(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.AccelTime[nAxis] := Param2;
end;

function TMintController.Get_AccelSensorScale(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AccelSensorScale[nAxis];
end;

procedure TMintController.Set_RelayOut(nBank: Smallint; Param2: Integer);
begin
  DefaultInterface.RelayOut[nBank] := Param2;
end;

procedure TMintController.Set_RelayOutX(nRelay: Smallint; Param2: WordBool);
begin
  DefaultInterface.RelayOutX[nRelay] := Param2;
end;

function TMintController.Get_RemoteADC(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint): Single;
begin
    Result := DefaultInterface.RemoteADC[nCANBus, nNode, nChannel];
end;

function TMintController.Get_PWMOnTime(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PWMOnTime[nAxis];
end;

procedure TMintController.Set_PWMOnTime(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PWMOnTime[nAxis] := Param2;
end;

function TMintController.Get_ReadKey(nTermID: Integer): Smallint;
begin
    Result := DefaultInterface.ReadKey[nTermID];
end;

function TMintController.Get_RelayOutX(nRelay: Smallint): WordBool;
begin
    Result := DefaultInterface.RelayOutX[nRelay];
end;

function TMintController.Get_RemoteADCDelta(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.RemoteADCDelta[nCANBus, nNode, nChannel];
end;

function TMintController.Get_RelayOutputBankSetup(nBank: Smallint): Smallint;
begin
    Result := DefaultInterface.RelayOutputBankSetup[nBank];
end;

procedure TMintController.Set_RelayOutputBankSetup(nBank: Smallint; Param2: Smallint);
begin
  DefaultInterface.RelayOutputBankSetup[nBank] := Param2;
end;

procedure TMintController.Set_AccelJerkTime(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.AccelJerkTime[nAxis] := Param2;
end;

procedure TMintController.Set_AccelJerk(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.AccelJerk[nAxis] := Param2;
end;

function TMintController.Get_AccelJerkTime(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AccelJerkTime[nAxis];
end;

function TMintController.Get_AccelJerk(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AccelJerk[nAxis];
end;

function TMintController.Get_AccelScaleFactor(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AccelScaleFactor[nAxis];
end;

procedure TMintController.Set_AccelScaleFactor(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.AccelScaleFactor[nAxis] := Param2;
end;

procedure TMintController.Set_AbortMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AbortMode[nAxis] := Param2;
end;

function TMintController.Get_AbortMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AbortMode[nAxis];
end;

procedure TMintController.Set_AbsEncoderSinOffset(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AbsEncoderSinOffset[nAxis] := Param2;
end;

function TMintController.Get_AbsEncoder(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AbsEncoder[nAxis];
end;

function TMintController.Get_AbsEncoderCosOffset(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AbsEncoderCosOffset[nAxis];
end;

procedure TMintController.Set_AbsEncoderTurns(nChannel: Smallint; Param2: Integer);
begin
  DefaultInterface.AbsEncoderTurns[nChannel] := Param2;
end;

function TMintController.Get_AccelDemand(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AccelDemand[nAxis];
end;

function TMintController.Get_Accel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Accel[nAxis];
end;

function TMintController.Get_AbsEncoderTurns(nChannel: Smallint): Integer;
begin
    Result := DefaultInterface.AbsEncoderTurns[nChannel];
end;

procedure TMintController.Set_Accel(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Accel[nAxis] := Param2;
end;

function TMintController.Get_PresetSelectorInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PresetSelectorInput[nAxis];
end;

procedure TMintController.Set_PresetSelectorInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PresetSelectorInput[nAxis] := Param2;
end;

function TMintController.Get_PresetTriggerInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PresetTriggerInput[nAxis];
end;

procedure TMintController.Set_PresetTriggerInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PresetTriggerInput[nAxis] := Param2;
end;

function TMintController.Get_ProfileMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.ProfileMode[nAxis];
end;

procedure TMintController.Set_ProfileMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.ProfileMode[nAxis] := Param2;
end;

function TMintController.Get_PresetJogDirection(nPreset: Smallint): Smallint;
begin
    Result := DefaultInterface.PresetJogDirection[nPreset];
end;

function TMintController.Get_PresetIndexSource(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PresetIndexSource[nAxis];
end;

procedure TMintController.Set_PresetIndexSource(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PresetIndexSource[nAxis] := Param2;
end;

function TMintController.Get_PresetMoveParameter(nPreset: Smallint; nParam: Smallint): Single;
begin
    Result := DefaultInterface.PresetMoveParameter[nPreset, nParam];
end;

procedure TMintController.Set_PresetInputsMax(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PresetInputsMax[nAxis] := Param2;
end;

function TMintController.Get_PresetInputState(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PresetInputState[nAxis];
end;

procedure TMintController.Set_PresetMoveType(nPreset: Smallint; nParam: Smallint; Param3: Smallint);
begin
  DefaultInterface.PresetMoveType[nPreset, nParam] := Param3;
end;

procedure TMintController.Set_RemoteStatus(nCANBus: Smallint; nNode: Smallint; Param3: Smallint);
begin
  DefaultInterface.RemoteStatus[nCANBus, nNode] := Param3;
end;

function TMintController.Get_ResetInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.ResetInput[nAxis];
end;

procedure TMintController.Set_ResetInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.ResetInput[nAxis] := Param2;
end;

function TMintController.Get_RevCountDeadband(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.RevCountDeadband[nAxis];
end;

procedure TMintController.Set_RevCountDeadband(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.RevCountDeadband[nAxis] := Param2;
end;

function TMintController.Get_ScaleFactor(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.ScaleFactor[nAxis];
end;

procedure TMintController.Set_PresetMoveParameter(nPreset: Smallint; nParam: Smallint; 
                                                  Param3: Single);
begin
  DefaultInterface.PresetMoveParameter[nPreset, nParam] := Param3;
end;

function TMintController.Get_PresetMovePosition(nPreset: Smallint): Single;
begin
    Result := DefaultInterface.PresetMovePosition[nPreset];
end;

procedure TMintController.Set_PresetMovePosition(nPreset: Smallint; Param2: Single);
begin
  DefaultInterface.PresetMovePosition[nPreset] := Param2;
end;

function TMintController.Get_PresetMoveSpeed(nPreset: Smallint): Single;
begin
    Result := DefaultInterface.PresetMoveSpeed[nPreset];
end;

procedure TMintController.Set_PresetMoveSpeed(nPreset: Smallint; Param2: Single);
begin
  DefaultInterface.PresetMoveSpeed[nPreset] := Param2;
end;

function TMintController.Get_PresetMoveType(nPreset: Smallint; nParam: Smallint): Smallint;
begin
    Result := DefaultInterface.PresetMoveType[nPreset, nParam];
end;

function TMintController.Get_PresetInputsMax(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PresetInputsMax[nAxis];
end;

procedure TMintController.Set_RemoteEncoder(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint; 
                                            Param4: Integer);
begin
  DefaultInterface.RemoteEncoder[nCANBus, nNode, nChannel] := Param4;
end;

function TMintController.Get_RemoteError(nCANBus: Smallint; nNode: Smallint): Smallint;
begin
    Result := DefaultInterface.RemoteError[nCANBus, nNode];
end;

function TMintController.Get_RemoteDebounce(nCANBus: Smallint; nNode: Smallint): Smallint;
begin
    Result := DefaultInterface.RemoteDebounce[nCANBus, nNode];
end;

procedure TMintController.Set_RemoteComms(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                          Param4: Single);
begin
  DefaultInterface.RemoteComms[nBus, nNode, nIndex] := Param4;
end;

procedure TMintController.Set_RemoteDAC(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint; 
                                        Param4: Single);
begin
  DefaultInterface.RemoteDAC[nCANBus, nNode, nChannel] := Param4;
end;

function TMintController.Get_RemoteEncoder(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint): Integer;
begin
    Result := DefaultInterface.RemoteEncoder[nCANBus, nNode, nChannel];
end;

function TMintController.Get_Relay(nBank: Smallint): WordBool;
begin
    Result := DefaultInterface.Relay[nBank];
end;

procedure TMintController.Set_Relay(nBank: Smallint; Param2: WordBool);
begin
  DefaultInterface.Relay[nBank] := Param2;
end;

function TMintController.Get_RelayOut(nBank: Smallint): Integer;
begin
    Result := DefaultInterface.RelayOut[nBank];
end;

procedure TMintController.Set_RemoteDebounce(nCANBus: Smallint; nNode: Smallint; Param3: Smallint);
begin
  DefaultInterface.RemoteDebounce[nCANBus, nNode] := Param3;
end;

function TMintController.Get_RemoteEmergencyMessage(nCANBus: Smallint; nNode: Smallint): Smallint;
begin
    Result := DefaultInterface.RemoteEmergencyMessage[nCANBus, nNode];
end;

procedure TMintController.Set_RemoteADCDelta(nCANBus: Smallint; nNode: Smallint; 
                                             nChannel: Smallint; Param4: Smallint);
begin
  DefaultInterface.RemoteADCDelta[nCANBus, nNode, nChannel] := Param4;
end;

function TMintController.Get_RemoteComms(nBus: Smallint; nNode: Smallint; nIndex: Smallint): Single;
begin
    Result := DefaultInterface.RemoteComms[nBus, nNode, nIndex];
end;

procedure TMintController.Set_PresetMoveHomeType(nPreset: Smallint; Param2: Smallint);
begin
  DefaultInterface.PresetMoveHomeType[nPreset] := Param2;
end;

function TMintController.Get_PresetJogSpeed(nPreset: Smallint): Single;
begin
    Result := DefaultInterface.PresetJogSpeed[nPreset];
end;

procedure TMintController.Set_PresetJogSpeed(nPreset: Smallint; Param2: Single);
begin
  DefaultInterface.PresetJogSpeed[nPreset] := Param2;
end;

procedure TMintController.Set_PresetJogDirection(nPreset: Smallint; Param2: Smallint);
begin
  DefaultInterface.PresetJogDirection[nPreset] := Param2;
end;

procedure TMintController.Set_PresetMoveEnable(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.PresetMoveEnable[nAxis] := Param2;
end;

function TMintController.Get_PresetMoveHomeType(nPreset: Smallint): Smallint;
begin
    Result := DefaultInterface.PresetMoveHomeType[nPreset];
end;

procedure TMintController.Set_RemoteCommsInteger(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                                 Param4: Integer);
begin
  DefaultInterface.RemoteCommsInteger[nBus, nNode, nIndex] := Param4;
end;

function TMintController.Get_RemoteDAC(nCANBus: Smallint; nNode: Smallint; nChannel: Smallint): Single;
begin
    Result := DefaultInterface.RemoteDAC[nCANBus, nNode, nChannel];
end;

procedure TMintController.Set_RemoteBaud(nCANBus: Smallint; Param2: Integer);
begin
  DefaultInterface.RemoteBaud[nCANBus] := Param2;
end;

function TMintController.Get_PresetMoveEnable(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.PresetMoveEnable[nAxis];
end;

procedure TMintController.Set_PulseOutX(nChannel: Smallint; Param2: Integer);
begin
  DefaultInterface.PulseOutX[nChannel] := Param2;
end;

function TMintController.Get_RemoteCommsInteger(nBus: Smallint; nNode: Smallint; nIndex: Smallint): Integer;
begin
    Result := DefaultInterface.RemoteCommsInteger[nBus, nNode, nIndex];
end;

procedure TMintController.Set_AbsEncoderCosOffset(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AbsEncoderCosOffset[nAxis] := Param2;
end;

procedure TMintController.Set_ADCMode(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.ADCMode[nChannel] := Param2;
end;

procedure TMintController.Set_ADCMin(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.ADCMin[nChannel] := Param2;
end;

function TMintController.Get_ADCMode(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.ADCMode[nChannel];
end;

function TMintController.Get_AnalogOutputSetup(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.AnalogOutputSetup[nChannel];
end;

function TMintController.Get_ADCMonitor(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.ADCMonitor[nAxis];
end;

procedure TMintController.Set_ADCMonitor(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.ADCMonitor[nAxis] := Param2;
end;

procedure TMintController.Set_ADCTimeConstant(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.ADCTimeConstant[nChannel] := Param2;
end;

procedure TMintController.Set_ADCOffset(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.ADCOffset[nChannel] := Param2;
end;

function TMintController.Get_ADCTimeConstant(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.ADCTimeConstant[nChannel];
end;

function TMintController.Get_ADCOffset(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.ADCOffset[nChannel];
end;

function TMintController.Get_AnalogInputSetup(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.AnalogInputSetup[nChannel];
end;

procedure TMintController.Set_AnalogInputSetup(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.AnalogInputSetup[nChannel] := Param2;
end;

procedure TMintController.Set_AutoStartMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AutoStartMode[nAxis] := Param2;
end;

function TMintController.Get_AutoHomeMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AutoHomeMode[nAxis];
end;

function TMintController.Get_APIValue(nTable: Smallint; nFamily: Smallint; nIndex: Smallint; 
                                      vArgs: OleVariant): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.APIValue[nTable, nFamily, nIndex, vArgs];
end;

procedure TMintController.Set_AnalogOutputSetup(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.AnalogOutputSetup[nChannel] := Param2;
end;

procedure TMintController.Set_APIValue(nTable: Smallint; nFamily: Smallint; nIndex: Smallint; 
                                       vArgs: OleVariant; Param5: OleVariant);
begin
  DefaultInterface.APIValue[nTable, nFamily, nIndex, vArgs] := Param5;
end;

function TMintController.Get_AuxDAC(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.AuxDAC[nChannel];
end;

function TMintController.Get_AutotuneParam(nParam: Smallint): Single;
begin
    Result := DefaultInterface.AutotuneParam[nParam];
end;

function TMintController.Get_AutoStartMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AutoStartMode[nAxis];
end;

function TMintController.Get_APIArgumentValues(nTable: Smallint; nArgument: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.APIArgumentValues[nTable, nArgument];
end;

procedure TMintController.Set_AutoHomeMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AutoHomeMode[nAxis] := Param2;
end;

procedure TMintController.Set_AutotuneParam(nParam: Smallint; Param2: Single);
begin
  DefaultInterface.AutotuneParam[nParam] := Param2;
end;

procedure TMintController.Set_AuxDAC(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.AuxDAC[nChannel] := Param2;
end;

procedure TMintController.Set_AuxDACMode(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.AuxDACMode[nChannel] := Param2;
end;

procedure TMintController.Set_AuxEncoderMode(nAuxChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.AuxEncoderMode[nAuxChannel] := Param2;
end;

procedure TMintController.Set_AuxEncoderScale(nAuxChannel: Smallint; Param2: Single);
begin
  DefaultInterface.AuxEncoderScale[nAuxChannel] := Param2;
end;

function TMintController.Get_AuxEncoderMode(nAuxChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.AuxEncoderMode[nAuxChannel];
end;

function TMintController.Get_AuxEncoder(nAuxChannel: Smallint): Single;
begin
    Result := DefaultInterface.AuxEncoder[nAuxChannel];
end;

function TMintController.Get_AuxDACMode(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.AuxDACMode[nChannel];
end;

procedure TMintController.Set_AuxEncoderPreScale(nAuxChannel: Smallint; Param2: Integer);
begin
  DefaultInterface.AuxEncoderPreScale[nAuxChannel] := Param2;
end;

function TMintController.Get_ADCMin(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.ADCMin[nChannel];
end;

procedure TMintController.Set_AccelSensorOffset(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.AccelSensorOffset[nAxis] := Param2;
end;

function TMintController.Get_AuxEncoderSpeed(nAuxChannel: Smallint): Single;
begin
    Result := DefaultInterface.AuxEncoderSpeed[nAuxChannel];
end;

function TMintController.Get_AuxEncoderScale(nAuxChannel: Smallint): Single;
begin
    Result := DefaultInterface.AuxEncoderScale[nAuxChannel];
end;

function TMintController.Get_AuxEncoderPreScale(nAuxChannel: Smallint): Integer;
begin
    Result := DefaultInterface.AuxEncoderPreScale[nAuxChannel];
end;

procedure TMintController.Set_AuxEncoder(nAuxChannel: Smallint; Param2: Single);
begin
  DefaultInterface.AuxEncoder[nAuxChannel] := Param2;
end;

function TMintController.Get_AuxEncoderVel(nAuxChannel: Smallint): Single;
begin
    Result := DefaultInterface.AuxEncoderVel[nAuxChannel];
end;

function TMintController.Get_AuxEncoderWrap(nAuxChannel: Smallint): Single;
begin
    Result := DefaultInterface.AuxEncoderWrap[nAuxChannel];
end;

procedure TMintController.Set_AuxEncoderZeroLatchMode(nAuxChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.AuxEncoderZeroLatchMode[nAuxChannel] := Param2;
end;

procedure TMintController.Set_AuxEncoderZeroEnable(nAuxChannel: Smallint; Param2: WordBool);
begin
  DefaultInterface.AuxEncoderZeroEnable[nAuxChannel] := Param2;
end;

function TMintController.Get_AuxEncoderZeroLatchMode(nAuxChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.AuxEncoderZeroLatchMode[nAuxChannel];
end;

procedure TMintController.Set_AuxEncoderWrap(nAuxChannel: Smallint; Param2: Single);
begin
  DefaultInterface.AuxEncoderWrap[nAuxChannel] := Param2;
end;

function TMintController.Get_AuxEncoderZeroPosition(nAuxChannel: Smallint): Single;
begin
    Result := DefaultInterface.AuxEncoderZeroPosition[nAuxChannel];
end;

function TMintController.Get_AuxEncoderZLatch(nAuxChannel: Smallint): WordBool;
begin
    Result := DefaultInterface.AuxEncoderZLatch[nAuxChannel];
end;

procedure TMintController.Set_AuxEncoderSpeed(nAuxChannel: Smallint; Param2: Single);
begin
  DefaultInterface.AuxEncoderSpeed[nAuxChannel] := Param2;
end;

function TMintController.Get_AxisADC(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AxisADC[nAxis];
end;

procedure TMintController.Set_AxisADC(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AxisADC[nAxis] := Param2;
end;

function TMintController.Get_AverageVel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.AverageVel[nAxis];
end;

function TMintController.Get_AbsEncoderOffset(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AbsEncoderOffset[nAxis];
end;

procedure TMintController.Set_AbsEncoderOffset(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.AbsEncoderOffset[nAxis] := Param2;
end;

procedure TMintController.Set_AbsEncoderSinGain(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AbsEncoderSinGain[nAxis] := Param2;
end;

function TMintController.Get_AbsEncoderSinOffset(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AbsEncoderSinOffset[nAxis];
end;

function TMintController.Get_AbsEncoderSinGain(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AbsEncoderSinGain[nAxis];
end;

procedure TMintController.Set_AxisPosEncoder(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AxisPosEncoder[nAxis] := Param2;
end;

procedure TMintController.Set_AxisSyncDelay(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.AxisSyncDelay[nAxis] := Param2;
end;

procedure TMintController.Set_AxisWarning(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.AxisWarning[nAxis] := Param2;
end;

function TMintController.Get_AxisSyncDelay(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AxisSyncDelay[nAxis];
end;

function TMintController.Get_AxisStatus(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AxisStatus[nAxis];
end;

function TMintController.Get_AxisPosEncoder(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AxisPosEncoder[nAxis];
end;

procedure TMintController.Set_AxisVelEncoder(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AxisVelEncoder[nAxis] := Param2;
end;

procedure TMintController.Set_AxisPDOutput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AxisPDOutput[nAxis] := Param2;
end;

procedure TMintController.Set_AxisDAC(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AxisDAC[nAxis] := Param2;
end;

function TMintController.Get_AxisWarningDisable(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AxisWarningDisable[nAxis];
end;

function TMintController.Get_AxisWarning(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AxisWarning[nAxis];
end;

function TMintController.Get_AxisVelEncoder(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AxisVelEncoder[nAxis];
end;

function TMintController.Get_AxisStatusWord(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AxisStatusWord[nAxis];
end;

procedure TMintController.Set_Cam(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.Cam[nAxis] := Param2;
end;

function TMintController.Get_CamAmplitude(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.CamAmplitude[nAxis];
end;

function TMintController.Get_CamEnd(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.CamEnd[nAxis];
end;

function TMintController.Get_CamBox(nCamBox: Smallint): Smallint;
begin
    Result := DefaultInterface.CamBox[nCamBox];
end;

procedure TMintController.Set_CamBox(nCamBox: Smallint; Param2: Smallint);
begin
  DefaultInterface.CamBox[nCamBox] := Param2;
end;

procedure TMintController.Set_CamAmplitude(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.CamAmplitude[nAxis] := Param2;
end;

procedure TMintController.Set_CamEnd(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.CamEnd[nAxis] := Param2;
end;

function TMintController.Get_CamIndex(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.CamIndex[nAxis];
end;

procedure TMintController.Set_BusBaud(nBusID: Smallint; Param2: Integer);
begin
  DefaultInterface.BusBaud[nBusID] := Param2;
end;

function TMintController.Get_CamStart(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.CamStart[nAxis];
end;

procedure TMintController.Set_CamStart(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.CamStart[nAxis] := Param2;
end;

function TMintController.Get_CamPhaseStatus(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.CamPhaseStatus[nAxis];
end;

function TMintController.Get_AxisError(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AxisError[nAxis];
end;

procedure TMintController.Set_BurnInParameter(nParam: Smallint; Param2: Single);
begin
  DefaultInterface.BurnInParameter[nParam] := Param2;
end;

function TMintController.Get_BusBaud(nBusID: Smallint): Integer;
begin
    Result := DefaultInterface.BusBaud[nBusID];
end;

function TMintController.Get_BurnInParameter(nParam: Smallint): Single;
begin
    Result := DefaultInterface.BurnInParameter[nParam];
end;

function TMintController.Get_BridgeCompEnable(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.BridgeCompEnable[nAxis];
end;

procedure TMintController.Set_BridgeCompEnable(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.BridgeCompEnable[nAxis] := Param2;
end;

procedure TMintController.Set_BridgeErrorVoltage(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.BridgeErrorVoltage[nAxis] := Param2;
end;

procedure TMintController.Set_BacklashInterval(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.BacklashInterval[nAxis] := Param2;
end;

function TMintController.Get_BacklashMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.BacklashMode[nAxis];
end;

function TMintController.Get_BacklashInterval(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.BacklashInterval[nAxis];
end;

function TMintController.Get_BufferDepth(nBuffer: Smallint; nParam: Smallint): Integer;
begin
    Result := DefaultInterface.BufferDepth[nBuffer, nParam];
end;

procedure TMintController.Set_BufferDepth(nBuffer: Smallint; nParam: Smallint; Param3: Integer);
begin
  DefaultInterface.BufferDepth[nBuffer, nParam] := Param3;
end;

procedure TMintController.Set_Boost(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.Boost[nAxis] := Param2;
end;

function TMintController.Get_BridgeErrorCurrent(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.BridgeErrorCurrent[nAxis];
end;

procedure TMintController.Set_AxisError(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.AxisError[nAxis] := Param2;
end;

function TMintController.Get_AxisNode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AxisNode[nAxis];
end;

function TMintController.Get_AxisPDOutput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AxisPDOutput[nAxis];
end;

function TMintController.Get_AxisDAC(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AxisDAC[nAxis];
end;

function TMintController.Get_AxisChannel(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AxisChannel[nAxis];
end;

procedure TMintController.Set_AxisChannel(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.AxisChannel[nAxis] := Param2;
end;

procedure TMintController.Set_AxisWarningDisable(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.AxisWarningDisable[nAxis] := Param2;
end;

procedure TMintController.Set_BridgeErrorCurrent(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.BridgeErrorCurrent[nAxis] := Param2;
end;

function TMintController.Get_BridgeErrorVoltage(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.BridgeErrorVoltage[nAxis];
end;

function TMintController.Get_AxisMode(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AxisMode[nAxis];
end;

function TMintController.Get_AxisErrorLogMask(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.AxisErrorLogMask[nAxis];
end;

procedure TMintController.Set_AxisErrorLogMask(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.AxisErrorLogMask[nAxis] := Param2;
end;

procedure TMintController.Set_BusProcessDataInterval(nBusID: Smallint; Param2: Smallint);
begin
  DefaultInterface.BusProcessDataInterval[nBusID] := Param2;
end;

procedure TMintController.Set_BusProcessData(nBus: Smallint; bIn: WordBool; nChannel: Smallint; 
                                             Param4: Smallint);
begin
  DefaultInterface.BusProcessData[nBus, bIn, nChannel] := Param4;
end;

procedure TMintController.Set_BusPDOMapContent(nBus: Smallint; nNode: Smallint; bIn: WordBool; 
                                               nPeerNode: Smallint; nSlot: Smallint; 
                                               Param6: OleVariant);
begin
  DefaultInterface.BusPDOMapContent[nBus, nNode, bIn, nPeerNode, nSlot] := Param6;
end;

procedure TMintController.Set_DriveSpeedFatal(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DriveSpeedFatal[nAxis] := Param2;
end;

function TMintController.Get_DriveSpeedMax(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveSpeedMax[nAxis];
end;

function TMintController.Get_BusProcessDataInterval(nBusID: Smallint): Smallint;
begin
    Result := DefaultInterface.BusProcessDataInterval[nBusID];
end;

function TMintController.Get_BusTelegramDiagnosticStrings(nBusID: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.BusTelegramDiagnosticStrings;
end;

function TMintController.Get_BusState(nBusID: Smallint): Smallint;
begin
    Result := DefaultInterface.BusState[nBusID];
end;

procedure TMintController.Set_BusProcessDataParameter(nBus: Smallint; bIn: WordBool; 
                                                      nChannel: Smallint; Param4: Smallint);
begin
  DefaultInterface.BusProcessDataParameter[nBus, bIn, nChannel] := Param4;
end;

function TMintController.Get_BusProcessData(nBus: Smallint; bIn: WordBool; nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.BusProcessData[nBus, bIn, nChannel];
end;

function TMintController.Get_BusProcessDataParameter(nBus: Smallint; bIn: WordBool; 
                                                     nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.BusProcessDataParameter[nBus, bIn, nChannel];
end;

function TMintController.Get_BusTelegramDiagnostics(nBusID: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.BusTelegramDiagnostics;
end;

procedure TMintController.Set_DriveSpeedMax(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DriveSpeedMax[nAxis] := Param2;
end;

function TMintController.Get_DriveSpeedMaxRPM(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveSpeedMaxRPM[nAxis];
end;

procedure TMintController.Set_DriveRatingZone(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveRatingZone[nAxis] := Param2;
end;

function TMintController.Get_DriveRatingZoneInfo(nAxis: Smallint; nZone: Smallint; nParam: Smallint): Single;
begin
    Result := DefaultInterface.DriveRatingZoneInfo[nAxis, nZone, nParam];
end;

function TMintController.Get_EEPROMData(nAddress: Smallint): Smallint;
begin
    Result := DefaultInterface.EEPROMData[nAddress];
end;

procedure TMintController.Set_DriveUnderloadWarning(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DriveUnderloadWarning[nAxis] := Param2;
end;

function TMintController.Get_DriveVolts(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveVolts[nAxis];
end;

function TMintController.Get_DriveSpeedFatal(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveSpeedFatal[nAxis];
end;

function TMintController.Get_DriveSpeedMaxmmps(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveSpeedMaxmmps[nAxis];
end;

procedure TMintController.Set_DriveSpeedMaxmmps(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DriveSpeedMaxmmps[nAxis] := Param2;
end;

function TMintController.Get_DriveRatingZone(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveRatingZone[nAxis];
end;

function TMintController.Get_DriveRatedCurrent(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveRatedCurrent[nAxis];
end;

function TMintController.Get_DriveRatedHorsePower(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveRatedHorsePower[nAxis];
end;

function TMintController.Get_BusProtocol(nBus: Smallint): Smallint;
begin
    Result := DefaultInterface.BusProtocol[nBus];
end;

procedure TMintController.Set_CANBaud(nCANBus: Smallint; Param2: Integer);
begin
  DefaultInterface.CANBaud[nCANBus] := Param2;
end;

function TMintController.Get_CANBusState(nCANBus: Smallint): Smallint;
begin
    Result := DefaultInterface.CANBusState[nCANBus];
end;

procedure TMintController.Set_CaptureAxis(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.CaptureAxis[nChannel] := Param2;
end;

function TMintController.Get_CANEventInfo(nCANBus: Smallint): Smallint;
begin
    Result := DefaultInterface.CANEventInfo[nCANBus];
end;

function TMintController.Get_CaptureAxis(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.CaptureAxis[nChannel];
end;

function TMintController.Get_CANEvent(nCANBus: Smallint): Smallint;
begin
    Result := DefaultInterface.CANEvent[nCANBus];
end;

function TMintController.Get_CaptureHSMode(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.CaptureHSMode[nChannel];
end;

procedure TMintController.Set_CaptureHSMode(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.CaptureHSMode[nChannel] := Param2;
end;

function TMintController.Get_CANBaud(nCANBus: Smallint): Integer;
begin
    Result := DefaultInterface.CANBaud[nCANBus];
end;

procedure TMintController.Set_CaptureMode(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.CaptureMode[nChannel] := Param2;
end;

function TMintController.Get_CaptureModeParameter(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.CaptureModeParameter[nAxis];
end;

function TMintController.Get_CaptureMode(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.CaptureMode[nChannel];
end;

function TMintController.Get_Cam(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.Cam[nAxis];
end;

procedure TMintController.Set_BusCommandMask(nFieldbus: Smallint; Param2: Smallint);
begin
  DefaultInterface.BusCommandMask[nFieldbus] := Param2;
end;

function TMintController.Get_BusBaudsSupported(nBus: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.BusBaudsSupported;
end;

function TMintController.Get_BusCommandMask(nFieldbus: Smallint): Smallint;
begin
    Result := DefaultInterface.BusCommandMask[nFieldbus];
end;

function TMintController.Get_BusPDOMapContent(nBus: Smallint; nNode: Smallint; bIn: WordBool; 
                                              nPeerNode: Smallint; nSlot: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.BusPDOMapContent[nBus, nNode, bIn, nPeerNode, nSlot];
end;

function TMintController.Get_BusCycleRate(nBus: Smallint): Smallint;
begin
    Result := DefaultInterface.BusCycleRate[nBus];
end;

procedure TMintController.Set_BusCycleRate(nBus: Smallint; Param2: Smallint);
begin
  DefaultInterface.BusCycleRate[nBus] := Param2;
end;

procedure TMintController.Set_BusMessageMode(nBus: Smallint; Param2: Smallint);
begin
  DefaultInterface.BusMessageMode[nBus] := Param2;
end;

function TMintController.Get_BusEventInfo(nBusID: Smallint): Smallint;
begin
    Result := DefaultInterface.BusEventInfo[nBusID];
end;

function TMintController.Get_BusMessageMode(nBus: Smallint): Smallint;
begin
    Result := DefaultInterface.BusMessageMode[nBus];
end;

function TMintController.Get_BusEvent(nBusID: Smallint): Smallint;
begin
    Result := DefaultInterface.BusEvent[nBusID];
end;

function TMintController.Get_BusNode(nBus: Smallint): Smallint;
begin
    Result := DefaultInterface.BusNode[nBus];
end;

procedure TMintController.Set_BusNode(nBus: Smallint; Param2: Smallint);
begin
  DefaultInterface.BusNode[nBus] := Param2;
end;

function TMintController.Get_Backlash(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Backlash[nAxis];
end;

function TMintController.Get_CaptureProgress(bPostTrigger: WordBool): Smallint;
begin
    Result := DefaultInterface.CaptureProgress[bPostTrigger];
end;

function TMintController.Get_CaptureTriggerAbsolute(nTrigger: Smallint): WordBool;
begin
    Result := DefaultInterface.CaptureTriggerAbsolute[nTrigger];
end;

function TMintController.Get_CapturePoint(nChannel: Smallint; nIndex: Smallint): Single;
begin
    Result := DefaultInterface.CapturePoint[nChannel, nIndex];
end;

procedure TMintController.Set_CommandRefSource(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.CommandRefSource[nAxis] := Param2;
end;

function TMintController.Get_CommandRefSourceParameter(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.CommandRefSourceParameter[nAxis];
end;

procedure TMintController.Set_CaptureTriggerSource(nTrigger: Smallint; Param2: Smallint);
begin
  DefaultInterface.CaptureTriggerSource[nTrigger] := Param2;
end;

procedure TMintController.Set_CaptureTriggerMode(nTrigger: Smallint; Param2: Smallint);
begin
  DefaultInterface.CaptureTriggerMode[nTrigger] := Param2;
end;

function TMintController.Get_CaptureTriggerSource(nTrigger: Smallint): Smallint;
begin
    Result := DefaultInterface.CaptureTriggerSource[nTrigger];
end;

function TMintController.Get_CaptureTriggerMode(nTrigger: Smallint): Smallint;
begin
    Result := DefaultInterface.CaptureTriggerMode[nTrigger];
end;

procedure TMintController.Set_CaptureModeParameter(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.CaptureModeParameter[nAxis] := Param2;
end;

function TMintController.Get_CaptureModeName(nChannel: Smallint): WideString;
begin
    Result := DefaultInterface.CaptureModeName[nChannel];
end;

procedure TMintController.Set_CaptureTriggerAbsolute(nTrigger: Smallint; Param2: WordBool);
begin
  DefaultInterface.CaptureTriggerAbsolute[nTrigger] := Param2;
end;

procedure TMintController.Set_CommandRefSourceParameter(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.CommandRefSourceParameter[nAxis] := Param2;
end;

procedure TMintController.Set_CompareMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.CompareMode[nAxis] := Param2;
end;

function TMintController.Get_Coil(nCoil: Smallint): WordBool;
begin
    Result := DefaultInterface.Coil[nCoil];
end;

procedure TMintController.Set_Coil(nCoil: Smallint; Param2: WordBool);
begin
  DefaultInterface.Coil[nCoil] := Param2;
end;

function TMintController.Get_CurrentLimit(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.CurrentLimit[nAxis];
end;

procedure TMintController.Set_ControlRefSourceStartup(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.ControlRefSourceStartup[nAxis] := Param2;
end;

function TMintController.Get_CurrentDemand(nAxis: Smallint; nChannel: Smallint): Single;
begin
    Result := DefaultInterface.CurrentDemand[nAxis, nChannel];
end;

function TMintController.Get_CommandRefSource(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.CommandRefSource[nAxis];
end;

function TMintController.Get_Commissioned(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.Commissioned[nAxis];
end;

procedure TMintController.Set_Commissioned(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.Commissioned[nAxis] := Param2;
end;

function TMintController.Get_ChannelType(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.ChannelType[nChannel];
end;

function TMintController.Get_CaptureTriggerValue(nTrigger: Smallint): Single;
begin
    Result := DefaultInterface.CaptureTriggerValue[nTrigger];
end;

procedure TMintController.Set_CaptureTriggerValue(nTrigger: Smallint; Param2: Single);
begin
  DefaultInterface.CaptureTriggerValue[nTrigger] := Param2;
end;

function TMintController.Get_CaptureTriggerChannel(nTrigger: Smallint): Smallint;
begin
    Result := DefaultInterface.CaptureTriggerChannel[nTrigger];
end;

function TMintController.Get_CommsInteger(nIndex: Smallint): Integer;
begin
    Result := DefaultInterface.CommsInteger[nIndex];
end;

procedure TMintController.Set_Comms(nIndex: Smallint; Param2: Single);
begin
  DefaultInterface.Comms[nIndex] := Param2;
end;

function TMintController.Get_CommsControllerData(nEnum: Smallint; nParam: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.CommsControllerData[nEnum, nParam];
end;

procedure TMintController.Set_CommsMultiple(nIndex: Smallint; nCount: Smallint; Param3: OleVariant);
begin
  DefaultInterface.CommsMultiple[nIndex, nCount] := Param3;
end;

procedure TMintController.Set_CommsInteger(nIndex: Smallint; Param2: Integer);
begin
  DefaultInterface.CommsInteger[nIndex] := Param2;
end;

function TMintController.Get_CommsMapDataType(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.CommsMapDataType[nAxis];
end;

function TMintController.Get_CommsMapParameter(nIndex: Smallint): Smallint;
begin
    Result := DefaultInterface.CommsMapParameter[nIndex];
end;

function TMintController.Get_CommsMapMode(nIndex: Smallint): Smallint;
begin
    Result := DefaultInterface.CommsMapMode[nIndex];
end;

procedure TMintController.Set_CommsMapMode(nIndex: Smallint; Param2: Smallint);
begin
  DefaultInterface.CommsMapMode[nIndex] := Param2;
end;

procedure TMintController.Set_CommsMapDataType(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.CommsMapDataType[nAxis] := Param2;
end;

procedure TMintController.Set_CommsMapParameter(nIndex: Smallint; Param2: Smallint);
begin
  DefaultInterface.CommsMapParameter[nIndex] := Param2;
end;

function TMintController.Get_CommsMultiple(nIndex: Smallint; nCount: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.CommsMultiple[nIndex, nCount];
end;

procedure TMintController.Set_CompareEnable(nOutput: Smallint; Param2: WordBool);
begin
  DefaultInterface.CompareEnable[nOutput] := Param2;
end;

function TMintController.Get_CommsTestParameter(nParameter: Smallint): Single;
begin
    Result := DefaultInterface.CommsTestParameter[nParameter];
end;

function TMintController.Get_CommsRemote(nNode: Smallint; nIndex: Smallint): Single;
begin
    Result := DefaultInterface.CommsRemote[nNode, nIndex];
end;

function TMintController.Get_CommsMultipleRemote(nNode: Smallint; nIndex: Smallint; nCount: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.CommsMultipleRemote[nNode, nIndex, nCount];
end;

procedure TMintController.Set_CaptureTriggerChannel(nTrigger: Smallint; Param2: Smallint);
begin
  DefaultInterface.CaptureTriggerChannel[nTrigger] := Param2;
end;

function TMintController.Get_Comms(nIndex: Smallint): Single;
begin
    Result := DefaultInterface.Comms[nIndex];
end;

procedure TMintController.Set_CommsRemote(nNode: Smallint; nIndex: Smallint; Param3: Single);
begin
  DefaultInterface.CommsRemote[nNode, nIndex] := Param3;
end;

function TMintController.Get_CompareMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.CompareMode[nAxis];
end;

function TMintController.Get_CompareLatch(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.CompareLatch[nAxis];
end;

function TMintController.Get_CompareEnable(nOutput: Smallint): WordBool;
begin
    Result := DefaultInterface.CompareEnable[nOutput];
end;

procedure TMintController.Set_CommsMultipleRemote(nNode: Smallint; nIndex: Smallint; 
                                                  nCount: Smallint; Param4: OleVariant);
begin
  DefaultInterface.CommsMultipleRemote[nNode, nIndex, nCount] := Param4;
end;

procedure TMintController.Set_CommsTestParameter(nParameter: Smallint; Param2: Single);
begin
  DefaultInterface.CommsTestParameter[nParameter] := Param2;
end;

procedure TMintController.Set_CompareLatch(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.CompareLatch[nAxis] := Param2;
end;

function TMintController.Get_ControllerData(nEnum: Smallint; nParam: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ControllerData[nEnum, nParam];
end;

function TMintController.Get_ControlMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.ControlMode[nAxis];
end;

procedure TMintController.Set_ContourAngle(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.ContourAngle[nAxis] := Param2;
end;

function TMintController.Get_ControlModeStartup(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.ControlModeStartup[nAxis];
end;

procedure TMintController.Set_ControlModeStartup(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.ControlModeStartup[nAxis] := Param2;
end;

procedure TMintController.Set_ControlMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.ControlMode[nAxis] := Param2;
end;

function TMintController.Get_CompareOutput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.CompareOutput[nAxis];
end;

procedure TMintController.Set_CompareOutput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.CompareOutput[nAxis] := Param2;
end;

procedure TMintController.Set_Config(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.Config[nAxis] := Param2;
end;

procedure TMintController.Set_ComparePos(nAxis: Smallint; nRegister: Smallint; Param3: Single);
begin
  DefaultInterface.ComparePos[nAxis, nRegister] := Param3;
end;

function TMintController.Get_Config(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.Config[nAxis];
end;

function TMintController.Get_ComparePos(nAxis: Smallint; nRegister: Smallint): Single;
begin
    Result := DefaultInterface.ComparePos[nAxis, nRegister];
end;

procedure TMintController.Set_ContourRatio(nAxis1: Smallint; nAxis2: Smallint; Param3: Single);
begin
  DefaultInterface.ContourRatio[nAxis1, nAxis2] := Param3;
end;

function TMintController.Get_Boost(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.Boost[nAxis];
end;

function TMintController.Get_BlendMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.BlendMode[nAxis];
end;

function TMintController.Get_BlendDistance(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.BlendDistance[nAxis];
end;

procedure TMintController.Set_Backlash(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Backlash[nAxis] := Param2;
end;

procedure TMintController.Set_BacklashMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.BacklashMode[nAxis] := Param2;
end;

procedure TMintController.Set_BlendMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.BlendMode[nAxis] := Param2;
end;

function TMintController.Get_ContourParameter(nAxis: Smallint; nParam: Smallint): Single;
begin
    Result := DefaultInterface.ContourParameter[nAxis, nParam];
end;

function TMintController.Get_ContourMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.ContourMode[nAxis];
end;

procedure TMintController.Set_ContourMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.ContourMode[nAxis] := Param2;
end;

procedure TMintController.Set_BlendDistance(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.BlendDistance[nAxis] := Param2;
end;

procedure TMintController.Set_ContourParameter(nAxis: Smallint; nParam: Smallint; Param3: Single);
begin
  DefaultInterface.ContourParameter[nAxis, nParam] := Param3;
end;

function TMintController.Get_ContourRatio(nAxis1: Smallint; nAxis2: Smallint): Single;
begin
    Result := DefaultInterface.ContourRatio[nAxis1, nAxis2];
end;

function TMintController.Get_ConnectStatus(nCANBus: Smallint; nFromNode: Smallint): Smallint;
begin
    Result := DefaultInterface.ConnectStatus[nCANBus, nFromNode];
end;

function TMintController.Get_DAC(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.DAC[nChannel];
end;

function TMintController.Get_ControlRefSource(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.ControlRefSource[nAxis];
end;

procedure TMintController.Set_ControlRefSource(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.ControlRefSource[nAxis] := Param2;
end;

procedure TMintController.Set_DACMonitorAxis(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.DACMonitorAxis[nChannel] := Param2;
end;

procedure TMintController.Set_DACMonitorAbsolute(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.DACMonitorAbsolute[nChannel] := Param2;
end;

function TMintController.Get_DACMonitorAxis(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.DACMonitorAxis[nChannel];
end;

function TMintController.Get_ControlRefSourceStartup(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.ControlRefSourceStartup[nAxis];
end;

procedure TMintController.Set_CurrentLimit(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.CurrentLimit[nAxis] := Param2;
end;

function TMintController.Get_CurrentMeas(nAxis: Smallint; nChannel: Smallint): Single;
begin
    Result := DefaultInterface.CurrentMeas[nAxis, nChannel];
end;

procedure TMintController.Set_ControlRefChannel(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.ControlRefChannel[nAxis] := Param2;
end;

procedure TMintController.Set_ControlRate(nAxis: Smallint; nChannel: Smallint; Param3: Integer);
begin
  DefaultInterface.ControlRate[nAxis, nChannel] := Param3;
end;

function TMintController.Get_ControlRefChannel(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.ControlRefChannel[nAxis];
end;

procedure TMintController.Set_DACMonitorGain(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.DACMonitorGain[nChannel] := Param2;
end;

procedure TMintController.Set_Connect(nCANBus: Smallint; nFromNode: Smallint; nToNode: Smallint; 
                                      Param4: Smallint);
begin
  DefaultInterface.Connect[nCANBus, nFromNode, nToNode] := Param4;
end;

function TMintController.Get_ControlRate(nAxis: Smallint; nChannel: Smallint): Integer;
begin
    Result := DefaultInterface.ControlRate[nAxis, nChannel];
end;

function TMintController.Get_DACMode(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.DACMode[nChannel];
end;

function TMintController.Get_ContourAngle(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.ContourAngle[nAxis];
end;

function TMintController.Get_ConnectInfo(nBus: Smallint; nFromNode: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ConnectInfo[nBus, nFromNode];
end;

function TMintController.Get_Connect(nCANBus: Smallint; nFromNode: Smallint; nToNode: Smallint): Smallint;
begin
    Result := DefaultInterface.Connect[nCANBus, nFromNode, nToNode];
end;

function TMintController.Get_DACLimitMax(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.DACLimitMax[nChannel];
end;

function TMintController.Get_DACMonitorAbsolute(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.DACMonitorAbsolute[nChannel];
end;

function TMintController.Get_DACMonitorGain(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.DACMonitorGain[nChannel];
end;

procedure TMintController.Set_DACMode(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.DACMode[nChannel] := Param2;
end;

procedure TMintController.Set_DACLimitMax(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.DACLimitMax[nChannel] := Param2;
end;

procedure TMintController.Set_DAC(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.DAC[nChannel] := Param2;
end;

function TMintController.Get_Effort(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Effort[nAxis];
end;

procedure TMintController.Set_DriveData(nTransaction: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveData[nTransaction] := Param2;
end;

function TMintController.Get_DriveEnable(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.DriveEnable[nAxis];
end;

function TMintController.Get_DriveData(nTransaction: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveData[nTransaction];
end;

function TMintController.Get_DriveFault(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveFault[nAxis];
end;

function TMintController.Get_DriveFeedbackSource(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveFeedbackSource[nAxis];
end;

procedure TMintController.Set_DriveEnableOutput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveEnableOutput[nAxis] := Param2;
end;

procedure TMintController.Set_DriveEnableMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveEnableMode[nAxis] := Param2;
end;

function TMintController.Get_DriveEnableOutput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveEnableOutput[nAxis];
end;

function TMintController.Get_DriveEnableMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveEnableMode[nAxis];
end;

procedure TMintController.Set_DriveBusUnderVolts(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveBusUnderVolts[nAxis] := Param2;
end;

function TMintController.Get_DriveBusVolts(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveBusVolts[nAxis];
end;

procedure TMintController.Set_DriveEnable(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.DriveEnable[nAxis] := Param2;
end;

procedure TMintController.Set_DriveFeedbackSource(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveFeedbackSource[nAxis] := Param2;
end;

function TMintController.Get_DriveBusUnderVolts(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveBusUnderVolts[nAxis];
end;

function TMintController.Get_DriveErrorLogMask(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.DriveErrorLogMask[nAxis];
end;

procedure TMintController.Set_DriveErrorLogMask(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.DriveErrorLogMask[nAxis] := Param2;
end;

function TMintController.Get_DiagnosticString(nChannel: Smallint): WideString;
begin
    Result := DefaultInterface.DiagnosticString[nChannel];
end;

function TMintController.Get_DiagnosticParameter(nGroup: Smallint; nParameter: Smallint): Single;
begin
    Result := DefaultInterface.DiagnosticParameter[nGroup, nParameter];
end;

procedure TMintController.Set_DiagnosticParameter(nGroup: Smallint; nParameter: Smallint; 
                                                  Param3: Single);
begin
  DefaultInterface.DiagnosticParameter[nGroup, nParameter] := Param3;
end;

function TMintController.Get_DriveErrorString(nErrorCode: Smallint): WideString;
begin
    Result := DefaultInterface.DriveErrorString[nErrorCode];
end;

function TMintController.Get_DriveOkOutput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveOkOutput[nAxis];
end;

procedure TMintController.Set_DriveOkOutput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveOkOutput[nAxis] := Param2;
end;

procedure TMintController.Set_DriveError(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveError[nAxis] := Param2;
end;

function TMintController.Get_DriveEnableSwitch(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.DriveEnableSwitch[nAxis];
end;

function TMintController.Get_DriveError(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveError[nAxis];
end;

function TMintController.Get_DriveEnableInputMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveEnableInputMode[nAxis];
end;

function TMintController.Get_DACMonitorModeParameter(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.DACMonitorModeParameter[nChannel];
end;

function TMintController.Get_DACMonitorMode(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.DACMonitorMode[nChannel];
end;

procedure TMintController.Set_DACMonitorMode(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.DACMonitorMode[nChannel] := Param2;
end;

procedure TMintController.Set_DACRamp(nChannel: Smallint; Param2: Integer);
begin
  DefaultInterface.DACRamp[nChannel] := Param2;
end;

procedure TMintController.Set_DACMonitorModeParameter(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.DACMonitorModeParameter[nChannel] := Param2;
end;

function TMintController.Get_DACMonitorOffset(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.DACMonitorOffset[nChannel];
end;

function TMintController.Get_DACOffset(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.DACOffset[nChannel];
end;

function TMintController.Get_DACMonitorScale(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.DACMonitorScale[nChannel];
end;

procedure TMintController.Set_DACMonitorScale(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.DACMonitorScale[nChannel] := Param2;
end;

procedure TMintController.Set_DACMonitorOffset(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.DACMonitorOffset[nChannel] := Param2;
end;

procedure TMintController.Set_DACOffset(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.DACOffset[nChannel] := Param2;
end;

function TMintController.Get_DACRamp(nChannel: Smallint): Integer;
begin
    Result := DefaultInterface.DACRamp[nChannel];
end;

procedure TMintController.Set_DBExtAvgPower(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DBExtAvgPower[nAxis] := Param2;
end;

function TMintController.Get_DBEnable(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.DBEnable[nAxis];
end;

function TMintController.Get_DBDelay(nAxis: Smallint; nChannel: Smallint): Single;
begin
    Result := DefaultInterface.DBDelay[nAxis, nChannel];
end;

function TMintController.Get_DBConfig(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DBConfig[nAxis];
end;

procedure TMintController.Set_DriveEnableInputMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveEnableInputMode[nAxis] := Param2;
end;

function TMintController.Get_DecelTime(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.DecelTime[nAxis];
end;

procedure TMintController.Set_DBDelay(nAxis: Smallint; nChannel: Smallint; Param3: Single);
begin
  DefaultInterface.DBDelay[nAxis, nChannel] := Param3;
end;

function TMintController.Get_DBExtPeakPower(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DBExtPeakPower[nAxis];
end;

function TMintController.Get_DBExtPeakDuration(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DBExtPeakDuration[nAxis];
end;

function TMintController.Get_DBExtAvgPower(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DBExtAvgPower[nAxis];
end;

procedure TMintController.Set_DBConfig(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DBConfig[nAxis] := Param2;
end;

procedure TMintController.Set_DBEnable(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.DBEnable[nAxis] := Param2;
end;

procedure TMintController.Set_DBExtPeakDuration(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DBExtPeakDuration[nAxis] := Param2;
end;

procedure TMintController.Set_DigitalInputBankSetup(nBank: Smallint; Param2: Smallint);
begin
  DefaultInterface.DigitalInputBankSetup[nBank] := Param2;
end;

function TMintController.Get_DiagnosticIndexedParameter(nGroup: Smallint; nCaptureIndex: Smallint; 
                                                        nGDIPIndex: Smallint): Single;
begin
    Result := DefaultInterface.DiagnosticIndexedParameter[nGroup, nCaptureIndex, nGDIPIndex];
end;

procedure TMintController.Set_DiagnosticIndexedParameter(nGroup: Smallint; nCaptureIndex: Smallint; 
                                                         nGDIPIndex: Smallint; Param4: Single);
begin
  DefaultInterface.DiagnosticIndexedParameter[nGroup, nCaptureIndex, nGDIPIndex] := Param4;
end;

procedure TMintController.Set_DriveBusOverVolts(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveBusOverVolts[nAxis] := Param2;
end;

function TMintController.Get_DriveBusNominalVolts(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveBusNominalVolts[nAxis];
end;

function TMintController.Get_DriveBusOverVolts(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveBusOverVolts[nAxis];
end;

function TMintController.Get_DiagnosticIndexedString(nChannel: Smallint; nIndex: Smallint): WideString;
begin
    Result := DefaultInterface.DiagnosticIndexedString[nChannel, nIndex];
end;

procedure TMintController.Set_DiagnosticString(nChannel: Smallint; const Param2: WideString);
  { Warning: The property DiagnosticString has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.DiagnosticString := Param2;
end;

function TMintController.Get_DigitalInputBankSetup(nBank: Smallint): Smallint;
begin
    Result := DefaultInterface.DigitalInputBankSetup[nBank];
end;

procedure TMintController.Set_DecelTimeMax(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.DecelTimeMax[nAxis] := Param2;
end;

procedure TMintController.Set_DecelTime(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.DecelTime[nAxis] := Param2;
end;

function TMintController.Get_DecelTimeMax(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.DecelTimeMax[nAxis];
end;

procedure TMintController.Set_DriveBusTConst(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DriveBusTConst[nAxis] := Param2;
end;

function TMintController.Get_AxisBus(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.AxisBus[nAxis];
end;

procedure TMintController.Set_DPRFloat(nAddress: Smallint; Param2: Single);
begin
  DefaultInterface.DPRFloat[nAddress] := Param2;
end;

procedure TMintController.Set_DigitalOutputBankSetup(nBank: Smallint; Param2: Smallint);
begin
  DefaultInterface.DigitalOutputBankSetup[nBank] := Param2;
end;

procedure TMintController.Set_DPRLong(nAddress: Smallint; Param2: Integer);
begin
  DefaultInterface.DPRLong[nAddress] := Param2;
end;

function TMintController.Get_DriveBusTConst(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveBusTConst[nAxis];
end;

function TMintController.Get_DPRLong(nAddress: Smallint): Integer;
begin
    Result := DefaultInterface.DPRLong[nAddress];
end;

function TMintController.Get_DPRFloat(nAddress: Smallint): Single;
begin
    Result := DefaultInterface.DPRFloat[nAddress];
end;

function TMintController.Get_DigitalOutputBankSetup(nBank: Smallint): Smallint;
begin
    Result := DefaultInterface.DigitalOutputBankSetup[nBank];
end;

procedure TMintController.Set_DBExtPeakPower(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DBExtPeakPower[nAxis] := Param2;
end;

function TMintController.Get_EncoderVel(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.EncoderVel[nChannel];
end;

function TMintController.Get_EncoderType(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.EncoderType[nChannel];
end;

procedure TMintController.Set_EncoderType(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.EncoderType[nChannel] := Param2;
end;

procedure TMintController.Set_EncoderTestMode(nChannel: Smallint; Param2: Integer);
begin
  DefaultInterface.EncoderTestMode[nChannel] := Param2;
end;

function TMintController.Get_EncoderWrap(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.EncoderWrap[nChannel];
end;

procedure TMintController.Set_EncoderWrap(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.EncoderWrap[nChannel] := Param2;
end;

procedure TMintController.Set_DriveParameter(nTable: Smallint; nParameter: Smallint; 
                                             Param3: OleVariant);
begin
  DefaultInterface.DriveParameter[nTable, nParameter] := Param3;
end;

procedure TMintController.Set_DriveOverloadWarning(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DriveOverloadWarning[nAxis] := Param2;
end;

function TMintController.Get_DriveParameter(nTable: Smallint; nParameter: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.DriveParameter[nTable, nParameter];
end;

function TMintController.Get_EnableSwitch(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.EnableSwitch[nAxis];
end;

function TMintController.Get_DriveParameterFloat(nTable: Smallint; nParameter: Smallint): Single;
begin
    Result := DefaultInterface.DriveParameterFloat[nTable, nParameter];
end;

procedure TMintController.Set_DriveParameterFloat(nTable: Smallint; nParameter: Smallint; 
                                                  Param3: Single);
begin
  DefaultInterface.DriveParameterFloat[nTable, nParameter] := Param3;
end;

function TMintController.Get_EncoderSetup(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.EncoderSetup[nChannel];
end;

function TMintController.Get_ErrorMask(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.ErrorMask[nAxis];
end;

function TMintController.Get_ErrorList(nGroup: Smallint; nData: Integer): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ErrorList[nGroup, nData];
end;

function TMintController.Get_ErrorInputMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.ErrorInputMode[nAxis];
end;

function TMintController.Get_ErrorBitmapStrings(nType: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ErrorBitmapStrings;
end;

procedure TMintController.Set_ErrorInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.ErrorInput[nAxis] := Param2;
end;

function TMintController.Get_ErrorLogString(nType: Smallint; nErrorCode: Integer): WideString;
begin
    Result := DefaultInterface.ErrorLogString[nType, nErrorCode];
end;

function TMintController.Get_EncoderTestMode(nChannel: Smallint): Integer;
begin
    Result := DefaultInterface.EncoderTestMode[nChannel];
end;

procedure TMintController.Set_EncoderSetup(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.EncoderSetup[nChannel] := Param2;
end;

procedure TMintController.Set_EncoderScale(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.EncoderScale[nChannel] := Param2;
end;

procedure TMintController.Set_ErrorInputMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.ErrorInputMode[nAxis] := Param2;
end;

function TMintController.Get_EncoderZLatch(nChannel: Smallint): WordBool;
begin
    Result := DefaultInterface.EncoderZLatch[nChannel];
end;

function TMintController.Get_EncoderStatus(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.EncoderStatus[nChannel];
end;

function TMintController.Get_DriveParameterInteger(nTable: Smallint; nParameter: Smallint): Integer;
begin
    Result := DefaultInterface.DriveParameterInteger[nTable, nParameter];
end;

function TMintController.Get_DriveOverloadGain(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveOverloadGain[nAxis];
end;

procedure TMintController.Set_DrivePWMMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DrivePWMMode[nAxis] := Param2;
end;

function TMintController.Get_DriveTestParameter(nParam: Smallint): Single;
begin
    Result := DefaultInterface.DriveTestParameter[nParam];
end;

procedure TMintController.Set_DriveOverloadMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveOverloadMode[nAxis] := Param2;
end;

procedure TMintController.Set_DriveOverloadGain(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DriveOverloadGain[nAxis] := Param2;
end;

procedure TMintController.Set_DriveOverloadFatal(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DriveOverloadFatal[nAxis] := Param2;
end;

function TMintController.Get_DriveSpeedMin(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveSpeedMin[nAxis];
end;

function TMintController.Get_DriveUnderloadWarning(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveUnderloadWarning[nAxis];
end;

procedure TMintController.Set_EEPROMData(nAddress: Smallint; Param2: Smallint);
begin
  DefaultInterface.EEPROMData[nAddress] := Param2;
end;

procedure TMintController.Set_DriveTestParameter(nParam: Smallint; Param2: Single);
begin
  DefaultInterface.DriveTestParameter[nParam] := Param2;
end;

procedure TMintController.Set_DriveSpeedMin(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DriveSpeedMin[nAxis] := Param2;
end;

procedure TMintController.Set_DriveSpeedMaxRPM(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveSpeedMaxRPM[nAxis] := Param2;
end;

function TMintController.Get_DriveOverloadMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveOverloadMode[nAxis];
end;

procedure TMintController.Set_DriveParameterInteger(nTable: Smallint; nParameter: Smallint; 
                                                    Param3: Integer);
begin
  DefaultInterface.DriveParameterInteger[nTable, nParameter] := Param3;
end;

function TMintController.Get_DrivePeakCurrent(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DrivePeakCurrent[nAxis];
end;

function TMintController.Get_DriveOverloadWarning(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveOverloadWarning[nAxis];
end;

function TMintController.Get_DrivePWMFreq(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DrivePWMFreq[nAxis];
end;

function TMintController.Get_DrivePWMMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DrivePWMMode[nAxis];
end;

function TMintController.Get_DrivePeakDuration(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DrivePeakDuration[nAxis];
end;

function TMintController.Get_DriveOperatingMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveOperatingMode[nAxis];
end;

procedure TMintController.Set_DriveOperatingMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveOperatingMode[nAxis] := Param2;
end;

function TMintController.Get_DriveOverloadFatal(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveOverloadFatal[nAxis];
end;

procedure TMintController.Set_DriveOperatingZone(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DriveOperatingZone[nAxis] := Param2;
end;

function TMintController.Get_DriveOverloadArea(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DriveOverloadArea[nAxis];
end;

function TMintController.Get_DriveOperatingZone(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DriveOperatingZone[nAxis];
end;

procedure TMintController.Set_DBExtR(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DBExtR[nAxis] := Param2;
end;

procedure TMintController.Set_DBExtTripInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DBExtTripInput[nAxis] := Param2;
end;

procedure TMintController.Set_DBMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DBMode[nAxis] := Param2;
end;

function TMintController.Get_DBExtTripInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DBExtTripInput[nAxis];
end;

function TMintController.Get_DBExtThermalTimeConst(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DBExtThermalTimeConst[nAxis];
end;

function TMintController.Get_DBExtR(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DBExtR[nAxis];
end;

procedure TMintController.Set_DBFreq(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DBFreq[nAxis] := Param2;
end;

function TMintController.Get_EncoderOutChannel(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.EncoderOutChannel[nChannel];
end;

procedure TMintController.Set_EncoderOutChannel(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.EncoderOutChannel[nChannel] := Param2;
end;

function TMintController.Get_DBOverloadMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DBOverloadMode[nAxis];
end;

function TMintController.Get_DBMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DBMode[nAxis];
end;

function TMintController.Get_DBFreq(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DBFreq[nAxis];
end;

procedure TMintController.Set_DBExtThermalTimeConst(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DBExtThermalTimeConst[nAxis] := Param2;
end;

function TMintController.Get_DBSwitchingVolts(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DBSwitchingVolts[nAxis];
end;

procedure TMintController.Set_DBSwitchingVolts(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DBSwitchingVolts[nAxis] := Param2;
end;

function TMintController.Get_Decel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Decel[nAxis];
end;

function TMintController.Get_DBVoltsLimit(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DBVoltsLimit[nAxis];
end;

procedure TMintController.Set_DBVoltsLimit(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DBVoltsLimit[nAxis] := Param2;
end;

function TMintController.Get_DBVolts(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.DBVolts[nAxis];
end;

procedure TMintController.Set_Decel(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Decel[nAxis] := Param2;
end;

function TMintController.Get_DecelJerk(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.DecelJerk[nAxis];
end;

procedure TMintController.Set_DBOverloadMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.DBOverloadMode[nAxis] := Param2;
end;

function TMintController.Get_DecelJerkTime(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.DecelJerkTime[nAxis];
end;

procedure TMintController.Set_DecelJerkTime(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.DecelJerkTime[nAxis] := Param2;
end;

procedure TMintController.Set_DecelJerk(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.DecelJerk[nAxis] := Param2;
end;

procedure TMintController.Set_EncoderMode(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.EncoderMode[nChannel] := Param2;
end;

procedure TMintController.Set_EncoderLinesIn(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.EncoderLinesIn[nAxis] := Param2;
end;

procedure TMintController.Set_EncoderFilterType(nEncoderChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.EncoderFilterType[nEncoderChannel] := Param2;
end;

procedure TMintController.Set_EncoderFilterDepth(nEncoderChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.EncoderFilterDepth[nEncoderChannel] := Param2;
end;

procedure TMintController.Set_Encoder(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.Encoder[nChannel] := Param2;
end;

function TMintController.Get_EncoderFilterDepth(nEncoderChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.EncoderFilterDepth[nEncoderChannel];
end;

function TMintController.Get_EncoderLinesIn(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.EncoderLinesIn[nAxis];
end;

function TMintController.Get_ErrorInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.ErrorInput[nAxis];
end;

function TMintController.Get_ErrorDecel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.ErrorDecel[nAxis];
end;

function TMintController.Get_ErrData(nIndex: Smallint): Integer;
begin
    Result := DefaultInterface.ErrData[nIndex];
end;

function TMintController.Get_EncoderFilterType(nEncoderChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.EncoderFilterType[nEncoderChannel];
end;

function TMintController.Get_EncoderScale(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.EncoderScale[nChannel];
end;

procedure TMintController.Set_ErrorDecel(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.ErrorDecel[nAxis] := Param2;
end;

function TMintController.Get_Encoder(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.Encoder[nChannel];
end;

function TMintController.Get_EncoderResolution(nChannel: Smallint): Integer;
begin
    Result := DefaultInterface.EncoderResolution[nChannel];
end;

procedure TMintController.Set_EncoderResolution(nChannel: Smallint; Param2: Integer);
begin
  DefaultInterface.EncoderResolution[nChannel] := Param2;
end;

procedure TMintController.Set_EncoderPreScale(nChannel: Smallint; Param2: Integer);
begin
  DefaultInterface.EncoderPreScale[nChannel] := Param2;
end;

procedure TMintController.Set_EncoderLinesOut(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.EncoderLinesOut[nAxis] := Param2;
end;

function TMintController.Get_EncoderMode(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.EncoderMode[nChannel];
end;

function TMintController.Get_EncoderOutResolution(nChannel: Smallint): Integer;
begin
    Result := DefaultInterface.EncoderOutResolution[nChannel];
end;

function TMintController.Get_EncoderCycleSize(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.EncoderCycleSize[nAxis];
end;

procedure TMintController.Set_EncoderCycleSize(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.EncoderCycleSize[nAxis] := Param2;
end;

function TMintController.Get_EncoderCount(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.EncoderCount[nAxis];
end;

procedure TMintController.Set_EncoderOutResolution(nChannel: Smallint; Param2: Integer);
begin
  DefaultInterface.EncoderOutResolution[nChannel] := Param2;
end;

function TMintController.Get_EncoderPreScale(nChannel: Smallint): Integer;
begin
    Result := DefaultInterface.EncoderPreScale[nChannel];
end;

function TMintController.Get_EncoderLinesOut(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.EncoderLinesOut[nAxis];
end;

function TMintController.Get_RemoteStatus(nCANBus: Smallint; nNode: Smallint): Smallint;
begin
    Result := DefaultInterface.RemoteStatus[nCANBus, nNode];
end;

function TMintController.Get_HomeBackoff(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HomeBackoff[nAxis];
end;

procedure TMintController.Set_HomeBackoff(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HomeBackoff[nAxis] := Param2;
end;

function TMintController.Get_HomeCreepSpeed(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HomeCreepSpeed[nAxis];
end;

procedure TMintController.Set_HomeCreepSpeed(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HomeCreepSpeed[nAxis] := Param2;
end;

function TMintController.Get_HomeDecel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HomeDecel[nAxis];
end;

procedure TMintController.Set_HomeDecel(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HomeDecel[nAxis] := Param2;
end;

procedure TMintController.Set_FastAuxLatchEdge(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.FastAuxLatchEdge[nAxis] := Param2;
end;

function TMintController.Get_FastAuxLatchMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.FastAuxLatchMode[nAxis];
end;

procedure TMintController.Set_FastAuxLatchMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.FastAuxLatchMode[nAxis] := Param2;
end;

function TMintController.Get_FastAuxSelect(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.FastAuxSelect[nAxis];
end;

procedure TMintController.Set_FastAuxSelect(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.FastAuxSelect[nAxis] := Param2;
end;

procedure TMintController.Set_FastEnable(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.FastEnable[nAxis] := Param2;
end;

procedure TMintController.Set_HomeAccel(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HomeAccel[nAxis] := Param2;
end;

function TMintController.Get_HomeSpeed(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HomeSpeed[nAxis];
end;

procedure TMintController.Set_HomeSpeed(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HomeSpeed[nAxis] := Param2;
end;

function TMintController.Get_HomeInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.HomeInput[nAxis];
end;

procedure TMintController.Set_HomeStatus(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.HomeStatus[nAxis] := Param2;
end;

function TMintController.Get_HomeSwitch(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.HomeSwitch[nAxis];
end;

function TMintController.Get_HomeSources(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.HomeSources[nAxis];
end;

function TMintController.Get_HoldingRegister(nRegister: Integer): Integer;
begin
    Result := DefaultInterface.HoldingRegister[nRegister];
end;

procedure TMintController.Set_HoldingRegister(nRegister: Integer; Param2: Integer);
begin
  DefaultInterface.HoldingRegister[nRegister] := Param2;
end;

function TMintController.Get_HoldSwitch(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.HoldSwitch[nAxis];
end;

function TMintController.Get_Home(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.Home[nAxis];
end;

procedure TMintController.Set_Home(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.Home[nAxis] := Param2;
end;

function TMintController.Get_HomeAccel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HomeAccel[nAxis];
end;

function TMintController.Get_FastEncoder(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FastEncoder[nAxis];
end;

procedure TMintController.Set_FastAuxLatchDistance(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.FastAuxLatchDistance[nAxis] := Param2;
end;

function TMintController.Get_ErrorSwitch(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.ErrorSwitch[nAxis];
end;

procedure TMintController.Set_FastAuxEnable(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.FastAuxEnable[nAxis] := Param2;
end;

function TMintController.Get_ErrorString(nErrorCode: Integer): WideString;
begin
    Result := DefaultInterface.ErrorString[nErrorCode];
end;

function TMintController.Get_FastAuxLatch(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.FastAuxLatch[nAxis];
end;

function TMintController.Get_FastAuxLatchDistance(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FastAuxLatchDistance[nAxis];
end;

function TMintController.Get_FolErrorWarning(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FolErrorWarning[nAxis];
end;

procedure TMintController.Set_FolErrorWarning(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.FolErrorWarning[nAxis] := Param2;
end;

function TMintController.Get_FolErrorFatal(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FolErrorFatal[nAxis];
end;

function TMintController.Get_FastAuxEncoder(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FastAuxEncoder[nAxis];
end;

procedure TMintController.Set_FastLatchMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.FastLatchMode[nAxis] := Param2;
end;

procedure TMintController.Set_FolErrorMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.FolErrorMode[nAxis] := Param2;
end;

procedure TMintController.Set_ErrorMaskCode(nCode: Integer; nData: Integer; Param3: WordBool);
begin
  DefaultInterface.ErrorMaskCode[nCode, nData] := Param3;
end;

function TMintController.Get_FastLatch(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.FastLatch[nAxis];
end;

function TMintController.Get_FastLatchDistance(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FastLatchDistance[nAxis];
end;

procedure TMintController.Set_FastLatchDistance(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.FastLatchDistance[nAxis] := Param2;
end;

function TMintController.Get_FastLatchEdge(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.FastLatchEdge[nAxis];
end;

procedure TMintController.Set_FastLatchEdge(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.FastLatchEdge[nAxis] := Param2;
end;

function TMintController.Get_FastLatchMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.FastLatchMode[nAxis];
end;

function TMintController.Get_ErrorReadNext(nGroup: Smallint; nData: Integer): WordBool;
begin
    Result := DefaultInterface.ErrorReadNext[nGroup, nData];
end;

procedure TMintController.Set_ErrorMask(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.ErrorMask[nAxis] := Param2;
end;

function TMintController.Get_ErrorMaskCode(nCode: Integer; nData: Integer): WordBool;
begin
    Result := DefaultInterface.ErrorMaskCode[nCode, nData];
end;

function TMintController.Get_FastAuxLatchEdge(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.FastAuxLatchEdge[nAxis];
end;

function TMintController.Get_ErrorPresent(nGroup: Smallint; nData: Integer): WordBool;
begin
    Result := DefaultInterface.ErrorPresent[nGroup, nData];
end;

function TMintController.Get_ErrorReadCode(nGroup: Smallint; nData: Integer): WordBool;
begin
    Result := DefaultInterface.ErrorReadCode[nGroup, nData];
end;

procedure TMintController.Set_GroupMaster(nCANBus: Smallint; nGroup: Smallint; Param3: Smallint);
begin
  DefaultInterface.GroupMaster[nCANBus, nGroup] := Param3;
end;

function TMintController.Get_GroupMasterStatus(nCANBus: Smallint; nGroup: Smallint): Smallint;
begin
    Result := DefaultInterface.GroupMasterStatus[nCANBus, nGroup];
end;

procedure TMintController.Set_Group(nCANBus: Smallint; nGroup: Smallint; nNodeId: Smallint; 
                                    Param4: Smallint);
begin
  DefaultInterface.Group[nCANBus, nGroup, nNodeId] := Param4;
end;

procedure TMintController.Set_MotorRs(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorRs[nAxis] := Param2;
end;

function TMintController.Get_MotorSlipFreq(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorSlipFreq[nAxis];
end;

function TMintController.Get_GroupMaster(nCANBus: Smallint; nGroup: Smallint): Smallint;
begin
    Result := DefaultInterface.GroupMaster[nCANBus, nGroup];
end;

function TMintController.Get_HallReverseAngle(nAxis: Smallint; nSextant: Smallint): Single;
begin
    Result := DefaultInterface.HallReverseAngle[nAxis, nSextant];
end;

procedure TMintController.Set_HallReverseAngle(nAxis: Smallint; nSextant: Smallint; Param3: Single);
begin
  DefaultInterface.HallReverseAngle[nAxis, nSextant] := Param3;
end;

function TMintController.Get_HallTable(nAxis: Smallint; nState: Smallint): Smallint;
begin
    Result := DefaultInterface.HallTable[nAxis, nState];
end;

procedure TMintController.Set_GroupComms(nCANBus: Smallint; nGroup: Smallint; nIndex: Smallint; 
                                         Param4: Single);
begin
  DefaultInterface.GroupComms[nCANBus, nGroup, nIndex] := Param4;
end;

function TMintController.Get_GroupInfo(nBus: Smallint; nNode: Smallint): Smallint;
begin
    Result := DefaultInterface.GroupInfo[nBus, nNode];
end;

function TMintController.Get_GroupStatus(nCANBus: Smallint; nGroup: Smallint): Smallint;
begin
    Result := DefaultInterface.GroupStatus[nCANBus, nGroup];
end;

function TMintController.Get_MotorRs(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorRs[nAxis];
end;

procedure TMintController.Set_MotorRotorLeakageInd(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorRotorLeakageInd[nAxis] := Param2;
end;

function TMintController.Get_MotorRotorRes(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorRotorRes[nAxis];
end;

procedure TMintController.Set_MotorResolverOffset(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorResolverOffset[nAxis] := Param2;
end;

function TMintController.Get_MotorTemperatureInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorTemperatureInput[nAxis];
end;

function TMintController.Get_MotorSpeedMaxmmps(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorSpeedMaxmmps[nAxis];
end;

function TMintController.Get_MotorRotorLeakageInd(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorRotorLeakageInd[nAxis];
end;

procedure TMintController.Set_MotorSlipFreq(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorSlipFreq[nAxis] := Param2;
end;

function TMintController.Get_MotorSpecNumber(nAxis: Smallint): WideString;
begin
    Result := DefaultInterface.MotorSpecNumber[nAxis];
end;

procedure TMintController.Set_MotorSpecNumber(nAxis: Smallint; const Param2: WideString);
  { Warning: The property MotorSpecNumber has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.MotorSpecNumber := Param2;
end;

function TMintController.Get_MotorResolverSpeed(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorResolverSpeed[nAxis];
end;

procedure TMintController.Set_MotorResolverSpeed(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorResolverSpeed[nAxis] := Param2;
end;

procedure TMintController.Set_MotorRotorRes(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorRotorRes[nAxis] := Param2;
end;

function TMintController.Get_Hall(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.Hall[nAxis];
end;

procedure TMintController.Set_HallTable(nAxis: Smallint; nState: Smallint; Param3: Smallint);
begin
  DefaultInterface.HallTable[nAxis, nState] := Param3;
end;

function TMintController.Get_HomePhase(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.HomePhase[nAxis];
end;

function TMintController.Get_HomePos(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HomePos[nAxis];
end;

function TMintController.Get_FrictionCompensationTConst(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FrictionCompensationTConst[nAxis];
end;

procedure TMintController.Set_FrictionCompensationTConst(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.FrictionCompensationTConst[nAxis] := Param2;
end;

function TMintController.Get_Gearing(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Gearing[nAxis];
end;

procedure TMintController.Set_HomeOffset(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HomeOffset[nAxis] := Param2;
end;

procedure TMintController.Set_HomeRefPos(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HomeRefPos[nAxis] := Param2;
end;

function TMintController.Get_HomeStatus(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.HomeStatus[nAxis];
end;

function TMintController.Get_HomeRefPos(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HomeRefPos[nAxis];
end;

procedure TMintController.Set_HomeInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.HomeInput[nAxis] := Param2;
end;

function TMintController.Get_HomeOffset(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HomeOffset[nAxis];
end;

procedure TMintController.Set_GearingMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.GearingMode[nAxis] := Param2;
end;

function TMintController.Get_FrictionCompensation(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FrictionCompensation[nAxis];
end;

procedure TMintController.Set_FrictionCompensation(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.FrictionCompensation[nAxis] := Param2;
end;

function TMintController.Get_FrictionCompensationSpeed(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FrictionCompensationSpeed[nAxis];
end;

function TMintController.Get_HallForwardAngle(nAxis: Smallint; nSextant: Smallint): Single;
begin
    Result := DefaultInterface.HallForwardAngle[nAxis, nSextant];
end;

procedure TMintController.Set_HallForwardAngle(nAxis: Smallint; nSextant: Smallint; Param3: Single);
begin
  DefaultInterface.HallForwardAngle[nAxis, nSextant] := Param3;
end;

function TMintController.Get_Group(nCANBus: Smallint; nGroup: Smallint; nNodeId: Smallint): Smallint;
begin
    Result := DefaultInterface.Group[nCANBus, nGroup, nNodeId];
end;

procedure TMintController.Set_FrictionCompensationSpeed(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.FrictionCompensationSpeed[nAxis] := Param2;
end;

procedure TMintController.Set_Gearing(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Gearing[nAxis] := Param2;
end;

function TMintController.Get_GearingMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.GearingMode[nAxis];
end;

procedure TMintController.Set_FollowNumerator(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.FollowNumerator[nAxis] := Param2;
end;

function TMintController.Get_Freq(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Freq[nAxis];
end;

procedure TMintController.Set_Freq(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Freq[nAxis] := Param2;
end;

procedure TMintController.Set_FolErrorFatal(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.FolErrorFatal[nAxis] := Param2;
end;

procedure TMintController.Set_KITrack(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.KITrack[nAxis] := Param2;
end;

function TMintController.Get_KIntMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.KIntMode[nAxis];
end;

procedure TMintController.Set_KIntMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.KIntMode[nAxis] := Param2;
end;

procedure TMintController.Set_KVel(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KVel[nAxis] := Param2;
end;

procedure TMintController.Set_KIProp(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KIProp[nAxis] := Param2;
end;

function TMintController.Get_KITrack(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.KITrack[nAxis];
end;

procedure TMintController.Set_KVDerivTConst(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KVDerivTConst[nAxis] := Param2;
end;

function TMintController.Get_KVel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KVel[nAxis];
end;

procedure TMintController.Set_KProp(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KProp[nAxis] := Param2;
end;

function TMintController.Get_KIProp(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KIProp[nAxis];
end;

function TMintController.Get_KProp(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KProp[nAxis];
end;

function TMintController.Get_KVDerivTConst(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KVDerivTConst[nAxis];
end;

procedure TMintController.Set_KVProp(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KVProp[nAxis] := Param2;
end;

function TMintController.Get_KVelFF(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KVelFF[nAxis];
end;

procedure TMintController.Set_KVelFF(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KVelFF[nAxis] := Param2;
end;

function TMintController.Get_KVFilterLevel(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.KVFilterLevel[nAxis];
end;

procedure TMintController.Set_KVFilterLevel(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.KVFilterLevel[nAxis] := Param2;
end;

function TMintController.Get_KVInt(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KVInt[nAxis];
end;

procedure TMintController.Set_KVInt(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KVInt[nAxis] := Param2;
end;

function TMintController.Get_KVTrack(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.KVTrack[nAxis];
end;

procedure TMintController.Set_KVMeas(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KVMeas[nAxis] := Param2;
end;

function TMintController.Get_KVProp(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KVProp[nAxis];
end;

function TMintController.Get_KVMeas(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KVMeas[nAxis];
end;

function TMintController.Get_KVTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KVTime[nAxis];
end;

procedure TMintController.Set_KVTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KVTime[nAxis] := Param2;
end;

function TMintController.Get_KVDeriv(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KVDeriv[nAxis];
end;

procedure TMintController.Set_HTAChannel(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.HTAChannel[nAxis] := Param2;
end;

function TMintController.Get_HTADamping(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HTADamping[nAxis];
end;

procedure TMintController.Set_HomeType(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.HomeType[nAxis] := Param2;
end;

function TMintController.Get_IdleVel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.IdleVel[nAxis];
end;

function TMintController.Get_HTAKProp(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HTAKProp[nAxis];
end;

function TMintController.Get_HTAChannel(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.HTAChannel[nAxis];
end;

procedure TMintController.Set_HTAFilter(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HTAFilter[nAxis] := Param2;
end;

function TMintController.Get_HTAKInt(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HTAKInt[nAxis];
end;

procedure TMintController.Set_HTAKInt(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HTAKInt[nAxis] := Param2;
end;

function TMintController.Get_HTA(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HTA[nAxis];
end;

procedure TMintController.Set_HTA(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HTA[nAxis] := Param2;
end;

procedure TMintController.Set_HTADamping(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HTADamping[nAxis] := Param2;
end;

procedure TMintController.Set_IdleTime(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.IdleTime[nAxis] := Param2;
end;

procedure TMintController.Set_IdlePos(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.IdlePos[nAxis] := Param2;
end;

procedure TMintController.Set_HTAKProp(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HTAKProp[nAxis] := Param2;
end;

function TMintController.Get_Idle(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.Idle[nAxis];
end;

procedure TMintController.Set_KVDeriv(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KVDeriv[nAxis] := Param2;
end;

procedure TMintController.Set_IdleMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.IdleMode[nAxis] := Param2;
end;

function TMintController.Get_IdlePos(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.IdlePos[nAxis];
end;

function TMintController.Get_IMask(nBank: Smallint): Integer;
begin
    Result := DefaultInterface.IMask[nBank];
end;

procedure TMintController.Set_IMask(nBank: Smallint; Param2: Integer);
begin
  DefaultInterface.IMask[nBank] := Param2;
end;

function TMintController.Get_IdleTime(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.IdleTime[nAxis];
end;

function TMintController.Get_IdleMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.IdleMode[nAxis];
end;

function TMintController.Get_IdleSettlingTime(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.IdleSettlingTime[nAxis];
end;

procedure TMintController.Set_IdleVel(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.IdleVel[nAxis] := Param2;
end;

procedure TMintController.Set_FeedrateParameter(nAxis: Smallint; nOverride: Smallint; Param3: Single);
begin
  DefaultInterface.FeedrateParameter[nAxis, nOverride] := Param3;
end;

function TMintController.Get_FirmwareComponentVersion(nComponent: Smallint): Single;
begin
    Result := DefaultInterface.FirmwareComponentVersion[nComponent];
end;

procedure TMintController.Set_Fly(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Fly[nAxis] := Param2;
end;

function TMintController.Get_FastSelect(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.FastSelect[nAxis];
end;

procedure TMintController.Set_FastSelect(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.FastSelect[nAxis] := Param2;
end;

procedure TMintController.Set_FeedrateMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.FeedrateMode[nAxis] := Param2;
end;

function TMintController.Get_HomeType(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.HomeType[nAxis];
end;

procedure TMintController.Set_KFInt(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KFInt[nAxis] := Param2;
end;

function TMintController.Get_KFProp(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KFProp[nAxis];
end;

function TMintController.Get_FeedrateOverride(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FeedrateOverride[nAxis];
end;

procedure TMintController.Set_FeedrateOverride(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.FeedrateOverride[nAxis] := Param2;
end;

function TMintController.Get_FeedrateParameter(nAxis: Smallint; nOverride: Smallint): Single;
begin
    Result := DefaultInterface.FeedrateParameter[nAxis, nOverride];
end;

function TMintController.Get_FastPos(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FastPos[nAxis];
end;

procedure TMintController.Set_FollowMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.FollowMode[nAxis] := Param2;
end;

function TMintController.Get_FollowNumerator(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FollowNumerator[nAxis];
end;

procedure TMintController.Set_Follow(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Follow[nAxis] := Param2;
end;

function TMintController.Get_FolErrorMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.FolErrorMode[nAxis];
end;

function TMintController.Get_Follow(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Follow[nAxis];
end;

function TMintController.Get_FollowMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.FollowMode[nAxis];
end;

function TMintController.Get_Feedrate(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Feedrate[nAxis];
end;

procedure TMintController.Set_Feedrate(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Feedrate[nAxis] := Param2;
end;

function TMintController.Get_FeedrateMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.FeedrateMode[nAxis];
end;

function TMintController.Get_FollowDenom(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FollowDenom[nAxis];
end;

procedure TMintController.Set_FollowDenom(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.FollowDenom[nAxis] := Param2;
end;

function TMintController.Get_FolError(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.FolError[nAxis];
end;

procedure TMintController.Set_KFProp(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KFProp[nAxis] := Param2;
end;

procedure TMintController.Set_JogDuration(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.JogDuration[nAxis] := Param2;
end;

procedure TMintController.Set_JogSpeed(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.JogSpeed[nAxis] := Param2;
end;

function TMintController.Get_KASInt(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KASInt[nAxis];
end;

function TMintController.Get_JogSpeed(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.JogSpeed[nAxis];
end;

procedure TMintController.Set_JogDecelTimeMax(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.JogDecelTimeMax[nAxis] := Param2;
end;

function TMintController.Get_JogDuration(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.JogDuration[nAxis];
end;

function TMintController.Get_KAccel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KAccel[nAxis];
end;

procedure TMintController.Set_KAccel(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KAccel[nAxis] := Param2;
end;

procedure TMintController.Set_KIntLimit(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KIntLimit[nAxis] := Param2;
end;

procedure TMintController.Set_KASInt(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KASInt[nAxis] := Param2;
end;

function TMintController.Get_KASProp(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KASProp[nAxis];
end;

function TMintController.Get_JogTime(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.JogTime[nAxis];
end;

procedure TMintController.Set_JogMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.JogMode[nAxis] := Param2;
end;

function TMintController.Get_KFTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KFTime[nAxis];
end;

function TMintController.Get_KInt(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KInt[nAxis];
end;

procedure TMintController.Set_KInt(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KInt[nAxis] := Param2;
end;

function TMintController.Get_KDeriv(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KDeriv[nAxis];
end;

procedure TMintController.Set_KDeriv(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KDeriv[nAxis] := Param2;
end;

function TMintController.Get_KFInt(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KFInt[nAxis];
end;

procedure TMintController.Set_KIInt(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KIInt[nAxis] := Param2;
end;

procedure TMintController.Set_KASProp(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KASProp[nAxis] := Param2;
end;

function TMintController.Get_JogMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.JogMode[nAxis];
end;

function TMintController.Get_KIntLimit(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KIntLimit[nAxis];
end;

procedure TMintController.Set_KFTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.KFTime[nAxis] := Param2;
end;

function TMintController.Get_KIInt(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.KIInt[nAxis];
end;

procedure TMintController.Set_MotorStatorRes(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorStatorRes[nAxis] := Param2;
end;

procedure TMintController.Set_LatchSourceChannel(nLatchChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.LatchSourceChannel[nLatchChannel] := Param2;
end;

procedure TMintController.Set_LatchInhibitValue(nLatchChannel: Smallint; Param2: Single);
begin
  DefaultInterface.LatchInhibitValue[nLatchChannel] := Param2;
end;

function TMintController.Get_KnifeMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.KnifeMode[nAxis];
end;

function TMintController.Get_LatchTriggerEdge(nLatchChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.LatchTriggerEdge[nLatchChannel];
end;

procedure TMintController.Set_LatchSource(nLatchChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.LatchSource[nLatchChannel] := Param2;
end;

function TMintController.Get_LatchSourceChannel(nLatchChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.LatchSourceChannel[nLatchChannel];
end;

function TMintController.Get_KnifeMasterAxis(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.KnifeMasterAxis[nAxis];
end;

procedure TMintController.Set_KnifeMasterAxis(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.KnifeMasterAxis[nAxis] := Param2;
end;

procedure TMintController.Set_KnifeStatus(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.KnifeStatus[nAxis] := Param2;
end;

procedure TMintController.Set_KnifeMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.KnifeMode[nAxis] := Param2;
end;

function TMintController.Get_KnifeStatus(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.KnifeStatus[nAxis];
end;

procedure TMintController.Set_KVTrack(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.KVTrack[nAxis] := Param2;
end;

procedure TMintController.Set_LatchTriggerChannel(nLatchChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.LatchTriggerChannel[nLatchChannel] := Param2;
end;

function TMintController.Get_MotorFluxMax(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorFluxMax[nAxis];
end;

procedure TMintController.Set_LatchSetup(nDeviceType: Smallint; nChannel: Smallint; Param3: Smallint);
begin
  DefaultInterface.LatchSetup[nDeviceType, nChannel] := Param3;
end;

function TMintController.Get_LatchSetupMultiple(nDeviceType: Smallint; nChannel: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.LatchSetupMultiple[nDeviceType, nChannel];
end;

procedure TMintController.Set_MotorFluxMin(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorFluxMin[nAxis] := Param2;
end;

function TMintController.Get_MotorFlux(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorFlux[nAxis];
end;

procedure TMintController.Set_MotorFlux(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorFlux[nAxis] := Param2;
end;

function TMintController.Get_LatchSetup(nDeviceType: Smallint; nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.LatchSetup[nDeviceType, nChannel];
end;

function TMintController.Get_LatchSource(nLatchChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.LatchSource[nLatchChannel];
end;

function TMintController.Get_LatchTriggerChannel(nLatchChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.LatchTriggerChannel[nLatchChannel];
end;

procedure TMintController.Set_LatchSetupMultiple(nDeviceType: Smallint; nChannel: Smallint; 
                                                 Param3: OleVariant);
begin
  DefaultInterface.LatchSetupMultiple[nDeviceType, nChannel] := Param3;
end;

function TMintController.Get_LatchMode(nLatchChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.LatchMode[nLatchChannel];
end;

procedure TMintController.Set_LatchMode(nLatchChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.LatchMode[nLatchChannel] := Param2;
end;

function TMintController.Get_LatchInhibitTime(nLatchChannel: Smallint): Integer;
begin
    Result := DefaultInterface.LatchInhibitTime[nLatchChannel];
end;

procedure TMintController.Set_MasterDistance(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MasterDistance[nAxis] := Param2;
end;

function TMintController.Get_MasterSource(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MasterSource[nAxis];
end;

procedure TMintController.Set_MasterSource(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MasterSource[nAxis] := Param2;
end;

function TMintController.Get_MaxAccel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MaxAccel[nAxis];
end;

procedure TMintController.Set_MaxAccel(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MaxAccel[nAxis] := Param2;
end;

function TMintController.Get_MaxDecel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MaxDecel[nAxis];
end;

function TMintController.Get_LimitForwardInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.LimitForwardInput[nAxis];
end;

function TMintController.Get_LatchTriggerMode(nLatchChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.LatchTriggerMode[nLatchChannel];
end;

procedure TMintController.Set_LatchTriggerMode(nLatchChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.LatchTriggerMode[nLatchChannel] := Param2;
end;

procedure TMintController.Set_ListOf(nListOf: Smallint; nParameter: Smallint; Param3: OleVariant);
begin
  DefaultInterface.ListOf[nListOf, nParameter] := Param3;
end;

function TMintController.Get_Limit(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.Limit[nAxis];
end;

function TMintController.Get_LimitForward(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.LimitForward[nAxis];
end;

function TMintController.Get_MasterDistance(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MasterDistance[nAxis];
end;

function TMintController.Get_LatchEnable(nLatchChannel: Smallint): WordBool;
begin
    Result := DefaultInterface.LatchEnable[nLatchChannel];
end;

procedure TMintController.Set_LatchEnable(nLatchChannel: Smallint; Param2: WordBool);
begin
  DefaultInterface.LatchEnable[nLatchChannel] := Param2;
end;

procedure TMintController.Set_LatchTriggerEdge(nLatchChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.LatchTriggerEdge[nLatchChannel] := Param2;
end;

procedure TMintController.Set_LatchInhibitTime(nLatchChannel: Smallint; Param2: Integer);
begin
  DefaultInterface.LatchInhibitTime[nLatchChannel] := Param2;
end;

function TMintController.Get_LatchInhibitValue(nLatchChannel: Smallint): Single;
begin
    Result := DefaultInterface.LatchInhibitValue[nLatchChannel];
end;

function TMintController.Get_Latch(nLatchChannel: Smallint): WordBool;
begin
    Result := DefaultInterface.Latch[nLatchChannel];
end;

function TMintController.Get_LoadDamping(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.LoadDamping[nAxis];
end;

procedure TMintController.Set_LoadDamping(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.LoadDamping[nAxis] := Param2;
end;

function TMintController.Get_LoadInertia(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.LoadInertia[nAxis];
end;

procedure TMintController.Set_LoadInertia(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.LoadInertia[nAxis] := Param2;
end;

function TMintController.Get_MasterChannel(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MasterChannel[nAxis];
end;

procedure TMintController.Set_MasterChannel(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MasterChannel[nAxis] := Param2;
end;

function TMintController.Get_MintExtendedStatus(nCommand: Smallint; vData: OleVariant): Integer;
begin
    Result := DefaultInterface.MintExtendedStatus[nCommand, vData];
end;

procedure TMintController.Set_MaxDecel(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MaxDecel[nAxis] := Param2;
end;

function TMintController.Get_MaxSpeed(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MaxSpeed[nAxis];
end;

procedure TMintController.Set_MotorBrake(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.MotorBrake[nAxis] := Param2;
end;

function TMintController.Get_MintExpressions(vLHS: OleVariant): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.MintExpressions;
end;

procedure TMintController.Set_MintExpressions(vLHS: OleVariant; Param2: OleVariant);
begin
  DefaultInterface.MintExpressions[vLHS] := Param2;
end;

function TMintController.Get_MotorBaseVolts(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorBaseVolts[nAxis];
end;

procedure TMintController.Set_MotorBaseVolts(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorBaseVolts[nAxis] := Param2;
end;

function TMintController.Get_ModuleName(nModuleID: Smallint): WideString;
begin
    Result := DefaultInterface.ModuleName[nModuleID];
end;

procedure TMintController.Set_MaxSpeed(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MaxSpeed[nAxis] := Param2;
end;

function TMintController.Get_MintStatus(nCommand: Smallint): Integer;
begin
    Result := DefaultInterface.MintStatus[nCommand];
end;

procedure TMintController.Set_MotorBaseFreq(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorBaseFreq[nAxis] := Param2;
end;

function TMintController.Get_MotorDirection(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorDirection[nAxis];
end;

function TMintController.Get_MotorBrakeDelay(nAxis: Smallint; nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorBrakeDelay[nAxis, nChannel];
end;

procedure TMintController.Set_MotorBrakeDelay(nAxis: Smallint; nChannel: Smallint; Param3: Smallint);
begin
  DefaultInterface.MotorBrakeDelay[nAxis, nChannel] := Param3;
end;

function TMintController.Get_MotorBrakeMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorBrakeMode[nAxis];
end;

procedure TMintController.Set_MotorBrakeMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MotorBrakeMode[nAxis] := Param2;
end;

function TMintController.Get_MotorBrakeOutput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorBrakeOutput[nAxis];
end;

procedure TMintController.Set_MotorBrakeOutput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MotorBrakeOutput[nAxis] := Param2;
end;

procedure TMintController.Set_MotorEncoderLines(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.MotorEncoderLines[nAxis] := Param2;
end;

function TMintController.Get_MotorCatalogNumber(nAxis: Smallint): WideString;
begin
    Result := DefaultInterface.MotorCatalogNumber[nAxis];
end;

procedure TMintController.Set_MotorCatalogNumber(nAxis: Smallint; const Param2: WideString);
  { Warning: The property MotorCatalogNumber has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.MotorCatalogNumber := Param2;
end;

function TMintController.Get_MotorBrakeStatus(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorBrakeStatus[nAxis];
end;

procedure TMintController.Set_MotorDirection(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MotorDirection[nAxis] := Param2;
end;

function TMintController.Get_MotorEncoderLines(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.MotorEncoderLines[nAxis];
end;

function TMintController.Get_MonitorParameter(nGroup: Smallint; nMode: Smallint; 
                                              nParameter: Smallint): Integer;
begin
    Result := DefaultInterface.MonitorParameter[nGroup, nMode, nParameter];
end;

function TMintController.Get_MotorFeedbackAngle(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorFeedbackAngle[nAxis];
end;

function TMintController.Get_MotorFeedbackOffset(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorFeedbackOffset[nAxis];
end;

procedure TMintController.Set_MotorFeedbackOffset(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorFeedbackOffset[nAxis] := Param2;
end;

procedure TMintController.Set_MotorLs(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorLs[nAxis] := Param2;
end;

function TMintController.Get_MotorMagCurrent(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorMagCurrent[nAxis];
end;

function TMintController.Get_MotorFluxTConst(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorFluxTConst[nAxis];
end;

function TMintController.Get_MotorFeedbackStatus(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorFeedbackStatus[nAxis];
end;

procedure TMintController.Set_MotorFluxMax(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorFluxMax[nAxis] := Param2;
end;

function TMintController.Get_MotorFluxMin(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorFluxMin[nAxis];
end;

procedure TMintController.Set_MotorFeedback(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MotorFeedback[nAxis] := Param2;
end;

function TMintController.Get_MotorFeedbackAlignment(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorFeedbackAlignment[nAxis];
end;

procedure TMintController.Set_MotorFeedbackAlignment(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorFeedbackAlignment[nAxis] := Param2;
end;

function TMintController.Get_MotorLs(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorLs[nAxis];
end;

procedure TMintController.Set_MotorLinearEncoderResolution(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.MotorLinearEncoderResolution[nAxis] := Param2;
end;

function TMintController.Get_MotorLinearPolePitch(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorLinearPolePitch[nAxis];
end;

procedure TMintController.Set_MotorFluxTConst(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorFluxTConst[nAxis] := Param2;
end;

function TMintController.Get_MotorBaseFreq(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorBaseFreq[nAxis];
end;

function TMintController.Get_MotorFeedback(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorFeedback[nAxis];
end;

function TMintController.Get_MotorLinearEncoderResolution(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.MotorLinearEncoderResolution[nAxis];
end;

procedure TMintController.Set_MotorMagCurrent(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorMagCurrent[nAxis] := Param2;
end;

function TMintController.Get_MotorMagCurrentCoeff(nAxis: Smallint; nChannel: Smallint): Single;
begin
    Result := DefaultInterface.MotorMagCurrentCoeff[nAxis, nChannel];
end;

procedure TMintController.Set_MotorMagCurrentCoeff(nAxis: Smallint; nChannel: Smallint; 
                                                   Param3: Single);
begin
  DefaultInterface.MotorMagCurrentCoeff[nAxis, nChannel] := Param3;
end;

function TMintController.Get_MotorInstabilityFreq(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorInstabilityFreq[nAxis];
end;

procedure TMintController.Set_MotorInstabilityFreq(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorInstabilityFreq[nAxis] := Param2;
end;

procedure TMintController.Set_MotorLinearPolePitch(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorLinearPolePitch[nAxis] := Param2;
end;

function TMintController.Get_LatchValue(nLatchChannel: Smallint): Single;
begin
    Result := DefaultInterface.LatchValue[nLatchChannel];
end;

function TMintController.Get_MotorRatedCurrent(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorRatedCurrent[nAxis];
end;

procedure TMintController.Set_MotorRatedCurrent(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorRatedCurrent[nAxis] := Param2;
end;

procedure TMintController.Set_MotorRatedSpeed(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorRatedSpeed[nAxis] := Param2;
end;

procedure TMintController.Set_MotorRatedFreq(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorRatedFreq[nAxis] := Param2;
end;

function TMintController.Get_MotorRatedSpeed(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorRatedSpeed[nAxis];
end;

function TMintController.Get_MotorPowerMeasured(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorPowerMeasured[nAxis];
end;

function TMintController.Get_MotorRatedSpeedmmps(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorRatedSpeedmmps[nAxis];
end;

procedure TMintController.Set_MotorRatedSpeedmmps(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorRatedSpeedmmps[nAxis] := Param2;
end;

function TMintController.Get_MotorRatedSpeedRPM(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.MotorRatedSpeedRPM[nAxis];
end;

procedure TMintController.Set_MotorRatedSpeedRPM(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.MotorRatedSpeedRPM[nAxis] := Param2;
end;

function TMintController.Get_MotorRatedVolts(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorRatedVolts[nAxis];
end;

procedure TMintController.Set_MotorRatedVolts(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorRatedVolts[nAxis] := Param2;
end;

function TMintController.Get_MotorRatedFreq(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorRatedFreq[nAxis];
end;

function TMintController.Get_NetInteger(nIndex: Smallint): Integer;
begin
    Result := DefaultInterface.NetInteger[nIndex];
end;

procedure TMintController.Set_NetInteger(nIndex: Smallint; Param2: Integer);
begin
  DefaultInterface.NetInteger[nIndex] := Param2;
end;

function TMintController.Get_NodeType(nCANBus: Smallint; nNode: Smallint): Smallint;
begin
    Result := DefaultInterface.NodeType[nCANBus, nNode];
end;

procedure TMintController.Set_NetIntegerMultiple(nIndex: Smallint; nElements: Smallint; 
                                                 Param3: OleVariant);
begin
  DefaultInterface.NetIntegerMultiple[nIndex, nElements] := Param3;
end;

function TMintController.Get_NodeLive(nCANBus: Smallint; nNode: Smallint): WordBool;
begin
    Result := DefaultInterface.NodeLive[nCANBus, nNode];
end;

procedure TMintController.Set_NetFloatMultiple(nIndex: Smallint; nElements: Smallint; 
                                               Param3: OleVariant);
begin
  DefaultInterface.NetFloatMultiple[nIndex, nElements] := Param3;
end;

procedure TMintController.Set_NodeType(nCANBus: Smallint; nNode: Smallint; Param3: Smallint);
begin
  DefaultInterface.NodeType[nCANBus, nNode] := Param3;
end;

function TMintController.Get_NodeTypeExtended(nBus: Smallint; nNode: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.NodeTypeExtended[nBus, nNode];
end;

procedure TMintController.Set_NodeTypeExtended(nBus: Smallint; nNode: Smallint; Param3: OleVariant);
begin
  DefaultInterface.NodeTypeExtended[nBus, nNode] := Param3;
end;

function TMintController.Get_NumberOf(nItem: Smallint): Smallint;
begin
    Result := DefaultInterface.NumberOf[nItem];
end;

procedure TMintController.Set_NumberOf(nItem: Smallint; Param2: Smallint);
begin
  DefaultInterface.NumberOf[nItem] := Param2;
end;

function TMintController.Get_NumberOfExtended(nItem: Smallint; nParameter: Smallint): Smallint;
begin
    Result := DefaultInterface.NumberOfExtended[nItem, nParameter];
end;

procedure TMintController.Set_MotorPoles(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MotorPoles[nAxis] := Param2;
end;

function TMintController.Get_MotorStatorLeakageInd(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorStatorLeakageInd[nAxis];
end;

procedure TMintController.Set_MotorSpeedMaxmmps(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorSpeedMaxmmps[nAxis] := Param2;
end;

function TMintController.Get_MotorSpeedMaxRPM(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorSpeedMaxRPM[nAxis];
end;

function TMintController.Get_MotorResolverOffset(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorResolverOffset[nAxis];
end;

function TMintController.Get_MotorStabilityGain(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorStabilityGain[nAxis];
end;

procedure TMintController.Set_MotorStabilityGain(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorStabilityGain[nAxis] := Param2;
end;

function TMintController.Get_MotorTemperatureMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorTemperatureMode[nAxis];
end;

procedure TMintController.Set_MotorTemperatureMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MotorTemperatureMode[nAxis] := Param2;
end;

function TMintController.Get_MotorStatorRes(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorStatorRes[nAxis];
end;

procedure TMintController.Set_MotorSpeedMaxRPM(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MotorSpeedMaxRPM[nAxis] := Param2;
end;

procedure TMintController.Set_MotorStatorLeakageInd(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorStatorLeakageInd[nAxis] := Param2;
end;

procedure TMintController.Set_MotorTemperatureInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MotorTemperatureInput[nAxis] := Param2;
end;

procedure TMintController.Set_MotorPeakCurrent(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorPeakCurrent[nAxis] := Param2;
end;

procedure TMintController.Set_MotorMagCurrentMax(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorMagCurrentMax[nAxis] := Param2;
end;

function TMintController.Get_MotorMagCurrentMin(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorMagCurrentMin[nAxis];
end;

procedure TMintController.Set_MotorMagCurrentMin(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorMagCurrentMin[nAxis] := Param2;
end;

function TMintController.Get_MotorMagInd(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorMagInd[nAxis];
end;

procedure TMintController.Set_MotorMagInd(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorMagInd[nAxis] := Param2;
end;

function TMintController.Get_MotorOverloadArea(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorOverloadArea[nAxis];
end;

function TMintController.Get_MotorPoles(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorPoles[nAxis];
end;

procedure TMintController.Set_MotorOverloadMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MotorOverloadMode[nAxis] := Param2;
end;

function TMintController.Get_MotorPeakCurrent(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorPeakCurrent[nAxis];
end;

function TMintController.Get_MotorOverloadMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorOverloadMode[nAxis];
end;

function TMintController.Get_MotorPeakDuration(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorPeakDuration[nAxis];
end;

procedure TMintController.Set_MotorPeakDuration(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MotorPeakDuration[nAxis] := Param2;
end;

function TMintController.Get_NetFloat(nIndex: Smallint): Single;
begin
    Result := DefaultInterface.NetFloat[nIndex];
end;

procedure TMintController.Set_NetFloat(nIndex: Smallint; Param2: Single);
begin
  DefaultInterface.NetFloat[nIndex] := Param2;
end;

function TMintController.Get_MoveRTest(nAxis: Smallint; nParam: Smallint): Single;
begin
    Result := DefaultInterface.MoveRTest[nAxis, nParam];
end;

procedure TMintController.Set_MoveDwell(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.MoveDwell[nAxis] := Param2;
end;

procedure TMintController.Set_MoveR(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MoveR[nAxis] := Param2;
end;

function TMintController.Get_MultipleCommandsExecute(nFlags: Integer): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.MultipleCommandsExecute;
end;

function TMintController.Get_MotorType(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MotorType[nAxis];
end;

procedure TMintController.Set_MotorType(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MotorType[nAxis] := Param2;
end;

procedure TMintController.Set_MoveA(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MoveA[nAxis] := Param2;
end;

procedure TMintController.Set_MoveRTest(nAxis: Smallint; nParam: Smallint; Param3: Single);
begin
  DefaultInterface.MoveRTest[nAxis, nParam] := Param3;
end;

function TMintController.Get_MoveStatus(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MoveStatus[nAxis];
end;

procedure TMintController.Set_MoveBufferSize(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MoveBufferSize[nAxis] := Param2;
end;

procedure TMintController.Set_MoveCorrection(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.MoveCorrection[nAxis] := Param2;
end;

function TMintController.Get_ListOf(nListOf: Smallint; nParameter: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ListOf[nListOf, nParameter];
end;

function TMintController.Get_LimitMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.LimitMode[nAxis];
end;

procedure TMintController.Set_LimitMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.LimitMode[nAxis] := Param2;
end;

procedure TMintController.Set_LimitForwardInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.LimitForwardInput[nAxis] := Param2;
end;

function TMintController.Get_LimitReverseInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.LimitReverseInput[nAxis];
end;

procedure TMintController.Set_LimitReverseInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.LimitReverseInput[nAxis] := Param2;
end;

procedure TMintController.Set_MoveOutX(nAxis: Smallint; nChannel: Smallint; Param3: WordBool);
begin
  DefaultInterface.MoveOutX[nAxis, nChannel] := Param3;
end;

procedure TMintController.Set_MovePulseOutX(nAxis: Smallint; nChannel: Smallint; Param3: Integer);
begin
  DefaultInterface.MovePulseOutX[nAxis, nChannel] := Param3;
end;

function TMintController.Get_MoveBufferStatus(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MoveBufferStatus[nAxis];
end;

function TMintController.Get_LimitReverse(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.LimitReverse[nAxis];
end;

function TMintController.Get_MotorMagCurrentMax(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.MotorMagCurrentMax[nAxis];
end;

procedure TMintController.Set_MoveOut(nAxis: Smallint; nOutputBank: Smallint; Param3: Integer);
begin
  DefaultInterface.MoveOut[nAxis, nOutputBank] := Param3;
end;

function TMintController.Get_MotorTemperatureSwitch(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.MotorTemperatureSwitch[nAxis];
end;

procedure TMintController.Set_OffsetDistance(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.OffsetDistance[nAxis] := Param2;
end;

function TMintController.Get_OkToLoadMove(nNumberOfAxes: Smallint; nAxisArray: OleVariant): WordBool;
begin
    Result := DefaultInterface.OkToLoadMove[nNumberOfAxes, nAxisArray];
end;

function TMintController.Get_OptionCardBus(nSlot: Smallint): Smallint;
begin
    Result := DefaultInterface.OptionCardBus[nSlot];
end;

function TMintController.Get_NVFloat(nAddress: Smallint): Single;
begin
    Result := DefaultInterface.NVFloat[nAddress];
end;

procedure TMintController.Set_NVFloat(nAddress: Smallint; Param2: Single);
begin
  DefaultInterface.NVFloat[nAddress] := Param2;
end;

function TMintController.Get_NVLong(nAddress: Smallint): Integer;
begin
    Result := DefaultInterface.NVLong[nAddress];
end;

function TMintController.Get_OffsetStatus(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.OffsetStatus[nAxis];
end;

procedure TMintController.Set_NumberOfExtended(nItem: Smallint; nParameter: Smallint; 
                                               Param3: Smallint);
begin
  DefaultInterface.NumberOfExtended[nItem, nParameter] := Param3;
end;

function TMintController.Get_NetIntegerMultiple(nIndex: Smallint; nElements: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.NetIntegerMultiple[nIndex, nElements];
end;

function TMintController.Get_OptionCardNetworkAddress(nSlot: Smallint): Integer;
begin
    Result := DefaultInterface.OptionCardNetworkAddress[nSlot];
end;

function TMintController.Get_OffsetMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.OffsetMode[nAxis];
end;

procedure TMintController.Set_OffsetMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.OffsetMode[nAxis] := Param2;
end;

function TMintController.Get_OffsetDistance(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.OffsetDistance[nAxis];
end;

function TMintController.Get_MoveBufferLow(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MoveBufferLow[nAxis];
end;

procedure TMintController.Set_MoveBufferLow(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.MoveBufferLow[nAxis] := Param2;
end;

function TMintController.Get_MoveBufferSize(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MoveBufferSize[nAxis];
end;

function TMintController.Get_MotorTestMode(nParam: Smallint): Single;
begin
    Result := DefaultInterface.MotorTestMode[nParam];
end;

procedure TMintController.Set_MotorTestMode(nParam: Smallint; Param2: Single);
begin
  DefaultInterface.MotorTestMode[nParam] := Param2;
end;

function TMintController.Get_MoveBufferFree(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.MoveBufferFree[nAxis];
end;

function TMintController.Get_NetFloatMultiple(nIndex: Smallint; nElements: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.NetFloatMultiple[nIndex, nElements];
end;

procedure TMintController.Set_NVLong(nAddress: Smallint; Param2: Integer);
begin
  DefaultInterface.NVLong[nAddress] := Param2;
end;

procedure TMintController.Set_Offset(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Offset[nAxis] := Param2;
end;

function TMintController.Get_MoveBufferID(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.MoveBufferID[nAxis];
end;

procedure TMintController.Set_MoveBufferID(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.MoveBufferID[nAxis] := Param2;
end;

function TMintController.Get_MoveBufferIDLast(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.MoveBufferIDLast[nAxis];
end;

function TMintController.Get_PosRef(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.PosRef[nAxis];
end;

procedure TMintController.Set_PosRef(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.PosRef[nAxis] := Param2;
end;

function TMintController.Get_PosRemaining(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.PosRemaining[nAxis];
end;

function TMintController.Get_PLXData(nAddress: Smallint): Integer;
begin
    Result := DefaultInterface.PLXData[nAddress];
end;

procedure TMintController.Set_PLXData(nAddress: Smallint; Param2: Integer);
begin
  DefaultInterface.PLXData[nAddress] := Param2;
end;

function TMintController.Get_PosDemand(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.PosDemand[nAxis];
end;

procedure TMintController.Set_PosWrap(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.PosWrap[nAxis] := Param2;
end;

procedure TMintController.Set_PrecisionSourceChannel(nAxisOrChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.PrecisionSourceChannel[nAxisOrChannel] := Param2;
end;

function TMintController.Get_PresetAccel(nPreset: Smallint; nFmt: Smallint): Single;
begin
    Result := DefaultInterface.PresetAccel[nPreset, nFmt];
end;

procedure TMintController.Set_PosDemand(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.PosDemand[nAxis] := Param2;
end;

function TMintController.Get_PositionControlLooptime(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PositionControlLooptime[nAxis];
end;

procedure TMintController.Set_PositionControlLooptime(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PositionControlLooptime[nAxis] := Param2;
end;

function TMintController.Get_PLCTaskStatus(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.PLCTaskStatus[nChannel];
end;

procedure TMintController.Set_PosTrimGain(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.PosTrimGain[nAxis] := Param2;
end;

function TMintController.Get_PosWrap(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.PosWrap[nAxis];
end;

procedure TMintController.Set_PosScaleUnits(nAxis: Smallint; const Param2: WideString);
  { Warning: The property PosScaleUnits has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.PosScaleUnits := Param2;
end;

function TMintController.Get_PosRolloverTarget(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.PosRolloverTarget[nAxis];
end;

function TMintController.Get_PosScaleUnits(nAxis: Smallint): WideString;
begin
    Result := DefaultInterface.PosScaleUnits[nAxis];
end;

function TMintController.Get_PosTrimGain(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.PosTrimGain[nAxis];
end;

function TMintController.Get_Pos(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Pos[nAxis];
end;

procedure TMintController.Set_Pos(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Pos[nAxis] := Param2;
end;

function TMintController.Get_PosAchieved(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.PosAchieved[nAxis];
end;

function TMintController.Get_PosTarget(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.PosTarget[nAxis];
end;

function TMintController.Get_PosTargetLast(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.PosTargetLast[nAxis];
end;

function TMintController.Get_PosRollover(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.PosRollover[nAxis];
end;

procedure TMintController.Set_PresetAccel(nPreset: Smallint; nFmt: Smallint; Param3: Single);
begin
  DefaultInterface.PresetAccel[nPreset, nFmt] := Param3;
end;

function TMintController.Get_PowerReadyInput(nParam: Smallint): Smallint;
begin
    Result := DefaultInterface.PowerReadyInput[nParam];
end;

function TMintController.Get_PrecisionAxis(nAxisOrChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.PrecisionAxis[nAxisOrChannel];
end;

function TMintController.Get_PrecisionMode(nAxisOrChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.PrecisionMode[nAxisOrChannel];
end;

procedure TMintController.Set_PowerReadyOutput(nParam: Smallint; Param2: Smallint);
begin
  DefaultInterface.PowerReadyOutput[nParam] := Param2;
end;

function TMintController.Get_PowerbaseParameter(nParam: Smallint): Single;
begin
    Result := DefaultInterface.PowerbaseParameter[nParam];
end;

procedure TMintController.Set_PowerbaseParameter(nParam: Smallint; Param2: Single);
begin
  DefaultInterface.PowerbaseParameter[nParam] := Param2;
end;

function TMintController.Get_PrecisionIncrement(nAxisOrChannel: Smallint): Single;
begin
    Result := DefaultInterface.PrecisionIncrement[nAxisOrChannel];
end;

procedure TMintController.Set_PrecisionIncrement(nAxisOrChannel: Smallint; Param2: Single);
begin
  DefaultInterface.PrecisionIncrement[nAxisOrChannel] := Param2;
end;

function TMintController.Get_OutputMonitorModeParameter(nOutput: Smallint): Smallint;
begin
    Result := DefaultInterface.OutputMonitorModeParameter[nOutput];
end;

procedure TMintController.Set_PrecisionMode(nAxisOrChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.PrecisionMode[nAxisOrChannel] := Param2;
end;

function TMintController.Get_PrecisionOffset(nAxisOrChannel: Smallint): Single;
begin
    Result := DefaultInterface.PrecisionOffset[nAxisOrChannel];
end;

procedure TMintController.Set_PrecisionAxis(nAxisOrChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.PrecisionAxis[nAxisOrChannel] := Param2;
end;

function TMintController.Get_PowerReadyOutput(nParam: Smallint): Smallint;
begin
    Result := DefaultInterface.PowerReadyOutput[nParam];
end;

function TMintController.Get_PresetDecel(nPreset: Smallint; nFmt: Smallint): Single;
begin
    Result := DefaultInterface.PresetDecel[nPreset, nFmt];
end;

function TMintController.Get_PresetIndex(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PresetIndex[nAxis];
end;

procedure TMintController.Set_PresetIndex(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PresetIndex[nAxis] := Param2;
end;

function TMintController.Get_PrecisionSource(nAxisOrChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.PrecisionSource[nAxisOrChannel];
end;

procedure TMintController.Set_PrecisionSource(nAxisOrChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.PrecisionSource[nAxisOrChannel] := Param2;
end;

function TMintController.Get_PrecisionSourceChannel(nAxisOrChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.PrecisionSourceChannel[nAxisOrChannel];
end;

procedure TMintController.Set_PresetDwellTime(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.PresetDwellTime[nAxis] := Param2;
end;

procedure TMintController.Set_PrecisionOffset(nAxisOrChannel: Smallint; Param2: Single);
begin
  DefaultInterface.PrecisionOffset[nAxisOrChannel] := Param2;
end;

procedure TMintController.Set_PowerReadyInput(nParam: Smallint; Param2: Smallint);
begin
  DefaultInterface.PowerReadyInput[nParam] := Param2;
end;

function TMintController.Get_PresetIndexMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PresetIndexMode[nAxis];
end;

procedure TMintController.Set_PresetDecel(nPreset: Smallint; nFmt: Smallint; Param3: Single);
begin
  DefaultInterface.PresetDecel[nPreset, nFmt] := Param3;
end;

function TMintController.Get_PresetDwellTime(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.PresetDwellTime[nAxis];
end;

function TMintController.Get_SuspendSwitch(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.SuspendSwitch[nAxis];
end;

function TMintController.Get_Temperature(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.Temperature[nChannel];
end;

procedure TMintController.Set_TorqueFilterBand(nAxis: Smallint; nStage: Smallint; Param3: Single);
begin
  DefaultInterface.TorqueFilterBand[nAxis, nStage] := Param3;
end;

function TMintController.Get_TemperatureLimitWarning(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.TemperatureLimitWarning[nChannel];
end;

function TMintController.Get_TerminalAddress(nTerminalID: Integer): Smallint;
begin
    Result := DefaultInterface.TerminalAddress[nTerminalID];
end;

procedure TMintController.Set_SuspendInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.SuspendInput[nAxis] := Param2;
end;

function TMintController.Get_TorqueRefEnable(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.TorqueRefEnable[nAxis];
end;

procedure TMintController.Set_TorqueRefEnable(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.TorqueRefEnable[nAxis] := Param2;
end;

function TMintController.Get_TorqueRefErrorFallTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.TorqueRefErrorFallTime[nAxis];
end;

procedure TMintController.Set_TorqueRefErrorFallTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.TorqueRefErrorFallTime[nAxis] := Param2;
end;

function TMintController.Get_TorqueRefFallTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.TorqueRefFallTime[nAxis];
end;

procedure TMintController.Set_TorqueRefFallTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.TorqueRefFallTime[nAxis] := Param2;
end;

function TMintController.Get_TemperatureLimitFatal(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.TemperatureLimitFatal[nChannel];
end;

function TMintController.Get_Torque(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Torque[nAxis];
end;

procedure TMintController.Set_TerminalAddress(nTerminalID: Integer; Param2: Smallint);
begin
  DefaultInterface.TerminalAddress[nTerminalID] := Param2;
end;

function TMintController.Get_StopSwitch(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.StopSwitch[nAxis];
end;

function TMintController.Get_TorqueFilterBand(nAxis: Smallint; nStage: Smallint): Single;
begin
    Result := DefaultInterface.TorqueFilterBand[nAxis, nStage];
end;

function TMintController.Get_TimeScale(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.TimeScale[nAxis];
end;

procedure TMintController.Set_TimeScale(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.TimeScale[nAxis] := Param2;
end;

function TMintController.Get_StopMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.StopMode[nAxis];
end;

procedure TMintController.Set_StopMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.StopMode[nAxis] := Param2;
end;

function TMintController.Get_SuspendInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.SuspendInput[nAxis];
end;

function TMintController.Get_Suspend(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.Suspend[nAxis];
end;

procedure TMintController.Set_Suspend(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.Suspend[nAxis] := Param2;
end;

procedure TMintController.Set_StopInputMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.StopInputMode[nAxis] := Param2;
end;

function TMintController.Get_TorqueRefRiseTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.TorqueRefRiseTime[nAxis];
end;

function TMintController.Get_TorqueRef(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.TorqueRef[nAxis];
end;

procedure TMintController.Set_TorqueLimitNeg(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.TorqueLimitNeg[nAxis] := Param2;
end;

function TMintController.Get_TorqueLimitPos(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.TorqueLimitPos[nAxis];
end;

function TMintController.Get_TorqueLimitNeg(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.TorqueLimitNeg[nAxis];
end;

function TMintController.Get_TorqueProvingMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.TorqueProvingMode[nAxis];
end;

procedure TMintController.Set_TorqueProvingMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.TorqueProvingMode[nAxis] := Param2;
end;

procedure TMintController.Set_PosScaleFactor(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.PosScaleFactor[nAxis] := Param2;
end;

procedure TMintController.Set_PosRollover(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.PosRollover[nAxis] := Param2;
end;

function TMintController.Get_PosRolloverDemand(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.PosRolloverDemand[nAxis];
end;

procedure TMintController.Set_TorqueLimitPos(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.TorqueLimitPos[nAxis] := Param2;
end;

function TMintController.Get_PosRolloverTargetLast(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.PosRolloverTargetLast[nAxis];
end;

function TMintController.Get_PosScaleFactor(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.PosScaleFactor[nAxis];
end;

function TMintController.Get_TorqueFilterFreq(nAxis: Smallint; nStage: Smallint): Single;
begin
    Result := DefaultInterface.TorqueFilterFreq[nAxis, nStage];
end;

procedure TMintController.Set_TorqueRefRiseTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.TorqueRefRiseTime[nAxis] := Param2;
end;

function TMintController.Get_TorqueRefSource(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.TorqueRefSource[nAxis];
end;

procedure TMintController.Set_TorqueRefSource(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.TorqueRefSource[nAxis] := Param2;
end;

function TMintController.Get_TriggerChannel(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.TriggerChannel[nAxis];
end;

procedure TMintController.Set_TriggerChannel(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.TriggerChannel[nAxis] := Param2;
end;

function TMintController.Get_TriggerCompensation(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.TriggerCompensation[nAxis];
end;

procedure TMintController.Set_TorqueFilterType(nAxis: Smallint; nStage: Smallint; Param3: Smallint);
begin
  DefaultInterface.TorqueFilterType[nAxis, nStage] := Param3;
end;

function TMintController.Get_TorqueFilterDepth(nAxis: Smallint; nStage: Smallint): Single;
begin
    Result := DefaultInterface.TorqueFilterDepth[nAxis, nStage];
end;

procedure TMintController.Set_TorqueFilterDepth(nAxis: Smallint; nStage: Smallint; Param3: Single);
begin
  DefaultInterface.TorqueFilterDepth[nAxis, nStage] := Param3;
end;

procedure TMintController.Set_TorqueRef(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.TorqueRef[nAxis] := Param2;
end;

procedure TMintController.Set_TorqueFilterFreq(nAxis: Smallint; nStage: Smallint; Param3: Single);
begin
  DefaultInterface.TorqueFilterFreq[nAxis, nStage] := Param3;
end;

function TMintController.Get_TorqueFilterType(nAxis: Smallint; nStage: Smallint): Smallint;
begin
    Result := DefaultInterface.TorqueFilterType[nAxis, nStage];
end;

procedure TMintController.Set_OutputMonitorModeParameter(nOutput: Smallint; Param2: Smallint);
begin
  DefaultInterface.OutputMonitorModeParameter[nOutput] := Param2;
end;

procedure TMintController.Set_RemoteNumberOf(nBus: Smallint; nNode: Smallint; nItem: Smallint; 
                                             Param4: Smallint);
begin
  DefaultInterface.RemoteNumberOf[nBus, nNode, nItem] := Param4;
end;

function TMintController.Get_RemoteInBank(nCANBus: Smallint; nNode: Smallint; nBank: Smallint): Integer;
begin
    Result := DefaultInterface.RemoteInBank[nCANBus, nNode, nBank];
end;

function TMintController.Get_RemoteInhibitTime(nBus: Smallint): Smallint;
begin
    Result := DefaultInterface.RemoteInhibitTime[nBus];
end;

procedure TMintController.Set_RemoteOut(nCANBus: Smallint; nNode: Smallint; Param3: Integer);
begin
  DefaultInterface.RemoteOut[nCANBus, nNode] := Param3;
end;

function TMintController.Get_RemoteOutBank(nCANBus: Smallint; nNode: Smallint; nBank: Smallint): Integer;
begin
    Result := DefaultInterface.RemoteOutBank[nCANBus, nNode, nBank];
end;

procedure TMintController.Set_RemoteOutBank(nCANBus: Smallint; nNode: Smallint; nBank: Smallint; 
                                            Param4: Integer);
begin
  DefaultInterface.RemoteOutBank[nCANBus, nNode, nBank] := Param4;
end;

function TMintController.Get_RemoteIn(nCANBus: Smallint; nNode: Smallint): Integer;
begin
    Result := DefaultInterface.RemoteIn[nCANBus, nNode];
end;

function TMintController.Get_RemoteInputActiveLevel(nCANBus: Smallint; nNode: Smallint): Integer;
begin
    Result := DefaultInterface.RemoteInputActiveLevel[nCANBus, nNode];
end;

procedure TMintController.Set_RemoteMode(nCANBus: Smallint; nNode: Smallint; Param3: Smallint);
begin
  DefaultInterface.RemoteMode[nCANBus, nNode] := Param3;
end;

procedure TMintController.Set_RemoteInhibitTime(nBus: Smallint; Param2: Smallint);
begin
  DefaultInterface.RemoteInhibitTime[nBus] := Param2;
end;

function TMintController.Get_RemoteEStop(nCANBus: Smallint; nNode: Smallint): WordBool;
begin
    Result := DefaultInterface.RemoteEStop[nCANBus, nNode];
end;

procedure TMintController.Set_RemoteEStop(nCANBus: Smallint; nNode: Smallint; Param3: WordBool);
begin
  DefaultInterface.RemoteEStop[nCANBus, nNode] := Param3;
end;

function TMintController.Get_RemoteOutputError(nCANBus: Smallint; nNode: Smallint): Integer;
begin
    Result := DefaultInterface.RemoteOutputError[nCANBus, nNode];
end;

procedure TMintController.Set_RemoteObjectFloat(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                                nSubIndex: Smallint; Param5: Single);
begin
  DefaultInterface.RemoteObjectFloat[nBus, nNode, nIndex, nSubIndex] := Param5;
end;

function TMintController.Get_RemoteObjectString(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                                nSubIndex: Smallint): WideString;
begin
    Result := DefaultInterface.RemoteObjectString[nBus, nNode, nIndex, nSubIndex];
end;

procedure TMintController.Set_RemoteObjectString(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                                 nSubIndex: Smallint; const Param5: WideString);
  { Warning: The property RemoteObjectString has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.RemoteObjectString := Param5;
end;

procedure TMintController.Set_PhaseSearchInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PhaseSearchInput[nAxis] := Param2;
end;

function TMintController.Get_PhaseSearchMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PhaseSearchMode[nAxis];
end;

procedure TMintController.Set_PresetIndexMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PresetIndexMode[nAxis] := Param2;
end;

function TMintController.Get_RemoteOut(nCANBus: Smallint; nNode: Smallint): Integer;
begin
    Result := DefaultInterface.RemoteOut[nCANBus, nNode];
end;

function TMintController.Get_RemoteOutputActiveLevel(nCANBus: Smallint; nNode: Smallint): Integer;
begin
    Result := DefaultInterface.RemoteOutputActiveLevel[nCANBus, nNode];
end;

procedure TMintController.Set_RemoteOutputActiveLevel(nCANBus: Smallint; nNode: Smallint; 
                                                      Param3: Integer);
begin
  DefaultInterface.RemoteOutputActiveLevel[nCANBus, nNode] := Param3;
end;

function TMintController.Get_RemoteObject(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                          nSubIndex: Smallint; nVarType: Smallint): Integer;
begin
    Result := DefaultInterface.RemoteObject[nBus, nNode, nIndex, nSubIndex, nVarType];
end;

procedure TMintController.Set_RemoteObject(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                           nSubIndex: Smallint; nVarType: Smallint; Param6: Integer);
begin
  DefaultInterface.RemoteObject[nBus, nNode, nIndex, nSubIndex, nVarType] := Param6;
end;

function TMintController.Get_RemoteObjectFloat(nBus: Smallint; nNode: Smallint; nIndex: Smallint; 
                                               nSubIndex: Smallint): Single;
begin
    Result := DefaultInterface.RemoteObjectFloat[nBus, nNode, nIndex, nSubIndex];
end;

procedure TMintController.Set_RemoteNode(nCANBus: Smallint; Param2: Smallint);
begin
  DefaultInterface.RemoteNode[nCANBus] := Param2;
end;

function TMintController.Get_SentinelLatch(nChannel: Smallint): WordBool;
begin
    Result := DefaultInterface.SentinelLatch[nChannel];
end;

function TMintController.Get_SentinelPeriod(nSentinelChannel: Smallint): Integer;
begin
    Result := DefaultInterface.SentinelPeriod[nSentinelChannel];
end;

procedure TMintController.Set_ScaleFactor(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.ScaleFactor[nAxis] := Param2;
end;

function TMintController.Get_SentinelSource(nSentinelChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.SentinelSource[nSentinelChannel];
end;

procedure TMintController.Set_SentinelSource(nSentinelChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.SentinelSource[nSentinelChannel] := Param2;
end;

procedure TMintController.Set_SentinelActionParameter(nSentinelChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.SentinelActionParameter[nSentinelChannel] := Param2;
end;

function TMintController.Get_RemoteOutX(nCANBus: Smallint; nNode: Smallint; nOutput: Smallint): WordBool;
begin
    Result := DefaultInterface.RemoteOutX[nCANBus, nNode, nOutput];
end;

procedure TMintController.Set_RemoteOutX(nCANBus: Smallint; nNode: Smallint; nOutput: Smallint; 
                                         Param4: WordBool);
begin
  DefaultInterface.RemoteOutX[nCANBus, nNode, nOutput] := Param4;
end;

function TMintController.Get_RemotePDOIn(nBus: Smallint; lCOBID: Integer; nBank: Smallint): Integer;
begin
    Result := DefaultInterface.RemotePDOIn[nBus, lCOBID, nBank];
end;

function TMintController.Get_RemotePDOMode(nBus: Smallint; nNode: Smallint): Smallint;
begin
    Result := DefaultInterface.RemotePDOMode[nBus, nNode];
end;

procedure TMintController.Set_RemotePDOMode(nBus: Smallint; nNode: Smallint; Param3: Smallint);
begin
  DefaultInterface.RemotePDOMode[nBus, nNode] := Param3;
end;

function TMintController.Get_RemotePDOValid(nBus: Smallint; nNode: Smallint): WordBool;
begin
    Result := DefaultInterface.RemotePDOValid[nBus, nNode];
end;

procedure TMintController.Set_SentinelPeriod(nSentinelChannel: Smallint; Param2: Integer);
begin
  DefaultInterface.SentinelPeriod[nSentinelChannel] := Param2;
end;

function TMintController.Get_RemoteMode(nCANBus: Smallint; nNode: Smallint): Smallint;
begin
    Result := DefaultInterface.RemoteMode[nCANBus, nNode];
end;

procedure TMintController.Set_RemoteOutputError(nCANBus: Smallint; nNode: Smallint; Param3: Integer);
begin
  DefaultInterface.RemoteOutputError[nCANBus, nNode] := Param3;
end;

procedure TMintController.Set_SentinelAction(nSentinelChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.SentinelAction[nSentinelChannel] := Param2;
end;

function TMintController.Get_RemoteNumberOf(nBus: Smallint; nNode: Smallint; nItem: Smallint): Smallint;
begin
    Result := DefaultInterface.RemoteNumberOf[nBus, nNode, nItem];
end;

procedure TMintController.Set_RemoteInputActiveLevel(nCANBus: Smallint; nNode: Smallint; 
                                                     Param3: Integer);
begin
  DefaultInterface.RemoteInputActiveLevel[nCANBus, nNode] := Param3;
end;

function TMintController.Get_RemoteInX(nCANBus: Smallint; nNode: Smallint; nInput: Smallint): WordBool;
begin
    Result := DefaultInterface.RemoteInX[nCANBus, nNode, nInput];
end;

procedure TMintController.Set_ScaleUnits(nAxis: Smallint; nChannel: Smallint; Param3: Smallint);
begin
  DefaultInterface.ScaleUnits[nAxis, nChannel] := Param3;
end;

function TMintController.Get_SentinelAction(nSentinelChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.SentinelAction[nSentinelChannel];
end;

function TMintController.Get_SentinelActionParameter(nSentinelChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.SentinelActionParameter[nSentinelChannel];
end;

function TMintController.Get_SentinelActionMode(nSentinelChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.SentinelActionMode[nSentinelChannel];
end;

procedure TMintController.Set_SentinelActionMode(nSentinelChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.SentinelActionMode[nSentinelChannel] := Param2;
end;

function TMintController.Get_ScaleUnits(nAxis: Smallint; nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.ScaleUnits[nAxis, nChannel];
end;

function TMintController.Get_OptionCardNetworkStatus(nSlot: Smallint): Smallint;
begin
    Result := DefaultInterface.OptionCardNetworkStatus[nSlot];
end;

function TMintController.Get_OptionCardObjectFloat(nSlot: Smallint; nObject: Smallint; 
                                                   lInstance: Integer; lAttribute: Integer; 
                                                   nType: Smallint): Single;
begin
    Result := DefaultInterface.OptionCardObjectFloat[nSlot, nObject, lInstance, lAttribute, nType];
end;

function TMintController.Get_OptionCardObjectString(nSlot: Smallint; nObject: Smallint; 
                                                    lInstance: Integer; lAttribute: Integer; 
                                                    nType: Smallint): WideString;
begin
    Result := DefaultInterface.OptionCardObjectString[nSlot, nObject, lInstance, lAttribute, nType];
end;

function TMintController.Get_OptionCardObjectInteger(nSlot: Smallint; nObject: Smallint; 
                                                     lInstance: Integer; lAttribute: Integer; 
                                                     nType: Smallint): Integer;
begin
    Result := DefaultInterface.OptionCardObjectInteger[nSlot, nObject, lInstance, lAttribute, nType];
end;

procedure TMintController.Set_OptionCardObjectInteger(nSlot: Smallint; nObject: Smallint; 
                                                      lInstance: Integer; lAttribute: Integer; 
                                                      nType: Smallint; Param6: Integer);
begin
  DefaultInterface.OptionCardObjectInteger[nSlot, nObject, lInstance, lAttribute, nType] := Param6;
end;

procedure TMintController.Set_OptionCardNetworkAddress(nSlot: Smallint; Param2: Integer);
begin
  DefaultInterface.OptionCardNetworkAddress[nSlot] := Param2;
end;

procedure TMintController.Set_OptionCardObjectString(nSlot: Smallint; nObject: Smallint; 
                                                     lInstance: Integer; lAttribute: Integer; 
                                                     nType: Smallint; const Param6: WideString);
  { Warning: The property OptionCardObjectString has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.OptionCardObjectString := Param6;
end;

function TMintController.Get_OptionCardStatus(nSlot: Smallint): Smallint;
begin
    Result := DefaultInterface.OptionCardStatus[nSlot];
end;

function TMintController.Get_OptionCardType(nSlot: Smallint): Smallint;
begin
    Result := DefaultInterface.OptionCardType[nSlot];
end;

function TMintController.Get_OptionCardVersion(nSlot: Smallint; nItem: Smallint): Smallint;
begin
    Result := DefaultInterface.OptionCardVersion[nSlot, nItem];
end;

function TMintController.Get_Out(nBank: Smallint): Integer;
begin
    Result := DefaultInterface.Out[nBank];
end;

procedure TMintController.Set_Out(nBank: Smallint; Param2: Integer);
begin
  DefaultInterface.Out[nBank] := Param2;
end;

procedure TMintController.Set_OptionCardObjectFloat(nSlot: Smallint; nObject: Smallint; 
                                                    lInstance: Integer; lAttribute: Integer; 
                                                    nType: Smallint; Param6: Single);
begin
  DefaultInterface.OptionCardObjectFloat[nSlot, nObject, lInstance, lAttribute, nType] := Param6;
end;

procedure TMintController.Set_OutputMonitorMode(nOutput: Smallint; Param2: Smallint);
begin
  DefaultInterface.OutputMonitorMode[nOutput] := Param2;
end;

function TMintController.Get_OutX(nOutput: Smallint): WordBool;
begin
    Result := DefaultInterface.OutX[nOutput];
end;

function TMintController.Get_ParameterValuesSubset(nSubset: Smallint; nParameter: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ParameterValuesSubset[nSubset, nParameter];
end;

function TMintController.Get_OutputType(nOutput: Smallint): Smallint;
begin
    Result := DefaultInterface.OutputType[nOutput];
end;

procedure TMintController.Set_OutputActiveLevel(nBank: Smallint; Param2: Integer);
begin
  DefaultInterface.OutputActiveLevel[nBank] := Param2;
end;

function TMintController.Get_OutputMonitorMode(nOutput: Smallint): Smallint;
begin
    Result := DefaultInterface.OutputMonitorMode[nOutput];
end;

function TMintController.Get_ParameterListString(nParameter: Smallint; nEnumeration: Smallint): WideString;
begin
    Result := DefaultInterface.ParameterListString[nParameter, nEnumeration];
end;

function TMintController.Get_ParameterNumberSubset(nSubset: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.ParameterNumberSubset;
end;

function TMintController.Get_OutputActiveLevel(nBank: Smallint): Integer;
begin
    Result := DefaultInterface.OutputActiveLevel[nBank];
end;

function TMintController.Get_ParamSaveMode(nChannel: Smallint): WordBool;
begin
    Result := DefaultInterface.ParamSaveMode[nChannel];
end;

procedure TMintController.Set_ParamSaveMode(nChannel: Smallint; Param2: WordBool);
begin
  DefaultInterface.ParamSaveMode[nChannel] := Param2;
end;

procedure TMintController.Set_OutX(nOutput: Smallint; Param2: WordBool);
begin
  DefaultInterface.OutX[nOutput] := Param2;
end;

function TMintController.Get_PDOLossMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PDOLossMode[nAxis];
end;

function TMintController.Get_PhaseSearchCurrent(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.PhaseSearchCurrent[nAxis];
end;

procedure TMintController.Set_PDOLossMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PDOLossMode[nAxis] := Param2;
end;

function TMintController.Get_PhaseSearchBackoff(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PhaseSearchBackoff[nAxis];
end;

function TMintController.Get_PhaseSearchSpeed(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PhaseSearchSpeed[nAxis];
end;

function TMintController.Get_PhaseSearchBandwidth(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.PhaseSearchBandwidth[nAxis];
end;

procedure TMintController.Set_PhaseSearchBandwidth(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.PhaseSearchBandwidth[nAxis] := Param2;
end;

function TMintController.Get_PhaseSearchOutput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PhaseSearchOutput[nAxis];
end;

procedure TMintController.Set_PhaseSearchOutput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PhaseSearchOutput[nAxis] := Param2;
end;

function TMintController.Get_PhaseSearchInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PhaseSearchInput[nAxis];
end;

procedure TMintController.Set_PhaseSearchBackoff(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PhaseSearchBackoff[nAxis] := Param2;
end;

procedure TMintController.Set_PhaseSearchCurrent(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.PhaseSearchCurrent[nAxis] := Param2;
end;

procedure TMintController.Set_PhaseSearchMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PhaseSearchMode[nAxis] := Param2;
end;

procedure TMintController.Set_PLCOperator(nChannel: Smallint; nConditionNo: Smallint; 
                                          Param3: Smallint);
begin
  DefaultInterface.PLCOperator[nChannel, nConditionNo] := Param3;
end;

procedure TMintController.Set_PhaseSearchSpeed(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PhaseSearchSpeed[nAxis] := Param2;
end;

function TMintController.Get_PhaseSearchStatus(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.PhaseSearchStatus[nAxis];
end;

function TMintController.Get_PhaseSearchTravel(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.PhaseSearchTravel[nAxis];
end;

procedure TMintController.Set_PhaseSearchTravel(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.PhaseSearchTravel[nAxis] := Param2;
end;

function TMintController.Get_PLCCondition(nChannel: Smallint; nConditionNo: Smallint): Smallint;
begin
    Result := DefaultInterface.PLCCondition[nChannel, nConditionNo];
end;

procedure TMintController.Set_PLCCondition(nChannel: Smallint; nConditionNo: Smallint; 
                                           Param3: Smallint);
begin
  DefaultInterface.PLCCondition[nChannel, nConditionNo] := Param3;
end;

function TMintController.Get_PLCTaskData(nChannel: Smallint; var pnCondition1: Smallint; 
                                         var pnParam1: Smallint; var pnOperator: Smallint; 
                                         var pnCondition2: Smallint; var pnParam2: Smallint): WordBool;
begin
    Result := DefaultInterface.PLCTaskData[nChannel, pnCondition1, pnParam1, pnOperator, 
                                           pnCondition2, pnParam2];
end;

procedure TMintController.Set_PLCEnableAction(nChannel: Smallint; Param2: WordBool);
begin
  DefaultInterface.PLCEnableAction[nChannel] := Param2;
end;

function TMintController.Get_PLCOperator(nChannel: Smallint; nConditionNo: Smallint): Smallint;
begin
    Result := DefaultInterface.PLCOperator[nChannel, nConditionNo];
end;

function TMintController.Get_PLCEnableAction(nChannel: Smallint): WordBool;
begin
    Result := DefaultInterface.PLCEnableAction[nChannel];
end;

function TMintController.Get_PLCParameter(nChannel: Smallint; nConditionNo: Smallint): Smallint;
begin
    Result := DefaultInterface.PLCParameter[nChannel, nConditionNo];
end;

procedure TMintController.Set_PLCParameter(nChannel: Smallint; nConditionNo: Smallint; 
                                           Param3: Smallint);
begin
  DefaultInterface.PLCParameter[nChannel, nConditionNo] := Param3;
end;

function TMintController.Get_TorqueDemand(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.TorqueDemand[nAxis];
end;

function TMintController.Get_StopInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.StopInput[nAxis];
end;

procedure TMintController.Set_StopInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.StopInput[nAxis] := Param2;
end;

procedure TMintController.Set_StepperScale(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.StepperScale[nChannel] := Param2;
end;

function TMintController.Get_StepperIO(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.StepperIO[nAxis];
end;

function TMintController.Get_StepperScale(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.StepperScale[nChannel];
end;

procedure TMintController.Set_StepperWrap(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.StepperWrap[nChannel] := Param2;
end;

function TMintController.Get_SplineStart(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.SplineStart[nAxis];
end;

procedure TMintController.Set_SplineStart(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.SplineStart[nAxis] := Param2;
end;

function TMintController.Get_SplineSuspendTime(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.SplineSuspendTime[nAxis];
end;

function TMintController.Get_StepperVel(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.StepperVel[nChannel];
end;

function TMintController.Get_StepperWrap(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.StepperWrap[nChannel];
end;

procedure TMintController.Set_Stepper(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.Stepper[nChannel] := Param2;
end;

procedure TMintController.Set_StepperDelay(nChannel: Smallint; Param2: Single);
begin
  DefaultInterface.StepperDelay[nChannel] := Param2;
end;

function TMintController.Get_SpeedRefDecelTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedRefDecelTime[nAxis];
end;

procedure TMintController.Set_SpeedRefAccelTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedRefAccelTime[nAxis] := Param2;
end;

function TMintController.Get_SpeedRefDecelJerkEndTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedRefDecelJerkEndTime[nAxis];
end;

function TMintController.Get_SpeedRefAccelTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedRefAccelTime[nAxis];
end;

function TMintController.Get_SpeedRefDecelJerkStartTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedRefDecelJerkStartTime[nAxis];
end;

procedure TMintController.Set_SpeedRefDecelJerkStartTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedRefDecelJerkStartTime[nAxis] := Param2;
end;

function TMintController.Get_StepperMode(nChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.StepperMode[nChannel];
end;

procedure TMintController.Set_StepperMode(nChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.StepperMode[nChannel] := Param2;
end;

function TMintController.Get_StepperDelay(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.StepperDelay[nChannel];
end;

procedure TMintController.Set_SpeedRefDecelJerkEndTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedRefDecelJerkEndTime[nAxis] := Param2;
end;

procedure TMintController.Set_Spline(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.Spline[nAxis] := Param2;
end;

procedure TMintController.Set_StepperIO(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.StepperIO[nAxis] := Param2;
end;

function TMintController.Get_SplineEnd(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.SplineEnd[nAxis];
end;

function TMintController.Get_SoftLimitReverse(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SoftLimitReverse[nAxis];
end;

procedure TMintController.Set_SoftLimitReverse(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SoftLimitReverse[nAxis] := Param2;
end;

function TMintController.Get_SoftwareDiagnostic(nParam1: Smallint; nParam2: Smallint): Integer;
begin
    Result := DefaultInterface.SoftwareDiagnostic[nParam1, nParam2];
end;

function TMintController.Get_SerialBaud(nPort: Smallint): Integer;
begin
    Result := DefaultInterface.SerialBaud[nPort];
end;

procedure TMintController.Set_SerialBaud(nPort: Smallint; Param2: Integer);
begin
  DefaultInterface.SerialBaud[nPort] := Param2;
end;

function TMintController.Get_SoftLimitForward(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SoftLimitForward[nAxis];
end;

function TMintController.Get_SentinelTriggerValueInteger(nSentinelChannel: Smallint; 
                                                         nSentinelBand: Smallint): Integer;
begin
    Result := DefaultInterface.SentinelTriggerValueInteger[nSentinelChannel, nSentinelBand];
end;

procedure TMintController.Set_SentinelSource2(nSentinelChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.SentinelSource2[nSentinelChannel] := Param2;
end;

function TMintController.Get_SentinelSource2Parameter(nSentinelChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.SentinelSource2Parameter[nSentinelChannel];
end;

procedure TMintController.Set_SoftLimitForward(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SoftLimitForward[nAxis] := Param2;
end;

function TMintController.Get_SoftLimitMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.SoftLimitMode[nAxis];
end;

procedure TMintController.Set_SoftLimitMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.SoftLimitMode[nAxis] := Param2;
end;

procedure TMintController.Set_SentinelTriggerValueInteger(nSentinelChannel: Smallint; 
                                                          nSentinelBand: Smallint; Param3: Integer);
begin
  DefaultInterface.SentinelTriggerValueInteger[nSentinelChannel, nSentinelBand] := Param3;
end;

procedure TMintController.Set_SRamp(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SRamp[nAxis] := Param2;
end;

function TMintController.Get_StaticHandle(const lpszTask: WideString; const lpszVariable: WideString): Integer;
begin
    Result := DefaultInterface.StaticHandle[lpszTask, lpszVariable];
end;

function TMintController.Get_Stepper(nChannel: Smallint): Single;
begin
    Result := DefaultInterface.Stepper[nChannel];
end;

procedure TMintController.Set_SplineEnd(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.SplineEnd[nAxis] := Param2;
end;

function TMintController.Get_SplineIndex(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.SplineIndex[nAxis];
end;

procedure TMintController.Set_SplineSuspendTime(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.SplineSuspendTime[nAxis] := Param2;
end;

function TMintController.Get_SerialBaudsSupported(nChannel: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.SerialBaudsSupported;
end;

function TMintController.Get_Sextant(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.Sextant[nAxis];
end;

procedure TMintController.Set_Sextant(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.Sextant[nAxis] := Param2;
end;

function TMintController.Get_SplineTime(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.SplineTime[nAxis];
end;

procedure TMintController.Set_SplineTime(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.SplineTime[nAxis] := Param2;
end;

function TMintController.Get_SRamp(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SRamp[nAxis];
end;

function TMintController.Get_JogAwayOffset(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.JogAwayOffset[nAxis];
end;

function TMintController.Get_InState(nBank: Smallint): Integer;
begin
    Result := DefaultInterface.InState[nBank];
end;

function TMintController.Get_InputActiveLevel(nBank: Smallint): Integer;
begin
    Result := DefaultInterface.InputActiveLevel[nBank];
end;

function TMintController.Get_JogDecelTimeMax(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.JogDecelTimeMax[nAxis];
end;

function TMintController.Get_JogAway(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.JogAway[nAxis];
end;

procedure TMintController.Set_JogAway(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.JogAway[nAxis] := Param2;
end;

procedure TMintController.Set_IncR(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.IncR[nAxis] := Param2;
end;

function TMintController.Get_InKey(nTerminalID: Integer): Smallint;
begin
    Result := DefaultInterface.InKey[nTerminalID];
end;

procedure TMintController.Set_InputDebounce(nBank: Smallint; Param2: Smallint);
begin
  DefaultInterface.InputDebounce[nBank] := Param2;
end;

procedure TMintController.Set_InputActiveLevel(nBank: Smallint; Param2: Integer);
begin
  DefaultInterface.InputActiveLevel[nBank] := Param2;
end;

function TMintController.Get_InputDebounce(nBank: Smallint): Smallint;
begin
    Result := DefaultInterface.InputDebounce[nBank];
end;

procedure TMintController.Set_IncA(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.IncA[nAxis] := Param2;
end;

procedure TMintController.Set_JogCommand(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.JogCommand[nAxis] := Param2;
end;

function TMintController.Get_In_(nBank: Smallint): Integer;
begin
    Result := DefaultInterface.In_[nBank];
end;

function TMintController.Get_Jog(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Jog[nAxis];
end;

procedure TMintController.Set_Jog(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Jog[nAxis] := Param2;
end;

function TMintController.Get_HTADeadband(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HTADeadband[nAxis];
end;

procedure TMintController.Set_HTADeadband(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.HTADeadband[nAxis] := Param2;
end;

function TMintController.Get_HTAFilter(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.HTAFilter[nAxis];
end;

function TMintController.Get_InX(nInput: Smallint): WordBool;
begin
    Result := DefaultInterface.InX[nInput];
end;

procedure TMintController.Set_JogAccelTimeMax(nAxis: Smallint; Param2: Integer);
begin
  DefaultInterface.JogAccelTimeMax[nAxis] := Param2;
end;

function TMintController.Get_JogCommand(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.JogCommand[nAxis];
end;

function TMintController.Get_JogAccelTimeMax(nAxis: Smallint): Integer;
begin
    Result := DefaultInterface.JogAccelTimeMax[nAxis];
end;

function TMintController.Get_InStateX(nInput: Smallint): WordBool;
begin
    Result := DefaultInterface.InStateX[nInput];
end;

function TMintController.Get_InternalData(nEnum1: Smallint; nEnum2: Smallint): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.InternalData[nEnum1, nEnum2];
end;

procedure TMintController.Set_InputNegTrigger(nBank: Smallint; Param2: Integer);
begin
  DefaultInterface.InputNegTrigger[nBank] := Param2;
end;

function TMintController.Get_SpeedTestRefAccelTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedTestRefAccelTime[nAxis];
end;

procedure TMintController.Set_SpeedTestRefAccelTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedTestRefAccelTime[nAxis] := Param2;
end;

procedure TMintController.Set_SpeedRefDecelTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedRefDecelTime[nAxis] := Param2;
end;

procedure TMintController.Set_SpeedTestRefDecelTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedTestRefDecelTime[nAxis] := Param2;
end;

function TMintController.Get_Spline(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.Spline[nAxis];
end;

procedure TMintController.Set_SpeedTestRef(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedTestRef[nAxis] := Param2;
end;

function TMintController.Get_SpeedRefAccelJerkEndTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedRefAccelJerkEndTime[nAxis];
end;

procedure TMintController.Set_SpeedRefAccelJerkEndTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedRefAccelJerkEndTime[nAxis] := Param2;
end;

function TMintController.Get_SpeedRefAccelJerkStartTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedRefAccelJerkStartTime[nAxis];
end;

procedure TMintController.Set_SpeedRefAccelJerkStartTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedRefAccelJerkStartTime[nAxis] := Param2;
end;

function TMintController.Get_SpeedRefAccelSource(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.SpeedRefAccelSource[nAxis];
end;

procedure TMintController.Set_SpeedRefAccelSource(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.SpeedRefAccelSource[nAxis] := Param2;
end;

function TMintController.Get_SpeedTestRefDecelTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedTestRefDecelTime[nAxis];
end;

procedure TMintController.Set_InputMode(nBank: Smallint; Param2: Integer);
begin
  DefaultInterface.InputMode[nBank] := Param2;
end;

function TMintController.Get_InputNegTrigger(nBank: Smallint): Integer;
begin
    Result := DefaultInterface.InputNegTrigger[nBank];
end;

procedure TMintController.Set_SpeedRefErrorDecelTime(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedRefErrorDecelTime[nAxis] := Param2;
end;

function TMintController.Get_InputPosTrigger(nBank: Smallint): Integer;
begin
    Result := DefaultInterface.InputPosTrigger[nBank];
end;

procedure TMintController.Set_InputPosTrigger(nBank: Smallint; Param2: Integer);
begin
  DefaultInterface.InputPosTrigger[nBank] := Param2;
end;

function TMintController.Get_InputMode(nBank: Smallint): Integer;
begin
    Result := DefaultInterface.InputMode[nBank];
end;

procedure TMintController.Set_SpeedRefEnable(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.SpeedRefEnable[nAxis] := Param2;
end;

function TMintController.Get_SpeedRefErrorDecelTime(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedRefErrorDecelTime[nAxis];
end;

function TMintController.Get_SpeedTestRef(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedTestRef[nAxis];
end;

function TMintController.Get_SpeedRefSource(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.SpeedRefSource[nAxis];
end;

procedure TMintController.Set_SpeedRefSource(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.SpeedRefSource[nAxis] := Param2;
end;

function TMintController.Get_SpeedRefEnable(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.SpeedRefEnable[nAxis];
end;

procedure TMintController.Set_SentinelSource2Parameter(nSentinelChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.SentinelSource2Parameter[nSentinelChannel] := Param2;
end;

function TMintController.Get_VFThreePointFreq(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.VFThreePointFreq[nAxis];
end;

procedure TMintController.Set_VFThreePointFreq(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.VFThreePointFreq[nAxis] := Param2;
end;

function TMintController.Get_VFThreePointMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.VFThreePointMode[nAxis];
end;

procedure TMintController.Set_TriggerValue(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.TriggerValue[nAxis] := Param2;
end;

procedure TMintController.Set_UserMotion(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.UserMotion[nAxis] := Param2;
end;

function TMintController.Get_VelScaleFactor(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.VelScaleFactor[nAxis];
end;

procedure TMintController.Set_VFThreePointMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.VFThreePointMode[nAxis] := Param2;
end;

function TMintController.Get_ZeroSpeedDeadband(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.ZeroSpeedDeadband[nAxis];
end;

procedure TMintController.Set_ZeroSpeedDeadband(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.ZeroSpeedDeadband[nAxis] := Param2;
end;

procedure TMintController.Set_VFProfile(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.VFProfile[nAxis] := Param2;
end;

function TMintController.Get_VFSlipCompensationMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.VFSlipCompensationMode[nAxis];
end;

procedure TMintController.Set_VFSlipCompensationMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.VFSlipCompensationMode[nAxis] := Param2;
end;

function TMintController.Get_TriggerValue(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.TriggerValue[nAxis];
end;

procedure TMintController.Set_TriggerMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.TriggerMode[nAxis] := Param2;
end;

function TMintController.Get_TriggerSource(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.TriggerSource[nAxis];
end;

procedure TMintController.Set_TriggerCompensation(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.TriggerCompensation[nAxis] := Param2;
end;

function TMintController.Get_VelFatalMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.VelFatalMode[nAxis];
end;

procedure TMintController.Set_UserTimeUnits(nAxis: Smallint; const Param2: WideString);
  { Warning: The property UserTimeUnits has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.UserTimeUnits := Param2;
end;

function TMintController.Get_TriggerMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.TriggerMode[nAxis];
end;

function TMintController.Get_UserPositionUnits(nAxis: Smallint): WideString;
begin
    Result := DefaultInterface.UserPositionUnits[nAxis];
end;

procedure TMintController.Set_UserPositionUnits(nAxis: Smallint; const Param2: WideString);
  { Warning: The property UserPositionUnits has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.UserPositionUnits := Param2;
end;

function TMintController.Get_UserTimeUnits(nAxis: Smallint): WideString;
begin
    Result := DefaultInterface.UserTimeUnits[nAxis];
end;

function TMintController.Get_TriggerInput(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.TriggerInput[nAxis];
end;

procedure TMintController.Set_TriggerInput(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.TriggerInput[nAxis] := Param2;
end;

procedure TMintController.Set_TriggerSource(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.TriggerSource[nAxis] := Param2;
end;

function TMintController.Get_VFDeadband(nAxis: Smallint; nChannel: Smallint): Single;
begin
    Result := DefaultInterface.VFDeadband[nAxis, nChannel];
end;

procedure TMintController.Set_TerminalMode(nTerminalID: Integer; Param2: Smallint);
begin
  DefaultInterface.TerminalMode[nTerminalID] := Param2;
end;

function TMintController.Get_TerminalPort(nTerminalID: Integer): Smallint;
begin
    Result := DefaultInterface.TerminalPort[nTerminalID];
end;

procedure TMintController.Set_VFDeadbandCentreFreq(nAxis: Smallint; nChannel: Smallint; 
                                                   Param3: Single);
begin
  DefaultInterface.VFDeadbandCentreFreq[nAxis, nChannel] := Param3;
end;

function TMintController.Get_VFBoostTransitionMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.VFBoostTransitionMode[nAxis];
end;

procedure TMintController.Set_VFBoostTransitionMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.VFBoostTransitionMode[nAxis] := Param2;
end;

function TMintController.Get_TerminalMode(nTerminalID: Integer): Smallint;
begin
    Result := DefaultInterface.TerminalMode[nTerminalID];
end;

procedure TMintController.Set_TerminalXoff(nTerminalID: Integer; Param2: WordBool);
begin
  DefaultInterface.TerminalXoff[nTerminalID] := Param2;
end;

procedure TMintController.Set_Torque(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Torque[nAxis] := Param2;
end;

procedure TMintController.Set_TerminalPort(nTerminalID: Integer; Param2: Smallint);
begin
  DefaultInterface.TerminalPort[nTerminalID] := Param2;
end;

function TMintController.Get_TerminalDevice(nTerminalID: Integer): Smallint;
begin
    Result := DefaultInterface.TerminalDevice[nTerminalID];
end;

procedure TMintController.Set_TerminalDevice(nTerminalID: Integer; Param2: Smallint);
begin
  DefaultInterface.TerminalDevice[nTerminalID] := Param2;
end;

function TMintController.Get_VFDeadbandCentreFreq(nAxis: Smallint; nChannel: Smallint): Single;
begin
    Result := DefaultInterface.VFDeadbandCentreFreq[nAxis, nChannel];
end;

function TMintController.Get_VFProfile(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.VFProfile[nAxis];
end;

function TMintController.Get_VelSetpointMax(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.VelSetpointMax[nAxis];
end;

procedure TMintController.Set_VelSetpointMax(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.VelSetpointMax[nAxis] := Param2;
end;

function TMintController.Get_VFThreePointVolts(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.VFThreePointVolts[nAxis];
end;

procedure TMintController.Set_VFThreePointVolts(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.VFThreePointVolts[nAxis] := Param2;
end;

function TMintController.Get_VoltageDemand(nAxis: Smallint; nChannel: Smallint): Single;
begin
    Result := DefaultInterface.VoltageDemand[nAxis, nChannel];
end;

procedure TMintController.Set_VelScaleUnits(nAxis: Smallint; const Param2: WideString);
  { Warning: The property VelScaleUnits has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.VelScaleUnits := Param2;
end;

procedure TMintController.Set_VelSetpointMin(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.VelSetpointMin[nAxis] := Param2;
end;

procedure TMintController.Set_VFDeadband(nAxis: Smallint; nChannel: Smallint; Param3: Single);
begin
  DefaultInterface.VFDeadband[nAxis, nChannel] := Param3;
end;

function TMintController.Get_VelSetpointMin(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.VelSetpointMin[nAxis];
end;

procedure TMintController.Set_VelScaleFactor(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.VelScaleFactor[nAxis] := Param2;
end;

function TMintController.Get_VelScaleUnits(nAxis: Smallint): WideString;
begin
    Result := DefaultInterface.VelScaleUnits[nAxis];
end;

function TMintController.Get_SpeedMeasured(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedMeasured[nAxis];
end;

procedure TMintController.Set_SpeedObserverK1(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedObserverK1[nAxis] := Param2;
end;

procedure TMintController.Set_SpeedObserverKJ(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedObserverKJ[nAxis] := Param2;
end;

function TMintController.Get_SpeedObserverK1(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedObserverK1[nAxis];
end;

function TMintController.Get_SpeedFilterType(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.SpeedFilterType[nAxis];
end;

procedure TMintController.Set_SpeedFilterType(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.SpeedFilterType[nAxis] := Param2;
end;

procedure TMintController.Set_SpeedObserverK2(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedObserverK2[nAxis] := Param2;
end;

function TMintController.Get_SpeedObserverKJ(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedObserverKJ[nAxis];
end;

procedure TMintController.Set_SpeedFilterRipple(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedFilterRipple[nAxis] := Param2;
end;

function TMintController.Get_SpeedRef(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedRef[nAxis];
end;

procedure TMintController.Set_SpeedRef(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedRef[nAxis] := Param2;
end;

function TMintController.Get_SpeedObserverK2(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedObserverK2[nAxis];
end;

procedure TMintController.Set_SpeedObserverEnable(nAxis: Smallint; Param2: WordBool);
begin
  DefaultInterface.SpeedObserverEnable[nAxis] := Param2;
end;

function TMintController.Get_SentinelState(nSentinelChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.SentinelState[nSentinelChannel];
end;

procedure TMintController.Set_SentinelTriggerMode(nSentinelChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.SentinelTriggerMode[nSentinelChannel] := Param2;
end;

function TMintController.Get_SentinelTriggerValueFloat(nSentinelChannel: Smallint; 
                                                       nSentinelBand: Smallint): Single;
begin
    Result := DefaultInterface.SentinelTriggerValueFloat[nSentinelChannel, nSentinelBand];
end;

function TMintController.Get_SentinelSourceParameter(nSentinelChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.SentinelSourceParameter[nSentinelChannel];
end;

procedure TMintController.Set_SentinelSourceParameter(nSentinelChannel: Smallint; Param2: Smallint);
begin
  DefaultInterface.SentinelSourceParameter[nSentinelChannel] := Param2;
end;

function TMintController.Get_SentinelSource2(nSentinelChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.SentinelSource2[nSentinelChannel];
end;

function TMintController.Get_SentinelTriggerMode(nSentinelChannel: Smallint): Smallint;
begin
    Result := DefaultInterface.SentinelTriggerMode[nSentinelChannel];
end;

function TMintController.Get_Speed(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Speed[nAxis];
end;

function TMintController.Get_SpeedObserverEnable(nAxis: Smallint): WordBool;
begin
    Result := DefaultInterface.SpeedObserverEnable[nAxis];
end;

procedure TMintController.Set_SentinelTriggerValueFloat(nSentinelChannel: Smallint; 
                                                        nSentinelBand: Smallint; Param3: Single);
begin
  DefaultInterface.SentinelTriggerValueFloat[nSentinelChannel, nSentinelBand] := Param3;
end;

function TMintController.Get_SentinelTriggerAbsolute(nSentinelChannel: Smallint): WordBool;
begin
    Result := DefaultInterface.SentinelTriggerAbsolute[nSentinelChannel];
end;

procedure TMintController.Set_SentinelTriggerAbsolute(nSentinelChannel: Smallint; Param2: WordBool);
begin
  DefaultInterface.SentinelTriggerAbsolute[nSentinelChannel] := Param2;
end;

function TMintController.Get_SpeedError(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedError[nAxis];
end;

function TMintController.Get_VariableData(const bstrTaskName: WideString; 
                                          const bstrVarName: WideString): OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.VariableData[bstrTaskName, bstrVarName];
end;

procedure TMintController.Set_VariableData(const bstrTaskName: WideString; 
                                           const bstrVarName: WideString; Param3: OleVariant);
begin
  DefaultInterface.VariableData[bstrTaskName, bstrVarName] := Param3;
end;

function TMintController.Get_VectorAngle(nAxisX: Smallint; nAxisY: Smallint): Single;
begin
    Result := DefaultInterface.VectorAngle[nAxisX, nAxisY];
end;

function TMintController.Get_Vel(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.Vel[nAxis];
end;

function TMintController.Get_VelDemand(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.VelDemand[nAxis];
end;

function TMintController.Get_VelDemandPath(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.VelDemandPath[nAxis];
end;

procedure TMintController.Set_VelRef(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.VelRef[nAxis] := Param2;
end;

function TMintController.Get_VelFatal(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.VelFatal[nAxis];
end;

procedure TMintController.Set_VelFatal(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.VelFatal[nAxis] := Param2;
end;

function TMintController.Get_VelError(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.VelError[nAxis];
end;

procedure TMintController.Set_VelFatalMode(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.VelFatalMode[nAxis] := Param2;
end;

function TMintController.Get_VelRef(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.VelRef[nAxis];
end;

function TMintController.Get_StopInputMode(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.StopInputMode[nAxis];
end;

function TMintController.Get_SpeedDemand(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedDemand[nAxis];
end;

procedure TMintController.Set_SpeedDemand(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedDemand[nAxis] := Param2;
end;

function TMintController.Get_SpeedFilterBand(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedFilterBand[nAxis];
end;

function TMintController.Get_SpeedErrorFatal(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedErrorFatal[nAxis];
end;

procedure TMintController.Set_SpeedErrorFatal(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedErrorFatal[nAxis] := Param2;
end;

procedure TMintController.Set_Speed(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.Speed[nAxis] := Param2;
end;

procedure TMintController.Set_SpeedFilterBand(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedFilterBand[nAxis] := Param2;
end;

function TMintController.Get_SpeedFilterFreq(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedFilterFreq[nAxis];
end;

procedure TMintController.Set_SpeedFilterFreq(nAxis: Smallint; Param2: Single);
begin
  DefaultInterface.SpeedFilterFreq[nAxis] := Param2;
end;

function TMintController.Get_SpeedFilterPoles(nAxis: Smallint): Smallint;
begin
    Result := DefaultInterface.SpeedFilterPoles[nAxis];
end;

procedure TMintController.Set_SpeedFilterPoles(nAxis: Smallint; Param2: Smallint);
begin
  DefaultInterface.SpeedFilterPoles[nAxis] := Param2;
end;

function TMintController.Get_SpeedFilterRipple(nAxis: Smallint): Single;
begin
    Result := DefaultInterface.SpeedFilterRipple[nAxis];
end;

function TMintController.Get_USBDeviceList: OleVariant;
begin
  Result := DefaultInterface.USBDeviceList;
end;

procedure TMintController.Set_USBDeviceList(Value: OleVariant);
begin
  DefaultInterface.USBDeviceList := Value;
end;

function TMintController.Get_H2USBDeviceList: OleVariant;
begin
  Result := DefaultInterface.H2USBDeviceList;
end;

procedure TMintController.Set_H2USBDeviceList(Value: OleVariant);
begin
  DefaultInterface.H2USBDeviceList := Value;
end;

function TMintController.Get_ExtendedEventData: OleVariant;
begin
  Result := DefaultInterface.ExtendedEventData;
end;

procedure TMintController.Set_ExtendedEventData(Value: OleVariant);
begin
  DefaultInterface.ExtendedEventData := Value;
end;

function TMintController.Get_BufferChars: OleVariant;
begin
  Result := DefaultInterface.BufferChars;
end;

procedure TMintController.Set_BufferChars(Value: OleVariant);
begin
  DefaultInterface.BufferChars := Value;
end;

function TMintController.Get_BootloaderBaudsSupported: OleVariant;
begin
  Result := DefaultInterface.BootloaderBaudsSupported;
end;

procedure TMintController.Set_BootloaderBaudsSupported(Value: OleVariant);
begin
  DefaultInterface.BootloaderBaudsSupported := Value;
end;

procedure TMintController.DoLocate(nTerminalID: Integer; nColumn: Smallint; nRow: Smallint);
begin
  DefaultInterface.DoLocate(nTerminalID, nColumn, nRow);
end;

procedure TMintController.DoPrint(nTermID: Integer; const str: WideString);
begin
  DefaultInterface.DoPrint(nTermID, str);
end;

procedure TMintController.DoUpdateEPLFirmware(const sFilename: WideString);
begin
  DefaultInterface.DoUpdateEPLFirmware(sFilename);
end;

procedure TMintController.DoMintCommandEx(nCommand: Smallint; vParam: OleVariant);
begin
  DefaultInterface.DoMintCommandEx(nCommand, vParam);
end;

procedure TMintController.DoMintBreak;
begin
  DefaultInterface.DoMintBreak;
end;

procedure TMintController.DoKnife(nAxis: Smallint);
begin
  DefaultInterface.DoKnife(nAxis);
end;

procedure TMintController.DoUpdateBootloader(const bstrBootloader: WideString);
begin
  DefaultInterface.DoUpdateBootloader(bstrBootloader);
end;

procedure TMintController.DoUpdateFirmwareAtSpeed(const szFilename: WideString; nSpeed: Integer);
begin
  DefaultInterface.DoUpdateFirmwareAtSpeed(szFilename, nSpeed);
end;

procedure TMintController.DoUpdatePLXEEPROM(const lpszFile: WideString);
begin
  DefaultInterface.DoUpdatePLXEEPROM(lpszFile);
end;

procedure TMintController.DoUpdateFirmware(const szFilename: WideString);
begin
  DefaultInterface.DoUpdateFirmware(szFilename);
end;

procedure TMintController.DoUpdateCommsFirmware(const szFilename: WideString);
begin
  DefaultInterface.DoUpdateCommsFirmware(szFilename);
end;

procedure TMintController.DoSystemDefaults;
begin
  DefaultInterface.DoSystemDefaults;
end;

procedure TMintController.DoMintCommand(nCommand: Smallint);
begin
  DefaultInterface.DoMintCommand(nCommand);
end;

procedure TMintController.DoParameterSave;
begin
  DefaultInterface.DoParameterSave;
end;

procedure TMintController.DoParameterTableDownload(const lpszFile: WideString);
begin
  DefaultInterface.DoParameterTableDownload(lpszFile);
end;

procedure TMintController.DoMintFileDownload(const szFilename: WideString);
begin
  DefaultInterface.DoMintFileDownload(szFilename);
end;

procedure TMintController.DoPLCDefault(nLevel: Smallint);
begin
  DefaultInterface.DoPLCDefault(nLevel);
end;

procedure TMintController.DoPopRedirect;
begin
  DefaultInterface.DoPopRedirect;
end;

procedure TMintController.DoParameterTableUpload(const lpszFile: WideString);
begin
  DefaultInterface.DoParameterTableUpload(lpszFile);
end;

procedure TMintController.DoGo3(nAxis1: Smallint; nAxis2: Smallint; nAxis3: Smallint);
begin
  DefaultInterface.DoGo3(nAxis1, nAxis2, nAxis3);
end;

procedure TMintController.DoGo4(nAxis1: Smallint; nAxis2: Smallint; nAxis3: Smallint; 
                                nAxis4: Smallint);
begin
  DefaultInterface.DoGo4(nAxis1, nAxis2, nAxis3, nAxis4);
end;

procedure TMintController.DoInstallMintSystemFile(const szFilename: WideString);
begin
  DefaultInterface.DoInstallMintSystemFile(szFilename);
end;

procedure TMintController.DoH2ParameterTableCloneRestore(const sFilename: WideString);
begin
  DefaultInterface.DoH2ParameterTableCloneRestore(sFilename);
end;

procedure TMintController.DoInitCompilerInfo;
begin
  DefaultInterface.DoInitCompilerInfo;
end;

procedure TMintController.DoH2ParameterTableCloneSave(const sFilename: WideString);
begin
  DefaultInterface.DoH2ParameterTableCloneSave(sFilename);
end;

procedure TMintController.DoWait(lTime: Integer);
begin
  DefaultInterface.DoWait(lTime);
end;

procedure TMintController.DoCaptureTrigger;
begin
  DefaultInterface.DoCaptureTrigger;
end;

procedure TMintController.DoClearErrorLog;
begin
  DefaultInterface.DoClearErrorLog;
end;

procedure TMintController.DoCaptureChannelUpload(nChannel: Smallint; var pvData: OleVariant; 
                                                 nSize: Smallint);
begin
  DefaultInterface.DoCaptureChannelUpload(nChannel, pvData, nSize);
end;

procedure TMintController.DoResetAll;
begin
  DefaultInterface.DoResetAll;
end;

procedure TMintController.DoSerialClearError(var plError: Integer);
begin
  DefaultInterface.DoSerialClearError(plError);
end;

procedure TMintController.DoGo2(nAxis1: Smallint; nAxis2: Smallint);
begin
  DefaultInterface.DoGo2(nAxis1, nAxis2);
end;

procedure TMintController.DoControllerReset;
begin
  DefaultInterface.DoControllerReset;
end;

procedure TMintController.DoDataFileDownload(const lpszFile: WideString);
begin
  DefaultInterface.DoDataFileDownload(lpszFile);
end;

procedure TMintController.DoCompRefLogReset;
begin
  DefaultInterface.DoCompRefLogReset;
end;

procedure TMintController.DoCancel(nAxis: Smallint);
begin
  DefaultInterface.DoCancel(nAxis);
end;

procedure TMintController.DoCancelAll;
begin
  DefaultInterface.DoCancelAll;
end;

procedure TMintController.DoCls(nTerminalID: Integer);
begin
  DefaultInterface.DoCls(nTerminalID);
end;

procedure TMintController.DoSerialClearReceiveBuffer;
begin
  DefaultInterface.DoSerialClearReceiveBuffer;
end;

procedure TMintController.DoSymbolTableUpload(const szFilename: WideString);
begin
  DefaultInterface.DoSymbolTableUpload(szFilename);
end;

procedure TMintController.DoRemotePDOOut(nBus: Smallint; lCOBID: Integer; nPDOLength: Smallint; 
                                         nBank0Data: Integer; nBank1Data: Integer);
begin
  DefaultInterface.DoRemotePDOOut(nBus, lCOBID, nPDOLength, nBank0Data, nBank1Data);
end;

procedure TMintController.DoRemoteReset(nCANBus: Smallint; nNodeId: Smallint);
begin
  DefaultInterface.DoRemoteReset(nCANBus, nNodeId);
end;

procedure TMintController.DoUpdateLanguagePack(const sFilename: WideString);
begin
  DefaultInterface.DoUpdateLanguagePack(sFilename);
end;

procedure TMintController.DoUpdateAndProgramFirmware(const bstrFirmware: WideString; 
                                                     nSpeed: Integer; nMinBuildNumber: Smallint);
begin
  DefaultInterface.DoUpdateAndProgramFirmware(bstrFirmware, nSpeed, nMinBuildNumber);
end;

procedure TMintController.DoUpdateFPGA(const szFilename: WideString);
begin
  DefaultInterface.DoUpdateFPGA(szFilename);
end;

procedure TMintController.DoReset(nAxis: Smallint);
begin
  DefaultInterface.DoReset(nAxis);
end;

procedure TMintController.DoSerialClearTransmitBuffer;
begin
  DefaultInterface.DoSerialClearTransmitBuffer;
end;

procedure TMintController.DoStop(nAxis: Smallint);
begin
  DefaultInterface.DoStop(nAxis);
end;

procedure TMintController.DoPushRedirect(nBus: Integer; nNode: Integer);
begin
  DefaultInterface.DoPushRedirect(nBus, nNode);
end;

procedure TMintController.DoProcessorReset;
begin
  DefaultInterface.DoProcessorReset;
end;

procedure TMintController.DoProcessorResetParam(nParameter: Smallint);
begin
  DefaultInterface.DoProcessorResetParam(nParameter);
end;

procedure TMintController.DoMintFileUpload(const szFilename: WideString);
begin
  DefaultInterface.DoMintFileUpload(szFilename);
end;

procedure TMintController.DoMintRun;
begin
  DefaultInterface.DoMintRun;
end;

procedure TMintController.DoNVRAMUpload(const lpszFile: WideString);
begin
  DefaultInterface.DoNVRAMUpload(lpszFile);
end;

procedure TMintController.DoNodeScan(nCANBus: Smallint; nNode: Smallint);
begin
  DefaultInterface.DoNodeScan(nCANBus, nNode);
end;

procedure TMintController.DoNVRAMDownload(const lpszFile: WideString);
begin
  DefaultInterface.DoNVRAMDownload(lpszFile);
end;

procedure TMintController.DoMultipleCommandsBegin;
begin
  DefaultInterface.DoMultipleCommandsBegin;
end;

procedure TMintController.DoCompileMintProgram(const bstrSource: WideString; 
                                               const bstrDest: WideString; nCompilerFlags: Integer);
begin
  DefaultInterface.DoCompileMintProgram(bstrSource, bstrDest, nCompilerFlags);
end;

procedure TMintController.SetControllerProdInfo(const lpszControllerType: WideString; 
                                                const lpszControllerVersion: WideString; 
                                                const lpszSerialNumber: WideString; 
                                                nFuncRev: Smallint; nBoardType: Smallint; 
                                                nPowerCycles: Integer; nNoAxes: Smallint; 
                                                nExpCards: Smallint);
begin
  DefaultInterface.SetControllerProdInfo(lpszControllerType, lpszControllerVersion, 
                                         lpszSerialNumber, nFuncRev, nBoardType, nPowerCycles, 
                                         nNoAxes, nExpCards);
end;

procedure TMintController.GetCPLDInfo(nBoard: Smallint; var pnDecodeCPLD: Smallint; 
                                      var pnIOCPLD: Smallint; var parrASIC: OleVariant);
begin
  DefaultInterface.GetCPLDInfo(nBoard, pnDecodeCPLD, pnIOCPLD, parrASIC);
end;

procedure TMintController.GetControllerProdInfo(var pszType: WideString; 
                                                var pszVersion: WideString; 
                                                var pszSerial: WideString; var pnFnRev: Smallint; 
                                                var pnBoardType: Smallint; 
                                                var plPowerCycles: Integer; var pnAxes: Smallint; 
                                                var pnExpCards: Smallint);
begin
  DefaultInterface.GetControllerProdInfo(pszType, pszVersion, pszSerial, pnFnRev, pnBoardType, 
                                         plPowerCycles, pnAxes, pnExpCards);
end;

procedure TMintController.GetCommsRead(nAddress: Smallint; var pfValue: Single);
begin
  DefaultInterface.GetCommsRead(nAddress, pfValue);
end;

procedure TMintController.SetCommsWrite(nAddress: Smallint; fValue: Single);
begin
  DefaultInterface.SetCommsWrite(nAddress, fValue);
end;

procedure TMintController.SetCommsWriteMultipleHCP2(nNode: Smallint; nAddress: Smallint; 
                                                    vValues: OleVariant);
begin
  DefaultInterface.SetCommsWriteMultipleHCP2(nNode, nAddress, vValues);
end;

procedure TMintController.CamTable(nAxis: Smallint; fPosArray: OleVariant; fLengthArray: OleVariant);
begin
  DefaultInterface.CamTable(nAxis, fPosArray, fLengthArray);
end;

procedure TMintController.GetCapturedData(const sFilename: WideString; 
                                          bExtrapolateFollowingError: WordBool; 
                                          bExtrapolateVelocity: WordBool; bShowProgress: WordBool);
begin
  DefaultInterface.GetCapturedData(sFilename, bExtrapolateFollowingError, bExtrapolateVelocity, 
                                   bShowProgress);
end;

procedure TMintController.CamSegment(nAxis: Smallint; nTable: Smallint; nStartSegment: Integer; 
                                     fSegmentArray: OleVariant);
begin
  DefaultInterface.CamSegment(nAxis, nTable, nStartSegment, fSegmentArray);
end;

procedure TMintController.GetCompRefCalcs(var pnParamA: Smallint; var pnParamB: Smallint; 
                                          var pulARaw: Integer; var pfA: Single; 
                                          var pfAGain: Single; var pfAFunction: Single; 
                                          var plBRaw: Integer; var pfB: Single; 
                                          var pfBGain: Single; var pfBFunction: Single; 
                                          var pfCOperator: Single; var pfCFunction: Single);
begin
  DefaultInterface.GetCompRefCalcs(pnParamA, pnParamB, pulARaw, pfA, pfAGain, pfAFunction, plBRaw, 
                                   pfB, pfBGain, pfBFunction, pfCOperator, pfCFunction);
end;

procedure TMintController.GetCompRefLog(var pnParamA: Smallint; var pnParamB: Smallint; 
                                        var pfCRMax: Single; var pfMaxALog: Single; 
                                        var pfMaxBLog: Single; var pfCRMin: Single; 
                                        var pfMinALog: Single; var pfMinBLog: Single);
begin
  DefaultInterface.GetCompRefLog(pnParamA, pnParamB, pfCRMax, pfMaxALog, pfMaxBLog, pfCRMin, 
                                 pfMinALog, pfMinBLog);
end;

procedure TMintController.GetCommsMapList(nIndex: Smallint; var pnMode: Smallint; 
                                          var pnParameter: Smallint; var pstrName: WideString);
begin
  DefaultInterface.GetCommsMapList(nIndex, pnMode, pnParameter, pstrName);
end;

procedure TMintController.SetCommsWriteMultiple(nAddress: Smallint; fValues: OleVariant);
begin
  DefaultInterface.SetCommsWriteMultiple(nAddress, fValues);
end;

procedure TMintController.SetAbsEncoderLinearMotorInfo(nAxis: Smallint; 
                                                       const bstrCatalogNumber: WideString; 
                                                       const bstrSpecNumber: WideString; 
                                                       const bstrManufactureDate: WideString; 
                                                       fMotorRatedCurrent: Single; 
                                                       fMotorPeakCurrent: Single; 
                                                       fMotorPeakDuration: Single; 
                                                       fMotorFlux: Single; 
                                                       fStatorResistance: Single; 
                                                       fStatorInductance: Single; 
                                                       fMaxLinearSpeed: Single; 
                                                       fMotorPolePitch: Single; fInertia: Single; 
                                                       fDamping: Single);
begin
  DefaultInterface.SetAbsEncoderLinearMotorInfo(nAxis, bstrCatalogNumber, bstrSpecNumber, 
                                                bstrManufactureDate, fMotorRatedCurrent, 
                                                fMotorPeakCurrent, fMotorPeakDuration, fMotorFlux, 
                                                fStatorResistance, fStatorInductance, 
                                                fMaxLinearSpeed, fMotorPolePitch, fInertia, fDamping);
end;

procedure TMintController.GetAPIDefnTableForController(bForceUpload: WordBool; 
                                                       var pbstrPath: WideString);
begin
  DefaultInterface.GetAPIDefnTableForController(bForceUpload, pbstrPath);
end;

procedure TMintController.GetAPIValueEx(nTable: Smallint; nFamily: Smallint; nIndex: Smallint; 
                                        vArgs: OleVariant; var pvCurrentValue: OleVariant; 
                                        var pvMin: OleVariant; var pvMax: OleVariant; 
                                        var pvDefault: OleVariant; var psUnits: WideString; 
                                        var pnDataType: Smallint);
begin
  DefaultInterface.GetAPIValueEx(nTable, nFamily, nIndex, vArgs, pvCurrentValue, pvMin, pvMax, 
                                 pvDefault, psUnits, pnDataType);
end;

procedure TMintController.SetVirtualControllerLink;
begin
  DefaultInterface.SetVirtualControllerLink;
end;

procedure TMintController.SetUSBControllerLink(nNode: Smallint);
begin
  DefaultInterface.SetUSBControllerLink(nNode);
end;

procedure TMintController.SetUSBDeviceLink(const bstrLinkName: WideString);
begin
  DefaultInterface.SetUSBDeviceLink(bstrLinkName);
end;

procedure TMintController.GetBusProcessDataTelegram(nBus: Smallint; bIn: WordBool; 
                                                    var pnControlWord: Integer; 
                                                    var pvRawData: OleVariant; 
                                                    var pvFloatData: OleVariant);
begin
  DefaultInterface.GetBusProcessDataTelegram(nBus, bIn, pnControlWord, pvRawData, pvFloatData);
end;

procedure TMintController.GetCommsReadHCP2(nNode: Smallint; nAddress: Smallint; var pfValue: Single);
begin
  DefaultInterface.GetCommsReadHCP2(nNode, nAddress, pfValue);
end;

procedure TMintController.SetCommsWriteHCP2(nNode: Smallint; nAddress: Smallint; fValue: Single);
begin
  DefaultInterface.SetCommsWriteHCP2(nNode, nAddress, fValue);
end;

procedure TMintController.SetAbsEncoderRotaryMotorInfo(nAxis: Smallint; 
                                                       const strCatalogNumber: WideString; 
                                                       const strSpecNumber: WideString; 
                                                       const strManufactureDate: WideString; 
                                                       fMotorRatedCurrent: Single; 
                                                       fMotorPeakCurrent: Single; 
                                                       fMotorPeakDuration: Single; 
                                                       fMotorFlux: Single; 
                                                       fStatorResistance: Single; 
                                                       fStatorInductance: Single; 
                                                       nMaxRotarySpeed: Smallint; 
                                                       nMotorPoles: Smallint; fInertia: Single; 
                                                       fDamping: Single);
begin
  DefaultInterface.SetAbsEncoderRotaryMotorInfo(nAxis, strCatalogNumber, strSpecNumber, 
                                                strManufactureDate, fMotorRatedCurrent, 
                                                fMotorPeakCurrent, fMotorPeakDuration, fMotorFlux, 
                                                fStatorResistance, fStatorInductance, 
                                                nMaxRotarySpeed, nMotorPoles, fInertia, fDamping);
end;

procedure TMintController.GetAbsEncoderRotaryInfo(nAxis: Smallint; var pnFeedbackType: Smallint; 
                                                  var pbstrSerialNumber: WideString; 
                                                  var pbstrProgramVersion: WideString; 
                                                  var pbstrPartNumber: WideString; 
                                                  var pnTypeNumber: Smallint; 
                                                  var plAbsCountsPerRev: Integer; 
                                                  var pnCyclesPerRev: Smallint; 
                                                  var pnMaxRotarySpeed: Smallint; 
                                                  var pnAbsCountBits: Smallint; 
                                                  var plMinCountsPerRev: Integer; 
                                                  var plMaxCountsPerRev: Integer; 
                                                  var pnNumTurns: Smallint);
begin
  DefaultInterface.GetAbsEncoderRotaryInfo(nAxis, pnFeedbackType, pbstrSerialNumber, 
                                           pbstrProgramVersion, pbstrPartNumber, pnTypeNumber, 
                                           plAbsCountsPerRev, pnCyclesPerRev, pnMaxRotarySpeed, 
                                           pnAbsCountBits, plMinCountsPerRev, plMaxCountsPerRev, 
                                           pnNumTurns);
end;

procedure TMintController.GetAbsEncoderRotaryMotorInfo(nAxis: Smallint; 
                                                       var pbstrCatalogNumber: WideString; 
                                                       var pbstrSpecNumber: WideString; 
                                                       var pbstrManufactureDate: WideString; 
                                                       var pfMotorRatedCurrent: Single; 
                                                       var pfMotorPeakCurrent: Single; 
                                                       var pfMotorPeakDuration: Single; 
                                                       var pfMotorFlux: Single; 
                                                       var pfStatorResistance: Single; 
                                                       var pfStatorInductance: Single; 
                                                       var pnMaxRotarySpeed: Smallint; 
                                                       var pnMotorPoles: Smallint; 
                                                       var pfInertia: Single; var pfDamping: Single);
begin
  DefaultInterface.GetAbsEncoderRotaryMotorInfo(nAxis, pbstrCatalogNumber, pbstrSpecNumber, 
                                                pbstrManufactureDate, pfMotorRatedCurrent, 
                                                pfMotorPeakCurrent, pfMotorPeakDuration, 
                                                pfMotorFlux, pfStatorResistance, 
                                                pfStatorInductance, pnMaxRotarySpeed, pnMotorPoles, 
                                                pfInertia, pfDamping);
end;

procedure TMintController.SetBusReceiveTelegram(nBus: Smallint; nCountWords: Smallint; 
                                                vData: OleVariant);
begin
  DefaultInterface.SetBusReceiveTelegram(nBus, nCountWords, vData);
end;

procedure TMintController.SetControllerTarget(nTarget: Smallint);
begin
  DefaultInterface.SetControllerTarget(nTarget);
end;

procedure TMintController.InstallUnknownEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallUnknownEventHandler(bInstall);
end;

procedure TMintController.InstallUSBDeviceChangedHandler(hWnd: Integer; var phNotification: Integer);
begin
  DefaultInterface.InstallUSBDeviceChangedHandler(hWnd, phNotification);
end;

procedure TMintController.InstallTimerEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallTimerEventHandler(bInstall);
end;

procedure TMintController.SetDSPControllerLink(nNode: Smallint; nPort: Smallint; 
                                               lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetDSPControllerLink(nNode, nPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetEthernetControllerLink(const sLinkName: WideString);
begin
  DefaultInterface.SetEthernetControllerLink(sLinkName);
end;

procedure TMintController.InstallBusMessageEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallBusMessageEventHandler(bInstall);
end;

procedure TMintController.InstallAxisIdleEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallAxisIdleEventHandler(bInstall);
end;

procedure TMintController.InstallBusEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallBusEventHandler(bInstall);
end;

procedure TMintController.InstallNetDataEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallNetDataEventHandler(bInstall);
end;

procedure TMintController.InstallCommsEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallCommsEventHandler(bInstall);
end;

procedure TMintController.InstallDPREventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallDPREventHandler(bInstall);
end;

procedure TMintController.InstallSerialReceiveEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallSerialReceiveEventHandler(bInstall);
end;

procedure TMintController.GetCommsMapInfo(var pnSize: Smallint; var pnBase: Smallint; 
                                          var pnChannels: Smallint);
begin
  DefaultInterface.GetCommsMapInfo(pnSize, pnBase, pnChannels);
end;

procedure TMintController.CircleA(nXAxis: Smallint; nYAxis: Smallint; fXCentre: Single; 
                                  fYCentre: Single; fAngle: Single);
begin
  DefaultInterface.CircleA(nXAxis, nYAxis, fXCentre, fYCentre, fAngle);
end;

procedure TMintController.GetCaptureModeParameterObject(nChannel: Smallint; var pnBus: Smallint; 
                                                        var pnNode: Smallint; 
                                                        var pnIndex: Smallint; 
                                                        var pnSubIndex: Smallint; 
                                                        var pnType: Smallint);
begin
  DefaultInterface.GetCaptureModeParameterObject(nChannel, pnBus, pnNode, pnIndex, pnSubIndex, 
                                                 pnType);
end;

procedure TMintController.CamBoxData(nCamBox: Smallint; nOutput: Smallint; nSource: Smallint; 
                                     nChannel: Smallint; nTime: Smallint; newValue: OleVariant);
begin
  DefaultInterface.CamBoxData(nCamBox, nOutput, nSource, nChannel, nTime, newValue);
end;

procedure TMintController.GetCaptureInfo(var pnNumPoints: Smallint; var pnFirstElement: Smallint);
begin
  DefaultInterface.GetCaptureInfo(pnNumPoints, pnFirstElement);
end;

procedure TMintController.CircleR(nXAxis: Smallint; nYAxis: Smallint; fXCentre: Single; 
                                  fYCentre: Single; fAngle: Single);
begin
  DefaultInterface.CircleR(nXAxis, nYAxis, fXCentre, fYCentre, fAngle);
end;

procedure TMintController.InstallTerminalReceiveEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallTerminalReceiveEventHandler(bInstall);
end;

procedure TMintController.InstallStopEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallStopEventHandler(bInstall);
end;

procedure TMintController.InstallResetEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallResetEventHandler(bInstall);
end;

procedure TMintController.SetCaptureModeParameterObject(nChannel: Smallint; nBus: Smallint; 
                                                        nNode: Smallint; nIndex: Smallint; 
                                                        nSubIndex: Smallint; nType: Smallint);
begin
  DefaultInterface.SetCaptureModeParameterObject(nChannel, nBus, nNode, nIndex, nSubIndex, nType);
end;

procedure TMintController.SetSerialControllerLink(nType: Smallint; nNode: Smallint; 
                                                  nPort: Smallint; lBaudRate: Integer; 
                                                  bOpenPort: WordBool);
begin
  DefaultInterface.SetSerialControllerLink(nType, nNode, nPort, lBaudRate, bOpenPort);
end;

procedure TMintController.InstallStopSwitchEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallStopSwitchEventHandler(bInstall);
end;

procedure TMintController.DoFactoryDefaults;
begin
  DefaultInterface.DoFactoryDefaults;
end;

procedure TMintController.DoEventPend(nEventType: Smallint; nEventData1: Integer; 
                                      nEventData2: Integer);
begin
  DefaultInterface.DoEventPend(nEventType, nEventData1, nEventData2);
end;

procedure TMintController.DoEventUnPend(nEventType: Smallint; nEventData1: Integer; 
                                        nEventData2: Integer);
begin
  DefaultInterface.DoEventUnPend(nEventType, nEventData1, nEventData2);
end;

procedure TMintController.DoDataFileUpload(const lpszFile: WideString; bArraysOnly: WordBool);
begin
  DefaultInterface.DoDataFileUpload(lpszFile, bArraysOnly);
end;

procedure TMintController.DoFactoryDefaultsParam(nType: Smallint);
begin
  DefaultInterface.DoFactoryDefaultsParam(nType);
end;

procedure TMintController.DoFileDelete(const sFilename: WideString);
begin
  DefaultInterface.DoFileDelete(sFilename);
end;

procedure TMintController.DoFileUpload(const sSourceName: WideString; nType: Smallint; 
                                       const sDestPath: WideString);
begin
  DefaultInterface.DoFileUpload(sSourceName, nType, sDestPath);
end;

procedure TMintController.DoFileSystemDownload(const lpszSource: WideString);
begin
  DefaultInterface.DoFileSystemDownload(lpszSource);
end;

procedure TMintController.DoFileSystemUpload(const lpszDest: WideString);
begin
  DefaultInterface.DoFileSystemUpload(lpszDest);
end;

procedure TMintController.DoFileDownload(const sSourcePath: WideString; 
                                         const sDestName: WideString; nDestType: Smallint);
begin
  DefaultInterface.DoFileDownload(sSourcePath, sDestName, nDestType);
end;

procedure TMintController.DoGo(nNumberOfAxes: Smallint; nAxisArray: OleVariant);
begin
  DefaultInterface.DoGo(nNumberOfAxes, nAxisArray);
end;

procedure TMintController.DoGo1(nAxis1: Smallint);
begin
  DefaultInterface.DoGo1(nAxis1);
end;

procedure TMintController.DoAutotune(nAxis: Smallint; nOp: Smallint);
begin
  DefaultInterface.DoAutotune(nAxis, nOp);
end;

procedure TMintController.DoAPIValueTableUpload(nTable: Smallint; const lpszFile: WideString);
begin
  DefaultInterface.DoAPIValueTableUpload(nTable, lpszFile);
end;

procedure TMintController.DoAPIDefinitionTableUpload(const szFilename: WideString);
begin
  DefaultInterface.DoAPIDefinitionTableUpload(szFilename);
end;

procedure TMintController.DoAbort;
begin
  DefaultInterface.DoAbort;
end;

procedure TMintController.DoCompileMintProgramOffline(const bstrSource: WideString; 
                                                      const bstrDest: WideString; 
                                                      nTarget: Smallint; 
                                                      nCompilerVersion: Smallint; 
                                                      const bstrSymbolTable: WideString; 
                                                      nCompileFlags: Integer);
begin
  DefaultInterface.DoCompileMintProgramOffline(bstrSource, bstrDest, nTarget, nCompilerVersion, 
                                               bstrSymbolTable, nCompileFlags);
end;

procedure TMintController.DoCANBusReset(nCANBus: Smallint);
begin
  DefaultInterface.DoCANBusReset(nCANBus);
end;

procedure TMintController.DoAPIValueTableDownload(nTable: Smallint; const lpszFile: WideString);
begin
  DefaultInterface.DoAPIValueTableDownload(nTable, lpszFile);
end;

procedure TMintController.DoCamPhase(nAxis: Smallint; nIndex: Smallint; nSegments: Smallint; 
                                     fdeltaMSD: Single);
begin
  DefaultInterface.DoCamPhase(nAxis, nIndex, nSegments, fdeltaMSD);
end;

procedure TMintController.DoAutotuneAbort;
begin
  DefaultInterface.DoAutotuneAbort;
end;

procedure TMintController.DoAPIValueTableUploadPartial(nTable: Smallint; 
                                                       const lpszAPIDefnTable: WideString; 
                                                       const lpszOutputFile: WideString);
begin
  DefaultInterface.DoAPIValueTableUploadPartial(nTable, lpszAPIDefnTable, lpszOutputFile);
end;

procedure TMintController.DoADCOffsetTrim(nChannel: Smallint);
begin
  DefaultInterface.DoADCOffsetTrim(nChannel);
end;

procedure TMintController.DoAPIValueTableUploadCSV(nTable: Smallint; const sFilename: WideString);
begin
  DefaultInterface.DoAPIValueTableUploadCSV(nTable, sFilename);
end;

procedure TMintController.DoBusReset(nBus: Smallint);
begin
  DefaultInterface.DoBusReset(nBus);
end;

procedure TMintController.DoErrorClear(nGroup: Smallint; nData: Integer);
begin
  DefaultInterface.DoErrorClear(nGroup, nData);
end;

procedure TMintController.GetBusMuxCycleConfig(nBus: Smallint; nNode: Smallint; 
                                               var pnMuxRatio: Smallint; var pvNodes: OleVariant);
begin
  DefaultInterface.GetBusMuxCycleConfig(nBus, nNode, pnMuxRatio, pvNodes);
end;

procedure TMintController.GetBusProcessDataInfo(nBusID: Smallint; bIn: WordBool; 
                                                var pnCountModes: Smallint; 
                                                var pnCountChannels: Smallint);
begin
  DefaultInterface.GetBusProcessDataInfo(nBusID, bIn, pnCountModes, pnCountChannels);
end;

procedure TMintController.GetBusProcessDataList(nBus: Smallint; bIn: WordBool; nIndex: Smallint; 
                                                var pnMode: Smallint; var pnParam: Smallint; 
                                                var pstrName: WideString);
begin
  DefaultInterface.GetBusProcessDataList(nBus, bIn, nIndex, pnMode, pnParam, pstrName);
end;

procedure TMintController.Blend(nAxis: Smallint);
begin
  DefaultInterface.Blend(nAxis);
end;

procedure TMintController.SetAsyncError(lPresent: Integer; lMisc: Integer; 
                                        lAxisErrorArray: OleVariant; lAxisWarningArray: OleVariant);
begin
  DefaultInterface.SetAsyncError(lPresent, lMisc, lAxisErrorArray, lAxisWarningArray);
end;

procedure TMintController.GetAutotuneParamLimits(nParam: Smallint; var pfDefault: Single; 
                                                 var pfMin: Single; var pfMax: Single);
begin
  DefaultInterface.GetAutotuneParamLimits(nParam, pfDefault, pfMin, pfMax);
end;

procedure TMintController.GetAsyncError(var plPresent: Integer; var plMisc: Integer; 
                                        var plAxisErrorArray: OleVariant; 
                                        var plAxisWarningArray: OleVariant);
begin
  DefaultInterface.GetAsyncError(plPresent, plMisc, plAxisErrorArray, plAxisWarningArray);
end;

procedure TMintController.GetAbsEncoderLinearInfo(nAxis: Smallint; var pnFeedbackType: Smallint; 
                                                  var pbstrSerialNumber: WideString; 
                                                  var pbstrProgramVersion: WideString; 
                                                  var pbstrPartNumber: WideString; 
                                                  var pnTypeNumber: Smallint; 
                                                  var plAbsLinearResolution: Integer; 
                                                  var plLinearCycleLength: Integer; 
                                                  var plMaxLinearSpeed: Integer; 
                                                  var pnAbsCountBits: Smallint; 
                                                  var plMinLinearResolution: Integer; 
                                                  var plMaxLinearResolution: Integer);
begin
  DefaultInterface.GetAbsEncoderLinearInfo(nAxis, pnFeedbackType, pbstrSerialNumber, 
                                           pbstrProgramVersion, pbstrPartNumber, pnTypeNumber, 
                                           plAbsLinearResolution, plLinearCycleLength, 
                                           plMaxLinearSpeed, pnAbsCountBits, plMinLinearResolution, 
                                           plMaxLinearResolution);
end;

procedure TMintController.GetAbsEncoderLinearMotorInfo(nAxis: Smallint; 
                                                       var pbstrCatalogNumber: WideString; 
                                                       var pbstrSpecNumber: WideString; 
                                                       var pbstrManufactureDate: WideString; 
                                                       var pfMotorRatedCurrent: Single; 
                                                       var pfMotorPeakCurrent: Single; 
                                                       var pfMotorPeakDuration: Single; 
                                                       var pfMotorFlux: Single; 
                                                       var pfStatorResistance: Single; 
                                                       var pfStatorInductance: Single; 
                                                       var pfMaxLinearSpeed: Single; 
                                                       var pfMotorPolePitch: Single; 
                                                       var pfInertia: Single; var pfDamping: Single);
begin
  DefaultInterface.GetAbsEncoderLinearMotorInfo(nAxis, pbstrCatalogNumber, pbstrSpecNumber, 
                                                pbstrManufactureDate, pfMotorRatedCurrent, 
                                                pfMotorPeakCurrent, pfMotorPeakDuration, 
                                                pfMotorFlux, pfStatorResistance, 
                                                pfStatorInductance, pfMaxLinearSpeed, 
                                                pfMotorPolePitch, pfInertia, pfDamping);
end;

procedure TMintController.SetBusPDOMapConfig(nBus: Smallint; nNode: Smallint; bIn: WordBool; 
                                             nPeerNode: Smallint; nStartSlot: Smallint; 
                                             nEndSlot: Smallint);
begin
  DefaultInterface.SetBusPDOMapConfig(nBus, nNode, bIn, nPeerNode, nStartSlot, nEndSlot);
end;

procedure TMintController.SetBusMuxCycleConfig(nBus: Smallint; nNode: Smallint; 
                                               nMuxRatio: Smallint; vNodes: OleVariant);
begin
  DefaultInterface.SetBusMuxCycleConfig(nBus, nNode, nMuxRatio, vNodes);
end;

procedure TMintController.GetBusPDOMapConfig(nBus: Smallint; nNode: Smallint; bIn: WordBool; 
                                             nPeerNode: Smallint; var pnStartSlot: Smallint; 
                                             var pnEndSlot: Smallint);
begin
  DefaultInterface.GetBusPDOMapConfig(nBus, nNode, bIn, nPeerNode, pnStartSlot, pnEndSlot);
end;

procedure TMintController.GetBusMessageInfo(nBus: Smallint; var pnTime: Integer; 
                                            var pnIdentifier: Smallint; var pvData: OleVariant);
begin
  DefaultInterface.GetBusMessageInfo(nBus, pnTime, pnIdentifier, pvData);
end;

procedure TMintController.DoDefault(nAxis: Smallint);
begin
  DefaultInterface.DoDefault(nAxis);
end;

procedure TMintController.DoDefaultAll;
begin
  DefaultInterface.DoDefaultAll;
end;

procedure TMintController.DoDownloadMintSystemFile(const strName: WideString);
begin
  DefaultInterface.DoDownloadMintSystemFile(strName);
end;

procedure TMintController.DoDeviceClose;
begin
  DefaultInterface.DoDeviceClose;
end;

procedure TMintController.DoDeviceOpen;
begin
  DefaultInterface.DoDeviceOpen;
end;

procedure TMintController.DoDeleteDataObjects;
begin
  DefaultInterface.DoDeleteDataObjects;
end;

procedure TMintController.DoDPREvent(nCode: Smallint);
begin
  DefaultInterface.DoDPREvent(nCode);
end;

procedure TMintController.DoDriveMacroDownload(const lpszFile: WideString);
begin
  DefaultInterface.DoDriveMacroDownload(lpszFile);
end;

procedure TMintController.GetBusCommandTelegram(nBus: Smallint; var pnRXControlWord: Integer; 
                                                var pnRXDataWord: Integer; var pfRXData: Single; 
                                                var pnTXControlWord: Integer; 
                                                var pnTXDataWord: Integer; var pfTXData: Single);
begin
  DefaultInterface.GetBusCommandTelegram(nBus, pnRXControlWord, pnRXDataWord, pfRXData, 
                                         pnTXControlWord, pnTXDataWord, pfTXData);
end;

procedure TMintController.DoDriveMacroUpload(const sFilename: WideString);
begin
  DefaultInterface.DoDriveMacroUpload(sFilename);
end;

procedure TMintController.DoEEPROMUpload(nDeviceID: Smallint; const sFilename: WideString);
begin
  DefaultInterface.DoEEPROMUpload(nDeviceID, sFilename);
end;

procedure TMintController.DoDriveMacroSourceUpload(const lpszFile: WideString; nFlags: Integer);
begin
  DefaultInterface.DoDriveMacroSourceUpload(lpszFile, nFlags);
end;

procedure TMintController.mmSetPWMPolarity(nNodeId: Smallint; nPolarity: Smallint);
begin
  DefaultInterface.mmSetPWMPolarity(nNodeId, nPolarity);
end;

procedure TMintController.mmSetBiDirectionalMotor(nNodeId: Smallint; nMotor: Smallint; 
                                                  nDirection: Smallint; nOnTime: Integer; 
                                                  bEnable: WordBool);
begin
  DefaultInterface.mmSetBiDirectionalMotor(nNodeId, nMotor, nDirection, nOnTime, bEnable);
end;

procedure TMintController.mmGetPWMPolarity(nNodeId: Smallint; var pnPolarity: Smallint);
begin
  DefaultInterface.mmGetPWMPolarity(nNodeId, pnPolarity);
end;

procedure TMintController.mmGetPWMErrorTime(nNodeId: Smallint; var pnErrorTime: Integer);
begin
  DefaultInterface.mmGetPWMErrorTime(nNodeId, pnErrorTime);
end;

procedure TMintController.mmSetPWMErrorTime(nNodeId: Smallint; nErrorTime: Integer);
begin
  DefaultInterface.mmSetPWMErrorTime(nNodeId, nErrorTime);
end;

procedure TMintController.mmSetPWMOnTime(nNodeId: Smallint; nChannel: Smallint; nOnTime: Integer);
begin
  DefaultInterface.mmSetPWMOnTime(nNodeId, nChannel, nOnTime);
end;

procedure TMintController.VectorR(nNumberOfAxes: Smallint; nAxesArray: OleVariant; 
                                  fPosArray: OleVariant);
begin
  DefaultInterface.VectorR(nNumberOfAxes, nAxesArray, fPosArray);
end;

procedure TMintController.debugGetBurnInParameter(nParam: Smallint; var pfValue: Single);
begin
  DefaultInterface.debugGetBurnInParameter(nParam, pfValue);
end;

procedure TMintController.VectorA(nNumberOfAxes: Smallint; nAxesArray: OleVariant; 
                                  fPosArray: OleVariant);
begin
  DefaultInterface.VectorA(nNumberOfAxes, nAxesArray, fPosArray);
end;

procedure TMintController.mmGetPWMPeriod(nNodeId: Smallint; var pnPeriod: Integer);
begin
  DefaultInterface.mmGetPWMPeriod(nNodeId, pnPeriod);
end;

procedure TMintController.mmSetPWMPeriod(nNodeId: Smallint; nPeriod: Integer);
begin
  DefaultInterface.mmSetPWMPeriod(nNodeId, nPeriod);
end;

procedure TMintController.mmSetPWMErrors(nNodeId: Smallint; nErrors: Integer);
begin
  DefaultInterface.mmSetPWMErrors(nNodeId, nErrors);
end;

procedure TMintController.mmGetPWMMode(nNodeId: Smallint; var pnMode: Smallint);
begin
  DefaultInterface.mmGetPWMMode(nNodeId, pnMode);
end;

procedure TMintController.mmSetPWMMode(nNodeId: Smallint; nMode: Smallint);
begin
  DefaultInterface.mmSetPWMMode(nNodeId, nMode);
end;

procedure TMintController.mmGetPWMOnTime(nNodeId: Smallint; nChannel: Smallint; 
                                         var pnOnTime: Integer);
begin
  DefaultInterface.mmGetPWMOnTime(nNodeId, nChannel, pnOnTime);
end;

procedure TMintController.TransmitICMCommand(vFrontStruct: OleVariant; var pvInOut: OleVariant);
begin
  DefaultInterface.TransmitICMCommand(vFrontStruct, pvInOut);
end;

procedure TMintController.mmSetMotorPair(nNodeId: Smallint; nMotor: Smallint; nDirection: Smallint; 
                                         nMotor1OnTime: Integer; nMotor2OnTime: Integer; 
                                         bEnable: WordBool);
begin
  DefaultInterface.mmSetMotorPair(nNodeId, nMotor, nDirection, nMotor1OnTime, nMotor2OnTime, bEnable);
end;

procedure TMintController.mmGetPWMErrors(nNodeId: Smallint; var pnErrors: Integer);
begin
  DefaultInterface.mmGetPWMErrors(nNodeId, pnErrors);
end;

procedure TMintController.mmGetPWMEnable(nNodeId: Smallint; nChannel: Smallint; 
                                         var pnEnable: Smallint);
begin
  DefaultInterface.mmGetPWMEnable(nNodeId, nChannel, pnEnable);
end;

procedure TMintController.mmGetPWMBraking(nNodeId: Smallint; var pnBraking: Smallint);
begin
  DefaultInterface.mmGetPWMBraking(nNodeId, pnBraking);
end;

procedure TMintController.GetTriggerPoints(var pvTriggered: OleVariant; var pvXPos: OleVariant; 
                                           var pvYPos: OleVariant);
begin
  DefaultInterface.GetTriggerPoints(pvTriggered, pvXPos, pvYPos);
end;

procedure TMintController.debugSetBurnInParameter(nParam: Smallint; fValue: Single);
begin
  DefaultInterface.debugSetBurnInParameter(nParam, fValue);
end;

procedure TMintController.mmSetPWMEnable(nNodeId: Smallint; nChannel: Smallint; nEnable: Smallint);
begin
  DefaultInterface.mmSetPWMEnable(nNodeId, nChannel, nEnable);
end;

procedure TMintController.mmSetPWMBraking(nNodeId: Smallint; nBraking: Smallint);
begin
  DefaultInterface.mmSetPWMBraking(nNodeId, nBraking);
end;

procedure TMintController.mmSetUniDirectionalMotor(nNodeId: Smallint; nMotor: Smallint; 
                                                   nDirection: Smallint; nOnTime: Integer; 
                                                   bEnable: WordBool);
begin
  DefaultInterface.mmSetUniDirectionalMotor(nNodeId, nMotor, nDirection, nOnTime, bEnable);
end;

procedure TMintController.PrecisionTable(nAxisOrChannel: Smallint; fForwardArray: OleVariant; 
                                         fReverseArray: OleVariant);
begin
  DefaultInterface.PrecisionTable(nAxisOrChannel, fForwardArray, fReverseArray);
end;

procedure TMintController.PresetCancel(nAxis: Smallint; nPreset: Smallint);
begin
  DefaultInterface.PresetCancel(nAxis, nPreset);
end;

procedure TMintController.SetMappedDevice(nType: Smallint; nLocalChannel: Smallint; nBus: Smallint; 
                                          nNode: Smallint; nRemoteChannel: Smallint);
begin
  DefaultInterface.SetMappedDevice(nType, nLocalChannel, nBus, nNode, nRemoteChannel);
end;

procedure TMintController.HelixA(nXAxis: Smallint; nYAxis: Smallint; nZAxis: Smallint; 
                                 fXCentre: Single; fYCentre: Single; fAngle: Single; fZPos: Single);
begin
  DefaultInterface.HelixA(nXAxis, nYAxis, nZAxis, fXCentre, fYCentre, fAngle, fZPos);
end;

procedure TMintController.SetDriveUnitProductionData(const strCatalogNumber: WideString; 
                                                     const strSerialNumber: WideString; 
                                                     const strBuildDate: WideString; 
                                                     nRevCode: Smallint; nBetaBuild: Smallint; 
                                                     nDemoUnit: Smallint);
begin
  DefaultInterface.SetDriveUnitProductionData(strCatalogNumber, strSerialNumber, strBuildDate, 
                                              nRevCode, nBetaBuild, nDemoUnit);
end;

procedure TMintController.DoMoveFiducial(nXAxis: Smallint; nYAxis: Smallint; nCountMoves: Smallint; 
                                         vPosData: OleVariant; vWindowData: OleVariant; 
                                         nOutputChannel: Smallint; nOutputBit0: Smallint; 
                                         nOutputBit1: Smallint; nMinTime: Smallint; 
                                         fFiducialSpeed: Single; nMode: Smallint; 
                                         nPulseTime: Smallint; nDwellTime: Smallint);
begin
  DefaultInterface.DoMoveFiducial(nXAxis, nYAxis, nCountMoves, vPosData, vWindowData, 
                                  nOutputChannel, nOutputBit0, nOutputBit1, nMinTime, 
                                  fFiducialSpeed, nMode, nPulseTime, nDwellTime);
end;

procedure TMintController.GetMappedRemoteDevice(nType: Smallint; nLocalChannel: Smallint; 
                                                var pnBus: Smallint; var pnNode: Smallint; 
                                                var pnRemoteNode: Smallint; 
                                                var pnRemoteChannel: Smallint);
begin
  DefaultInterface.GetMappedRemoteDevice(nType, nLocalChannel, pnBus, pnNode, pnRemoteNode, 
                                         pnRemoteChannel);
end;

procedure TMintController.GetMappedDevice(nType: Smallint; nLocalChannel: Smallint; 
                                          var pnBus: Smallint; var pnNode: Smallint; 
                                          var pnRemoteChannel: Smallint);
begin
  DefaultInterface.GetMappedDevice(nType, nLocalChannel, pnBus, pnNode, pnRemoteChannel);
end;

procedure TMintController.GetDriveMacroNonEmpty(lFlags: Integer; var pbNonEmpty: WordBool);
begin
  DefaultInterface.GetDriveMacroNonEmpty(lFlags, pbNonEmpty);
end;

procedure TMintController.SetDriveUnitProductionDataOld(const strCatalogNumber: WideString; 
                                                        const strSerialNumber: WideString; 
                                                        const strBuildDate: WideString; 
                                                        const strRepairDate: WideString);
begin
  DefaultInterface.SetDriveUnitProductionDataOld(strCatalogNumber, strSerialNumber, strBuildDate, 
                                                 strRepairDate);
end;

procedure TMintController.GetFileSystemEntry(nIndex: Smallint; var pbstrName: WideString; 
                                             var pnType: Smallint; var plSize: Integer);
begin
  DefaultInterface.GetFileSystemEntry(nIndex, pbstrName, pnType, plSize);
end;

procedure TMintController.GetDriveUnitProductionDataOld(var strCatalogNumber: WideString; 
                                                        var strSerialNumber: WideString; 
                                                        var strBuildDate: WideString; 
                                                        var strRepairDate: WideString);
begin
  DefaultInterface.GetDriveUnitProductionDataOld(strCatalogNumber, strSerialNumber, strBuildDate, 
                                                 strRepairDate);
end;

procedure TMintController.GetDriveUnitProductionData(var strCatalogNumber: WideString; 
                                                     var strSerialNumber: WideString; 
                                                     var strBuildDate: WideString; 
                                                     var pnRevCode: Smallint; 
                                                     var pnBetaBuild: Smallint; 
                                                     var pnDemoUnit: Smallint);
begin
  DefaultInterface.GetDriveUnitProductionData(strCatalogNumber, strSerialNumber, strBuildDate, 
                                              pnRevCode, pnBetaBuild, pnDemoUnit);
end;

procedure TMintController.SetDCFSection(nBus: Smallint; nNode: Smallint);
begin
  DefaultInterface.SetDCFSection(nBus, nNode);
end;

procedure TMintController.SetMappedRemoteDevice(nType: Smallint; nLocalChannel: Smallint; 
                                                nBus: Smallint; nNode: Smallint; 
                                                nRemoteNode: Smallint; nRemoteChannel: Smallint);
begin
  DefaultInterface.SetMappedRemoteDevice(nType, nLocalChannel, nBus, nNode, nRemoteNode, 
                                         nRemoteChannel);
end;

procedure TMintController.GetSymbolTableForController(bForceUpload: WordBool; 
                                                      var pBstrSymbolTable: WideString);
begin
  DefaultInterface.GetSymbolTableForController(bForceUpload, pBstrSymbolTable);
end;

procedure TMintController.HelixR(nXAxis: Smallint; nYAxis: Smallint; nZAxis: Smallint; 
                                 fXCentre: Single; fYCentre: Single; fAngle: Single; fZPos: Single);
begin
  DefaultInterface.HelixR(nXAxis, nYAxis, nZAxis, fXCentre, fYCentre, fAngle, fZPos);
end;

procedure TMintController.GetHiperfaceInfo(nAxis: Smallint; var bstrSerialNumber: WideString; 
                                           var bstrProgramVersion: WideString; var nType: Smallint; 
                                           var lAbsCountsPerRev: Integer; 
                                           var nCyclesPerRev: Smallint; var nNumTurns: Smallint);
begin
  DefaultInterface.GetHiperfaceInfo(nAxis, bstrSerialNumber, bstrProgramVersion, nType, 
                                    lAbsCountsPerRev, nCyclesPerRev, nNumTurns);
end;

procedure TMintController.SetMACAddress(nAddress1: Smallint; nAddress2: Smallint; 
                                        nAddress3: Smallint; nAddress4: Smallint; 
                                        nAddress5: Smallint; nAddress6: Smallint);
begin
  DefaultInterface.SetMACAddress(nAddress1, nAddress2, nAddress3, nAddress4, nAddress5, nAddress6);
end;

procedure TMintController.SetLongStop(nAxis: Smallint; fMax: Single; fMin: Single; nState: Smallint);
begin
  DefaultInterface.SetLongStop(nAxis, fMax, fMin, nState);
end;

procedure TMintController.GetMACAddress(var pnAddress1: Smallint; var pnAddress2: Smallint; 
                                        var pnAddress3: Smallint; var pnAddress4: Smallint; 
                                        var pnAddress5: Smallint; var pnAddress6: Smallint);
begin
  DefaultInterface.GetMACAddress(pnAddress1, pnAddress2, pnAddress3, pnAddress4, pnAddress5, 
                                 pnAddress6);
end;

procedure TMintController.GetListData(nListId: Smallint; nIndex: Smallint; 
                                      var pbSupported: WordBool; var pbFloat: WordBool; 
                                      var pnEnum: Smallint; var pnChMin: Smallint; 
                                      var pnChMax: Smallint; var pnChType: Smallint; 
                                      var psLabel: WideString);
begin
  DefaultInterface.GetListData(nListId, nIndex, pbSupported, pbFloat, pnEnum, pnChMin, pnChMax, 
                               pnChType, psLabel);
end;

procedure TMintController.GetFirmwareInfo(var pnReleaseCandidate: Smallint; 
                                          var pnBuildOption: Smallint; var pbstrCustomer: WideString);
begin
  DefaultInterface.GetFirmwareInfo(pnReleaseCandidate, pnBuildOption, pbstrCustomer);
end;

procedure TMintController.SetPCBProductionData(nPCB: Smallint; ucType: Smallint; 
                                               ucArtworkRevision: Smallint; 
                                               ucFunctionalRevision: Smallint; 
                                               ucManufacturer: Smallint; unModState: Integer; 
                                               const bstrSerialNumber: WideString; 
                                               const strPLD1Type: WideString; 
                                               ucPLD1Revision: Smallint; 
                                               const strPLD2Type: WideString; 
                                               ucPLD2Revision: Smallint);
begin
  DefaultInterface.SetPCBProductionData(nPCB, ucType, ucArtworkRevision, ucFunctionalRevision, 
                                        ucManufacturer, unModState, bstrSerialNumber, strPLD1Type, 
                                        ucPLD1Revision, strPLD2Type, ucPLD2Revision);
end;

procedure TMintController.GetPLCTask(nChannel: Smallint; var pbEnable: WordBool; 
                                     var pnCondition1: Smallint; var pnParameter1: Smallint; 
                                     var pnOperator: Smallint; var pnCondition2: Smallint; 
                                     var pnParameter2: Smallint; var pnAction: Smallint; 
                                     var pnActionParameter: Smallint);
begin
  DefaultInterface.GetPLCTask(nChannel, pbEnable, pnCondition1, pnParameter1, pnOperator, 
                              pnCondition2, pnParameter2, pnAction, pnActionParameter);
end;

procedure TMintController.GetPCBProductionData(nPCB: Smallint; var ucType: Smallint; 
                                               var ucArtworkRevision: Smallint; 
                                               var ucFunctionalRevision: Smallint; 
                                               var ucManufacturer: Smallint; 
                                               var unModState: Integer; 
                                               var bstrSerialNumber: WideString; 
                                               var bstrPLD1Type: WideString; 
                                               var ucPLD1Revision: Smallint; 
                                               var bstrPLD2Type: WideString; 
                                               var ucPLD2Revision: Smallint);
begin
  DefaultInterface.GetPCBProductionData(nPCB, ucType, ucArtworkRevision, ucFunctionalRevision, 
                                        ucManufacturer, unModState, bstrSerialNumber, bstrPLD1Type, 
                                        ucPLD1Revision, bstrPLD2Type, ucPLD2Revision);
end;

procedure TMintController.GetSentinel(nChannel: Smallint; var pnSource: Smallint; 
                                      var pnParameter: Smallint; var pnMode: Smallint; 
                                      var pbAbsolute: WordBool; var pfValueLow: Single; 
                                      var pfValueHigh: Single);
begin
  DefaultInterface.GetSentinel(nChannel, pnSource, pnParameter, pnMode, pbAbsolute, pfValueLow, 
                               pfValueHigh);
end;

procedure TMintController.SetSentinel(nChannel: Smallint; nSource: Smallint; nParameter: Smallint; 
                                      nMode: Smallint; bAbsolute: WordBool; fValueLow: Single; 
                                      fValueHigh: Single);
begin
  DefaultInterface.SetSentinel(nChannel, nSource, nParameter, nMode, bAbsolute, fValueLow, 
                               fValueHigh);
end;

procedure TMintController.GetPresetMoveData(nPreset: Smallint; nAccelFormat: Smallint; 
                                            var pnPresetType: Smallint; 
                                            var pnPresetSubType: Smallint; 
                                            var pfPresetPosition: Single; 
                                            var pfPresetSpeed: Single; var pfPresetAccel: Single; 
                                            var pfPresetDecel: Single);
begin
  DefaultInterface.GetPresetMoveData(nPreset, nAccelFormat, pnPresetType, pnPresetSubType, 
                                     pfPresetPosition, pfPresetSpeed, pfPresetAccel, pfPresetDecel);
end;

procedure TMintController.PresetJog(nAxis: Smallint; nPreset: Smallint; fSpeed: Single; 
                                    fAccel: Single; fDecel: Single);
begin
  DefaultInterface.PresetJog(nAxis, nPreset, fSpeed, fAccel, fDecel);
end;

procedure TMintController.PresetMoveA(nAxis: Smallint; nPreset: Smallint; fMove: Single; 
                                      fSpeed: Single; fAccel: Single; fDecel: Single);
begin
  DefaultInterface.PresetMoveA(nAxis, nPreset, fMove, fSpeed, fAccel, fDecel);
end;

procedure TMintController.PresetHome(nAxis: Smallint; nPreset: Smallint; nMode: Smallint; 
                                     fSpeed: Single; fAccel: Single; fDecel: Single);
begin
  DefaultInterface.PresetHome(nAxis, nPreset, nMode, fSpeed, fAccel, fDecel);
end;

procedure TMintController.GetOptionCardProdInfo(nCard: Smallint; var pnType: Smallint; 
                                                var pnVersion: Smallint; 
                                                var pbstrVersion1: WideString; 
                                                var pbstrSerialNumber1: WideString; 
                                                var pbstrVersion2: WideString; 
                                                var pbstrSerialNumber2: WideString; 
                                                var pnAxes: Smallint);
begin
  DefaultInterface.GetOptionCardProdInfo(nCard, pnType, pnVersion, pbstrVersion1, 
                                         pbstrSerialNumber1, pbstrVersion2, pbstrSerialNumber2, 
                                         pnAxes);
end;

procedure TMintController.SetOptionCardProdInfo(nCard: Smallint; nType: Smallint; 
                                                nVersion: Smallint; const bstrVersion1: WideString; 
                                                const bstrSerialNumber1: WideString; 
                                                const bstrVersion2: WideString; 
                                                const bstrSerialNumber2: WideString; nAxes: Smallint);
begin
  DefaultInterface.SetOptionCardProdInfo(nCard, nType, nVersion, bstrVersion1, bstrSerialNumber1, 
                                         bstrVersion2, bstrSerialNumber2, nAxes);
end;

procedure TMintController.SetPLCTask(nChannel: Smallint; bEnable: WordBool; nCondition1: Smallint; 
                                     nParameter1: Smallint; nOperator: Smallint; 
                                     nCondition2: Smallint; nParameter2: Smallint; 
                                     nAction: Smallint; nActionParameter: Smallint);
begin
  DefaultInterface.SetPLCTask(nChannel, bEnable, nCondition1, nParameter1, nOperator, nCondition2, 
                              nParameter2, nAction, nActionParameter);
end;

procedure TMintController.SplineSegment(nAxis: Smallint; nTable: Smallint; nStartSegment: Integer; 
                                        fSegmentArray: OleVariant);
begin
  DefaultInterface.SplineSegment(nAxis, nTable, nStartSegment, fSegmentArray);
end;

procedure TMintController.SetMultipleInterpolatedMoves(pfData: OleVariant);
begin
  DefaultInterface.SetMultipleInterpolatedMoves(pfData);
end;

procedure TMintController.PresetSpeedRef(nAxis: Smallint; nPreset: Smallint; fSpeed: Single; 
                                         fAccel: Single; fDecel: Single);
begin
  DefaultInterface.PresetSpeedRef(nAxis, nPreset, fSpeed, fAccel, fDecel);
end;

procedure TMintController.PresetStop(nAxis: Smallint; nPreset: Smallint);
begin
  DefaultInterface.PresetStop(nAxis, nPreset);
end;

procedure TMintController.GetFileSystemDetails(var pnVersion: Smallint; var pnNumFiles: Smallint; 
                                               var plTotalSpace: Integer; var plUsedSpace: Integer);
begin
  DefaultInterface.GetFileSystemDetails(pnVersion, pnNumFiles, plTotalSpace, plUsedSpace);
end;

procedure TMintController.GetErrorLogEntry(nIndex: Smallint; var pnAxis: Smallint; 
                                           var pnType: Smallint; var pnCode: Integer; 
                                           var pnSeconds: Integer; var pnTicks: Smallint);
begin
  DefaultInterface.GetErrorLogEntry(nIndex, pnAxis, pnType, pnCode, pnSeconds, pnTicks);
end;

procedure TMintController.GetErrorLogEntryRTC(nIndex: Smallint; var pnAxis: Smallint; 
                                              var pnType: Smallint; var plCode: Integer; 
                                              var pDate: TDateTime);
begin
  DefaultInterface.GetErrorLogEntryRTC(nIndex, pnAxis, pnType, plCode, pDate);
end;

procedure TMintController.PresetTorqueRef(nAxis: Smallint; nPreset: Smallint; fTorque: Single; 
                                          fAccel: Single; fDecel: Single);
begin
  DefaultInterface.PresetTorqueRef(nAxis, nPreset, fTorque, fAccel, fDecel);
end;

procedure TMintController.SplineTable(nAxis: Smallint; fPosArray: OleVariant; 
                                      fVelArray: OleVariant; fLengthArray: OleVariant);
begin
  DefaultInterface.SplineTable(nAxis, fPosArray, fVelArray, fLengthArray);
end;

procedure TMintController.GetStaticInfo(nStaticHandle: Integer; var pnType: Smallint; 
                                        var pnSize: Integer; var pnOffset: Integer; 
                                        var pbstrTask: WideString; var pbstrVariable: WideString);
begin
  DefaultInterface.GetStaticInfo(nStaticHandle, pnType, pnSize, pnOffset, pbstrTask, pbstrVariable);
end;

procedure TMintController.PresetPos(nAxis: Smallint; nPreset: Smallint; fPos: Single);
begin
  DefaultInterface.PresetPos(nAxis, nPreset, fPos);
end;

procedure TMintController.PresetMoveR(nAxis: Smallint; nPreset: Smallint; fMove: Single; 
                                      fSpeed: Single; fAccel: Single; fDecel: Single);
begin
  DefaultInterface.PresetMoveR(nAxis, nPreset, fMove, fSpeed, fAccel, fDecel);
end;

procedure TMintController.PresetMoveSuspend(nAxis: Smallint; nPreset: Smallint);
begin
  DefaultInterface.PresetMoveSuspend(nAxis, nPreset);
end;

procedure TMintController.SetNullLink;
begin
  DefaultInterface.SetNullLink;
end;

procedure TMintController.SetOfflineDSPControllerLink(nType: Smallint; nVersion: Integer; 
                                                      nNode: Smallint; nPort: Smallint; 
                                                      lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetOfflineDSPControllerLink(nType, nVersion, nNode, nPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetNextMoveE100Link(nNodeNumber: Smallint; nCommPort: Smallint; 
                                              lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetNextMoveE100Link(nNodeNumber, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetRouteToDCFLink(const lpszFilePath: WideString);
begin
  DefaultInterface.SetRouteToDCFLink(lpszFilePath);
end;

procedure TMintController.SetSC610Link(nNode: Smallint; nPort: Smallint; lBaudRate: Integer; 
                                       bOpenPort: WordBool);
begin
  DefaultInterface.SetSC610Link(nNode, nPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetRouteFromDCFLink(const lpszFilePath: WideString);
begin
  DefaultInterface.SetRouteFromDCFLink(lpszFilePath);
end;

procedure TMintController.SetFadalAmpLink(nNodeNumber: Smallint; nCommPort: Smallint; 
                                          lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetFadalAmpLink(nNodeNumber, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetFlexDrive2Link(nNodeNumber: Smallint; nCommPort: Smallint; 
                                            lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetFlexDrive2Link(nNodeNumber, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetH2USBLink(nNodeNumber: Smallint);
begin
  DefaultInterface.SetH2USBLink(nNodeNumber);
end;

procedure TMintController.SetH2SerialLink(nNode: Smallint; nCommPort: Smallint; lBaudRate: Integer; 
                                          bOpenPort: WordBool);
begin
  DefaultInterface.SetH2SerialLink(nNode, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetH2USBDeviceLink(const szDeviceLink: WideString);
begin
  DefaultInterface.SetH2USBDeviceLink(szDeviceLink);
end;

procedure TMintController.SetFlexPlusDrive2Link(nNodeNumber: Smallint; nCommPort: Smallint; 
                                                lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetFlexPlusDrive2Link(nNodeNumber, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetNextMoveSTLink(nNode: Smallint; nPort: Smallint; lBaudRate: Integer; 
                                            bOpenPort: WordBool);
begin
  DefaultInterface.SetNextMoveSTLink(nNode, nPort, lBaudRate, bOpenPort);
end;

procedure TMintController.InstallKnifeEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallKnifeEventHandler(bInstall);
end;

procedure TMintController.InstallFastInEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallFastInEventHandler(bInstall);
end;

procedure TMintController.InstallInputEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallInputEventHandler(bInstall);
end;

procedure TMintController.InstallErrorEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallErrorEventHandler(bInstall);
end;

procedure TMintController.InstallLatchEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallLatchEventHandler(bInstall);
end;

procedure TMintController.InstallMoveBufferLowEventHandler(bInstall: WordBool);
begin
  DefaultInterface.InstallMoveBufferLowEventHandler(bInstall);
end;

procedure TMintController.SetNextMovePCI1Link(nNodeNumber: Smallint; nCardNumber: Smallint);
begin
  DefaultInterface.SetNextMovePCI1Link(nNodeNumber, nCardNumber);
end;

procedure TMintController.SetNextMoveESLink(nNode: Smallint; nCommPort: Smallint; 
                                            lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetNextMoveESLink(nNode, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetNextMoveESBLink(nNode: Smallint; nCommPort: Smallint; 
                                             lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetNextMoveESBLink(nNode, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetEuroFlexLink(nNodeNumber: Smallint; nCommPort: Smallint; 
                                          lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetEuroFlexLink(nNodeNumber, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetNextMovePCIFastLink(nNodeNumber: Smallint; nCardNumber: Smallint);
begin
  DefaultInterface.SetNextMovePCIFastLink(nNodeNumber, nCardNumber);
end;

procedure TMintController.SetNextMovePCI2FastLink(nNodeNumber: Smallint; nCardNumber: Smallint);
begin
  DefaultInterface.SetNextMovePCI2FastLink(nNodeNumber, nCardNumber);
end;

procedure TMintController.SetNextMoveBXLink(nNodeNumber: Smallint; nCommPort: Smallint; 
                                            lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetNextMoveBXLink(nNodeNumber, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetMicroFlexLink(nNodeNumber: Smallint; nCommPort: Smallint; 
                                           lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetMicroFlexLink(nNodeNumber, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetNextMoveBX2Link(nNodeNumber: Smallint; nCommPort: Smallint; 
                                             lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetNextMoveBX2Link(nNodeNumber, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetMintDrive2Link(nNodeNumber: Smallint; nCommPort: Smallint; 
                                            lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetMintDrive2Link(nNodeNumber, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.SetMicroFlexE100Link(nNodeNumber: Smallint; nCommPort: Smallint; 
                                               lBaudRate: Integer; bOpenPort: WordBool);
begin
  DefaultInterface.SetMicroFlexE100Link(nNodeNumber, nCommPort, lBaudRate, bOpenPort);
end;

procedure TMintController.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure TMintCommandPrompt.InitControlData;
const
  CTFontIDs: array [0..0] of DWORD = (
    $FFFFFE00);
  CControlData: TControlData2 = (
    ClassID: '{2E23F631-82D8-4C5C-A435-39667062B271}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000007;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs);
begin
  ControlData := @CControlData;
end;

procedure TMintCommandPrompt.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DCommandPromptCtrl;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMintCommandPrompt.GetControlInterface: _DCommandPromptCtrl;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TMintCommandPrompt.SetSerialControllerLink(nControllerType: Smallint; nNode: Smallint; 
                                                     nPort: Smallint; nSpeed: Integer; 
                                                     bOpenPort: WordBool);
begin
  DefaultInterface.SetSerialControllerLink(nControllerType, nNode, nPort, nSpeed, bOpenPort);
end;

procedure TMintCommandPrompt.setPCIControllerLink(nControllerType: Smallint; nNode: Smallint; 
                                                  nCard: Smallint);
begin
  DefaultInterface.setPCIControllerLink(nControllerType, nNode, nCard);
end;

procedure TMintCommandPrompt.setMintControllerID(const sID: WideString);
begin
  DefaultInterface.setMintControllerID(sID);
end;

procedure TMintCommandPrompt.setCompiler(nVersion: Integer);
begin
  DefaultInterface.setCompiler(nVersion);
end;

procedure TMintCommandPrompt.setSymbolTable(const sTable: WideString);
begin
  DefaultInterface.setSymbolTable(sTable);
end;

procedure TMintCommandPrompt.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure TMintCommandPrompt.SetEthernetControllerLink(const lpszAddress: WideString);
begin
  DefaultInterface.SetEthernetControllerLink(lpszAddress);
end;

procedure TMintCommandPrompt.DisplayMacroEditor;
begin
  DefaultInterface.DisplayMacroEditor;
end;

procedure TMintCommandPrompt.getContextKeyword(var psKeyword: WideString);
begin
  DefaultInterface.getContextKeyword(psKeyword);
end;

procedure TMintCommandPrompt.SetUSBControllerLink(nNode: Smallint);
begin
  DefaultInterface.SetUSBControllerLink(nNode);
end;

procedure TMintCommandPrompt.setMintController(const pController: IUnknown);
begin
  DefaultInterface.setMintController(pController);
end;

procedure TMintTerminal.InitControlData;
const
  CTFontIDs: array [0..0] of DWORD = (
    $00000002);
  CControlData: TControlData2 = (
    ClassID: '{A157F972-3078-4679-8C9B-3C8AB49369A0}';
    EventIID: '{B023086C-06BC-4637-AB9D-FBCC4A6826DA}';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$80004005*);
    Flags: $00000003;
    Version: 401;
    FontCount: 1;
    FontIDs: @CTFontIDs);
begin
  ControlData := @CControlData;
end;

procedure TMintTerminal.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _DMintTerminal;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TMintTerminal.GetControlInterface: _DMintTerminal;
begin
  CreateControl;
  Result := FIntf;
end;

procedure TMintTerminal.AboutBox;
begin
  DefaultInterface.AboutBox;
end;

procedure TMintTerminal.SetUSBControllerLink(nNode: Smallint);
begin
  DefaultInterface.SetUSBControllerLink(nNode);
end;

procedure TMintTerminal.SetSerialControllerLink(nControllerType: Smallint; nNode: Smallint; 
                                                nPort: Smallint; nSpeed: Integer; 
                                                bOpenPort: WordBool);
begin
  DefaultInterface.SetSerialControllerLink(nControllerType, nNode, nPort, nSpeed, bOpenPort);
end;

procedure TMintTerminal.setPCIControllerLink(nControllerType: Smallint; nNode: Smallint; 
                                             nCard: Smallint);
begin
  DefaultInterface.setPCIControllerLink(nControllerType, nNode, nCard);
end;

procedure TMintTerminal.SetEthernetControllerLink(const lpszAddress: WideString);
begin
  DefaultInterface.SetEthernetControllerLink(lpszAddress);
end;

procedure TMintTerminal.setMintController(const pController: IUnknown);
begin
  DefaultInterface.setMintController(pController);
end;

procedure TMintTerminal.setMintControllerID(const sID: WideString);
begin
  DefaultInterface.setMintControllerID(sID);
end;

class function CoSinkForServerEvents.Create: ISinkForServerEvents;
begin
  Result := CreateComObject(CLASS_SinkForServerEvents) as ISinkForServerEvents;
end;

class function CoSinkForServerEvents.CreateRemote(const MachineName: string): ISinkForServerEvents;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SinkForServerEvents) as ISinkForServerEvents;
end;

procedure TSinkForServerEvents.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{36716D57-1751-474A-A8A6-5F78AA1ACA5A}';
    IntfIID:   '{66B03FD3-2A76-4CB2-9634-F6F44AC752DD}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSinkForServerEvents.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as ISinkForServerEvents;
  end;
end;

procedure TSinkForServerEvents.ConnectTo(svrIntf: ISinkForServerEvents);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TSinkForServerEvents.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TSinkForServerEvents.GetDefaultInterface: ISinkForServerEvents;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TSinkForServerEvents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSinkForServerEventsProperties.Create(Self);
{$ENDIF}
end;

destructor TSinkForServerEvents.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSinkForServerEvents.GetServerProperties: TSinkForServerEventsProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSinkForServerEventsProperties.Create(AServer: TSinkForServerEvents);
begin
  inherited Create;
  FServer := AServer;
end;

function TSinkForServerEventsProperties.GetDefaultInterface: ISinkForServerEvents;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoOCXSerialEventSink.Create: IOCXSerialEventSink;
begin
  Result := CreateComObject(CLASS_OCXSerialEventSink) as IOCXSerialEventSink;
end;

class function CoOCXSerialEventSink.CreateRemote(const MachineName: string): IOCXSerialEventSink;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_OCXSerialEventSink) as IOCXSerialEventSink;
end;

procedure TOCXSerialEventSink.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{35022C4C-587B-4EDE-A98B-2741D3345EE1}';
    IntfIID:   '{3C3B44B3-1DD8-4AE9-888B-B7547499E9D5}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TOCXSerialEventSink.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IOCXSerialEventSink;
  end;
end;

procedure TOCXSerialEventSink.ConnectTo(svrIntf: IOCXSerialEventSink);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TOCXSerialEventSink.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TOCXSerialEventSink.GetDefaultInterface: IOCXSerialEventSink;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TOCXSerialEventSink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TOCXSerialEventSinkProperties.Create(Self);
{$ENDIF}
end;

destructor TOCXSerialEventSink.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TOCXSerialEventSink.GetServerProperties: TOCXSerialEventSinkProperties;
begin
  Result := FProps;
end;
{$ENDIF}

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TOCXSerialEventSinkProperties.Create(AServer: TOCXSerialEventSink);
begin
  inherited Create;
  FServer := AServer;
end;

function TOCXSerialEventSinkProperties.GetDefaultInterface: IOCXSerialEventSink;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TMintController, TMintCommandPrompt, TMintTerminal]);
  RegisterComponents(dtlServerPage, [TSinkForServerEvents, TOCXSerialEventSink]);
end;

end.
