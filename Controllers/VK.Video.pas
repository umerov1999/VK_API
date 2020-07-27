unit VK.Video;

interface

uses
  System.SysUtils, System.Generics.Collections, REST.Client, VK.Controller, VK.Types, VK.Entity.Video, System.JSON,
  VK.Entity.Status, VK.Entity.Media, VK.Entity.Video.Save;

type
  TVkVideosFilter = (vfMP4, vfYouTube, vfVimeo, vfShort, vfLong);

  TVkVideosFilterHelper = record helper for TVkVideosFilter
    function ToString: string; inline;
  end;

  TVkVideosFilters = set of TVkVideosFilter;

  TVkVideosFiltersHelper = record helper for TVkVideosFilters
    function ToString: string; inline;
    class function All: TVkVideosFilters; static; inline;
  end;

  TVkParamsVideosGet = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function AlbumId(Value: Integer): Integer;
    function Extended(Value: Boolean): Integer;
    function Count(Value: Integer): Integer;
    function Offset(Value: Integer): Integer;
    function Videos(Value: TArrayOfString): Integer;
  end;

  TVkParamsVideoGetAlbums = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function Count(Value: Integer): Integer;
    function Offset(Value: Integer): Integer;
    function Extended(Value: Boolean): Integer;
    function NeedSystem(Value: Boolean): Integer;
  end;

  TVkParamsVideosAddToAlbum = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function TargetId(Value: Integer): Integer;
    function AlbumId(Value: Integer): Integer;
    function AlbumIds(Value: TIds): Integer;
    function VideoId(Value: Integer): Integer;
  end;

  TVkParamsVideosCreateComment = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function VideoId(Value: Integer): Integer;
    function Message(Value: string): Integer;
    function Attachments(Value: TAttachmentArray): Integer;
    function FromGroup(Value: Integer): Integer;
    function ReplyToComment(Value: Integer): Integer;
    function StickerId(Value: Integer): Integer;
    function Guid(Value: string): Integer;
  end;

  TVkParamsVideosEdit = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function VideoId(Value: Integer): Integer;
    function Name(Value: string): Integer;
    function Desc(Value: string): Integer;
    function PrivacyView(Value: TArrayOfString): Integer;
    function PrivacyComment(Value: TArrayOfString): Integer;
    function NoComments(Value: Boolean): Integer;
    function &Repeat(Value: Boolean): Integer;
  end;

  TVkParamsVideosEditAlbum = record
    List: TParams;
    function GroupId(Value: Integer): Integer;
    function AlbumId(Value: Integer): Integer;
    function Title(Value: string): Integer;
    function Privacy(Value: TArrayOfString): Integer;
  end;

  TVkParamsVideosEditComment = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function CommentId(Value: Integer): Integer;
    function Message(Value: string): Integer;
    function Attachments(Value: TIds): Integer;
  end;

  TVkParamsVideoGetComments = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function VideoId(Value: Integer): Integer;
    function NeedLikes(Value: Boolean): Integer;
    function StartCommentId(Value: Integer): Integer;
    function Offset(Value: Integer): Integer;
    function Count(Value: Integer): Integer;
    function Sort(Value: TVkSort): Integer;
    function Extended(Value: Boolean): Integer;
    function Fields(UserFields: TVkUserFields = []; GroupFields: TVkGroupFields = []): Integer;
  end;

  TVkParamsVideoRemoveFromAlbum = record
    List: TParams;
    function TargetId(Value: Integer): Integer;
    function AlbumId(Value: Integer): Integer;
    function AlbumIds(Value: TIds): Integer;
    function OwnerId(Value: Integer): Integer;
    function VideoId(Value: Integer): Integer;
  end;

  TVkParamsVideoReorderAlbums = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function AlbumId(Value: Integer): Integer;
    function Before(Value: Integer): Integer;
    function After(Value: Integer): Integer;
  end;

  TVkParamsVideoReorderVideos = record
    List: TParams;
    function TargetId(Value: Integer): Integer;
    function AlbumId(Value: Integer): Integer;
    function OwnerId(Value: Integer): Integer;
    function VideoId(Value: Integer): Integer;
    function BeforeOwnerId(Value: Integer): Integer;
    function BeforeVideoId(Value: Integer): Integer;
    function AfterOwnerId(Value: Integer): Integer;
    function AfterVideoId(Value: Integer): Integer;
  end;

  TVkParamsVideosReport = record
    List: TParams;
    function OwnerId(Value: Integer): Integer;
    function VideoId(Value: Integer): Integer;
    function Reason(Value: TVkMediaReportReason): Integer;
    function Comment(Value: string): Integer;
    function SearchQuery(Value: string): Integer;
  end;

  TVkParamsVideosSave = record
    List: TParams;
    function Name(Value: string): Integer;
    function Description(Value: string): Integer;
    function IsPrivate(Value: Boolean): Integer;
    function Wallpost(Value: Boolean): Integer;
    function Link(Value: string): Integer;
    function GroupId(Value: Integer): Integer;
    function AlbumId(Value: Integer): Integer;
    function PrivacyView(Value: TArrayOfString): Integer;
    function PrivacyComment(Value: TArrayOfString): Integer;
    function NoComments(Value: Boolean): Integer;
    function &Repeat(Value: Boolean): Integer;
    function Compression(Value: Boolean): Integer;
  end;

  TVkParamsVideosSearch = record
    List: TParams;
    function Query(Value: string): Integer;
    function Sort(Value: Integer): Integer;
    function Hd(Value: Integer): Integer;
    function Adult(Value: Boolean): Integer;
    function Filters(Value: TVkVideosFilters): Integer;
    function SearchOwn(Value: Boolean): Integer;
    function Offset(Value: Integer): Integer;
    function Longer(Value: Integer): Integer;
    function Shorter(Value: Integer): Integer;
    function Count(Value: Integer): Integer;
    function Extended(Value: Boolean): Integer;
  end;

  TVideoController = class(TVkController)
  public
    /// <summary>
    /// ��������� ����������� � ������ ������������.
    /// </summary>
    function Add(const VideoId, OwnerId: Integer; TargetId: Integer = 0): Boolean;
    /// <summary>
    /// ������� ������ ������ ������������.
    /// </summary>
    function AddAlbum(var AlbumId: Integer; Title: string; Privacy: TArrayOfString = []; GroupId: Integer = 0): Boolean;
    /// <summary>
    /// ��������� �������� ����������� � ������.
    /// </summary>
    function AddToAlbum(Params: TParams): Boolean; overload;
    /// <summary>
    /// ��������� �������� ����������� � ������.
    /// </summary>
    function AddToAlbum(Params: TVkParamsVideosAddToAlbum): Boolean; overload;
    /// <summary>
    /// C������ ����� ����������� � �����������
    /// </summary>
    function CreateComment(var CommentId: Integer; Params: TParams): Boolean; overload;
    /// <summary>
    /// C������ ����� ����������� � �����������
    /// </summary>
    function CreateComment(var CommentId: Integer; Params: TVkParamsVideosCreateComment): Boolean; overload;
    /// <summary>
    /// ������� ����������� �� �������� ������������.
    /// </summary>
    function Delete(const VideoId, OwnerId: Integer; TargetId: Integer = 0): Boolean;
    /// <summary>
    /// ������� ������ ������������.
    /// </summary>
    function DeleteAlbum(const AlbumId: Integer; GroupId: Integer = 0): Boolean;
    /// <summary>
    /// ������� ����������� � �����������.
    /// </summary>
    function DeleteComment(const CommentId: Integer; OwnerId: Integer = 0): Boolean;
    /// <summary>
    /// C������ ����� ����������� � �����������
    /// </summary>
    function Edit(Params: TParams): Boolean; overload;
    /// <summary>
    /// C������ ����� ����������� � �����������
    /// </summary>
    function Edit(Params: TVkParamsVideosEdit): Boolean; overload;
    /// <summary>
    /// ����������� ������ � �����.
    /// </summary>
    function EditAlbum(Params: TParams): Boolean; overload;
    /// <summary>
    /// ����������� ������ � �����.
    /// </summary>
    function EditAlbum(Params: TVkParamsVideosEditAlbum): Boolean; overload;
    /// <summary>
    /// �������� ����� ����������� � �����������.
    /// </summary>
    function EditComment(Params: TParams): Boolean; overload;
    /// <summary>
    /// �������� ����� ����������� � �����������.
    /// </summary>
    function EditComment(Params: TVkParamsVideosEditComment): Boolean; overload;
    /// <summary>
    /// ���������� ���������� � ������������.
    /// </summary>
    function Get(var Items: TVkVideos; Params: TParams): Boolean; overload;
    /// <summary>
    /// ���������� ���������� � ������������.
    /// </summary>
    function Get(var Items: TVkVideos; Params: TVkParamsVideosGet): Boolean; overload;
    /// <summary>
    /// ��������� �������� ���������� �� ������� � �����.
    /// </summary>
    function GetAlbumById(var Item: TVkVideoAlbum; AlbumId: Integer; OwnerId: Integer = 0): Boolean; overload;
    /// <summary>
    /// ��������� �������� ���������� �� ������� � �����.
    /// </summary>
    function GetAlbums(var Items: TVkVideoAlbums; Params: TParams): Boolean; overload;
    /// <summary>
    /// ��������� �������� ���������� �� ������� � �����.
    /// </summary>
    function GetAlbums(var Items: TVkVideoAlbums; Params: TVkParamsVideoGetAlbums): Boolean; overload;
    /// <summary>
    /// ���������� ������ ��������, � ������� ��������� �����������.
    /// </summary>
    function GetAlbumsByVideo(var Items: TVkVideoAlbums; const VideoId, OwnerId: Integer; TargetId: Integer = 0):
      Boolean; overload;
    /// <summary>
    /// ���������� ������ ������������ � �����������.
    /// </summary>
    function GetComments(var Items: TVkComments; Params: TParams): Boolean; overload;
    /// <summary>
    /// ���������� ������ ������������ � �����������.
    /// </summary>
    function GetComments(var Items: TVkComments; Params: TVkParamsVideoGetComments): Boolean; overload;
    /// <summary>
    /// ��������� ������ ����������� �� �������.
    /// </summary>
    function RemoveFromAlbum(Params: TParams): Boolean; overload;
    /// <summary>
    /// ��������� ������ ����������� �� �������.
    /// </summary>
    function RemoveFromAlbum(Params: TVkParamsVideoRemoveFromAlbum): Boolean; overload;
    /// <summary>
    /// ��������� �������� ������� �������� � �����.
    /// </summary>
    function ReorderAlbums(Params: TParams): Boolean; overload;
    /// <summary>
    /// ��������� �������� ������� �������� � �����.
    /// </summary>
    function ReorderAlbums(Params: TVkParamsVideoReorderAlbums): Boolean; overload;
    /// <summary>
    /// ��������� ����������� ����������� � �������.
    /// </summary>
    function ReorderVideos(Params: TParams): Boolean; overload;
    /// <summary>
    /// ��������� ����������� ����������� � �������.
    /// </summary>
    function ReorderVideos(Params: TVkParamsVideoReorderVideos): Boolean; overload;
    /// <summary>
    /// ��������� ������������ �� �����������.
    /// </summary>
    function Report(Params: TParams): Boolean; overload;
    /// <summary>
    /// ��������� ������������ �� �����������.
    /// </summary>
    function Report(Params: TVkParamsVideosReport): Boolean; overload;
    /// <summary>
    /// ��������� ������������ �� ����������� � �����������.
    /// </summary>
    function ReportComment(OwnerId, CommentId: Integer; Reason: TVkMediaReportReason): Boolean; overload;
    /// <summary>
    /// ��������������� ��������� �����������.
    /// </summary>
    function Restore(VideoId: Integer; OwnerId: Integer = 0): Boolean;
    /// <summary>
    /// ��������������� ��������� ����������� � �����������.
    /// </summary>
    function RestoreComment(CommentId: Integer; OwnerId: Integer = 0): Boolean;
    /// <summary>
    /// ���������� ����� �������, ����������� ��� ��������, � ������ �����������.
    /// </summary>
    function Save(var VideoSaved: TVkVideoSaved; Params: TParams): Boolean; overload;
    /// <summary>
    /// ���������� ����� �������, ����������� ��� ��������, � ������ �����������.
    /// </summary>
    function Save(var VideoSaved: TVkVideoSaved; Params: TVkParamsVideosSave): Boolean; overload;
    /// <summary>
    /// ���������� ����� �������, ����������� ��� ��������, � ������ �����������.
    /// </summary>
    function Save(var VideoSaved: TVkVideoSaved; Link: string): Boolean; overload;
    /// <summary>
    /// ���������� ������ ������������ � ������������ � �������� ��������� ������.
    /// </summary>
    function Search(var Items: TVkVideos; Params: TParams): Boolean; overload;
    /// <summary>
    /// ���������� ������ ������������ � ������������ � �������� ��������� ������.
    /// </summary>
    function Search(var Items: TVkVideos; Params: TVkParamsVideosSearch): Boolean; overload;
  end;

