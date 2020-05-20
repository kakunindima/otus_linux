# Otus-linux hometask
## Less16
### Logs

__Клонируем [репозиторий](https://github.com/kakunindima/otus_linux.git) и переходим в папку otus_linux/less16/__


__В выполненном дз стенд создан на основе 2х машин - WEB & LOG__

__Дз состоит из 2х частей:__

__Часть1: Journald__

__На LOG настроен центральный сервер логов на основе Journald__

__А именно настроены: systemd-journal-gateway & systemd-journal-remote__

__На стороне WEB настроен systemd-journal-uload__

__Как результат на LOG прилетают все логи с WEB в директорию /var/log/journal/remote/__

__Также сюда прилетают все логи nginx__

__Для проcмтра логов выполните в консоли команду:__

```
    journalctl -D /var/log/journal/remote --follow
```

__Часть2: Auditd__


__На LOG настроен прием событий аудита изменения конфиг файлов nginx__

__WEB в свою очередь сохраняет сообщения аудита а также отсылает на LOG__

__Для проcмтра сообщений аудита необходимо:__

__На WEB__

__Изменить конфиг nginx__

```
    vi /etc/nginx/nginx.conf
```

__На LOG выполнить команду:__

```
    ausearch -k nginx
```
