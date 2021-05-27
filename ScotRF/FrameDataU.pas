unit FrameDataU;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Dialogs, Mk2ErrorsFormU,
  generics.collections, generics.Defaults, GlobalU, ScotRFTypes, winUtils,
  Datasnap.DBClient, UnitDMRollFormer, DB;

type
  TSteelFrame = class;
  TItemProcess   = reference to procedure(anEntityPointer: pEntityRecType);
  TProcessFilter = reference to function(AFrame: TSteelFrame; anEntityPointer: pEntityRecType): Boolean;
  TGetItemColor = Function(AFrame: TSteelFrame; p:pEntityRecType): TColor of object;


  TEntitys = Array of EntityRecType;

  TThingsType = (ttNone, ttFlangeHole, ttLipHole);

  TRollFormer = class(TObject)
  private
    FRFNAME       : String;
    FDESCRIPTION  : String;
    FRFPROGRAM    : String;
    FVERSION      : String;
    FCODE         : String;
    FPRODUCTION   : Double;
    FRFTYPEID     : Smallint;
    FSTATUSID     : Smallint;
    FSITEID       : Integer;
  public
    Property RFNAME       : String   Read FRFNAME      write FRFNAME;
    Property DESCRIPTION  : String   Read FDESCRIPTION write FDESCRIPTION;
    Property RFPROGRAM    : String   Read FRFPROGRAM   write FRFPROGRAM;
    Property VERSION      : String   Read FVERSION     write FVERSION;
    Property CODE         : String   Read FCODE        write FCODE;
    Property PRODUCTION   : Double   Read FPRODUCTION  write FPRODUCTION;
    Property RFTYPEID     : Smallint Read FRFTYPEID    write FRFTYPEID;
    Property STATUSID     : Smallint Read FSTATUSID    write FSTATUSID;
    Property SITEID       : Integer  Read FSITEID      write FSITEID;
  end;

  TDesignJob = class(TObject)
  private
    FDESIGN         : String;
    FSTEEL          : String;
    FITEMTYPEID     : Integer;
    FRFTYPEID       : TRFType;
    FITEMTYPE       : String;
    FFRAMECOPIES    : Integer;
    FSTARTMEMBER    : Integer;
    FLASTMEMBER     : Integer;
    FFILEPATH       : String;
    FROLLFORMERID   : Integer;
    FTRANSFERTORFID : Integer;
  public
    Property DESIGN         : String  read FDESIGN write FDESIGN;
    Property STEEL          : String  read FSTEEL write FSTEEL;
    Property ITEMTYPEID     : Integer read FITEMTYPEID write FITEMTYPEID;
    Property RFTYPEID       : TRFType read FRFTYPEID write FRFTYPEID;
    Property ITEMTYPE       : String  read FITEMTYPE write FITEMTYPE;
    Property FRAMECOPIES    : Integer read FFRAMECOPIES write FFRAMECOPIES;
    Property STARTMEMBER    : Integer read FSTARTMEMBER write FSTARTMEMBER;
    Property LASTMEMBER     : Integer read FLASTMEMBER write FLASTMEMBER;
    Property FILEPATH       : String  read FFILEPATH write FFILEPATH;
    Property ROLLFORMERID   : Integer read FROLLFORMERID write FROLLFORMERID;
    Property TRANSFERTORFID : Integer read FTRANSFERTORFID write FTRANSFERTORFID;
  end;

  TSteelFrame = class(TObject)
  private
    FFrameName     : String;
    FFrameID       : Integer;
    FLines         : TStringList;
    FMinHoleDist   : Double;
    FProfileHeight : Double;
    FPreCamber     : Double;
    FEP2FILEID     : Integer;
    FEP2FILE       : String;
    FJOBID         : Integer;
    FStatus        : Integer;
    procedure ResetOrigin;
    procedure SortEntities;
    function  ReadStructure: Integer;
    function  FindItemIndex(ecode: String): Integer;
    procedure GetFrameExtent;
    procedure AddOperation(AItemIndex: Integer; AOperation: String; xhole, yhole: Real);
    procedure AddSimcutStrings(SL: TStrings);
    procedure SetItemIDs;
  protected
    FItemCount     : Integer;
    FEntity        : TEntitys;
    {$IFDEF TRUSS}
    BCXmin: Double; // for span
    BCXmax: Double; // for span
    ChordYMin: Double; // for height
    ChordYMax: Double; // for height
    {$ELSE}
    PlateYMin: Double; // for height
    PlateYMax: Double; // for height
    {$ENDIF}
    FNumberOfFrames : Integer;
    FTEKSCREWS      : Integer;
    FSPACERS        : Integer;
    FRFTYPEID       : TRFType;
    FSITEID         : Integer;
    FROLLFORMERID   : Integer;
    FTRANSFERTORFID : Integer;

    FCanvasRect     : TRect;
    FCanvas         : TCanvas;
    FOnGetColour    : TGetItemColor;

    FOrigin         : Point2D; // 2D point at image centre
    FRectCentre     : TPoint; // image centre
    FScale          : Double;

    procedure InitCanvas;
    procedure SetScaleAndOrigin;

    procedure SetFont(AColor:TColor=clblack; ASize:integer=8; AStyle: TFontStyles=[]); overload;
    procedure SetFont(AColor:TColor; AStyle: TFontStyles=[]); overload;
    function  Client2Screen(Pt: Point2D): TPoint;
    Function  GetEntityPoints(Ent: pEntityRecType): RectType;
    procedure DrawItem(p: pEntityRecType);
    procedure DrawOperations(pEnt: pEntityRecType);
    procedure LineOut(AP1, AP2: Point2D);
    procedure TextOut(s: string; APt: Point2D);

    procedure TextOutAtP(APt: Point2D; Caption: string; dy: integer);
    procedure Circle(APt: Point2D; ARadius: integer; AColor: TColor);
    procedure Square(APt: Point2D; ARadius: integer; AColor: TColor);
    procedure SquareUnder(APt: Point2D; ARadius: integer; AColor: TColor);

  public
    xMin : Double;
    xMax : Double;
    yMin : Double;
    YMax : Double;
    FConnectionCount : Integer;       // from AdjustForJoints
    FConnectors      : Integer;            // from operations queue
    FrameErrors      : TStringlist;
    constructor Create(ALines: TStringlist; AID: integer);overload;
    constructor Create(aFrameCDS, aEntityCDS : TDataset);overload;
    destructor  Destroy; override;
    function MaterialLength: double;
    function  ProcessFrame: Integer;
    procedure ForEachItem(proc: TItemProcess);
    procedure DrawSteelFrame(aCanvas : TCanvas);
    property FrameID        : integer  read FFrameID        write FFrameID;
    property FrameName      : string   read FFrameName      write FFrameName;
    property PreCamber      : double   read FPreCamber      write FPreCamber;
    property MinHoleDist    : double   read FMinHoleDist    write FMinHoleDist;
    property ProfileHeight  : double   read FProfileHeight  write FProfileHeight;
    property ItemCount      : integer  read FItemCount      write FItemCount;
    property EP2FILEID      : Integer  read FEP2FILEID      write FEP2FILEID;
    property EP2FILE        : string   read FEP2FILE        write FEP2FILE;
    property JOBID          : Integer  read FJOBID          write FJOBID;
    property Entity         : TEntitys read FEntity         write FEntity;
    property Status         : Integer  read FStatus         write FStatus;
    property NumberOfFrames : Integer  READ FNumberOfFrames write FNumberOfFrames;
    property TEKSCREWS      : Integer  READ FTEKSCREWS;
    property SPACERS        : Integer  READ FSPACERS;
    property RFTYPEID       : TRFType  READ FRFTYPEID;
    property SITEID         : Integer  READ FSITEID;
    property ROLLFORMERID   : Integer  READ FROLLFORMERID;
    Property TRANSFERTORFID : Integer  read FTRANSFERTORFID write FTRANSFERTORFID;
  end;

  TFrameList = class(TObjectList<TSteelFrame>)
  public
    function Find(const APredicate: TPredicate<TSteelFrame>): TSteelFrame;
  end;

  TFrameSelection = class(TObject)
  private
    FFileExtension  : String;
    FEP2File : String;
    FJob: String;
    FDesign: String;
    FDate: String;
    FItemType: String;
    FSteel: String;
    FFrameCopies: Integer;
    FStartMember: Integer;
    FLastMember: Integer;
    function GetFrameCount: Integer;
    function ProcessFrames(aFrames: TFrameList): boolean;overload;
  protected
    FSelectedFrames: TFrameList;
  public
    GroupItems  : Boolean;
    constructor Create;
    destructor Destroy; override;
    procedure SaveEntities;
    procedure FramesGridsJobSelection;
    procedure ResetSelectedFrames;
    function ProcessFrames: boolean;overload;
    property FrameCount: integer read getFrameCount;
    property Job: string read FJob;
    property Design: string read FDesign;
    property Steel: string read FSteel;
    property ItemType: string read FItemType;
    property Copies: integer read FFrameCopies write FFrameCopies;
    property StartMember: Integer read FStartMember write FStartMember;
    property LastMember: Integer read FLastMember write FLastMember;
    property SelectedFrames: TFrameList read FSelectedFrames;
    property EP2File : String read FEP2File write FEP2File;
  end;

  TEventAudit = class(TObject)
  private
    FEVENTTYPE    : TRFEventType;
    FEVENT        : String;
    FSITEID       : SmallInt;
    FROLLFORMERID : SmallInt;
    FCARDNUMBER   : String;
    FREMAINMETERS : Double;
    FDATETIME     : TDATETIME;
  public
    property EVENTTYPE    : TRFEventType read FEVENTTYPE write FEVENTTYPE;
    property EVENT        : String    read FEVENT write FEVENT;
    property SITEID       : SmallInt  read FSITEID write FSITEID;
    property ROLLFORMERID : SmallInt  read FROLLFORMERID write FROLLFORMERID;
    property CARDNUMBER   : String    read FCARDNUMBER write FCARDNUMBER;
    property REMAINMETERS : Double    read FREMAINMETERS write FREMAINMETERS;
    property DATETIME     : TDATETIME read FDATETIME write FDATETIME;
  end;

  TEXPORTFILE = class(TObject)
  private
    FEXPORTFILE   : String;
    FEXPORTTEXT   : String;
    FSITEID       : SmallInt;
    FJOBID        : SmallInt;
    FTRANSFERTORFID : Integer;
    FROLLFORMERID   : Integer;
  public
    property EXPORTFILE   : String   read FEXPORTFILE write FEXPORTFILE;
    property EXPORTTEXT   : String   read FEXPORTTEXT write FEXPORTTEXT;
    property SITEID       : SmallInt read FSITEID     write FSITEID;
    property JOBID        : SmallInt read FJOBID      write FJOBID;
    Property ROLLFORMERID   : Integer read FROLLFORMERID   write FROLLFORMERID;
    Property TRANSFERTORFID : Integer read FTRANSFERTORFID write FTRANSFERTORFID;
  end;

  TRFDateInfo = class(TObject)
  private
    FRFINFODATE   : TDate;
    FROLLFORMERID : SmallInt;
    FCARDNUMBER   : String;
    FRUNTIME      : Integer;
    FPAUSETIME    : Integer;
    FMETERS       : Double;
    FREMAINMETERS : Double;
    FORIGINMETERS : Double;
    FCUTS         : Integer;
    FFSWAGE       : Integer;
    FNOTCH        : Integer;
    FFLAT         : Integer;
    FFPUNCH       : Integer;
    FSTATUSID     : Integer;
    FSITEID       : Integer;
    FStartTime    : TDatetime;
    FStartPause   : TDatetime;
  public
    Constructor Create;
    procedure Init;
    Property RFINFODATE   : TDate read FRFINFODATE write FRFINFODATE;
    Property ROLLFORMERID : SmallInt read FROLLFORMERID write FROLLFORMERID;
    Property CARDNUMBER   : String  read FCARDNUMBER write FCARDNUMBER;
    Property ORIGINMETERS : Double  read FORIGINMETERS write FORIGINMETERS;
    Property REMAINMETERS : Double  read FREMAINMETERS write FREMAINMETERS;
    Property RUNTIME      : Integer read FRUNTIME write FRUNTIME;
    Property PAUSETIME    : Integer read FPAUSETIME write FPAUSETIME;
    Property METERS       : Double  read FMETERS write FMETERS;
    Property CUTS         : Integer read FCUTS write FCUTS;
    Property FSWAGE       : Integer read FFSWAGE write FFSWAGE;
    Property NOTCH        : Integer read FNOTCH write FNOTCH;
    Property FLAT         : Integer read FFLAT write FFLAT;
    Property FPUNCH       : Integer read FFPUNCH write FFPUNCH;
    Property STATUSID     : Integer read FSTATUSID write FSTATUSID;
    Property SITEID       : Integer read FSITEID write FSITEID;
    Property StartTime    : TDatetime read FStartTime write FStartTime;
    Property StartPause   : TDatetime read FStartPause  write FStartPause;
  end;

  TTHINGSONENTITY = class(TObject)
  private
    FThings         : TThingsType;
    FKind           : TOpKind;
    FPOINTX         : Double;
    FPOINTY         : Double;
    FNUM            : WORD;
    FPOSITION       : DOUBLE;
    FFRAMEID        : Integer;
    FFRAMEENTITYID  : Integer;
  public
    property Things   : TThingsType   read FThings        write FThings;
    property Kind     : TOpKind       read FKind          write FKind;
    property POINTX   : Double        read FPOINTX        write FPOINTX;
    property POINTY   : Double        read FPOINTY        write FPOINTY;
    property NUM      : WORD          read FNUM           write FNUM;
    property POSITION : DOUBLE        read FPOSITION      write FPOSITION;
    property FRAMEID  : Integer       read FFRAMEID       write FFRAMEID;
    property FRAMEENTITYID : Integer  read FFRAMEENTITYID write FFRAMEENTITYID;
  end;

  TJOBDETAIL = Class(TObject)
  private
    FJOBID     : Integer;
    FEP2FILEID : Integer;
    FFRAMEID   : Integer;
    FDESIGN    : String;
    FSTEEL     : String;
    FOPERATOR  : String;
    FRIVERTER  : String;
    FCOILID    : String;
    FGAUGE     : String;
    FWEIGHT    : String;
  public
    Property JOBID     : Integer read FJOBID write FJOBID;
    Property EP2FILEID : Integer read FEP2FILEID write FEP2FILEID;
    Property FRAMEID   : Integer read FFRAMEID write FFRAMEID;
    Property DESIGN    : String read FDESIGN write FDESIGN;
    Property STEEL     : String read FSTEEL write FSTEEL;
    Property WORKER    : String read FOPERATOR write FOPERATOR;
    Property RIVERTER  : String read FRIVERTER write FRIVERTER;
    Property COILID    : String read FCOILID write FCOILID;
    Property GAUGE     : String read FGAUGE write FGAUGE;
    Property WEIGHT    : String read FWEIGHT write FWEIGHT;
  End;

  TJOBTRANSFER = Class(TObject)
  private
    FJOBID            : Integer;
    FEP2FILEID        : Integer;
    FFRAMEID          : Integer;
    FFRAMEENTITYID    : Integer;
    FFROMROLLFORMERID : Integer;
    FTOROLLFORMERID   : Integer;
    FSTATUSID         : Integer;
    FSITEID           : Integer;
  public
    Constructor Create;
    Property JOBID            : Integer read FJOBID write FJOBID;
    Property EP2FILEID        : Integer read FEP2FILEID write FEP2FILEID;
    Property FRAMEID          : Integer read FFRAMEID write FFRAMEID;
    Property FRAMEENTITYID    : Integer read FFRAMEENTITYID write FFRAMEENTITYID;
    Property FROMROLLFORMERID : Integer read FFROMROLLFORMERID write FFROMROLLFORMERID;
    Property TOROLLFORMERID   : Integer read FTOROLLFORMERID write FTOROLLFORMERID;
    Property STATUSID         : Integer read FSTATUSID write FSTATUSID;
    Property SITEID           : Integer read FSITEID write FSITEID;
  End;

