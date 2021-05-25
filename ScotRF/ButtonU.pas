unit ButtonU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, StrUtils, Menus, ImgList;

type
  TButtonFrame = class(TFrame)
    uxText: TLabel;
    ImageList32: TImageList;
  private
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation
uses mainu;
{$R *.dfm}


constructor TButtonFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;


end.
