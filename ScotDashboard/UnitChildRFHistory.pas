unit UnitChildRFHistory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitChildWin, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, UnitDMDesignJob, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, VCLTee.Series, Vcl.Menus,
  UnitScotDashBoard;

type
  TMDIChildRFHistory = class(TMDIChild)
    PanelLeft: TPanel;
    PanelRight: TPanel;
    Splitter1: TSplitter;
    DBGridRollFormer: TDBGrid;
    PopupMenuRFHistory: TPopupMenu;
    ActionLoadEP21: TMenuItem;
    DBGrid1: TDBGrid;
    Splitter2: TSplitter;
    DBChartRFProducedMeters: TDBChart;
    Series2: TBarSeries;
    procedure FormCreate(Sender: TObject);
    procedure DBGridRollFormerCellClick(Column: TColumn);
    procedure DBGridRollFormerKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MDIChildRFHistory: TMDIChildRFHistory;

implementation

{$R *.dfm}

procedure TMDIChildRFHistory.DBGridRollFormerCellClick(Column: TColumn);
begin
  inherited;
  DBChartRFProducedMeters.RefreshData;
end;

procedure TMDIChildRFHistory.DBGridRollFormerKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  DBChartRFProducedMeters.RefreshData;
end;

procedure TMDIChildRFHistory.FormCreate(Sender: TObject);
begin
  inherited;
  DBChartRFProducedMeters.RefreshData;
end;

end.
