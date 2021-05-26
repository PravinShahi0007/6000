unit CardAdapterU;
(***************************************************************
  Common interface to "old" cards and " new" cards
    Original cards are Gemplus "GemClub" code (Pete's) is CardU
    1st replacement was Gemplus "Gemclub Memu" - CardGemMemoU.pas)
    next replacement Acos3 in CardAcos3U.pas & CardAcos3ConfigU.pas

  Usage tracking
    Metre useage is tracked in FCardDelta. When this value exceeds
    1 metre , the card is updated (only whole metres stored) and
    FCardDelta reduced.

***************************************************************)

interface
uses Windows, sysUtils, dialogs, cardBaseU, cardU, CardApiU;

type
  TCardAdapter=class
  private
    type TCardType=(ctNone, ctOld, ctNew);
  private
    FCardDelta: double; // accumulated mm not yet deducted from card
    FCardType: TCardType;
    FOldCard:  TCard;
    FCardBase: TCardBase;
    procedure SetCardTypeFromATR;
    procedure updateCard;
  public
    constructor Create;
    Destructor Destroy; override;
    procedure OpenReader;
    procedure CloseReader;
    procedure ClearDelta;
    function CheckCardOK: boolean;
    function CheckCardChargeType(AMachineChargeType : TChargeType): boolean;
    function Metres: integer;
    function MetresOnCard: integer;
    procedure DeductMM(mmDistance: double; AFrameEnd: boolean=false);
    function IssuedTO: string;
    function CardID: string;
    function ChargeScheme: TChargeType;
    function ChargeSchemeStr: String; overload;
    function isUnlimited: boolean;
    function hasCredit: boolean;
    function NoCreditMessage: string;
    function ExpiryDate: tDateTime;
    property CardBase : TCardBase read FCardBase;
  end;

var
  CardAdapter: TCardAdapter;
implementation

{ TCardAdapter }

constructor TCardAdapter.Create;
begin
  FOldCard:= TCard.Create(nil);
end;

destructor TCardAdapter.Destroy;
begin
  CardAdapter:=nil; // clear the singleton
  FOldCard.Free;
  freeAndNil(FCardBase);
  inherited;
end;

function TCardAdapter.ExpiryDate: tDateTime;
begin
  if assigned(FCardBase)  and
     FCardBase.isUnlimitedMetres then
    Result := FCardBase.ExpiryDate
  else
    Result :=0;
end;

function TCardAdapter.hasCredit: boolean;
begin
  if isUnlimited then
    result := ExpiryDate>=Now
  else
    result := (Metres>0);
end;

function TCardAdapter.NoCreditMessage: string;
begin
  if hasCredit then
    result:='OK'
  else
  if isUnlimited then
    result := 'expired'
  else
    result := 'empty';
end;

procedure TCardAdapter.OpenReader;
begin
  CardApi.RefreshCardState ;
  SetCardTypeFromATR;
end;

procedure TCardAdapter.CloseReader;
begin
    case FCardType of
    ctNone: ;
    ctOld:  FOldCard.CloseReader;
    ctNew:  ; // connection is released in object destructor
  end;
end;

function TCardAdapter.ChargeScheme: TChargeType;
begin
  Result := ccGreen;
  if assigned(FCardBase) and
     (FCardBase.ChargeScheme in [ccGreen,ccRed,ccNoCharge]) then
        Result := FCardBase.ChargeScheme ;
end;

function TCardAdapter.ChargeSchemeStr: String;
begin
  if CardApi.CardState = csCard then
    result := tCardBase.ChargeSchemeStr(ChargeScheme)
  else
    result := APIStates[CardApi.CardState];
end;

function TCardAdapter.CheckCardOK: boolean;
const Signature= {$IFDEF Panel}'SCSPANEL'{$Else}'SCSTRUSS'{$Endif};
begin
  Result := false;
  if CardApi=nil then
    exit;
  if (CardApi.CardState = csCard) then
  begin
    case FCardType of
     ctNone: Result := false;
     ctOld:  Result := FOldCard.CheckCardOK ;
     ctNew:  Result := FCardBase.CheckCardOK(Signature);
    end;
  end;