Procedure FreeList(List: TFrameList);
function isReportableError(ErrNum: Integer): boolean;

Var
 FJobDetail     : TJOBDETAIL;
 FRFDateInfo    : TRFDateInfo;
 FrameToProduce : TFrameSelection;

implementation

uses
  strUtils, DCPBlowfish, DCPSha1, zLib, math, printers, errorsFormU,
  UnitDMTemplate, UnitDMEXPORTJOB, com_exception,
  AdjustForJointsU, Usettings, UtilsU, FrameDrawU, ItemTypeSelectionU,
  UnitDMEXPORTFRAME, UnitDMEXPORTFRAMEENTITY,
  SplashScreenU, UnitJobSelection, UnitDMDesignJob;

Constructor TJOBTRANSFER.Create;
Begin
  FJOBID            := 0;
  FEP2FILEID        := 0;
  FFRAMEID          := 0;
  FFRAMEENTITYID    := 0;
  FFROMROLLFORMERID := 0;
  FTOROLLFORMERID   := 0;
  FSTATUSID         := 0;
  FSITEID           := 0;
End;

Constructor TRFDateInfo.Create;
begin
  inherited;
  Init;
  FStartTime    := Now;
  FStartPause   := Now;
end;

procedure TRFDateInfo.Init;
begin
  FRFINFODATE   := Trunc(Now);
  FROLLFORMERID := DMSCOTRFID.ScotRFRollFormerID;
  FCARDNUMBER   := Trim(CurrentCARDNUMBER);
  FRUNTIME      := 0;
  FPAUSETIME    := 0;
  FMETERS       := 0;
  FORIGINMETERS := GREMAINMETERS;
  FREMAINMETERS := GREMAINMETERS;
  FCUTS         := 0;
  FFSWAGE       := 0;
  FNOTCH        := 0;
  FFLAT         := 0;
  FFPUNCH       := 0;
  FSTATUSID     := 0;
  FSITEID       := StrToInt(SITE_ID);
