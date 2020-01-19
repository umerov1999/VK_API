unit VK.LongPollServer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, Vcl.Dialogs, System.Classes, System.Variants,
  REST.Client, System.JSON, System.Net.HttpClient, VK.Types, System.Generics.Collections;

type
  TLongPollServer = class;

  TGroupLongPollServers = class(TList<TLongPollServer>)
    function Find(GroupID: string): Integer;
    procedure Clear;
  end;

  TLongPollData = record
    key: string;
    wait: string;
    ts: string;
    server: string;
    version: string;
    function Requset: string;
  end;

  TLongPollServer = class
  private
    FThread: TThread;
    FLongPollNeedStop: Boolean;
    FLongPollData: TLongPollData;
    FParams: TParams;
    FMethod: string;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    FOnError: TOnVKError;
    FInterval: Integer;
    FGroupID: string;
    FOnUpdate: TOnLongPollServerUpdate;
    function QueryLongPollServer: Boolean;
    procedure DoError(Text: string);
    procedure OnLongPollRecieve(Response: TJSONValue);
    procedure SetOnError(const Value: TOnVKError);
    procedure SetInterval(const Value: Integer);
    procedure SetGroupID(const Value: string);
    procedure SetOnUpdate(const Value: TOnLongPollServerUpdate);
    procedure SetClient(const Value: TCustomRESTClient);
    function GetClient: TCustomRESTClient;
    procedure SetMethod(const Value: string);
    procedure SetParams(const Value: TParams);
  public
    function Start: Boolean;
    procedure Stop;
    constructor Create; overload;
    constructor Create(AClient: TRESTClient; AMethod: string; AParams: TParams); overload;
    destructor Destroy; override;
    property OnError: TOnVKError read FOnError write SetOnError;
    property Interval: Integer read FInterval write SetInterval;
    property GroupID: string read FGroupID write SetGroupID;
    property OnUpdate: TOnLongPollServerUpdate read FOnUpdate write SetOnUpdate;
    property Client: TCustomRESTClient read GetClient write SetClient;
    property Method: string read FMethod write SetMethod;
    property Params: TParams read FParams write SetParams;
  end;

const
  DefaultLongPollServerInterval = 1000;

implementation

{ TLongPollServer }

constructor TLongPollServer.Create(AClient: TRESTClient; AMethod: string; AParams: TParams);
begin
  inherited Create;
  Method := AMethod;
  Params := AParams;
  Client := AClient;
end;

constructor TLongPollServer.Create;
begin
  inherited;
  FInterval := DefaultLongPollServerInterval;
  //Response
  RESTResponse := TRESTResponse.Create(nil);
  RESTResponse.ContentType := 'text/html';
  //Request
  RESTRequest := TRESTRequest.Create(nil);
  RESTRequest.Response := RESTResponse;
end;

destructor TLongPollServer.Destroy;
begin
  Stop;
  RESTResponse.Free;
  RESTRequest.Free;
  inherited;
end;

procedure TLongPollServer.DoError(Text: string);
begin
  if Assigned(FOnError) then
    FOnError(Self, -10000, Text);
end;

function TLongPollServer.GetClient: TCustomRESTClient;
begin
  Result := RESTRequest.Client;
end;

function TLongPollServer.QueryLongPollServer: Boolean;
var
  i: Integer;
  JSON: TJSONValue;
