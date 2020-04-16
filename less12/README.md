# Otus-linux hometask
## Lesson 12
### Selinux

__ДЗ состоит из 2х частей__


__Часть 1__

__Запуск nginx на нестандартном порту 3мя способами__

__1.1 Добавление нестандартного порта в имеющийся тип__

_Проверяем статус сервиса nginx со стандартным портом 80_

```
[root@otuslinux vagrant]# systemctl status nginx
  nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: active (running) since Thu 2020-04-16 08:22:59 UTC; 3s ago
  Process: 27098 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 27096 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 27094 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 27100 (nginx)
   CGroup: /system.slice/nginx.service
           ├─27100 nginx: master process /usr/sbin/nginx
           └─27101 nginx: worker process

Apr 16 08:22:59 otuslinux systemd[1]: Starting The nginx HTTP and reverse proxy server...
Apr 16 08:22:59 otuslinux nginx[27096]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Apr 16 08:22:59 otuslinux nginx[27096]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Apr 16 08:22:59 otuslinux systemd[1]: Failed to read PID from file /run/nginx.pid: Invalid argument
Apr 16 08:22:59 otuslinux systemd[1]: Started The nginx HTTP and reverse proxy server.
```

__Меняем порт nginx 80->8090 и перезагружаем сервис__

```
[root@otuslinux vagrant]# systemctl restart nginx
Job for nginx.service failed because the control process exited with error code. See "systemctl status nginx.service" and "journalctl -xe" for details.
```
__Смотрим перечень разрешенных портов для сервисов__

```
[root@otuslinux vagrant]# semanage port -l | grep http_port_t
http_port_t                    tcp      80, 81, 443, 488, 8008, 8009, 8443, 9000
```

__Используя утилиту semanage доьавляем нестандартный порт 8090__

```
[root@otuslinux vagrant]# semanage port -a -t http_port_t -p tcp 8090

[root@otuslinux vagrant]# systemctl restart nginx
  nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: active (running) since Thu 2020-04-16 08:28:56 UTC; 5s ago
  Process: 27144 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 27143 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 27140 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 27147 (nginx)
   CGroup: /system.slice/nginx.service
           ├─27147 nginx: master process /usr/sbin/nginx
           └─27148 nginx: worker process

Apr 16 08:28:56 otuslinux systemd[1]: Starting The nginx HTTP and reverse proxy server...
Apr 16 08:28:56 otuslinux nginx[27143]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Apr 16 08:28:56 otuslinux nginx[27143]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Apr 16 08:28:56 otuslinux systemd[1]: Failed to read PID from file /run/nginx.pid: Invalid argument
Apr 16 08:28:56 otuslinux systemd[1]: Started The nginx HTTP and reverse proxy server.
```

__Проверяем какой порт слушает nginx__

```
[root@otuslinux vagrant]# ss -lntp | grep LISTEN | grep nginx
LISTEN     0      128          *:8090                     *:*			users:(("nginx",pid=27197,fd=6),("nginx",pid=27196,fd=6))
LISTEN     0      128         :::8090                    :::*			users:(("nginx",pid=27197,fd=7),("nginx",pid=27196,fd=7))
```

__1.2 ФОрмирование и установка модуля Selinux__

__Меняем порт nginx 8090->8095


```
[root@otuslinux vagrant]# systemctl restart nginx
Job for nginx.service failed because the control process exited with error code. See "systemctl status nginx.service" and "journalctl -xe" for details.
```

__Используя утилиту audit2why запустим анализ лога для формирования модуля__

```
[root@otuslinux vagrant]# audit2allow -M httpd_add --debug < /var/log/audit/audit.log
******************** IMPORTANT ***********************
To make this policy package active, execute:

semodule -i httpd_add.pp
```

__Инсталируем модуль__
```
[root@otuslinux vagrant]# semodule -i httpd_add.pp

```

__Проверяем__