end;

procedure FreeList(List: TFrameList);
begin
  if (List = nil) then
    Exit;
  List.Clear;
end;

function PerpDistance(x1, y1, x2, y2, x, y: double): double; forward;

function isReportableError(ErrNum: Integer): boolean;
begin
  result := (ErrNum < 0)and (ErrNum >= RESULT_HOLE_ERR);
end;

function AdjustJointsErrorAsString(ErrNum: Integer):String;
begin
  Result := '';
  case ErrNum of
    RESULT_NOT_FOUND:       Result := 'Min End Distance error';
    RESULT_NOT_INITIALISED: Result := 'DLL not initialised';
    RESULT_LIP_LT_FLG:      Result := 'Lip Hole Height is less than Flg Hole Height';
    RESULT_HOLE_ERR:        Result := 'Hole error';
    RESULT_RANGE_ERR:       Result := 'Range error';
    RESULT_ADDED_COPE_ERR:  {$IFDEF Panel}
                              Result := 'Added flat error';
                            {$ELSE}
                              Result := 'Added cope error';
                            {$ENDIF}
    RESULT_ADDED_NOTCH_ERR: Result := 'Added notch error';
    else
      if ErrNum<0 then Result:=inttostr(ErrNum);
  end;
end;

{ TFrameSelection }
constructor TFrameSelection.Create;
begin
  FSelectedFrames := TFrameList.Create(false);
  FStartMember    := 1;
  FLastMember     := MaxInt;
  FFrameCopies    := 1;
  Copies          := 1;
  GroupItems      := False;
end;

destructor TFrameSelection.Destroy;
begin
  FSelectedFrames.Free;
  inherited;
end;

procedure TFrameSelection.FramesGridsJobSelection;
begin
  TFormJobSelection.SelectFramesToProduce;
end;

procedure TFrameSelection.ResetSelectedFrames;
begin
  try
    FreeList(FSelectedFrames);
  except
    on E: Exception do
      HandleException(e,'TFrameSelection.ResetSelectedFrames',[]);
  end;
end;

function TFrameSelection.getFrameCount: integer;
begin
  result := FSelectedFrames.Count;
end;

procedure TFrameSelection.SaveEntities;
// *Writes entities array to disk file sim.cut
// *Accessible via keybd+mouse & pwd.
// *This is not user published, only for debugging
var
  aStringList: TStringlist;
  aFrame: TSteelFrame;
  FilePath: string;
