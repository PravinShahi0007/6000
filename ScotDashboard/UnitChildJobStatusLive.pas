unit UnitChildJobStatusLive;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitChildWin, DBXJSON, JSON, System.Generics.Collections;

type

//  TJobLiveCallback = class(TDBXCallback)
//  public
//    function Execute(const Arg: TJSONValue): TJSONValue; override;
//  end;

  TMDIChildCurrentJobProcessing = class(TMDIChild)
  private
    { Private declarations }

//    procedure QueueLogMsg(const Arg: TJSONValue);
//    procedure LogMsg(const aRFID, aJobID, aJobName, aEP2FILEID, aEP2FILE, aFrameID, aFrameName, aItemName, aDayMeters, aEventID: string);
  public
    { Public declarations }
  end;

var
  MDIChildCurrentJobProcessing: TMDIChildCurrentJobProcessing;

implementation

{$R *.dfm}

uses ScotRFTypes, UnitDMDesignJob, UnitDMRFStatus;


//function TJobLiveCallback.Execute(const Arg: TJSONValue): TJSONValue;
//begin
//  If Assigned(MDIChildCurrentJobProcessing) then
//    MDIChildCurrentJobProcessing.QueueLogMsg(Arg);
//  Result := TJSONTrue.Create;
//end;

//procedure TMDIChildCurrentJobProcessing.QueueLogMsg(const Arg: TJSONValue);
//var
//  aRFID      : String;
//  aJobName   : String;
//  aEP2FILEID : String;
//  aEP2FILE   : String;
//  aFrameID   : String;
//  aFrameName : String;
//  aItemName  : String;
//  aDayMeters : String;
//  aEventID   : String;
//  aJobID     : String;
//begin
//  aRFID      := Arg.GetValue<String>('RollformerID');
//  aJobID     := Arg.GetValue<String>('JobID');
//  aJobName   := Arg.GetValue<String>('JobName');
//  aFrameID   := Arg.GetValue<String>('FRAMEID');
//  aFrameName := Arg.GetValue<String>('FrameName');
//  aEP2FILEID := Arg.GetValue<String>('EP2FILEID');
//  aEP2FILE   := Arg.GetValue<String>('EP2FILE');
//  aItemName  := Arg.GetValue<String>('ItemName');
//  aDayMeters := Arg.GetValue<String>('DayMeters');
//  aEventID   := Arg.GetValue<String>('EventID');
//  TThread.Queue(nil, procedure begin LogMsg(aRFID, aJobID, aJobName, aEP2FILEID, aEP2FILE, aFrameID, aFrameName, aItemName, aDayMeters, aEventID) end);
//end;
//
//procedure TMDIChildCurrentJobProcessing.LogMsg(const aRFID, aJobID, aJobName, aEP2FILEID, aEP2FILE, aFrameID, aFrameName, aItemName, aDayMeters, aEventID: string);
//var
//  anEventID : TRFEventType;
//begin
//  anEventID := TRFEventType(StrToInt(aEventID));
//  DMDesignJob.FDMemTableJOB.FindKey([StrToIntDef(aJobID, 0)]);
//end;

end.
