program VKAuth;

uses
  Vcl.Forms,
  VKAuth.Main in 'VKAuth.Main.pas' {FormMain},
  VK.API in '..\..\VK.API.pas',
  VK.Types in '..\..\VK.Types.pas',
  VK.Components in '..\..\VK.Components.pas',
  VK.Controller in '..\..\VK.Controller.pas',
  VK.Handler in '..\..\VK.Handler.pas',
  VK.Captcha in '..\..\Forms\VK.Captcha.pas' {FormCaptcha},
  VK.LongPollServer in '..\..\VK.LongPollServer.pas',
  VK.UserEvents in '..\..\VK.UserEvents.pas',
  VK.GroupEvents in '..\..\VK.GroupEvents.pas',
  VK.OAuth2 in '..\..\Forms\VK.OAuth2.pas' {FormOAuth2},
  VK.Utils in '..\..\VK.Utils.pas',
  VK.Uploader in '..\..\VK.Uploader.pas',
  VK.Account in '..\..\Controllers\VK.Account.pas',
  VK.Audio in '..\..\Controllers\VK.Audio.pas',
  VK.Auth in '..\..\Controllers\VK.Auth.pas',
  VK.Board in '..\..\Controllers\VK.Board.pas',
  VK.Docs in '..\..\Controllers\VK.Docs.pas',
  VK.Friends in '..\..\Controllers\VK.Friends.pas',
  VK.Groups in '..\..\Controllers\VK.Groups.pas',
  VK.Likes in '..\..\Controllers\VK.Likes.pas',
  VK.Messages in '..\..\Controllers\VK.Messages.pas',
  VK.Photos in '..\..\Controllers\VK.Photos.pas',
  VK.Status in '..\..\Controllers\VK.Status.pas',
  VK.Users in '..\..\Controllers\VK.Users.pas',
  VK.Wall in '..\..\Controllers\VK.Wall.pas',
  VK.Entity.AccountInfo in '..\..\Entity\VK.Entity.AccountInfo.pas',
  VK.Entity.AccountInfoRequest in '..\..\Entity\VK.Entity.AccountInfoRequest.pas',
  VK.Entity.ActiveOffers in '..\..\Entity\VK.Entity.ActiveOffers.pas',
  VK.Entity.Album in '..\..\Entity\VK.Entity.Album.pas',
  VK.Entity.Audio in '..\..\Entity\VK.Entity.Audio.pas',
  VK.Entity.AudioMessage in '..\..\Entity\VK.Entity.AudioMessage.pas',
  VK.Entity.ClientInfo in '..\..\Entity\VK.Entity.ClientInfo.pas',
  VK.Entity.Common in '..\..\Entity\VK.Entity.Common.pas',
  VK.Entity.Counters in '..\..\Entity\VK.Entity.Counters.pas',
  VK.Entity.Doc in '..\..\Entity\VK.Entity.Doc.pas',
  VK.Entity.Doc.Save in '..\..\Entity\VK.Entity.Doc.Save.pas',
  VK.Entity.Event in '..\..\Entity\VK.Entity.Event.pas',
  VK.Entity.Gift in '..\..\Entity\VK.Entity.Gift.pas',
  VK.Entity.Graffiti in '..\..\Entity\VK.Entity.Graffiti.pas',
  VK.Entity.GroupSettings in '..\..\Entity\VK.Entity.GroupSettings.pas',
  VK.Entity.Keyboard in '..\..\Entity\VK.Entity.Keyboard.pas',
  VK.Entity.Link in '..\..\Entity\VK.Entity.Link.pas',
  VK.Entity.Market in '..\..\Entity\VK.Entity.Market.pas',
  VK.Entity.Media in '..\..\Entity\VK.Entity.Media.pas',
  VK.Entity.Message in '..\..\Entity\VK.Entity.Message.pas',
  VK.Entity.Note in '..\..\Entity\VK.Entity.Note.pas',
  VK.Entity.OldApp in '..\..\Entity\VK.Entity.OldApp.pas',
  VK.Entity.Page in '..\..\Entity\VK.Entity.Page.pas',
  VK.Entity.Photo in '..\..\Entity\VK.Entity.Photo.pas',
  VK.Entity.Photo.Upload in '..\..\Entity\VK.Entity.Photo.Upload.pas',
  VK.Entity.Playlist in '..\..\Entity\VK.Entity.Playlist.pas',
  VK.Entity.Poll in '..\..\Entity\VK.Entity.Poll.pas',
  VK.Entity.PrettyCard in '..\..\Entity\VK.Entity.PrettyCard.pas',
  VK.Entity.ProfileInfo in '..\..\Entity\VK.Entity.ProfileInfo.pas',
  VK.Entity.PushSettings in '..\..\Entity\VK.Entity.PushSettings.pas',
  VK.Entity.Sticker in '..\..\Entity\VK.Entity.Sticker.pas',
  VK.Entity.User in '..\..\Entity\VK.Entity.User.pas',
  VK.Entity.Video in '..\..\Entity\VK.Entity.Video.pas',
  VK.Entity.Audio.Upload in '..\..\Entity\VK.Entity.Audio.Upload.pas',
  VK.Entity.Conversation in '..\..\Entity\VK.Entity.Conversation.pas',
  VK.Entity.Group in '..\..\Entity\VK.Entity.Group.pas',
  VK.Entity.Status in '..\..\Entity\VK.Entity.Status.pas',
  VK.Entity.CommentInfo in '..\..\Entity\VK.Entity.CommentInfo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormCaptcha, FormCaptcha);
  Application.CreateForm(TFormOAuth2, FormOAuth2);
  Application.Run;
end.
