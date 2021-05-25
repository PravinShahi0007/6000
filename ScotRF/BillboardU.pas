unit BillboardU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, generics.collections;

type
  TBillboard = class(TFrame)
    Panel1: TPanel;
    Label1: TLabel;
    procedure FrameResize(Sender: TObject);
  private
    FLabels: TList<TLabel>;
    function GetLabels(i: integer): TLabel;
    procedure SetYPos;
    procedure SetCount(const Value: integer);
    function getCount: integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure DisplayItem(s: string); //displays next string s, in label list on main production screen - FILO
    procedure SetFontSize(ASize: integer);
    property Labels[i: integer]: TLabel read GetLabels;
    property Count: integer read getCount write SetCount;
  end;

implementation

{$R *.dfm}
{ TBillboard }

constructor TBillboard.Create(AOwner: TComponent);
begin
  inherited;
  FLabels := TList<TLabel>.Create;
  FLabels.Add(Label1);

  Count := 50;

  Clear;
end;

destructor TBillboard.Destroy;
begin
  FLabels.Free;
  inherited;
end;

procedure TBillboard.DisplayItem(s: string);
var i: integer;
begin
  for i := (FLabels.Count - 1) downto 1 do
    FLabels[i].Caption := FLabels[i - 1].Caption;
  Label1.Caption := s;
end;

procedure TBillboard.FrameResize(Sender: TObject);
var L: TLabel;
begin
  SetYPos;
  for L in FLabels do
    L.visible := L.Top > 2;
end;

function TBillboard.getCount: integer;
begin
  result := FLabels.Count;
end;

procedure TBillboard.Clear;
var i: integer;
begin
  for i := 0 to pred(FLabels.Count) do
    FLabels[i].Caption := '';
end;

function TBillboard.GetLabels(i: integer): TLabel;
begin
  result := FLabels[i];
end;

procedure TBillboard.SetCount(const Value: integer);
var L: TLabel;
begin
  while FLabels.Count < Value do
  begin
    L := TLabel.Create(self);
    L.Parent := Panel1;
    L.Anchors := Label1.Anchors;
    L.BoundsRect := Label1.BoundsRect;
    L.Font.Assign(Label1.Font);

    FLabels.Add(L);
  end;
  SetYPos;
end;

procedure TBillboard.SetFontSize(ASize: integer);
var L: TLabel;
begin
  for L in FLabels do
    L.Font.size := ASize;
  SetYPos;
end;

procedure TBillboard.SetYPos;
var
  Y, dy: integer;
  L: TLabel;
begin
  Y := clientheight - 22;
  dy := Label1.height + 2;
  for L in FLabels do
  begin
    L.Top := Y;
    Dec(Y, dy);
  end;
end;

end.
