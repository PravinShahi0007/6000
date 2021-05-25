unit mint;
{
 General drive communication routines - pre Mint II drives
}

interface

uses
  Windows, SysUtils, Forms,  StdCtrls;

function Send(cmd:string): boolean;
function SendMove(cmd:string): boolean;
function WriteCommsArray(canum, datas:string): boolean;
procedure DownloadConfiguration(configfile:string);
procedure DownloadProgram(programfile:string);
function ReadCommsArray(canum:string): boolean;
procedure SendMint(cmd:string);
function WaitforMint(n: word; wc:string): boolean;

implementation

uses rollformerU;

const
  eot = 4; ack = 6; nak = 21; stx = 2; etx = 3; enq = 5;

var
  memo1: tMemo;
function Send(cmd:string): boolean;
//*Send operation command string via serial port
begin
  ReceivedStrings := '';
  rollformer.VaComm1.WriteBuf(cmd[1], length(cmd));
  rollformer.startTimer;
  repeat
    application.processmessages
  until (pos('*', ReceivedStrings)<> 0) or (pos('!', ReceivedStrings)<> 0) or (rollformer.tick > 5); {5s}
  result :=(pos('*', ReceivedStrings)<> 0);
  if not result then
    inc(errcount);
end;

function SendMove(cmd:string): boolean;
//*Send move command string via serial port
var ok: boolean;
begin
  ReceivedStrings := '';
  rollformer.startTimer;
  rollformer.VaComm1.WriteBuf(cmd[1], length(cmd));
  repeat
    application.processmessages
  until (pos('*', ReceivedStrings)<> 0) or (pos('!', ReceivedStrings)<> 0) or (rollformer.tick > 5); {5s}
  ok :=(pos('*', ReceivedStrings)<> 0);
  if ok then
  begin
    ReceivedStrings := '';
    rollformer.StartTimer;
    repeat
      application.processmessages
    until (pos('#', ReceivedStrings)<> 0) or (pos('!', ReceivedStrings)<> 0) or (rollformer.tick > 15); {15s}
    ok :=(pos('#', ReceivedStrings)<> 0);
  end;
  result := ok;
  if not ok then
    inc(errcount);
end;

function WriteCommsArray(canum, datas:string): boolean;
//*Write into drives comms array memory - this is scanned by the drive software for changes
var td: array[1 .. 100] of byte; i: integer; chksum: byte; tds{,ts}:string;
begin
  td[1]:= eot;
  td[2]:= ord('0'); {ascii 0}
  td[3]:= td[2];
  td[4]:= stx;
  if length(canum) = 0 then
    canum := '00';
  if length(canum) = 1 then
    canum := '0' + canum;
  td[5]:= ord(canum[1]); td[6]:= ord(canum[2]);
  for i := 1 to length(datas) do
    td[6 + i]:= ord(datas[i]);
  td[6 + length(datas)+ 1]:= etx;
  chksum := td[5];
  for i := 6 to 6 + length(datas)+ 1 do
    chksum := chksum xor td[i];
  td[6 + length(datas)+ 2]:= chksum;
  tds := '';
  for i := 1 to 6 + length(datas)+ 2 do
    tds := tds + chr(td[i]);
  ReceivedStrings := '';
  rollformer.VaComm1.WriteBuf(tds[1], length(tds));

  rollformer.StartTimer;
  repeat
    application.processmessages
  until (pos(chr(ack), ReceivedStrings)<> 0) or (pos(chr(nak), ReceivedStrings)<> 0) or (rollformer.tick > 2);
  result :=(pos(chr(ack), ReceivedStrings)<> 0);
  if not result then
    inc(errcount);
end;

procedure DownloadConfiguration(configfile:string);
//* write drive configuration file for Pre Mint controllers
const lf = 10;
var tf: textfile; ts:string;
begin
  Memo1.clear;
  SendMint(^E);
  WaitforMint(5, 'Break');
  SendMint('CON' +^J);
  WaitforMint(5, 'C>');
  SendMint('NEW' +^J);
  WaitforMint(5, 'C>');
  SendMint('EDIT' +^J);
  WaitforMint(5, '1>');
  assignfile(tf, configfile);
  reset(tf);
  repeat
    readln(tf, ts);
    if length(ts)= 0 then
      ts := ' '; {avoid 0 length lines}
    SendMint(ts +^J);
    WaitforMint(5, '>');
    Memo1.lines.add(ts);
    application.processmessages;
  until eof(tf);
  SendMint(^J);
  WaitforMint(5, 'C>');
  SendMint('RUN' +^J);
end;

function ReadCommsArray(canum:string): boolean;
//*Read drives comm array values. Canum:integer string, is the array index
var td: array[1 .. 100] of byte; i, J: integer; tds, ts:string;
begin
  td[1]:= eot;
  td[2]:= ord('0'); {ascii 0}
  td[3]:= td[2];
  td[4]:= stx;
  if length(canum) = 0 then
    canum := '00';
  if length(canum) = 1 then
    canum := '0' + canum;
  td[5]:= ord(canum[1]); td[6]:= ord(canum[2]);
  td[7]:= enq;
  tds := '';
  for i := 1 to 7 do
    tds := tds + chr(td[i]);
  ReceivedStrings := '';
  Rollformer.VaComm1.WriteBuf(tds[1], length(tds));
  Rollformer.StartTimer;
  repeat
    application.processmessages
  until (pos(chr(etx), ReceivedStrings)<> 0) or (pos(chr(nak), ReceivedStrings)<> 0) or (Rollformer.tick > 2);
  result :=(pos(chr(etx), ReceivedStrings)<> 0);

  if result then
  begin
    ts := '';
    J := pos(chr(etx), ReceivedStrings);
    for i := 4 to J - 1 do
      ts := ts + ReceivedStrings[i];
    Rollformer.CommData := ts;
  end;
  if not result then
    inc(errcount);
end;

procedure SendMint(cmd:string);
//*Write command buffer to the drive
begin
  ReceivedStrings := '';
  Rollformer.VaComm1.WriteBuf(cmd[1], length(cmd));
end;

function WaitforMint(n: word; wc:string): boolean;
//*Wait for the drive to respond for n:integer ticks of timer 4 clock
//*Increment errcount if timed out
begin
  rollformer.StartTimer ;
  repeat
    application.processmessages
  until (pos(wc, ReceivedStrings)<> 0) or (rollformer.tick >= n);
  result :=(pos(wc, ReceivedStrings)<> 0);
  if not result then
    inc(errcount);
end;

procedure DownloadProgram(programfile:string);
//* Download mnt program to pre Mint drives.
//*This talks directly to the drive, by emulation the text editor
const lf = 10;
var tf: textfile; ts:string;
begin
  Memo1.clear;
  SendMint(^E);
  WaitforMint(5, 'Break');
  SendMint('PROG' +^J);
  WaitforMint(5, 'P>');
  SendMint('NEW' +^J);
  WaitforMint(5, 'P>');
  SendMint('EDIT' +^J);
  WaitforMint(5, '1>');
  assignfile(tf, programfile);
  reset(tf);
  repeat
    readln(tf, ts);
    if length(ts)= 0 then
      ts := ' '; {avoid 0 length lines}
    SendMint(ts +^J);
    WaitforMint(5, '>');
    Memo1.lines.add(ts);
    application.processmessages;
  until eof(tf);
  SendMint(^J);
  WaitforMint(5, 'P>');
  SendMint('RUN' +^J);
end;

initialization
  memo1:= tMemo.create(application);
end.
