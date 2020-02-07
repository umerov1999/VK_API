# VKAPI
 VK API

Русский
-
API для Вконтакте

**Способы авторизации:**

1 . Авторизация через OAuth2 форму

    VK.Login(<родитель для окна, необяз.>);

2 . Авторизация напрямую, используя токен (пользовательский или бота)
    
    procedure TFormMain.VKAuth(Sender: TObject; var Token: string; var TokenExpiry: Int64; var ChangePasswordHash: string);
    begin
      Token := '<здесь токен>';
    end;
    
    procdure TFormMain.FormCreate(Sender: TObject);
    begin
      VK.Login;
    end;  

3 . Авторизация с помощью сервисных ключей (указывается в designtime компоненте) 


**Получение пользователей**

    var
      Users: TVkUsers;
      i: Integer;
    begin
      if VK.Users.Get(Users, '286400863,415730216', UserFieldsAll, '') then
      begin
        for i := Low(Users.Items) to High(Users.Items) do
        begin
          Memo1.Lines.Add('About: ' + Users.Items[i].About);
          Memo1.Lines.Add('BirthDate: ' + Users.Items[i].BirthDate);
          Memo1.Lines.Add('Domain: ' + Users.Items[i].Domain);
          Memo1.Lines.Add('FirstName: ' + Users.Items[i].FirstName);
          Memo1.Lines.Add('Movies: ' + Users.Items[i].Movies);
          Memo1.Lines.Add('------------');
        end;
        Users.Free;
      end;
    end;
**Установка статуса онлайн**

    if VK.Account.SetOnline then
      Memo1.Lines.Add('online')
    else
      Memo1.Lines.Add('Error online');
**Создание поста в группе**

    var
      Params: TVkWallParams;
    begin
      Params.Message('Test Text');
      Params.OwnerId(-145962568);
      Params.FromGroup(True);
      Params.Signed(True);
      Params.Attachments(['doc58553419_533494309_657138cd5d7842ae0a']);
      VK.Wall.Post(Params);
    end;  
**Отправка сообщения**

    Vk.Messages.Send.PeerId(Message.PeerId).Message(FAnswer).Send.Free;
**или, с созданием клавиатуры**

    var
      Keys: TVkKeyboardConstructor;
    begin
      Keys.SetOneTime(True);
      Keys.AddButtonText(0, 'Погода', 'weather', 'positive');
      Keys.AddButtonText(0, 'Отмена', 'cancel', 'negative');
      Keys.AddButtonText(1, 'Информация', 'info', 'primary');
      Keys.AddButtonText(1, 'Команды', 'commands', 'secondary');
      Vk.Messages.
        Send.
        PeerId(PeerId).
        Keyboard(Keys).
        Message('Выбери вариант').
        Send.Free;
    end;
**или простое**

    Vk.Messages.Send(PeerId, 'Текст сообщения', [<вложения>]);
**Отправка фото**

    var
      Url: string;
      Response: TVkPhotoUploadResponse;
      Photos: TVkPhotos;
    begin
      if VK.Photos.GetMessagesUploadServer(Url, PeerId) then
      begin
        if VK.Uploader.UploadPhotos(Url, FileName, Response) then
        begin
          if VK.Photos.SaveMessagesPhoto(Response, Photos) then
          begin
            FileName := CreateAttachment('photo', Photos.Items[0].OwnerId, Photos.Items[0].Id, Photos.Items[0].AccessKey);
            Vk.Messages.
              Send.
              PeerId(PeerId).
              Attachemt([FileName]).
              Send.Free;
            Photos.Free;
          end;
          Response.Free;
        end;
      end;
    end;
**Получение аудиозаписей плейлиста (альбома)**

    var
      List: TVkAudios;
      Params: TVkAudioParams;
      i: Integer;
    begin
      Params.OwnerId(415730216);
      Params.AlbumId(86751037);
      if VK.Audio.Get(List, Params) then
      begin
        for i := Low(List.Items) to High(List.Items) do
        begin
          Memo1.Lines.Add(List.Items[i].Artist + '-' + List.Items[i].Title);
        end;
        List.Free;
      end;
    end;    

