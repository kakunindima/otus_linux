# Otus-linux hometask
## Lesson 9
### PAM 
__Конфигурируем вход для группы__

_Поскольку непосредственно в time.conf нельзя задать группу, выполним следующее:_

__Добавляем 2 строчки в /etc/pam.d/login__
```
account    [success=1 default=ignore] pam_succeed_if.so user ingroup admin
account    required     pam_time.so
```
__В time.conf запрещаем всем login в выходные__

```
login;*;*;Wk0000-2400
```

__Тестирование:__

```
vagrant up
vagrant ssh

groupadd admin

useradd -G admin test1
useradd test2
```

__Пользователь test1 - будет иметь возможность логиниться в выходные, test2 - только будние__