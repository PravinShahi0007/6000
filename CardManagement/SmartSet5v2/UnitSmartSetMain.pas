unit UnitSmartSetMain;
{
Unit that allows users to setup data on s/card - Panel type version 5
Author - Pete
Nov 2003 - increased limit to 150000m
Nov 2007 - Added limit of 200,000 metres & confim,ation for > 25000 m
Feb 2011 - V5.22 with 24 byte usage record - encrytped}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, Des, inifiles;

type
  TCTInit  = function (Ctn,Pn : word) : Smallint; stdcall;
  TCTClose = function (Ctn : word) : Smallint; stdcall;
  TCTData  = function (Ctn : word;                                              //Ctn -- Card Ternimial Number
                       var Dad, Sad : Byte;                                     //Dad -- Destination Address, Sad -- Source Address
                       LC  : UInt16;                                            //Lc  -- Length of Command
                       Cmd : PansiChar;
                       var LR : Uint16;                                         //Lr  -- Length of Response
                       Rsp : PAnsiChar ) : SmallInt; stdcall;                   //Rsp -- Response Address
  CTCarray = array[1..2] of byte;
  TFormSmartSet = class(TForm)
    ButtonOpen: TButton;
    ButtonFinish: TButton;
    BitBtnClose: TBitBtn;
    SpeedButtonResetCT: TSpeedButton;
    des: TDES;
    SpeedButtonUsage: TSpeedButton;
    SpeedButtonSetUp: TSpeedButton;
    SpeedButtonIssuer: TSpeedButton;
    SpeedButtonCTC: TSpeedButton;
    bnVerifyPin: TSpeedButton;
    SpeedButtonCustID: TSpeedButton;
    SpeedButtonAuto: TSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    unitscombo: TComboBox;
    Image1: TImage;
    SpeedButtonSerialno: TSpeedButton;
    Image2: TImage;
    procedure ButtonOpenClick(Sender: TObject);
    procedure ButtonFinishClick(Sender: TObject);
    procedure SpeedButtonResetCTClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButtonUsageClick(Sender: TObject);
    procedure SpeedButtonSetUpClick(Sender: TObject);
    procedure SpeedButtonIssuerClick(Sender: TObject);
    procedure SpeedButtonCTCClick(Sender: TObject);
    procedure bnVerifyPinClick(Sender: TObject);
    procedure SpeedButtonCustIDClick(Sender: TObject);
    procedure SpeedButtonAutoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SpeedButtonSerialnoClick(Sender: TObject);
  private
    { Private declarations }
    {DLL}
    rsp : array[1..256] of byte;
    cmd : array[1..256] of byte;
    sw1 : byte;
    sw2 : byte;
    tag : byte;
    mac : AnsiString;
    cmdlen     : word;
    testcount  : word;
    calibcount : word;
    ctc        : CTCArray;
    data       : ansistring;
    resp       : ansistring;
    cmdptr     : pansichar;
    rspptr     : pansichar;
    sad   : byte;
    dad   : byte;
    cla   : byte;
    ins   : byte;
    p1    : byte;
    p2    : byte;
    lc    : byte;
    le    : byte;
    Flr    : uint16;
    FEncryptedTotal  : AnsiString;
    FTotal           : AnsiString;

    blk1 : TBlock;
    blk2 : TBlock;
    key1 : AnsiString;
    key2 : AnsiString;
    si   : AnsiString;
    so   : AnsiString;

    CTInit  : TCTInit;
    FCTData : TCTData;
    CTClose : TCTClose;
    DLLHandle: THandle;
    DLLName: PChar;
    OSType:string;
    function CTData(Ctn: Word;
                    var Dad, Sad: Byte;
                    LC: UInt16;
                    Cmd: PAnsiChar;
                    var LR: UInt16;
                    Rsp: PAnsiChar): Smallint; stdcall;
    procedure SelectDLL;
    function BuildMacBlocks(tag:byte; ctc:ctcarray; hdr,si:ansistring;
                            var so:ansistring):integer;
    procedure ReadCTC;
    procedure ResetCard;
    procedure SetupCard;
    function  GetOSName:string;
    procedure Decrypt;
    procedure Encrypt;
    procedure DesForBlockN;
  public
  end;

