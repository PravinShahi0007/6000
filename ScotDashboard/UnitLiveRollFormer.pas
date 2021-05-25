unit UnitLiveRollFormer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, DB;

type
  TFrameLiveRollFormer = class(TFrame)
    PanelRFTitle: TPanel;
    LabelRFName: TLabel;
    LabelDayMeters: TLabel;
    LabelJobName: TLabel;
    LabelFrameName: TLabel;
    MemoItems: TMemo;
    LabelRFStatus: TLabel;
  private
    { Private declarations }
    FRollFormerID   : String;
    FRollFormerName : String;
    FCurrentJobName   : String;
    FCurrentFrameName : String;
    FDayMeters : String;
    Procedure SetCurrentJobName( aCurrentJobName : String);
    Procedure SetCurrentFrameName( aCurrentFrameName : String);
    Procedure SetDayMeters( aDayMeters : String);
    procedure SetJobStart(aBool : Boolean);
    procedure SetJobFinish(aBool : Boolean);
    procedure SetJobPause(aBool : Boolean);
  public
    { Public declarations }
    constructor CreateLiveRollFormer(aOwner: TComponent; aParent:TWinControl; aRFDataSet: TDataSet);
    Procedure ClearData;
    property RollFormerID     : String read FRollFormerID;
    property CurrentJobName   : String read FCurrentJobName   write SetCurrentJobName;
    property CurrentFrameName : String read FCurrentFrameName write SetCurrentFrameName;
    property DayMeters        : String read FDayMeters write SetDayMeters;
    property JobStart         : Boolean write SetJobStart;
    property JObFinish        : Boolean write SetJObFinish;
    property JobPause         : Boolean write SetJobPause;

  end;

implementation

{$R *.dfm}

Constructor TFrameLiveRollFormer.CreateLiveRollFormer(aOwner: TComponent; aParent:TWinControl; aRFDataSet: TDataSet);
begin
  Inherited Create(aOwner);
  Align  := alLeft;
  Parent := aParent;
  Name   := 'RFFRAME'+ aRFDataSet.FieldByName('RollFormerID').AsString;
  FRollFormerID   := aRFDataSet.FieldByName('RollFormerID').AsString;
  FRollFormerName := aRFDataSet.FieldByName('NAME').AsString;
  LabelRFName.Caption := Format('%s', [FRollFormerName]);
  LabelDayMeters.Caption :='';
  ClearData;
end;

Procedure TFrameLiveRollFormer.ClearData;
begin
  LabelJobName.Caption := '';
  LabelFrameName.Caption := '';
  MemoItems.Clear;
end;

Procedure TFrameLiveRollFormer.SetCurrentJobName( aCurrentJobName : String);
begin
  FCurrentJobName := aCurrentJobName;
  LabelJobName.Caption := FCurrentJobName;
end;
Procedure TFrameLiveRollFormer.SetCurrentFrameName( aCurrentFrameName : String);
begin
  FCurrentFrameName := aCurrentFrameName;
  LabelFrameName.Caption := Format('%s', [FCurrentFrameName]);
end;

Procedure TFrameLiveRollFormer.SetDayMeters( aDayMeters : String);
begin
  FDayMeters := aDayMeters;
  LabelDayMeters.Caption :=Format('%s', [FDayMeters]);
end;

procedure TFrameLiveRollFormer.SetJobStart(aBool : Boolean);
begin
  If aBool then
  begin
    MemoItems.Color := clLime;
    LabelRFStatus.Caption :='Machine Running'
  end;
end;

procedure TFrameLiveRollFormer.SetJobFinish(aBool : Boolean);
begin
  If aBool then
  begin
    MemoItems.Color := clGray;
    LabelRFStatus.Caption :='Job Finished'
  end;
end;

procedure TFrameLiveRollFormer.SetJobPause(aBool : Boolean);
begin
  If aBool then
  begin
    MemoItems.Color := clYellow;
    LabelRFStatus.Caption :='Machine Paused'
  end;
end;


end.