**English**
-
API for Vkontakte


**Authorization Methods:**
1 . Authorization through OAuth2 form

    VK.Login(<родитель для окна, необяз.>);

2 . Log in directly using a token (user or bot)
    
    procedure TFormMain.VKAuth(Sender: TObject; var Token: string; var TokenExpiry: Int64; var ChangePasswordHash: string);
    begin
      Token := '<здесь токен>';
    end;
    
    procdure TFormMain.FormCreate(Sender: TObject);
    begin
      VK.Login;
    end;  
3 . Authorization using service keys (specified in the designtime component) 


**Get Users**

    var
      Users: TVkUsers;
      i: Integer;
    begin
      if VK.Users.Get(Users, '286400863,415730216', UserFieldsAll, '') then
      begin
        for i := Low(Users.Items) to High(Users.Items) do
        begin
          Memo1.Lines.Add('About: ' + Users.Items[i].About);
          Memo1.Lines.Add('BirthDate: ' + Users.Items[i].BirthDate);
          Memo1.Lines.Add('Domain: ' + Users.Items[i].Domain);
          Memo1.Lines.Add('FirstName: ' + Users.Items[i].FirstName);
          Memo1.Lines.Add('Movies: ' + Users.Items[i].Movies);
          Memo1.Lines.Add('------------');
        end;
        Users.Free;
      end;
    end;
**Set Online**

    if VK.Account.SetOnline then
      Memo1.Lines.Add('online')
    else
      Memo1.Lines.Add('Error online');
**New Post**

    var
      Params: TVkWallParams;
    begin
      Params.Message('Test Text');
      Params.OwnerId(-145962568);
      Params.FromGroup(True);
      Params.Signed(True);
      Params.Attachments(['doc58553419_533494309_657138cd5d7842ae0a']);
      VK.Wall.Post(Params);
    end;  
**Message send**

    Vk.Messages.Send.PeerId(Message.PeerId).Message(FAnswer).Send.Free;
**or, with keyboard**

    var
      Keys: TVkKeyboardConstructor;
    begin
      Keys.SetOneTime(True);
      Keys.AddButtonText(0, 'Погода', 'weather', 'positive');
      Keys.AddButtonText(0, 'Отмена', 'cancel', 'negative');
      Keys.AddButtonText(1, 'Информация', 'info', 'primary');
      Keys.AddButtonText(1, 'Команды', 'commands', 'secondary');
      Vk.Messages.
        Send.
        PeerId(PeerId).
        Keyboard(Keys).
        Message('Выбери вариант').
        Send.Free;
    end;
**or simple**

    Vk.Messages.Send(PeerId, 'Текст сообщения', [<вложения>]);
**Photo send**

    var
      Url: string;
      Response: TVkPhotoUploadResponse;
      Photos: TVkPhotos;
    begin
      if VK.Photos.GetMessagesUploadServer(Url, PeerId) then
      begin
        if VK.Uploader.UploadPhotos(Url, FileName, Response) then
        begin
          if VK.Photos.SaveMessagesPhoto(Response, Photos) then
          begin
            FileName := CreateAttachment('photo', Photos.Items[0].OwnerId, Photos.Items[0].Id, Photos.Items[0].AccessKey);
            Vk.Messages.
              Send.
              PeerId(PeerId).
              Attachemt([FileName]).
              Send.Free;
            Photos.Free;
          end;
          Response.Free;
        end;
      end;
    end;
**Receiving audio recordings of a playlist (album)**

    var
      List: TVkAudios;
      Params: TVkAudioParams;
      i: Integer;
    begin
      Params.OwnerId(415730216);
      Params.AlbumId(86751037);
      if VK.Audio.Get(List, Params) then
      begin
        for i := Low(List.Items) to High(List.Items) do
        begin
          Memo1.Lines.Add(List.Items[i].Artist + '-' + List.Items[i].Title);
        end;
        List.Free;
      end;
    end;    
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTY2MDExNDI1Miw5MzcyNjYxMzQsMzQ1Mj
kyMzUsLTE0NDUxODA3NDFdfQ==
-->
