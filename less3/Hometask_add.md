# Otus-linux Hometask
## Less3 additional hometask *
### 1.Установка btrfs
__btrfs будем устанавливать на доступные диски - sdb,sdc,sdd,sde
выводим список:__
``` 
[vagrant@lvm ~]$ lsblk

NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   40G  0 disk 
├─sda1                    8:1    0    1M  0 part 
├─sda2                    8:2    0    1G  0 part /boot
└─sda3                    8:3    0   39G  0 part 
  ├─VolGroup00-LogVol00 253:0    0 37.5G  0 lvm  /
  └─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
sdb                       8:16   0   10G  0 disk 
sdc                       8:32   0    2G  0 disk 
sdd                       8:48   0    1G  0 disk 
sde                       8:64   0    1G  0 disk 
```
__Создаем ФС на дисках sdb,sdc,sdd,sde.__
```
[root@lvm vagrant]# mkfs.btrfs /dev/sdb
btrfs-progs v4.9.1
See http://btrfs.wiki.kernel.org for more information.

Label:              (null)
UUID:               a8383377-ba69-40fe-b6c0-c0c862eed531
Node size:          16384
Sector size:        4096
Filesystem size:    10.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP               1.00GiB
  System:           DUP               8.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1    10.00GiB  /dev/sdb

[root@lvm vagrant]# mkfs.btrfs /dev/sdc /dev/sdd
btrfs-progs v4.9.1
See http://btrfs.wiki.kernel.org for more information.

Label:              (null)
UUID:               38f786d4-c0b5-40eb-977b-d957bbebad5d
Node size:          16384
Sector size:        4096
Filesystem size:    3.00GiB
Block group profiles:
  Data:             RAID0           307.12MiB
  Metadata:         RAID1           153.56MiB
  System:           RAID1             8.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Number of devices:  2
Devices:
   ID        SIZE  PATH
    1     2.00GiB  /dev/sdc
    2     1.00GiB  /dev/sdd
```
__Создаем папку и монтируем первый том__
```
[root@lvm vagrant]# mkdir /mnt/sdb
[root@lvm vagrant]# mount /dev/sdb/ /mnt/sdb/
[root@lvm vagrant]# df -h
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00   38G  760M   37G   2% /
devtmpfs                         109M     0  109M   0% /dev
tmpfs                            118M     0  118M   0% /dev/shm
tmpfs                            118M  4.5M  114M   4% /run
tmpfs                            118M     0  118M   0% /sys/fs/cgroup
/dev/sda2                       1014M   63M  952M   7% /boot
tmpfs                             24M     0   24M   0% /run/user/1000
/dev/sdb                          10G   17M  8.0G   1% /mnt/sdb
```
__В результате видим появившийся смонтированый раздел равный 8Гб.
Расширим созданый раздел средствами btrfs, добавив еще один диск размером 2Гб__
```
[root@lvm vagrant]# btrfs devicce add /dev/sdc/ /mnt/sdb/
[root@lvm vagrant]# df -h
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00   38G  760M   37G   2% /
devtmpfs                         109M     0  109M   0% /dev
tmpfs                            118M     0  118M   0% /dev/shm
tmpfs                            118M  4.5M  114M   4% /run
tmpfs                            118M     0  118M   0% /sys/fs/cgroup
/dev/sda2                       1014M   63M  952M   7% /boot
tmpfs                             24M     0   24M   0% /run/user/1000
/dev/sdb                          12G   17M   10G   1% /mnt/sdb
```
__Как результат видим что размер примонтированого тома увеличился до 10ГБ__
```
[root@lvm vagrant]# lsblk
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   40G  0 disk 
├─sda1                    8:1    0    1M  0 part 
├─sda2                    8:2    0    1G  0 part /boot
└─sda3                    8:3    0   39G  0 part 
  ├─VolGroup00-LogVol00 253:0    0 37.5G  0 lvm  /
  └─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
sdb                       8:16   0   10G  0 disk /mnt/sdb
sdc                       8:32   0    2G  0 disk 
sdd                       8:48   0    1G  0 disk 
sde                       8:64   0    1G  0 disk 
```
__Просмотрим статус смонтированого ресурса__
```
[root@lvm vagrant]# btrfs devce stats /mnt/sdb/
[/dev/sdb].write_io_errs    0
[/dev/sdb].read_io_errs     0
[/dev/sdb].flush_io_errs    0
[/dev/sdb].corruption_errs  0
[/dev/sdb].generation_errs  0
[/dev/sdc].write_io_errs    0
[/dev/sdc].read_io_errs     0
[/dev/sdc].flush_io_errs    0
[/dev/sdc].corruption_errs  0
[/dev/sdc].generation_errs  0

[root@lvm vagrant]# btrfs filesystem show --mounted
Label: none  uuid: a8383377-ba69-40fe-b6c0-c0c862eed531
	Total devices 2 FS bytes used 384.00KiB
	devid    1 size 10.00GiB used 2.02GiB path /dev/sdb
	devid    2 size 2.00GiB used 0.00B path /dev/sdc
```
### 2.Перенос папки /var/opt на смонтированый том c btrfs /dev/sdb
__Перенесем на смонтированый раздел папку /vat/opt__

