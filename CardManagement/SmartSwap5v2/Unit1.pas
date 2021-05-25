unit Unit1;
//{$DEFINE Smart2000}
{
Main unit of SmartSwap
Author-Pete
1.0 - first release
1.1 - fixed -1 recharge problem
1.2 - Both Win16 & Win32 supported
1.3 - Reg codes
4.0 - s.card version 4.0
4.1 - Changed DLL code to auto select
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Des, jpeg, Mask, inifiles ;

type
  TCTInit =  function (Ctn,Pn:word):Smallint; stdcall;
  TCTClose = function (Ctn:word):smallint; stdcall;
  TCTData =  function (Ctn:word; var Dad,Sad:byte; Lc:byte;
                       Cmd:pansichar; var Lr:byte; Rsp:pansichar):smallint; stdcall;
  ctcarray=array[1..2] of byte;

  TForm1 = class(TForm)
    BtnCardRead: TBitBtn;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Bevel2: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    BtnTransfer: TBitBtn;
    Image1: TImage;
    DES: TDES;
    BtnRemove: TBitBtn;
    Label8: TLabel;
    Edit6: TEdit;
    Label9: TLabel;
    Edit7: TEdit;
    Edit1: TEdit;
    Edit3: TEdit;
    unitscombo: TComboBox;
    Image2: TImage;
    procedure BtnCardReadClick(Sender: TObject);
    procedure BtnTransferClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnRemoveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    {DLL}
    CTInit:TCTInit;
    CTData:TCTData;
    CTClose:TCTClose;
    DLLHandle: THandle;
    DLLName: PChar;
    hinst:thandle;
    rsp,cmd:array[1..256] of byte;
    sw1,sw2,tag:byte;
    mac:ansistring; cmdlen:word;
    ctc:ctcarray;
    data,resp:ansistring;
    cmdptr,rspptr:pansichar;
    sad,dad,cla,ins,p1,p2,lc,le,lr:byte;
    OSType:string;
    sourceread,removed,transferred:boolean;
    sourceorg,sourceupdate,amttransferred,destorg,destupdate:integer;
    total,encryptedtotal:ansistring;

    function  BuildMacBlocks(tag:byte; ctc:ctcarray; hdr,si:ansistring; var so:ansistring):integer;
    function  CardOk:boolean;
    function  UpdateCardData(us:string):boolean;
    function  XorBlks(b1,b2:tblock):tblock;
    function  StrtoBlk(s:ansistring):tblock;
    function  BlktoStr(b:tblock):ansistring;
    function  Pad(tag,n:byte):ansistring;
    function  GetOSName:string;
    procedure SelectDLL;
    procedure Decrypt;
    procedure Encrypt;

  public
    procedure ReadCTC;
    function VerifyPin:boolean;
    function ReadCardID:boolean;
    function ReadCardData:boolean;
    procedure ClearEdits;
    procedure ClearAmts;
    procedure Xorwith(var ds:ansistring;es:ansistring);
    procedure ShowDS(ds:string);
  end;

var
  Form1: TForm1;

implementation
{$R *.DFM}
{$R swap.res}

uses
  LbCipher, LbString;
var
  Key128         : TKey128;


type str100=string[100];



procedure Xorwith(var ds:ansistring;es:ansistring);
//*XORs 2 strings. Returns result as ds
var i:word;
begin
for i:=1 to 8 do ds[i]:=ansichar(ord(ds[i]) xor ord(es[i]));
end;

procedure TForm1.BtnCardReadClick(Sender: TObject);
//*Reads the source cards details
//*Chks that the program has no outstanding amounts not transfered to a card before reading another
begin {read source card details}
unitscombo.Enabled:=true;
{procedure check}
if removed and not transferred then
   begin  messagebeep(0); showmessage('ERROR - Removed amount not transferred'); system.exit; end;
ClearEdits; ClearAmts;
edit3.readonly:=false;
{Load button pics}
BtnCardRead.glyph.LoadFromResourceName(hInstance,'blank');
BtnRemove.glyph.LoadFromResourceName(hInstance,'blank');
BtnTransfer.glyph.LoadFromResourceName(hInstance,'blank');
sourceread:=false; removed:=false; transferred:=false;
CTClose(0);
{Check that card is present in reader}
If not CardOK then system.exit;
{Verify secret file for correct PIN}
If not verifypin then system.exit;
{Read ID from card}
if ReadCardID then edit1.text:=unicodestring(resp) else system.exit;
{Read total & display = always stored as metres}
if ReadCardData then
   begin
   //if pos('-',resp) > 0 then resp:='0'; {negative values are zero}
   if unitscombo.text='Metres' then
      edit2.text:=inttostr(strtoint(unicodestring(total)))
     else
      edit2.text:=inttostr(round(strtoint(total)/0.3048))
    end
  else
   begin
   showmessage('ERROR - Invalid card data');
   system.exit;
   end;
sourceorg:=strtoint(edit2.text);
if unitscombo.text='Metres' then
   sourceorg:=strtoint(edit2.text)
  else
   sourceorg:=round(strtofloat(edit2.text)*0.3048);
{Amount must be >= 1}
if sourceorg < 1 then
   begin messagebeep(0); showmessage('ERROR - Invalid amount remaining'); system.exit; end;
BtncardRead.glyph.LoadFromResourceName(hInstance,'tick');
sourceread:=true;
unitscombo.Enabled:=false;
end;

procedure TForm1.BtnRemoveClick(Sender: TObject);
//*remove xfr amount from source card
//*Checks that correct procedure is followed
begin
ReadCTC;
//showmessage('SourceRead '+booltostr(sourceread)+' Transferred '+booltostr(transferred));
if (not sourceread) or transferred then
   begin messagebeep(0); showmessage('ERROR - Need to read source card'); system.exit; end;
if removed then
   begin messagebeep(0); showmessage('ERROR - Removed amount not transferred'); system.exit; end;
try
   if unitscombo.text='Metres' then
      AmtTransferred:=strtoint(edit3.text)
     else
      AmtTransferred:=round(strtoint(edit3.text)*0.3048);
except
  on EConvertError do
     begin messagebeep(0); showmessage('ERROR - Invalid amount'); system.exit; end;
end;
if AmtTransferred > sourceorg then
   begin messagebeep(0); showmessage('ERROR - Invalid amount'); system.exit; end;
if (amtTransferred <= 0) then
   begin messagebeep(0); showmessage('ERROR - No amount transferred'); system.exit; end;
{calc new card total}
Sourceupdate:=sourceorg-AmtTransferred;

{Update source card - users must not exit program here, or will loose xfr amt}
//showmessage(inttostr(SourceUpdate));
if UpdateCarddata(inttostr(SourceUpdate)) then
   begin
   BtnRemove.glyph.LoadFromResourceName(hInstance,'tick');
   if unitscombo.text='Metres' then
      edit7.text:=inttostr(SourceUpdate)
     else
      edit7.text:=inttostr(round(SourceUpdate/0.3048));
   removed:=true; edit3.readonly:=true;
   end
  else
   begin messagebeep(0); showmessage('ERROR - Amount not removed'); system.exit; end;
end;


procedure TForm1.BtnTransferClick(Sender: TObject);
//*Transfer to destination s/card
begin
{Must follow procedure}
if not removed then begin messagebeep(0); showmessage('ERROR - Amount not removed from source'); system.exit; end;
if transferred or (not sourceread) then
   begin messagebeep(0); showmessage('ERROR - Need to read source card'); system.exit; end;
{Only 1 reader. So swap cards now}
showmessage('Remove Source and insert destination card');
CTClose(0);
{Check destination card}
If not CardOK then system.exit;
If not verifypin then system.exit;
if ReadCardID then edit4.text:=resp else system.exit;
if ReadCardData then
   begin
   if pos('-',resp) > 0 then resp:='0'; {negative values are zero}
   if unitscombo.text='Metres' then
      edit5.text:=inttostr(strtoint(total))
     else
      edit5.text:=inttostr(round(strtoint(total)/0.3048));
   end
  else system.exit;
if unitscombo.text='Metres' then
   destorg:=strtoint(edit5.text)
  else
   destorg:=round(strtoint(edit5.Text)*0.3048);
destupdate:=destorg+amtTransferred;
{Calc new destination total, and update the card}
if UpdateCardData(inttostr(destupdate)) then
   begin
   if unitscombo.text='Metres' then
      edit6.text:=inttostr(destupdate)
     else
      edit6.text:=inttostr(round(destupdate/0.3048));
   transferred:=true;
   BtnTransfer.glyph.LoadFromResourceName(hInstance,'tick');
   ClearAmts;
   end
  else
   begin messagebeep(0); showmessage('ERROR - Invalid Destination card'); system.exit; end;
end;

//*
//* Generic s/card routines - see Smartset4 for comments}
//*

procedure TForm1.ReadCTC;
//*Reads the CTC
const zeros=#0+#0+#0+#0+#0+#0+#0+#0;
var res,i:smallint;
begin  {read ctc}
dad:=0; sad:=2;
cla:=$80; ins:=$BE; p1:=$27; p2:=1; lc:=8; le:=0; cmdlen:=13;
data:=zeros;

cmd[1]:=cla;cmd[2]:=ins; cmd[3]:=p1;
cmd[4]:=p2; cmd[5]:=lc;
for i:=1 to length(data) do cmd[5+i]:=ord(data[i]);
cmd[6+length(data)]:=le;
lr:=30; resp:=''; sw1:=0; sw2:=0;
fillchar(rsp,sizeof(rsp),32);
cmdptr:=addr(cmd); rspptr:=addr(rsp);
res:=CTData(0,dad,sad,cmdlen,cmdptr,lr,rspptr);
if res=0 then
   begin sw1:=ord(rsp[lr-1]); sw2:=ord(rsp[lr]); end;
if sw1=$61 then
   begin
   dad:=0; sad:=2;
   cla:=0; ins:=$C0; p1:=0; p2:=0; lc:=sw2; le:=sw2; cmdlen:=5;
   cmd[1]:=cla;cmd[2]:=ins; cmd[3]:=p1;
   cmd[4]:=p2; cmd[5]:=lc;
   for i:=1 to length(data) do cmd[5+i]:=ord(data[i]);
   cmd[6+length(data)]:=le;
   lr:=50; resp:=''; sw1:=0; sw2:=0;
   fillchar(rsp,sizeof(rsp),32);
   cmdptr:=addr(cmd); rspptr:=addr(rsp);
   {send request to card reader}
   res:=CTData(0,dad,sad,cmdlen,cmdptr,lr,rspptr);
   if res=0 then
      begin sw1:=ord(rsp[lr-1]); sw2:=ord(rsp[lr]); end;
   if (sw1=$90) and (sw2=0) then
      begin
      ctc[1]:=ord(rsp[1]); ctc[2]:=ord(rsp[2]);
      end;
   end;
end;


function TForm1.VerifyPin:boolean;
var res,i:smallint;
begin
result:=false;
dad:=0; sad:=2;
cla:=$0; ins:=$20; p1:=0; p2:=0; lc:=8; le:=0; cmdlen:=13;

//data:=#$7A+#$55+#$FF+#$C5+#$02+#$D7+#$27+#$82; // TrussCard v 5
//data:=#198+#207+#160+#106+#135+#20+#188+#212;  // TrussCard v 3 and 4
data:=#$AC+#$E3+#$1B+#$A5+#$C2+#$D7+#$20+#$52; // PanelCard v 5
//data:=#$1C+#$13+#$7B+#05+#$22+#$B7+#$B0+#$D2; // PanelCard v 3 and 4

//Xorwith(data,'06Q!-&a.');

cmd[1]:=cla;cmd[2]:=ins; cmd[3]:=p1;
cmd[4]:=p2; cmd[5]:=lc;
for i:=1 to length(data) do cmd[5+i]:=ord(data[i]);
cmd[6+length(data)]:=le;
lr:=10; resp:=''; sw1:=0; sw2:=0;
fillchar(rsp,sizeof(rsp),32);
cmdptr:=addr(cmd); rspptr:=addr(rsp);

res:=CTData(0,dad,sad,cmdlen,cmdptr,lr,rspptr);
if res=0 then
    begin
    if lr >= 2 then
       begin
       sw1:=ord(rsp[lr-1]); sw2:=ord(rsp[lr]);
       if (sw1=$90) and (sw2=0) then result:=true else
          begin
          result:=false; messagebeep(0); showmessage('ERROR - Invalid card'); system.exit; end;
       end
    end;
data:='53376401'; {hide data}
end;

function TForm1.ReadCardID:boolean;
var i:word; res:smallint;

begin                    {lc=8 or 24}
result:=false;
dad:=0; sad:=2;          {p2=sfi 20:2 28:3}
cla:=0; ins:=$B2; p1:=1; p2:=28; lc:=24; le:=0; cmdlen:=5;
data:=#0;

cmd[1]:=cla;cmd[2]:=ins; cmd[3]:=p1;
cmd[4]:=p2; cmd[5]:=lc;
for i:=1 to length(data) do cmd[5+i]:=ord(data[i]);
cmd[6+length(data)]:=le;
lr:=35; resp:=''; sw1:=0; sw2:=0;
fillchar(rsp,sizeof(rsp),32);
cmdptr:=addr(cmd); rspptr:=addr(rsp);

res:=CTData(0,dad,sad,cmdlen,cmdptr,lr,rspptr);
if res=0 then
    begin
    if lr >= 2 then
       begin
       sw1:=ord(rsp[lr-1]); sw2:=ord(rsp[lr]);
       for i:=1 to lr-2 do resp:=resp+ansichar(ord(rsp[i]));
       if (sw1=$90) and (sw2=0) then
          begin
          result:=true;
          end;
       end
    end;
end;

function TForm1.ReadCardData:boolean;
var i:word; res:smallint;
begin                    {lc=8 or 24}
result:=false;
dad:=0; sad:=2;          {p2=sfi 20:2 28:3}
cla:=0; ins:=$B2; p1:=1; p2:=20; lc:=24; le:=0; cmdlen:=5;
data:=#0;
//dad:=0; sad:=2;          {p2=sfi 20:2 28:3}
//cla:=0; ins:=$B2; p1:=1; p2:=20; lc:=8; le:=0; cmdlen:=5;
//data:=#0;
cmd[1]:=cla;cmd[2]:=ins; cmd[3]:=p1;
cmd[4]:=p2; cmd[5]:=lc;
for i:=1 to length(data) do cmd[5+i]:=ord(data[i]);
cmd[6+length(data)]:=le;
lr:=35; resp:=''; sw1:=0; sw2:=0;
fillchar(rsp,length(rsp),32);
cmdptr:=addr(cmd); rspptr:=addr(rsp);

res:=CTData(0,dad,sad,cmdlen,cmdptr,lr,rspptr);
if res=0 then
    begin
    if lr >= 2 then
       begin
       sw1:=ord(rsp[lr-1]); sw2:=ord(rsp[lr]);
       for i:=1 to lr-2 do resp:=resp+ansichar(rsp[i]);
       if (sw1=$90) and (sw2=0) then
          begin
          result:=true;
          encryptedtotal:=resp;
          Decrypt; {encryptedtotal -> total}
          end;
       end
    end;
end;

function TForm1.UpdateCardData(us:string):boolean;
const nulls=#0+#0+#0+#0+#0+#0+#0+#0;
      zeros= '00000000';
      spaces='        ';
var key1,key2,hdr,si,so,ts,ts1,seedtext:ansistring;
    bc:byte; i:integer;
    blk1,blk2:tblock; res:smallint;

begin
result:=false;
ReadCTC;

total:=copy(spaces{zeros},1,12-length(us))+us;
Encrypt; {total -> encryptedtotal}
us:=encryptedtotal;
data:=us;
//data:=copy(zeros,1,8-length(us))+us;
//xorwith(data,'P#8!s0+?'); // encrypt cardtotal
tag:=$81;                    {lc=8 or 24}
dad:=0; sad:=2;              {p2=sfi 20:2 28:3}
cla:=4; ins:=$DC; p1:=1; p2:=20; lc:=$20; le:=$20; cmdlen:=37;
//tag:=$81;                    {lc=8 or 24}
//dad:=0; sad:=2;              {p2=sfi 20:2 28:3}
//cla:=4; ins:=$DC; p1:=1; p2:=20; lc:=$10; le:=$20; cmdlen:=21;

if ctc[2] < 255 then inc(ctc[2]) else
  begin inc(ctc[1]); ctc[2]:=0; end;
mac:=''; {build mac blocks from fields}

// generate keys PanelCard 5
ts:=floattostr(sqrt(sin(ln(pi))));
seedtext:=floattostr(pi*pi*pi); // change seed and equation for panel & truss.
GenerateLMDKey(Key128, SizeOf(Key128), seedText);
ts1 := TripleDESEncryptStringEx(ts, Key128, True);
key1:=copy(ts1,1,8);
key2:=copy(ts1,9,8);

hdr:=chr(cla)+chr(ins)+chr(p1)+chr(p2)+chr(lc);
si:=data;
bc:=BuildMacBlocks(tag,ctc,hdr,si,so);
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
{3des for blk n}
if length(so) <> 8 then showmessage('ERROR - Card data fault');
blk2:=StrtoBlk(copy(so,1,8));
blk1:=XorBlks(blk1,blk2);
des.initialiseString(key1);
des.EncBlock(blk1,blk2); blk1:=blk2;
des.initialiseString(key2);
des.DecBlock(blk1,blk2); blk1:=blk2;
des.initialiseString(key1);
des.EncBlock(blk1,blk2); blk1:=blk2;
mac:=BlktoStr(blk1); {BuildCmd}

cmd[1]:=cla;cmd[2]:=ins; cmd[3]:=p1;
cmd[4]:=p2; cmd[5]:=lc;
for i:=1 to length(si) do cmd[5+i]:=ord(si[i]);
for i:=1 to length(mac) do cmd[length(si)+5+i]:=ord(mac[i]);
cmd[6+length(data)+length(si)]:=le;
lr:=100; resp:=''; sw1:=0; sw2:=0;
fillchar(rsp,sizeof(rsp),32);
cmdptr:=addr(cmd); rspptr:=addr(rsp);

res:=CTData(0,dad,sad,cmdlen,cmdptr,lr,rspptr);
sw1:=0; sw2:=0;
if res=0 then
   begin sw1:=ord(rsp[lr-1]); sw2:=ord(rsp[lr]); end;
if (sw1=$61) and (sw2=10) then result:=true;
key1:='53882016'; key2:='34216680';  {hide keys}
end;


function TForm1.CardOk:boolean; // Reset Card
var i:word; res:smallint;
begin
{init reader}
res:=CTInit(0,0);
if res <> 0 then
   begin
   messagebeep(0); showmessage('ERROR - Card reader error'); result:=false; system.exit;
   end;
{reset card}
dad:=1; sad:=2;
cla:=$20; ins:=$10; p1:=1; p2:=1; lc:=0; le:=0; cmdlen:=4;
data:=#0;
cmd[1]:=cla;cmd[2]:=ins; cmd[3]:=p1; cmd[4]:=p2; cmd[5]:=lc;
for i:=1 to length(data) do cmd[5+i]:=ord(data[i]);
cmd[6+length(data)]:=le;
lr:=15; resp:=''; sw1:=0; sw2:=0;
fillchar(rsp,length(rsp),32);
cmdptr:=addr(cmd); rspptr:=addr(rsp);
res:=CTData(0,dad,sad,cmdlen,cmdptr,lr,rspptr);
if res=0 then
    begin
    if lr >= 2 then
       begin
       sw1:=ord(rsp[lr-1]); sw2:=ord(rsp[lr]);
       for i:=1 to lr-2 do resp:=resp+ansichar(rsp[i]);
       if not ((sw1=$90) and (sw2=1)) then
          begin messagebeep(0); showmessage('ERROR - Card not inserted'); result:=false; system.exit; end;
       end
    end
  else
   begin messagebeep(0); showmessage('ERROR - Card not inserted'); result:=false; system.exit; end;
ReadCTC;      // Added May 2010 - Delphi 2010 on Windows 7 ?
result:=true;
end;


function TForm1.pad(tag,n:byte):ansistring;
const padding=#$80+#0+#0+#0+#0+#0+#0+#0;
begin
if n=0 then result:=ansichar(tag)+ copy(padding,1,7)
  else
   result:=copy(padding,1,n);
end;

function TForm1.BuildMacBlocks(tag:byte; ctc:ctcarray; hdr,si:ansistring;
                               var so:ansistring):integer;
var bc,i:integer; ts:ansistring;
begin
so:=''; ts:=si;
bc:=0;
so:=ansichar(tag)+ansichar(ctc[1])+ansichar(ctc[2])+hdr; inc(bc);
if length(ts) > 7 then
   begin
   for i:=1 to (length(si) div 7) do
      begin
      so:=so+ansichar(tag)+copy(ts,1,7);
      delete(ts,1,7);
      end;
   so:=so+ansichar(tag)+ts+pad(tag,7-length(ts));
   bc:=bc+length(si) div 7 + 1;
   end
   else
    begin
    so:=so+ansichar(tag)+si+pad(tag,7-length(si));
    inc(bc); if length(si)=7 then inc(bc);
    end;
result:=bc;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
ReadCTC;

Showmessage('CTC = '+inttostr(ctc[2])+'  '+inttostr(ctc[1]));
end;

function TForm1.XorBlks(b1,b2:tblock):tblock;
var ts:tblock; i:integer;
begin
for i:=0 to 7 do
   ts[i]:= b1[i] xor b2[i];
result:=ts;
end;

function TForm1.StrtoBlk(s:ansistring):tblock;
var i:integer; inblk:tblock;
begin
for i:=0 to 7 do inblk[i]:=ord(s[i+1]);
result:=inblk;
end;

function TForm1.BlktoStr(b:tblock):ansistring;
var i:integer; s:ansistring;
begin
s:='00000000';
for i:=0 to 7 do s[i+1]:=ansichar(b[i]);
result:=s;
end;

//*
//* End of generic s/card routines
//*

procedure TForm1.FormCreate(Sender: TObject);
begin
//if CheckReg then
//   begin
   OsType:=GetOsName;
   SelectDLL;
   sourceread:=false; removed:=false; transferred:=false;
   ClearAmts;
//   end
//  else
//   application.Terminate;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
if hinst<>0 then FreeLibrary(hinst);
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
Canclose:=not (removed and not transferred);
if not Canclose then
   begin
   messagebeep(0);
   showmessage('ERROR - Removed amount not transferred');
   end;
end;

procedure TForm1.ClearEdits;
begin
edit1.text:='';edit2.text:='';edit3.text:='';
edit4.text:='';edit5.text:='';edit6.text:='';edit7.text:='';
end;

procedure TForm1.ClearAmts;
begin
sourceorg:=0; sourceupdate:=0; destorg:=0; destupdate:=0; amttransferred:=0;
end;

procedure TForm1.Xorwith(var ds:ansistring;es:ansistring);
var i:word;
begin
for i:=1 to 8 do ds[i]:=ansichar(ord(ds[i]) xor ord(es[i]));
end;

procedure TForm1.ShowDS(ds:string);
var i:word;
begin
for i:=1 to 8 do showmessage(inttostr(ord(ds[i])));
end;


function TForm1.GetOSName:string;
//*Return a string of the OS name
var OsInfo: TOSVERSIONINFO;
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
      else result := 'Win32' {Windows NT}
      end;
    end;
 end;
end;

procedure TForm1.SelectDLL;
//*Select windows OS dll types
begin
  if OsType='Win32' then DLLName := 'Ctpcsc.dll' else DLLName := 'Ctscrw95.dll';
  DLLHandle := LoadLibrary( DLLName );
  try
    if DLLHandle > 0 then
    begin
      @CTInit := GetProcAddress( DLLHandle, 'CT_init');
      @CTClose := GetProcAddress( DLLHandle, 'CT_close');
      @CTData := GetProcAddress( DLLHandle, 'CT_data');
    end
    else
     MessageDlg('Error: '+DLLName+' not found', mtInformation,[mbOk], 0);
  finally
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
//* Close file & write Cardswap.ini unit value
var inifile:tinifile;
begin
if DLLHandle > 0 then FreeLibrary( DLLHandle );
inifile:=tinifile.create(extractfilepath(paramstr(0))+'Cardswap.ini');
with inifile do
   begin
   writestring('general','units',unitscombo.text);
   end;
inifile.free;

end;

procedure TForm1.FormShow(Sender: TObject);
//*Sets card swap units.
var inifile:tinifile;
begin
inifile:=tinifile.create(extractfilepath(paramstr(0))+'Cardswap.ini');
with inifile do
   begin
   unitscombo.text:=readstring('general','units','Metres');
   end;
inifile.Free;
end;

procedure TForm1.Decrypt;
//*Decrypts total
var ts,seedtext:ansistring; Key128:TKey128;
begin
seedtext:=string(floattostr(exp(pi))); // change seed and equation for panel & truss.
GenerateLMDKey(Key128, SizeOf(Key128), seedText);
ts := TripleDESEncryptStringEx(EncryptedTotal, Key128, false); // decrypt
Total:=ts;
end;

procedure TForm1.Encrypt;
//* Encrypts steel total
var ts,seedtext:ansistring; Key128:TKey128;
begin
ts:=total;
seedtext:=string(floattostr(exp(pi))); // change seed and equation for panel & truss.
GenerateLMDKey(Key128, SizeOf(Key128), seedText);
EncryptedTotal := TripleDESEncryptStringEx(ts, Key128, true); // encrypt
end;


END.
