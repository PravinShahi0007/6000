unit ManufactureU;

{*
   Here use AnsiChar as Operation or Process,
   'C'  Cut
   'L'  Lip Hole
   'F'  Flange Hole
   'P'  Cops Flats
   'N'  Notches
   'W'  Swage
   'S'  Service1s
   'T'  Service2s
   Hope to add operation process type TOperationProcess to change this

   TOperationProcess = (  opCut
                        , opLipHole
                        , opFlangeHole
                        , opCopsFlats
                        , opNotches
                        , opSwage
                        , opService1s
                        , opService2s);

*}

interface

uses
  Windows, forms, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, Math, strUtils, stdCtrls,
  generics.collections, generics.Defaults, WinUtils, GlobalU, FrameDataU, ScotRFTypes, ToolOffsets;

type

  TProductionQueue=class;

  TCheckLength = reference to function(S: string): boolean;
  TOperationProcessSet = Set of TOperationProcess;

  TRFOperation = class(TObject)
  private
    FProcess      : TOperationProcess;
    FDistance     : Double;
    FRelativePos  : Double;
    FDescription  : String;
    FSITEID       : SmallInt;
    FROLLFORMERID : SmallInt;                                                           // Machine movement, relative to cut
    constructor Create(const AProcess: TOperationProcess; const ADistance, RPos: Double);
    class function Compare(const A, B: TRFOperation): integer; static;
    function GetDescription : String;
  public
    property RelativePos  : Double read FRelativePos write FRelativePos;
    property Distance     : Double read FDistance;                                   // Actual distance from cut to operation
    property Process      : TOperationProcess read FProcess;
    property Description  : string read GetDescription;
    function debugString  : string; virtual;
    property SITEID       : SmallInt read FSITEID write FSITEID;
    property ROLLFORMERID : SmallInt read FROLLFORMERID write FROLLFORMERID;
  end;

  TItemBase = class abstract
  private
    procedure SortOperations;
    function RelativePosition(const op: TOperationProcess): Double;
    function CountOps(Ops: TOperationProcessSet): Integer;
  protected
    FQueue: TProductionQueue; // for access to ToolOffsets
    FToolOffsets: IToolOffsets;

    FOperations : TObjectList<TRFOperation>; // Initially: operations required to make a single steel item
    FFrameID    : Integer;
    FJOBID      : Integer;
    FID         : Integer;
    FEP2FILEID  : Integer;
    FIsLast     : boolean;
    FCopyID     : Integer;
//    FCARDNUMBER : String;
    function getItemName: string; virtual; abstract;
    function getTrussName: string; virtual; abstract;
    function getItemLength: Double; virtual; abstract;
    function getFrame: TSteelFrame; virtual;
  public
    constructor Create(AQueue: TProductionQueue); virtual;
    destructor Destroy; override;
    function getEnumerator: TEnumerator<TRFOperation>;
    function MaterialLength: Double;
    Function SerialNumber: integer; virtual; // entity item id (0 for process file & offcut)
    function IJPPrintLine(OnCheckLength: TCheckLength): AnsiString; // A single steel item
    function ItemStr: string;
    function isBoxWeb: boolean; virtual;
    function isBoxWebDbl: boolean; virtual;
    function ConnectOpCount: Integer;
    function FirstOp: TRFOperation;
    procedure AddOperation(const anOperationPosition: Double; const op: TOperationProcess; const bAllowZero: boolean=False);
    property TrussName  : string read getTrussName; // W1 etc
    property ItemName   : string read getItemName; // SR1 etc