var
  FormSmartSet: TFormSmartSet;

implementation

{$R *.DFM}

uses
  LbCipher, LbString;
var
  Key128         : TKey128;

procedure TFormSmartSet.ButtonOpenClick(Sender: TObject);
//*Open s/card session
var
  res:smallint;
begin
  res:=CTInit(0,0);
  if res=0 then
    showmessage('Session Opened')
  else
    showmessage('No card or reader');
end;

procedure TFormSmartSet.ButtonFinishClick(Sender: TObject);
//*Finish s/card session
var
  res:smallint;
begin
  res:=CTClose(0);
  if res=0 then
    ShowMessage('Session Closed');
end;

procedure TFormSmartSet.SpeedButtonResetCTClick(Sender: TObject);
//*Reset CT (Card Terminal)
begin
  ResetCard;
end;

procedure TFormSmartSet.ResetCard;
//*Reset s/card - called from reset CT
//*See GemPlus manual for data structures
var
  i   : word;
  res : smallint;
begin
  res := 0;
  dad := 1;
  sad := 2;
  cla := $20;
  ins := $10;
  p1  := 1;
  p2  := 1;
  lc  := 0;
  le  := 0;
  cmdlen := 4;
  data   := #0;
  cmd[1] := cla;
  cmd[2] := ins;
  cmd[3] := p1;
  cmd[4] := p2;
  cmd[5] := lc;
  for i:=1 to length(data) do
    cmd[5+i] := ord(data[i]);
  cmd[6+length(data)]:=le;
  Flr   := 15;
  resp := '';
  sw1  := 0;
  sw2  := 0;
  FillChar(rsp,sizeof(rsp),32);
  cmdptr := addr(cmd);
  rspptr := addr(rsp);
  try
   {send request to card reader}
   res:=CTData(0,dad,sad,cmdlen,cmdptr,Flr,rspptr);
  except
   showmessage('CT_Data error');
  end;
  if (res=0) and (Flr >= 2) then
  begin
    sw1 := ord(rsp[Flr-1]);
    sw2 := ord(rsp[Flr]);
    for i:=1 to Flr-2 do
      resp := resp + AnsiChar(rsp[i]);
    if (sw1=$90) and (sw2=1) then
      showmessage('Card OK')
    else
      showmessage('Card error')
  end
  else
    ShowMessage(inttohex(ord(res),2));
end;

procedure TFormSmartSet.FormCreate(Sender: TObject);
//*Select DLLs from OS, get encrypted pwd to access this program
//var pwd:string; tf:double;
begin
  OsType:=GetOSName;
  SelectDLL;
  (**************************************************
  if CheckReg then
  begin
    tf:=0;
    pwd:=InputBox('SmartSet 5', 'Please enter Access Code', '');
    try
      if pwd <> '' then tf:=strtofloat(pwd);
      //showmessage(inttostr(trunc(tf*7/sqr(3.14159))));
      if trunc(tf*7/sqr(3.14159)) <> 123085 then application.terminate;
      // pwd = 173543
    except
      application.terminate;
    end;
  end
  else
    application.terminate;
  ********************************************************)
end;

procedure TFormSmartSet.FormDestroy(Sender: TObject);
begin
  {RM.free;}
end;

function TFormSmartSet.BuildMacBlocks(tag:byte; ctc:ctcarray; hdr,si:ansistring;
                               var so:ansistring):integer;
//*Builds so data blk. See GemPlus s/card manual
var
  bc : Integer;
  i  : Integer;
  ts : AnsiString;

  Function pad(tag, n: byte) : AnsiString;
  const
    padding=#$80+#0+#0+#0+#0+#0+#0+#0;
  begin
    if n=0 then
      result:=ansichar(tag)+ copy(padding,1,7)
    else
      result:=copy(padding,1,n);
  end;