```
[root@otuslinux vagrant]# systemctl restart nginx

[root@otuslinux vagrant]# systemctl status nginx
  nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: active (running) since Thu 2020-04-16 08:32:38 UTC; 2s ago
  Process: 27194 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 27191 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 27190 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 27196 (nginx)
   CGroup: /system.slice/nginx.service
           ├─27196 nginx: master process /usr/sbin/nginx
           └─27197 nginx: worker process

Apr 16 08:32:38 otuslinux systemd[1]: Starting The nginx HTTP and reverse proxy server...
Apr 16 08:32:38 otuslinux nginx[27191]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Apr 16 08:32:38 otuslinux nginx[27191]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Apr 16 08:32:38 otuslinux systemd[1]: Failed to read PID from file /run/nginx.pid: Invalid argument
Apr 16 08:32:38 otuslinux systemd[1]: Started The nginx HTTP and reverse proxy server.

[root@otuslinux vagrant]# ss -lntp | grep LISTEN | grep nginx
LISTEN     0      128         :::8095                    :::*                   users:(("nginx",pid=27197,fd=7),("nginx",pid=27196,fd=7))
LISTEN     0      128         :::8090                    :::*			users:(("nginx",pid=27197,fd=7),("nginx",pid=27196,fd=7))
```

__1.3 Использование переключателей setsebool__

__Меняем порт nginx 8095->8099__

```
[root@otuslinux vagrant]# systemctl restart nginx
Job for nginx.service failed because the control process exited with error code. See "systemctl status nginx.service" and "journalctl -xe" for details.

[root@otuslinux vagrant]# systemctl status nginx

 nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Thu 2020-04-16 08:33:08 UTC; 2s ago
  Process: 27194 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 27213 ExecStartPre=/usr/sbin/nginx -t 31m(code=exited, status=1/FAILURE)
  Process: 27211 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 27196 (code=exited, status=0/SUCCESS)

Apr 16 08:33:08 otuslinux systemd[1]: Stopped The nginx HTTP and reverse proxy server.
Apr 16 08:33:08 otuslinux systemd[1]: Starting The nginx HTTP and reverse proxy server...
Apr 16 08:33:08 otuslinux nginx[27213]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Apr 16 08:33:08 otuslinux nginx[27213]: nginx: [emerg] bind() to 0.0.0.0:8099 failed (13: Permission denied)
Apr 16 08:33:08 otuslinux nginx[27213]: nginx: configuration file /etc/nginx/nginx.conf test failed
Apr 16 08:33:08 otuslinux systemd[1]: nginx.service: control process exited, code=exited status=1
Apr 16 08:33:08 otuslinux systemd[1]: Failed to start The nginx HTTP and reverse proxy server
Apr 16 08:33:08 otuslinux systemd[1]: Unit nginx.service entered failed state
Apr 16 08:33:08 otuslinux systemd[1]: nginx.service failed

```
__Используя утилиту audit2why просматриваем лог, для найденных проблем будет предложен вариант решения__
```
[root@otuslinux vagrant]# audit2why < /var/log/audit/audit.log

type=AVC msg=audit(1587026115.008:1025): avc:  denied  { name_bind } for  pid=27280 comm="nginx" src=8099 scontext=system_u:system_r:httpd_t:s0 tcontext=system_u:object_r:preupgrade_port_t:s0 tclass=tcp_socket permissive=0
	Was caused by:
	The boolean httpd_run_preupgrade was set incorrectly. 
	Description:
	Allow httpd to run preupgrade
	Allow access by executing:
	# setsebool -P httpd_run_preupgrade 1
```
__Рекомендовано для устранения проблемы использовать следующий переключатель: ```httpd_run_preupgrade``` установив в статус `1 (on)`__

```
[root@otuslinux vagrant]# setsebool -P httpd_run_preupgrade 1

[root@otuslinux vagrant]# systemctl restart nginx
[root@otuslinux vagrant]# systemctl status nginx
  nginx.service - The nginx HTTP and reverse proxy server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: active (running) since Thu 2020-04-16 08:37:13 UTC; 4s ago
  Process: 27322 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
  Process: 27320 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
  Process: 27318 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
 Main PID: 27324 (nginx)
   CGroup: /system.slice/nginx.service
           ├─27324 nginx: master process /usr/sbin/nginx
           └─27325 nginx: worker process

[root@otuslinux vagrant]# ss -lntp | grep LISTEN | grep nginx
LISTEN     0      128          *:8099                     *:*                   users:(("nginx",pid=27325,fd=6),("nginx",pid=27324,fd=6))
LISTEN     0      128         :::8099                    :::*                   users:(("nginx",pid=27325,fd=7),("nginx",pid=27324,fd=7))
```
__В результате мы видим что все три механизма отрабатывают.__