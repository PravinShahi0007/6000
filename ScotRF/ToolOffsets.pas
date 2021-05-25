unit ToolOffsets;

Interface

uses
  SysUtils, Classes, Controls, ScotRFtypes;

type
  IToolOffsets = Interface
    Function RelativePosition(AProcess: TOperationProcess): Double;
    Function OffcutLength: double;
  End;

  TPanelOffsets=class(TInterfacedObject, IToolOffsets)
  private
    CutWidth        : Double;
    Cut2Flat        : Double;
    Notch2Flat      : Double;
    Swage2Flat      : Double;
    Hole2Flat       : Double;
    HoleM2Flat      : Double;  {multihole}
    Service2Flat    : Double;
    Service22Flat   : Double;
    EndBearing2Flat : Double;
  public
    Constructor Create;
    Function RelativePosition(AProcess: TOperationProcess): Double;
    Function OffcutLength: double;
  end;

  TTrussOffsets=class(TInterfacedObject, IToolOffsets)       // 2" Truss
  private
    CutWidth    : Double;
    FHole2lHole : Double;
    Cut2lHole   : Double;
    Notch2lHole : Double;
    Cope2lHole  : Double;
  public
    constructor Create;
    function RelativePosition(AProcess: TOperationProcess): Double;
    function OffcutLength: double;
  end;

  T75mmTrussOffsets=class(TInterfacedObject, IToolOffsets)   // 3" truss
  private
    CutWidth       : Double;
    FHole2lHole    : Double;
    CutToNotch     : Double;
    CopeToNotch    : Double;
    SwageToNotch   : Double;
    LipHoleToNotch : Double;
    SwageSize      : Double;
  public
    constructor Create;
    function RelativePosition(AProcess: TOperationProcess): Double;
    function OffcutLength: double;
  end;

  TBoxTrussOffsets=class(TInterfacedObject, IToolOffsets)  // Box web
  private
    WebCutWidth  : Double;
    Cut2webhole  : Double;
  public
    constructor Create;
    function RelativePosition(AProcess: TOperationProcess): Double;
    function OffcutLength: double;
  end;

Function GetToolOffsets    : IToolOffsets;
Function GetBoxToolOffsets : IToolOffsets;


implementation
uses GlobalU, Units, USettings, StrUtils, dialogs;

Function GetBoxToolOffsets: IToolOffsets;
begin
  result := TBoxTrussOffsets.Create;
end;

function getToolOffsets:IToolOffsets; // Get tool offset values for manufacturw
begin
  if G_Settings.general_machinetype='' then
    MessageDlg('Error - Invalid value in Machine Type settings', mtInformation, [mbOK], 0)
  else
  case TMachineType(AnsiIndexStr(G_Settings.general_machinetype, ['PANEL','PANELHD','50MMTRUSS','75MMTRUSS']))  of
    mtTruss:            result := TTrussOffsets.Create;
    mt75mmTruss:        result := T75mmTrussOffsets.Create;
    mtPanel, mtPanelHD: result := TPanelOffsets.Create;
  end;
end;

{$region 'PANEL'}

{ TPanelOffsets }

constructor TPanelOffsets.Create;
begin
  with G_Settings do
  begin
     cutwidth        := strtofloat(ToolUnitsIn(panelrf_cutwidth));         // PanelCutwidth.text));
     cut2flat        := strtofloat(ToolUnitsIn(panelrf_cut2flat));         // PanelCut2flat.text));
     notch2flat      := strtofloat(ToolUnitsIn(panelrf_notch2flat));       // PanelNotch2Flat.text));
     hole2flat       := strtofloat(ToolUnitsIn(panelrf_hole2flat));        // PanelHole2Flat.text));
     holeM2flat      := hole2flat - strtofloat(ToolUnitsIn(panelrf_holeM2diffhorz));    // ToolUnitsIn(PanelHoleDiffHorz.text));
     swage2flat      := strtofloat(ToolUnitsIn(panelrf_swage2flat));       // PanelSwage2Flat.text));
     service2flat    := strtofloat(ToolUnitsIn(panelrf_service2flat));     // PanelService2Flat.text));
     service22flat   := strtofloat(ToolUnitsIn(panelrf_service22flat));    // PanelService22Flat.text));
     EndBearing2Flat := strtofloat(ToolUnitsIn(panelrf_EndBrgNotchToFlat));// uxPanelEndBrgToFlat.text));
   end;
end;

function TPanelOffsets.RelativePosition(AProcess: TOperationProcess): Double;
begin
  Result := 0.0;
  if AProcess = opCopsFlats         then result :=              - cut2Flat ;    //  flat
  if AProcess = opNotches           then result := notch2flat   - cut2flat;     // notch
  if AProcess = opLipHole           then result := holeM2flat   - cut2flat;     // lip holes
  if AProcess = opFlangeHole        then result := hole2flat    - cut2flat;     //  F is op symbol for flange hole in truss, or dbl hole in stud
  if AProcess = opEndBearingNotch   then result := EndBearing2Flat  - cut2flat; // End Bearing Notch
  if AProcess = opService1s         then result := service2flat - cut2flat;     // service 1
  if AProcess = opService2s         then result := service22flat- cut2flat;     // service 2
  if AProcess = opSwage             then result := swage2flat   - cut2flat;     // swage
  if AProcess = opCut               then result := cutwidth;