begin {of BuildMacBlocks}
  so := '';
  ts := si;
  bc := 0;
  so := AnsiChar(tag)+AnsiChar(ctc[1])+AnsiChar(ctc[2])+hdr;
  inc(bc);
  if length(ts) > 7 then
  begin
    for i:=1 to (length(si) div 7) do
    begin
      so := so+ansichar(tag)+copy(ts,1,7);
      delete(ts,1,7);
    end;
    so := so+ansichar(tag)+ts+pad(tag,7-length(ts));
    bc := bc+length(si) div 7 + 1;
  end
  else
  begin
    so:=so+ansichar(tag)+si+pad(tag,7-length(si));
    inc(bc);
    if length(si)=7 then
      inc(bc);
  end;
  result:=bc;
end;

function XorBlks(b1,b2:tblock):tblock;
//*XOR 2 arrays
var
  ts:tblock;
  i:integer;
begin
  for i:=0 to 7 do
    ts[i]:= b1[i] xor b2[i];
  result:=ts;
end;

function StrtoBlk(s:ansistring):tblock;
//*Converts string to chr array
var
  i:integer;
  inblk:tblock;
begin
  for i:=0 to 7 do
    inblk[i]:=ord(s[i+1]);
  result:=inblk;
end;

function BlktoStr(b:tblock):ansistring;
//*Converts chr array into string
var
  i : Integer;
  s : AnsiString;
begin
  s:='00000000';
  for i:=0 to 7 do
    s[i+1] := AnsiChar(b[i]);
  result:=s;
end;

procedure XorWith(var ds:ansistring;es:ansistring);
//*XORs 2 strings
var
  i : word;
begin
  for i:=1 to 8 do
    ds[i] := AnsiChar(ord(ds[i]) xor ord(es[i]));
end;

procedure TFormSmartSet.SpeedButtonSetUpClick(Sender: TObject);
//*Setup s/card ID and Steel total
begin
  SetupCARD;
end;

procedure TFormSmartSet.DesForBlockN;
var
  i : Integer;
begin
  if length(so) <> 8 then
    showmessage('Blk length error');
  blk2:=StrtoBlk(copy(so,1,8));
  blk1:=XorBlks(blk1,blk2);
  des.initialiseString(key1);
  des.EncBlock(blk1,blk2);
  blk1:=blk2;
  des.initialiseString(key2);
  des.DecBlock(blk1,blk2);
  blk1:=blk2;
  des.initialiseString(key1);
  des.EncBlock(blk1,blk2);
  blk1:=blk2;
  mac:=BlktoStr(blk1); {BuildCmd}
  cmd[1]:=cla;
  cmd[2]:=ins;
  cmd[3]:=p1;
  cmd[4]:=p2;
  cmd[5]:=lc;
  for i:=1 to length(si) do
    cmd[5+i]:=ord(si[i]);
  for i:=1 to length(mac) do
    cmd[length(si)+5+i]:=ord(mac[i]);
  cmd[6+length(data)+length(si)]:=le;
  Flr   := 100;
  resp := '';
  sw1  := 0;
  sw2  := 0;
  FillChar(rsp,sizeof(rsp),32);
  cmdptr := addr(cmd);
  rspptr := addr(rsp);
end;

procedure TFormSmartSet.SetUpCard;
//*Setup s/card ID and Steel total
const
  nulls=#0+#0+#0+#0+#0+#0+#0+#0#0+#0+#0+#0+#0+#0+#0+#0#0+#0+#0+#0+#0+#0+#0+#0;
  zeros= '000000000000000000000000';
  spaces='                        ';
var
  hdr  : AnsiString;
  bc   : Byte;
  i    : Integer;
  res  : SmallInt;
  us   : String;
  cs   : String;
  ds   : String;
  ts   : AnsiString;
  ts1  : AnsiString;
  SeedText : AnsiString;