```	
[root@lvm vagrant]# mount /dev/sdb /var/opt/ 
[root@lvm vagrant]# df -h
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00   38G  760M   37G   2% /
devtmpfs                         109M     0  109M   0% /dev
tmpfs                            118M     0  118M   0% /dev/shm
tmpfs                            118M  4.5M  114M   4% /run
tmpfs                            118M     0  118M   0% /sys/fs/cgroup
/dev/sda2                       1014M   63M  952M   7% /boot
tmpfs                             24M     0   24M   0% /run/user/1000
/dev/sdb                          12G   17M   10G   1% /var/opt
```
__Перейдем в папку и для наглядности создадим файлы__
```
[root@lvm opt]# cd opt/
[root@lvm opt]# ll
total 0
[root@lvm opt]# touch file{1..20}
[root@lvm opt]# ll
total 0
-rw-r--r--. 1 root root 0 Feb 19 11:10 file1
-rw-r--r--. 1 root root 0 Feb 19 11:10 file10
-rw-r--r--. 1 root root 0 Feb 19 11:10 file11
-rw-r--r--. 1 root root 0 Feb 19 11:10 file12
-rw-r--r--. 1 root root 0 Feb 19 11:10 file13
-rw-r--r--. 1 root root 0 Feb 19 11:10 file14
-rw-r--r--. 1 root root 0 Feb 19 11:10 file15
-rw-r--r--. 1 root root 0 Feb 19 11:10 file16
-rw-r--r--. 1 root root 0 Feb 19 11:10 file17
-rw-r--r--. 1 root root 0 Feb 19 11:10 file18
-rw-r--r--. 1 root root 0 Feb 19 11:10 file19
-rw-r--r--. 1 root root 0 Feb 19 11:10 file2
-rw-r--r--. 1 root root 0 Feb 19 11:10 file20
-rw-r--r--. 1 root root 0 Feb 19 11:10 file3
-rw-r--r--. 1 root root 0 Feb 19 11:10 file4
-rw-r--r--. 1 root root 0 Feb 19 11:10 file5
-rw-r--r--. 1 root root 0 Feb 19 11:10 file6
-rw-r--r--. 1 root root 0 Feb 19 11:10 file7
-rw-r--r--. 1 root root 0 Feb 19 11:10 file8
-rw-r--r--. 1 root root 0 Feb 19 11:10 file9

[root@lvm opt]# lslsblk
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   40G  0 disk 
├─sda1                    8:1    0    1M  0 part 
├─sda2                    8:2    0    1G  0 part /boot
└─sda3                    8:3    0   39G  0 part 
  ├─VolGroup00-LogVol00 253:0    0 37.5G  0 lvm  /
  └─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
sdb                       8:16   0   10G  0 disk /var/opt
sdc                       8:32   0    2G  0 disk 
sdd                       8:48   0    1G  0 disk 
sde                       8:64   0    1G  0 disk 
```
### 3.Работа со снапшотами на оставшихся дисках /dev/sdd, /dev/sde

