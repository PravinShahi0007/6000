unit UnitDMLoadEP2Files;

interface

uses
  Windows, System.SysUtils, System.Classes, StrUtils, FrameDataU, GlobalU, DB
  , AdjustForJointsU, Vcl.StdCtrls, ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type

  TDMLoadEP2Files = class(TDataModule)
    FDMemTableEP2FILE: TFDMemTable;
    FDMemTableEP2FILEEP2FILEID: TIntegerField;
    FDMemTableEP2FILEEP2TEXT: TBlobField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    FJob: String;
    FEP2FILE: String;
    FDesign: String;
    FDate: String;
    FItemType: String;
    FSteel: String;
    FFrameCopies: Integer;
    FStartMember: Integer;
    FLastMember: Integer;
    Fep2FilesList   : TStringList;
    FFileStrings    : TStringlist;
    FSteelFrameSelection : TFrameSelection;
    function  AddAllFilesInDir( const StartDir: String ) : Boolean;
    procedure SetProperty(const AProperty, AValue: string);
    procedure AddFrameToFrameSelection(aLines: TStringlist; aJobID : Integer; aSelectedFrames: TFrameList);overload;
    procedure AddFrameToFrameSelection(aLines: TStringlist; aJobID : Integer);overload;
    function  scanFile(aJobID: Integer; aLines: TStringlist): Boolean;
    procedure GetEP2FileBLOB(anEP2FILEID : Integer);

  public
    { Public declarations }
    property  FileStrings : TStringList read FFileStrings;
    procedure LoadEP2Files(const AFilePath: string; const ARollFormerID : Integer);
    procedure LoadSelectedEP2FileFrames(aDataSet : TDataSet);
    function LoadSelectedFrameToProduce(aCDSEP2FILE, aCDSFrame: TDataSet):TSteelFrame;
    procedure LoadAllFrameToProduce(aCDSEP2FILE, aCDSFrame: TDataSet; aListBox : TListBox);
    procedure LoadFrameDetails(aSteelFrame: TSteelFrame; Current, TotalCount : Integer);
    procedure ProcessFile(aLines : TStringList; aFrameSelection : TFrameSelection);
    procedure RestoreFile (aDataSet : TDataSet);overload;
    procedure RestoreFile (aLines: TStringlist);overload;
    procedure ResetFFileStrings;
  end;

var
  DMLoadEP2Files: TDMLoadEP2Files;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses FrameDrawU, WinUtils, SplashScreenU, UnitDMEXPORTFRAME,
  UnitDMEXPORTFRAMEENTITY, UnitDMEXPORTJOB, ScotRFTypes, Variants, ErrorsFormU,
  Dialogs, UnitDMDesignJob, DateUtils, Com_Exception, UnitDMEXPORTEP2FILE,
  Data.FireDACJSONReflect, UnitLocalDBClass, Vcl.Controls, UnitJobFoundForm;

{$REGION 'Import SCS File code'}
const
  IMPORT_DLL_FILENAME = 'SCSImporter.dll';

function ImportSCSFile(sFileName: string): string;
type
  TImportStrucSoftFileTo = function(const AFileName, sImportFolder: string): Integer; stdcall;
var
  Hnd: THandle;
  aProc: TImportStrucSoftFileTo;
  sDir: string;
begin
  Result := '';
  sDir := ScsTempDataPath + 'SCS_2_RF\';
  Hnd := LoadLibrary(IMPORT_DLL_FILENAME);
  if Hnd > 0 then
  begin
    try
      @aProc := GetProcAddress(Hnd, 'ImportStrucSoftFileTo');
      if @aProc <> nil then
      begin
        ForceDirectories(sDir);
        if (aProc(sFileName, sDir) = ERROR_SUCCESS) then
          Result := sDir + ExtractFileName(ChangeFileExt(sFileName, '.txt'))
        else
          MessageDlg('The export process failed', mtError, [mbOK], 0);
      end
      else
        MessageDlg('The export process was not found', mtError, [mbOK], 0);
    finally
      FreeLibrary(Hnd);
    end;
  end
  else
    MessageDlg(IMPORT_DLL_FILENAME + ' was not loaded', mtError, [mbOK], 0);
end;
{$ENDREGION}