begin
  tag    := $81;         {lc=8 or 24}
  dad    := 0;
  sad    := 2;           {p2=sfi 20:2 28:3}
  cla    := 4;
  ins    := $DC;
  ReadCTC;
  InputQuery('Card detail','Name (24 chrs max)',cs);
  try
    if UnitsCombo.text='Metres' then
    begin
      InputQuery('Usage','Metres (1000000 max.)',us);
    end
    else
    begin
      InputQuery('Usage','Feet (3280000 max.)',us);
      us:=IntToStr(round(strtofloat(us)*0.3048));
    end;
  except
     MessageDlg('Invalid data', mtwarning,[mbOk], 0);
     Exit;
  end;
  // Check for large amounts
  if StrToFloat(us) > 200000 then
  begin
    MessageDlg('You have entered an Invalid amount', mtwarning,[mbOk], 0);
    Exit;
  end;
  if StrToFloat(us) > 25000 then
  begin
    ts1:= InputBox('Large amount', 'Pls re-enter', '');
    if StrToFloat(ts1) <> StrToFloat(us) then
    begin
      MessageDlg('They do not agree', mtwarning,[mbAbort], 0);
      exit;
    end;
  end;
  // =================== update usage record ===================
  FTotal:=Copy(Spaces{zeros},1,12-Length(us))+us;
  Encrypt; {total -> encryptedtotal}
  us     := FEncryptedtotal;
  data   := us;
  p1     := 1;
  p2     := 20;
  lc     := $20;
  le     := $20;
  cmdlen := 37;
  if ctc[2] < 255 then
    inc(ctc[2])
  else
  begin
    inc(ctc[1]);
    ctc[2]:=0;
  end;
  mac :=''; {build mac blocks from fields}
  // generate keys PanelCard 5
  ts  := FloatToStr(sqrt(sin(ln(pi))));
  SeedText := FloatToStr(pi*pi*pi); // change seed and equation for panel & truss.
  GenerateLMDKey(Key128, SizeOf(Key128), SeedText);
  ts1  := TripleDESEncryptStringEx(ts, Key128, True);
  key1 := copy(ts1,1,8);
  key2 := copy(ts1,9,8);
  //===========================================================
  //key1:=#161+#172+#242+#75+#221+#216+#63+#2;   // Panelcard3
  //key2:=#177+#219+#243+#65+#232+#231+#250+#16;
  //===========================================================
  hdr := chr(cla)+chr(ins)+chr(p1)+chr(p2)+chr(lc);
  si  := data;
  bc  := BuildMacBlocks(tag,ctc,hdr,si,so);
  blk1:=StrtoBlk(nulls);
  for i:=1 to bc-1 do  {des for blks 1 .. n-1}
  begin
    blk2:=StrtoBlk(copy(so,1,8));
    blk1:=XorBlks(blk1,blk2);
    delete(so,1,8);
    des.initialiseString(key1);
    des.EncBlock(blk1,blk2);
    blk1:=blk2;
  end;

  DesForBlockN;
  {send request to card reader}
  res:=CTData(0,dad,sad,cmdlen,cmdptr,Flr,rspptr);
  if res=0 then
  begin
    sw1:=ord(rsp[Flr-1]);
    sw2:=ord(rsp[Flr]);
  end;
  if not ((sw1=$61) and (sw2=10)) then
    showmessage('Usage update failed');
  // =================== update customer id record ===================
  data   := cs+copy('                      ',1,24-length(cs));
  p1     := 1;
  p2     := 28;
  lc     := $20;
  le     := $20;
  cmdlen := 37;
  if ctc[2] < 255 then
    inc(ctc[2])
  else
  begin
    inc(ctc[1]);
    ctc[2]:=0;
  end;
  mac:=''; {build mac blocks from fields}
  //key1:=#61+#111+#31+#234+#50+#14+#243+#40;
  //key2:=#152+#183+#63+#201+#4+#93+#115+#77;
  hdr := chr(cla)+chr(ins)+chr(p1)+chr(p2)+chr(lc);
  si  := data;
  bc  := BuildMacBlocks(tag,ctc,hdr,si,so);
  blk1:= StrtoBlk(nulls);
  for i:=1 to bc-1 do  {des for blks 1 .. n-1}
  begin
    blk2:=StrtoBlk(copy(so,1,8));
    blk1:=XorBlks(blk1,blk2);
    delete(so,1,8);
    des.initialiseString(key1);
    des.EncBlock(blk1,blk2);
    blk1:=blk2;
  end;
  {3des for blk n}
  DesForBlockN;
  {send request to card reader}
  res := CTData(0,dad,sad,cmdlen,cmdptr,Flr,rspptr);
  if res=0 then
  begin
    sw1:=ord(rsp[Flr-1]);
    sw2:=ord(rsp[Flr]);
  end;
  if not ((sw1=$61) and (sw2=10)) then
    showmessage('Customer update failed');
  key1:='';
  key2:='';
  // ========== update controller serial no. record =============
  data := ds+copy('                      ',1,16-length(ds));
  p1     := 1;
  p2     := 36;
  lc     := 24; {20h}
  le     := $20;
  cmdlen := 29;
  if ctc[2] < 255 then
    inc(ctc[2])
  else
  begin
    inc(ctc[1]);
    ctc[2] :=0;
  end;
  mac:=''; {build mac blocks from fields}
  //key1:=#61+#111+#31+#234+#50+#14+#243+#40;
  //key2:=#152+#183+#63+#201+#4+#93+#115+#77;
  hdr:=chr(cla)+chr(ins)+chr(p1)+chr(p2)+chr(lc);
  si := data;
  bc := BuildMacBlocks(tag,ctc,hdr,si,so);
  blk1:=StrToBlk(nulls);
  for i:=1 to bc-1 do  {des for blks 1 .. n-1}
  begin
    blk2:=StrToBlk(copy(so,1,8));
    blk1:=XorBlks(blk1,blk2);
    delete(so,1,8);
    des.initialiseString(key1);
    des.EncBlock(blk1,blk2);
    blk1:=blk2;
  end;
  {3des for blk n}
  DesForBlockN;
  {send request to card reader}
  res:=CTData(0,dad,sad,cmdlen,cmdptr,Flr,rspptr);
  if res=0 then
  begin
    sw1:=ord(rsp[Flr-1]);
    sw2:=ord(rsp[Flr]);
  end;
  if not ((sw1=$61) and (sw2=10)) then
    showmessage('Serial no. update failed');
  key1:='';
  key2:='';
