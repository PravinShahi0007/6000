unit PrtPrev;

interface

uses
  Windows, Messages, SysUtils,
  Classes, Graphics, Controls,
  Forms, Dialogs, ExtDlgs,
  Printers, frmPrintPreviewU;

type
  TPrintRange = (prAllPages, prCurrentPage);

type
  TPrtPrev = class(TComponent)
  private    { Private declarations }
    //Persistent Font properties
    FFontColor: TColor;
    FFontSize: Integer;
    FFontStyle: TFontStyles;
    FFontName: string;
    //Persistent Brush Properties
    {FBrushColor: TColor;
    FBrushStyle: TBrushStyle;
    //Persistent Pen Properties
    FPenColor: TColor;
    FPenMode: TPenMode;
    FPenStyle: TPenStyle;
    FPenWidth: Integer;
    //other Persist props
    FPenPos: TPoint;    }
    {Std Props}
    FPageIdx: Integer;
    FMetaFile: array of TMetaFile;
    FCanvas: TMetaFileCanvas;
    FAborted: Boolean;
    FPageNumber: Integer;
    FTitle: string;
    FPreviewForm: TfrmPrintPreview;
    FPreview: Boolean;
    FPrintRange: TPrintRange;
    FInitSaveToDir: string;
    FInitFileName: TFileName;
    FUseMagnifyCursor: Boolean;
    {multipage}
    FCurrentPage: Integer;
    {events - none yet}
    procedure GetCanvas;
    function GetFonts: TStrings;
    function GetHandle: HDC;
    function GetOrientation: TPrinterOrientation;
    function GetPageHeight: Integer;
    function GetPageWidth: Integer;
    procedure SetOrientation(const Value: TPrinterOrientation);
    function GetPrinters: TStrings;
    {multipage}
    function GetPage(PageNo: Integer): TMetaFile;
    function GetTotalPages: Integer;
    procedure SetCurrentPage(const Value: Integer);
    procedure AddPage;
    procedure txtPageNumChange(Sender: TObject);
    procedure DoPreview;
    procedure btnSaveClick(Sender: TObject);
    procedure SaveDlgTypeChange(Sender: TObject);
    procedure CleanUp;
  protected    { Protected declarations }

  public       { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Abort;
    procedure BeginDoc;
    procedure EndDoc;
    procedure NewPage;
    property Aborted: Boolean read FAborted;
    property Canvas: TMetaFileCanvas read FCanvas;
    property Fonts: TStrings read GetFonts;
    property Handle: HDC read GetHandle;
    property Orientation: TPrinterOrientation read GetOrientation write SetOrientation;
    property PageHeight: Integer read GetPageHeight;
    property PageWidth: Integer read GetPageWidth;
    property PageNumber: Integer read FPageNumber;
    property Printers: TStrings read GetPrinters;
    {Multipage Support}
    property Pages[PageNo: Integer]: TMetaFile read GetPage;
    property TotalPages: Integer read GetTotalPages;
    procedure Clear;
    property CurrentPage: Integer read FCurrentPage write SetCurrentPage;
  published    { Published declarations }
    property Title: string read FTitle write FTitle;
    property Preview: Boolean read FPreview write FPreview default True;
    property PrintRange: TPrintRange read FPrintRange write FPrintRange default prAllPages;
    property InitSaveToDir: string read FInitSaveToDir write FInitSaveToDir;
    property InitFileName: TFileName read FInitFileName write FInitFileName;
    property UseMagnifyCursor: Boolean read FUseMagnifyCursor write FUseMagnifyCursor;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TPrtPrev]);
end;

{ TPrtPrev }

procedure TPrtPrev.Abort;
begin
  FAborted := True;
end;

procedure TPrtPrev.AddPage;
var
  n: Integer;
