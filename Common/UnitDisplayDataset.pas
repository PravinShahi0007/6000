unit UnitDisplayDataset;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TFormDisplayDataset = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure ShowDataset(aDataSet : TDataset);
  end;


implementation

{$R *.dfm}

procedure TFormDisplayDataset.FormShow(Sender: TObject);
begin
  Caption := DataSource1.DataSet.Name;
end;

class procedure TFormDisplayDataset.ShowDataset(aDataSet : TDataset);
var
  aFormShowData: TFormDisplayDataset;
begin
  aFormShowData := TFormDisplayDataset.Create(nil);
  aFormShowData.DataSource1.DataSet := aDataSet;
  aFormShowData.Show;
end;



end.
