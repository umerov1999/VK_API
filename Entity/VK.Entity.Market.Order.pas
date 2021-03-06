unit VK.Entity.Market.Order;

interface

uses
  Generics.Collections, REST.Json.Interceptors, REST.JsonReflect, Rest.Json,
  VK.Entity.Common, VK.Entity.Common.List, VK.Entity.Market, VK.Entity.Photo,
  VK.Types, VK.Wrap.Interceptors;

type
  TVkOrderRecipient = class
  private
    FDisplay_text: string;
    FName: string;
    FPhone: string;
  public
    property DisplayText: string read FDisplay_text write FDisplay_text;
    property Name: string read FName write FName;
    property Phone: string read FPhone write FPhone;
  end;

  TVkOrderDelivery = class
  private
    FAddress: string;
    FType: string;
  public
    property Address: string read FAddress write FAddress;
    property&Type: string read FType write FType;
  end;

  TVkOrderPayment = class(TVkEntity)
  private
    FStatus: string;
    FPayment_status: string;
    FReceipt_link: string;
  public
    property Status: string read FStatus write FStatus;
    property ReceiptLink: string read FReceipt_link write FReceipt_link;
    property PaymentStatus: string read FPayment_status write FPayment_status;
  end;

  TVkOrderTag = class(TVkEntity)
  private
    FName: string;
    FIndex: Integer;
  public
    property Index: Integer read FIndex write FIndex;
    property Name: string read FName write FName;
  end;

  TVkOrderSeller = class(TVkEntity)
  private
    FContact_Id: Integer;
    FGroup_Id: Integer;
    FName: string;
    FTitle: string;
  public
    property ContactId: Integer read FContact_Id write FContact_Id;
    property GroupId: Integer read FGroup_Id write FGroup_Id;
    property Name: string read FName write FName;
    property Title: string read FTitle write FTitle;
  end;

  TVkOrder = class(TVkObject)
  private
    FComment: string;
    [JsonReflectAttribute(ctString, rtString, TUnixDateTimeInterceptor)]
    FDate: TDateTime;
    FDelivery: TVkOrderDelivery;
    FDisplay_order_id: string;
    FGroup_id: Integer;
    FItems_count: Integer;
    FPreview_order_items: TArray<TVkProduct>;
    FRecipient: TVkOrderRecipient;
    [JsonReflectAttribute(ctString, rtString, TOrderStatusInterceptor)]
    FStatus: TVkOrderStatus;
    FTotal_price: TVkProductPrice;
    FUser_id: Integer;
    FMerchant_comment: string;
    FPayment: TVkOrderPayment;
    FSeller: TVkOrderSeller;
    FTags: TArray<TVkOrderTag>;
  public
    property GroupId: Integer read FGroup_id write FGroup_id;
    property UserId: Integer read FUser_id write FUser_id;
    property Date: TDateTime read FDate write FDate;
    property Status: TVkOrderStatus read FStatus write FStatus;
    property ItemsCount: Integer read FItems_count write FItems_count;
    property TotalPrice: TVkProductPrice read FTotal_price write FTotal_price;
    property DisplayOrderId: string read FDisplay_order_id write FDisplay_order_id;
    property MerchantComment: string read FMerchant_comment write FMerchant_comment;
    property Tags: TArray<TVkOrderTag> read FTags write FTags;
    property Comment: string read FComment write FComment;
    property Delivery: TVkOrderDelivery read FDelivery write FDelivery;
    property PreviewOrderItems: TArray<TVkProduct> read FPreview_order_items write FPreview_order_items;
    property Recipient: TVkOrderRecipient read FRecipient write FRecipient;
    property Payment: TVkOrderPayment read FPayment write FPayment;
    property Seller: TVkOrderSeller read FSeller write FSeller;
    constructor Create; override;
    destructor Destroy; override;
  end;

  TVkOrders = TVkEntityList<TVkOrder>;

implementation

uses
  VK.CommonUtils;

{TVkOrder}

constructor TVkOrder.Create;
begin
  inherited;
  FTotal_price := TVkProductPrice.Create();
  FRecipient := TVkOrderRecipient.Create();
end;

destructor TVkOrder.Destroy;
begin
  TArrayHelp.FreeArrayOfObject<TVkProduct>(FPreview_order_items);
  TArrayHelp.FreeArrayOfObject<TVkOrderTag>(FTags);
  FTotal_price.Free;
  FRecipient.Free;
  if Assigned(FDelivery) then
    FDelivery.Free;
  if Assigned(FPayment) then
    FPayment.Free;
  if Assigned(FSeller) then
    FSeller.Free;
  inherited;
end;

end.