begin
  aStringList := TStringlist.Create;
  try
    for aFrame in FSelectedFrames do
      aFrame.AddSimcutStrings(aStringList);
  finally
    FilePath := extractfilepath(paramstr(0)) + 'sim.cut';
    aStringList.SaveToFile(FilePath);
    messageDlg('File saved'#10 + FilePath, mtInformation,[mbOk], 0);
    FreeAndNil(aStringList);
  end;
end;

Function SimcutOpString(anEntity: pEntityRecType) : string;
var
  I : Integer;
  S : String;
  aOperatePosition : Double;
  aPoint : Point2D;

  Function Add(V: Double): boolean;
  begin
    Result := V<>0;
    if Result then
      S := S + Format(' %.2f', [V]);
  end;

{$IFDEF TRUSS}
begin
  S  :=  'lh:';
  For aPoint in anEntity^.LHoles do
  Begin
    if aPoint.x = 0 then
      break
    else
    begin
      aOperatePosition := DistFromHoleToEnd(anEntity, aPoint);
      Add(aOperatePosition);
    end;
  End;

  S := S + ' fh:';
  For aPoint in anEntity^.FHoles do
  Begin
    if aPoint.x = 0 then
      break
    else
    begin
      aOperatePosition := DistFromHoleToEnd(anEntity, aPoint);
      Add(aOperatePosition);
    end;
  End;

  S := S + ' nt:';
  For I:=Low(anEntity^.PosNotch) to High(anEntity^.PosNotch) do
    if not Add(anEntity^.PosNotch[I]) then
      break;

  S := S + ' cp:';
  For I:=Low(anEntity^.poscope) to High(anEntity^.poscope) do
    if not Add(anEntity^.poscope[I]) then
      break;

  Result:=S;
end;
{$ELSE}
begin
  S  :=  'h:';
  For aPoint in anEntity^.FHoles do
  begin
    if aPoint.x = 0 then
      break
    else
    begin
      aOperatePosition := DistFromHoleToEnd(anEntity, aPoint);
      Add(aOperatePosition);
    end;
  end;
  S  :=   S + ' h2:';
  For aPoint in anEntity^.LHoles do
  begin
    if aPoint.x = 0 then
      break
    else
    begin
      aOperatePosition := DistFromHoleToEnd(anEntity, aPoint);
      Add(aOperatePosition);
    end;
  end;
  S  :=   S + ' f:';
  For i:= Low(anEntity^.PosCope) to High(anEntity^.PosCope) do
    if not Add(anEntity^.PosCope[i]) then
      break;

  S  :=   S + ' n:';
  for i:= Low(anEntity^.PosNotch) to High(anEntity^.PosNotch) do
    if not Add(anEntity^.PosNotch[i]) then
      break;
  S  :=   S + ' w:';
  For i := 1 to Max_ops do
  Begin
    if anEntity^.op[i].Kind = okSwage then
       Add(anEntity^.op[i].pos);
  End;
  S  :=   S + ' e:';
  for i := 1 to Max_ops do
  begin
    if anEntity^.op[i].Kind = okSlot then
       Add(anEntity^.op[i].pos);
  end;
  S  :=   S + ' s1:';
  for i := 1 to anEntity^.OpCount do
  begin
    if anEntity^.Op[i].Kind <> okServ1 then
      break
    else
    begin
      aOperatePosition := DistFromHoleToEnd(anEntity, anEntity^.Op[i].p);
      Add(aOperatePosition);
    end;
  end;
  S  :=   S + ' s2:';
  for i := 1 to anEntity^.OpCount do
  begin
    if anEntity^.Op[i].Kind <> okServ2 then
      break
    else
      aOperatePosition := DistFromHoleToEnd(anEntity, anEntity^.Op[i].p);
      Add(aOperatePosition);
  end;

  Result:=S;
end;
{$ENDIF}

procedure TSteelFrame.AddSimcutStrings(SL: TStrings);
var
  i: integer;
begin
  for i := 0 to Pred(FItemCount) do
  begin
    with FEntity[i] do
      SL.Add(Format('%s %s %d',[truss, item, round(len)]));
    SL.Add(SimcutOpString(@FEntity[i]));
  end;
end;

procedure TSteelFrame.SetItemIDs;
var i: integer;
begin
  for i := 0 to Pred(FItemCount) do
    FEntity[i].id := i + 1;
end;

function TFrameSelection.ProcessFrames: boolean; // false if any errors
begin
  result := ProcessFrames(FSelectedFrames)
end;

function TFrameSelection.ProcessFrames(aFrames: TFrameList): boolean;
var
  aSteelFrame: TSteelFrame;
  res : integer;
begin
  result := True;
  SLErrorItems.Clear;
  G_Settings.SetGlobalJointvalues;
  for aSteelFrame in aFrames do
  begin
    res := aSteelFrame.ProcessFrame;
    if isReportableError(res) then
    begin
      result := false;
    end;
  end;
end;


function TSteelFrame.ProcessFrame: integer;
begin
  FrameErrors.clear;
  result := ProcessTruss(FEntity, FItemCount);
  if isReportableError(result) then
  begin
    FrameErrors.Add(FrameName+'    '+ AdjustJointsErrorAsString(result));
    FrameErrors.AddStrings (SLErrorItems);
    FrameErrors.Add('____________________');
  end;
  FConnectionCount := TotalRivets;
  ResetOrigin;
  SortEntities;
  SetItemIDs;
  GetFrameExtent;
end;

{ TFrameList }

function TFrameList.Find(const APredicate: TPredicate<TSteelFrame>): TSteelFrame;
var
  Frame: TSteelFrame;
begin
  for Frame in self do
    if APredicate(Frame) then
      exit(Frame);
  result := nil
end;

{ TFrame}

constructor TSteelFrame.Create(aFrameCDS, aEntityCDS : TDataset);
var
  i,j,k,l,m,n,o,p,q : word;
  ItemCode : string;
  ItemType : string;
  xhole : real;
  yhole : real;
  MeasureProfile: Boolean;
  Itemindex : integer;
begin
  FLines          := TStringlist.Create;
  FLines.Capacity := aFrameCDS.RecordCount;
  FrameErrors     := TStringlist.Create;
  FFrameID        := aFrameCDS.FieldByName('FRAMEID').AsInteger;
  FMinHoleDist    := aFrameCDS.FieldByName('MINHOLEDISTANCE').AsFloat;
  FFrameName      := aFrameCDS.FieldByName('FRAMENAME').AsString;
  FJobID          := aFrameCDS.FieldByName('JOBID').AsInteger;
{$IFDEF PANEL}
  FRFTYPEID       := rfPanel;
{$ELSE}
  FRFTYPEID       := rfTruss;
{$ENDIF}
  FSITEID         := StrToIntDef(G_Settings.general_SiteID,1);
  FROLLFORMERID   := DMSCOTRFID.ScotRFRollFormerID;

  SetLength(FEntity,0); // clear
  SetLength(FEntity, aEntityCDS.RecordCount);
  FItemCount      :=0;
  FStatus         := aFrameCDS.FieldByName('STATUSID').AsInteger;
  aEntityCDS.BlockReadSize:=10;
  try
    aEntityCDS.First;
    while NOT aEntityCDS.Eof do
    begin
      ItemCode := aEntityCDS.FieldByName('ITEMNAME').AsString;
      ItemType := aEntityCDS.FieldByName('FRAMETYPE').AsString;
      if (pos('Web', ItemType) > 0) or (pos('ord', ItemType) > 0) or (ItemType = 'BC') or (ItemType = 'Heel') then
      begin
        with FEntity[FItemCount] do
        begin
          JOBID         := aEntityCDS.FieldByName('JOBID').AsInteger;
          Truss         := aEntityCDS.FieldByName('FRAMENAME').AsString;
          Item          := aEntityCDS.FieldByName('ITEMNAME').AsString;
          iType         := aEntityCDS.FieldByName('FRAMETYPE').AsString;
          ID            := aEntityCDS.FieldByName('FRAMEID').AsInteger;
          Pt[1].x       := aEntityCDS.FieldByName('POINT1X').AsFloat;
          Pt[1].y       := aEntityCDS.FieldByName('POINT1Y').AsFloat;
          Pt[2].x       := aEntityCDS.FieldByName('POINT2X').AsFloat;
          Pt[2].y       := aEntityCDS.FieldByName('POINT2Y').AsFloat;
          Pt[3].x       := aEntityCDS.FieldByName('POINT3X').AsFloat;
          Pt[3].y       := aEntityCDS.FieldByName('POINT3Y').AsFloat;
          Pt[4].x       := aEntityCDS.FieldByName('POINT4X').AsFloat;
          Pt[4].y       := aEntityCDS.FieldByName('POINT4Y').AsFloat;
          j:=1;
          k:=1;
          l:=1;
          m:=1;
          n:=1;
          o:=1;
          p:=1;
          q:=1;
          Len           := aEntityCDS.FieldByName('LENGTH').AsFloat;
          Web           := aEntityCDS.FieldByName('WEB').AsFloat;
          Col           := aEntityCDS.FieldByName('COL').AsInteger;
          OpCount       := aEntityCDS.FieldByName('OPCOUNT').AsInteger;
          bNonRF        := Boolean(aEntityCDS.FieldByName('NONRF').AsInteger);
          bIsFacingItem := Boolean(aEntityCDS.FieldByName('ISFACINGITEM').AsInteger);
          { units convert }
          if not G_Settings.general_metric then
            for i := 1 to 4 do
            begin
              Pt[i].x := Pt[i].x * 25.4;
              Pt[i].y := Pt[i].y * 25.4;
            end;
          if not measureprofile then
          begin
            FProfileHeight := PerpDistance(Pt[1].x, Pt[1].y, Pt[2].x, Pt[2].y, Pt[3].x, Pt[3].y);
            measureprofile := true;
          end;
        end;
      end;
      // Special Operations
      if (Uppercase(ItemType) = 'CT') or
         (Uppercase(ItemType) = 'INSERT') or
         (Uppercase(ItemType) = 'COPE') or
         (Uppercase(ItemType) = 'CON1') or
         (Uppercase(ItemType) = 'NOTCH') or
         (Uppercase(Copy(ItemType, 1, 3)) = 'SCR') or
         (Uppercase(Copy(ItemType, 1, 3)) = 'SCB') or
        ((Uppercase(Copy(ItemType, 1, 1)) = 'B') and (ItemType <> 'BC'))or
         (Uppercase(Copy(ItemType, 1, 2)) = 'PC') or
         (Uppercase(Copy(ItemType, 1, 2)) = 'S1') or
         (Uppercase(Copy(ItemType, 1, 2)) = 'S2') or
         (Uppercase(Copy(ItemType, 1, 3)) = 'TEK') then
      begin
        Itemindex := FindItemIndex(itemcode);
        if Itemindex >= 0 then
        begin
          if not G_Settings.general_metric then
          begin
            xhole := xhole * 25.4;
            yhole := yhole * 25.4;
          end;
          AddOperation(Itemindex, ItemType, xhole, yhole);
        end;
      end;
    Inc(FItemCount);
    aEntityCDS.Next;
    end;
  finally
    aEntityCDS.BlockReadSize:=0;
  end;
  GetFrameExtent; // update extent
end;

constructor TSteelFrame.Create(ALines: TStringlist; AID: integer);
var
  units: string;
  anEntity : EntityRecType;
  aString : String;
begin
  // 1st 4 lines: mm, min hole dist. , frame name and Frame ID
  // these are removed and replaced with just the frame name
  assert(ALines.Count > 6);
{$IFDEF PANEL}
  FRFTYPEID := rfPanel;
{$ELSE}
  FRFTYPEID := rfTruss;
{$ENDIF}
  FSITEID       := StrToIntDef(G_Settings.general_SiteID,1);
  FROLLFORMERID := DMSCOTRFID.ScotRFRollFormerID;
  FrameErrors     := TStringlist.Create;
  FLines := TStringlist.Create;
  FLines.Capacity := ALines.Count;
  FLines.AddStrings(ALines);
  FFrameID := AID;
  Units := trim(FLines[0]);
  Assert((units = 'inches') or (units = 'mm'), 'Units missing from input file');
  FMinHoleDist := StrToFloatDef(trim(FLines[1]), 5);
  FFrameName := trim(FLines[2]);
  FLines.Delete(0); // mm
  FLines.Delete(0); // mhd
  FNumberOfFrames := StrToInt(Trim(FLines[1]));
  FLines.Delete(1); // ID
  ReadStructure;
end;

function TSteelFrame.ReadStructure: integer;
// * Reads trusscode & loads members coords and special ops into TrussEntity array
// * Reads all member special operations in file, and adds to Op[]
// * Returns design profile height of panel/truss members
var
  i: word;
  ds: string;
  e: integer;
  ItemCode : string;
  ItemType : string;
  xhole : real;
  yhole : real;
  MeasureProfile: Boolean;
  Lc : integer;
  Itemindex : integer;
begin
  MeasureProfile := false;
  Lc := 0;
  FItemCount := 0;
  SetLength(FEntity,0); // clear
  SetLength(FEntity, FLines.Count div 11); // each frame AT LEAST 11 lines
  // Start reading the structure
  while (Lc < FLines.Count - 1) and (trim(FLines[Lc]) = FFrameName) do
  begin
    inc(Lc);
    ItemCode := trim(FLines[Lc]);
    inc(Lc);
    ItemType := trim(FLines[Lc]);
    inc(Lc);
    if (pos('Web', ItemType) > 0) or (pos('ord', ItemType) > 0) or (ItemType = 'BC') or (ItemType = 'Heel') then
    { Chord or Web (also dbl rivet items: Chord2 or Web2) }
    begin
      // add item
      inc(FItemCount);
      with FEntity[FItemCount - 1] do
      begin
        OpCount := 0;
        truss := FFrameName;
        item := itemcode;
        itype := ItemType;
        ds := trim(FLines[Lc]);
        inc(Lc);
        val(trim(ds), Pt[1].x, e);
        ds := trim(FLines[Lc]);
        inc(Lc);
        val(trim(ds), Pt[1].y, e);
        ds := trim(FLines[Lc]);
        inc(Lc);
        val(trim(ds), Pt[2].x, e);
        ds := trim(FLines[Lc]);
        inc(Lc);
        val(trim(ds), Pt[2].y, e);
        ds := trim(FLines[Lc]);
        inc(Lc);
        val(trim(ds), Pt[3].x, e);
        ds := trim(FLines[Lc]);
        inc(Lc);
        val(trim(ds), Pt[3].y, e);
        ds := trim(FLines[Lc]);
        inc(Lc);
        val(trim(ds), Pt[4].x, e);
        ds := trim(FLines[Lc]);
        inc(Lc);
        val(trim(ds), Pt[4].y, e);
        { units convert }
        if not G_Settings.general_metric then
          for i := 1 to 4 do
          begin
            Pt[i].x := Pt[i].x * 25.4;
            Pt[i].y := Pt[i].y * 25.4;
          end;
        if not measureprofile then
        begin
          FProfileHeight := PerpDistance(Pt[1].x, Pt[1].y, Pt[2].x, Pt[2].y, Pt[3].x, Pt[3].y);
          measureprofile := true;
        end;
      end;
    end;

    // Special Operations
    if (Uppercase(ItemType) = 'CT') or
       (Uppercase(ItemType) = 'INSERT') or
       (Uppercase(ItemType) = 'COPE') or
       (Uppercase(ItemType) = 'CON1') or
       (Uppercase(ItemType) = 'NOTCH') or
       (Uppercase(Copy(ItemType, 1, 3)) = 'SCR') or
       (Uppercase(Copy(ItemType, 1, 3)) = 'SCB') or
       ((Uppercase(Copy(ItemType, 1, 1)) = 'B') and (ItemType <> 'BC')) or
       (Uppercase(Copy(ItemType, 1, 2)) = 'PC') or
       (Uppercase(Copy(ItemType, 1, 2)) = 'S1') or
       (Uppercase(Copy(ItemType, 1, 2)) = 'S2') or
       (Uppercase(Copy(ItemType, 1, 3)) = 'TEK') or
       SameText(ItemType, '2R') or
       SameText(ItemType, '4R') or
       SameText(ItemType, '2R+2T') or
       SameText(ItemType, '2R+4T') then
    begin
      // Add special op to existing item
      Itemindex := FindItemIndex(itemcode);
      if Itemindex >= 0 then
      begin
        ds := trim(FLines[Lc]);
        inc(Lc);
        val(trim(ds), xhole, e);
        ds := trim(FLines[Lc]);
        inc(Lc);
        val(trim(ds), yhole, e);
        if not G_Settings.general_metric then
        begin
          xhole := xhole * 25.4;
          yhole := yhole * 25.4;
        end;
        AddOperation(Itemindex, ItemType, xhole, yhole);
      end else
      ods('%d operation %s - item %s not found', [lc, ItemType , itemcode]);
    end;
  end;
  GetFrameExtent; // update extent
  result := FItemCount;
end;

procedure TSteelFrame.SortEntities;
var Comparex: IComparer<EntityRecType>;
  procedure swap(a, B: integer);
  var t: EntityRecType;
  begin
    t := FEntity[a]; FEntity[a]:= FEntity[B]; FEntity[B]:= t;
  end;

begin
  Comparex:= TComparer<entityrectype>.Construct( function (const a,b:entityrectype): integer
                                                 begin
                                                   result:=sign(round(a.Pt[1].x) - round(b.Pt[1].x));
                                                   if result=0 then
                                                     result:=sign(a.Pt[1].y - b.Pt[1].y);
                                                 end);
  TArray.sort<EntityRecType>(FEntity, Comparex, 0, FItemCount);
  // make PB always before PT if PB is 2nd or 3rd in entites[]. May 2013
  if FItemCount > 3 then
  begin
    if (Copy(FEntity[0].item, 1, 2) = 'PT') then
    begin
      if (Copy(FEntity[2].item, 1, 2) = 'PB') then
        swap(0, 2)
      else if (Copy(FEntity[1].item, 1, 2) = 'PB') then
        swap(0, 1);
    end;
  end;
end;

procedure TSteelFrame.GetFrameExtent;
// * Scans all trusscode members and sets dx = overall BC length, & dy = overall TC to BC heights
// * Used for stacking - not implemented yet
var
{$IFDEF TRUSS} tcItem, bcItem: Boolean; {$ENDIF}
  ItemStr: String;
  i, j: integer;
  x, y: double;
begin
  xMin := 100000;
  xMax := -100000;
  yMin := 100000;
  YMax := -100000;
{$IFDEF TRUSS}
  ChordYMin := 100000;
  ChordYMax := -100000;

  BCXmin := 100000;
  BCXmax := -100000;
{$ELSE}
  PlateYMin:=10000;
  PlateYMax:=-10000;
{$ENDIF}
  for i := 0 to Pred(FItemCount) do
  begin
    ItemStr := FEntity[i].item;
    for j := 1 to 4 do
    begin
      x := FEntity[i].Pt[j].x;
      y := FEntity[i].Pt[j].y;

      xMin := min(xMin, x);
      xMax := max(xMax, x);
      yMin := min(yMin, y);
      YMax := max(YMax, y);
{$IFDEF TRUSS}
      tcItem := pos('TC', ItemStr) > 0;
      bcItem := pos('BC', ItemStr) > 0;
      if tcItem or bcItem then
      begin
        ChordYMin := min(ChordYMin, y);
        ChordYMax := max(ChordYMax, y);
      end;

      if bcItem then
      begin
        BCXmin := min(BCXmin, x);
        BCXmax := max(BCXmax, x);
      end;
{$ELSE}
      if StartsText( 'P', ItemStr) then
      begin
        PlateYMin := min(PlateYMin, y);
        PlateYMax := max(PlateYMax, y);
      end;
{$ENDIF}
    end;
  end;
end;

function MaterialReqd(E: pEntityRecType): double;
begin
  result:=E^.len + CutWidth;  // BladeCutWidth
end;

function TSteelFrame.MaterialLength: double;
var i: integer;
begin
  Result := 0;
  for i := 0 to Pred(FItemCount) do
    Result :=   Result + MaterialReqd(@FEntity[i]) ;
end;

destructor TSteelFrame.Destroy;
begin
  FLines.Free;
  FrameErrors.free;
  inherited;
end;

procedure TSteelFrame.AddOperation(AItemIndex: integer; AOperation: string; xhole, yhole: real);
// *Adds entity operation at TrussEnitity[ndx]
// *Itemtype is operation, xhole,yhole is 2D psoition
// *Operations are added into Op[] array
var
  pctemp: integer;
begin
  with FEntity[AItemIndex] do
  begin
    inc(OpCount);
    op[OpCount].p.x := xhole;
    op[OpCount].p.y := yhole;
    if Uppercase(AOperation) = 'CT' then
      op[OpCount].Kind := OkCT;
    if Uppercase(AOperation) = 'INSERT' then
    begin
      op[OpCount].Kind := OkINS;
    end;
    if Uppercase(AOperation) = 'COPE' then
      op[OpCount].Kind := OkCope;
    if Uppercase(AOperation) = 'NOTCH' then
      op[OpCount].Kind := OkNotch;
    if Uppercase(AOperation) = 'CON1' then
    begin
      op[OpCount].Kind := OkCon1;
      INC(FSPACERS);
    end;
    if Uppercase(AOperation) = 'S1' then
      op[OpCount].Kind := OkServ1;
    if (Uppercase(AOperation) = 'S2') and  G_Settings.Pstructure_service2 then
      op[OpCount].Kind := OkServ2
    else if (Uppercase(AOperation) = 'S2') then
      op[OpCount].Kind := OkServ1;

    if SameText(AOperation, '2R') then
      Op[OpCount].Kind := ok2Rivet
    else if SameText(AOperation, '4R') then
      Op[OpCount].Kind := ok4Rivet
    else if SameText(AOperation, '2R+2T') then
    begin
      Op[OpCount].Kind := ok2Rivet2Tek;
      FTEKSCREWS:=FTEKSCREWS+2;
    end
    else if SameText(AOperation, '2R+4T') then
    BEGIN
      Op[OpCount].Kind := ok2Rivet4Tek;
      FTEKSCREWS:=FTEKSCREWS+4;
    END;
    if Uppercase(Copy(AOperation, 1, 1)) = 'B' then
    begin
      if Uppercase(AOperation) = 'BRACE' then
        op[OpCount].Kind := okBrace // Brace location
      else if Uppercase(Copy(AOperation, 2, 1)) = 'A' then
        op[OpCount].Kind := OkBrA // Bearing types
      else if Uppercase(Copy(AOperation, 2, 1)) = 'B' then
        op[OpCount].Kind := OkBrB
      else
        op[OpCount].Kind := OkBrC;
      if Uppercase(AOperation) <> 'BRACE' then
        try
          op[OpCount].num := strtoint(Copy(AOperation, 3, 2));
        except
          op[OpCount].num := 0;
        end;
    end;
    if (Uppercase(Copy(AOperation, 1, 3)) = 'SCR') or (Uppercase(Copy(AOperation, 1, 3)) = 'TEK') then // Screw count
    begin
      op[OpCount].Kind := OkSCR;
      if not bframes then
        try
          op[OpCount].num := strtoint(Copy(AOperation, 4, 2));
        except
          op[OpCount].num := 0;
        end;
      FTEKSCREWS:=FTEKSCREWS+op[OpCount].num;
    end;
    if Uppercase(Copy(AOperation, 1, 3)) = 'SCB' then // A DOUBLE SIDED SCREW
    begin
      op[OpCount].Kind := OkSCB;
      FTEKSCREWS:=FTEKSCREWS+1;
      try
        op[OpCount].num := strtoint(Copy(AOperation, 4, 2));
      except
        op[OpCount].num := 0;
      end;
    end;
    if Uppercase(Copy(AOperation, 1, 2)) = 'PC' then // Pre Camber value
    begin
      op[OpCount].Kind := OkPC;
      try
        pctemp := trunc(strtofloat(Copy(AOperation, 3, 3)) * 1000);
        op[OpCount].num := pctemp; // 1/1000th percent
      except
        op[OpCount].num := 0;
      end;
    end;
  end;
end;

function TSteelFrame.FindItemIndex(ecode: string): integer;
// *Returns the ndx of the trusscode ecode in TrussEntity[]
var
  i: integer;
begin
  for i := 0 to Pred(FItemCount) do
    if FEntity[i].item = ecode then
      exit(i);
  exit(-1);
end;

procedure TSteelFrame.ForEachItem(proc: TItemProcess);
var
  i: integer;
begin
  SetItemIDs;
  for i := 0 to Pred(FItemCount) do
    proc(@FEntity[i]);
end;

function PerpDistance(x1, y1, x2, y2, x, y: double): double;
// *returns the perp. distance from a point to line x1,y1-x2,y2
// *Used to calc profile height from coordinates of member.
var
  s, angle, p: extended;

  function lineSlope(x1, y1, x2, y2: double): double;
  // *Returns line gradient - ised on PerpDist calc
  begin
    if abs(x2 - x1) < 0.001 then
      result := 100000000
    else
      result := (y2 - y1) / (x2 - x1);
  end;

begin { of perpdist }
  s := lineSlope(x1, y1, x2, y2);
  angle := arctan(s) + pi / 2;
  p := x1 * cos(angle) + y1 * sin(angle);
  result := (x * cos(angle) + y * sin(angle) - p);
end;

procedure TSteelFrame.ResetOrigin;
// *Moves all entities origin to left cnr and swap start/ends
var
  i, j: word;
  tx, ty: double;
begin
  assert(xMin < xMax);
  { translate frame to avoid -ve end adjusts }
  for i := 0 to Pred(FItemCount) do
    with FEntity[i] do
    begin
      if OpCount > 0 then
        for j := 1 to OpCount do
        begin
          op[j].p.x := op[j].p.x - xMin { +150 } ;
          op[j].p.y := op[j].p.y - yMin { +150 } ;
        end;
      for j := 1 to 4 do
      begin
        Pt[j].x := Pt[j].x - xMin { +150 } ;
        Pt[j].y := Pt[j].y - yMin { +150 } ;
      end;
      for j:=1 to MAX_HOLES do
      begin
        if PointIsOrigin(LHoles[j])then
          break;
        LHoles[j].x := LHoles[j].x - xMin ;
        LHoles[j].y := LHoles[j].y - yMin;
      end;
      for j:=1 to MAX_HOLES do
      begin
        if PointIsOrigin(FHoles[j])then
          break;
        FHoles[j].x := FHoles[j].x - xMin ;
        FHoles[j].y := FHoles[j].y - yMin;
      end;
    end;

  { swap start/end to conform with std }
  for i := 0 to Pred(FItemCount) do
    with FEntity[i] do
    begin
      if (Pt[1].x <> Pt[2].x) and (Pt[1].x > Pt[2].x) then
      begin
        tx := Pt[1].x;
        Pt[1].x := Pt[2].x;
        Pt[2].x := tx;
        ty := Pt[1].y;
        Pt[1].y := Pt[2].y;
        Pt[2].y := ty;
        tx := Pt[3].x;
        Pt[3].x := Pt[4].x;
        Pt[4].x := tx;
        ty := Pt[3].y;
        Pt[3].y := Pt[4].y;
        Pt[4].y := ty;
      end;
      if (abs(Pt[1].x - Pt[2].x) < 1) and (Pt[1].y > Pt[2].y) then
      begin
        tx := Pt[1].x;
        Pt[1].x := Pt[2].x;
        Pt[2].x := tx;
        ty := Pt[1].y;
        Pt[1].y := Pt[2].y;
        Pt[2].y := ty;
        tx := Pt[3].x;
        Pt[3].x := Pt[4].x;
        Pt[4].x := tx;
        ty := Pt[3].y;
        Pt[3].y := Pt[4].y;
        Pt[4].y := ty;
      end;
    end;
end;

procedure TSteelFrame.InitCanvas;
begin
  FCanvas.Pen.color := clBlack;
  FCanvas.Pen.Width := 1;
  FCanvas.FillRect(FCanvasRect);
  FCanvas.font.name:='Arial';
end;

procedure TSteelFrame.SetScaleAndOrigin;
var
  xrange : Double;
  yrange : Double;
  W      : Integer;
  H      : Integer;
begin
  FOrigin.X := (xmax + xmin)/ 2;
  FOrigin.Y := (ymax + ymin)/ 2;
  xrange    := abs(xmax - xmin);
  yrange    := abs(ymax - ymin);

  W := FCanvasRect.Right  - FCanvasRect.Left;
  H := FCanvasRect.Bottom - FCanvasRect.Top;
  FRectCentre := Point(FCanvasRect.Left + W div 2, FCanvasRect.Top + H div 2); // image centre
  FScale := min(W / xrange, H / yrange);
end;

procedure TSteelFrame.SetFont(AColor:TColor; ASize:integer; AStyle: TFontStyles);
begin
  FCanvas.Font.Color := AColor;
  FCanvas.Font.Size  := ASize;
  FCanvas.Font.Style := AStyle;
end;

procedure TSteelFrame.SetFont(AColor: TColor; AStyle: TFontStyles);
begin
  FCanvas.Font.Color := AColor;
  FCanvas.Font.Style := AStyle;
end;

function TSteelFrame.Client2Screen(Pt: Point2D): TPoint;
// Convert from real-world coordinates to screen coordinates
begin
  Result.X := FRectCentre.X + round(FScale * (Pt.X - FOrigin.X));
  Result.Y := FRectCentre.Y - round(FScale * (Pt.Y - FOrigin.Y));
end;

function TSteelFrame.GetEntityPoints(Ent: pEntityRecType): RectType;
var
  ScreenPoint: TPoint;
  I : Integer;
begin
  for I := 1 to 4 do
  begin
    ScreenPoint:= Client2Screen(Ent^.Pt[i]);
    result.Pt[i].x := ScreenPoint.x; // int -> double
    result.Pt[i].y := ScreenPoint.y; // int -> double
  end;
end;

procedure TSteelFrame.LineOut(AP1, AP2: Point2D);
// Display line from real-world coordinates
var
  p1, p2: TPoint;
begin
  p1 := Client2Screen(AP1);
  p2 := Client2Screen(AP2);
  FCanvas.MoveTo(p1.X, p1.Y);
  FCanvas.LineTo(p2.X, p2.Y);
end;

procedure TSteelFrame.TextOut(s: string; APt: Point2D);
var
  p: TPoint;
begin
  // default alignment:  top-left of text
  p := Client2Screen(APt);
  FCanvas.TextOut(p.X, p.Y, s)
end;


procedure TSteelFrame.TextOutAtP(APt: Point2D; Caption: string; dy: integer);   // centred text-out
var Sz: TSize;
  P: TPoint;
begin
  Sz := FCanvas.TextExtent(Caption);
  p := Client2Screen(APt);
  FCanvas.TextOut(p.X - sz.cx div 2, p.Y + dy - sz.cy div 2 , Caption); // centre text on operation
end;

procedure TSteelFrame.Circle(APt: Point2D; ARadius: integer; AColor: TColor);
// Display circle from real-world coordinates and canvas radius
var
  p: TPoint;
begin
  FCanvas.Pen.color := AColor;
  p := Client2Screen(APt);
  FCanvas.Ellipse(p.X - ARadius, p.Y - ARadius, p.X + ARadius, p.Y + ARadius);
end;

procedure TSteelFrame.Square(APt: Point2D; ARadius: integer; AColor: TColor);
var
  p: TPoint;
begin
  FCanvas.Pen.Color := AColor;
  p := Client2Screen(APt);
  FCanvas.Rectangle(p.X - ARadius, p.Y - ARadius, p.X + ARadius, p.Y + ARadius);
end;

procedure TSteelFrame.SquareUnder(APt: Point2D; ARadius: integer; AColor: TColor);
var
  p: TPoint;
begin
  FCanvas.Pen.Color := AColor;
  p := Client2Screen(APt);
  FCanvas.Rectangle(p.X - ARadius, p.Y , p.X + ARadius, p.Y + ARadius*2);
end;


procedure TSteelFrame.DrawItem(p: pEntityRecType);
var
  linewidth : Integer;
  baseWidth : Integer;
begin
  if p^.isBoxDbl then
  begin
    linewidth := 3;
    baseWidth := 3;
  end
  else
  begin
    linewidth := 1;
    baseWidth := 2;
  end;
  FCanvas.Pen.Width := baseWidth;
  FCanvas.Pen.color := FOnGetColour(Self, p);
  with p^ do
  begin
    LineOut(Pt[1], Pt[2]);
    FCanvas.Pen.Width := linewidth;
    LineOut(Pt[2], Pt[3]);
    LineOut(Pt[3], Pt[4]);
    LineOut(Pt[4], Pt[1]);
  end;
end;

procedure TSteelFrame.DrawOperations(pEnt: pEntityRecType);
var
  Operation        : OpType;
  Caption          : String;
  s                : String;
  i                : Integer;
  BearingRad       : Integer;
  Radius           : Integer;
  W                : Integer;
  ServiceRad2      : Integer;
  Color            : TColor;
  p                : TPoint;
  bShowConnections : Boolean;
begin
  FCanvas.pen.width:=2;
  Radius := round( FScale * pEnt^.Web / 2 ) ;
  BearingRad := Radius;
  {$IFDEF TRUSS}
    bShowConnections := G_Settings.tstructure_specialcons;
  {$ELSE}
    bShowConnections := True;
  {$ENDIF}
  ServiceRad2:=FCanvas.TextWidth('X'); // service circle size - fixed
  for i := 1 to pEnt^.OpCount do
  begin
    Operation := pEnt^.Op[i];
    Caption := '';
    case Operation.Kind of
      okServ1:                // plumbing - 1/2 size
        if G_Settings.Pstructure_showservice then
          Circle(Operation.p, ServiceRad2  div 2, clblue);
      okServ2:
        if G_Settings.Pstructure_showservice then
          Circle(Operation.p, ServiceRad2, clRed);
      okIns:
        if bShowConnections then
          Circle(Operation.p, ServiceRad2, clRed);
      okCon1:                 // connectors
        if bShowConnections then
        begin
          FCanvas.Brush.Color :=clWebFirebrick;
          Circle(Operation.p, Radius, clRed);
          FCanvas.Brush.Color := clWhite;
        end;
      okScr, okScb:           // connectors (# screws / teks)
        if G_Settings.tstructure_screws then
        begin
          Caption := inttostr(Operation.num) + ifthen(Operation.Kind = okScb, 'B', '');
          SetFont(clRED,[fsBold]);
          TextOutAtP(Operation.p, Caption, -20); // centred text-out above connection
          SetFont;
        end;
      okBrA, okBrB, okBrC:    // bearings - possibly unnecessary
        if bShowConnections then
        begin
          Color:=clBlack;
          case Operation.Kind of
            okBrA: Color := clgreen;
            okBrB: Color := clblue;
            okBrC: Color := clRed;
          end;
          SquareUnder(Operation.p, BearingRad, Color);
        end;
      okBrace:
        if bShowConnections then
          Square(Operation.p, Radius, clBlack);
      okPC:
        if bShowConnections then
        begin
          Caption := format('PC %4.2f', [Operation.num / 1000]);
          W := FCanvas.TextWidth(Caption);
          p := Client2Screen(Operation.p);
          FCanvas.TextOut(p.X - W div 2, p.Y - 6, Caption); // centre text on operation
        end;
      ok4Rivet, ok2Rivet2Tek, ok2Rivet4Tek:   // not ok2Rivet, it's standard
        if bShowConnections then
        begin
          s := '4R';
          case Operation.Kind of
            ok2Rivet2Tek: s := '2R+2T';
            ok2Rivet4Tek: s := '2R+4T';
          end;
          W := FCanvas.TextWidth(s);
          p := Client2Screen(Operation.p);
          FCanvas.TextOut(p.X - W div 2, p.Y - 6, s); // centre text on operation
        end;
    end;
  end;
end;

procedure TSteelFrame.DrawSteelFrame(aCanvas : TCanvas);
begin
  FCanvasRect  := aCanvas.ClipRect;
  FCanvas      := ACanvas;
  InitCanvas;
  InFlateRect( FCanvasRect, -Margin, -Margin );
  SetScaleAndOrigin;
  SetFont;
  ForEachItem(DrawItem);
  ForEachItem(DrawOperations);
end;

end.
