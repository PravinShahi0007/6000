unit UnitChildRFStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitChildWin, Vcl.StdCtrls, Data.DB,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart,
  VCLTee.Series, Vcl.DBCtrls, JvExDBGrids, JvDBGrid;

type
  TMDIChildRFStatus = class(TMDIChild)
    PanelRight: TPanel;
    PanelLeft: TPanel;
    Splitter2: TSplitter;
    Splitter4: TSplitter;
    GroupBoxRollFormerRunningTime: TGroupBox;
    GroupBoxRollFormerProduceMeters: TGroupBox;
    Splitter1: TSplitter;
    Splitter5: TSplitter;
    DBChartRFRuningTime: TDBChart;
    Series1: TBarSeries;
    DBChartRFProducedMeters: TDBChart;
    Series2: TBarSeries;
    GroupBoxProductionByCard: TGroupBox;
    JvDBGridProductionByCard: TJvDBGrid;
    GroupBoxProductionByRF: TGroupBox;
    JvDBGridProductionByRF: TJvDBGrid;
    GroupBoxJob: TGroupBox;
    JvDBGridRFStatus: TJvDBGrid;
    GroupBoxPauseTime: TGroupBox;
    DBChartProductionByRF: TDBChart;
    Series5: TBarSeries;
    procedure FormCreate(Sender: TObject);
    procedure JvDBGridRFStatusCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MDIChildRFStatus: TMDIChildRFStatus;

implementation

{$R *.dfm}

uses UnitDMRFStatus;

procedure TMDIChildRFStatus.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  MDIChildRFStatus:=nil;
end;

procedure TMDIChildRFStatus.FormCreate(Sender: TObject);
begin
  inherited;
  DBChartRFRuningTime.AutoRefresh:=True;
  DBChartRFRuningTime.Refresh;
  DBChartRFRuningTime.RefreshData;
  DBChartRFProducedMeters.AutoRefresh:=True;
  DBChartRFProducedMeters.Refresh;
  DBChartRFProducedMeters.RefreshData;
end;

procedure TMDIChildRFStatus.JvDBGridRFStatusCellClick(Column: TColumn);
begin
  inherited;
  DBChartRFRuningTime.AutoRefresh:=True;
  DBChartRFRuningTime.Refresh;
  DBChartRFRuningTime.RefreshData;
  DBChartRFProducedMeters.AutoRefresh:=True;
  DBChartRFProducedMeters.Refresh;
  DBChartRFProducedMeters.RefreshData;
end;

end.
