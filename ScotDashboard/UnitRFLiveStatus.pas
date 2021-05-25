unit UnitRFLiveStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitChildWin, VclTee.TeeGDIPlus,
  Data.DB, VCLTee.TeEngine, VCLTee.Series, Vcl.ExtCtrls, VCLTee.TeeProcs,
  VCLTee.Chart, VCLTee.DBChart, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, DBXJSON, JSON, UnitLiveRollFormer, System.Generics.Collections;

type

  TDashBoardCallback = class(TDBXCallback)
  public
    function Execute(const Arg: TJSONValue): TJSONValue; override;
  end;

  TMDIChildRFLiveStatus = class(TMDIChild)
    DBChartLiveProduction: TDBChart;
    BarSeries1: TBarSeries;
    ScrollBoxRFStatus: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FRollFormers : TDictionary<String, TFrameLiveRollFormer>;
    FFrameLiveRollFormer : TFrameLiveRollFormer;
  public
    { Public declarations }
    procedure LogMsg(const aRFID, aJobID, aJobName, aFrameName, aItemName, aDayMeters, aEventID: string);
    procedure QueueLogMsg(const Arg: TJSONValue);
  end;

var
  MDIChildRFLiveStatus: TMDIChildRFLiveStatus;

implementation

{$R *.dfm}

uses UnitDMRFStatus, ScotRFTypes, UnitDMDesignJob;


function TDashBoardCallback.Execute(const Arg: TJSONValue): TJSONValue;
begin
  If Assigned(MDIChildRFLiveStatus) then
    MDIChildRFLiveStatus.QueueLogMsg(Arg);
  Result := TJSONTrue.Create;
end;

procedure TMDIChildRFLiveStatus.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  MDIChildRFLiveStatus:=nil;
end;

procedure TMDIChildRFLiveStatus.FormCreate(Sender: TObject);
begin
  inherited;
  FRollFormers := TDictionary<String, TFrameLiveRollFormer>.Create;
  If Not Assigned(DMDesignJob) then
    Exit;
  DMDesignJob.FDMemTableRollFormer.First;
  while Not DMDesignJob.FDMemTableRollFormer.Eof do
  begin
    FFrameLiveRollFormer := TFrameLiveRollFormer.CreateLiveRollFormer(Self,ScrollBoxRFStatus,DMDesignJob.FDMemTableRollFormer);
    FRollFormers.Add(DMDesignJob.FDMemTableRollFormer.FieldByName('RollFormerID').AsString, FFrameLiveRollFormer);
    DMDesignJob.FDMemTableRollFormer.Next;
  end;
end;

procedure TMDIChildRFLiveStatus.LogMsg(const aRFID, aJobID, aJobName, aFrameName, aItemName, aDayMeters, aEventID: string);
var
  anEventID : TRFEventType;
  i : integer;
begin
  anEventID := TRFEventType(StrToInt(aEventID));
  if FRollFormers.TryGetValue(aRFID, FFrameLiveRollFormer) = False  then
  begin
    DMDesignJob.GetROLLFORMER;
    DMDesignJob.FDMemTableRollFormer.Locate('RollFormerID', aRFID,[]);
    FFrameLiveRollFormer := TFrameLiveRollFormer.CreateLiveRollFormer(Self,ScrollBoxRFStatus,DMDesignJob.FDMemTableRollFormer);
    FRollFormers.Add(DMDesignJob.FDMemTableRollFormer.FieldByName('RollFormerID').AsString, FFrameLiveRollFormer);
  end;
  DMDesignJob.FDMemTableJOB.FindKey([StrToIntDef(aJobID, 0)]);
  with FFrameLiveRollFormer do
  begin
    If anEventID = rfetItemStart then
    begin
      JobStart := True;
      DMRFStatus.EndTime := Now;
      DBChartLiveProduction.Refresh;
    end
    else
    If anEventID = rfetJobFinish then
    begin
      JobFinish:= True;
      DMDesignJob.ResetFilter('0');
      DMDesignJob.GetJOB;
      DMDesignJob.GetEP2FILE;
      DMDesignJob.GetFrame;
      DMDesignJob.GetFrameEntity;
      DMDesignJob.GetItemProduction;
    end
    else
    If anEventID = rfetPause then
    begin
      JobPause := True;
      Exit;
    end
    else
    begin
      JobStart := True;
    end;
    CurrentJobName   := aJobName;
    CurrentFrameName := aFrameName;
    DayMeters        := aDayMeters;
    MemoItems.Lines.Add(DateTimeToStr(Now) +':'+aItemName);
  end;
end;

procedure TMDIChildRFLiveStatus.QueueLogMsg(const Arg: TJSONValue);
var
  aRFID : String;
  aJobName : String;
  aFrameName : String;
  aItemName : String;
  aDayMeters : String;
  aEventID   : String;
  aJobID     : String;
begin
  aRFID      := Arg.GetValue<String>('RollformerID');
  aJobID     := Arg.GetValue<String>('JobID');
  aJobName   := Arg.GetValue<String>('JobName');
  aFrameName := Arg.GetValue<String>('FrameName');
  aItemName  := Arg.GetValue<String>('ItemName');
  aDayMeters := Arg.GetValue<String>('DayMeters');
  aEventID   := Arg.GetValue<String>('EventID');
  TThread.Queue(nil, procedure begin LogMsg(aRFID, aJobID, aJobName, aFrameName, aItemName, aDayMeters, aEventID) end);
end;

end.
