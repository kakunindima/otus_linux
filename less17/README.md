# Otus-linux hometask
## Less 17
### Backup

__Результат выполнения ДЗ по использованию borgbackup__

__1. Приложен скрипт резервного копирования с политикой хранения бэкапов за последние 30 дней, и за последние 2 месяца__

__Скрипт запускается через cron на сервере раз в час__

__2. Тестирование восстановления данных в директории /etc/ при помощи опции borg mount__

__Создаем файл test.txt__

```
[root@server vagrant]# echo "test" > /etc/test.txt

[root@server vagrant]# ls /etc/
DIR_COLORS               cifs-utils     firewalld    iproute2        mtab               printcap          rsyslog.d       sudoers.d
DIR_COLORS.256color      cron.d         fstab        issue           my.cnf             profile           rwtab           sysconfig
DIR_COLORS.lightbgcolor  cron.daily     fuse.conf    issue.net       my.cnf.d           profile.d         rwtab.d         sysctl.conf
GREP_COLORS              cron.deny      gcrypt       krb5.conf       netconfig          protocols         samba           sysctl.d
GeoIP.conf               cron.hourly    gnupg        krb5.conf.d     networks           python            sasl2           system-release
GeoIP.conf.default       cron.monthly   groff        ld.so.cache     nfs.conf           qemu-ga           securetty       system-release-cpe
NetworkManager           cron.weekly    group        ld.so.conf      nfsmount.conf      rc.d              security        systemd
X11                      crontab        group-       ld.so.conf.d    nsswitch.conf      rc.local          selinux         terminfo
adjtime                  crypttab       grub.d       libaudit.conf   nsswitch.conf.bak  rc0.d             services        test.txt
aliases                  csh.cshrc      grub2.cfg    libnl           openldap           rc1.d             sestatus.conf   tmpfiles.d
aliases.db               csh.login      gshadow      libuser.conf    opt                rc2.d             shadow          tuned
alternatives             dbus-1         gshadow-     locale.conf     os-release         rc3.d             shadow-         udev
anacrontab               default        gss          localtime       pam.d              rc4.d             shells          vconsole.conf
audisp                   depmod.d       gssproxy     login.defs      passwd             rc5.d             skel            virc
audit                    dhcp           host.conf    logrotate.conf  passwd-            rc6.d             ssh             vmware-tools
bash_completion.d        dracut.conf    hostname     logrotate.d     pkcs11             redhat-release    ssl             wgetrc
bashrc                   dracut.conf.d  hosts        machine-id      pki                request-key.conf  statetab        wpa_supplicant
binfmt.d                 e2fsck.conf    hosts.allow  magic           pm                 request-key.d     statetab.d      xdg
centos-release           environment    hosts.deny   man_db.conf     polkit-1           resolv.conf       subgid          xinetd.d
centos-release-upstream  ethertypes     idmapd.conf  mke2fs.conf     popt.d             rpc               subuid          yum
chkconfig.d              exports        init.d       modprobe.d      postfix            rpm               sudo-ldap.conf  yum.conf
chrony.conf              exports.d      inittab      modules-load.d  ppp                rsyncd.conf       sudo.conf       yum.repos.d
chrony.keys              filesystems    inputrc      motd            prelink.conf.d     rsyslog.conf      sudoers

[root@server vagrant]# ls /etc/ | grep test
test.txt

[root@server vagrant]# cat /etc/test.txt 
test
```
__Запускаем создание бэкапа при помощи скрипта__
```
[root@server vagrant]# /opt/./backup.sh 
less17
------------------------------------------------------------------------------  
Archive name: etc-2020-06-10_08:05:21
Archive fingerprint: 3958dfe9e53ac3945a6830ab7742a3e17a95023f9bf670ce4cb0fd8d40d799cc
Time (start): Wed, 2020-06-10 08:05:22
Time (end):   Wed, 2020-06-10 08:05:23
Duration: 1.12 seconds
Number of files: 1693
Utilization of max. archive size: 0%
------------------------------------------------------------------------------
                       Original size      Compressed size    Deduplicated size
This archive:               27.80 MB             13.20 MB            126.46 kB
All archives:              166.81 MB             79.21 MB             12.06 MB

                       Unique chunks         Total chunks
Chunk index:                    1284                10117
------------------------------------------------------------------------------
Keeping archive: etc-2020-06-10_08:05:21              Wed, 2020-06-10 08:05:22 [3958dfe9e53ac3945a6830ab7742a3e17a95023f9bf670ce4cb0fd8d40d799cc]
Pruning archive: etc-2020-06-10_08:02:36              Wed, 2020-06-10 08:02:37 [86235f4568e1235b59a87f0d266df811f3ae7254ea59d977f78217ab2643475f] (1/1)
Keeping archive: etc-2020-06-10_07:13:03              Wed, 2020-06-10 07:13:05 [8836a955bcf0fcf131fb80357b83cd035ff376b777dccade730824fe077892f4]
Keeping archive: etc-2020-06-09_17:42:31              Tue, 2020-06-09 17:42:33 [00e55a3879b944b68862427879c6dfaa8308853c7f91eef252478ba6f27eef14]
Keeping archive: etc-2020-06-09_16:56:11              Tue, 2020-06-09 16:56:14 [0d2e6e5bf171cbf679a1cba371bd1921e2f11c2b17431f37883c62f54c4522fc]
Keeping archive: etc-2020-06-09_15:11:57              Tue, 2020-06-09 15:12:15 [1372bacda00d4ffb1c8f401e02996ba820ff0b9cdcad029de9390f633e9d7d87]
```
__Удаляем тестовый файл__