end;

procedure TFormSmartSet.SpeedButtonIssuerClick(Sender: TObject);
//*Returns the s/card issuer ID. Fixed for our cards
var
  i   : Word;
  res : SmallInt;
begin
  dad := 0;
  sad := 2;
  cla := $80;
  ins := $BE;
  p1  := 0;
  p2  := 0;
  lc  := $1C;
  le  := $1C;
  cmdlen :=5;
  data:= #0;
  cmd[1]:=cla;
  cmd[2]:=ins;
  cmd[3]:=p1;
  cmd[4]:=p2;
  cmd[5]:=lc;
  for i:=1 to length(data) do
    cmd[5+i]:=ord(data[i]);
  cmd[6+length(data)]:=le;
  Flr:=30;
  resp:='';
  sw1:=0;
  sw2:=0;
  FillChar(rsp,sizeof(rsp),32);
  cmdptr:=addr(cmd);
  rspptr:=addr(rsp);
  {send request to card reader}
  res:=CTData(0,dad,sad,cmdlen,cmdptr,Flr,rspptr);
  if res=0 then
  begin
    if Flr >= 13 then
    begin
      sw1:=ord(rsp[Flr-1]);
      sw2:=ord(rsp[Flr]);
      for i:= Flr-5 to Flr-2 do
        resp:=resp+inttohex(ord(rsp[i]),2);
      if (sw1=$90) and (sw2=0) then
        showmessage(resp);
    end
  end
  else
    showmessage(IntToHex(Res,4));
end;

procedure TFormSmartSet.SpeedButtonCTCClick(Sender: TObject);
//*Reads the s/card CTC counter (Cyclic Transaction Counter)
begin
  ReadCTC;
  ShowMessage(inttostr(ctc[2]));
end;

procedure TFormSmartSet.ReadCTC;
//*Reads the CTC
const
  zeros=#0+#0+#0+#0+#0+#0+#0+#0;
var
  res: smallint;
  i  : smallint;
