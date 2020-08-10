unit VK.Entity.Login;

interface

uses
  Generics.Collections, Rest.Json;

type
  TVkLoginInfo = class
  private
    FError: string;
    FError_description: string;
    FPhone_mask: string;
    FRedirect_uri: string;
    FValidation_sid: string;
    FValidation_type: string;
    FExpires_in: Int64;
    FUser_id: Integer;
    FAccess_token: string;
    FCaptcha_img: string;
    FCaptcha_sid: string;
  public
    property Error: string read FError write FError;
    property ErrorDescription: string read FError_description write FError_description;
    property PhoneMask: string read FPhone_mask write FPhone_mask;
    property RedirectUri: string read FRedirect_uri write FRedirect_uri;
    property ValidationSid: string read FValidation_sid write FValidation_sid;
    property ValidationType: string read FValidation_type write FValidation_type;
    property AccessToken: string read FAccess_token write FAccess_token;
    property ExpiresIn: Int64 read FExpires_in write FExpires_in;
    property UserId: Integer read FUser_id write FUser_id;
    property CaptchaImg: string read FCaptcha_img write FCaptcha_img;
    property CaptchaSid: string read FCaptcha_sid write FCaptcha_sid;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkLoginInfo;
  end;

implementation

{TVkLoginInfo}

function TVkLoginInfo.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkLoginInfo.FromJsonString(AJsonString: string): TVkLoginInfo;
begin
  result := TJson.JsonToObject<TVkLoginInfo>(AJsonString)
end;

end.