begin
  RESTRequest.Params.Clear;
  for i := Low(FParams) to High(FParams) do
    RESTRequest.AddParameter(FParams[i][0], FParams[i][1]);
  RESTRequest.Resource := FMethod;
  RESTRequest.Execute;

  JSON := RESTResponse.JSONValue;
  if RESTResponse.JSONValue.TryGetValue<TJSONValue>('response', JSON) then
  begin
    FLongPollData.key := JSON.GetValue('key', '');
    FLongPollData.server := JSON.GetValue('server', '');
    FLongPollData.ts := JSON.GetValue('ts', '');
    FLongPollData.wait := '25';
    FLongPollData.version := '3';
    Result := not FLongPollData.server.IsEmpty;
  end
  else
  begin
    DoError('QueryLongPollServer error '#13#10 + JSON.ToString);
    Exit(False);
  end;
end;

procedure TLongPollServer.OnLongPollRecieve(Response: TJSONValue);
var
  Updates: TJSONArray;
  i: Integer;
begin
  if not Assigned(FOnUpdate) then
    raise Exception.Create('���������� ����������� ������� ���������� �������� ����������');
  if Response.TryGetValue<TJSONArray>('updates', Updates) then
  begin
    for i := 0 to Updates.Count - 1 do
      FOnUpdate(Self, FGroupID, Updates.Items[i]);
  end
  else
  begin
    if not QueryLongPollServer then
    begin
      DoError(Response.ToString);
      FLongPollNeedStop := True;
    end;
  end;
end;

procedure TLongPollServer.SetClient(const Value: TCustomRESTClient);
begin
  RESTRequest.Client := Value;
end;

procedure TLongPollServer.SetGroupID(const Value: string);
begin
  FGroupID := Value;
end;

procedure TLongPollServer.SetInterval(const Value: Integer);
begin
  FInterval := Value;
end;

procedure TLongPollServer.SetMethod(const Value: string);
begin
  FMethod := Value;
end;

procedure TLongPollServer.SetOnError(const Value: TOnVKError);
begin
  FOnError := Value;
end;

procedure TLongPollServer.SetOnUpdate(const Value: TOnLongPollServerUpdate);
begin
  FOnUpdate := Value;
end;

procedure TLongPollServer.SetParams(const Value: TParams);
var
  Param: TParam;
begin
  FParams := Value;
  //�������� id ������, ���� ��� ��������
  for Param in FParams do
    if Param[0] = 'group_id' then
      FGroupID := Param[1];
end;

function TLongPollServer.Start: Boolean;
begin
  Result := False;
  FLongPollNeedStop := False;
  //
  if not QueryLongPollServer then
    Exit;
  FThread := TThread.CreateAnonymousThread(
    procedure
    var
      HTTP: THTTPClient;
      Stream: TStringStream;
      JSON: TJSONValue;
    begin
      HTTP := THTTPClient.Create;
      Stream := TStringStream.Create;
      try
        while (not TThread.CurrentThread.CheckTerminated) and (not FLongPollNeedStop) do
        begin
          Stream.Clear;
          HTTP.Get(FLongPollData.Requset, Stream);
          if FLongPollNeedStop then
            Break;
          JSON := TJSONObject.ParseJSONValue(UTF8ToString(Stream.DataString));
          if Assigned(JSON) then
          begin
            FLongPollData.ts := JSON.GetValue('ts', '');
            if FLongPollNeedStop then
              Break;
            TThread.Synchronize(TThread.CurrentThread,
              procedure
              begin
                OnLongPollRecieve(JSON);
              end);
            JSON.Free;
          end;
          Sleep(FInterval);
        end;
      except
        on E: Exception do
          DoError(E.Message);
      end;
      HTTP.Free;
      Stream.Free;
    end);
  FThread.FreeOnTerminate := False;
  FThread.Start;
  Result := True;
end;

procedure TLongPollServer.Stop;
begin
  FLongPollNeedStop := True;
  if Assigned(FThread) then
  begin
    FThread.Terminate;
    FThread.WaitFor;
    FThread.Free;
    FThread := nil;
  end;
end;

{ TLongPollData }

function TLongPollData.Requset: string;
begin
  Result := server + '?act=a_check&key=' + key + '&ts=' + ts + '&' + wait + '=25&version=' + version;
  if Pos('http', Result) = 0 then
    Result := 'http://' + Result;
end;

{ TGroupLongPollServers }

procedure TGroupLongPollServers.Clear;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].Free;
  inherited;
end;

function TGroupLongPollServers.Find(GroupID: string): Integer;
var
  i: Integer;
  Param: TParam;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    for Param in Items[i].FParams do
      if Param[0] = 'group_id' then
        if Param[1] = GroupID then
          Exit(i);
  end;
end;

end.