//    property CARDNUMBER : String  read FCARDNUMBER write FCARDNUMBER;
    property ItemLength : Double read getItemLength;// 2D item length
    property Frame      : TSteelFrame read getFrame;
    property isLast     : boolean read FIsLast;
    property FrameID    : Integer read FFrameID   write FFrameID;
    property JOBID      : Integer read FJOBID     write FJOBID;
    property ID         : Integer read FID        write FID;
    property EP2FILEID  : Integer read FEP2FILEID write fEP2FILEID;
    property CopyID     : Integer read FCopyID    write FCopyID;
  end;

  TEntityItem = class(TItemBase)
  protected
    FEntity   : pEntityRecType;
    FFrame    : TSteelFrame;
    function getItemName: string; override;
    function getTrussName: string; override;
    function getItemLength: Double; override;
    function getFrame: TSteelFrame; override;
    function GetSmartCardNumber : String;
  public
    constructor Create(AQueue: TProductionQueue; AEntity: pEntityRecType; AFrame: TSteelFrame); reintroduce;
    function isBoxWeb     : Boolean; override;
    function isBoxWebDbl  : Boolean; override;
    Function SerialNumber : Integer; override; // FEntity.ID: Sequential number within frame: first is 1
    function ScrewCount   : Integer;
    function SpacerCount  : Integer;
    procedure BuildOperations;
    property SteelFrame   : TSteelFrame read FFrame;
    property SmartCardNumber : String read GetSmartCardNumber;
  end;

  TSimpleItem = class(TItemBase) // A single steel item (offcut or processfile)
  strict private
    FTrussName: string;
    FItemName: string;
    FItemLength: Double;
  protected
    function getItemName: string; override;
    function getTrussName: string; override;
    function getItemLength: Double; override;
  public
    constructor Create(AQueue: TProductionQueue;AName, AMemberName: string); reintroduce;
    procedure AddCut(ACutPosition: Double);
  end;

  TOnMove     = Function (ADelta: Double): boolean of object;
  TOnToolOp   = Procedure(AProcess: TRFOperation) of object;
  TFrameEvent = Procedure(AFrame: TFrame) of object;
  TItemEvent  = Procedure(AFrame: TFrame; APItem: TItemBase) of object;

  ETerminate = class(EAbort)
  end;

  TSteelList = class(TObjectList<TItemBase>)
    procedure MergeItems(ASource: TSteelList);
  private
    function FindLastItemForTruss(ATrussName: string): integer;
  end;

  TProductionQueue = class(TObject)
  private
    FMainQ : TSteelList;
    {$IFDEF TRUSS}
    FWebQ  : TSteelList;
    {$ENDIF}
    FTriggerRequired: boolean;
    FCurrentItem: TItemBase;
    FItemPosition: Double;
    FFrameN: cardinal;
    FOnMove      : TOnMove;
    FOnToolOp    : TOnToolOp;
    FItemStart   : TNotifyEvent;
    FItemFinish  : TNotifyEvent;
    FFrameStart  : TNotifyEvent;
    FFrameFinish : TNotifyEvent;
    FJobStart    : TNotifyEvent;
    FJobFinish   : TNotifyEvent;
    procedure RelocateOperations(AList: TList<TItemBase>);
    procedure RunItemOps;
    procedure CheckForPause;
    procedure NoOp(AObject: TObject);
    function AddtoQueue(AFrame: TSteelFrame; pEntity: pEntityRecType): TItemBase;
    procedure AddItem(AItem: TItemBase);
    function getFrameCount: integer;
    procedure OptimiseOffcut;
  protected // unused
    procedure SaveToFile(AList: TList<TItemBase>;const AFileName: string);
  public
    AsyncPause, AsyncAbort: boolean;
    Running: boolean;
    Tool_OffSets: IToolOffsets;
    {$ifdef TRUSS}
      BoxToolOffsets: IToolOffsets;
    {$endif}
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure AddOffcut(ALength: Double = 0);
    procedure AddSelectionToQueue(ASelection : TFrameSelection; AAccept : TProcessFilter);
    function ParseProcessStrings(aLines: TStrings; aCount: Integer): boolean;
    function GetItemColor(AFrame: TSteelFrame; p: pEntityRecType): TColor;
    function Empty: boolean;
    procedure Run;
    property CurrentItem: TItemBase read FCurrentItem;
    property FrameN: cardinal read FFrameN;
    property FrameCount: integer read getFrameCount;
    function CurrentEntity:pEntityRecType;
    property ItemPosition: Double read FItemPosition;
    property TriggerRequired: boolean read FTriggerRequired write FTriggerRequired;
    function ConnectorTotal: integer;

    property OnMove        : TOnMove      read FOnMove      write FOnMove;
    property OnToolOp      : TOnToolOp    read FOnToolOp    write FOnToolOp;
    property OnItemStart   : TNotifyEvent read FItemStart   write FItemStart;
    property OnItemFinish  : TNotifyEvent read FItemFinish  write FItemFinish;
    property OnFrameStart  : TNotifyEvent read FFrameStart  write FFrameStart;
    property OnFrameFinish : TNotifyEvent read FFrameFinish write FFrameFinish;
    property OnJobStart    : TNotifyEvent read FJobStart    write FJobStart;
    property OnJobFinish   : TNotifyEvent read FJobFinish   write FJobFinish;
  end;

implementation

uses Logging, Units, USettings, AdjustForJointsU, ItemTypeSelectionU;

{ TProductionQueue }
constructor TProductionQueue.Create;
begin
  FMainQ := TSteelList.Create;
  FMainQ.Capacity := 1000; // initial alloc - frames per job
{$IFDEF TRUSS}
  FWebQ := TSteelList.Create;
{$ENDIF}
  // initialise all callbacks as 'no operation'
  OnItemStart   := NoOp;
  OnItemFinish  := NoOp;
  OnFrameStart  := NoOp;
  OnFrameFinish := NoOp;
  OnJobStart    := NoOp;
  OnJobFinish   := NoOp;