begin  {read ctc}
  dad := 0;
  sad := 2;
  cla := $80;
  ins := $BE;
  p1  := $27;
  p2  := 1;
  lc  := 8;
  le  := 0;
  cmdlen:=13;
  data:=zeros;
  cmd[1]:=cla;
  cmd[2]:=ins;
  cmd[3]:=p1;
  cmd[4]:=p2;
  cmd[5]:=lc;
  for i:=1 to length(data) do
    cmd[5+i]:=ord(data[i]);
  cmd[6+length(data)]:=le;
  Flr:=30;
  resp:='';
  sw1:=0;
  sw2:=0;
  FillChar(rsp,sizeof(rsp),32);
  cmdptr:=addr(cmd);
  rspptr:=addr(rsp);
  res:=CTData(0,dad,sad,cmdlen,cmdptr,Flr,rspptr);
  if res=0 then
  begin
    sw1:=ord(rsp[Flr-1]);
    sw2:=ord(rsp[Flr]);
  end;
  if sw1=$61 then
  begin
    dad:=0;
    sad:=2;
    cla:=0;
    ins:=$C0;
    p1:=0;
    p2:=0;
    lc:=sw2;
    le:=sw2;
    cmdlen:=5;
    cmd[1]:=cla;
    cmd[2]:=ins;
    cmd[3]:=p1;
    cmd[4]:=p2;
    cmd[5]:=lc;
    for i:=1 to length(data) do
      cmd[5+i]:=ord(data[i]);
    cmd[6+length(data)]:=le;
    Flr:=50;
    resp:='';
    sw1:=0;
    sw2:=0;
    FillChar(rsp,sizeof(rsp),32);
    cmdptr:=addr(cmd);
    rspptr:=addr(rsp);
    {send request to card reader}
    res:=CTData(0,dad,sad,cmdlen,cmdptr,Flr,rspptr);
    if res=0 then
    begin
      sw1:=ord(rsp[Flr-1]);
      sw2:=ord(rsp[Flr]);
    end;
    if (sw1=$90) and (sw2=0) then
    begin
      ctc[1]:=ord(rsp[1]); ctc[2]:=ord(rsp[2]);
    end;
  end;
end;

procedure TFormSmartSet.SpeedButtonUsageClick(Sender: TObject);
//*read the cards steel total
var
  i   : word;
  res : smallint;
begin                    {lc=8 or 24}
  dad:=0;
  sad:=2;          {p2=sfi 20:2 28:3}
  cla:=0;
  ins:=$B2;
  p1:=1;
  p2:=20;
  lc:=24;
  le:=0;
  cmdlen:=5;
  data:=#0;
  cmd[1]:=cla;
  cmd[2]:=ins;
  cmd[3]:=p1;
  cmd[4]:=p2;
  cmd[5]:=lc;
  for i:=1 to length(data) do
    cmd[5+i]:=ord(data[i]);
  cmd[6+length(data)]:=le;
  Flr:=35;
  resp:='';
  sw1:=0;
  sw2:=0;
  FillChar(rsp,length(rsp),32);
  cmdptr:=addr(cmd);
  rspptr:=addr(rsp);
  {send request to card reader}
  res:=CTData(0,dad,sad,cmdlen,cmdptr,Flr,rspptr);
  if res=0 then
  begin
    if Flr >= 2 then
    begin
      sw1:=ord(rsp[Flr-1]);
      sw2:=ord(rsp[Flr]);
      for i:=1 to Flr-2 do
        resp:=resp+ansichar(rsp[i]);
      if (sw1=$90) and (sw2=0) then
      begin
        Fencryptedtotal:=resp;
        Decrypt; {encryptedtotal -> total}
        showmessage(Ftotal)
      end;
    end
  end
end;

procedure TFormSmartSet.SpeedButtonCustIDClick(Sender: TObject);
//*Reads the s/card ID record
var
  i:word;
  res:smallint;
begin                    {lc=8 or 24}
  dad:=0;
  sad:=2;          {p2=sfi 20:2 28:3}
  cla:=0;
  ins:=$B2;
  p1:=1;
  p2:=28;
  lc:=24;
  le:=0;
  cmdlen:=5;
  data:=#0;
  cmd[1]:=cla;
  cmd[2]:=ins;
  cmd[3]:=p1;
  cmd[4]:=p2;
  cmd[5]:=lc;
  for i:=1 to length(data) do
    cmd[5+i]:=ord(data[i]);
  cmd[6+length(data)]:=le;
  Flr:=35;
  resp:='';
  sw1:=0;
  sw2:=0;
  fillchar(rsp,sizeof(rsp),32);
  cmdptr:=addr(cmd);
  rspptr:=addr(rsp);
  {send request to card reader}
  res:=CTData(0,dad,sad,cmdlen,cmdptr,Flr,rspptr);
  if res=0 then
  begin
    if Flr >= 2 then
    begin
      sw1:=ord(rsp[Flr-1]);
      sw2:=ord(rsp[Flr]);
      for i:=1 to Flr-2 do
        resp:=resp+ansichar(rsp[i]);
      if (sw1=$90) and (sw2=0) then
        showmessage(resp);
    end
  end
