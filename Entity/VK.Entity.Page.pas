unit VK.Entity.Page;

interface

uses
  Generics.Collections, Rest.Json, VK.Entity.Common;

type
  TVkPage = class(TVkObject)
  private
    FCreated: Int64;
    FEdited: Int64;
    FGroup_id: Integer;
    FParent2: string;
    FTitle: string;
    FView_url: string;
    FViews: integer;
    FWho_can_edit: Integer;
    FWho_can_view: Integer;
    FCreator_id: Integer;
    FCurrent_user_can_edit: Integer;
    FCurrent_user_can_edit_access: Integer;
    FEditor_id: Integer;
    FParent: string;
    FSource: string;
    FHtml: string;
  public
    property GroupId: Integer read FGroup_id write FGroup_id;
    property CreatorId: Integer read FCreator_id write FCreator_id;
    property Title: string read FTitle write FTitle;
    property CurrentUserCanEdit: Integer read FCurrent_user_can_edit write FCurrent_user_can_edit;
    property CurrentUserCanEditAccess: Integer read FCurrent_user_can_edit_access write FCurrent_user_can_edit_access;
    property WhoCanView: Integer read FWho_can_view write FWho_can_view;
    property WhoCanEdit: Integer read FWho_can_edit write FWho_can_edit;
    property Edited: Int64 read FEdited write FEdited;
    property Created: Int64 read FCreated write FCreated;
    property EditorId: Integer read FEditor_id write FEditor_id;
    property Views: Integer read FViews write FViews;
    property Parent: string read FParent write FParent;
    property Parent2: string read FParent2 write FParent2;
    property Source: string read FSource write FSource;
    property Html: string read FHtml write FHtml;
    property ViewUrl: string read FView_url write FView_url;
  end;

  TVkPages = class(TVkEntity)
  private
    FItems: TArray<TVkPage>;
    FCount: Integer;
  public
    property Items: TArray<TVkPage> read FItems write FItems;
    property Count: Integer read FCount write FCount;
    destructor Destroy; override;
  end;

  TVkPageVersion = class(TVkObject)
  private
    FDate: Int64;
    FEditor_id: Integer;
    FEditor_name: string;
    FLength: Integer;
  public
    property Date: Int64 read FDate write FDate;
    property EditorId: Integer read FEditor_id write FEditor_id;
    property EditorName: string read FEditor_name write FEditor_name;
    property Length: Integer read FLength write FLength;
  end;

  TVkPageVersions = class(TVkEntity)
  private
    FItems: TArray<TVkPageVersion>;
    FCount: Integer;
  public
    property Items: TArray<TVkPageVersion> read FItems write FItems;
    property Count: Integer read FCount write FCount;
    destructor Destroy; override;
  end;

implementation

uses
  VK.CommonUtils;

{ TVkPageVersions }

destructor TVkPageVersions.Destroy;
begin
  TArrayHelp.FreeArrayOfObject<TVkPageVersion>(FItems);
  inherited;
end;

{ TVkPages }

destructor TVkPages.Destroy;
begin
  TArrayHelp.FreeArrayOfObject<TVkPage>(FItems);
  inherited;
end;

end.