begin
  if FCanvas <> nil then
  begin
    FFontColor := FCanvas.Font.Color;
    FFontSize := FCanvas.Font.Size;
    FFontStyle := FCanvas.Font.Style;
    FFontName := FCanvas.Font.Name;
    {FBrushColor := FCanvas.Brush.Color;
    FBrushStyle := FCanvas.Brush.Style;
    FPenColor := FCanvas.Pen.Color;
    FPenMode := FCanvas.Pen.Mode;
    FPenStyle := FCanvas.Pen.Style;
    FPenWidth := FCanvas.Pen.Width;
    FPenPos := FCanvas.PenPos;
  end 
  {else begin
    FBrushColor := clWhite;
    FBrushStyle := bsSolid;    }
  end;

  FCanvas.Free;
  FCanvas := nil;

  n := FPageIdx;
  SetLength(FMetaFile, succ(n));
  FMetaFile[n] := TMetafile.Create;
  with FMetaFile[n] do
  begin
    Width := Printer.PageWidth;
    Height := Printer.PageHeight;
  end;
  inc(FPageIdx);
end;

procedure TPrtPrev.BeginDoc;
begin
  Clear;
  FMetaFile := nil;
  FAborted := False;
  AddPage;
  GetCanvas;
end;

procedure TPrtPrev.Clear;
begin
  FMetaFile := nil;
  FPageIdx := 0;
  FCurrentPage := 0;
  FAborted := False;
  {if FPreviewForm <> nil then
    FPreviewForm.Close;}
end;

procedure TPrtPrev.txtPageNumChange(Sender: TObject);
begin
  if FPreviewForm <> nil then
    SetCurrentPage( StrToIntDef(FPreviewForm.txtPageNum.Text, 1) );
end;

constructor TPrtPrev.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPageIdx := 0;
  {default properties}
  FPreview := True;
  FPrintRange := prAllPages;
  FUseMagnifyCursor := True;
end;

destructor TPrtPrev.Destroy;
begin
  if FCanvas <> nil then
  begin
    FCanvas.Free;
    FCanvas := nil;
  end;

  Clear;
  FMetaFile := nil;
  CleanUp;
  inherited Destroy;
end;

//* Prevent a memory leak by clearing the MetaFiles from the PrintPrev component
procedure TPrtPrev.CleanUp;
var
  i: Integer;
begin
  for i:= TotalPages downto 1 do
    Pages[i].Free;
end;

procedure TPrtPrev.EndDoc;
//var
// i: Integer;
  {nPages: Integer;
  s: string;        }
begin
  FAborted := False;
  {FCanvas.Pen.Color := clBlack;
  FCanvas.Brush.Style := bsClear;
  //Debug Code to draw a Rect around the Printout
  i:=0;
  while i < 20 do
  begin
    with FCanvas.ClipRect do
      FCanvas.Rectangle(Left+i, Top+i, Right-i, Bottom-i);
    inc(i,2);
  end;       }
  FCanvas.Free;
  FCanvas := nil;

  DoPreview;
  CleanUp;
end;

procedure TPrtPrev.GetCanvas;
var
 idx: Integer;
begin
  idx := pred(FPageIdx);
  FCanvas := TMetaFileCanvas.Create(FMetaFile[idx], Printer.Handle);
  {Clear the Canvas}
  FCanvas.Brush.Color := clWhite;
  FCanvas.Brush.Style := bsSolid;
  FCanvas.FillRect(FCanvas.ClipRect);
  {Set Font to Printer Resolution}
  FCanvas.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle,LOGPIXELSX);
  
  //Persist Font Properties
  if FFontSize <> 0 then
  with FCanvas.Font do
  begin
    Color := FFontColor;
    Size := FFontSize;
    Style := FFontStyle;
    Name := FFontName;
  end;
  {
  //Persist Brush Properties
  FCanvas.Brush.Color := FBrushColor;
  FCanvas.Brush.Style := FBrushStyle;
  //Persist Pen Properties
  FCanvas.Pen.Color := FPenColor;
  FCanvas.Pen.Mode := FPenMode;
  FCanvas.Pen.Style := FPenStyle;
  FCanvas.Pen.Width := FPenWidth;
  //other Persist Props
  FCanvas.PenPos := FPenPos;
  }
end;

function TPrtPrev.GetFonts: TStrings;
begin
  Result := Printer.Fonts;
end;

function TPrtPrev.GetHandle: HDC;
begin
  Result := Printer.Handle;
