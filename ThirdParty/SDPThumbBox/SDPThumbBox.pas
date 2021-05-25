unit SDPThumbBox;

interface

uses
  Windows, Messages, SysUtils,
  Classes, Controls, Forms,
  Graphics, ExtCtrls,
  Jpeg, ShellAPI,
  ActiveX, AXCtrls, ComObj;

type TThumbnail = class(TCustomControl)
  private   { Private declarations }
    FPic : TJPEGImage;
    FFileName: TFileName;
    FActualHeight: Integer;
    FActualWidth: Integer;
    procedure SetPic(Value: TJPEGImage);
  public    { Public declarations }
    procedure Paint; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property FileName: TFileName read FFileName;
    property ActualWidth: Integer read FActualWidth;
    property ActualHeight: Integer read FActualHeight;
  published  { Published declarations }
    property Pic: TJPEGImage read FPic write SetPic;
end;

type
  TSDPThumbBox= class(TScrollBox)
  private   { Private declarations }
    FJPEG: TJPEGImage;
    FPath: TFileName;
    FThumbWidth: Integer;
    FThumbHeight: Integer;
    FSorted: Boolean;
    FThumbCount: Integer;
    FShowFileName: Boolean;
    FThumbColor: TColor;
    FThumbFrameTopColor: TColor;
    FThumbFrameBottomColor: TColor;
    procedure SetPath(const Value: TFileName);
    procedure ClearThumbs;
    procedure SetThumbHeight(const Value: Integer);
    procedure SetThumbWidth(const Value: Integer);
    procedure RepaintThumbs;
    //procedure ThumbClick(Sender: TObject);
  protected { Protected declarations }
    procedure Resizing(State: TWindowState); override;
  public    { Public declarations }
    Thumbs: array of TThumbnail;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ThumbCount: Integer read FThumbCount;
    procedure Repaint; override;
  published  { Published declarations }
    property Path: TFileName read FPath write SetPath;
    property ThumbWidth: Integer read FThumbWidth write SetThumbWidth default 120;
    property ThumbHeight: Integer read FThumbHeight write SetThumbHeight default 90;
    property Sorted: Boolean read FSorted write FSorted default True;
    property ShowFileName: Boolean read FShowFileName write FShowFileName default True;
    property ThumbColor: TColor read FThumbColor write FThumbColor default clBtnFace;
    property ThumbFrameTopColor: TColor read FThumbFrameTopColor write FThumbFrameTopColor default clBtnHighlight;
    property ThumbFrameBottomColor: TColor read FThumbFrameBottomColor write FThumbFrameBottomColor default clBtnShadow;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TSDPThumbBox]);
end;

{ TSDPThumbBox}

constructor TSDPThumbBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FJPEG := TJPEGImage.Create;
  FJPEG.Performance := jpBestSpeed;
  HorzScrollBar.Tracking := True;
  VertScrollBar.Tracking := True;
  //default values
  FThumbWidth := 120;
  FThumbHeight := 90;
  FSorted := True;
  FShowFileName := True;
  VertScrollBar.Increment := 46;
  FThumbColor := clBtnFace;
  FThumbFrameTopColor := clBtnHighlight;
  FThumbFrameBottomColor := clBtnShadow;
end;

procedure TSDPThumbBox.ClearThumbs;
var
  i: Integer;
begin
  i:=0;
  while i<ComponentCount do
  begin
    if (Components[i] is TThumbnail)then
      Components[i].Free
    else
      inc(i);
  end;
  SetLength(Thumbs, 0);
end;

destructor TSDPThumbBox.Destroy;
begin
  FJPEG.Free;
  ClearThumbs;
  inherited Destroy;
end;

procedure TSDPThumbBox.SetPath(const Value: TFileName);
const
  READ_MODE      = STGM_READ or STGM_SHARE_EXCLUSIVE;