end;

function TProductionQueue.CurrentEntity: pEntityRecType;
begin
  Result := nil;
  if assigned(Currentitem) and (currentItem is TEntityItem) then
    Result := TEntityItem(Currentitem).FEntity;
end;

destructor TProductionQueue.Destroy;
begin
  FMainQ.Free;
{$IFDEF TRUSS}
  FWebQ.Free;
{$ENDIF}
  inherited;
end;

procedure TProductionQueue.AddOffcut(ALength: Double);
var
  Offcut: TSimpleItem;
  OCLength: double;
begin
  OCLength := Tool_Offsets.OffcutLength;
  Offcut := TSimpleItem.Create(Self, 'OffCut', 'OC');    // pseudo-name for offcut piece
  Offcut.AddCut(OCLength);
  FMainQ.Add(Offcut);
end;
procedure TProductionQueue.CheckForPause;
begin
  //Has the PAUSE button been clicked ? }
  if not running then
    exit;
  if AsyncPause then
    repeat
      application.processmessages;
      sleep(50);
    until (not AsyncPause) or AsyncAbort;
    if AsyncAbort then
      raise ETerminate.Create('Cancelled');
end;

procedure TProductionQueue.Clear;
begin
  FCurrentItem := nil;
  AsyncPause := false;
  AsyncAbort := false;
  FMainQ.Clear;
  Tool_Offsets := getToolOffsets;
  {$ifdef TRUSS}
    FWebQ.Clear;
    BoxToolOffsets := getBoxToolOffsets;
  {$endif}
end;

function TProductionQueue.GetItemColor(AFrame: TSteelFrame; p: pEntityRecType): TColor;
var
  ActiveItemID: integer;
begin
  result := clBlack;
  if assigned(FCurrentItem) then
  begin
    ActiveItemID := FCurrentItem.SerialNumber;
    if ActiveItemID = p^.ID + 1 then
      exit(clgreen); // just done
    case sign(p^.ID - ActiveItemID) of
      - 1: result := clBlue; // done
      0: result := clred; // in progress
      1: result := clBlack; // to be done
    end;
  end;
end;

procedure TProductionQueue.RunItemOps;
// note
//  - last operation must be cut;
//  - the list of operations may include operations from the next steel item
//  - OnMove & OnToolOp must be assigned
var
  Delta: Double;
  op: TRFOperation;
begin
  FItemPosition := 0;
  for op in FCurrentItem.FOperations do
  begin
    CheckForPause;
    Delta := op.RelativePos - FItemPosition;
    if Delta > 0 then
      if Assigned(FOnMove) then
        if not FOnMove(Delta) then
          raise EAbort.Create('Move failed');
    if Assigned(FOnToolOp) then
      FOnToolOp(op);
    FItemPosition := FItemPosition + Delta
  end;
end;

procedure TProductionQueue.Run;
var
  I : Integer;
  MergedQ: TSteelList;
  isNewFrame: boolean;
begin
  MergedQ := TSteelList.Create(false);
  Running := true;
  try
    if (G_Settings.general_machinetype='75MMTRUSS') and
        (FMainQ.count > 1) and
        (FMainQ[0].ItemName ='OC') then
      OptimiseOffcut;

    RelocateOperations(FMainQ);
    for I := 0 to pred(FMainQ.Count) do
      FMainQ[I].SortOperations;
    MergedQ.MergeItems(FMainQ);

    {$IFDEF TRUSS}
    RelocateOperations(FWebQ);
    for i := 0 to pred(FWebQ.count) do
      FWebQ[i].SortOperations;
    MergedQ.MergeItems(FWebQ);
    {$ENDIF}

    OnJobStart(self);
    FFrameN := 1;
    isNewFrame := True;
    for i := 0 to pred(MergedQ.count) do
    begin
      FCurrentItem := MergedQ[i];
      CheckForPause;
      if isNewFrame and (FCurrentItem.Frame <> nil) then
      begin
        OnFrameStart(self);
        isNewFrame:=false;
      end;

      OnItemStart(self);
      RunItemOps;
      OnItemFinish(self);
      if (FCurrentItem.isLast) then
      begin
        if i = pred(MergedQ.count) then
          Running := false;
        OnFrameFinish(self);
        isNewFrame := True;
        inc(FFrameN);
        CheckForPause;
      end;
    end;
  finally
    Running := false;
    OnJobFinish(self);
    MergedQ.Free;  // MergedQ does not own the items so FCurrentItem remains valid (used in paint method)
  end;
end;

procedure TProductionQueue.RelocateOperations(AList: TList<TItemBase>);
var
  Item: TItemBase;
  PrevItem: TItemBase;
  op: TRFOperation;
  i, j, k: integer;
  // move operations with negative relative position to the preceeding items operation list
