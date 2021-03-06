unit VK.Likes;

interface

uses
  System.SysUtils, VK.Controller, VK.Types, VK.Entity.Common, VK.Entity.Profile,
  System.JSON, VK.Entity.Common.List;

type
  TVkLikesParams = record
    List: TParams;
    function &Type(Value: TVkItemType): Integer;
    function OwnerId(Value: Integer): Integer;
    function ItemId(Value: Integer): Integer;
    function PageUrl(Value: string): Integer;
    function Filter(Copies: Boolean): Integer;
    function FriendsOnly(Value: Boolean): Integer;
    function Count(Value: Integer): Integer;
    function Offset(Value: Integer): Integer;
    function SkipOwn(Value: Boolean): Integer;
  end;

  TLikesController = class(TVkController)
  public
    /// <summary>
    /// �������� ������ �������������, ������� �������� �������� ������ � ���� ������ ��� ��������
    /// </summary>
    function GetList(var Items: TVkProfiles; Params: TParams): Boolean; overload;
    /// <summary>
    /// �������� ������ �������������, ������� �������� �������� ������ � ���� ������ ��� ��������
    /// </summary>
    function GetList(var Items: TVkProfiles; Params: TVkLikesParams): Boolean; overload;
    /// <summary>
    /// �������� ������ ��������������� �������������, ������� �������� �������� ������ � ���� ������ ��� ��������
    /// </summary>
    function GetListIds(var Items: TVkIdList; Params: TVkLikesParams): Boolean; overload;
    /// <summary>
    /// �������� ������ �������������, ������� �������� �������� ������ � ���� ������ ��� ��������
    /// </summary>
    function Add(var Items: Integer; &Type: TVkItemType; OwnerId, ItemId: Integer; AccessKey: string = ''): Boolean; overload;
    /// <summary>
    /// ������� ��������� ������ �� ������ ��� �������� �������� ������������
    /// </summary>
    function Delete(var Items: Integer; &Type: TVkItemType; OwnerId, ItemId: Integer; AccessKey: string = ''): Boolean; overload;
    /// <summary>
    /// ���������, ��������� �� ������ � ������ ��� �������� ��������� ������������.
    /// </summary>
    function IsLiked(var Item: TVkLiked; UserId: Integer; &Type: TVkItemType; OwnerId, ItemId: Integer): Boolean; overload;
  end;

implementation

uses
  VK.API, VK.CommonUtils;

{ TLikesController }

function TLikesController.Add(var Items: Integer; &Type: TVkItemType; OwnerId, ItemId: Integer; AccessKey: string): Boolean;
begin
  Result := Handler.Execute('likes.add', [
    ['type', &Type.ToString],
    ['owner_id', OwnerId.ToString],
    ['item_id', ItemId.ToString],
    ['access_key', AccessKey]]).
    ResponseAsInt(Items);
end;

function TLikesController.Delete(var Items: Integer; &Type: TVkItemType; OwnerId, ItemId: Integer; AccessKey: string): Boolean;
begin
  Result := Handler.Execute('likes.delete', [
    ['type', &Type.ToString],
    ['owner_id', OwnerId.ToString],
    ['item_id', ItemId.ToString],
    ['access_key', AccessKey]]).
    ResponseAsInt(Items);
end;

function TLikesController.GetList(var Items: TVkProfiles; Params: TVkLikesParams): Boolean;
begin
  Result := GetList(Items, Params.List);
end;

function TLikesController.GetListIds(var Items: TVkIdList; Params: TVkLikesParams): Boolean;
begin
  Params.List.Add('extended', False);
  Result := Handler.Execute('likes.getList', Params.List).GetObject<TVkIdList>(Items);
end;

function TLikesController.IsLiked(var Item: TVkLiked; UserId: Integer; &Type: TVkItemType; OwnerId, ItemId: Integer): Boolean;
begin
  Result := Handler.Execute('likes.isLiked', [
    ['type', &Type.ToString],
    ['owner_id', OwnerId.ToString],
    ['item_id', ItemId.ToString],
    ['user_id', UserId.ToString]]).
    GetObject<TVkLiked>(Item);
end;

function TLikesController.GetList(var Items: TVkProfiles; Params: TParams): Boolean;
begin
  Params.Add('extended', True);
  Result := Handler.Execute('likes.getList', Params).GetObject<TVkProfiles>(Items);
end;

{ TVkLikesParams }

function TVkLikesParams.Count(Value: Integer): Integer;
begin
  Result := List.Add('count', Value);
end;

function TVkLikesParams.Filter(Copies: Boolean): Integer;
begin
  if Copies then
    Result := List.Add('filter', 'copies')
  else
  begin
    List.Remove('filter');
    Result := -1;
  end;
end;

function TVkLikesParams.FriendsOnly(Value: Boolean): Integer;
begin
  Result := List.Add('friends_only', BoolToString(Value));
end;

function TVkLikesParams.ItemId(Value: Integer): Integer;
begin
  Result := List.Add('item_id', Value);
end;

function TVkLikesParams.&Type(Value: TVkItemType): Integer;
begin
  Result := List.Add('type', Value.ToString);
end;

function TVkLikesParams.Offset(Value: Integer): Integer;
begin
  Result := List.Add('offset', Value);
end;

function TVkLikesParams.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkLikesParams.PageUrl(Value: string): Integer;
begin
  Result := List.Add('page_url', Value);
end;

function TVkLikesParams.SkipOwn(Value: Boolean): Integer;
begin
  Result := List.Add('skip_own', BoolToString(Value));
end;

end.