var
  i,x,y, nCols, ColNum, Len, nThumbs: Integer;
  FoundList: TStringList;
  SearchRec: TSearchRec;
  bJPEGsFound: Bool;
  wFileName: PWideChar;
  RootStorage: IStorage;
  Stream: IStream;
  OLEStream: TOleStream;
begin
  if Value = FPath then
    exit;
  FPath := Value;
  //Trim trailing '\'
  Len := Length(FPath);
  if (FPath[Len] = '\')and(Len>3)then
    FPath := Copy(FPath, 1, pred(Len));

  FoundList := TStringList.Create;
  try  //look for jpg files
    bJPEGsFound := FindFirst(FPath + '\*.sdp', faAnyFile, SearchRec) = 0;
    try
      if bJPEGsFound then
      begin
        FoundList.Add(FPath + '\' + SearchRec.Name);
        while FindNext(SearchRec) = 0 do
          FoundList.Add(FPath + '\' + SearchRec.Name);
      end;
    finally
      FindClose(SearchRec);
    end;

    ClearThumbs;

    VertScrollBar.Position := 0;
    HorzScrollBar.Position := 0;
    Invalidate;

    //create the thumbnails
    if FSorted then
      FoundList.Sort;
    y:=2;  ColNum := 0;
    nCols := pred(Width div (ThumbWidth + 2));   //13 = Scrollbar width
    FThumbCount := FoundList.Count;
    //SetLength(Thumbs, FThumbCount);
    nThumbs := 0;
    RootStorage := nil;
    for i:=0 to pred(FThumbCount) do
    begin
      wFileName := PWideChar( WideString( FoundList[i] ) );
      if StgIsStorageFile(wFileName) = S_OK then
      begin
        inc(nThumbs);
        SetLength(Thumbs, nThumbs);
        Thumbs[pred(nThumbs)] := TThumbnail.Create(Self);
        OleCheck( StgOpenStorage( wFileName, nil, READ_MODE, nil, 0, RootStorage ) );
        if Succeeded( RootStorage.OpenStream('JPEG', nil, READ_MODE, 0, Stream) )then
        begin
          OLEStream := TOleStream.Create(Stream);
          try
            FJPEG.LoadFromStream(OLEStream);
            with Thumbs[pred(nThumbs)] do
            begin
              FActualWidth := FJPEG.Width;
              FActualHeight := FJPEG.Height;
              FFileName := FoundList[i];
              Pic := FJPEG;
              Parent := Self;
              if ColNum > nCols then
              begin
                ColNum := 0;
                inc(y, (ThumbHeight + 2));
              end;
              x := ColNum * (ThumbWidth + 2) + 2;
              inc(ColNum);
              SetBounds(x,y, ThumbWidth, ThumbHeight);
              Visible := True;
              OnClick := TSDPThumbBox(Parent).OnClick; //ThumbClick;
              OnDblClick := TSDPThumbBox(Parent).OnDblClick;
              OnMouseDown := TSDPThumbBox(Parent).OnMouseDown;
              OnMouseUp := TSDPThumbBox(Parent).OnMouseUp;
              OnMouseMove := TSDPThumbBox(Parent).OnMouseMove;
              Color := TSDPThumbBox(Parent).FThumbColor;
              Application.ProcessMessages;
            end;
          finally
            OLEStream.Free;
          end;
        end;
      end;
    end;
  finally
    FoundList.free;
    FThumbCount := Length(Thumbs);
  end;
end;

procedure TSDPThumbBox.RepaintThumbs;
var
  i, x,y, nCols, colNum: Integer;
begin
  y := 2;  ColNum := 0;
  nCols := pred(Width div (ThumbWidth + 2));
  for i:=0 to Pred(ComponentCount)do
  begin
    if Components[i] is TThumbnail then
    begin
      if ColNum > nCols then
      begin
        ColNum := 0;
        inc(y, (ThumbHeight + 2));
      end;
      x := ColNum * (ThumbWidth + 2) + 2;
      inc(colNum);
      (Components[i] as TThumbnail).SetBounds(x,y, ThumbWidth, ThumbHeight);
    end;
  end;
end;

procedure TSDPThumbBox.Resizing(State: TWindowState);
begin
  inherited;
  RepaintThumbs;
end;

procedure TSDPThumbBox.SetThumbHeight(const Value: Integer);
begin
  FThumbHeight := Value;
  VertScrollBar.Increment := (FThumbHeight + 2) div 2;
  RepaintThumbs;
end;

procedure TSDPThumbBox.SetThumbWidth(const Value: Integer);
begin
  FThumbWidth := Value;
  RepaintThumbs;
end;
     {
procedure TSDPThumbBox.ThumbClick(Sender: TObject);
begin
  if (Sender is TThumbnail)then
    with (Sender as TThumbnail)do
      ShellExecute(Handle,'open',PChar(FileName),nil,nil,SW_SHOW);
end;
      }
procedure TSDPThumbBox.Repaint;
var
  i: Integer;
begin
  inherited;
  i:=0;
  while i<ComponentCount do
  begin
    if (Components[i] is TThumbnail)then
      (Components[i] as TThumbnail).Paint;
    inc(i);
  end;
end;

{ TThumbnail }

constructor TThumbnail.Create(AOwner: TComponent);
begin
  inherited;
  FPic := TJPEGImage.Create;
end;

destructor TThumbnail.Destroy;
begin
  FPic.Free;
  inherited;
end;

procedure TThumbnail.SetPic(Value: TJPEGImage);
var
  sz: Single;
begin     //Need to use Thumb size too
  FPic.Scale:= jsEighth;
  sz := Sqrt(Value.Width * Value.Height);
  if sz < 1024 then
    FPic.Scale := jsQuarter;
  if sz < 512 then
    FPic.Scale := jsHalf;
  if sz < 256 then
    FPic.Scale := jsFullSize;
  //FPic.Grayscale := True;
  //FPic.ProgressiveDisplay := True; //default is False
  FPic.Assign(Value);
  //FPic.DibNeeded;
end;

procedure TThumbnail.Paint;
var
  ARect : TRect;
  s: string;
  W,H, L,T,R,B: Integer;
  Ratio: Single;
begin
  inherited;
  ARect := ClientRect;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(ClientRect);
  Ratio := FPic.Width / FPic.Height;
  if Ratio >= Width / Height then
  begin
    W := Width;  H := Round(Width / Ratio);
  end
  else begin
    W := Round(Height * Ratio);  H := Height;
  end;
  L := (Width - W) div 2;
  R := L + W;
  T := (Height - H) div 2;
  B := T + H;
  ARect := Rect(L,T,R,B);
  Canvas.StretchDraw(ARect, FPic);
  ARect := ClientRect;
  //Raised, Lowered has colours reversed, Flat has no Frame3D
  //Frame3D(Canvas, ARect, clBtnHighlight, clBtnShadow, 2);
  with TSDPThumbBox(Parent)do
    Frame3D(Canvas, ARect, FThumbFrameTopColor, FThumbFrameBottomColor, 2);  
  if TSDPThumbBox(Parent).FShowFileName then
  begin
    s := ' ' + ExtractFileName( ChangeFileExt(FileName, '') ) + ' ';
    Canvas.Brush.Color := clWhite;
    Canvas.Font := TSDPThumbBox(Parent).Font;
    W := Canvas.TextWidth(s);
    L := (Width - W) div 2;
    H := Canvas.TextHeight(s);
    //Canvas.Brush.Style := bsClear;
    Canvas.TextOut(L, 2, s);
    ARect := Rect(L, 2, L + W, 2 + H);
    Frame3D(Canvas, ARect, clBtnShadow, clBtnHighlight, 1);
  end;
end;

end.