begin
  for i := 0 to pred(AList.count) do
  begin
    Item := AList[i];
    for j := pred(Item.FOperations.count) downto 0 do
    begin
      op := Item.FOperations[j];
      if (op.RelativePos < 0) and (i > 0) then
      begin
        k := i - 1;
        Item.FOperations.Extract(op);
        if op.Process = opPrint then // can't push print back
        begin
          op.Free;
          continue;
        end;
        while k >= 0 do
        begin
          PrevItem := AList[k];
          op.RelativePos := op.RelativePos + PrevItem.MaterialLength;
          if (op.RelativePos > 0) or (k = 0) then
          begin
            PrevItem.FOperations.Add(op);
            break;
          end;
          dec(k);
        end;
      end;
    end;
    // may need to move service hole position (service tool head is after the cutter)
    // If service hole is past the cut position, drag it back
    for op in (Item.FOperations) do
    begin
      if op.Process in [opService1s, opService2s] then
        if (op.RelativePos > Item.MaterialLength) then
          op.RelativePos := Item.MaterialLength - 0.01;
    end;
  end;
end;

procedure TProductionQueue.OptimiseOffcut;
var
  r1,r2,Rpos: double;
  OCDefault: double; // default
  OCLength: double;  // calculated
  LPrior: double;
  i: integer;
const MIN_OFFCUT=200;
begin
  if (FMainQ.count>2) then
  begin
    //  check for negative operation position and swap items 1 & 2 if 2nd item 'better' than first
    r1:= FMainQ[1].FirstOp.FRelativePos;
    r2:= FMainQ[2].FirstOp.FRelativePos;
    if (r1<0) and (r1<r2) then
      FMainQ.Exchange (1,2);
  end;
  LPrior:=0;
  I:=1;
  OCDefault := Tool_OffSets.OffcutLength;
  OCLength := MIN_OFFCUT;

  while (I < (FMainQ.count-1)) and
        (LPrior<OCDefault) do
  begin
    Rpos:= FMainQ[I].FirstOp.FRelativePos;
    if (rPos<0) then
      OCLength:=max( OCLength, -(Rpos+LPrior));
    LPrior := LPrior +  FMainQ[I].ItemLength ;
    Inc(I);
  end;
  FMainQ.Items[0].FOperations.Clear;
  (FMainQ.Items[0] as TSimpleItem).AddCut(OCLength);
end;

procedure TProductionQueue.SaveToFile(AList: TList<TItemBase>;const AFileName: string);
var
  anItem: TItemBase;
  anOperation: TRFOperation;
  aStringList: TStringlist;
begin
  aStringList := TStringlist.Create;
  try
    for anItem in FMainQ do
    begin
      aStringList.Add(format('<%s %s %d item len %f MaterialLength=%f mm> '
                            ,[  anItem.TrussName
                              , anItem.ItemName
                              , FMainQ.IndexOf(anItem)
                              , anItem.ItemLength
                              , anItem.MaterialLength ]
                            )
                      );
      for anOperation in anItem.FOperations do
        aStringList.Add(inttostr(anItem.FOperations.IndexOf(anOperation)) + ' ' + anOperation.debugString);
    end;
    aStringList.SaveToFile(AFileName);
  finally
    FreeAndNil(aStringList);
  end;
end;

function TProductionQueue.ConnectorTotal: integer;
var
  AItem: TItemBase;
  op:   TRFOperation ;
begin
  result := 0;
  for AItem in FMainQ do
    for op in AItem do
      if (op.process in [opLipHole, opFlangeHole]) then
        inc(result);
  {$IFDEF TRUSS}
  for AItem in FWebQ do
    for op in AItem do
      if ( op.process in [opLipHole, opFlangeHole]) then
        inc(result);
  Result := Result  div 2; // bolt counted twice - once on each member
                           // rivets also counted twice but need 2 per operation (1 each side)
  {$ENDIF}
end;

procedure TProductionQueue.AddSelectionToQueue(ASelection: TFrameSelection; AAccept: TProcessFilter);
var
  anItem : TItemBase;
  Frame  : TSteelFrame;
  aCopyID             : Integer;
  SelectedFrameIndex  : Integer;
  StartMember: integer;
  J : Integer;
