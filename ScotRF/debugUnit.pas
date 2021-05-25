unit debugUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;
{-DEFINE DEBUGIJP}
type
  TDebug = class(TForm)
    Memo1: TMemo;
    StatusBar1: TStatusBar;
    bnSave: TBitBtn;
    procedure bnSaveClick(Sender: TObject);
  private
    class var instance: TDebug;
  public
    destructor Destroy; override;
    class procedure Log(S: string); overload;
    class procedure Log(const AFormat: string; const Args: array of const); overload;
  end;

implementation

{$R *.dfm}

destructor TDebug.Destroy;
begin
{$ifdef DEBUGIJP}
  Memo1.Lines.SaveToFile('c:\temp\Scotrf final.log');
{$endif}
  instance := nil;
  inherited;
end;

procedure TDebug.bnSaveClick(Sender: TObject);
begin
  Memo1.Lines.SaveToFile('c:\temp\Scotrf.log');
end;

class procedure TDebug.Log(S: string);
begin
{$ifdef DEBUGIJP}
  if instance = nil then
    instance := TDebug.Create(nil);
  if instance <> nil then
  begin
    instance.Memo1.Lines.add(S);
    if not instance.Visible then
      instance.Show;
  end;
{$endif}
end;

class procedure TDebug.Log(const AFormat: string; const Args: array of const);
begin
  Log(format(AFormat, Args));
end;

initialization


finalization

if assigned(TDebug.instance) then
  FreeAndNil(TDebug.instance)

end.
