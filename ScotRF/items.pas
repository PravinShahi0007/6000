unit items;
{
 Form for user maintenance of item production
}

interface

uses
  Windows, Classes, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ComCtrls, ScotRfTypes, winUtils;

type
  TItemform = class(TForm)
    Memo1: TMemo;
    bnClear: TSpeedButton;
    bnLoad: TSpeedButton;
    bnSave: TSpeedButton;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    SpeedButton2: TSpeedButton;
    bnHelp: TSpeedButton;
    bnWizard: TSpeedButton;
    StatusBar1: TStatusBar;
    bnRun: TSpeedButton;
    procedure bnLoadClick(Sender: TObject);
    procedure bnSaveClick(Sender: TObject);
    procedure bnHelpClick(Sender: TObject);
    procedure bnWizardClick(Sender: TObject);
    procedure bnClearClick(Sender: TObject);
    procedure bnRunClick(Sender: TObject);
  private
    procedure AddStrings(Source: TStrings; Count: integer);
  public
    itemfilename:string;
  end;

var
  Itemform: TItemform;

implementation

uses itemhelp, itemwizard, PanelWizard;
{$R *.DFM}

procedure TItemform.bnLoadClick(Sender: TObject);
//*Load existing item file
var dsnfile: textfile; ts:string;
begin
  if OpenDialog1.execute and (OpenDialog1.filename <> '') then
  begin
    Memo1.clear;
    itemfilename := OpenDialog1.filename;
    caption := itemfilename;
    AssignFile(dsnfile, OpenDialog1.filename);
    Reset(dsnfile);
    repeat
      readln(dsnfile, ts);
      Memo1.lines.add(ts);
    until eof(dsnfile);
    Closefile(dsnfile);
  end;
end;

procedure TItemform.bnRunClick(Sender: TObject);
begin
  if Memo1.lines.Count = 0 then
    NoFramesMessage
  else
    modalResult := ID_RUNPROCESS;
end;

procedure TItemform.bnSaveClick(Sender: TObject);
//* Save items to file
var
  SL: TStringlist;
begin
  SaveDialog1.filename := itemfilename;
  SL := TStringlist.Create;
  try
    if SaveDialog1.execute and (SaveDialog1.filename <> '') and (Memo1.lines.Count > 0) then
      Memo1.lines.savetofile(SaveDialog1.filename);
  finally
    SL.Free;
  end;
end;

procedure TItemform.bnHelpClick(Sender: TObject);
//*Open item designer help
begin
  itemhelpform.showmodal;
end;

procedure TItemform.AddStrings(Source: TStrings; Count: integer);
var N: integer;
begin
  for N := 1 to count do
    memo1.Lines.AddStrings(Source);
end;

procedure TItemform.bnWizardClick(Sender: TObject);
//*Call item designer wizard
begin
{$IFDEF PANEL}
  setDialogPos(PanelWizardform);
  if PanelWizardform.showmodal = mrOK then
  begin
    AddStrings(PanelWizardform.lines,PanelWizardform.count);
  end;
{$ELSE}
  setDialogPos(PanelWizardform);
  if itemwizardform.showmodal = mrOK then
  begin
    AddStrings(itemwizardform.lines,itemwizardform.count);
  end;
{$ENDIF}
end;


 procedure TItemform.bnClearClick(Sender: TObject);
//*Erase all items from listbox
begin
  Memo1.clear;
end;

end.