procedure TDMLoadEP2Files.DataModuleCreate(Sender: TObject);
begin
  Fep2FilesList   := TStringlist.Create;
  FFileStrings    := TStringlist.Create;
  FSteelFrameSelection := TFrameSelection.Create;
  DMEXPORTJOB         := TDMEXPORTJOB.Create(self);
  DMEXPORTEP2FILE     := TDMEXPORTEP2FILE.Create(self);
  DMEXPORTFRAME       := TDMEXPORTFRAME.Create(self);
  DMEXPORTFRAMEENTITY := TDMEXPORTFRAMEENTITY.Create(self);
end;

procedure TDMLoadEP2Files.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(Fep2FilesList);
  FreeAndNil(FFileStrings);
  FreeAndNil(FSteelFrameSelection);
end;

function  TDMLoadEP2Files.AddAllFilesInDir( const StartDir: String ) : Boolean;
var
  SR: TSearchRec;
begin
  result:=False;
  Fep2FilesList.Clear;
{$IFDEF PANEL}
  if (FindFirst(IncludeTrailingBackslash(StartDir) + '*.ep2', faAnyFile or faDirectory, SR) = 0)
    or (FindFirst(IncludeTrailingBackslash(StartDir) + '*.scs', faAnyFile or faDirectory, SR) = 0) then
{$ELSE}
  if (FindFirst(IncludeTrailingBackslash(StartDir) + '*.tx*', faAnyFile or faDirectory, SR) = 0)
    or (FindFirst(IncludeTrailingBackslash(StartDir) + '*.scs', faAnyFile or faDirectory, SR) = 0) then
{$ENDIF}
  try
    repeat
      if (SR.Attr and faDirectory) = 0 then
      begin
{$IFDEF PANEL}
        If (AnsiPos('.SCS',UPPERCASE(SR.Name))>0) then
        begin
          IF (AnsiPos('6038',UPPERCASE(SR.Name))<=0)
          and(AnsiPos('6050',UPPERCASE(SR.Name))<=0)
          and(AnsiPos('6075',UPPERCASE(SR.Name))<=0) THEN                       //PANEL NAME NOT INCLUDE 6038-6050-6075
            Fep2FilesList.Add(IncludeTrailingBackslash(StartDir) + SR.Name);
        end
        else
          Fep2FilesList.Add(IncludeTrailingBackslash(StartDir) + SR.Name);
        Result := true;
{$ELSE}
        If (AnsiPos('.SCS',UPPERCASE(SR.Name))>0) then
        begin
          IF (AnsiPos('6038',UPPERCASE(SR.Name))>0)
           or(AnsiPos('6050',UPPERCASE(SR.Name))>0)
           or(AnsiPos('6075',UPPERCASE(SR.Name))>0) THEN                        //TRUSS NAME INCLUDE 6038-6050-6075
           begin
            Fep2FilesList.Add(IncludeTrailingBackslash(StartDir) + SR.Name);
            Result := true;
           end;
        end
        else
        BEGIN
          If AnsiPos(UPPERCASE(ExtractFileExt(SR.Name)),'.TX18.TX20.TX22.TX55.TX75.TX95.TX115.SCS')>0 then
          begin
            Fep2FilesList.Add(IncludeTrailingBackslash(StartDir) + SR.Name);
            Result := true;
          end;
        END;
{$ENDIF}
      end
      else if (SR.Name <> '.') and (SR.Name <> '..') then
        AddAllFilesInDir(IncludeTrailingBackslash(StartDir) + SR.Name );  // recursive call!
    until FindNext(Sr) <> 0;
  finally
    FindClose(SR);
  end;
end;

procedure TDMLoadEP2Files.SetProperty(const AProperty, AValue: string);
begin
  if sameText(AProperty,'$Job')    then FJob      := AValue;
  if sameText(AProperty,'$Design') then FDesign   := AValue;
  if sameText(AProperty,'$Date')   then FDate     := AValue;
  if sameText(AProperty,'$Steel')  then FSteel    := AValue;
  if sameText(AProperty,'$Type')   then
  begin
    FItemType := AValue;
    FrameType := AValue;
  end;
end;

procedure TDMLoadEP2Files.ProcessFile(aLines : TStringList; aFrameSelection : TFrameSelection);
begin
  AddFrameToFrameSelection(aLines, 0, aFrameSelection.SelectedFrames);
  aFrameSelection.ProcessFrames;
end;

