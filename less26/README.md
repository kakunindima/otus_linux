# Otus-linux Hometask
## less26
### LDAP

__Выполненное ДЗ представляет собой готовый к проверке стенд, приложено две ansible-role для конфигурирования сервера и клиента__

__Проверка ДЗ__

__Необходимо выполнить ряд действий:__

__1. Клонируем репозиторий и запускаеем стенд__
```
    vagrant up
```
__2.Server task - создадим ldap пользователя__
```
    vagrant ssh ldap -c 'echo password | kinit admin && ipa user-add --first="test" --last="test" --cn="test" --password test --shell="/bin/bash"'
```
__3.Client task - вход от имени польователя__
```
    vagrant ssh cli
    su -l test
```