__Монтируем диски для создания subvolume для последующего создания снапшота__
```
[root@lvm vagrant]# mount /dev/sde /mnt/sde
[root@lvm vagrant]# mount /dev/sdd /mnt/sdd
```
__Создаем дополнительные подразделы__
```
[root@lvm vagrant]# btrfs subvolume create /mnt/sdd/subv_1
[root@lvm vagrant]# btrfs subvolume create /mnt/sdd/subv_2
    Create subvolume '/mnt/sdd/subv_1'
    Create subvolume '/mnt/sdd/subv_2'

[root@lvm vagrant]# btrfs subvolume list /mnt/sdd
ID 256 gen 11 top level 5 path subv_1
ID 257 gen 12 top level 5 path subv_2

[root@lvm vagrant]# btrfs subvolume list /mnt/sde
ID 256 gen 8 top level 5 path subv_2
ID 257 gen 9 top level 5 path subv_1
```
__Переходим в смонтированую директорию /mnt/sdd/sub_v1/ создаем файлы__ 
```
[root@lvm vagrant]# cd /mnt/sdd/subv_1
[root@lvm vagrant]# touch file{1..10}
[root@lvm vagrant]# ls -l /mnt/sdd/subv_1
total 0
-rw-r--r--. 1 root root 0 Feb 19 13:54 file1
-rw-r--r--. 1 root root 0 Feb 19 13:54 file10
-rw-r--r--. 1 root root 0 Feb 19 13:54 file2
-rw-r--r--. 1 root root 0 Feb 19 13:54 file3
-rw-r--r--. 1 root root 0 Feb 19 13:54 file4
-rw-r--r--. 1 root root 0 Feb 19 13:54 file5
-rw-r--r--. 1 root root 0 Feb 19 13:54 file6
-rw-r--r--. 1 root root 0 Feb 19 13:54 file7
-rw-r--r--. 1 root root 0 Feb 19 13:54 file8
-rw-r--r--. 1 root root 0 Feb 19 13:54 file9
```
__Создаем снапшот с /mnt/sdd/subv_1 в /mnt/sdd/subv_2__
```
[root@lvm vagrant]# btrfs subvolume snapshot /mnt/sdd/subv_1 /mnt/sdd/subv_2
Create a snapshot of '/mnt/sdd/subv_1' in '/mnt/sdd/subv_2/subv_1'
```
__Проверяем наличие файлов в снапшоте__
```
[root@lvm vagrant]# ls -l /mnt/sdd/subv_2/subv_1/
total 0
-rw-r--r--. 1 root root 0 Feb 19 13:54 file1
-rw-r--r--. 1 root root 0 Feb 19 13:54 file10
-rw-r--r--. 1 root root 0 Feb 19 13:54 file2
-rw-r--r--. 1 root root 0 Feb 19 13:54 file3
-rw-r--r--. 1 root root 0 Feb 19 13:54 file4
-rw-r--r--. 1 root root 0 Feb 19 13:54 file5
-rw-r--r--. 1 root root 0 Feb 19 13:54 file6
-rw-r--r--. 1 root root 0 Feb 19 13:54 file7
-rw-r--r--. 1 root root 0 Feb 19 13:54 file8
-rw-r--r--. 1 root root 0 Feb 19 13:54 file9
```
__Удаляем часть файлов__
```
[root@lvm /]# rm -rf /mnt/sdd/subv_1/file{1..5} 
ls -l /mnt/sdd/subv_1
total 0
-rw-r--r--. 1 root root 0 Feb 20 07:53 file6
-rw-r--r--. 1 root root 0 Feb 20 07:53 file7
-rw-r--r--. 1 root root 0 Feb 20 07:53 file8
-rw-r--r--. 1 root root 0 Feb 20 07:53 file9
-rw-r--r--. 1 root root 0 Feb 20 07:53 file10
```
__Восстанавливаем файлы из снапшота__
```
[root@lvm /]# btrfs subvolume snapshot /mnt/sdd/subv_2 /mnt/dev/sdd/subv1
Create a snapshot of '/mnt/sdd/subv_2/subv_1/' in '/mnt/sdd/subv_1/subv_1'
[root@lvm /]# ls -la /mnt/sdd/subv_1
total 16
drwxr-xr-x. 1 root root 1184 Feb 20 07:43
drwxr-xr-x. 1 root root   44 Feb 20 08:01
-rw-r--r--. 1 root root    0 Feb 19 13:54 file1
-rw-r--r--. 1 root root    0 Feb 19 13:54 file10
-rw-r--r--. 1 root root    0 Feb 19 13:54 file2
-rw-r--r--. 1 root root    0 Feb 19 13:54 file3
-rw-r--r--. 1 root root    0 Feb 19 13:54 file4
-rw-r--r--. 1 root root    0 Feb 19 13:54 file5
-rw-r--r--. 1 root root    0 Feb 19 13:54 file6
-rw-r--r--. 1 root root    0 Feb 19 13:54 file7
-rw-r--r--. 1 root root    0 Feb 19 13:54 file8
-rw-r--r--. 1 root root    0 Feb 19 13:54 file9
```