procedure TDMLoadEP2Files.AddFrameToFrameSelection(aLines: TStringlist; aJobID : Integer; aSelectedFrames: TFrameList);
var
  id: integer;
  aSteelFrame : TSteelFrame;
begin
  if aLines.Count > 3 then
  begin
    id := aSelectedFrames.Count + 1;
    aSteelFrame := TSteelFrame.Create(ALines, id);
    aSteelFrame.JOBID := aJobID;
    aSelectedFrames.Add(aSteelFrame);
  end;
end;

procedure TDMLoadEP2Files.AddFrameToFrameSelection(aLines: TStringlist; aJobID : Integer);
var
  id: integer;
  aSteelFrame : TSteelFrame;
begin
  if aLines.Count > 3 then
  begin
    id := FSteelFrameSelection.SelectedFrames.Count + 1;
    aSteelFrame := TSteelFrame.Create(ALines, id);
    aSteelFrame.JOBID := aJobID;
    FSteelFrameSelection.SelectedFrames.Add(aSteelFrame);
  end;
end;

function LeftStr(const s: string; ASeparator: Char): string;
var
  p: integer;
begin
  p := AnsiPos(ASeparator, s);
  if (p <> 0) then
    result := Copy(s, 1, p - 1)
  else
    result := '';
end;

function RightStr(const s: string; ASeparator: Char): string;
var
  p: integer;
begin
  p := AnsiPos(ASeparator, s);
  if (p <> 0) then
    result := Copy(s, p + 1, maxint)
  else
    result := '';
end;

function  TDMLoadEP2Files.scanFile(aJobID: Integer; aLines: TStringlist): Boolean;
var
  aString: string;
  spaceRemoved : String;
  aStringList: TStringlist;
begin
  aStringList := TStringlist.Create;
  try
    for aString in aLines do
    begin
      spaceRemoved := StringReplace(aString, ' ', '', [rfReplaceAll]);
      if StartsText('$', spaceRemoved) then
      begin
        SetProperty(LeftStr(spaceRemoved, ':'), RightStr(spaceRemoved, ':'));
        continue;
      end;
      if SameText(spaceRemoved, 'inches') and G_Settings.general_metric then
        raise exception.Create('Units do not match .RFS File Settings');
      if SameText(spaceRemoved, 'mm')     and NOT G_Settings.general_metric then
        raise exception.Create('Units do not match .RFS File Settings');
      if (spaceRemoved = 'inches') or (spaceRemoved = 'mm') then
      begin
        AddFrameToFrameSelection(aStringList, aJobID);
        aStringList.clear;
      end;
      aStringList.Add(spaceRemoved);
    end;
    AddFrameToFrameSelection(aStringList, aJobID); // add last frame
  finally
    FreeAndNil(aStringList);
  end;
  result := true;
end;

procedure TDMLoadEP2Files.LoadEP2Files(const AFilePath: string; const ARollFormerID : Integer);
var
  aSteelFrame  : TSteelFrame;
  aString      : String;
  aLoadInfo    : String;
  i            : integer;
  aSelection   : Integer;
  aJob         : TDesignJob;
  aJobID       : Integer;
  aFileName    : String;
  anEXPORTFILE : TEXPORTFILE;
  aRFID        : Integer;
