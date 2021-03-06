unit VK.Entity.Note;

interface

uses
  Generics.Collections, REST.Json.Interceptors, REST.JsonReflect, Rest.Json,
  VK.Entity.Common, VK.Entity.Common.List;

type
  TVkNote = class(TVkObject)
  private
    FComments: Integer;
    [JsonReflectAttribute(ctString, rtString, TUnixDateTimeInterceptor)]
    FDate: TDateTime;
    FOwner_id: Integer;
    FRead_comments: Integer;
    FTitle: string;
    FView_url: string;
    FText: string;
    FPrivacy: Integer;
    FComment_privacy: Integer;
    FCan_comment: Boolean;
    FAccess_key: string;
  public
    /// <summary>
    /// ������������� �������
    /// </summary>
    property Id;
    /// <summary>
    /// ���� �������
    /// </summary>
    property AccessKey: string read FAccess_key write FAccess_key;
    /// <summary>
    /// ������������� ��������� �������
    /// </summary>
    property OwnerId: Integer read FOwner_id write FOwner_id;
    /// <summary>
    /// ���������� ������������
    /// </summary>
    property Comments: Integer read FComments write FComments;
    /// <summary>
    /// ���� �������� �������
    /// </summary>
    property Date: TDateTime read FDate write FDate;
    /// <summary>
    /// ���������� ����������� ������������ (������ ��� ������� ���������� � ������� �������� ������������)
    /// </summary>
    property ReadComments: Integer read FRead_comments write FRead_comments;
    /// <summary>
    /// ��������� �������
    /// </summary>
    property Title: string read FTitle write FTitle;
    /// <summary>
    /// ����� �������
    /// </summary>
    property Text: string read FText write FText;
    /// <summary>
    /// URL �������� ��� ����������� �������
    /// </summary>
    property ViewUrl: string read FView_url write FView_url;
    property Privacy: Integer read FPrivacy write FPrivacy;
    property CommentPrivacy: Integer read FComment_privacy write FComment_privacy;
    property CanComment: Boolean read FCan_comment write FCan_comment;
  end;

  TVkNotes = TVkEntityList<TVkNote>;

  TVkNoteComment = class(TVkObject)
  private
    [JsonReflectAttribute(ctString, rtString, TUnixDateTimeInterceptor)]
    FDate: TDateTime;
    FMessage: string;
    FNid: Integer;
    FOid: Integer;
    FReply_to: Integer;
    FUid: Integer;
  public
    property Date: TDateTime read FDate write FDate;
    property Message: string read FMessage write FMessage;
    property NoteId: Integer read FNid write FNid;
    property OwnerId: Integer read FOid write FOid;
    property ReplyTo: Integer read FReply_to write FReply_to;
    property UserId: Integer read FUid write FUid;
  end;

  TVkNoteComments = TVkEntityList<TVkNoteComment>;

implementation

end.

