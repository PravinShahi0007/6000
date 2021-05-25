unit IJPMaster;

interface

uses
  SysUtils, strUtils, Windows, Classes, ScotRFTypes, ijpTypesU, extCtrls;

var verbose: integer = 250;

  //  TInkjetType = (ijpNone,dod2002, sx32, videojet, sojet);
type

  TInkJet = class(TComponent)
  private
    FTimer: TTimer;
    FPrinter: IInkjetPrinter;
    FPrinterType: TInkjetType;
    procedure setPrinterType(const Value: TInkjetType);
    procedure OnTimer(AObject: Tobject);
  public
    property PrinterType: TInkjetType read FPrinterType write setPrinterType;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var InkJetMaster: TInkJet;

implementation

uses IJPBaseU, ijpSojetU, ijpotherU;

const POLLING_INTERVAL=5000;

constructor TInkJet.Create(AOwner: TComponent);
begin
  inherited;
  FTimer:= TTimer.Create(self);
  FTimer.Interval := POLLING_INTERVAL;
  FTimer.OnTimer := self.OnTimer;
  FTimer.Enabled :=true;
end;

destructor TInkJet.Destroy;
begin
  FTimer.Enabled:=false;
  FTimer.Free;

  inherited;
end;

procedure TInkJet.OnTimer(AObject: Tobject);
begin

end;

procedure TInkJet.setPrinterType(const Value: TInkjetType);
// class factory - create printer-specific object and
var InkJetObj: TInkJetB;
begin
  case Value of
    ijpNone:
      InkJetObj := TInkJetB.Create(Self, nil); // base class - all requests ignored
    Sojet:
      InkJetObj := TSojet.Create(Self, nil);
    else
      InkJetObj := TIJPOther.Create(Self, nil);
  end;
  FPrinter := InkJetObj;  //  cast to an interface
  FPrinterType := Value;
end;

end.