implementation

uses
  VK.API, VK.CommonUtils;

{ TVideoController }

function TVideoController.GetAlbums(var Items: TVkVideoAlbums; Params: TParams): Boolean;
begin
  with Handler.Execute('video.getAlbums', Params) do
  begin
    Result := Success;
    if Result then
    begin
      try
        Items := TVkVideoAlbums.FromJsonString(Response);
      except
        Result := False;
      end;
    end;
  end;
end;

function TVideoController.GetAlbums(var Items: TVkVideoAlbums; Params: TVkParamsVideoGetAlbums): Boolean;
begin
  Result := GetAlbums(Items, Params.List);
end;

function TVideoController.GetAlbumsByVideo(var Items: TVkVideoAlbums; const VideoId, OwnerId: Integer; TargetId: Integer):
  Boolean;
var
  Params: TParams;
begin
  Params.Add('video_id', VideoId);
  Params.Add('owner_id', OwnerId);
  if TargetId <> 0 then
    Params.Add('target_id', TargetId);
  Params.Add('extended', True);
  with Handler.Execute('video.getAlbumsByVideo', Params) do
  begin
    Result := Success;
    if Result then
    begin
      try
        Items := TVkVideoAlbums.FromJsonString(Response);
      except
        Result := False;
      end;
    end;
  end;
