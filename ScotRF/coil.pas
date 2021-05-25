unit coil;
{
 Form to allow users to enter coil details for production logging data
}

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, Buttons, iniFiles, strUtils, winUtils;

type
  TCoilform = class(TForm)
    Label1: TLabel;
    uxCoilID: TEdit;
    bnSave: TBitBtn;
    Label4: TLabel;
    uxJobName: TEdit;
    uxOperator: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    uxRiveters: TMemo;
    Label6: TLabel;
    uxCoilWeight: TEdit;
    uxDesign: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    uxSteel: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure EnableButtons(Sender: TObject);
    procedure bnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ReadIni;
    procedure WriteIni;
    function GetCoilWeight: double;
    function GetCoilID: string;
    function GetJobName: string;
    function GetRiveters: TStrings;
    function GetOperator: string;
    function GetCoilGauge: double;
    function GetDesign: string;
    function GetSteel: string;
  protected // unused
    function WeightOK: boolean;
    function GaugeOK: boolean;
  public
    procedure SetFormDetails(const AJobname, ADesign, ASteel: string); overload;
    function RivetersStr:  String;
    property JobName:      String    read GetJobName;
    property Design:       String    read GetDesign;
    property Steel:        String    read GetSteel;
    property CoilID:       String    read GetCoilID;
    property CoilWeight:   Double    read GetCoilWeight;
    property CoilGauge:    Double    read GetCoilGauge;
    property Riveters:     TStrings  read GetRiveters;
    property OperatorName: String    read GetOperator;

  end;


implementation

uses logging, cardAdapterU, GlobalU, FrameDataU, UnitDMJOBDETAIL;
{$R *.DFM}

const SECTION = 'JOB';

procedure TCoilform.setFormDetails(const AJobname, ADesign, ASteel: string);
begin
  If AJobname <> '' then
    uxJobName.text := AJobname;
  If ADesign <> '' then
    uxDesign.text := ADesign;
  If ASteel <> '' then
    uxSteel.text := ASteel;
end;

procedure TCoilform.FormCreate(Sender: TObject);
begin
  ReadIni;
end;

procedure TCoilform.FormShow(Sender: TObject);
begin
  EnableButtons(nil);
end;

function TCoilform.getCoilID: string;
begin
  result := Trim(uxCoilID.text);
end;

function TCoilform.getCoilWeight: double;
begin
  result := StrToFloatDef(uxCoilWeight.text, 0);
end;

function TCoilform.getDesign: string;
begin
  result := uxDesign.text;
end;

function TCoilform.getCoilGauge: double;
begin
end;

function TCoilform.getJobName: string;
begin
  result := Trim(uxJobName.text);
end;

function TCoilform.getOperator: string;
begin
  result := Trim(uxOperator.text);
end;

function TCoilform.getRiveters: TStrings;
begin
  uxRiveters.Lines.delimiter := ';';
  result := uxRiveters.Lines;
end;

function TCoilform.getSteel: string;
begin
  result := Trim(uxSteel.text);
end;

function TCoilform.RivetersStr: String;
begin
  uxRiveters.Lines.delimiter := ';';
  result := uxRiveters.Lines.DelimitedText;
end;


procedure TCoilform.WriteIni;
var
  iniFile: tMemInifile;
  i: integer;
  aJobDetail :  TJOBDETAIL;
begin
  iniFile := tMemInifile.create('ScotRF.ini');
  iniFile.Encoding := TEncoding.Unicode;
  try
    iniFile.EraseSection(SECTION);
    iniFile.writeString(SECTION, 'JobName', JobName);
    iniFile.writeString(SECTION, 'Operator', OperatorName);
    iniFile.writeString(SECTION, 'Design', Design);
    iniFile.writeString(SECTION, 'Steel', Steel);
    for i := 0 to Riveters.count - 1 do
      if Trim(Riveters[i])<> '' then
        iniFile.writeString(SECTION, 'Riveters' + inttostr(i), Trim(Riveters[i]));
    iniFile.writeString(SECTION, 'CoilID', CoilID);
    iniFile.writeFloat(SECTION, 'CoilGauge', CoilGauge);
    iniFile.writeFloat(SECTION, 'CoilWeight', CoilWeight);
    iniFile.UpdateFile;
  finally
    iniFile.free;
  end;
end;

procedure TCoilform.ReadIni;
var
  i: integer;
  iniFile: tMemInifile;
  SL: tStringlist;
begin
  iniFile := tMemInifile.create('ScotRF.ini', TEncoding.Unicode);
  SL := tStringlist.create;
  try
    iniFile.ReadSectionValues(SECTION, SL);
    uxJobName.text := iniFile.readString(SECTION, 'JobName', '');
    uxOperator.text := iniFile.readString(SECTION, 'Operator', '');
    uxDesign.text := iniFile.readString(SECTION, 'Design', '');
    uxSteel.text := iniFile.readString(SECTION, 'Steel', '');
    uxRiveters.Lines.clear;
    for i := 0 to SL.count - 1 do
      if StartsText('Riveters', SL[i]) then
        uxRiveters.Lines.Add(SL.ValueFromIndex[i]);
    uxCoilID.text := iniFile.readString(SECTION, 'CoilID', '');
    uxCoilWeight.text := iniFile.readString(SECTION, 'CoilWeight', '');
  finally
    SL.free;
    iniFile.free;
  end;
end;

function TCoilform.WeightOK: boolean;
var W: double;
begin
  W := StrToFloatDef(uxCoilWeight.text,-1);
  result :=(uxCoilWeight.text = '') or ((W >= 0) and (W < 2.0));
end;

function TCoilform.GaugeOK: boolean;
begin
end;

procedure TCoilform.bnSaveClick(Sender: TObject);
begin
  WriteIni;
end;

procedure TCoilform.EnableButtons(Sender: TObject);
begin
  bnSave.enabled := (Trim(JobName)<> '') and (Trim(OperatorName) <> '');
end;

end.
