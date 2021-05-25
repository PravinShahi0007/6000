unit TranslateU;

interface

uses
  SysUtils, Classes, Forms,
  TypInfo;

  function TranslateStr(const ASentence: string): string;
  procedure TranslateForm(AForm: TForm);

var RecordStrings: boolean;
implementation


var
  LanguageStrings: TStringList;

//* Look for the Language file
//* this is 'Language.txt' in the same folder as the application
//* this procedure is automatically called from the initialization part of this unit
procedure ReadLanguageFile;
var
  sFileName: string;
  i: Integer;
begin
  sFileName := ExtractFilePath(ParamStr(0)) + 'Language.txt';
  if FileExists(sFileName) then
  begin
    LanguageStrings.LoadFromFile(sFileName);
    // - Remove the REM strings -
    for  i:=pred(LanguageStrings.Count) downto 0 do
      //if copy(LanguageStrings[i],1,1)=';' then
      if pos(';', LanguageStrings[i]) = 1 then
        LanguageStrings.Delete(i);
  end;
end;

//* Translate a string variable
//* if ASentence is not found no change is made to it
//* Usage e.g.:
//* s := 'Hello';
//* Translate(s);
function isALanguageString(ASentence: ansistring): boolean;
var  c: ansichar; N: integer;
begin
  N:=0;
  for c in asentence do
    if c in ['a'..'z','A'..'Z'] then
      inc(N);
  result:=N>=3;

end;
function TranslateRaw(const ASentence: ansistring): string;
var
  s: string;
begin
  result:=  ASentence;
  if LanguageStrings=nil then
    exit;
  if isALanguageString(ASentence) then
  begin
    s := LanguageStrings.Values[ASentence];
    if (s<>'') and (S<>'?') then
      result:=s
    else if s='' then
       LanguageStrings.Values[ASentence]:='?';
  end;
end;

function TranslateStr(const ASentence: string): string;
var c1,cLast: char;
begin
  c1:=#0;cLast:=#0;
  if length(ASentence)>=1 then
    c1:=ASentence[1];
  if length(ASentence)>=2 then
    cLast:=ASentence[length(ASentence)];
  if c1='&' then
    exit('&'+TranslateRaw(copy( ASentence,2,999)));
  if (c1='(') and (cLast=')' ) then
    exit('('+TranslateRaw(copy( ASentence,2,length(ASentence)-2)+')'));
  exit(TranslateRaw(ASentence));
end;

//* Translate all the Caption, Hint and Text properties in a form
//* Add:
//*        TranslateForm(Self);
//* to any form's OnCreate event to update all those strings
procedure TranslateForm(AForm: TForm);
var
  s: ansistring;
   //--------------------------------------------
   procedure CheckProperty(lComponent: TComponent; const aProperty: string);
   var
     PropInfo: PPropInfo;
   begin
     PropInfo := GetPropInfo(lComponent, aProperty);
     if Assigned(PropInfo) then
     begin
       s := GetStrProp(lComponent, aProperty);
       if s <> '' then
       begin
         s:=TranslateStr (s);
         SetStrProp(lComponent, aProperty, s);
       end;
     end;
   end;
   //---- Recursive search for components -----
   procedure AddToList(AComponent: TComponent);
   var
     lComponent: TComponent;
   begin
     for lComponent in AComponent do
     begin
       if lComponent.ComponentCount > 0 then
         AddToList(lComponent);              //recurse

       CheckProperty(lComponent, 'Caption');
       CheckProperty(lComponent, 'Hint');
       CheckProperty(lComponent, 'Text');
     end;
   end;
   //--------------------------------------------
begin
  AddToList(AForm);
end;

initialization
  LanguageStrings := TStringList.Create;
  ReadLanguageFile;
finalization
  if RecordStrings then
    LanguageStrings.SaveToFile ( ExtractFilePath(ParamStr(0)) + 'Language.txt');
  LanguageStrings.Free;
END.
