unit UnitsU;

{
Utility routines for converting units
currently there's only one public function:
  ImperialStrToMM
The other routines are just called by that
}

interface

uses
  Windows, SysUtils{, Dialogs};

  function ImperialStrToMM(s: string; var bUnitsErrorOccured: Bool): Double;

implementation

function InchesToMM(Inches: Double): Double;
const
  INCHES_PER_METER=39.370079;
begin
  Result := Inches * 1000 / INCHES_PER_METER;
end;

function FeetInch2ThirtySeconds(es: string; var bUnitsError: Bool): string;
  //---------------------------
  function GetIntFromStr(s: string; Index, Count: Integer): Integer;
  begin
    try
      Result := StrToInt(Copy(s, Index, Count));
    except
      Result := 0;
    end;
  end;
  //---------------------------
//type
//  TValidChars = set of Char;
var
  n: Byte;
  ftpos,fracpos,spcpos,
  Feet, Inches, Numerator, Denominator, neg, i: Integer;
  //ValidChars: TValidChars;
  HasInValidChar: Bool;
begin
  Result:='0';  bUnitsError := True;

  if es = '' then
    exit;
  neg := 1;
  if es[1]='-' then  //remove any -ve sign
  begin
    neg := -1;
    Delete(es, 1, 1);
  end;
  if es = '' then
    exit;

  //ValidChars := ['0'..'9', '"','-','/',chr(39),' '];   {...no decimals allowed '.',}
  HasInValidChar := False;
  for n := 1 to Length(es) do
  begin
    //HasInValidChar := not(es[n] in ValidChars);
    HasInValidChar := not CharInSet(es[n], ['0'..'9', '"','-','/',chr(39),' ']);
    if HasInValidChar then
      break;
  end;
  if HasInValidChar then
    exit;

  try
    for i:=1 to Length(es) do
      if es[i]='"' then
        es[i]:=' ';
    es := trim(es);
    if es='' then
      exit;
    Feet := 0; Inches := 0; Numerator := 0; Denominator := 1;
    ftpos := pos(chr(39), es);
    if ftpos > 0 then begin
      Feet := GetIntFromStr(es, 1, pred(ftpos));
      Delete(es, 1, ftpos);
    end;
    es := trim(es);
    spcpos := pos(' ', es); fracpos := pos(chr(47), es);
    if (spcpos=0) and (fracpos=0) and (Length(es)>0) then
      Inches := StrToInt(es);
    if (spcpos>0) then  //removed "and (fracpos>0)" v943
    begin
      Inches := GetIntFromStr(es, 1, pred(spcpos));
      Delete(es, 1, spcpos);
    end;
    fracpos := pos(chr(47), es);
    if fracpos>0 then
    begin
      Numerator := GetIntFromStr(es, 1, pred(fracpos));
      Denominator := GetIntFromStr(es, succ(fracpos), 4);
      if Denominator = 0 then
        exit;
    end;
    Result := IntToStr(neg*Round(feet*12*32+inches*32+(numerator/denominator*32)));
    bUnitsError := False;
  except
    //on EConvertError do ShowMessage('Unit Error!');  //replaced with bUnitsError
  end;
end;

//* Convert an imperial string to millimetres
function ImperialStrToMM(s: string; var bUnitsErrorOccured: Bool): Double;
var
  s32: string;
  f: Double;
begin
  s32 := FeetInch2ThirtySeconds(s, bUnitsErrorOccured);
  f := StrToFloat(s32);  //32nds
  f := f/32;
  Result := InchesToMM(f);
end;

END.
