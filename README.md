# VKAPI

API для Вконтакте

Покрытие методов - **80%**
 
**Внимание**
Если вы уже использовали обертку (до 08.07.2020) и недавно затянули изменения, то вы вероятно получите ошибку при открытии формы. Для её решения нужно закарыть форму с ошибкой без сохранения и исправать файл формы dfm/fmx. Заменить значение свойства Permissions компонента TVK с "'friends,messages..'" на "[Friends,Messages]". Т.е. изменить тип со строки к множеству.

**Warning**
If you have already used a wrapper (before 07/08/2020) and recently tightened the changes, then you will probably get an error when opening the form. To solve it, you need to close the form with an error without saving and fix the dfm/fmx form file. Replace the value of the Permissions property of the TVK component from "'friends,messages..'" to "[Friends,Messages]". Those. change type from string to set.


**Заметки**

Для использования FMX необходимо добавить директиву *NEEDFMX* в проект.

Для некоторых старых версий среды требуется указать директиву *OLD_VERSION*.

**Note**

To use FMX, you need to add the NEEDFMX directive to the project.

**Способы авторизации:**

1 . Авторизация через OAuth2 форму

```
Для FMX - VK.FMX.OAuth2 - TFormFMXOAuth2
Для VCL - VK.VCL.OAuth2 - TFormOAuth2
```

```Pascal
...
var 
  FToken: string;
  FChangePasswordHash: string;
  FTokenExpiry: Int64;
...

procedure TFormMain.VKAuth(Sender: TObject; Url: string; var Token: string; var TokenExpiry: Int64; var ChangePasswordHash: string);
begin
  if FToken.IsEmpty then
  begin
    TFormFMXOAuth2.Execute(Url,
      procedure(Form: TFormFMXOAuth2)
      begin
        FToken := Form.Token;
        FTokenExpiry := Form.TokenExpiry;
        FChangePasswordHash := Form.ChangePasswordHash;
        if not FToken.IsEmpty then
          VK.Login;
      end);
  end
  else
  begin
    Token := FToken;
    TokenExpiry := FTokenExpiry;
  end;
end;

VK.Login(<родитель для окна для VCL, необяз.>);
...
VKAPI.Application := TVkApplicationData.Android;  <-- Данные оф. клиента для Android
VKAPI.Login('+7**********', '*****************',
  function(var Code: string): Boolean
  begin
    Code := InputBox('', '', ''); <-- Код двухэтапной авторизации
    Result := not Code.IsEmpty;
  end);

```

2 . Авторизация напрямую, используя токен (пользовательский или бота)
    
```Pascal
procedure TFormMain.VKAuth(Sender: TObject; Url: string; var Token: string; var TokenExpiry: Int64; var ChangePasswordHash: string);
begin
  Token := '<здесь токен>';
end;   
```

3 . Авторизация с помощью сервисных ключей (указывается в designtime компоненте) 


**Получение пользователей**
    
```Pascal
var
  Users: TVkProfiles;
  i: Integer;
begin
  if VK.Users.Get(Users, [286400863, 415730216], TVkProfileFields.All) then
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
```
    
**Установка статуса онлайн**

```Pascal
if VK.Account.SetOnline then
  Memo1.Lines.Add('online')
else
  Memo1.Lines.Add('Error online');
```
    
**Создание поста в группе**

```Pascal
var
  Params: TVkWallParams;
begin
  Params.Message('Test Text');
  Params.OwnerId(-145962568);
  Params.FromGroup(True);
  Params.Signed(True);
  Params.Attachments([Attachment.Doc(58553419, 533494309, '657138cd5d7842ae0a')]);
  VK.Wall.Post(Params);
end;  
```

**Отправка сообщения**

```Pascal
Vk.Messages.Send.PeerId(Message.PeerId).Message(FAnswer).Send.Free;
```

**или, с созданием клавиатуры**

```Pascal
var
  Keys: TVkKeyboardConstructor;
begin
  Keys.SetOneTime(True);
  Keys.AddButtonText(0, 'Погода', 'weather', bcPositive);
  Keys.AddButtonText(0, 'Отмена', 'cancel', bcNegative);
  Keys.AddButtonText(1, 'Информация', 'info', bcPrimary);
  Keys.AddButtonText(1, 'Команды', 'commands', bcSecondary);
  Vk.Messages.
    Send.
    PeerId(PeerId).
    Keyboard(Keys).
    Message('Выбери вариант').
    Send.Free;
end;
```

**или простое**

```Pascal
Vk.Messages.Send(PeerId, 'Текст сообщения', [<вложения>]);
```    
**Отправка фото**

```Pascal
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
        FileName := Photos.Items[0].ToAttachment;
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
```

**Получение аудиозаписей плейлиста (альбома)**

```Pascal
var
  List: TVkAudios;
  Params: TVkParamsAudio;
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
```

**Использование метода Walk, для выполнения методов с параметрами Count и Offset**

Это простой цикл, который вызывает наш метод регулируя Offset. Cancel позволяет закончить цикл.

Метод позволяет получить все элементы определённого метода с Count и Offset
Достаточно написать стандартную конструкцию получения данных с помощью искомого метода внутри 
передаваемой анонимной функции в Walk и указать шаг получения кол-ва элементов.

```Pascal
VKAPI.Walk(
   function(Offset: Integer; var Cancel: Boolean): Integer
   var
     Audio: TVkAudio;
     Audios: TVkAudios;
     Params: TVkParamsAudio;
   begin
     Result := 0;  //Метод должн вернуть кол-во фактически полученных элементов
     Params.Count(100);
     Params.Offset(Offset);
     if VKAPI.Audio.Get(Audios, Params) then
     begin
       Cnt := Audios.Count;
       Result := Length(Audios.Items);  //Возвращение кол-во полученных элементов
       for Audio in Audios.Items do
       begin
         //Do somethings with Audio
       end;
       Audios.Free;
     end
     else
       Cancel := True;
   end, 100);  // 100 - параметр шага запроса, должен соответстовать параметру метода "Params.Count(100);"
```        
  
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTY2MDExNDI1Miw5MzcyNjYxMzQsMzQ1Mj
kyMzUsLTE0NDUxODA3NDFdfQ==
-->