begin
  StartMember := ASelection.StartMember;
  IF not ASelection.GroupItems then
  for SelectedFrameIndex := 0 to ASelection.SelectedFrames.Count-1 do
  begin
    for aCopyID := 1 to ASelection.Copies do
    begin
      Frame := ASelection.SelectedFrames[SelectedFrameIndex];
      Frame.FConnectors:=0;
      For J := 1 to Frame.NumberOfFrames do
      begin
        anItem := nil;
        if SelectedFrameIndex=0 then
          Frame.ForEachItem(procedure(aEntityPointer: pEntityRecType)
                            begin
                              if   (aEntityPointer.ID >= StartMember)
                               and (aEntityPointer.ID <= ASelection.LastMember)
                               and AAccept(Frame, aEntityPointer) then
                               begin
                                 anItem := AddtoQueue(Frame, aEntityPointer);     //
                                 anItem.CopyID := aCopyID;
                                 anItem.EP2FILEID := Frame.EP2FILEID;
                                 Frame.FConnectors := Frame.FConnectors + anItem.ConnectOpCount;
                              end;
                            end)
        else
          Frame.ForEachItem(procedure(aEntityPointer: pEntityRecType)
                            begin
                              if AAccept(Frame, aEntityPointer) then
                              begin
                                 anItem := AddtoQueue(Frame, aEntityPointer);
                                 anItem.CopyID := aCopyID;
                                 anItem.EP2FILEID := Frame.EP2FILEID;
                                 Frame.FConnectors := Frame.FConnectors + anItem.ConnectOpCount;
                              end;
                            end);
        if not TypeSelectform.SelectByItems and assigned(anItem) then
          anItem.FIsLast := true;
        StartMember :=1;
      End;
    end;
   {$IFDEF TRUSS}
   Frame.FConnectors := Frame.FConnectors div 2;  // bolt counted twice - once on each member
                                                  // rivets also counted twice but need 2 per operation (1 each side)
   {$endif}
  end
  else
  For SelectedFrameIndex := 0 to ASelection.SelectedFrames.Count-1 do
  begin
    Frame := ASelection.SelectedFrames[SelectedFrameIndex];
    Frame.FConnectors:=0;
    For J := 1 to Frame.NumberOfFrames do
    begin
      anItem := nil;
      if SelectedFrameIndex=0 then
        Frame.ForEachItem(procedure(aEntityPointer: pEntityRecType)
                          var
                            cpid : Integer;
                          begin
                            if   (aEntityPointer.ID >= StartMember)
                             and (aEntityPointer.ID <= ASelection.LastMember)
                             and AAccept(Frame, aEntityPointer) then
                            begin
                              for cpid := 1 to ASelection.Copies do
                              begin
                                anItem := AddtoQueue(Frame, aEntityPointer);
                                anItem.EP2FILEID := Frame.EP2FILEID;
                                anItem.CopyID := cpid;
                              end;
                              Frame.FConnectors := Frame.FConnectors + anItem.ConnectOpCount;
                            end;
                          end)
      else
        Frame.ForEachItem(procedure(aEntityPointer: pEntityRecType)
                          var
                            cpid : Integer;
                          begin
                            if AAccept(Frame, aEntityPointer) then
                            begin
                              for cpid := 1 to ASelection.Copies do
                              begin
                                anItem := AddtoQueue(Frame, aEntityPointer);
                                anItem.EP2FILEID := Frame.EP2FILEID;
                                anItem.CopyID := cpid;
                              end;
                              Frame.FConnectors := Frame.FConnectors + anItem.ConnectOpCount;
                            end;
                          end);
      if not TypeSelectform.SelectByItems and assigned(anItem) then
        anItem.FIsLast := true;
    end;
   {$IFDEF TRUSS}
    Frame.FConnectors := Frame.FConnectors div 2;  // bolt counted twice - once on each member
                                                  // rivets also counted twice but need 2 per operation (1 each side)
   {$endif}
  end;
end;

