unit IJPMasterU;

interface

uses
  SysUtils, strUtils, Windows, Classes, ScotRFTypes, ijpBaseU, extCtrls, ijpStatusU;

var verbose: integer = 250;

type

  TInkJetMaster = class(TComponent)
  private
    FPrinter: TInkJetB;
    FPrinterType: TInkjetType;
    FEnabled: boolean;
    FStatus1: string;
    procedure setPrinterType(const Value: TInkjetType);
    procedure setStatusFrame1(const Value: TInkjetStatus);
    procedure setStatusFrame2(const Value: TInkjetStatus);
    procedure SetEnabled(const Value: boolean);
    procedure UpdateStatus;
    procedure onShowStatus(aLine: int8; AText: string);
    procedure onShowStatusLight(aLight: TStatusLight);
    procedure onShowInk(v1, v2: double);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    FStatusFrame1: TInkjetStatus;
    FStatusFrame2: TInkjetStatus;
    property Status1: string read FStatus1; // on-screen response text

    property PrinterType: TInkjetType read FPrinterType write setPrinterType;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property StatusFrame1: TInkjetStatus read FStatusFrame1 write setStatusFrame1;
    property StatusFrame2: TInkjetStatus read FStatusFrame2 write setStatusFrame2;
    procedure StartPrint(AText: AnsiString; APrintSpaceRemaining: double);
    procedure TriggerPrint;
    procedure InitSojetPrinter;
    property IJPType: TInkjetType read FPrinterType;
    function SendPrintCommand(cs: AnsiString; wfr: boolean): boolean; //(NOT for sojet)
    function PrinterTypeAsString: string;
    function IJPTriggerRequired: boolean;
    property IJPEnabled: boolean read FEnabled write SetEnabled;
  end;

var InkJetMaster: TInkJetMaster;

implementation

uses ijpSojetU, ijpotherU;

constructor TInkJetMaster.Create(AOwner: TComponent);
begin
  inherited;
  PrinterType:=ijpNone;
end;

destructor TInkJetMaster.Destroy;
begin
  inherited;
end;

function TInkJetMaster.IJPTriggerRequired: boolean;
begin
  result := PrinterType = sojet;
end;

procedure TInkJetMaster.InitSojetPrinter;
begin
  if FPrinter is TSojet then
    TSojet(FPrinter).InitSojetPrinter;
end;

function TInkJetMaster.PrinterTypeAsString: string;
begin
  result := strInkjetType[FPrinterType];
end;

function TInkJetMaster.SendPrintCommand(cs: AnsiString; wfr: boolean): boolean;
begin
  result := true;
  if FPrinter is TIJPOther then
    result :=  TIJPOther(FPrinter).SendPrintCommand(cs, wfr);
end;

procedure TInkJetMaster.SetEnabled(const Value: boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if Value then
      FPrinter.connectToIJP
    else
      FPrinter.CloseConnections;
  end;
  UpdateStatus;
end;

procedure TInkJetMaster.onShowInk(v1, v2: double);
begin
  if assigned(FStatusFrame1) then
    FStatusFrame1.SetInkStatus(v1, v2);
  if assigned(FStatusFrame2) then
    FStatusFrame2.SetInkStatus(v1, v2);
end;

procedure TInkJetMaster.onShowStatusLight(aLight: TStatusLight);
begin
  if assigned(FStatusFrame1) then
    FStatusFrame1.StatusLight := aLight;
  if assigned(FStatusFrame2) then
    FStatusFrame2.StatusLight := aLight;
end;

procedure TInkJetMaster.onShowStatus(aLine: int8; AText: string);
begin
  if assigned(FStatusFrame1) then
    FStatusFrame1.Line[aLine]:= AText;
  if assigned(FStatusFrame2) then
    FStatusFrame2.Line[aLine]:= AText;
  if ALine=1 then
    FStatus1:=AText;
end;

procedure TInkJetMaster.UpdateStatus;
var
 Line1 : string;
 Light: TStatusLight;
begin
  onShowStatus(0, strInkjetType[FPrinterType]);
  assert(FPrinter <>nil); // FPrinter should always be assigned

  if (FPrinterType = ijpNone) or not IJPEnabled then // no printer or sim or virtual
  begin
    Line1 := 'PRINTING OFF';
    Light := tsOff;
  end
  else
  begin
    Line1:='Connected';
    Light := tsOK;
    if not FPrinter.Connected then
    begin
      Line1:='NO CONNECTION';
      if FPrinter is tSojet and
        (tSojet(FPrinter).FSocketError<>'')  then
          Line1:= tSojet(FPrinter).FSocketError;
      Light:=tsRed;
    end;
  end;
  onShowStatus(1, Line1);onShowStatusLight( Light);
end;

procedure TInkJetMaster.setPrinterType(const Value: TInkjetType);
// class factory - create printer-specific object
begin
  if (Value <> FPrinterType) or (FPrinter=nil) then
  begin
    if FPrinter<>nil then
      IJPEnabled:=false; // close connections
    FreeAndNil(FPrinter);
    case Value of
      ijpNone:
        FPrinter := TInkJetB.Create(self); // base class - all requests ignored
      sojet:
        FPrinter := TSojet.Create(self);
    else
      FPrinter := TIJPOther.Create(self, Value);
    end;
    FPrinter.setStatus := onShowStatus;   // link status callback methods
    FPrinter.setLight := onShowStatusLight;
    FPrinter.setInk := onShowInk;
    FPrinterType := Value;
  end;
end;

procedure TInkJetMaster.setStatusFrame1(const Value: TInkjetStatus);
begin
  FStatusFrame1 := Value;
  if Value <> nil then
    Value.FreeNotification(self);
end;

procedure TInkJetMaster.setStatusFrame2(const Value: TInkjetStatus);
begin
  FStatusFrame2 := Value;
  if Value <> nil then
    Value.FreeNotification(self);
end;

procedure TInkJetMaster.StartPrint(AText: AnsiString; APrintSpaceRemaining: double);
begin
  FPrinter.StartPrint(AText, APrintSpaceRemaining);
end;

procedure TInkJetMaster.TriggerPrint;
begin
  FPrinter.TriggerPrint;
end;

procedure TInkJetMaster.Notification(AComponent: TComponent; Operation: TOperation);
// Notification mechanism ensures we do not keep links to deleted objects
begin
  if Operation = opRemove then
  begin
    if AComponent = FStatusFrame1 then
      FStatusFrame1 := nil;
    if AComponent = FStatusFrame2 then
      FStatusFrame2 := nil;
  end;
  inherited;
end;

end.