end;


var bWarn: boolean;
function TCardAdapter.CheckCardChargeType(AMachineChargeType : TChargeType): boolean;
begin
  if (self.ChargeScheme=ccRed) and (AMachineChargeType=ccGreen) then
  begin
    if bWarn=false then
      messagebox(0,'"Red" card is not required for this machine.', 'ScotRF',0);
    bWarn:=true;
    exit(true);
  end;

  exit(AMachineChargeType = self.ChargeScheme);
end;

procedure TCardAdapter.SetCardTypeFromATR;
begin
  if (CardApi.CardState = csCard) and
     CompareMem( @CardApi.ATR , @GemClub1K[0], sizeof(GemClub1K)) then
    FCardType:=ctOld
  else
  begin
    freeAndNil(FCardBase);
    FCardBase := TCardBase.Construct(@CardApi.ATR);
    if FCardBase=nil then
      FCardType := ctNone
    else
      FCardType := ctNew;
  end;
end;

function TCardAdapter.CardID: string;
begin
  case FCardType of
    ctNone: Result := 'none';
    ctOld:  Result := FOldCard.cardID;
    ctNew:  Result := FCardBase.IssuedTO +' '+intToStr(FCardBase.SerialNumber );
  end;
end;

function TCardAdapter.IssuedTO: string;
var   i: integer;
begin
  case FCardType of
    ctNone: Result := '';
    ctOld:
      begin
        Result := FOldCard.cardID;
        i:= pos('#',result);
        if i>0 then
          result := copy(result,1,i-1);
      end;
    ctNew:  Result := FCardBase.IssuedTO ;
  end;
end;

function TCardAdapter.isUnlimited: boolean;
begin
  result := (FCardType = ctNew) and
            FCardBase.isUnlimitedMetres;
end;

{$region 'Metres on Card'}

{ Metres on Card
  Metres stored as integer; fractions tracked by FCardDelta
  Update
    Standard card - at end of each items
    Unlimited card - at end of each frame (to reduce card read/write count)
  Value
    Normally pre-loaded with purchased amount and decreases to zero.
    Unlimited card starts at zero and decreases; value on the card is negative
  FCardDelta
    Class variable holding mm not yet deducted from the card
}

procedure TCardAdapter.DeductMM(mmDistance: double; AFrameEnd: boolean);
begin
  FCardDelta := FCardDelta + mmDistance;
  if isUnlimited then
  begin
    // Update card at frame end only
    if AFrameEnd then
      updateCard;
  end
  else
  begin
    // Update card when accumulated total > 1 metre
    if  FCardDelta >= 1000 then
      updateCard;
  end;
end;


function TCardAdapter.MetresOnCard: integer;
begin
  Result := 0;
  case FCardType of
    ctOld:  Result := FOldCard.DecryptMT;
    ctNew:  Result := FCardBase.Metres;
  end;
end;

function TCardAdapter.Metres: integer;
begin
  if FCardType=ctNone then
    exit(0);
  Result := MetresOnCard - trunc(FCardDelta / 1000);
end;

procedure TCardAdapter.updateCard;
var
  Value: integer;
  deltaMetres: integer;
begin
  Value := MetresOnCard ;
  if (Value<0) and not isUnlimited then
    raise exception.Create('Card metres negative');
  deltaMetres:= trunc(FCardDelta/1000);
  if (DeltaMetres >= 1) and ((DeltaMetres <= 100) or isUnlimited) then
  begin
    FCardDelta :=  FCardDelta - deltaMetres * 1000;
    Value := Value - deltaMetres;
    case FCardType of
      ctNone: raise exception.Create('no card');
      ctOld:
        begin
          FOldCard.SetCard(value) ;
        end;
      ctNew:  FCardBase.Metres := Value;
    end;
  end;
end;
procedure TCardAdapter.ClearDelta;
begin
  FCardDelta:=0;
end;

{$endregion}
initialization
  // created in .dpr (dependancy on CardAPI)
finalization
  freeandNil(CardAdapter);


end.

