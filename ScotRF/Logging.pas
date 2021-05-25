unit Logging;

interface

uses
  windows, sysutils, classes, variants, Math, fileCtrl, iniFiles, generics.Collections, generics.Defaults,
  strUtils, WinUtils, ScotRFTypes, GlobalU, ManufactureU, FrameDataU, DBClient, Data.DB, UnitServiceManager;

type
  TMachineState =(msRunning, msSim, msPaused, msIdle, msClosed);

  TLineStyle = (lsLine, lsPoint);

procedure RecordToolOp(op: string);
function DefaultLogFolder: string;
procedure EventAudit(anEventType: TRFEventType; aString: String; aMeter : Double = 0);
procedure OperationRecord(anOperation: TRFOperation);

procedure StartService;
procedure StopService;

const
  StateStr: array[TMachineState] of string=('ACTIVE', 'SIM', 'PAUSED', 'IDLE', 'CLOSED');

var
  aEventAudit : TEventAudit;
  FServiceManager : TServiceManager;
  FServiceStatus  : TServiceState;

implementation

uses VersionU, RollFormerU, UnitDMRFDateInfo
, Com_Exception, DateUtils;

procedure RecordToolOp(op: string);
begin
{$IFDEF Panel}
  if (op = 'Cope') then
    op := 'Flat';
{$ENDIF}
end;

function DefaultLogFolder: string;
begin
  result := ScsProgramDataPath; // = C:\ProgramData\Scottsdale\
end;

function Timestamp(T: TDateTime): string;
var TS: TTimeStamp;
begin
  // machine readable date-time as string
  TS := DateTimeToTimestamp(T);
  result := 'D:' + intToStr(TS.Date)+ ',T:' + intToStr(TS.Time);
end;

function fieldValue(AKey: string; ACSVString: String): string;
var SL: tStringlist;
begin
  result := '';
  SL := tStringlist.Create;
  try
    SL.StrictDelimiter := true;
    SL.CommaText := ACSVString;
    result := SL.Values[AKey];
    if result <> '' then
      if result[1]= '"' then
        result := AnsiDequotedStr(result, '"');
  finally
    SL.Free;
  end;
end;

procedure EventAudit(anEventType: TRFEventType; aString: String; aMeter : Double = 0);
begin
  Try
    case anEventType of
      rfetFrameStart:
      begin
        FRFDateInfo.Init;
        FRFDateInfo.StartTime := Now;
      end;
      rfetItemStart:
      begin
        FRFDateInfo.Init;
      end;
      rfetToolOp:
      begin
        if AnsiPos('Op=FPunch', aString)>0 then
          FRFDateInfo.FPUNCH  := FRFDateInfo.FPUNCH + 1
        else
        if AnsiPos('Op=Flat', aString)>0 then
          FRFDateInfo.FLAT    := FRFDateInfo.FLAT + 1
        else
        if AnsiPos('Op=Notch', aString)>0 then
          FRFDateInfo.NOTCH   := FRFDateInfo.NOTCH + 1
        else
        if AnsiPos('Op=Swage', aString)>0 then
          FRFDateInfo.FSWAGE  := FRFDateInfo.FSWAGE + 1
        else
        if AnsiPos('Op=Cut', aString)>0 then
          FRFDateInfo.CUTS    := FRFDateInfo.CUTS + 1;
      end;
      rfetItemFinish:
      begin
        FRFDateInfo.REMAINMETERS := CardInformation.Metres;
        FRFDateInfo.METERS       := aMeter;
        FRFDateInfo.RUNTIME      := 0;
        FRFDateInfo.PAUSETIME    := 0;
        DMRFDateInfo.AddData( FRFDateInfo );                                      //
      end;
      rfetFrameFinish:
      begin
        FRFDateInfo.RUNTIME      := Round(MilliSecondsBetween(FRFDateInfo.StartTime, Now)/1000);
        FRFDateInfo.PAUSETIME    := 0;
        FRFDateInfo.METERS       := 0;
        DMRFDateInfo.AddData( FRFDateInfo );                                      //
      end;
      rfetPause:
      begin
        FRFDateInfo.RUNTIME      := 0;
        FRFDateInfo.PAUSETIME    := Round(MilliSecondsBetween(FRFDateInfo.StartPause, Now)/1000);
        DMRFDateInfo.AddData( FRFDateInfo );                                      //
      end;
    end;
  Except
    on E: Exception do
      HandleException(e,'TFormScotTruss.OnItemFinish',[]);
  End;
end;

procedure OperationRecord(anOperation: TRFOperation);
begin
  try
  finally
  end;
end;

procedure StartService;
begin
  FServiceManager := TServiceManager.Create;
  FServiceManager.Active := True;
  FServiceStatus := FServiceManager.ServiceByName['ServiceScot'].State;
  Case FServiceStatus of
    ssStopped      : begin
                       FServiceManager.ServiceByName['ServiceScot'].ServiceStart(True);
                     end;
    ssRunning      : begin
                     end;
    ssContinuePending:;
    ssPausePending:;
    ssPaused:;
  End;
end;

procedure StopService;
begin
  FServiceStatus := FServiceManager.ServiceByName['ServiceScot'].State;
  Case FServiceStatus of
    ssStopped      : begin
                     end;
    ssRunning      : begin
                       FServiceManager.ServiceByName['ServiceScot'].ServiceStop(True);
                     end;
    ssContinuePending:;
    ssPausePending:;
    ssPaused:;
  End;

end;

initialization

finalization


end.
