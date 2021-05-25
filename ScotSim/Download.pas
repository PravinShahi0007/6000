unit Download;

interface

uses
  Windows, SysUtils, Classes,
  Dialogs, Controls,
  URLMon,    //for URLDownloadToFile and IBindStatusCallback
  ActiveX;

type
  TDownloadProgressEvent = procedure (BytesDone, TotalBytes: Cardinal) of object;
  TDownloadStatusEvent = procedure (Code: Cardinal; Msg: string) of object;

type
  TDownload = class(TComponent)
  private    { Private declarations }
    fSrcFile: string;
    fDestFile: string;
    fOnProgress: TDownloadProgressEvent;
    fOnStatus: TDownloadStatusEvent;
    fOnStarting: TNotifyEvent;
    fOnFinished: TNotifyEvent;
    fAborted: Bool;
    //Events
    procedure Progress(BytesDone, TotalBytes: Cardinal); dynamic;
    procedure Status(Code: Cardinal; Msg: string); dynamic;
    procedure Starting(Sender: TObject); dynamic;
    procedure Finished(Sender: TObject); dynamic;
  protected  { Protected declarations }

  public     { Public declarations }
    property Aborted: Bool read fAborted write fAborted default False;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function DownloadFile: Bool;
    procedure Stop;
  published  { Published declarations }
    property URL: string read fSrcFile write fSrcFile;    {**** Case Sensitive ****}
    property DestinationFile: string read fDestFile write fDestFile;
    //Events
    property OnProgress: TDownloadProgressEvent read fOnProgress write fOnProgress;
    property OnStatus: TDownloadStatusEvent read fOnStatus write fOnStatus;
    property OnStartingDownload: TNotifyEvent read fOnStarting write fOnStarting;
    property OnFinishedDownload: TNotifyEvent read fOnFinished write fOnFinished;
  end;

type
  TBindStatusCallback = class(TComponent, IBindStatusCallback)
  private

  protected
     fDownloader: TDownload;
     FRefCount: Integer;
   // IUnknown
     //function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
     function _AddRef: Integer; stdcall;
     function _Release: Integer; stdcall;
  public
    property Downloader: TDownload read fDownloader write fDownloader;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
   // IBindStatusCallback
    function OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult; stdcall;
    function GetPriority(out nPriority): HResult; stdcall;
    function OnLowResource(reserved: DWORD): HResult; stdcall;
    function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
      szStatusText: LPCWSTR): HResult; stdcall;
    function OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult; stdcall;
    function GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult; stdcall;
    function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc;
      stgmed: PStgMedium): HResult; stdcall;
    function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HResult; stdcall;
  end;

  function DownloadStatusCodeToStr(Code: Cardinal): string;

procedure Register;

implementation

uses
  WinInet;

var
  BSC: TBindStatusCallback;

procedure Register;
begin
  RegisterComponents('Samples', [TDownload]);
end;

procedure DeleteIECacheFile(sURL: string);
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
begin
  dwEntrySize := 0;
  lpEntryInfo := nil;
  hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);
  GetMem(lpEntryInfo, dwEntrySize);
  try
    if dwEntrySize > 0 then
      lpEntryInfo^.dwStructSize := dwEntrySize;
    hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);
    if hCacheDir <> 0 then
    begin
      repeat
        if SameText(lpEntryInfo^.lpszSourceUrlName, sURL) then
        begin
          DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
          break;
        end;
        FreeMem(lpEntryInfo, dwEntrySize);
        dwEntrySize := 0;
        FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
        GetMem(lpEntryInfo, dwEntrySize);
        if dwEntrySize > 0 then
          lpEntryInfo^.dwStructSize := dwEntrySize;
      until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize);
    end;
  finally
    FreeMem(lpEntryInfo, dwEntrySize);
    FindCloseUrlCache(hCacheDir);
  end;
end;

function DownloadStatusCodeToStr(Code: Cardinal): string;
begin
  Result := '';
  case Code of
    BINDSTATUS_FINDINGRESOURCE:   Result := 'Finding';            //1
    BINDSTATUS_CONNECTING:        Result := 'Connecting';         //2
    BINDSTATUS_BEGINDOWNLOADDATA: Result := 'Starting';           //4
    BINDSTATUS_DOWNLOADINGDATA:   Result := 'Downloading';        //5
    BINDSTATUS_ENDDOWNLOADDATA:   Result := 'Finished';           //6                                  //5
    BINDSTATUS_SENDINGREQUEST:    Result := 'Sending request';    //11
    BINDSTATUS_CLASSIDAVAILABLE:  Result := 'Class ID available'  //13
  end;
end;

{*********************** TBindStatusCallback **********************************}
             {
function TBindStatusCallback.QueryInterface(const IID: TGUID; out Obj): HResult; 
begin
  if GetInterface(IID, Obj) then Result := S_OK
                            else Result := E_NOINTERFACE;
end;     }

function TBindStatusCallback._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TBindStatusCallback._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
end;

