unit VK.Entity.App;

interface

uses
  Generics.Collections, Rest.Json, VK.Entity.Common, VK.Entity.Profile, VK.Entity.Group;

type
  TVkAppScreenshot = class
  private
    FAlbum_id: Integer;
    FDate: Int64;
    FHas_tags: Boolean;
    FId: Integer;
    FOwner_id: Integer;
    FSizes: TArray<TVkSize>;
    FText: string;
    FUser_id: Integer;
  public
    property AlbumId: Integer read FAlbum_id write FAlbum_id;
    property Date: Int64 read FDate write FDate;
    property HasTags: Boolean read FHas_tags write FHas_tags;
    property Id: Integer read FId write FId;
    property OwnerId: Integer read FOwner_id write FOwner_id;
    property Sizes: TArray<TVkSize> read FSizes write FSizes;
    property Text: string read FText write FText;
    property UserId: Integer read FUser_id write FUser_id;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkAppScreenshot;
  end;

  TVkApp = class
  private
    FAuthor_owner_id: Integer;
    FAuthor_url: string;
    FBanner_1120: string;
    FBanner_560: string;
    FGenre: string;
    FGenre_id: Integer;
    FHide_tabbar: Boolean;
    FIcon_139: string;
    FIcon_150: string;
    FIcon_278: string;
    FIcon_75: string;
    FId: Integer;
    FInternational: Boolean;
    FIs_in_catalog: Boolean;
    FIs_installed: Boolean;
    FLeaderboard_type: Integer;
    FMembers_count: Integer;
    FMobile_controls_type: Integer;
    FMobile_view_support_type: Integer;
    FPublished_date: Int64;
    FSection: string;
    FTitle: string;
    FType: string;
    FPush_enabled: Boolean;
    FScreenshots: TArray<TVkAppScreenshot>;
    FScreen_name: string;
    FDescription: string;
    FIcon_16: string;
    FFriends: TArray<Integer>;
    FCatalog_position: Integer;
  public
    property AuthorOwnerId: Integer read FAuthor_owner_id write FAuthor_owner_id;
    property AuthorUrl: string read FAuthor_url write FAuthor_url;
    property banner1120: string read FBanner_1120 write FBanner_1120;
    property Banner560: string read FBanner_560 write FBanner_560;
    property Genre: string read FGenre write FGenre;
    property GenreId: Integer read FGenre_id write FGenre_id;
    property HideTabbar: Boolean read FHide_tabbar write FHide_tabbar;
    property Icon139: string read FIcon_139 write FIcon_139;
    property Icon150: string read FIcon_150 write FIcon_150;
    property Icon278: string read FIcon_278 write FIcon_278;
    property Icon75: string read FIcon_75 write FIcon_75;
    property Icon16: string read FIcon_16 write FIcon_16;
    property Id: Integer read FId write FId;
    property International: Boolean read FInternational write FInternational;
    property IsInCatalog: Boolean read FIs_in_catalog write FIs_in_catalog;
    property IsInstalled: Boolean read FIs_installed write FIs_installed;
    property LeaderboardType: Integer read FLeaderboard_type write FLeaderboard_type;
    property MembersCount: Integer read FMembers_count write FMembers_count;
    property MobileControlsType: Integer read FMobile_controls_type write FMobile_controls_type;
    property MobileViewSupportType: Integer read FMobile_view_support_type write FMobile_view_support_type;
    property PublishedDate: Int64 read FPublished_date write FPublished_date;
    property Section: string read FSection write FSection;
    property Title: string read FTitle write FTitle;
    property&Type: string read FType write FType;
    property CatalogPosition: Integer read FCatalog_position write FCatalog_position;
    property Description: string read FDescription write FDescription;
    property Friends: TArray<Integer> read FFriends write FFriends;
    property PushEnabled: Boolean read FPush_enabled write FPush_enabled;
    property ScreenName: string read FScreen_name write FScreen_name;
    property Screenshots: TArray<TVkAppScreenshot> read FScreenshots write FScreenshots;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkApp;
  end;

  TVkApps = class
  private
    FCount: Integer;
    FItems: TArray<TVkApp>;
    FProfiles: TArray<TVkProfile>;
    FGroups: TArray<TVkGroup>;
  public
    property Count: Integer read FCount write FCount;
    property Items: TArray<TVkApp> read FItems write FItems;
    property Profiles: TArray<TVkProfile> read FProfiles write FProfiles;
    property Groups: TArray<TVkGroup> read FGroups write FGroups;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkApps;
  end;

implementation

{TVkApp}

function TVkApp.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

destructor TVkApp.Destroy;
var
  LitemsItem: TVkAppScreenshot;
begin

  for LitemsItem in FScreenshots do
    LitemsItem.Free;
  inherited;
end;

class function TVkApp.FromJsonString(AJsonString: string): TVkApp;
begin
  result := TJson.JsonToObject<TVkApp>(AJsonString)
end;

{TVkApps}

destructor TVkApps.Destroy;
var
  LitemsItem: TVkApp;
  i: Integer;
begin
  for i := Low(FGroups) to High(FGroups) do
    FGroups[i].Free;
  for i := Low(FProfiles) to High(FProfiles) do
    FProfiles[i].Free;
  for LitemsItem in FItems do
    LitemsItem.Free;

  inherited;
end;

function TVkApps.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkApps.FromJsonString(AJsonString: string): TVkApps;
begin
  result := TJson.JsonToObject<TVkApps>(AJsonString)
end;

{ TVkAppScreenshot }

destructor TVkAppScreenshot.Destroy;
var
  LsizesItem: TVkSize;
begin

  for LsizesItem in FSizes do
    LsizesItem.Free;

  inherited;
end;

function TVkAppScreenshot.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkAppScreenshot.FromJsonString(AJsonString: string): TVkAppScreenshot;
begin
  result := TJson.JsonToObject<TVkAppScreenshot>(AJsonString)
end;

end.