end;

function TPanelOffsets.OffcutLength: double;
begin
  Result := cut2flat - cutwidth;
end;
{$endregion}

{$region 'TRUSS'}

{ TTrussOffsets }

function TTrussOffsets.RelativePosition(AProcess: TOperationProcess): Double;
// position relative to CUT;  before cut is negative
begin
  Result := 0.0;
  if AProcess= opCopsFlats  then result := cope2lhole   - cut2lhole;            // copes
  if AProcess= opNotches    then result := notch2lhole  - cut2lhole;            // notch
  if AProcess= opLipHole    then result :=              - cut2lhole;            // lip holes
  if AProcess= opFlangeHole then result := fhole2lhole  - cut2lhole;            // flange holes
  if AProcess = opCut then result := cutwidth;
end;

constructor TTrussOffsets.Create; // 2" truss
begin
  inherited;
  with G_Settings do
  begin
    cut2lhole   := strtofloat(ToolUnitsIn(trussrf_c2fhole));                    //uxTrussCutToLip.text
    cope2lhole  := strtofloat(ToolUnitsIn(trussrf_cope2fhole));                 //uxTrussCopeToLip.text
    notch2lhole := strtofloat(ToolUnitsIn(trussrf_n2fhole));                    //uxTrussNotchToLip.text
    fhole2lhole := strtofloat(ToolUnitsIn(trussrf_lhole2fhole));                //uxTrussFHtoLipH.text
    cutwidth    := strtofloat(ToolUnitsIn(trussrf_cutwidth));                   //trusscutwidthEdit.text
  end;
end;

function TTrussOffsets.OffcutLength: double;
begin
  Result := cut2lhole  - cutwidth
end;

{ T75mmTrussOffsets }

constructor T75mmTrussOffsets.Create;   // 3" truss
begin
  with G_Settings do
  begin
    CutToNotch       := strtofloat(ToolUnitsIn(trussrf_CutToNotch));            //uxTrussCutToNotch.text
    CopeToNotch      := strtofloat(ToolUnitsIn(trussrf_CopeToNotch));           //uxTrussCopeToNotch.text
    SwageToNotch     := strtofloat(ToolUnitsIn(trussrf_SwageToNotch75));        //uxTrussSwageToNotch.text
    LipHoleToNotch   := strtofloat(ToolUnitsIn(trussrf_LipHoleToNotch));        //uxTrussLipHoleToNotch.text
    SwageSize        := strtofloat(ToolUnitsIn(trussrf_SwageSize75));           //uxTrussSwageSize.text
    fhole2lhole      := strtofloat(ToolUnitsIn(trussrf_FlangeHoleToLipHole75)); //uxTruss3inFHtoLipH.text
    cutwidth         := strtofloat(ToolUnitsIn(trussrf_cutwidth));              //trusscutwidthEdit.text
  end;
end;

function T75mmTrussOffsets.RelativePosition(AProcess: TOperationProcess): Double;
// position relative to CUT;  before cut is negative
begin
  Result := 0.0;
  if AProcess = opCopsFlats  then result := CopeToNotch      - CutToNotch;                // copes
  if AProcess = opNotches    then result :=                  - CutToNotch;                // notch
  if AProcess = opLipHole    then result := LipHoleToNotch   - CutToNotch;                // lip holes
  if AProcess = opFlangeHole then result := LipHoleToNotch   + fhole2lhole  - CutToNotch; // flange holes
  if AProcess = opSwage      then result := SwageToNotch     - CutToNotch;                // swage
  if AProcess = OpCut        then result := cutwidth;
end;

function T75mmTrussOffsets.OffcutLength: double;
begin
  Result := cutToNotch - cutwidth; // 3" truss
end;

{ TBoxTrussOffsets }

function TBoxTrussOffsets.RelativePosition(AProcess: TOperationProcess): Double;
begin
  Result := 0.0;
  if AProcess = opFlangeHole then result := - cut2webhole ;
  if AProcess = opCut        then result := webcutwidth;
end;

constructor TBoxTrussOffsets.Create;
begin
  cut2webhole := strtofloat(ToolUnitsIn(G_Settings.boxrf_boxc2hole   ));        //formSettings.BoxCut2holeEdit.text
  webcutwidth := strtofloat(ToolUnitsIn(G_Settings.boxrf_boxcutwidth ));        //formSettings.BoxCutWidthEdit.text
end;

function TBoxTrussOffsets.OffcutLength: double;
begin
  Result := cut2webhole  - webcutwidth
end;

{$endregion}

end.