```
[root@server vagrant]# rm /etc/test.txt 
rm: remove regular file '/etc/test.txt'? yes
[root@server vagrant]# ls /etc/ | grep test
```
__Просматриваем наличие бэкапа в репозитории__
```
[root@server vagrant]# borg list back@backup:less17 
etc-2020-06-09_15:11:57              Tue, 2020-06-09 15:12:15 [1372bacda00d4ffb1c8f401e02996ba820ff0b9cdcad029de9390f633e9d7d87]
etc-2020-06-09_16:56:11              Tue, 2020-06-09 16:56:14 [0d2e6e5bf171cbf679a1cba371bd1921e2f11c2b17431f37883c62f54c4522fc]
etc-2020-06-09_17:42:31              Tue, 2020-06-09 17:42:33 [00e55a3879b944b68862427879c6dfaa8308853c7f91eef252478ba6f27eef14]
etc-2020-06-10_07:13:03              Wed, 2020-06-10 07:13:05 [8836a955bcf0fcf131fb80357b83cd035ff376b777dccade730824fe077892f4]
etc-2020-06-10_08:05:21              Wed, 2020-06-10 08:05:22 [3958dfe9e53ac3945a6830ab7742a3e17a95023f9bf670ce4cb0fd8d40d799cc]
```
__Создаем директорию и монтируем бэкап__
```
[root@server vagrant]# mkdir /backup
[root@server vagrant]# borg mount back@backup:less17 /backup
```
__Просматриваем наличие восстанавливаемых файлов в последнем бэкапе__
```
[root@server vagrant]# ls /backup
etc-2020-06-09_15:11:57  etc-2020-06-09_16:56:11  etc-2020-06-09_17:42:31  etc-2020-06-10_07:13:03  etc-2020-06-10_08:05:21
[root@server vagrant]# ls /backup/etc-2020-06-10_08\:05\:21/etc/
DIR_COLORS               cifs-utils     firewalld    iproute2        mtab               printcap          rsyslog.d       sudoers.d
DIR_COLORS.256color      cron.d         fstab        issue           my.cnf             profile           rwtab           sysconfig
DIR_COLORS.lightbgcolor  cron.daily     fuse.conf    issue.net       my.cnf.d           profile.d         rwtab.d         sysctl.conf
GREP_COLORS              cron.deny      gcrypt       krb5.conf       netconfig          protocols         samba           sysctl.d
GeoIP.conf               cron.hourly    gnupg        krb5.conf.d     networks           python            sasl2           system-release
GeoIP.conf.default       cron.monthly   groff        ld.so.cache     nfs.conf           qemu-ga           securetty       system-release-cpe
NetworkManager           cron.weekly    group        ld.so.conf      nfsmount.conf      rc.d              security        systemd
X11                      crontab        group-       ld.so.conf.d    nsswitch.conf      rc.local          selinux         terminfo
adjtime                  crypttab       grub.d       libaudit.conf   nsswitch.conf.bak  rc0.d             services        test.txt
aliases                  csh.cshrc      grub2.cfg    libnl           openldap           rc1.d             sestatus.conf   tmpfiles.d
aliases.db               csh.login      gshadow      libuser.conf    opt                rc2.d             shadow          tuned
alternatives             dbus-1         gshadow-     locale.conf     os-release         rc3.d             shadow-         udev
anacrontab               default        gss          localtime       pam.d              rc4.d             shells          vconsole.conf
audisp                   depmod.d       gssproxy     login.defs      passwd             rc5.d             skel            virc
audit                    dhcp           host.conf    logrotate.conf  passwd-            rc6.d             ssh             vmware-tools
bash_completion.d        dracut.conf    hostname     logrotate.d     pkcs11             redhat-release    ssl             wgetrc
bashrc                   dracut.conf.d  hosts        machine-id      pki                request-key.conf  statetab        wpa_supplicant
binfmt.d                 e2fsck.conf    hosts.allow  magic           pm                 request-key.d     statetab.d      xdg
centos-release           environment    hosts.deny   man_db.conf     polkit-1           resolv.conf       subgid          xinetd.d
centos-release-upstream  ethertypes     idmapd.conf  mke2fs.conf     popt.d             rpc               subuid          yum
chkconfig.d              exports        init.d       modprobe.d      postfix            rpm               sudo-ldap.conf  yum.conf
chrony.conf              exports.d      inittab      modules-load.d  ppp                rsyncd.conf       sudo.conf       yum.repos.d
chrony.keys              filesystems    inputrc      motd            prelink.conf.d     rsyslog.conf      sudoers
[root@server vagrant]# ls /backup/etc-2020-06-10_08\:05\:21/etc/ | grep test.txt
test.txt
```
__Копируем файл обратно в директорию /etc/__
```
[root@server vagrant]# cp /backup/etc-2020-06-10_08\:05\:21/etc/test.txt /etc/
[root@server vagrant]# ls /etc/ | grep test.txt
test.txt
```