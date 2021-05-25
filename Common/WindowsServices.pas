unit WindowsServices;

interface

uses WinSvc, Windows, Forms, Classes, SysUtils, UnitStopServiceForm;

function ServiceStart(
  const sMachine,
        sService : string ) : Boolean;
function ServiceStop(
  const sMachine,
        sService : string ) : Boolean;
function ServiceGetList(
  const sMachine : string;
  const dwServiceType,
        dwServiceState : DWORD;
  const slServicesList : TStrings ) : Boolean;
function ServiceExists(
  const sMachine,
        sService : string;
  const dwServiceState : DWORD ) : Boolean;

const
  //
  // Service Types
  //
  SERVICE_KERNEL_DRIVER       = $00000001;
  SERVICE_FILE_SYSTEM_DRIVER  = $00000002;
  SERVICE_ADAPTER             = $00000004;
  SERVICE_RECOGNIZER_DRIVER   = $00000008;

  SERVICE_DRIVER              =
    (SERVICE_KERNEL_DRIVER or
     SERVICE_FILE_SYSTEM_DRIVER or
     SERVICE_RECOGNIZER_DRIVER);

  SERVICE_WIN32_OWN_PROCESS   = $00000010;
  SERVICE_WIN32_SHARE_PROCESS = $00000020;
  SERVICE_WIN32               =
    (SERVICE_WIN32_OWN_PROCESS or
     SERVICE_WIN32_SHARE_PROCESS);

  SERVICE_INTERACTIVE_PROCESS = $00000100;

  SERVICE_TYPE_ALL            =
    (SERVICE_WIN32 or
     SERVICE_ADAPTER or
     SERVICE_DRIVER  or
     SERVICE_INTERACTIVE_PROCESS);

implementation

//
// start service
//
// return TRUE if successful
//
// sMachine:
//   machine name, ie: \SERVER
//   empty = local machine
//
// sService
//   service name, ie: Alerter
//
function ServiceStart(
  const sMachine,
        sService : string ) : Boolean;
var
  //
  // service control
  // manager handle
  schm,
  //
  // service handle
  schs   : SC_Handle;
  //
  // service status
  ss     : TServiceStatus;
  //
  // temp char pointer
  psTemp : PChar;
  //
  // check point
  dwChkP : DWORD;
  // start service form
  AStopServiceForm: TStopServiceForm;
begin
  ss.dwCurrentState := 0;

  // connect to the service
  // control manager
  schm := OpenSCManager(
    PChar(sMachine),
    Nil,
    SC_MANAGER_CONNECT);

  // if successful...
  if(schm > 0)then
  begin
    // open a handle to
    // the specified service
    schs := OpenService(
      schm,
      PChar(sService),
      // we want to
      // start the service and
      SERVICE_START or
      // query service status
      SERVICE_QUERY_STATUS);

    // if successful...
    if(schs > 0)then
    begin
      psTemp := Nil;
      if(StartService(
           schs,
           0,
           psTemp))then
      begin
        // check status
        if(QueryServiceStatus(
             schs,
             ss))then
        begin
          while (SERVICE_RUNNING
            <> ss.dwCurrentState) do
          begin
            //
            // dwCheckPoint contains a
            // value that the service
            // increments periodically
            // to report its progress
            // during a lengthy
            // operation.
            //
            // save current value
            //
            dwChkP := ss.dwCheckPoint;

            //
            // wait a bit before
            // checking status again
            //
            // dwWaitHint is the
            // estimated amount of time
            // the calling program
            // should wait before calling
            // QueryServiceStatus() again
            //
            // idle events should be
            // handled here...
            //
            AStopServiceForm := TStopServiceForm.Create(nil);
            try
              AStopServiceForm.SetHeading('Starting Service Scot. ' +
                'Please wait...');
              AStopServiceForm.SetTimer(ss.dwWaitHint);
              AStopServiceForm.ShowModal();
            finally
              AStopServiceForm.Release();
            end;

            if(not QueryServiceStatus(
                 schs,
                 ss))then
            begin
              // couldn't check status
              // break from the loop
              break;
            end;

            if(ss.dwCheckPoint <
              dwChkP)then
            begin
              // QueryServiceStatus
              // didn't increment
              // dwCheckPoint as it
              // should have.
              // avoid an infinite
              // loop by breaking
              break;
            end;
          end;
        end;
      end;

      // close service handle
      CloseServiceHandle(schs);
    end;

    // close service control
    // manager handle
    CloseServiceHandle(schm);
  end;

  // return TRUE if
  // the service status is running
  Result :=
    SERVICE_RUNNING =
      ss.dwCurrentState;
end;

//
// stop service
//
// return TRUE if successful
//
// sMachine:
//   machine name, ie: \SERVER
//   empty = local machine
//
// sService
//   service name, ie: Alerter
//
function ServiceStop(
  const sMachine,
        sService : string ) : Boolean;
var
  //
  // service control
  // manager handle
  schm,
  //
  // service handle
  schs   : SC_Handle;
  //
  // service status
  ss     : TServiceStatus;
  //
  // check point
  dwChkP : DWORD;
  // stop service form
  AStopServiceForm: TStopServiceForm;
