unit MainU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,  Buttons,  generics.collections, generics.defaults,
  winUtils, CardNewU, FormatDetailU, Menus;

type
  TMain = class(TForm)
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    lbErrorStatus: TLabel;
    lbStatus2: TLabel;
    bnFormatCard: TBitBtn;
    bnLoadCard: TBitBtn;
    bnClose: TBitBtn;
    PopupMenu1: TPopupMenu;
    OldFormatCards1: TMenuItem;
    miOldTruss: TMenuItem;
    miOldPanel: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure bnFormatCardClick(Sender: TObject);
    procedure bnLoadCardClick(Sender: TObject);
    procedure bnCloseClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure miOldPanelClick(Sender: TObject);
    procedure miOldTrussClick(Sender: TObject);
  private
    FDomain,FUser: string;
    FCard: TCardBase;
    FFormatDetail: TFormatDetail;
    procedure OnCardStateChange(Sender: TObject);
    procedure ShowError(s: string);
    function checkAuth: boolean;
    function MemoCard: TCardClubMemo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  Main: TMain;

implementation

uses CardAPIU, InputDetailU, passwordU, OldMetresU;
{$R *.dfm}

procedure TMain.bnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TMain.bnFormatCardClick(Sender: TObject);
begin
  if FFormatDetail=nil then
    FFormatDetail := TFormatDetail.Create(self); // keep the form so same values can be used on successive cards
  if FFormatDetail.ShowModal = mrOK then
  begin
    Screen.cursor:=crHourGlass;

    FCard.FormatCard(FFormatDetail.PanelOrTruss,FFormatDetail.ChargeScheme);
    Screen.cursor:=crDefault;
  end;
  OnCardStateChange(self);;
end;

procedure TMain.bnLoadCardClick(Sender: TObject);
var
  form: TInputDetail;
  ClubMemoCard : TCardClubMemo;
  defDate: tDateTime;
  dd,mm,yy: word;
begin
  form := TInputDetail.Create(Application);
  try
   ClubMemoCard := FCard as TCardClubMemo;
    form.edName.Text        := ClubMemoCard.IssuedTo;
    form.edQuantity.Text    := '0';
    form.edQuantity.Enabled := not ClubMemoCard.isUnlimitedMetres;
    decodedate(Now,yy,mm,dd) ;
    inc(yy,3);

    defDate := EncodeDate(yy,4,4); // 4th April
    form.uxExpiry.DateTime  := defDate;
    form.uxExpiry.Visible   := ClubMemoCard.isUnlimitedMetres;
    form.lbExpiry.Visible   := ClubMemoCard.isUnlimitedMetres;
    form.edSerial.Text      := IntToStr(ClubMemoCard.SerialNumber);
    if form.ShowModal = mrOK then
    begin
      Screen.cursor:=crHourGlass;
      if ClubMemoCard.isUnlimitedMetres then
        FCard.LoadMetres(form.SerialNumber, rawByteString(form.edName.text), 0, now, form.uxExpiry.DateTime)
      else
        FCard.LoadMetres(form.SerialNumber, rawByteString(form.edName.text), form.getmetres, now, 0);
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
  bnFormatCard.Enabled  :=  False;
  bnLoadCard.Enabled    :=  False;
  freeAndNil(FCard);

  if (CardApi.CardState = csCard) and
      CompareMem( @CardApi.ATR , @GemClubMemo[0], sizeof(GemClubMemo)) then
    FCard := TCardClubMemo.Create
  else
    FCard := tCardBase.Create;
  try
    lbStatus2.caption := CardApi.CardName;
    Memo1.visible := (FCard is TCardClubMemo);
    if (FCard is TCardClubMemo) then
    begin
      MemoCard.AddInfo(Memo1.lines);
      bnFormatCard.Enabled  :=  not MemoCard.isUserMode;
      bnLoadCard.Enabled    :=  MemoCard.isUserMode;
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
               (FCard <> TCardClubMemo.Create);
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

function TMain.MemoCard: TCardClubMemo;
begin
  result := FCard as TCardClubMemo;
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
  Hash: uint32;
  pwd: ansistring;
const
  DomainHash = $DD11E856;  // = BobJenkinsHash('SCOTTSDALE', SizeOf('SCOTTSDALE'), 0)
  PwdHash = $9A0E96AF;     // pwd = 173543
begin
  GetDomainAndUserName(FDomain, FUser);
  FDomain := 'SCOTTSDALE';
  Hash := BobJenkinsHash(FDomain[1], sizeof(FDomain), 0);
//  result := not Hash xor DomainHash = $FFFFFFFF; // ie sametext(FDomain,'SCOTTSDALE') ;
  result := True;
  if not result then
  begin
     pwd := InputPassword('SCS Cardmaster','Password');
     Hash := BobJenkinsHash(pwd[1],length(pwd),0);
     result := hash = PwdHash;
     bnFormatCard.visible:=false; // remove 'Format' when not on domain
     bnFormatCard.onClick:=nil;
  end;
end;

procedure tMain.ShowError(s: string);
begin
  lbErrorStatus.caption:=s;
  lbErrorStatus.visible := s<>'';
end;

initialization
end.
