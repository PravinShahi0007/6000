unit VirtualMachineU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BillboardU;

type
  TVMForm = class(TForm)
    Billboard1: TBillboard;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    Class var FForm: TVMForm;
  public
    class var Active: boolean;
    class procedure AddString(S: String); overload;
    destructor Destroy; override;
  end;

implementation
uses winUtils;

{$R *.dfm}
{ TVMForm }

class procedure TVMForm.AddString(S: String);
begin
  if Active then
  begin
    if FForm =nil then
    begin
      FForm := TVMForm.Create(application);
      FForm.show;
      FForm.Billboard1.count := 50;
    end;
    FForm.Billboard1.DisplayItem(S);
  end;
end;

destructor TVMForm.Destroy;
begin
  FForm :=nil;
  inherited;
end;

procedure TVMForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TVMForm.FormShow(Sender: TObject);
begin
  left := 50; width := 250;
end;
initialization
 TVMForm.Active := ctrlKeyDown;

end.
