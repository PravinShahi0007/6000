unit UnitJobTransferForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, UnitDMDesignJob, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type

  TFormJobTransfer = class(TForm)
    PanelButtons: TPanel;
    ButtonCancel: TButton;
    ButtonOk: TButton;
    DBGridRollFormer: TDBGrid;
    FDMemTableRollFormer: TFDMemTable;
    DataSourceRollFormer: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FDMemTableRollFormerFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
  private
    { Private declarations }
    procedure GetROLLFORMER;
  public
    { Public declarations }
    class procedure TransferAJobToOtherMachine( const aRollFormerID : Integer; aTransferType : TTransferType );
    procedure DoTransfer( aRollFormerID : Integer; aTransferType : TTransferType );
  end;

var
  FormJobTransfer: TFormJobTransfer;

implementation

{$R *.dfm}

uses ScotRFTypes, FrameDataU, UnitDMJobTransfer, Data.FireDACJSONReflect
, Com_Exception;

procedure TFormJobTransfer.GetROLLFORMER;
begin
  DMScotServer.GetRollFormer(0, 1, 0, Now,FDMemTableRollFormer);
end;

procedure TFormJobTransfer.FDMemTableRollFormerFilterRecord(
  DataSet: TDataSet; var Accept: Boolean);
var
  aFromRollFormerID   : Integer;
  aJOBTRANSFERTORFID1 : Integer;
  aJOBTRANSFERTORFID2 : Integer;
  aJOBTRANSFERTORFID3 : Integer;
  aJOBTRANSFERTORFID4 : Integer;
  aJOBTRANSFERTORFID5 : Integer;
  aJOBTRANSFERTORFID6 : Integer;
begin
  If DMScotServer.IsDashboard then
  begin
    aFromRollFormerID := DMDesignJob.FDMemTableJOBROLLFORMERID.AsInteger;
  end
  else
  begin
    aFromRollFormerID := DMDesignJob.ScotRFRollFormerID;
  end;
  aJOBTRANSFERTORFID1 := DMDesignJob.FDMemTableJOBTRANSFERTORFID1.AsInteger;
  aJOBTRANSFERTORFID2 := DMDesignJob.FDMemTableJOBTRANSFERTORFID2.AsInteger;
  aJOBTRANSFERTORFID3 := DMDesignJob.FDMemTableJOBTRANSFERTORFID3.AsInteger;
  aJOBTRANSFERTORFID4 := DMDesignJob.FDMemTableJOBTRANSFERTORFID4.AsInteger;
  aJOBTRANSFERTORFID5 := DMDesignJob.FDMemTableJOBTRANSFERTORFID5.AsInteger;
  aJOBTRANSFERTORFID6 := DMDesignJob.FDMemTableJOBTRANSFERTORFID6.AsInteger;
  Accept :=            ( FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsInteger <> aFromRollFormerID);
  Accept := Accept and ( FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsInteger <> aJOBTRANSFERTORFID1 );
  Accept := Accept and ( FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsInteger <> aJOBTRANSFERTORFID2 );
  Accept := Accept and ( FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsInteger <> aJOBTRANSFERTORFID3 );
  Accept := Accept and ( FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsInteger <> aJOBTRANSFERTORFID4 );
  Accept := Accept and ( FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsInteger <> aJOBTRANSFERTORFID5 );
  Accept := Accept and ( FDMemTableRollFormer.FieldByName('ROLLFORMERID').AsInteger <> aJOBTRANSFERTORFID6 );
end;

procedure TFormJobTransfer.FormCreate(Sender: TObject);
begin
  GetROLLFORMER;
  Caption := Format('Assign job from %s to the Selected Machine',[G_Settings.general_MachineName]);
  DBGridRollFormer.Columns[0].Title.Caption := Format('Assign job %s to the selected machine',[DMDesignJob.FDMemTableJOBDESIGN.AsString])
end;