end;

procedure TFormSmartSet.bnVerifyPinClick(Sender: TObject);
//*Reads and verifys the s/card PIN code in the secret file
var
  res :smallint;
  i   :smallint;
begin  {verify pin}
  dad := 0;
  sad := 2;
  cla := $0;
  ins := $20;
  p1  := 0;
  p2  := 0;
  lc  := 8;
  le  := 0;
  cmdlen:=13;

  //data:=#$7A+#$55+#$FF+#$C5+#$02+#$D7+#$27+#$82; // TrussCard v 5
  //data:=#198+#207+#160+#106+#135+#20+#188+#212;  // TrussCard v 3 and 4
  data:=#$AC+#$E3+#$1B+#$A5+#$C2+#$D7+#$20+#$52; // PanelCard v 5
  //data:=#$1C+#$13+#$7B+#05+#$22+#$B7+#$B0+#$D2; // PanelCard v 3 and 4

  cmd[1] := cla;
  cmd[2] := ins;
  cmd[3] := p1;
  cmd[4] := p2;
  cmd[5] := lc;
  for i:=1 to length(data) do
    cmd[5+i] := ord(data[i]);
  cmd[6+length(data)] := le;
  Flr:=10;
  resp:='';
  sw1:=0;
  sw2:=0;
  FillChar(rsp,sizeof(rsp),32);
  cmdptr:=addr(cmd);
  rspptr:=addr(rsp);
  {send request to card reader}
  res:=CTData(0,dad,sad,cmdlen,cmdptr,Flr,rspptr);
  if res=0 then
  begin
    if Flr >= 2 then
    begin
      sw1:=ord(rsp[Flr-1]); sw2:=ord(rsp[Flr]);
      if (sw1=$90) and (sw2=0) then
        showmessage('Verify OK')
      else
        showmessage(inttohex(sw1,2)+' '+inttohex(sw2,2));
    end
  end
  else
    showmessage(inttohex(res,4));
end;

procedure TFormSmartSet.SpeedButtonAutoClick(Sender: TObject);
//*Auto card setup - ie does everything & asks for ID and total
var
  res:smallint;
begin  {auto card setup}
  res:=CTInit(0,0);
  if res<>0 then
  begin
    showmessage('Session Open failed');
    exit;
  end;
  ResetCard;
  SetupCard;
  res:=CTClose(0);
  if res<>0 then
  begin
    showmessage('Session Close failed');
    system.exit;
  end;
    showmessage('Setup completed.');
end;

procedure TFormSmartSet.SelectDLL;
//*Select DLL based on OS version
begin
  if OsType='Win32' then
    DLLName := 'Ctpcsc.dll'
  else
    DLLName := 'Ctscrw95.dll';
  DLLHandle := LoadLibrary( DLLName );
  try
    if DLLHandle > 0 then
    begin
      @CTInit := GetProcAddress( DLLHandle, 'CT_init');
      @CTClose := GetProcAddress( DLLHandle, 'CT_close');
      @FCTData := GetProcAddress( DLLHandle, 'CT_data');
    end
    else
    begin
      MessageDlg('Error: '+DLLName+' not found', mtInformation,[mbOk], 0);
      application.terminate
    end;
  finally
  end;
end;

procedure TFormSmartSet.FormClose(Sender: TObject; var Action: TCloseAction);
//*Close form, free dll memory, write cardset.ini units
var
  inifile : tinifile;
begin
  if DLLHandle > 0 then
    FreeLibrary( DLLHandle );
  inifile:=tinifile.create(extractfilepath(paramstr(0))+'Cardset.ini');
  with inifile do
  begin
    writestring('general','units',unitscombo.text);
  end;
  inifile.free;
