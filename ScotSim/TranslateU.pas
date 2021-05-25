unit TranslateU;

interface

uses
  SysUtils, Classes, Forms,
  //Menus,
  TypInfo;

  procedure Translate(var ASentence: string);
  function TranslateStr(const ASentence: string): string;
  procedure TranslateForm(AForm: TForm);

var
  LanguageStrings: TStringList;

implementation

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
procedure Translate(var ASentence: string);
var
  s: string;
begin
  //stop access violation (from LanguageStrings not yet being created)
  if LanguageStrings=nil then
    exit;
  s := LanguageStrings.Values[ASentence];
  if s<>'' then
    ASentence := s;
end;

//* Translate a string and return the translation
//* if ASentence is not found it returns the original string
//* Usage e.g.:
//* s := 'Hello';
//* NewString := Translate(s);
function TranslateStr(const ASentence: string): string;
begin
  Result := ASentence;
  Translate(Result);
end;

//* Translate all the Caption, Hint and Text properties in a form
//* Add:
//*        TranslateForm(Self);
//* to any form's OnCreate event to update all those strings
procedure TranslateForm(AForm: TForm);
var
  s: string;
   //--------------------------------------------
   procedure CheckProperty(lComponent: TComponent; const aProperty: string);
   var
     PropInfo: PPropInfo;
   begin
     PropInfo := GetPropInfo(lComponent, aProperty);
     if Assigned(PropInfo) then
     begin
       s := GetStrProp(lComponent, aProperty);
       //s := StripHotKey(s);
       if s <> '' then
       begin
         Translate(s);
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
  LanguageStrings.Free;

END.
