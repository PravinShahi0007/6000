unit IJPOtherU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, VaClasses, VaComm, ExtCtrls, ScotRFTypes, IJPBaseU;

type
  TIJPOther = class(TInkJetB)
    Timer5: TTimer;
    VaComm2: TVaComm;
    procedure Timer5Timer(Sender: TObject);
    procedure VaComm2RxChar(Sender: TObject; Count: Integer);
  private
    pcmd, Cmd: array [1 .. 300] of byte;
    ptick: Integer;
    VaComm2Response: string;    // VaComm2
    selectedSCS: boolean;
    InkjetType : TInkjetType;
  const
    lf = ansichar(10);
    esc = ansichar(27);
    eot = 4; ack = 6; nak = 21; stx = 2; etx = 3; enq = 5;

  protected
    procedure SendPrintLine(AText: ansistring; APrintSpaceRemaining: double);
  public
    constructor Create(AOwner: TComponent;AType:TInkjetType); reintroduce;
    function ConnectToIJP: boolean; override;
    function Connected: boolean; override;
    procedure CloseConnections; override;
    function SendPrintCommand(cs: ansistring; wfr: boolean): boolean;   // called from settings form (NOT for sojet)
    procedure StartPrint(AText: AnsiString; APrintSpaceRemaining: double); override;
    procedure TriggerPrint; override;
  end;

implementation

uses Usettings, Com_Exception;
{$R *.dfm}

procedure TIJPOther.Timer5Timer(Sender: TObject);
// *Tick event for Timer5. Increments ptick.
begin
  inc(ptick);
end;

procedure TIJPOther.VaComm2RxChar(Sender: TObject; Count: Integer);
// *Rcv chr event for VaComm2 serial port
begin
  VaComm2Response := VaComm2Response + VaComm2.ReadText;
end;

procedure TIJPOther.CloseConnections;
begin
  inherited;
  VaComm2.close;
end;

function TIJPOther.Connected: boolean;
begin
  result := VaComm2.Active;
end;

function TIJPOther.ConnectToIJP: boolean;
begin
  inherited;
  result := false;
  VaComm2.devicename := G_Settings.general_com2port;

  //If inkjet printer is selected, open VaComm2 as its serial port
  try
    VaComm2.open;
    if VaComm2.Active then
    begin
      If G_Settings.inkprinter_inkbaudrate = '9600' then
        VaComm2.baudrate := TVabaudrate(br9600)
      else if G_Settings.inkprinter_inkbaudrate = '19200' then
        VaComm2.baudrate := TVabaudrate(br19200)
      else if G_Settings.inkprinter_inkbaudrate = '57600' then
        VaComm2.baudrate := TVabaudrate(br57600)
      else if G_Settings.inkprinter_inkbaudrate = '115200' then
        VaComm2.baudrate := TVabaudrate(br115200);
      //Dod2002 9600 ,sx32 19200, videojet ?
      result := true;
    end;
  except
    on E: Exception do
      HandleException(e,'TIJPOther.ConnectToIJP',[]);
  end;

end;

constructor TIJPOther.Create(AOwner: TComponent; AType: TInkjetType);
begin
  inherited Create(AOwner);
  InkjetType := AType;
end;

procedure TIJPOther.SendPrintLine(AText: ansistring; APrintSpaceRemaining: double);
// *Send printline to inkjet printer
// *AText is acii string message
const
  LOGO_WIDTH_REQUIRED=300; // space required  for logo bitmap
var
  i, j, logowidth: word;
  ts: ansistring;
  bShowLogo: boolean;
begin
  VaComm2Response := '';
  setStatus(3, AText);
  application.processmessages;
  if InkjetType = dod2002 then
  begin // ---------------- Mathews DoD2002 ------------------
    pcmd[1] := ord(esc);
    pcmd[2] := ord('L');
    pcmd[3] := ord('1');
    pcmd[4] := ord(':');
    j := 4; // last element used so far
    ts := formsettings.LogoEdit.text;
    if ((formsettings.LogoCBox.Checked) and (length(ts) > 0)) then
    // add logo if selected
    begin
      pcmd[5] := ord(esc);
      pcmd[6] := ord('+');
      pcmd[7] := ord('G');
      for i := 1 to length(ts) do
      begin
        pcmd[i + 7] := ord(ts[i]);
        j := i + 7;
      end;
      inc(j);
      pcmd[j] := ord(esc);
      inc(j);
      pcmd[j] := ord('+');
      inc(j);
      pcmd[j] := ord('T');
    end;
    // continue with text if any
    i := j + 1;
    j := 1;
    repeat
      pcmd[i] := ord(AText[j]);
      inc(i);
      inc(j);
    until j > length(AText);
    pcmd[i] := ord(lf);
    pcmd[i + 1] := ord(lf);
    VaComm2.WriteBuf(pcmd[1], i + 1); // i+2 -->> i+1 Apr 09
    ptick := 0;
    Timer5.enabled := true;
    repeat
      application.processmessages;
    until (length(VaComm2Response) > 0) or (ptick > 10);
    Timer5.enabled := false;
    if VaComm2Response = ansichar(ack) then
      setStatus(1, 'DoD2002 Ack')
    else if ptick > 10 then
      setStatus(1,'DoD2002 T/Out');
  end
  else if InkjetType = sx32 then
  begin // ----------------- Mathews SX-32 --------------------
    // set text message [0]
    ts := 'ST[0]= "' + AText + '", SIZE = 16';
    SendPrintCommand(ts, true);

    bShowLogo := formsettings.LogoCBox.Checked and
                 (LOGO_WIDTH_REQUIRED < APrintSpaceRemaining);
    if bShowLogo then
    begin // Logo + text
      logowidth := length(formsettings.LogoEdit.text) div 2;
      ts := trim(inttostr(logowidth));
      // setup message structure - logo + text
      SendPrintCommand('SM[0] = ((G[24]@ 0:0),(T[0]@ ' + ts + ':0))', true);
      // G[24] = 24th graphics array object - buillt in settings
      // T[0] = 0th array text message - set each time in buildInkLine routine
      // ts:0 is x:y position on print line
    end else
    begin
      // setup message structure - text only
      SendPrintCommand('SM[0] = ((T[0]@ 0:0))', true);
    end;
  end
  else if InkjetType = videojet then
  begin // ----------------- VideoJet --------------------
    // select text message 'SCS' to print
    //showmessage('Selecting SCS message');
    if not selectedSCS then
    begin
      //debuglabel.caption:='Selecting SCS message'; application.processmessages;
      SendPrintCommand(chr(2)+ 'MSCS' + chr(3), true);
      selectedSCS := true; //Only send select SCS messzage once.
    end;
    // setup message structure - text only
    ts := chr(2) //stx
    + 'T' //message type 'T'
    + '04' //font number for 1220 model
    + '0001' //horizontal text position
    + '034' //vertical position
    + '000000' //attributes
    + AText //message
    + chr(3); //etx
    //debuglabel.caption:='Inkjet text = '+ AText;
    SendPrintCommand(ts, true);
  end