class procedure TFormJobTransfer.TransferAJobToOtherMachine( const aRollFormerID : Integer; aTransferType : TTransferType );
var
  aJobTransfer : TFormJobTransfer;
  SelectedButton : Integer;
begin
  aJobTransfer := TFormJobTransfer.Create(nil);
  try
    if aRollFormerID=0 then
    begin
      aJobTransfer.FDMemTableRollFormer.Filtered := False;
    end
    else
    begin
      aJobTransfer.FDMemTableRollFormer.Filtered := False;
      aJobTransfer.FDMemTableRollFormer.Filtered := True;
    end;
    if aJobTransfer.ShowModal = mrOk then
    begin
      SelectedButton := messagedlg( Format('Assign %s to %s'
                                          ,[  DMDesignJob.FDMemTableJOBDESIGN.AsString
                                            , aJobTransfer.FDMemTableRollFormer.FieldByName('Name').AsString ])
                                  , mtCustom, [mbYes,mbNo], 0);   //yes-6 no-7
      if SelectedButton = 6 then
        aJobTransfer.DoTransfer(aRollFormerID, aTransferType);
    end;
  finally
    FreeAndNil(aJobTransfer);
  end;
end;

procedure TFormJobTransfer.DoTransfer( aRollFormerID : Integer; aTransferType : TTransferType );
var
  aJobTransfer : TJOBTRANSFER;
  aDMJobTransfer : TDMJobTransfer;
begin
  aDMJobTransfer := TDMJobTransfer.Create(nil);
  try
    aJobTransfer                  := TJOBTRANSFER.Create;
    case aTransferType of
      ttJob       : begin
                      aJobTransfer.JOBID            := DMDesignJob.FDMemTableJOBJOBID.AsInteger;
                      aJobTransfer.EP2FILEID        := 0;
                      aJobTransfer.FRAMEID          := 0;
                      aJobTransfer.FRAMEENTITYID    := 0;
                    end;
      ttEP2TXT    : begin
                      aJobTransfer.JOBID            := 0;
                      aJobTransfer.EP2FILEID        := DMDesignJob.FDMemTableEP2FILEEP2FILEID.AsInteger;
                      aJobTransfer.FRAMEID          := 0;
                      aJobTransfer.FRAMEENTITYID    := 0;
                    end;
      ttFrame     : begin
                      aJobTransfer.JOBID            := 0;
                      aJobTransfer.EP2FILEID        := 0;
                      aJobTransfer.FRAMEID          := DMDesignJob.FDMemTableFRAMEFRAMEID.AsInteger;
                      aJobTransfer.FRAMEENTITYID    := 0;
                    end;
      ttFrameItem : begin
                      aJobTransfer.JOBID            := 0;
                      aJobTransfer.EP2FILEID        := 0;
                      aJobTransfer.FRAMEID          := 0;
                      aJobTransfer.FRAMEENTITYID    := DMDesignJob.FDMemTableFrameEntityFRAMEENTITYID.AsInteger;
                    end;
    end;
    aJobTransfer.FROMROLLFORMERID := aRollFormerID;
    aJobTransfer.TOROLLFORMERID   := FDMemTableRollFormer.FieldByName('RollFormerID').AsInteger;
    aJobTransfer.STATUSID         := 0;
    aJobTransfer.SITEID           := 1;
    if aJobTransfer.FROMROLLFORMERID=0 then
    begin
      DMDesignJob.DoAssignTo(aJobTransfer.TOROLLFORMERID);
    end
    else
    begin
      aDMJobTransfer.AddData(aJobTransfer);
      DMDesignJob.DoTransfer(aJobTransfer.FROMROLLFORMERID, aJobTransfer.TOROLLFORMERID, aTransferType);
      DMDesignJob.FDMemTableRollFormer.Filter := '';
      DMDesignJob.FDMemTableRollFormer.Filtered := False;
    end;
    DMDesignJob.RefreshData(nil);
  finally
    FreeAndNil(aDMJobTransfer);
  end;
end;

end.
