unit UnitStopServiceForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvWaitingGradient, ExtCtrls;

type
  TStopServiceForm = class(TForm)
    WaitingGradient: TJvWaitingGradient;
    lblProgressTitle: TLabel;
    TimerAutoClose: TTimer;
    btnHide: TButton;
    procedure FormCreate(Sender: TObject);
    procedure TimerAutoCloseTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnHideClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetHeading(const strHeading: string);
    procedure SetTimer(const iMilliseconds: Integer);
  end;

implementation

{$R *.dfm}

procedure TStopServiceForm.btnHideClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TStopServiceForm.FormCreate(Sender: TObject);
begin
  TimerAutoClose.Enabled := True;
  WaitingGradient.Active := True;
end;

procedure TStopServiceForm.FormShow(Sender: TObject);
begin
  TimerAutoClose.Enabled := True;
end;

procedure TStopServiceForm.SetHeading(const strHeading: string);
begin
  lblProgressTitle.Caption := strHeading;
end;

procedure TStopServiceForm.SetTimer(const iMilliseconds: Integer);
begin
  TimerAutoClose.Interval := iMilliseconds;
end;

procedure TStopServiceForm.TimerAutoCloseTimer(Sender: TObject);
begin
  WaitingGradient.Active := False;
  Self.Close();
end;

end.