begin
  aJobID := DMDesignJob.TheJobIsAlreadyLoaded(AFilePath);
  if (aJobID>0) then
  begin
    aLoadInfo := DMDesignJob.EP2TransferInformation;
    aRFID     := DMDesignJob.FDMemTableJOBJobAssign.FieldByName('ROLLFORMERID').AsInteger;
    aSelection := TFormJobFound.AJobFound(aLoadInfo);
    case aSelection of
      mrOk     : ;
      mrYes    : begin
                   DMDesignJob.DoTransfer(aRFID, DMDesignJob.ScotRFRollFormerID, ttJob);
                   Exit;
                 end;
      mrIgnore : Exit;
      else
      begin
        Exit;
      end;
    end;
  end;
  ResetFFileStrings;
{$IFDEF PANEL}
  if not AddAllFilesInDir( AFilePath ) then
  begin
    ShowMessage(Format('%s is not a EP2 files folder!',[AFilePath]));
    Exit;
  end;
  aJob := TDesignJob.Create;
  aFileName := Fep2FilesList[0];
  If AnsiPos(UPPERCASE(ExtractFileExt(aFileName)),'EP2')>0 then
  BEGIN
    DecryptAndSave( aFileName );                                                  //<<<<<<
    FFileStrings.LoadFromFile(ScsTempDataPath+'ep2temp.txt');                     //<<<<<<
  END
  ELSE
  If AnsiPos(UPPERCASE(ExtractFileExt(aFileName)),'SCS')>0 then
  BEGIN
    FFileStrings.LoadFromFile( ImportSCSFile(aFileName) );
  END;
  scanFile(0, FFileStrings);                                                    /////////////////////
  if FDesign<>'' then
  begin
    aString          := AFilePath;
    Delete(aString, 1, LastDelimiter('\', aString));
    aJob.DESIGN        := aString;
    aJob.STEEL         := FSteel;
    aJob.ITEMTYPEID    := 0;
    aJob.RFTYPEID      := rfPanel;
    aJob.ITEMTYPE      := FItemType;
    aJob.FRAMECOPIES   := 1;
    aJob.STARTMEMBER   := 1;
    aJob.LASTMEMBER    := MaxInt;
    aJob.FILEPATH      := AFilePath;
    aJob.ROLLFORMERID  := ARollFormerID;
    aJob.TRANSFERTORFID:= ARollFormerID;
  end
  else
  begin
    aString          := AFilePath;
    Delete(aString, 1, LastDelimiter('\', aString));
    aJob.DESIGN      := aString;
    aJob.STEEL       := 'SETUPRF';
    aJob.ITEMTYPEID  := 0;
    aJob.RFTYPEID    := rfPanel;
    aJob.ITEMTYPE    := 'SETUPRF';
    aJob.FRAMECOPIES := 1;
    aJob.STARTMEMBER := 1;
    aJob.LASTMEMBER  := 0;
    aJob.FILEPATH    := AFilePath;
    aJob.ROLLFORMERID:= ARollFormerID;
    aJob.TRANSFERTORFID:= ARollFormerID;
  end;
{$ELSE}
  if not AddAllFilesInDir( AFilePath ) then
  begin
    ShowMessage(Format('%s is not a TX? files folder!',[AFilePath]));
    Exit;
  end;
  aJob := TDesignJob.Create;
  aFileName := Fep2FilesList[0];
  If AnsiPos(UPPERCASE(ExtractFileExt(aFileName)),'SCS')>0 then
  BEGIN
    FFileStrings.LoadFromFile( ImportSCSFile(aFileName) );
  END
  ELSE
  BEGIN
    FFileStrings.LoadFromFile(aFileName);
  END;
  scanFile(0, FFileStrings);
  if FDesign<>'' then
  begin
    aString          := AFilePath;
    Delete(aString, 1, LastDelimiter('\', aString));
    aJob.DESIGN      := aString;
    aJob.STEEL       := FSteel;
    aJob.ITEMTYPEID  := 0;
    aJob.RFTYPEID    := rfTruss;
    aJob.ITEMTYPE    := FItemType;
    aJob.FRAMECOPIES := 1;
    aJob.STARTMEMBER := 1;
    aJob.LASTMEMBER  := MaxInt;
    aJob.FILEPATH    := AFilePath;
    aJob.ROLLFORMERID:= ARollFormerID;
    aJob.TRANSFERTORFID:= ARollFormerID;
  end
  else
  begin
    aString          := AFilePath;
    Delete(aString, 1, LastDelimiter('\', aString));
    aJob.DESIGN      := ExtractFileName(AFilePath);
    aJob.STEEL       := 'Unknown';
    aJob.ITEMTYPEID  := 1;
    aJob.RFTYPEID    := rfTruss;
    aJob.ITEMTYPE    := 'TRUSS(F)';
    aJob.FRAMECOPIES := 1;
    aJob.STARTMEMBER := 1;
    aJob.LASTMEMBER  := MaxInt;
    aJob.FILEPATH    := AFilePath;
    aJob.ROLLFORMERID:= ARollFormerID;
    aJob.TRANSFERTORFID:= ARollFormerID;
  end;
{$ENDIF}
  if not assigned(DMEXPORTJOB) then
    DMEXPORTJOB := TDMEXPORTJOB.Create(Self);
  DMEXPORTJOB.AddData( aJob );
{$IFDEF PANEL}
  ShowSplashscreen('Loading RF Export EP2 Files', 'PanelLogo');
{$ELSE}
  ShowSplashscreen('Loading RF Export EP2 Files','TrussLogo');
{$ENDIF}
  try
    for i := 0 to Fep2FilesList.Count-1 do
    begin
      try
      anEXPORTFILE := TEXPORTFILE.Create;
      anEXPORTFILE.EXPORTFILE   := Fep2FilesList[i];
      anEXPORTFILE.SITEID       := 1;
      anEXPORTFILE.ROLLFORMERID := ARollFormerID;
      anEXPORTFILE.TRANSFERTORFID := ARollFormerID;
{$IFDEF PANEL}
      If AnsiPos(UPPERCASE(ExtractFileExt(aFileName)),'.SCS')>0 then
      BEGIN
        anEXPORTFILE.EXPORTTEXT := ImportSCSFile(Fep2FilesList[i]);
      END
      ELSE
      BEGIN
        DecryptAndSave( anEXPORTFILE.EXPORTFILE );                                //**
        anEXPORTFILE.EXPORTTEXT := ScsTempDataPath+'ep2temp.txt';
      END;
      FFileStrings.LoadFromFile(anEXPORTFILE.EXPORTTEXT);                 //**
{$ELSE}
      If AnsiPos(UPPERCASE(ExtractFileExt(aFileName)),'.SCS')>0 then
        anEXPORTFILE.EXPORTTEXT := ImportSCSFile(Fep2FilesList[i])
      ELSE
        anEXPORTFILE.EXPORTTEXT := Fep2FilesList[i];
      FFileStrings.LoadFromFile(anEXPORTFILE.EXPORTTEXT);
{$ENDIF}
      anEXPORTFILE.JOBID   := DMEXPORTJOB.GetNewRecordID;
      if not assigned(DMEXPORTEP2FILE) then
        DMEXPORTEP2FILE := TDMEXPORTEP2FILE.Create(Self);
      DMEXPORTEP2FILE.AddData(anEXPORTFILE);                                    //Save Blob
      except
        On E: Exception do
          HandleException(e,'TDMLoadEP2Files.LoadEP2Files',[]);
      end;
      ShowSplashScreenMessage( Format('%s', [anEXPORTFILE.EXPORTFILE]));
    end;
  finally
    FreeAndNil(aJob);
    FreeAndNIl(anEXPORTFILE);
    HideSplashscreen;
  end;
end;

procedure TDMLoadEP2Files.LoadFrameDetails(aSteelFrame: TSteelFrame; Current, TotalCount : Integer);
var
  i : Integer;
begin
  for  i := 0 to Length(aSteelFrame.Entity)-1 do
  begin
    if (aSteelFrame.Entity[i].Truss='') or (aSteelFrame.Entity[i].Item='') then
      break;
    try
      aSteelFrame.Entity[i].FrameID := aSteelFrame.FrameID;
      aSteelFrame.Entity[i].ID      := i+1;
      aSteelFrame.Entity[i].JOBID   := aSteelFrame.JOBID;
      aSteelFrame.Entity[i].EP2FILEID   := aSteelFrame.EP2FILEID;
      ShowSplashScreenMessage( Format('Total Frames:%d, Current Processing:%d, %s(%d), %s(%d)'
                                    , [TotalCount
                                      ,Current
                                      ,aSteelFrame.Entity[i].Truss
                                      ,Length(aSteelFrame.Entity)
                                      ,aSteelFrame.Entity[i].Item, i]));
      DMEXPORTFRAMEENTITY.AddEntity(aSteelFrame.Entity[i]);
    except
      on E: Exception do
        HandleException(e,'TDMLoadEP2Files.LoadFrameDetails',[]);
    end;
  end;
  DMEXPORTFRAMEENTITY.ApplyUpdates;
end;

procedure TDMLoadEP2Files.LoadSelectedEP2FileFrames(aDataSet : TDataSet);
var
  i : Integer;
  aRecordCount : Integer;
begin
  aRecordCount := DMDesignJob.FDMemTableFrame.RecordCount;
  IF aRecordCount <1 THEN
  begin
    ShowSplashscreen('Loading ' + aDataSet.FieldByName('EP2FILE').AsString, 'PanelLogo');
    RestoreFile(DMDesignJob.FDMemTableEP2FILE);
    FrameType  := FItemType;
    for I := 0 to FSteelFrameSelection.SelectedFrames.Count-1 do
    begin
      Try
        FSteelFrameSelection.SelectedFrames[i].EP2FILEID := aDataSet.FieldByName('EP2FILEID').AsInteger;
        FSteelFrameSelection.SelectedFrames[i].EP2FILE   := aDataSet.FieldByName('EP2FILE').AsString;
        DMEXPORTFRAME.AddData(FSteelFrameSelection.SelectedFrames[i]);                                              //steven today
        DMEXPORTFRAME.ApplyUpdates;
        FSteelFrameSelection.SelectedFrames[i].FrameID := DMEXPORTFRAME.GetNewRecordID;                             //
        LoadFrameDetails(FSteelFrameSelection.SelectedFrames[i], I+1, FSteelFrameSelection.SelectedFrames.Count);   //
      except
        On E: Exception do
          HandleException(E,'TDMLoadEP2Files.LoadSelectedEP2FileFrames',[]);
      End;
    end;
  end;
  HideSplashscreen;
  If DMScotServer.IsDashboard then
    DMDesignJob.ResetFilter('0');
  DMDesignJob.GetFrame;
  DMDesignJob.GetFrameEntity;
end;

procedure TDMLoadEP2Files.LoadAllFrameToProduce(aCDSEP2FILE, aCDSFrame: TDataSet; aListBox : TListBox);
var
  i : Integer;
begin
  For i := 0 to FSteelFrameSelection.SelectedFrames.Count-1 do
    aListBox.Items.AddObject(Format('%s %5d',[ FSteelFrameSelection.SelectedFrames[i].FrameName
                                              ,FSteelFrameSelection.SelectedFrames[i].NumberOfFrames])
                                              ,FSteelFrameSelection.SelectedFrames[i]);
end;

function TDMLoadEP2Files.LoadSelectedFrameToProduce(aCDSEP2FILE, aCDSFrame: TDataSet):TSteelFrame;
var
  i : Integer;
begin
  result := nil;
  For I := 0 to FSteelFrameSelection.SelectedFrames.Count - 1 do
  begin
    if FSteelFrameSelection.SelectedFrames[i].FrameName = aCDSFrame.FieldByName('FrameName').AsString then
    begin
      FSteelFrameSelection.SelectedFrames[i].EP2FILEID := aCDSEP2FILE.FieldByName('EP2FILEID').AsInteger;
      FSteelFrameSelection.SelectedFrames[i].EP2FILE   := aCDSEP2FILE.FieldByName('EP2FILE').AsString;
      FSteelFrameSelection.SelectedFrames[i].FrameID   := aCDSFrame.FieldByName('FrameID').AsInteger;
      FSteelFrameSelection.SelectedFrames[i].Status    := aCDSFrame.FieldByName('StatusID').AsInteger;
      Result := FSteelFrameSelection.SelectedFrames[i];
      Exit;
    end;
  end;
end;

procedure TDMLoadEP2Files.ResetFFileStrings;
begin
  if Assigned(Self) then
    FFileStrings.Clear;
end;

procedure TDMLoadEP2Files.GetEP2FileBLOB(anEP2FILEID : Integer);
begin
  DMScotServer.GetEP2FileBLOB(anEP2FILEID,FDMemTableEP2FILE);
end;

procedure TDMLoadEP2Files.RestoreFile(aDataSet : TDataSet);
var
  aBlob : TStream;
begin
  FSteelFrameSelection.ResetSelectedFrames;
  GetEP2FileBLOB(aDataSet.FieldByName('EP2FILEID').AsInteger);
  aBlob := aDataSet.CreateBlobStream(FDMemTableEP2FILE.FieldByName('EP2TEXT'), bmRead);
  try
    aBlob.Seek(0, soFromBeginning);
    FFileStrings.LoadFromStream(aBlob);
  finally
    aBlob.Free ;
  end;
  If ScanFile(aDataSet.FieldByName('JOBID').AsInteger, FFileStrings) then
  Begin
    FrameType  := FItemType;
    FSteelFrameSelection.ProcessFrames;
  End;
end;

procedure TDMLoadEP2Files.RestoreFile (aLines: TStringlist);
begin
  FFileStrings.AddStrings(aLines);
end;

end.