function TBindStatusCallback.GetBindInfo(out grfBINDF: DWORD; var bindinfo: TBindInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.GetPriority(out nPriority): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnDataAvailable(grfBSCF, dwSize: DWORD;
  formatetc: PFormatEtc; stgmed: PStgMedium): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnLowResource(reserved: DWORD): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnObjectAvailable(const iid: TGUID; punk: IInterface): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnProgress(ulProgress, ulProgressMax,
  ulStatusCode: ULONG; szStatusText: LPCWSTR): HResult;
begin
  if Assigned(Downloader) then
  begin
    if (Downloader.Aborted) then
    begin
      Downloader.Finished(nil);
      Downloader.Status(BINDSTATUS_ENDDOWNLOADDATA, 'Aborted');
      Result := E_ABORT;
      exit;
    end;
    Downloader.Progress(ulProgress, ulProgressMax);
    Downloader.Status(ulStatusCode, szStatusText);
    case ulStatusCode of
      BINDSTATUS_BEGINDOWNLOADDATA: begin
                                      Downloader.Starting(nil);
                                    end;
      BINDSTATUS_ENDDOWNLOADDATA:   Downloader.Finished(nil);
    end;
  end;
  //Note ulStatusCode is a BINDSTATUS_... const in URLMon.pas
  //haven't checked these values
  {
  BINDSTATUS_FINDINGRESOURCE           = 1;
  BINDSTATUS_CONNECTING                = 2;
  BINDSTATUS_REDIRECTING               = 3;
  BINDSTATUS_BEGINDOWNLOADDATA         = 4;
  BINDSTATUS_DOWNLOADINGDATA           = 5;
  BINDSTATUS_ENDDOWNLOADDATA           = 6;
  BINDSTATUS_BEGINDOWNLOADCOMPONENTS   = 7;
  BINDSTATUS_INSTALLINGCOMPONENTS      = 8;
  BINDSTATUS_ENDDOWNLOADCOMPONENTS     = 9;
  BINDSTATUS_USINGCACHEDCOPY           = 10;
  BINDSTATUS_SENDINGREQUEST            = 11;
  BINDSTATUS_CLASSIDAVAILABLE          = 12;
  BINDSTATUS_MIMETYPEAVAILABLE         = 13;
  BINDSTATUS_CACHEFILENAMEAVAILABLE    = 14;
  
  BINDSTATUS_BEGINSYNCOPERATION        = 15;
  BINDSTATUS_ENDSYNCOPERATION          = 15;
  BINDSTATUS_BEGINUPLOADDATA           = 17;
  BINDSTATUS_UPLOADINGDATA             = 18;
  BINDSTATUS_ENDUPLOADDATA             = 19;
  BINDSTATUS_PROTOCOLCLASSID           = 20;
  BINDSTATUS_ENCODING                  = 21;
  BINDSTATUS_VERIFIEDMIMETYPEAVAILABLE = 22;
  BINDSTATUS_CLASSINSTALLLOCATION      = 23;
  BINDSTATUS_DECODING                  = 24;
  BINDSTATUS_LOADINGMIMEHANDLER        = 25;
  BINDSTATUS_CONTENTDISPOSITIONATTACH = BINDSTATUS_LOADINGMIMEHANDLER + 1;
  ... etc ...
  }

  Result := S_OK;
end;

function TBindStatusCallback.OnStartBinding(dwReserved: DWORD; pib: IBinding): HResult;
begin
  Result := E_NOTIMPL;
end;

function TBindStatusCallback.OnStopBinding(hresult: HResult; szError: LPCWSTR): HResult;
begin
  Result := E_NOTIMPL;
end;

constructor TBindStatusCallback.Create(AOwner: TComponent);
begin
  inherited;
  if (AOwner <> nil)and(AOwner is TDownload)then
  begin
    Downloader := TDownload(AOwner);
    Downloader.Aborted := False;
  end;
end;

destructor TBindStatusCallback.Destroy;
begin

  inherited;
end;

{**************************** TDownload ***********************************}

constructor TDownload.Create(AOwner: TComponent);
begin
  inherited;
  //fOverWriteWarning := False;
  Aborted :=False;
end;

destructor TDownload.Destroy;
begin

  inherited;
end;

function TDownload.DownloadFile: Bool;
begin
  Result := False;
  Stop;
  Aborted := False;

  if URL = '' then
  begin
    MessageDlg('No URL for ' + Self.Name , mtError, [mbOK], 0);
    exit;
  end;

  if DestinationFile = '' then
  begin
    MessageDlg('No DestinationFile for ' + Self.Name , mtError, [mbOK], 0);
    exit;
  end;

  DeleteIECacheFile(URL);

  BSC := TBindStatusCallback.Create(Self);
  try
    Result := (URLDownloadToFile(nil, PChar(fSrcFile), PChar(fDestFile), 0, BSC) = 0)
           and(not Aborted);
  finally
    BSC.Free;  BSC := nil;
  end;
end;

procedure TDownload.Finished(Sender: TObject);
begin
  if Assigned(fOnFinished)then
    fOnFinished(Self);
end;

procedure TDownload.Progress(BytesDone, TotalBytes: Cardinal);
begin
  if Assigned(FOnProgress) then
    FOnProgress(BytesDone, TotalBytes);
end;

procedure TDownload.Starting(Sender: TObject);
begin
  if Assigned(fOnStarting) then
    fOnStarting(Self);
end;

procedure TDownload.Status(Code: Cardinal; Msg: string);
begin
  if Assigned(FOnStatus) then
    FOnStatus(Code, Msg);
end;

procedure TDownload.Stop;
begin
  Aborted := True;
  if Assigned(BSC) then
    BSC.OnProgress(0,0,0,'');
end;

END.
