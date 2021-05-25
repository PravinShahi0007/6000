unit ResourcesU;

interface

uses
  SysUtils, Classes, ImgList, Controls;

type
  TResources = class(TDataModule)
    ImageList32: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Resources: TResources;

implementation

{$R *.dfm}

end.