end;

function TFormSmartSet.GetOSName:string;
//*Returns OS name
var
  OsInfo : TOSVERSIONINFO;
begin
  OsInfo.dwOSVersionInfoSize := sizeof(TOSVERSIONINFO);
  GetVersionEx(OsInfo);
  case OsInfo.dwPlatformId of
  VER_PLATFORM_WIN32s        : result:='Win16'; {Windows 3.1}
  VER_PLATFORM_WIN32_WINDOWS : result:='Win16'; {Windows 95}
  VER_PLATFORM_WIN32_NT :
    begin
      Case OsInfo.dwMajorVersion of
        5 : result:='Win32'; {Windows 2000(minor=0), XP(minor=1)}
      else
         result := 'Win32' {Windows NT}
      end;
    end;
  end;
end;


procedure TFormSmartSet.FormShow(Sender: TObject);
//*Performs this when main form is displayed
var
  inifile : tinifile;
begin
  inifile:=tinifile.create(extractfilepath(paramstr(0))+'Cardset.ini');
  with inifile do
  begin
    unitscombo.text:=readstring('general','units','Metres');
  end;
  inifile.Free;
end;

procedure TFormSmartSet.SpeedButtonSerialnoClick(Sender: TObject);
//*Reads card serial number record (RF ?) if present
var
  i   : word;
  res : smallint;
begin              {lc=8 or 24}
  dad:=0;
  sad:=2;          {p2=sfi 20:2 28:3 36:4}
  cla:=0;
  ins:=$B2;
  p1:=1;
  p2:=36;
  lc:=24;
  le:=0;
  cmdlen:=5;
  data:=#0;
  cmd[1]:=cla;
  cmd[2]:=ins;
  cmd[3]:=p1;
  cmd[4]:=p2;
  cmd[5]:=lc;
  for i:=1 to length(data) do
    cmd[5+i]:=ord(data[i]);
  cmd[6+length(data)]:=le;
  Flr:=35;
  resp:='';
  sw1:=0;
  sw2:=0;
  FillChar(rsp,sizeof(rsp),32);
  cmdptr:=addr(cmd);
  rspptr:=addr(rsp);
  {send request to card reader}
  res:=CTData(0,dad,sad,cmdlen,cmdptr,Flr,rspptr);
  if res=0 then
  begin
    if Flr >= 2 then
    begin
      sw1:=ord(rsp[Flr-1]);
      sw2:=ord(rsp[Flr]);
      for i:=1 to Flr-2 do
        resp:=resp+ansichar(rsp[i]);
      if (sw1=$90) and (sw2=0) then
        showmessage(resp)
      else
        showmessage(IntTohex(sw1,2) + ' ' +intToHex(sw2,2))
    end
  end
  else
    showmessage('Serial number not found');
end;

procedure TFormSmartSet.Decrypt;
//*Decrypts total
var
  ts:AnsiString;
  seedtext:AnsiString;
  Key128:TKey128;
begin
  seedtext:=string(floattostr(exp(pi)));
  GenerateLMDKey(Key128, SizeOf(Key128), seedText);
  ts := TripleDESEncryptStringEx(FEncryptedTotal, Key128, false); // decrypt
  FTotal:=ts;
end;

procedure TFormSmartSet.Encrypt;
//* Encrypts steel total
var
  ts       : AnsiString;
  seedtext : AnsiString;
  Key128   : TKey128;
begin
  ts:=Ftotal;
  seedtext:=string(floattostr(exp(pi)));
  GenerateLMDKey(Key128, SizeOf(Key128), seedText);
  FEncryptedTotal := TripleDESEncryptStringEx(ts, Key128, true); // encrypt
end;

Function TFormSmartSet.CTData(Ctn: Word;
                              var Dad, Sad: Byte;
                              LC: UInt16;
                              Cmd: PAnsiChar;
                              var LR: UInt16;
                              Rsp: PAnsiChar): Smallint;
begin
  Result := FCtData(Ctn, Dad, Sad, LC, Cmd, LR, Rsp);
end;

END.
