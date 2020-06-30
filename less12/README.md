# Otus-linux hometask
## Lesson 12
### Selinux

__ДЗ состоит из 2х частей__


### Часть 1

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

__Меняем порт nginx 8090->8095__


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

### Часть 2

__исправление стенда [SELinux: проблема с удаленным обновлением зоны DNS](https://github.com/mbfx/otus-linux-adm/tree/master/selinux_dns_problems)__

__Итак...__

__Запустив стенд и сделав попытку внести изменения в зону ddns.lab безуспешно получаем ошибку ```Servfail```__

```
    [vagrant@client ~]$ nsupdate -k /etc/named.zonetransfer.key
    > server 192.168.50.10
    > zone ddns.lab
    > update add www.ddns.lab. 60 A 192.168.50.15
    > send
    update failed: SERVFAIL

```
__Рассмотрим что настроено на ns01__

__Смотрим директорию /etc/named, в которой находятся все конфиги зон__

```
[root@ns01 vagrant]# ls -Z /etc/named
drw-rwx---. root named unconfined_u:object_r:etc_t:s0   dynamic
-rw-rw----. root named system_u:object_r:etc_t:s0       named.50.168.192.rev
-rw-rw----. root named system_u:object_r:etc_t:s0       named.dns.lab
-rw-rw----. root named system_u:object_r:etc_t:s0       named.dns.lab.view1
-rw-rw----. root named system_u:object_r:etc_t:s0       named.newdns.lab
[root@ns01 vagrant]# ls -Z /etc/named/dynamic/
-rw-rw----. named named system_u:object_r:etc_t:s0       named.ddns.lab
-rw-rw----. named named system_u:object_r:etc_t:s0       named.ddns.lab.view1
```
__Использовав команду ```ls -Z /etc/named/*```, ```ls -Z /etc/named/*``` видим что контекст конфигов ```etc_t```__

__Поискав на некоторых [ресурсах](https://linux.die.net/man/8/named_selinux) нашел что контекст конфигов может быть разным__

__Причина не работоспособности - нет прав на изменения конфигурации для данного контекста.__

__Решение проблемы:__

__Протестировал 3 способа, результат дали 2__

### Способ 0 - отключить selinux.... P.S. так не делайте)

### Способ 1 - состояние permissive

__Установить Selinux для named в состояние permissive__

```
    semanage permissive -a named_t
```
__Данная опция проблемы не решает а только убирает блокировку, в лог будут сыпаться ошибки, но результат__ +

### Способ 2 - контекст named_zone_t

__данный контекс применяется для файлов зоны которые можно изменять__

```
[root@ns01 vagrant]# chcon -t named_zone_t /etc/named/dynamic/*
[root@ns01 vagrant]# chcon -t named_zone_t /etc/named/*
```
__Меняем контекст и смотрим__
```
[root@ns01 vagrant]# ls -Z /etc/named/dynamic/
-rw-rw----. named named system_u:object_r:named_zone_t:s0 named.ddns.lab
-rw-rw----. named named system_u:object_r:named_zone_t:s0 named.ddns.lab.view1

[root@ns01 vagrant]# ls -Z /etc/named/
drw-rwx---. root named unconfined_u:object_r:named_zone_t:s0 dynamic
-rw-rw----. root named system_u:object_r:named_zone_t:s0 named.50.168.192.rev
-rw-rw----. root named system_u:object_r:named_zone_t:s0 named.dns.lab
-rw-rw----. root named system_u:object_r:named_zone_t:s0 named.dns.lab.view1
-rw-rw----. root named system_u:object_r:named_zone_t:s0 named.newdns.lab
```
__Тестируем, результат__ +

```
    [vagrant@client ~]$ nsupdate -k /etc/named.zonetransfer.key
    > server 192.168.50.10
    > zone ddns.lab 
    > update add www.ddns.lab. 60 A 192.168.50.15
    > send
```

### Способ 3 Контекст named_conf_t

__Данный контекст применяется для конфигурационных файлов в директории /etc/__

__Здесь для успешной работы выполняем 3 действия__

__1 Меняем контекст__

```
[root@ns01 vagrant]# chcon -t named_conf_t /etc/named/dynamic/*
[root@ns01 vagrant]# chcon -t named_conf_t /etc/named/*
[root@ns01 vagrant]# ls -Z /etc/named/dynamic/
-rw-rw----. named named system_u:object_r:named_conf_t:s0 named.ddns.lab
-rw-rw----. named named system_u:object_r:named_conf_t:s0 named.ddns.lab.view1

[root@ns01 vagrant]# ls -Z /etc/named/
drw-rwx---. root named unconfined_u:object_r:named_conf_t:s0 dynamic
-rw-rw----. root named system_u:object_r:named_conf_t:s0 named.50.168.192.rev
-rw-rw----. root named system_u:object_r:named_conf_t:s0 named.dns.lab
-rw-rw----. root named system_u:object_r:named_conf_t:s0 named.dns.lab.view1
-rw-rw----. root named system_u:object_r:named_conf_t:s0 named.newdns.lab
```
__Генерируем модуль для Selinux__
```
audit2why < /var/log/audit/audit.log 
type=AVC msg=audit(1592819750.373:1911): avc:  denied  { search } for  pid=7132 comm="isc-worker0000" name="net" dev="proc" ino=33279 scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:sysctl_net_t:s0 tclass=dir permissive=0

    Was caused by:
	Unknown - would be allowed by active policy
	Possible mismatch between this policy and the one under which the audit message was generated.

	Possible mismatch between current in-memory boolean settings vs. permanent ones.

type=AVC msg=audit(1592819750.373:1912): avc:  denied  { search } for  pid=7132 comm="isc-worker0000" name="net" dev="proc" ino=33279 scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:sysctl_net_t:s0 tclass=dir permissive=0

    Was caused by:
	Unknown - would be allowed by active policy
	Possible mismatch between this policy and the one under which the audit message was generated.

	Possible mismatch between current in-memory boolean settings vs. permanent ones.

type=AVC msg=audit(1592820828.693:1946): avc:  denied  { create } for  pid=7132 comm="isc-worker0000" name="named.ddns.lab.view1.jnl" scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:etc_t:s0 tclass=file permissive=0

    Was caused by:
	Unknown - would be allowed by active policy
	Possible mismatch between this policy and the one under which the audit message was generated.

	Possible mismatch between current in-memory boolean settings vs. permanent ones.

type=AVC msg=audit(1592824195.277:1954): avc:  denied  { create } for  pid=7132 comm="isc-worker0000" name="named.ddns.lab.view1.jnl" scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:etc_t:s0 tclass=file permissive=0

    Was caused by:
	Unknown - would be allowed by active policy
	Possible mismatch between this policy and the one under which the audit message was generated.

	Possible mismatch between current in-memory boolean settings vs. permanent ones.

type=AVC msg=audit(1592824593.671:1955): avc:  denied  { create } for  pid=7132 comm="isc-worker0000" name="named.ddns.lab.view1.jnl" scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:etc_t:s0 tclass=file permissive=0

    Was caused by:
	Unknown - would be allowed by active policy
	Possible mismatch between this policy and the one under which the audit message was generated.

	Possible mismatch between current in-memory boolean settings vs. permanent ones.

type=AVC msg=audit(1592825365.690:1984): avc:  denied  { create } for  pid=7132 comm="isc-worker0000" name="named.ddns.lab.view1.jnl" scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:etc_t:s0 tclass=file permissive=0

    Was caused by:
	Unknown - would be allowed by active policy
	Possible mismatch between this policy and the one under which the audit message was generated.

	Possible mismatch between current in-memory boolean settings vs. permanent ones.

type=AVC msg=audit(1592825781.603:1988): avc:  denied  { create } for  pid=7132 comm="isc-worker0000" name="named.ddns.lab.view1.jnl" scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:etc_t:s0 tclass=file permissive=0

    Was caused by:
	Unknown - would be allowed by active policy
	Possible mismatch between this policy and the one under which the audit message was generated.

	Possible mismatch between current in-memory boolean settings vs. permanent ones.

type=AVC msg=audit(1592827035.417:2012): avc:  denied  { write } for  pid=7132 comm="isc-worker0000" name="dynamic" dev="sda1" ino=300 scontext=system_u:system_r:named_t:s0 tcontext=unconfined_u:object_r:named_exec_t:s0 tclass=dir permissive=1

    Was caused by:
	Unknown - would be allowed by active policy
	Possible mismatch between this policy and the one under which the audit message was generated.

	Possible mismatch between current in-memory boolean settings vs. permanent ones.

type=AVC msg=audit(1592827035.417:2012): avc:  denied  { add_name } for  pid=7132 comm="isc-worker0000" name="named.ddns.lab.view1.jnl" scontext=system_u:system_r:named_t:s0 tcontext=unconfined_u:object_r:named_exec_t:s0 tclass=dir permissive=1

    Was caused by:
	Unknown - would be allowed by active policy
	Possible mismatch between this policy and the one under which the audit message was generated.

	Possible mismatch between current in-memory boolean settings vs. permanent ones.

type=AVC msg=audit(1592827035.417:2012): avc:  denied  { create } for  pid=7132 comm="isc-worker0000" name="named.ddns.lab.view1.jnl" scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:named_exec_t:s0 tclass=file permissive=1

    Was caused by:
	Unknown - would be allowed by active policy
	Possible mismatch between this policy and the one under which the audit message was generated.

	Possible mismatch between current in-memory boolean settings vs. permanent ones.

type=AVC msg=audit(1592827035.417:2012): avc:  denied  { write } for  pid=7132 comm="isc-worker0000" path="/etc/named/dynamic/named.ddns.lab.view1.jnl" dev="sda1" ino=507402 scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:named_exec_t:s0 tclass=file permissive=1

    Was caused by:
	Unknown - would be allowed by active policy
	Possible mismatch between this policy and the one under which the audit message was generated.

	Possible mismatch between current in-memory boolean settings vs. permanent ones.

type=AVC msg=audit(1592827826.716:2020): avc:  denied  { remove_name } for  pid=7132 comm="isc-worker0000" name="tmp-mjptBTGf5S" dev="sda1" ino=21315 scontext=system_u:system_r:named_t:s0 tcontext=unconfined_u:object_r:named_exec_t:s0 tclass=dir permissive=1

    Was caused by:
	Missing type enforcement (TE) allow rule.

	You can use audit2allow to generate a loadable module to allow this access.

type=AVC msg=audit(1592827826.716:2020): avc:  denied  { rename } for  pid=7132 comm="isc-worker0000" name="tmp-mjptBTGf5S" dev="sda1" ino=21315 scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:named_exec_t:s0 tclass=file permissive=1

    Was caused by:
	Missing type enforcement (TE) allow rule.

	You can use audit2allow to generate a loadable module to allow this access.

type=AVC msg=audit(1592827826.716:2020): avc:  denied  { unlink } for  pid=7132 comm="isc-worker0000" name="named.ddns.lab.view1" dev="sda1" ino=33563776 scontext=system_u:system_r:named_t:s0 tcontext=system_u:object_r:etc_t:s0 tclass=file permissive=1

    Was caused by:
	Missing type enforcement (TE) allow rule.

	You can use audit2allow to generate a loadable module to allow this access.
```
__Создаем и устанавливаем модуль__
```
[root@ns01 vagrant]# ausearch -c 'isc-worker0000' --raw | audit2allow -M my-iscworker0000
******************** IMPORTANT ***********************
To make this policy package active, execute:

semodule -i my-iscworker0000.pp

[root@ns01 vagrant]# semodule -i my-iscworker0000.pp

```
__Проверив с клиента - также получаем воможность записать изменения.__

__Cпособ 4 - контекст `named_cache_t`__

__Выдержка из [статьи](https://www.systutorials.com/docs/linux/man/8-named/)__


_The Red Hat BIND distribution and SELinux policy creates three directories where named is allowed to create and modify files: /var/named/slaves, /var/named/dynamic /var/named/data. By placing files you want named to modify, such as slave or DDNS updateable zone files and database / statistics dump files in these directories, named will work normally and no further operator action is required. Files in these directories are automatically assigned the_ __'named_cache_t'__ _file context, which SELinux allows named to write._

_Для динамичесски обновлемой зоны необходим контекст_ `named_cache_t`_, а для конфигов_ `named_conf_t`
_Изменяем контекст_
```
    chcon -t named_cache_t /etc/named/dynamic/*
    chcon -t named_conf_t /etc/named/*
```

_Результат тестирования +_

### Вывод

__Для динамически обновляемой зоны НЕОБХОДИМО устанавливать контекст  `named_cache_t`, что обезпечивает корректность работы, для конф файлов контекст__ `named-conf_t`