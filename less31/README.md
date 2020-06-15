# Otus-linux Hometask
## Less31
### MAIL

почтовый сервер
1. Установить в виртуалке postfix+dovecot для приёма почты на виртуальный домен любым обсужденным на семинаре способом
2. Отправить почту телнетом с хоста на виртуалку
3. Принять почту на хост почтовым клиентом

1. Отправляем почту с хоста телнетом
    ```
    telnet localhost 8025

    ehlo server.home.local
    mail from: username@example.com
    rcpt to: vagrant@server.home.local
    data
    Subject: hello from telnet
    hello
    .
    ```

1. Просмотрим ящик inbox via IMAP
    ```
    telnet localhost 8143
    a login vagrant password
    b select inbox
    ```

1. Подключемся при помощи thunderbird
  __email:__ _vagrant@server.home.local_
  __password:__ _password_
  __user:__ _vagrant_
  __imap:__ _port 9143, ssl none, Authentification Normal password_
  __smtp:__ _port 9925, ssl none, Authentification Normal password_

  __test:__
  ![img](https://github.com/kakunindima/otus_linux/blob/master/less31/mail.png)