end;

procedure TIJPOther.StartPrint(AText: AnsiString; APrintSpaceRemaining: double);
begin
  if (length(AText) > 0) then
  begin
    SendPrintLine(AText, APrintSpaceRemaining);
    TriggerPrint; // Do It
  end;

end;

procedure TIJPOther.TriggerPrint;
// * Forces inkjet to print now. Uses VaComm2 port
begin
  if InkjetType = dod2002 then
  begin
    Cmd[1] := ord(^c);
    VaComm2.WriteBuf(Cmd[1], 1);
  end
  else if InkjetType = sx32 then
  begin // sx32 print trigger
    SendPrintCommand('TRIGON', true);
    SendPrintCommand('TRIGOFF', true);
  end;
  //VideoJet & SoJet use hardware initiated printing.
end;

function MakePrintable(S: ansistring): string;
var c: ansichar;
const specials = ' ,.~!@#$%^&*()=+;:"''{}*?/\';
begin
  for c in S do
    if (c in ['a' .. 'z', 'A' .. 'Z', '0' .. '9']) or (pos(c, specials)> 0)then
      result := result + c
    else
      result := result + format('<%2.2x>', [byte(c)]);
end;

function TIJPOther.SendPrintCommand(cs: ansistring; wfr: boolean): boolean;
// *Generic - sends a command string cs, to the inkjet printer
// wfr - WaitForReply flag
var
  i, j: word;
const CRLF: string=#13#10;
begin
  result := true;
  VaComm2Response := '';
  setStatus(1, cs);
  i := 1;
  //=================== Dod2002 ========================
  if InkjetType = dod2002 then
  begin
    pcmd[i] := ord(esc);
    inc(i); // esc is first chr for dod2002
    j := 1;
    repeat
      pcmd[i] := ord(cs[j]);
      inc(i);
      inc(j);
    until j > length(cs);
    pcmd[i] := ord(lf);
    pcmd[i + 1] := ord(lf); // last 2 chrs are LFs for dod2002
    VaComm2.WriteBuf(pcmd[1], i + 1);
  end
  // ================== SX32 ============================
  else if InkjetType = sx32 then
  begin
    j := 1;
    repeat
      pcmd[i] := ord(cs[j]);
      inc(i);
      inc(j);
    until i > length(cs);
    pcmd[i] := 13; // last chr for SX-32 is a CR
    VaComm2.WriteBuf(pcmd[1], i);
  end
  //===================== VideoJet ======================
  else if InkjetType = videojet then
  begin
    j := 1;
    repeat
      pcmd[i] := ord(cs[j]);
      inc(i);
      inc(j);
    until i > length(cs); // send command as is to videojet, no extra chrs
    VaComm2.WriteBuf(pcmd[1], i - 1);
    //showmessage('Sent '+inttostr(i-1)+' chrs to videojet');
  end;

  if wfr then { Wait For Reply is true}
  begin
    ptick := 0;
    Timer5.enabled := true;
    if InkjetType = dod2002 then
      repeat
        application.processmessages
      until (length(VaComm2Response) > 0) or (ptick > 10) // dod2002 gives ack or nak
      else if InkjetType = sx32 then
      repeat
        application.processmessages
      until (pos(CRLF,VaComm2Response) >0) or (ptick > 10) // sx32 says 'ok' + CR, videojet r3plies with
      else if InkjetType = videojet then
      repeat
        application.processmessages
      until (length(VaComm2Response) >= 3) or (ptick > 10);// videojet replies with 3 or more chrs

      Timer5.enabled := false;

    if InkjetType = dod2002 then
      result := (VaComm2Response = ansichar(ack))
    else if InkjetType = sx32 then
      result := (copy(VaComm2Response, 1, 2) = 'ok') // sx32 says ok
    else if InkjetType = videojet then // videojet reply
    begin
      result :=(length(VaComm2Response)>= 3);
      //debuglabel.caption:='VideoJet replied  ['+rps+']'; application.processmessages;
    end;
    if ptick>10 then
      setStatus(1, 'Timeout')
    else if result then
      setStatus(1, 'Ok')
    else
      setStatus(1, 'Error: ['+MakePrintable(VaComm2Response)+']');
  end;
end;

end.
