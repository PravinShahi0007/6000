unit MainU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Menus,
  Dialogs, ComCtrls, StdCtrls,  Buttons, system.hash, generics.collections, generics.defaults,
  winUtils, CardBaseU, CardGemMemoU;

type
  TMain = class(TForm)
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    lbErrorStatus: TLabel;
    lbStatus2: TLabel;
    bnLoadCard: TBitBtn;
    bnClose: TBitBtn;
    PopupMenu1: TPopupMenu;
    OldFormatCards1: TMenuItem;
    miOldTruss: TMenuItem;
    miOldPanel: TMenuItem;
    GroupBox1: TGroupBox;
    bnFormatPanelCard: TBitBtn;
    bnFormatTrussCard: TBitBtn;
    bnAdd: TSpeedButton;
    miEnableFormat: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure bnLoadCardClick(Sender: TObject);
    procedure bnCloseClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure miOldPanelClick(Sender: TObject);
    procedure miOldTrussClick(Sender: TObject);
    procedure bnFormatTrussCardClick(Sender: TObject);
    procedure bnFormatPanelCardClick(Sender: TObject);
    procedure bnAddClick(Sender: TObject);
    procedure miEnableFormatClick(Sender: TObject);
  private
    FDomain,FUser: string;
    FCard: TCardBase;
    procedure OnCardStateChange(Sender: TObject);
    procedure ShowError(s: string);
    function checkAuth: boolean;
    procedure FormatCard(AProduct: ansiSTring);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Main: TMain;

implementation

uses CardAPIU,  InputDetailU, passwordU, OldMetresU, cardAcos3U ;
{$R *.dfm}


procedure TMain.bnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TMain.FormatCard(AProduct: ansiSTring);
begin
  try
    Screen.cursor:=crHourGlass;
    FCard.FormatCard(AProduct);
    Screen.cursor:=crDefault;
    OnCardStateChange(self);
    Memo1.lines.Add('FORMAT FINISHED');
  except
    on e: exception do
    begin
      Screen.cursor:=crDefault;
      main.Memo1.lines.Add(e.message);
    end;
  end;
end;

procedure TMain.bnFormatPanelCardClick(Sender: TObject);
begin
  FormatCard('SCSPANEL');
end;

procedure TMain.bnFormatTrussCardClick(Sender: TObject);
begin
 FormatCard('SCSTRUSS');
end;

procedure TMain.bnLoadCardClick(Sender: TObject);
var
  form: TInputDetail;
begin
  form := TInputDetail.Create(Application);
  try
    form.edName.Text        := FCard.IssuedTo;
    form.edSerial.Text      := IntToStr(FCard.SerialNumber);
    form.edQuantity.Text    := '0';
    form.setChargeScheme(FCard.ChargeScheme);
    if form.ShowModal = mrOK then
    begin
      Screen.cursor:=crHourGlass;
      if form.ChargeScheme = ccNoCharge then
         FCard.LoadMetres(form.SerialNumber, rawByteString(form.edName.text), form.ChargeScheme,  0, form.uxExpiry.DateTime)
      else
         FCard.LoadMetres(form.SerialNumber, rawByteString(form.edName.text), form.ChargeScheme,  form.getMetres, encodeDate(2099,12,31));
    end;
  finally
    form.free;
    Screen.cursor:=crDefault;
  end;
// - -- -  get stuff and load
  OnCardStateChange(self);;
end;

constructor TMain.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TMain.Destroy;
begin
  freeAndNil(FCard);
  if assigned(CardApi) then
      CardApi.OnStateChange := nil;
  inherited;
end;

procedure TMain.OnCardStateChange(Sender: TObject);
begin
  screen.cursor:=crHourglass;
  memo1.Lines.Clear;
  bnFormatPanelCard.Enabled  :=  False;
  bnFormatTrussCard.Enabled  :=  False;
  bnLoadCard.Enabled    :=  False;
  freeAndNil(FCard);

  FCard:=tCardBase.Construct(@CardApi.ATR);
  {$Warnings off}
  if FCard=nil then
      FCard := tCardBase.Create ('Unknown card');
  {$Warnings on}

  try
    lbStatus2.caption := CardApi.CardStateStr;
    Memo1.visible := CardApi.CardState = csCard;
    if CardApi.CardState = csCard then
    begin
      lbStatus2.caption := FCard.cardName;
      bnFormatPanelCard.Enabled  := FCard.canFormat;
      bnFormatTrussCard.Enabled  := FCard.canFormat;
      bnLoadCard.Enabled    := FCard.canLoad;
      FCard.AddInfo(Memo1.lines);
    end;
  except
    on e: exception do
      showError(e.message);
  end;
  screen.cursor:=crDefault;
end;

procedure TMain.PopupMenu1Popup(Sender: TObject);
var isOldCard: boolean;
begin
  isOldCard := (CardApi.CardState = csCard) and
               (FCard.ClassType = TCardGemPlusOneK);
  miOldTruss.Enabled:=isOldCard and CheckAuth;
  miOldPanel.Enabled:=isOldCard and CheckAuth;
end;

procedure TMain.FormActivate(Sender: TObject);
begin
  paint;
  application.processmessages;
  if not checkAuth then
  begin
    showerror('NOT AUTHORISED');
    application.ProcessMessages ;
    close;
    Sleep(1000);
    exit;
  end;

  CardApi.OnStateChange := self.OnCardStateChange;
  case CardApi.FReaderList.count of
    1: Statusbar1.SimpleText := String(CardApi.FReader);
    0: ShowError( CardApi.CardStateStr);
    else ShowError('Multiple Readers');
  end;
end;

procedure TMain.miEnableFormatClick(Sender: TObject);
begin
  bnFormatPanelCard.Enabled  :=  True;
  bnFormatTrussCard.Enabled  :=  True;
end;

procedure TMain.miOldPanelClick(Sender: TObject);
begin
 TfrmOldMetres.Exec('T');
end;

procedure TMain.miOldTrussClick(Sender: TObject);
begin
 TfrmOldMetres.Exec('T');
end;

function tMain.checkAuth: boolean;
var
  Hash: cardinal;
  pwd: ansistring;
const
  DomainHash = $FB7BD269;  // = BobJenkinsHash('SCOTTSDALE', SizeOf('SCOTTSDALE'), 0)
  DomainHashMKL = $D850A80D;  // = BobJenkinsHash mkl
  PwdHash = $242BC82B;     // pwd = 173543
begin
  GetDomainAndUserName(FDomain, FUser);
  Hash := Cardinal(THashBobJenkins.GetHashValue (FDomain[1], sizeof(FDomain), 0));
  result := not Hash xor DomainHash = $FFFFFFFF ; // ie sametext(FDomain,'SCOTTSDALE') ;
  if Result then Exit;
  result := not Hash xor DomainHashMKL = $FFFFFFFF ; // ie sametext(FDomain,'SCOTTSDALE') ;
  if Result then Exit;
  pwd := AnsiString(InputPassword('SCS Cardmaster','Password'));
  if pwd <> '' then
     Hash := Cardinal(THashBobJenkins.GetHashValue(pwd[1], length(pwd),0));
  result :=  Hash = Cardinal(PwdHash)  ;
end;

procedure tMain.ShowError(s: string);
begin
  lbErrorStatus.caption:=s;
  lbErrorStatus.visible := s<>'';
end;

procedure TMain.bnAddClick(Sender: TObject);
begin
   TCardACOS3(FCard).      AddMetres (2000, encodeDate(2100,12,31));
   CardApi.Reconnect(1);
end;
initialization
end.
