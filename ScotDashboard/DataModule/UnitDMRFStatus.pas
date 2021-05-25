unit UnitDMRFStatus;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient, Datasnap.DSConnect,
  VCLTee.Series, Graphics, Winapi.ShlObj, DbxCommon, System.IniFiles, Windows,
  VCLTee.Chart, VCLTee.TeEngine, MidasLib, Types,
  ExtCtrls, VCLTee.DBChart, Vcl.StdCtrls, ScotRFTypes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type

  TDMRFStatus = class(TDataModule)
    DataSourceRFDateInfo: TDataSource;
    DataSourceProductionByCard: TDataSource;
    DataSourceProductionByRF: TDataSource;
    FDMemTableProductionByRollFormer: TFDMemTable;
    FDMemTableProductionByCard: TFDMemTable;
    FDMemTableRFDateInfo: TFDMemTable;
    FDMemTableProductionByRollFormerROLLFORMERID: TIntegerField;
    FDMemTableProductionByRollFormerMETERS: TFloatField;
    FDMemTableProductionByRollFormerCUTS: TIntegerField;
    FDMemTableProductionByRollFormerSWAGE: TIntegerField;
    FDMemTableProductionByRollFormerNOTCH: TIntegerField;
    FDMemTableProductionByRollFormerFLAT: TIntegerField;
    FDMemTableProductionByRollFormerFPUNCH: TIntegerField;
    FDMemTableProductionByRollFormerPAUSETIME: TIntegerField;
    FDMemTableProductionByRollFormerSTATUSID: TSmallintField;
    FDMemTableProductionByCardORIGINMETERS: TFloatField;
    FDMemTableProductionByCardMETERS: TFloatField;
    FDMemTableProductionByCardREMAINMETERS: TFloatField;
    FDMemTableProductionByCardCARDNUMBER: TWideStringField;
    FDMemTableProductionByRollFormerRUNSECONDS: TIntegerField;
    FDMemTableRFDateInfoROLLFORMERID: TSmallintField;
    FDMemTableRFDateInfoRFINFODATE: TDateField;
    FDMemTableRFDateInfoCARDNUMBER: TWideStringField;
    FDMemTableRFDateInfoORIGINMETERS: TFloatField;
    FDMemTableRFDateInfoREMAINMETERS: TFloatField;
    FDMemTableRFDateInfoRUNSECONDS: TIntegerField;
    FDMemTableRFDateInfoPAUSETIME: TIntegerField;
    FDMemTableRFDateInfoMETERS: TFloatField;
    FDMemTableRFDateInfoSTATUSID: TSmallintField;
    FDMemTableRFDateInfoCUTS: TIntegerField;
    FDMemTableRFDateInfoSWAGE: TIntegerField;
    FDMemTableRFDateInfoNOTCH: TIntegerField;
    FDMemTableRFDateInfoFLAT: TIntegerField;
    FDMemTableRFDateInfoFPUNCH: TIntegerField;
    FDMemTableRFDateInfoRFTYPEID: TSmallintField;
    FDMemTableRFDateInfoSITEID: TSmallintField;
    FDMemTableRFDateInfoADDEDON: TSQLTimeStampField;
    FDMemTableProductionByRollFormerRUNTIME: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDMemTableProductionByRollFormerRUNSECONDSGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure FDMemTableProductionByRollFormerROLLFORMERIDGetText(
      Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FDMemTableProductionByRollFormerCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FStartTime : TDatetime;
    FEndTime   : TDatetime;
    FChart     : TChart;
    procedure SetStartTime(aTime : TDatetime);
    procedure SetEndTime(aTime : TDatetime);
    procedure ProcessDateInfo;
    procedure GetRFDateInfo;
    procedure FDMemTableRFDateInfoMETERSGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  public
    { Public declarations }
    property StartTime   : TDatetime read FStartTime write SetStartTime;
    property EndTime     : TDatetime read FEndTime   write SetEndTime;
  end;

var
  DMRFStatus : TDMRFStatus;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses GlobalU, DateUtils, StrUtils, SplashScreenU, Math, Com_Exception
, Data.FireDACJSONReflect, UnitDMDesignJob;

{$R *.dfm}

procedure TDMRFStatus.FDMemTableRFDateInfoMETERSGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  If AnsiPos(UPPERCASE(Sender.FieldName),'METERSORIGINMETERSREMAINMETERS')>0 then
    Text := FormatFloat('0.##M', Sender.AsFloat)
  else
  If AnsiPos(UPPERCASE(Sender.FieldName),'RUNSECONDSPAUSETIME')>0 then
    Text := Format('%2.2d:%2.2d:%2.2d',[Sender.AsInteger div SecsPerHour, (Sender.AsInteger div SecsPerMin) mod SecsPerMin, Sender.AsInteger mod SecsPerMin]);
end;

procedure TDMRFStatus.ProcessDateInfo;
begin
  FDMemTableProductionByCard.Open;
  FDMemTableProductionByRollFormer.Open;
  FDMemTableProductionByCard.EmptyDataSet;
  FDMemTableProductionByRollFormer.EmptyDataSet;
  FDMemTableRFDateInfo.FieldByName('METERS').OnGetText       := FDMemTableRFDateInfoMETERSGetText;
  FDMemTableRFDateInfo.FieldByName('RUNSECONDS').OnGetText   := FDMemTableRFDateInfoMETERSGetText;
  FDMemTableRFDateInfo.FieldByName('PAUSETIME').OnGetText    := FDMemTableRFDateInfoMETERSGetText;
  FDMemTableRFDateInfo.FieldByName('ORIGINMETERS').OnGetText := FDMemTableRFDateInfoMETERSGetText;
  FDMemTableRFDateInfo.FieldByName('REMAINMETERS').OnGetText := FDMemTableRFDateInfoMETERSGetText;
  FDMemTableRFDateInfo.First;
  with FDMemTableRFDateInfo do
  begin
    while not Eof do
    begin
      if not FDMemTableProductionByRollFormer.FindKey([FieldByName('ROLLFORMERID').AsInteger]) then
      begin
        FDMemTableProductionByRollFormer.Append;
        FDMemTableProductionByRollFormer.FieldByName('ROLLFORMERID').AsInteger := FieldByName('ROLLFORMERID').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('RUNSECONDS').AsInteger   := FieldByName('RUNSECONDS').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('STATUSID').AsInteger     := FieldByName('STATUSID').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('PAUSETIME').AsInteger    := FieldByName('PAUSETIME').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('CUTS').AsInteger         := FieldByName('CUTS').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('SWAGE').AsInteger        := FieldByName('SWAGE').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('NOTCH').AsInteger        := FieldByName('NOTCH').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('FLAT').AsInteger         := FieldByName('FLAT').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('FPUNCH').AsInteger       := FieldByName('FPUNCH').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('METERS').AsInteger       := FieldByName('METERS').AsInteger;
      end
      else
      begin
        FDMemTableProductionByRollFormer.Edit;
        FDMemTableProductionByRollFormer.FieldByName('RUNSECONDS').AsInteger   := FieldByName('RUNSECONDS').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('STATUSID').AsInteger     := FieldByName('STATUSID').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('PAUSETIME').AsInteger    := FDMemTableProductionByRollFormer.FieldByName('PAUSETIME').AsInteger+FieldByName('PAUSETIME').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('CUTS').AsInteger         := FDMemTableProductionByRollFormer.FieldByName('CUTS').AsInteger   + FieldByName('CUTS').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('SWAGE').AsInteger        := FDMemTableProductionByRollFormer.FieldByName('SWAGE').AsInteger  + FieldByName('SWAGE').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('NOTCH').AsInteger        := FDMemTableProductionByRollFormer.FieldByName('NOTCH').AsInteger  + FieldByName('NOTCH').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('FLAT').AsInteger         := FDMemTableProductionByRollFormer.FieldByName('FLAT').AsInteger   + FieldByName('FLAT').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('FPUNCH').AsInteger       := FDMemTableProductionByRollFormer.FieldByName('FPUNCH').AsInteger + FieldByName('FPUNCH').AsInteger;
        FDMemTableProductionByRollFormer.FieldByName('METERS').AsInteger       := FDMemTableProductionByRollFormer.FieldByName('METERS').AsInteger + FieldByName('METERS').AsInteger;
      end;
      FDMemTableProductionByRollFormer.Post;

      if not FDMemTableProductionByCard.FindKey([FieldByName('CARDNUMBER').AsString]) then
      begin
        FDMemTableProductionByCard.Append;
        FDMemTableProductionByCard.FieldByName('CARDNUMBER').AsString  := FieldByName('CARDNUMBER').AsString;
        FDMemTableProductionByCard.FieldByName('ORIGINMETERS').AsFloat := FieldByName('ORIGINMETERS').AsFloat;
        FDMemTableProductionByCard.FieldByName('METERS').AsFloat       := FieldByName('METERS').AsFloat;
        FDMemTableProductionByCard.FieldByName('REMAINMETERS').AsFloat := FieldByName('REMAINMETERS').AsFloat;
      end
      else
      begin
        FDMemTableProductionByCard.Edit;
        FDMemTableProductionByCard.FieldByName('ORIGINMETERS').AsFloat := Max(FDMemTableProductionByCard.FieldByName('ORIGINMETERS').AsFloat, FieldByName('ORIGINMETERS').AsFloat);
        FDMemTableProductionByCard.FieldByName('METERS').AsFloat       := FDMemTableProductionByCard.FieldByName('METERS').AsFloat + FieldByName('METERS').AsFloat;
        FDMemTableProductionByCard.FieldByName('REMAINMETERS').AsFloat := Min(FDMemTableProductionByCard.FieldByName('REMAINMETERS').AsFloat, FieldByName('REMAINMETERS').AsFloat);
      end;
      FDMemTableProductionByCard.Post;
      Next;
    end;
  end;
end;

procedure TDMRFStatus.GetRFDateInfo;
begin
  DMScotServer.GetRFDateInfo(0,1,StartTime,EndTime,FDMemTableRFDateInfo);
  ProcessDateInfo;
end;

procedure TDMRFStatus.DataModuleCreate(Sender: TObject);
begin
  FStartTime := Now-30;
  FEndTime   := Now;
end;

procedure TDMRFStatus.FDMemTableProductionByRollFormerCalcFields(
  DataSet: TDataSet);
begin
  FDMemTableProductionByRollFormerRUNTIME.AsFloat := DataSet.FieldByName('RUNSECONDS').AsInteger/SecsPerHour;
end;

procedure TDMRFStatus.FDMemTableProductionByRollFormerROLLFORMERIDGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := DMDesignJob.GetRollFormerName(Sender.AsInteger);
end;

procedure TDMRFStatus.FDMemTableProductionByRollFormerRUNSECONDSGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := Format('%2.2d:%2.2d:%2.2d',[Sender.AsInteger div SecsPerHour, (Sender.AsInteger div SecsPerMin) mod SecsPerMin, Sender.AsInteger mod SecsPerMin]);
end;

procedure TDMRFStatus.SetStartTime(aTime : TDatetime);
begin
  FStartTime := aTime;
end;

procedure TDMRFStatus.SetEndTime(aTime : TDatetime);
begin
  FEndTime := aTime;
  GetRFDateInfo;
end;

end.