function TProductionQueue.ParseProcessStrings(ALines: tStrings; ACount: integer): boolean;
var
  S: string;
  AnsiStr: AnsiString;
  i, j: integer;
  Position: Double;
  Item: TSimpleItem;
  ProcessStr: AnsiChar;
  Process: TOperationProcess;
  ItemName: string;
  SL: tStringlist;
  procedure parseLine;
  begin
    ItemName := trim(SL[0]);

    if ACount > 1 then
      ItemName := ItemName + '.' + inttostr(i);
    if Item =nil then
    begin
      Item := TSimpleItem.Create(Self, SL[0] {Name}, SL[1] {MemberName});
      AddItem(Item);
    end;
    AnsiStr := SL[3]+ '~';
    ProcessStr := AnsiStr[1];
    Position := StrToMM(SL[2]);   //StrToMM(SL[2]); // convert imperial to mm
{$IFDEF PANEL}
    { If a panel file, convert ops from panel wizard text to processing op format }
    if ProcessStr = 'H' then
      Process := opLipHole // normal single Hole -> lip hole
    else if ProcessStr = 'F' then
      Process := opCopsFlats // Flat -> cope/flat
    else if ProcessStr = 'D' then
      Process := opFlangeHole; // flange hole is double rivet hole
{$ENDIF}
    if ProcessName(Process) = ProcessStr then
      MessageDlg( format('Line %d '#10'%s'#10'Unknown operation %s',[j+1, S, ProcessStr]),
                   mtWarning,[mbOk],0);


    if ProcessStr = 'C' then
    begin
      Item.AddCut(Position); // update item length
      Item :=nil; // no more after cut
    end
    else
      Item.AddOperation(Position, Process);
  end;

begin
  result := true;
  SL := tStringlist.Create;
  try
    for i := 1 to ACount do
    begin
      Item :=nil;
      for j:= 0 to pred(ALines.Count) do
      try
        S:= trim(ALines[j]);
        SL.StrictDelimiter := True;
        SL.CommaText := S;
        if SL.count <= 3 then
          continue;
        ParseLine;
      except
        on e: exception do
        begin
          MessageDlg( 'Error on line ' + inttostr(j+1) + #10 +
                     S + #10 +
                     E.message,mtError,[mbOk],0);
          exit(false);
        end;
      end;
     end;
  finally
    SL.Free;
  end;
  if FMainQ.Count = 0 then
  begin
    messageDlg('No operations found',mtError,[mbOk],0);
    exit(false);
  end;

end;

procedure TProductionQueue.AddItem(AItem: TItemBase);
begin
{$IFDEF TRUSS}
  if AItem.isBoxWeb then
    FWebQ.Add(AItem)
  else
    FMainQ.Add(AItem);
{$ELSE}
  FMainQ.Add(AItem);
{$ENDIF}
end;

function TProductionQueue.AddtoQueue(AFrame: TSteelFrame; pEntity: pEntityRecType ): TItemBase;
var
  Item: TEntityItem;
begin
  Item := TEntityItem.Create(Self, pEntity, AFrame);
  Item.FrameID := AFrame.FrameID;
  Item.JOBID   := AFrame.JOBID;
  Item.ID      := pEntity.ID;
  Item.BuildOperations;
  if TriggerRequired then
  begin
    Item.AddOperation(StrToFloat(G_Settings.inkprinter_headpos), OpPrint);
  end;
  AddItem(Item);
  result := Item;
end;

procedure TProductionQueue.NoOp(AObject: TObject);
begin
  //
end;

function TProductionQueue.Empty: boolean;
begin
  // normally offcut is first  but production file has no offcut , just 1 item
  result := (FMainQ.count = 0) or
            ((FMainQ.count = 1) and  (FMainQ[0].ItemName ='OC'));
end;

function TProductionQueue.getFrameCount: integer;
var
  Item:TItemBase;
begin
  Result:=0;
  for Item in FMainQ do
  begin
    if assigned(Item.Frame) and Item.isLast then   // when copies > 1, each copy is counted
      Inc(Result);
  end;
  {$IFDEF TRUSS}
  for Item in FWebQ do
  begin
    if assigned(Item.Frame) and Item.isLast then   // when copies > 1, each copy is counted
      Inc(Result);
  end;
  {$ENDIF}
end;

{ TQOperation }

class function TRFOperation.Compare(const A, B: TRFOperation): integer;
begin
  result := sign(A.FRelativePos - B.FRelativePos);
  if result = 0 then
    result := ord(A.Process)- ord(B.Process);
end;

constructor TRFOperation.Create(const AProcess: TOperationProcess; const ADistance, RPos: Double);
begin
  inherited Create;
  FProcess := AProcess;
  FDistance := ADistance;
  FRelativePos := FDistance + RPos;
end;

function TRFOperation.debugString: string;
begin
  result := Format('%s %s steel pos %f tool pos %f', [ProcessName(Process), ProcessName(Process), FDistance, FRelativePos]);
end;

function TRFOperation.GetDescription : String;
begin
  result := Format('%s %s steel pos %f tool pos %f', [ProcessName(Process), ProcessName(Process), FDistance, FRelativePos]);
end;

{ TItemBase }

constructor TItemBase.Create(AQueue: TProductionQueue);
begin
  inherited Create;
  FOperations := TObjectList<TRFOperation>.Create(TComparer<TRFOperation>.Construct(TRFOperation.Compare));;
  FOperations.Capacity := 100;
  FQueue := AQueue;
  FToolOffsets := AQueue.Tool_Offsets ;
end;

destructor TItemBase.Destroy;
begin
  FOperations.Free;
  inherited;
end;


Function TItemBase.FirstOp: TRFOperation;
var
  pos: double;
  op: TRFOperation;
begin
  // first physical op
  Result := nil;
  pos:=1e6;
  for op in FOperations do
  begin
    if op.FRelativePos < pos then
    begin
      result := op;
      pos:= op.FRelativePos;
    end;
  end;
end;

procedure TItemBase.SortOperations;
var
  cutPos: Double;
  op: TRFOperation;
  bResort: boolean;
begin
  bResort := false;
  FOperations.sort;
  // any operations after the cut will screw the next member
  // may happen with service punch at end of member ( service punch / print head are physically after then cut
  cutPos := -1; // =unknown

  for op in FOperations do
  begin
    if op.Process = opCut then
      cutPos := op.RelativePos
    else
    if cutPos > 0 then
    begin
      op.RelativePos := cutPos - 0.01;
      bResort := true;
    end;
  end;
  if bResort then
    FOperations.sort;
end;

function TItemBase.getEnumerator: TEnumerator<TRFOperation>;
begin
  result := FOperations.GetEnumerator ;
end;

function TItemBase.getFrame: TSteelFrame;
begin
  result := nil;
end;

function TItemBase.MaterialLength: Double;
begin
  result := ItemLength + cutwidth;
{$IFDEF TRUSS}
//  if isBoxWeb then
//    result := ItemLength + WebCutWidth // box web BladeCutWidth
{$ENDIF}
end;

function TItemBase.CountOps(Ops: TOperationProcessSet): Integer;
var
  op: TRFOperation ;
begin
  Result := 0;
  for op in FOperations do
    if ( op.process in ops) then
      Inc(Result);
end;

function TItemBase.ConnectOpCount: Integer;
begin
  result := CountOps([opLipHole,opFlangeHole]); // Frame=rivet holes, Truss=bolt holes
end;

function TItemBase.SerialNumber: integer;
begin
  result := 0;
end;

function TItemBase.RelativePosition(const op: TOperationProcess): Double;
begin
  result := FQueue.Tool_Offsets.RelativePosition(op);
{$IFDEF TRUSS}
  if isBoxWeb then
    result := FQueue.BoxToolOffsets.RelativePosition(op);
{$ENDIF}
end;

procedure TItemBase.AddOperation(const anOperationPosition: Double; const op: TOperationProcess; const bAllowZero: boolean=False);
var
  anOperation: TRFOperation;
begin
  if IsZero(anOperationPosition) and not bAllowZero then
    exit;
//  Assert(anOperationPosition >= 0);
//  Assert(anOperationPosition <= ItemLength);
  anOperation := TRFOperation.Create(op, anOperationPosition, RelativePosition(op));
  FOperations.Add(anOperation);
end;

function TItemBase.IJPPrintLine(OnCheckLength: TCheckLength): AnsiString;
var
  Printline: string;
  function AddString(S: string; inFront: boolean = false): boolean;
  begin
    S := trim(S);
    if S = '' then
      exit(true);
    if inFront then
      S := S + ' ' + Printline
    else
      S := Printline + ' ' + S;
    S := trim(S);
    result := OnCheckLength(S);
    if result then
      Printline := S;
  end;

begin
  Printline := '';
  // max size is total item length less configured print position (cutter-to-Printhead + position on steel)
  // front margin ( position on steel) is configured print position less cutter-to-Printhead (~120mm)
  // tail margin must be at least cutter-to-Printhead so printing finishes before next cut
  try
    if not AddString(format('#%d',[SerialNumber])) then
      exit;
    if formsettings.IDescrCbox.Checked then
      if not AddString(copy(ItemName, 1, 2)) then // orientation
        exit;
    if not AddString(TrussName, true{inFront}) then // wall name
      exit;

    if not AddString(formsettings.editjob.text) then
      exit;
  finally
    result := Printline;
    // ods('%d item=%f, max print=%f actual %f <%s>', [iptr.no ,Form1.ItemLength(QueuePtr^[itemprtr]) ,Maxsize,inklen(Result),Result]);
  end;
end;

function TItemBase.isBoxWeb: boolean;
begin
  result := false;
end;

function TItemBase.isBoxWebDbl: boolean;
begin
  result := false;
end;

function TItemBase.ItemStr: string;
begin
  result := ifthen(isBoxWeb, 'BOXITEM', 'ITEM');
end;

{ TEntityItem }

constructor TEntityItem.Create(AQueue: TProductionQueue; AEntity: pEntityRecType; AFrame: TSteelFrame);
begin
  inherited Create(AQueue);
  FEntity := AEntity;
  FFrame := AFrame;
  {$ifdef Truss}
  if isBoxWeb then
    FToolOffsets := AQueue.BoxToolOffsets;
  {$endif}
end;

function TEntityItem.isBoxWeb: boolean;
begin
  result := FEntity.isBoxWeb;
end;

function TEntityItem.isBoxWebDbl: boolean;
begin
  result := FEntity.isBoxDbl;
end;

procedure TEntityItem.BuildOperations;
var
  c : integer;
  i : integer;
  aOperatePosition : Double;
begin
  { lip holes }
  for aOperatePosition in FEntity.PosLHoles do
  begin
    if aOperatePosition = 0 then
      break
    else
      AddOperation(aOperatePosition, opLipHole);
  end;
  { flg holes }
  for aOperatePosition in FEntity.PosFHoles do
  begin
    if aOperatePosition = 0 then
      break
    else
      AddOperation(aOperatePosition, opFlangeHole);
  end;
  { copes / flats }
  for aOperatePosition in FEntity.PosCope do
  begin
    if aOperatePosition = 0 then
      break
    else
      AddOperation(aOperatePosition, opCopsFlats);
  end;
  { notches }
  for aOperatePosition in FEntity.PosNotch do
  begin
    if aOperatePosition = 0 then
      break
    else
      AddOperation(aOperatePosition, opNotches);
  end;

  // New swage array - xfr to PosSwage[] Mar 2010
  c := 1;
  try
    for i := 1 to Max_ops do
    begin
      if FEntity.op[i].Kind = okSwage then
      begin
        FEntity.PosSwage[c] := FEntity.op[i].Pos;
        inc(c);
      end;
    end;
  except
    ods('except');
  end;
  // end of special array move

  for aOperatePosition in FEntity.PosSwage do
  begin
    if aOperatePosition = 0 then
      break
    else
      AddOperation(aOperatePosition, opSwage);
  end;

  { End Bearing Notch }
  for i := 1 to Max_ops do
  begin
    if FEntity.op[i].Kind = okSlot then
      AddOperation(FEntity.op[i].Pos, opEndBearingNotch, true);
  end;

  { service1s }
  for aOperatePosition in FEntity.PosServ1 do
  begin
    if aOperatePosition = 0 then
      break
    else
      AddOperation(aOperatePosition, opService1s);
  end;

  { service2s }
  for aOperatePosition in FEntity.PosServ2 do
  begin
    if aOperatePosition = 0 then
      break
    else
      AddOperation(aOperatePosition, opService2s);
  end;

  AddOperation(FEntity.len, opCut, true);
end;

function TEntityItem.getFrame: TSteelFrame;
begin
  result := FFrame;
end;

function TEntityItem.GetSmartCardNumber : String;
begin
  Result := CurrentCardNumber;
end;

function TEntityItem.getItemLength: Double;
begin
  result := FEntity.Len
end;

function TEntityItem.getItemName: string;
begin
  result := FEntity.Item;
end;

function TEntityItem.ScrewCount: integer;
var i: integer;
begin
  result := 0;
  for i := 1 to Max_ops do
  begin
    if FEntity.op[i].Kind = okScr then
      inc(result,FEntity.op[i].Num);
  end;
end;

function TEntityItem.SpacerCount: Integer;
var i: integer;
begin
  result := 0;
  for i := 1 to Max_ops do
  begin
    if FEntity.op[i].Kind = OkCon1 then
      inc(result);
  end;
end;

function TEntityItem.getTrussName: string;
begin
  result := FEntity.Truss; // frame / truss name
end;

function TEntityItem.SerialNumber: integer;
begin
  result := FEntity.ID;
end;


{ TSimpleItem }

constructor TSimpleItem.Create(AQueue: TProductionQueue; AName, AMemberName: string);
begin
  inherited Create(AQueue);
  FTrussName  := AName;
  FItemName   := AMemberName;
  FItemLength := 0;
end;

procedure TSimpleItem.AddCut(ACutPosition: Double);
var CutOp: TRFOperation;
begin
  FItemLength := ACutPosition;
  CutOp := TRFOperation.Create(opCut, ACutPosition, RelativePosition(opCut));
  FOperations.Add(CutOp);
end;

function TSimpleItem.getItemLength: Double;
begin
  result := FItemLength;
end;

function TSimpleItem.getItemName: string;
begin
  result := FItemName;
end;

function TSimpleItem.getTrussName: string;
begin
  result := FTrussName;
end;

{ TSteelList }

function TSteelList.FindLastItemForTruss(ATrussName: string): integer;
var i: integer;
begin
  for i := pred(count) downto 0 do
    if Sametext(self.items[i].TrussName, ATrussName) then
      exit(i);
  exit(-1);
end;

procedure TSteelList.MergeItems(ASource: TSteelList);
var
  i: integer;
  Item: TItemBase;
begin
  if count = 0 then
  begin
    // simple assign
    for Item in ASource do
      self.Add(Item);
  end
  else
  begin
    for Item in ASource do
    begin
      i := FindLastItemForTruss(Item.TrussName);
      if i < 0 then
        self.Add(Item)
      else
        self.Insert(i + 1, Item);
    end;
  end;

end;

end.