end;

function TVideoController.GetComments(var Items: TVkComments; Params: TVkParamsVideoGetComments): Boolean;
begin
  Result := GetComments(Items, Params.List);
end;

function TVideoController.RemoveFromAlbum(Params: TVkParamsVideoRemoveFromAlbum): Boolean;
begin
  Result := RemoveFromAlbum(Params.List);
end;

function TVideoController.ReorderAlbums(Params: TVkParamsVideoReorderAlbums): Boolean;
begin
  Result := ReorderAlbums(Params.List);
end;

function TVideoController.ReorderVideos(Params: TVkParamsVideoReorderVideos): Boolean;
begin
  Result := ReorderVideos(Params.List);
end;

function TVideoController.Report(Params: TVkParamsVideosReport): Boolean;
begin
  Result := Report(Params.List);
end;

function TVideoController.ReportComment(OwnerId, CommentId: Integer; Reason: TVkMediaReportReason): Boolean;
var
  Params: TParams;
begin
  Params.Add('owner_id', OwnerId);
  Params.Add('comment_id', CommentId);
  Params.Add('reason', Reason.ToConst.ToString);
  with Handler.Execute('video.reportComment', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.Restore(VideoId, OwnerId: Integer): Boolean;
var
  Params: TParams;
begin
  Params.Add('video_id', VideoId);
  if OwnerId <> 0 then
    Params.Add('owner_id', OwnerId);
  with Handler.Execute('video.restore', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.RestoreComment(CommentId, OwnerId: Integer): Boolean;
var
  Params: TParams;
begin
  Params.Add('comment_id', CommentId);
  if OwnerId <> 0 then
    Params.Add('owner_id', OwnerId);
  with Handler.Execute('video.restoreComment', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.Save(var VideoSaved: TVkVideoSaved; Params: TVkParamsVideosSave): Boolean;
begin
  Result := Save(VideoSaved, Params.List);
end;

function TVideoController.Save(var VideoSaved: TVkVideoSaved; Params: TParams): Boolean;
begin
  with Handler.Execute('video.save', Params) do
  begin
    Result := Success;
    if Result then
    begin
      try
        VideoSaved := TVkVideoSaved.FromJsonString(Response);
      except
        Result := False;
      end;
    end;
  end;
end;

function TVideoController.Report(Params: TParams): Boolean;
begin
  with Handler.Execute('video.report', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.ReorderVideos(Params: TParams): Boolean;
begin
  with Handler.Execute('video.reorderVideos', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.ReorderAlbums(Params: TParams): Boolean;
begin
  with Handler.Execute('video.reorderAlbums', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.RemoveFromAlbum(Params: TParams): Boolean;
begin
  with Handler.Execute('video.removeFromAlbum', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.GetComments(var Items: TVkComments; Params: TParams): Boolean;
begin
  with Handler.Execute('video.getComments', Params) do
  begin
    Result := Success;
    if Result then
    begin
      try
        Items := TVkComments.FromJsonString(Response);
      except
        Result := False;
      end;
    end;
  end;
end;

function TVideoController.GetAlbumById(var Item: TVkVideoAlbum; AlbumId: Integer; OwnerId: Integer): Boolean;
var
  Params: TParams;
begin
  Params.Add('album_id', AlbumId);
  Params.Add('owner_id', OwnerId);
  with Handler.Execute('video.getAlbumById', Params) do
  begin
    Result := Success;
    if Result then
    begin
      try
        Item := TVkVideoAlbum.FromJsonString(Response);
      except
        Result := False;
      end;
    end;
  end;
end;

function TVideoController.Get(var Items: TVkVideos; Params: TParams): Boolean;
begin
  with Handler.Execute('video.get', Params) do
  begin
    Result := Success;
    if Result then
    begin
      try
        Items := TVkVideos.FromJsonString(Response);
      except
        Result := False;
      end;
    end;
  end;
end;

function TVideoController.Get(var Items: TVkVideos; Params: TVkParamsVideosGet): Boolean;
begin
  Result := Get(Items, Params.List);
end;

function TVideoController.Add(const VideoId, OwnerId: Integer; TargetId: Integer): Boolean;
var
  Params: TParams;
begin
  Params.Add('video_id', VideoId);
  Params.Add('owner_id', OwnerId);
  if TargetId <> 0 then
    Params.Add('target_id', TargetId);
  with Handler.Execute('video.add', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.AddAlbum(var AlbumId: Integer; Title: string; Privacy: TArrayOfString; GroupId: Integer): Boolean;
var
  Params: TParams;
begin
  Params.Add('title', Title);
  if Length(Privacy) > 0 then
    Params.Add('privacy', Privacy);
  if GroupId <> 0 then
    Params.Add('group_id', GroupId);
  with Handler.Execute('video.addAlbum', Params) do
    Result := Success and TryStrToInt(Response, AlbumId);
end;

function TVideoController.AddToAlbum(Params: TVkParamsVideosAddToAlbum): Boolean;
begin
  Result := AddToAlbum(Params.List);
end;

function TVideoController.CreateComment(var CommentId: Integer; Params: TVkParamsVideosCreateComment): Boolean;
begin
  Result := CreateComment(CommentId, Params.List);
end;

function TVideoController.Delete(const VideoId, OwnerId: Integer; TargetId: Integer): Boolean;
var
  Params: TParams;
begin
  Params.Add('video_id', VideoId);
  Params.Add('owner_id', OwnerId);
  if TargetId <> 0 then
    Params.Add('target_id', TargetId);
  with Handler.Execute('video.delete', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.DeleteAlbum(const AlbumId: Integer; GroupId: Integer): Boolean;
var
  Params: TParams;
begin
  Params.Add('album_id', AlbumId);
  if GroupId <> 0 then
    Params.Add('group_id', GroupId);
  with Handler.Execute('video.deleteAlbum', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.DeleteComment(const CommentId: Integer; OwnerId: Integer): Boolean;
var
  Params: TParams;
begin
  Params.Add('comment_id', CommentId);
  if OwnerId <> 0 then
    Params.Add('owner_id', OwnerId);
  with Handler.Execute('video.deleteComment', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.Edit(Params: TVkParamsVideosEdit): Boolean;
begin
  Result := Edit(Params.List);
end;

function TVideoController.EditAlbum(Params: TVkParamsVideosEditAlbum): Boolean;
begin
  Result := EditAlbum(Params.List);
end;

function TVideoController.EditComment(Params: TVkParamsVideosEditComment): Boolean;
begin
  Result := EditComment(Params.List);
end;

function TVideoController.EditComment(Params: TParams): Boolean;
begin
  with Handler.Execute('video.editComment', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.EditAlbum(Params: TParams): Boolean;
begin
  with Handler.Execute('video.editAlbum', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.Edit(Params: TParams): Boolean;
begin
  with Handler.Execute('video.edit', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.CreateComment(var CommentId: Integer; Params: TParams): Boolean;
begin
  with Handler.Execute('video.createComment', Params) do
    Result := Success and TryStrToInt(Response, CommentId);
end;

function TVideoController.AddToAlbum(Params: TParams): Boolean;
begin
  with Handler.Execute('video.addToAlbum', Params) do
    Result := Success and (Response = '1');
end;

function TVideoController.Save(var VideoSaved: TVkVideoSaved; Link: string): Boolean;
var
  Params: TParams;
  SaveResp: string;
begin
  Params.Add('link', Link);
  Result := False;
  with Handler.Execute('video.save', Params) do
  begin
    if Success then
    begin
      try
        VideoSaved := TVkVideoSaved.FromJsonString(Response);
        Result := True;
      except
        Result := False;
      end;
    end;
  end;
  if Result then
  begin
    Result := False;
    if TCustomVK(VK).Uploader.Upload(VideoSaved.UploadUrl, '', SaveResp) then
    begin
      Result := not SaveResp.IsEmpty;
    end
    else
      TCustomVK(VK).DoError(Self, TVkException.Create(SaveResp), -1, SaveResp);
  end;
end;

function TVideoController.Search(var Items: TVkVideos; Params: TVkParamsVideosSearch): Boolean;
begin
  Result := Search(Items, Params.List);
end;

function TVideoController.Search(var Items: TVkVideos; Params: TParams): Boolean;
begin
  with Handler.Execute('video.search', Params) do
  begin
    Result := Success;
    if Result then
    begin
      try
        Items := TVkVideos.FromJsonString(Response);
      except
        Result := False;
      end;
    end;
  end;
end;

{ TVkVideosGetParams }

function TVkParamsVideosGet.AlbumId(Value: Integer): Integer;
begin
  Result := List.Add('album_id', Value);
end;

function TVkParamsVideosGet.Count(Value: Integer): Integer;
begin
  Result := List.Add('count', Value);
end;

function TVkParamsVideosGet.Extended(Value: Boolean): Integer;
begin
  Result := List.Add('extended', Value);
end;

function TVkParamsVideosGet.Offset(Value: Integer): Integer;
begin
  Result := List.Add('offset', Value);
end;

function TVkParamsVideosGet.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsVideosGet.Videos(Value: TArrayOfString): Integer;
begin
  Result := List.Add('videos', Value.ToString);
end;

{ TVkParamsVideoAlbumsGet }

function TVkParamsVideoGetAlbums.Count(Value: Integer): Integer;
begin
  Result := List.Add('count', Value);
end;

function TVkParamsVideoGetAlbums.Extended(Value: Boolean): Integer;
begin
  Result := List.Add('extended', Value);
end;

function TVkParamsVideoGetAlbums.NeedSystem(Value: Boolean): Integer;
begin
  Result := List.Add('need_system', Value);
end;

function TVkParamsVideoGetAlbums.Offset(Value: Integer): Integer;
begin
  Result := List.Add('offset', Value);
end;

function TVkParamsVideoGetAlbums.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

{ TVkParamsVideosAddToAlbum }

function TVkParamsVideosAddToAlbum.AlbumId(Value: Integer): Integer;
begin
  Result := List.Add('album_id', Value);
end;

function TVkParamsVideosAddToAlbum.AlbumIds(Value: TIds): Integer;
begin
  Result := List.Add('album_ids', Value);
end;

function TVkParamsVideosAddToAlbum.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsVideosAddToAlbum.TargetId(Value: Integer): Integer;
begin
  Result := List.Add('target_id', Value);
end;

function TVkParamsVideosAddToAlbum.VideoId(Value: Integer): Integer;
begin
  Result := List.Add('video_id', Value);
end;

{ TVkParamsVideosCreateComment }

function TVkParamsVideosCreateComment.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsVideosCreateComment.VideoId(Value: Integer): Integer;
begin
  Result := List.Add('video_id', Value);
end;

function TVkParamsVideosCreateComment.Message(Value: string): Integer;
begin
  Result := List.Add('message', Value);
end;

function TVkParamsVideosCreateComment.Attachments(Value: TAttachmentArray): Integer;
begin
  Result := List.Add('attachments', Value);
end;

function TVkParamsVideosCreateComment.FromGroup(Value: Integer): Integer;
begin
  Result := List.Add('from_group', Value);
end;

function TVkParamsVideosCreateComment.ReplyToComment(Value: Integer): Integer;
begin
  Result := List.Add('reply_to_comment', Value);
end;

function TVkParamsVideosCreateComment.StickerId(Value: Integer): Integer;
begin
  Result := List.Add('sticker_id', Value);
end;

function TVkParamsVideosCreateComment.Guid(Value: string): Integer;
begin
  Result := List.Add('guid', Value);
end;

{ TVkParamsVideosEdit }

function TVkParamsVideosEdit.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsVideosEdit.VideoId(Value: Integer): Integer;
begin
  Result := List.Add('video_id', Value);
end;

function TVkParamsVideosEdit.Name(Value: string): Integer;
begin
  Result := List.Add('name', Value);
end;

function TVkParamsVideosEdit.Desc(Value: string): Integer;
begin
  Result := List.Add('desc', Value);
end;

function TVkParamsVideosEdit.PrivacyView(Value: TArrayOfString): Integer;
begin
  Result := List.Add('privacy_view', Value);
end;

function TVkParamsVideosEdit.PrivacyComment(Value: TArrayOfString): Integer;
begin
  Result := List.Add('privacy_comment', Value);
end;

function TVkParamsVideosEdit.NoComments(Value: Boolean): Integer;
begin
  Result := List.Add('no_comments', Value);
end;

function TVkParamsVideosEdit.&Repeat(Value: Boolean): Integer;
begin
  Result := List.Add('repeat', Value);
end;

{ TVkParamsVideosEditAlbum }

function TVkParamsVideosEditAlbum.GroupId(Value: Integer): Integer;
begin
  Result := List.Add('group_id', Value);
end;

function TVkParamsVideosEditAlbum.AlbumId(Value: Integer): Integer;
begin
  Result := List.Add('album_id', Value);
end;

function TVkParamsVideosEditAlbum.Title(Value: string): Integer;
begin
  Result := List.Add('title', Value);
end;

function TVkParamsVideosEditAlbum.Privacy(Value: TArrayOfString): Integer;
begin
  Result := List.Add('privacy', Value);
end;

{ TVkParamsVideosEditComment }

function TVkParamsVideosEditComment.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsVideosEditComment.CommentId(Value: Integer): Integer;
begin
  Result := List.Add('comment_id', Value);
end;

function TVkParamsVideosEditComment.Message(Value: string): Integer;
begin
  Result := List.Add('message', Value);
end;

function TVkParamsVideosEditComment.Attachments(Value: TIds): Integer;
begin
  Result := List.Add('attachments', Value);
end;

{ TVkParamsVideoGetComments }

function TVkParamsVideoGetComments.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsVideoGetComments.VideoId(Value: Integer): Integer;
begin
  Result := List.Add('video_id', Value);
end;

function TVkParamsVideoGetComments.NeedLikes(Value: Boolean): Integer;
begin
  Result := List.Add('need_likes', Value);
end;

function TVkParamsVideoGetComments.StartCommentId(Value: Integer): Integer;
begin
  Result := List.Add('start_comment_id', Value);
end;

function TVkParamsVideoGetComments.Offset(Value: Integer): Integer;
begin
  Result := List.Add('offset', Value);
end;

function TVkParamsVideoGetComments.Count(Value: Integer): Integer;
begin
  Result := List.Add('count', Value);
end;

function TVkParamsVideoGetComments.Sort(Value: TVkSort): Integer;
begin
  Result := List.Add('sort', Value.ToString);
end;

function TVkParamsVideoGetComments.Extended(Value: Boolean): Integer;
begin
  Result := List.Add('extended', Value);
end;

function TVkParamsVideoGetComments.Fields(UserFields: TVkUserFields; GroupFields: TVkGroupFields): Integer;
begin
  Result := List.Add('fields', [GroupFields.ToString, UserFields.ToString]);
end;

{ TVkParamsVideoRemoveFromAlbum }

function TVkParamsVideoRemoveFromAlbum.TargetId(Value: Integer): Integer;
begin
  Result := List.Add('target_id', Value);
end;

function TVkParamsVideoRemoveFromAlbum.AlbumId(Value: Integer): Integer;
begin
  Result := List.Add('album_id', Value);
end;

function TVkParamsVideoRemoveFromAlbum.AlbumIds(Value: TIds): Integer;
begin
  Result := List.Add('album_ids', Value);
end;

function TVkParamsVideoRemoveFromAlbum.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsVideoRemoveFromAlbum.VideoId(Value: Integer): Integer;
begin
  Result := List.Add('video_id', Value);
end;

{ TVkParamsVideoReorderAlbums }

function TVkParamsVideoReorderAlbums.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsVideoReorderAlbums.AlbumId(Value: Integer): Integer;
begin
  Result := List.Add('album_id', Value);
end;

function TVkParamsVideoReorderAlbums.Before(Value: Integer): Integer;
begin
  Result := List.Add('before', Value);
end;

function TVkParamsVideoReorderAlbums.After(Value: Integer): Integer;
begin
  Result := List.Add('after', Value);
end;

{ TVkParamsVideoReorderVideos }

function TVkParamsVideoReorderVideos.TargetId(Value: Integer): Integer;
begin
  Result := List.Add('target_id', Value);
end;

function TVkParamsVideoReorderVideos.AlbumId(Value: Integer): Integer;
begin
  Result := List.Add('album_id', Value);
end;

function TVkParamsVideoReorderVideos.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsVideoReorderVideos.VideoId(Value: Integer): Integer;
begin
  Result := List.Add('video_id', Value);
end;

function TVkParamsVideoReorderVideos.BeforeOwnerId(Value: Integer): Integer;
begin
  Result := List.Add('before_owner_id', Value);
end;

function TVkParamsVideoReorderVideos.BeforeVideoId(Value: Integer): Integer;
begin
  Result := List.Add('before_video_id', Value);
end;

function TVkParamsVideoReorderVideos.AfterOwnerId(Value: Integer): Integer;
begin
  Result := List.Add('after_owner_id', Value);
end;

function TVkParamsVideoReorderVideos.AfterVideoId(Value: Integer): Integer;
begin
  Result := List.Add('after_video_id', Value);
end;

{ TVkParamsVideosReport }

function TVkParamsVideosReport.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value);
end;

function TVkParamsVideosReport.VideoId(Value: Integer): Integer;
begin
  Result := List.Add('video_id', Value);
end;

function TVkParamsVideosReport.Reason(Value: TVkMediaReportReason): Integer;
begin
  Result := List.Add('reason', Value.ToConst.ToString);
end;

function TVkParamsVideosReport.Comment(Value: string): Integer;
begin
  Result := List.Add('comment', Value);
end;

function TVkParamsVideosReport.SearchQuery(Value: string): Integer;
begin
  Result := List.Add('search_query', Value);
end;

{ TVkParamsVideosSave }

function TVkParamsVideosSave.Name(Value: string): Integer;
begin
  Result := List.Add('name', Value);
end;

function TVkParamsVideosSave.Description(Value: string): Integer;
begin
  Result := List.Add('description', Value);
end;

function TVkParamsVideosSave.IsPrivate(Value: Boolean): Integer;
begin
  Result := List.Add('is_private', Value);
end;

function TVkParamsVideosSave.Wallpost(Value: Boolean): Integer;
begin
  Result := List.Add('wallpost', Value);
end;

function TVkParamsVideosSave.Link(Value: string): Integer;
begin
  Result := List.Add('link', Value);
end;

function TVkParamsVideosSave.GroupId(Value: Integer): Integer;
begin
  Result := List.Add('group_id', Value);
end;

function TVkParamsVideosSave.AlbumId(Value: Integer): Integer;
begin
  Result := List.Add('album_id', Value);
end;

function TVkParamsVideosSave.PrivacyView(Value: TArrayOfString): Integer;
begin
  Result := List.Add('privacy_view', Value);
end;

function TVkParamsVideosSave.PrivacyComment(Value: TArrayOfString): Integer;
begin
  Result := List.Add('privacy_comment', Value);
end;

function TVkParamsVideosSave.NoComments(Value: Boolean): Integer;
begin
  Result := List.Add('no_comments', Value);
end;

function TVkParamsVideosSave.&Repeat(Value: Boolean): Integer;
begin
  Result := List.Add('repeat', Value);
end;

function TVkParamsVideosSave.Compression(Value: Boolean): Integer;
begin
  Result := List.Add('compression', Value);
end;

{ TVkVideosFilterHelper }

function TVkVideosFilterHelper.ToString: string;
begin
  case Self of
    vfMP4:
      Result := 'mp4';
    vfYouTube:
      Result := 'youtube';
    vfVimeo:
      Result := 'vimeo';
    vfShort:
      Result := 'short';
    vfLong:
      Result := 'long';
  else
    Result := '';
  end;
end;

{ TVkVideosFiltersHelper }

class function TVkVideosFiltersHelper.All: TVkVideosFilters;
begin
  Result := [vfMP4, vfYouTube, vfVimeo, vfShort, vfLong];
end;

function TVkVideosFiltersHelper.ToString: string;
var
  Item: TVkVideosFilter;
begin
  for Item in Self do
  begin
    Result := Result + Item.ToString + ',';
  end;
  Result.TrimRight([',']);
end;

{ TVkParamsVideosSearch }

function TVkParamsVideosSearch.Query(Value: string): Integer;
begin
  Result := List.Add('q', Value);
end;

function TVkParamsVideosSearch.Sort(Value: Integer): Integer;
begin
  Result := List.Add('sort', Value);
end;

function TVkParamsVideosSearch.Hd(Value: Integer): Integer;
begin
  Result := List.Add('hd', Value);
end;

function TVkParamsVideosSearch.Adult(Value: Boolean): Integer;
begin
  Result := List.Add('adult', Value);
end;

function TVkParamsVideosSearch.Filters(Value: TVkVideosFilters): Integer;
begin
  Result := List.Add('filters', Value.ToString);
end;

function TVkParamsVideosSearch.SearchOwn(Value: Boolean): Integer;
begin
  Result := List.Add('search_own', Value);
end;

function TVkParamsVideosSearch.Offset(Value: Integer): Integer;
begin
  Result := List.Add('offset', Value);
end;

function TVkParamsVideosSearch.Longer(Value: Integer): Integer;
begin
  Result := List.Add('longer', Value);
end;

function TVkParamsVideosSearch.Shorter(Value: Integer): Integer;
begin
  Result := List.Add('shorter', Value);
end;

function TVkParamsVideosSearch.Count(Value: Integer): Integer;
begin
  Result := List.Add('count', Value);
end;

function TVkParamsVideosSearch.Extended(Value: Boolean): Integer;
begin
  Result := List.Add('extended', Value);
end;

end.

