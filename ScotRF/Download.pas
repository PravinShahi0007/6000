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
  TDownload = class(TComponent, IBindStatusCallback)
  private    { Private declarations }
    fSrcFile: string;
    fDestFile: string;
    fOnDownloadProgress: TDownloadProgressEvent;
    fOnStatus: TDownloadStatusEvent;
    fOnStarting: TNotifyEvent;
    fOnFinished: TNotifyEvent;
    fAborted: Bool;
    //Events
    procedure DownloadProgress(BytesDone, TotalBytes: Cardinal); dynamic;
    procedure Status(Code: Cardinal; Msg: string); dynamic;
    procedure Starting(Sender: TObject); dynamic;
    procedure Finished(Sender: TObject); dynamic;
  protected  { Protected declarations }
    { IBindStatusCallback, only OnProgress is implemented }
    function OnProgress(ulProgress: Cardinal; ulProgressMax: Cardinal;
                   ulStatusCode: Cardinal; szStatusText: PWideChar): HRESULT; stdcall;
    function GetBindInfo(out grfBINDF: Cardinal; var bindinfo: _tagBINDINFO): HRESULT; stdcall;
    function GetPriority(out nPriority): HRESULT; stdcall;
    function OnDataAvailable(grfBSCF: Cardinal; dwSize: Cardinal;
                   formatetc: PFormatEtc; stgmed: PStgMedium): HRESULT; stdcall;
    function OnLowResource(reserved: Cardinal): HRESULT; stdcall;
    function OnObjectAvailable(const iid: TGUID; punk: IUnknown): HRESULT; stdcall;
    function OnStartBinding(dwReserved: Cardinal; pib: IBinding): HRESULT; stdcall;
    function OnStopBinding(hresult: HRESULT; szError: PWideChar): HRESULT; stdcall;
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
    property OnDownloadProgress: TDownloadProgressEvent read fOnDownloadProgress write fOnDownloadProgress;
    property OnStatus: TDownloadStatusEvent read fOnStatus write fOnStatus;
    property OnStartingDownload: TNotifyEvent read fOnStarting write fOnStarting;
    property OnFinishedDownload: TNotifyEvent read fOnFinished write fOnFinished;
  end;

  function DownloadStatusCodeToStr(Code: Cardinal): string;

procedure Register;

implementation

uses
  WinInet;    //for DeleteIECacheFile

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
    BINDSTATUS_ENDDOWNLOADDATA:   Result := 'Finished';           //6
    BINDSTATUS_SENDINGREQUEST:    Result := 'Sending request';    //11
  end;
end;

{**************************** TDownload ***********************************}

constructor TDownload.Create(AOwner: TComponent);
begin
  inherited;
  Aborted := False;
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

  Result := (URLDownloadToFile(nil, PChar(fSrcFile), PChar(fDestFile), 0, Self) = 0)
           and(not Aborted);
end;

procedure TDownload.Finished(Sender: TObject);
begin
  if Assigned(fOnFinished)then
    fOnFinished(Self);
end;

procedure TDownload.DownloadProgress(BytesDone, TotalBytes: Cardinal);
begin
  if Assigned(fOnDownloadProgress) then
    fOnDownloadProgress(BytesDone, TotalBytes);
end;

procedure TDownload.Starting(Sender: TObject);
begin
  if Assigned(fOnStarting) then
    fOnStarting(Self);
end;

procedure TDownload.Status(Code: Cardinal; Msg: string);
begin
  if Assigned(FOnStatus) then
    fOnStatus(Code, Msg);
end;

procedure TDownload.Stop;
begin
  Aborted := True;
  OnProgress(0, 0, BINDSTATUS_ENDDOWNLOADDATA, '');
end;

{------------ IBindStatusCallback ----------------------}
function TDownload.OnProgress(ulProgress, ulProgressMax, ulStatusCode: Cardinal;
           szStatusText: PWideChar): HRESULT;
begin
  if Aborted then
  begin
    Finished(nil);
    Status(BINDSTATUS_ENDDOWNLOADDATA, 'Aborted');
    Result := E_ABORT;
    exit;
  end;
  DownloadProgress(ulProgress, ulProgressMax);
  Status(ulStatusCode, szStatusText);
  case ulStatusCode of
    BINDSTATUS_BEGINDOWNLOADDATA: Starting(nil);
    BINDSTATUS_ENDDOWNLOADDATA:   Finished(nil);
  end;

  Result := S_OK;
end;

function TDownload.GetBindInfo(out grfBINDF: Cardinal; var bindinfo: _tagBINDINFO): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TDownload.GetPriority(out nPriority): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TDownload.OnDataAvailable(grfBSCF, dwSize: Cardinal;
           formatetc: PFormatEtc; stgmed: PStgMedium): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TDownload.OnLowResource(reserved: Cardinal): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TDownload.OnObjectAvailable(const iid: TGUID; punk: IInterface): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TDownload.OnStartBinding(dwReserved: Cardinal; pib: IBinding): HRESULT;
begin
  Result := E_NOTIMPL;
end;

function TDownload.OnStopBinding(hresult: HRESULT; szError: PWideChar): HRESULT;
begin
  Result := E_NOTIMPL;
end;
{------------end of IBindStatusCallback routines ----------------------}

END.