begin
  // connect to the service
  // control manager
  schm := OpenSCManager(
    PChar(sMachine),
    Nil,
    SC_MANAGER_CONNECT);

  // if successful...
  if(schm > 0)then
  begin
    // open a handle to
    // the specified service
    schs := OpenService(
      schm,
      PChar(sService),
      // we want to
      // stop the service and
      SERVICE_STOP or
      // query service status
      SERVICE_QUERY_STATUS);

    // if successful...
    if(schs > 0)then
    begin
      if(ControlService(
           schs,
           SERVICE_CONTROL_STOP,
           ss))then
      begin
        // check status
        if(QueryServiceStatus(
             schs,
             ss))then
        begin
          while(SERVICE_STOPPED
            <> ss.dwCurrentState)do
          begin
            //
            // dwCheckPoint contains a
            // value that the service
            // increments periodically
            // to report its progress
            // during a lengthy
            // operation.
            //
            // save current value
            //
            dwChkP := ss.dwCheckPoint;

            //
            // wait a bit before
            // checking status again
            //
            // dwWaitHint is the
            // estimated amount of time
            // the calling program
            // should wait before calling
            // QueryServiceStatus() again
            //
            // idle events should be
            // handled here...
            //
            AStopServiceForm := TStopServiceForm.Create(nil);
            try
              AStopServiceForm.SetHeading('Stopping Service Scot. ' +
                'Please wait...');
              AStopServiceForm.SetTimer(ss.dwWaitHint);
              AStopServiceForm.ShowModal();
            finally
              AStopServiceForm.Release();
            end;

            if(not QueryServiceStatus(
                 schs,
                 ss))then
            begin
              // couldn't check status
              // break from the loop
              break;
            end;

            if(ss.dwCheckPoint <
              dwChkP)then
            begin
              // QueryServiceStatus
              // didn't increment
              // dwCheckPoint as it
              // should have.
              // avoid an infinite
              // loop by breaking
              break;
            end;
          end;
        end;
      end;

      // close service handle
      CloseServiceHandle(schs);
    end;

    // close service control
    // manager handle
    CloseServiceHandle(schm);
  end;

  // return TRUE if
  // the service status is stopped
  Result :=
    SERVICE_STOPPED =
      ss.dwCurrentState;
end;

//-------------------------------------
// Get a list of services
//
// return TRUE if successful
//
// sMachine:
//   machine name, ie: \SERVER
//   empty = local machine
//
// dwServiceType
//   SERVICE_WIN32,
//   SERVICE_DRIVER or
//   SERVICE_TYPE_ALL
//
// dwServiceState
//   SERVICE_ACTIVE,
//   SERVICE_INACTIVE or
//   SERVICE_STATE_ALL
//
// slServicesList
//   TStrings variable to storage
//
function ServiceGetList(
  const sMachine : string;
  const dwServiceType,
        dwServiceState : DWORD;
  const slServicesList : TStrings ) : Boolean;
const
  //
  // assume that the total number of
  // services is less than 4096.
  // increase if necessary
  cnMaxServices = 4096;

type
  TSvcA = array[0..cnMaxServices]
          of TEnumServiceStatus;
  PSvcA = ^TSvcA;
          
var
  //
  // temp. use
  j : integer;

  //
  // service control
  // manager handle
  schm          : SC_Handle;

  //
  // bytes needed for the
  // next buffer, if any
  nBytesNeeded,

  //
  // number of services
  nServices,

  //
  // pointer to the
  // next unread service entry
  nResumeHandle : DWORD;

  //
  // service status array
  ssa : PSvcA;
begin
  Result := false;

  // connect to the service
  // control manager
  schm := OpenSCManager(
    PChar(sMachine),
    Nil,
    SC_MANAGER_ALL_ACCESS);

  // if successful...
  if(schm > 0)then
  begin
    nResumeHandle := 0;

    New(ssa);

    EnumServicesStatus(
      schm,
      dwServiceType,
      dwServiceState,
      ssa^[0],
      SizeOf(ssa^),
      nBytesNeeded,
      nServices,
      nResumeHandle );

    //
    // assume that our initial array
    // was large enough to hold all
    // entries. add code to enumerate
    // if necessary.
    //
    
    for j := 0 to nServices-1 do
    begin
      slServicesList.
        Add( StrPas(
          ssa^[j].lpDisplayName ) );
    end;

    Result := True;

    Dispose(ssa);

    // close service control
    // manager handle
    CloseServiceHandle(schm);
  end;
end;

//-------------------------------------
// Find out if a service is installed 
//
// return TRUE if found to be installed
//
// sMachine:
//   machine name, ie: \SERVER
//   empty = local machine
//
// sService
//   service name, ie: Alerter
//
// dwServiceState
//   SERVICE_ACTIVE,
//   SERVICE_INACTIVE or
//   SERVICE_STATE_ALL
//
function ServiceExists(
  const sMachine,
        sService : string;
  const dwServiceState : DWORD ) : Boolean;
var
  sl: TStringList;
  i: Integer;
begin
  Result := False;
  sl := TStringList.Create();
  try
    if ServiceGetList(sMachine, SERVICE_WIN32, dwServiceState, sl) = True then
    begin
      for i := 0 to sl.Count - 1 do
      begin
        if AnsiCompareStr(sl[i], sService) = 0 then
        begin
          Result := True;
          Break;
        end;
      end;
    end;
  finally
    if Assigned(sl) then
      FreeAndNil(sl);
  end;
end;

end.
