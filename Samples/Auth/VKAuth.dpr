program VKAuth;

uses
  Vcl.Forms,
  VKAuth.Main in 'VKAuth.Main.pas' {FormMain},
  VK.API in '..\..\VK.API.pas',
  VK.Types in '..\..\VK.Types.pas',
  VK.Components in '..\..\VK.Components.pas',
  VK.Entity.AccountInfo in '..\..\Entity\VK.Entity.AccountInfo.pas',
  VK.Controller in '..\..\VK.Controller.pas',
  VK.Handler in '..\..\VK.Handler.pas',
  VK.Captcha in '..\..\Forms\VK.Captcha.pas' {FormCaptcha},
  VK.Entity.ProfileInfo in '..\..\Entity\VK.Entity.ProfileInfo.pas',
  VK.Entity.ActiveOffers in '..\..\Entity\VK.Entity.ActiveOffers.pas',
  VK.Entity.Counters in '..\..\Entity\VK.Entity.Counters.pas',
  VK.Entity.PushSettings in '..\..\Entity\VK.Entity.PushSettings.pas',
  VK.Structs in '..\..\VK.Structs.pas',
  VK.Entity.User in '..\..\Entity\VK.Entity.User.pas',
  VK.LongPollServer in '..\..\VK.LongPollServer.pas',
  VK.UserEvents in '..\..\VK.UserEvents.pas',
  VK.GroupEvents in '..\..\VK.GroupEvents.pas',
  VK.Entity.Comment in '..\..\Entity\VK.Entity.Comment.pas',
  VK.Entity.Post in '..\..\Entity\VK.Entity.Post.pas',
  VK.Entity.Photo in '..\..\Entity\VK.Entity.Photo.pas',
  VK.Entity.Common in '..\..\Entity\VK.Entity.Common.pas',
  VK.Entity.Link in '..\..\Entity\VK.Entity.Link.pas',
  VK.Entity.Attachment in '..\..\Entity\VK.Entity.Attachment.pas',
  VK.Account in '..\..\Controllers\VK.Account.pas',
  VK.Auth in '..\..\Controllers\VK.Auth.pas',
  VK.Users in '..\..\Controllers\VK.Users.pas',
  VK.Messages in '..\..\Controllers\VK.Messages.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormCaptcha, FormCaptcha);
  Application.Run;
end.
