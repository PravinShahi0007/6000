unit UnitDSServerMain;

interface

uses
  SysUtils, Classes, DSServer, DSCommonServer, DSTCPServerTransport,
  WideStrings, FMTBcd, DB, SqlExpr, DBXCommon, DBClient, MidasLib,
  Dialogs, Windows, WinSock, Provider
  , DataSnap.DSProviderDataModuleAdapter, UnitScotFDServerContainer,
  Data.DBXFirebird;

type
  TDSServerMain = class(TDSServerModule)
    SQLConnToDB: TSQLConnection;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function ReadIPs: TStrings;
  public
    { Public declarations }
    function IpAddress : String;
    function ServerComputerName : String;

  end;

var
  DSServerMain: TDSServerMain;

implementation

{$R *.dfm}

uses UnitDSServerDB;

{ TDSMainServerModule }

function TDSServerMain.ServerComputerName: String;
var
  Buffer : array[0..255] of char;
  Size : DWORD;
begin
  if GetComputerName(Buffer, Size) then
    Result := Buffer
  else
    Result := '';
end;

procedure TDSServerMain.DSServerModuleCreate(Sender: TObject);
begin
  InitialDatabase(SQLConnToDB, GetServerDatabaseDirectory+POSDB_NAME);
  //SQLConnToDB is only here for initial Database, will replaced by FDconnection
end;

function TDSServerMain.IpAddress: String;
var
  iplist : TStrings;
begin
  iplist := ReadIPs;
  if iplist.Count > 0 then
     Result := iplist[0];
  iplist.Free;
end;

function TDSServerMain.ReadIPs: TStrings;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  Buffer: PAnsiChar;
  iI: Integer;
  PPtr: PaPInAddr;
  pHE: PHostEnt;
  GInitData: TWSAData;
begin
  WSAStartup($101, GInitData);
  Result := TStringList.Create;
  try
    Result.Clear;
    Buffer := '';
    GetHostName(Buffer, SizeOf(Buffer));
    pHE := GetHostByName(buffer);
    if pHE = nil then
       Exit;
    PPtr := PaPInAddr(pHE^.H_Addr_List);
    iI := 0;
    while pPtr^[iI] <> nil do
    begin
      Result.Add(String(Inet_NToA(PPtr^[iI]^)));
      Inc(iI);
    end;
  finally
    WSACleanup;
  end;
end;

end.
