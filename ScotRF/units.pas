unit units;
{
Unit conversion routines
Author - Pete
Gcad & RF3/4 used to use 1/16 as base unit for imperial
SD & ScotRF etc .. uses decimal mm
2011 Aug - mod to Units Out to allow decimals for metric PG
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, printers, ComCtrls, ScotRFTypes;

//function UnitsIn(s:string):string;
{ Imperial settings:
  on-screen is feet inches and 1/16ths
  internal unit-of-measure is mm (was 1/16th inch)
  Items Wizard and items screen enter and display imperial values
}
function StrToMM(s: string): Double;
function MMToStr(d: double;inchonly:boolean=false): string;
function StrToMMOr16ths(s: string): Double;
function FeetInch2Sixteenths(es:string):string;
function Sixteenths2FeetInch(ss:string;inchonly:boolean):string;
function ThirtySeconds2FeetInch(ss: string; inchonly: Boolean=False): string;
function fracinch(f:real):string;
function UnitsOut(s:string):string;
function ToolUnitsOut(s:string):string;
function ToolUnitsIn(s:string):string; // zallows /32 " input
function FeetInch2ThirtySeconds(es:string):string;
function mmto16ths(s:string):string;
function mmto32nds(s:string):string;

implementation

const
  MM_PER_16th = 1.5875;    // = 25.4 / 16
  MM_PER_32nd = 0.79375;   // = 25.4 / 32

function UnitsIn(s: string): string;
//*Returns a metric string or a 16th for imperial
begin
  Result := s;
  if NOT G_Settings.general_metric then
    Result := FeetInch2Sixteenths(s);
end;

function StrToMM(s: string): Double;
var
  s32: string;
begin
  if NOT G_Settings.general_metric then
  begin
    s32 := FeetInch2ThirtySeconds(s);
    Result := StrToFloat(s32) * MM_PER_32nd;
  end
  else
    Result := StrToFloat(s);
end;

function MMToStr(d: double;inchonly:boolean): string;
begin
  if NOT G_Settings.general_metric then
    Result := Sixteenths2FeetInch(FloatToStr(d / MM_PER_16th), inchonly)
  else
    Result := FloatToStr(d);
end;

function StrToMMOr16ths(s: string): Double;
begin
  if NOT G_Settings.general_metric then
    Result := StrToFloat( FeetInch2Sixteenths(s) )
  else
    Result := StrToFloat(s);
end;

function MMOr16thsToStr(d: Double): string;
begin
  Result := FloatToStr(d);
  if NOT G_Settings.general_metric then
    Result := Sixteenths2FeetInch(Result, False);
end;

function FeetInch2Sixteenths(es:string):string;
//*Converts string es (feet & inches) - returns a string of 16ths "
var
  ftpos,i,fracpos,spcpos,feet,inches,numerator,denominator,neg: Integer;
begin
  Result := '0';
  try
    for i:=1 to length(es) do
      if es[i]='"' then
        es[i]:=' ';
    es := Trim(es);
    if es='' then
      system.exit;
    neg:=1;
    if es[1]='-' then
    begin
      neg:=-1; delete(es,1,1);
    end;

    inches:=0; feet:=0; numerator:=0; denominator:=1;
    ftpos := pos(chr(39),es);  //fracpos:=pos(chr(47),es);
    if ftpos > 0 then
    begin
      feet := strtoint(copy(es,1,ftpos-1)); delete(es,1,ftpos);
    end;
    es:=trim(es);
    spcpos:=pos(' ',es); fracpos:=pos(chr(47),es);
    if (spcpos=0) and (fracpos=0) and (length(es)>0) then
      inches:=strtoint(es);
    if (spcpos>0) and (fracpos>0) then
    begin
      inches:=strtoint(copy(es,1,spcpos-1)); delete(es,1,spcpos);
    end;
    fracpos:=pos(chr(47),es);
    if fracpos>0 then
    begin
      numerator:=strtoint(copy(es,1,fracpos-1));
      if Length(es) > 4 then
        denominator:=strtoint(copy(es,fracpos+1,4));
    end;
    Result := IntToStr(neg*Round(feet*12*16 + inches*16 + (numerator/denominator*16)));
  except
    on EConvertError do showmessage('Unit Error!');
  end;
end;

function Fracinch(f:real):string;
//* Converts f inches to a fraction string
var
  sixteenths: Byte;
begin
  sixteenths:=round(f*16);
  if sixteenths=16 then
    fracinch:='1'
  else
    case sixteenths of
      1:fracinch:='1/16';   2:fracinch:='1/8';   3:fracinch:='3/16';   4:fracinch:='1/4';
      5:fracinch:='5/16';   6:fracinch:='3/8';   7:fracinch:='7/16';   8:fracinch:='1/2';
      9:fracinch:='9/16';   10:fracinch:='5/8'; 11:fracinch:='11/16'; 12:fracinch:='3/4';
      13:fracinch:='13/16'; 14:fracinch:='7/8'; 15:fracinch:='15/16';
    end;
end;

function Fracinch32(f: real):string;
//* Converts f inches to a fraction string
var
  thirty: Byte;
begin
  thirty := Round(f*32);
  if thirty=32 then
    Result:='1'
  else
    case thirty of
      1:Result:='1/32';    2:Result:='1/16';   3:Result:='3/32';   4:Result:='1/8';
      5:result:='5/32';    6:result:='3/16';   7:result:='7/32';   8:result:='1/4';
      9:result:='9/32';   10:result:='5/16';  11:result:='11/32'; 12:result:='3/8';
      13:result:='13/32'; 14:result:='7/16';  15:result:='15/32'; 16:result:='1/2';

      17:result:='17/32'; 18:result:='9/16';  19:result:='19/32'; 20:result:='5/8';
      21:result:='21/32'; 22:result:='11/16'; 23:result:='23/32'; 24:result:='3/4';
      25:result:='25/32'; 26:result:='13/16'; 27:result:='27/32'; 28:result:='7/8';
      29:result:='29/32'; 30:result:='15/16'; 31:result:='31/32';
    end;
end;

function WholeNoStr(s:string):string;
// strips decimal part from string, ie makes whole no string
var
  p: Integer;
begin
  Result := s;
  p := pos('.', s);
  if p > 0 then
    Result := Copy(s, 1, p-1);
end;

function UnitsOut(s:string):string;
//*Returns Feet and inches from sixteenths
begin
  Result := s;
  if NOT G_Settings.general_metric then
    Result := Sixteenths2FeetInch(mmto16ths(WholeNoStr(s)), false);
end;

function ToolUnitsOut(s:string):string;
//*Returns Feet and inches from thirtyseconds
begin
  Result := s;
  if NOT G_Settings.general_metric then
    Result := Thirtyseconds2FeetInch(mmto32nds(s), false);
end;

function mmto16ths(s: string): string;
//*Converts string s mm & returns a string of 1/16th "
begin
  result := IntToStr(Round(StrToInt(Trim(s)) / MM_PER_16th));
end;

function mmto32nds(s:string):string;
//*Converts string s mm & returns a string of 1/32 "
begin
  Result := FloatToStr(Round(StrToFloat(Trim(s)) / MM_PER_32nd));
end;

function Sixteenths2FeetInch(ss:string;inchonly:boolean):string;
//*Converts a number of 1/16ths (as a string ss} to Feet and inches
var
  emperials,fracs,negs: string;
  inches,feet: longint;
  six,remain:real;
  neg:boolean;
begin
  result:='0';
  if ss='' then
    exit;
  try
    six:=strtofloat(ss);
    neg:= six < 0;
    if neg then
      negs:='-'
    else
      negs:='';
    six:=abs(six);
    inches:=trunc(six/16); remain:=six - inches*16;
    fracs:=trim(fracinch(remain/16));
    if fracs='1' then
    begin
      inc(inches); fracs:='';
    end;
    if inchonly then
      if inches=0 then
        emperials:=fracs
      else
        emperials:=inttostr(inches)+' '+fracs
    else begin
      emperials:='';
      feet:=inches div 12;
      if feet <> 0 then
        emperials:=inttostr(feet)+chr(39);
      if (inches-feet*12) > 0 then
        emperials:=emperials+' '+inttostr(inches-feet*12);
      if fracs <> '' then
        emperials:=emperials+' '+fracs;
    end;
    result:=negs+emperials;
    if result='' then
      result:='0';
  except
    on EConvertError do showmessage('Unit Error : '+ss);
  end;
end;

function ThirtySeconds2FeetInch(ss: string; inchonly: Boolean=False): string;
//*Converts a number of 1/32nds (as a string ss} to Feet and inches
var
  emperials,fracs,negs: string;
  inches,feet: longint;
  thirty,remain: real;
  neg: boolean;
begin
  result:='0';
  if ss='' then exit;
  try
  thirty:=strtofloat(ss); neg:= thirty < 0; if neg then negs:='-' else negs:='';
  thirty:=abs(thirty);
  inches:=trunc(thirty/32); remain:=thirty - inches*32;
  fracs:=trim(fracinch32(remain/32));
  if fracs='1' then begin inc(inches); fracs:=''; end;
  if inchonly then
     if inches=0 then emperials:=fracs
       else emperials:=inttostr(inches)+' '+fracs
    else
     begin
     emperials:='';
     feet:=inches div 12; if feet <> 0 then emperials:=inttostr(feet)+chr(39);
     if (inches-feet*12) > 0 then emperials:=emperials+' '+inttostr(inches-feet*12);
     if fracs <> '' then emperials:=emperials+' '+fracs;
     end;
  result:=negs+emperials;
  if result='' then result:='0';
  except
    on EConvertError do ;//showmessage('Unit Error : '+ss);
  end;
end;


function ToolUnitsIn(s:string):string;
//* Converts a string of feet and inches, to 1/32".
//* Allows tool adjustments in 1/32" imperial units
begin
  Result := s;
  if NOT G_Settings.general_metric then
    Result := FloatToStr(MM_PER_32nd * StrToFloat(FeetInch2ThirtySeconds(s)));
end;

function FeetInch2ThirtySeconds(es:string):string;
//*Converts Feet & inches string to 1/32ths "
var
  ftpos,i,fracpos,spcpos,feet,inches,numerator,denominator,neg: Integer;
begin
  Result := '0';
  try
    for i:=1 to length(es) do
      if es[i]='"' then
        es[i]:=' ';
      es:=trim(es);
      if es='' then
        system.exit;
      if es[1]='-' then
      begin
        neg:=-1; delete(es,1,1);
      end
      else
        neg:=1;
      inches:=0; feet:=0; numerator:=0; denominator:=1;
      ftpos:=pos(chr(39),es);
      if ftpos > 0 then
      begin
        feet:=strtoint(copy(es,1,ftpos-1)); delete(es,1,ftpos);
      end;
      es:=trim(es);
      spcpos:=pos(' ',es); fracpos:=pos(chr(47),es);
      if (spcpos=0) and (fracpos=0) and (length(es)>0) then
        inches:=strtoint(es);
      if (spcpos>0) and (fracpos>0) then
      begin
        inches:=strtoint(copy(es,1,spcpos-1)); delete(es,1,spcpos);
      end;
      fracpos:=pos(chr(47),es);
      if (fracpos>1) and (Length(es)-fracpos >=1) then
      begin
        numerator := StrToInt(Copy(es, 1, fracpos-1));
        denominator := StrToInt(Copy(es, fracpos+1, Length(es)));
      end;
      Result := IntToStr(neg*Round(feet*12*32 + inches*32 + (numerator/denominator*32)));
    except
      //on EConvertError do showmessage('Unit Error!');
    end;
end;

END.