end;

function TPrtPrev.GetOrientation: TPrinterOrientation;
begin
  Result := Printer.Orientation;
end;

function TPrtPrev.GetPageHeight: Integer;
begin
  Result := Printer.PageHeight;
end;

function TPrtPrev.GetPage(PageNo: Integer): TMetaFile;
begin
  Result := FMetaFile[pred(PageNo)];
end;

function TPrtPrev.GetPageWidth: Integer;
begin
  Result := Printer.PageWidth;
end;

function TPrtPrev.GetPrinters: TStrings;
begin
  Result := Printer.Printers;
end;

function TPrtPrev.GetTotalPages: Integer;
begin
  Result := FPageIdx;
end;

procedure TPrtPrev.NewPage;
begin  {
  FCanvas.Free;
  FCanvas := nil;
  }
  FAborted := False;
  AddPage;
  GetCanvas;
end;

procedure TPrtPrev.SetCurrentPage(const Value: Integer);
var
  n, nPages: Integer;
begin
  n := Value;
  nPages := TotalPages;
  if nPages <> 0 then
  begin
    if n < 1 then n := 1;
    if n > nPages then n := nPages;
    FCurrentPage := n;
    FPreviewForm.Pic.Picture.Graphic := nil;
    if (FPreviewForm <> nil)and(nPages>0) then
      FPreviewForm.Pic.Picture.Assign(FMetaFile[pred(n)]);
  end;
end;

procedure TPrtPrev.SetOrientation(const Value: TPrinterOrientation);
begin
  Printer.Orientation := Value;
end;

procedure TPrtPrev.DoPreview;
var
  nPages: Integer;
  s: string;
begin
  if not (csDesigning in ComponentState) then
  begin
    FPreviewForm := TfrmPrintPreview.Create(Self);
    try           {    //debug
      FPreviewForm.AlphaBlend := True;
      FPreviewForm.AlphaBlendValue := 200;  }
      FPreviewForm.txtPageNum.OnChange := txtPageNumChange;
      FPreviewForm.btnSave.OnClick := btnSaveClick;

      nPages := TotalPages;
      FPreviewForm.udPageNum.Max := nPages;
      s := format('   of %d page',[nPages]);
      if nPages > 1 then
        s := s + 's';
      FPreviewForm.lblTotalPages.Caption := s;
      FPreviewForm.Tag := ord(FPrintRange);
      SetCurrentPage(1);

      FPreviewForm.PrinterTitle := Title;
      FPreviewForm.bMagnifyCursor := FUseMagnifyCursor;
      if FPreview then
        FPreviewForm.ShowModal
      else
        FPreviewForm.btnPrintClick(nil);
    finally
      FPreviewForm.Free;
      FPreviewForm := nil;
    end;
  end;
end;

procedure TPrtPrev.SaveDlgTypeChange(Sender: TObject);
var
  s: string;
begin
  with (Sender as TSavePictureDialog) do
  begin
    s := 'wmf';
    if FilterIndex = 2 then
      s := 'emf';
    DefaultExt := s;
  end;
end;

procedure TPrtPrev.btnSaveClick(Sender: TObject);
var
  nPage: Integer;
begin
  nPage := FCurrentPage;
  if (nPage < 1)or(nPage > TotalPages) then  //Range Check
    exit;
  with TSavePictureDialog.Create(Application) do
  begin
    try
      if FInitSaveToDir = '' then
        FInitSaveToDir := ExtractFilePath(ParamStr(0));
      InitialDir := FInitSaveToDir;
      DefaultExt := 'wmf';
      Filter := 'Windows Metafile (*.wmf)|*.wmf|Enhanced Metafile (*.emf)|*.emf';
      FileName := FInitFileName;
      Options := Options + [ofOverwritePrompt];
      OnTypeChange := SaveDlgTypeChange;
      if Execute then
      begin
        FMetaFile[pred(nPage)].SaveToFile(FileName);
        InitialDir := ExtractFilePath(FileName);
        FInitFileName := ExtractFileName(FileName);
      end;
    finally
      Free;
    end;
  end;
end;

END.
