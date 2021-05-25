unit IJPBaseU;

interface

uses
  SysUtils, strUtils, Windows, Classes, ScotRFTypes;

var verbose: integer = 250;

type

  TInkJetB = class(TDataModule)
  public
    setStatus: TStatusInfoProc ;       // callback methods to update on-screen status
    setLight: TStatusLightProc ;
    setInk : TStatusInkProc;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowCmdBuffer(Buffer: pbyte; Count: integer; txt: string= '');

    procedure StartPrint(AText: AnsiString; APrintSpaceRemaining: double); virtual; // caled at item start  ;
    procedure TriggerPrint; virtual;                  // called at print position (only if TriggerRequired returns true)
    function Connected: boolean; virtual;
    function ConnectToIJP: boolean; virtual;
    procedure CloseConnections; virtual;
    class procedure IJPTrace(s: string); inline; static;
  end;

implementation

uses Math, Usettings, VirtualMachineU ;
{$R *.dfm}

constructor TInkJetB.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  ods('%s Create %s Serial # %s',[classname, Self.Classname, formsettings.inkserialedit.text]);
end;

destructor TInkJetB.Destroy;
begin
  CloseConnections;
  inherited
end;

class procedure TInkJetB.IJPTrace(s: string);
begin
  TVMForm.AddString(s);
end;

procedure TInkJetB.CloseConnections;
begin
  //Close IP sockets
end;

function TInkJetB.Connected: boolean;
begin
  result := false;  // placeholder
end;

function TInkJetB.ConnectToIJP: boolean;
begin
  result := true;  // placeholder
end;

procedure TInkJetB.TriggerPrint;
// * Forces inkjet to print now. Uses VaComm2 port
begin
  // placeholder
end;

procedure TInkJetB.StartPrint(AText: AnsiString; APrintSpaceRemaining: double);
begin
  // Placeholder
end;

procedure TInkJetB.ShowCmdBuffer(Buffer: pbyte; Count: integer; txt: string= '');
var i, j: integer;
  s: string;
begin
  dec(verbose);

  if Count > 300 then
    Count := 300;
  i := 0;
  while i < Count do
  begin
    j := i;
    s := format('%.2d>',[i]);
    while j < min(Count, i + 4) do
    begin
      s := s + format(' %.2X',[Buffer[j]]);
      inc(j);
    end;
    inc(i, 4);
  end;

end;

end.

