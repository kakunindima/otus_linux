# Otus-linux hometask
## Lesson 3
### LVM
### Main part: lvm
### 1.Уменьшение размера тома до 8G
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
__создаем временный том для root__
```
[vagrant@lvm ~]$ pvcreate /dev/sdb/
[root@lvm vagrant]# vgcreate vg_root /dev/sdb
   Volume group "new_root" successfully created
[root@lvm vagrant]# lvcreate -n lv_root -l +100%FREE /dev/new_root
  Logical volume "lv_root" created.

NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   40G  0 disk 
├─sda1                    8:1    0    1M  0 part 
├─sda2                    8:2    0    1G  0 part /boot
└─sda3                    8:3    0   39G  0 part 
  ├─VolGroup00-LogVol00 253:0    0 37.5G  0 lvm  /
  └─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
sdb                       8:16   0   10G  0 disk 
└─new_root-lv_root      253:2    0   10G  0 lvm  
sdc                       8:32   0    2G  0 disk 
sdd                       8:48   0    1G  0 disk 
sde                       8:64   0    1G  0 disk 
```
__Создаем фс, переносим данные__
```
[root@lvm vagrant]# mkfs.xfs /dev/new_root/-lv_root
meta-data=/dev/new_root/lv_root  isize=512    agcunt=4, agsize=655104 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=2620416, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[root@lvm vagrant]# mount /dev/new_root/lv_root /mnt/

[root@lvm vagrant]# xfsdump xfsdump -J - /dev/VolGroup00/LogVol00 | xfsrestore -J - /mnt
xfsdump: Dump Status: SUCCESS
xfsrestore: restore complete: 19 seconds elapsed
xfsrestore: Restore Status: SUCCESS

[root@lvm vagrant]# ls -la /mnt
total 12
drwxr-xr-x. 18 root    root     239 Feb 18 08:07 [0m[38;5;27m.[0m
dr-xr-xr-x. 18 root    root     239 Feb 18 07:56 [38;5;27m..[0m
lrwxrwxrwx.  1 root    root       7 Feb 18 08:07 [38;5;51mbin[0m -> [38;5;27musr/bin[0m
drwxr-xr-x.  2 root    root       6 May 12  2018 [38;5;27mboot[0m
drwxr-xr-x.  2 root    root       6 May 12  2018 [38;5;27mdev[0m
drwxr-xr-x. 79 root    root    8192 Feb 18 07:56 [38;5;27metc[0m
drwxr-xr-x.  3 root    root      21 May 12  2018 [38;5;27mhome[0m
lrwxrwxrwx.  1 root    root       7 Feb 18 08:07 [38;5;51mlib[0m -> [38;5;27musr/lib[0m
lrwxrwxrwx.  1 root    root       9 Feb 18 08:07 [38;5;51mlib64[0m -> [38;5;27musr/lib64[0m
drwxr-xr-x.  2 root    root       6 Apr 11  2018 [38;5;27mmedia[0m
drwxr-xr-x.  2 root    root       6 Apr 11  2018 [38;5;27mmnt[0m
drwxr-xr-x.  2 root    root       6 Apr 11  2018 [38;5;27mopt[0m
drwxr-xr-x.  2 root    root       6 May 12  2018 [38;5;27mproc[0m
dr-xr-x---.  3 root    root     149 Feb 18 07:56 [38;5;27mroot[0m
drwxr-xr-x.  2 root    root       6 May 12  2018 [38;5;27mrun[0m
lrwxrwxrwx.  1 root    root       8 Feb 18 08:07 [38;5;51msbin[0m -> [38;5;27musr/sbin[0m
drwxr-xr-x.  2 root    root       6 Apr 11  2018 [38;5;27msrv[0m
drwxr-xr-x.  2 root    root       6 May 12  2018 
drwxrwxrwt.  8 root    root     256 Feb 18 08:06 
drwxr-xr-x. 13 root    root     155 May 12  2018 
drwxr-xr-x.  3 vagrant vagrant   54 Feb 18 07:54 
drwxr-xr-x. 18 root    root     254 Feb 18 07:55 
```
__Перекоонфигурируем grub__
```
[root@lvm vagrant]# for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/$i; done
[root@lvm vagrant]# chroot /mnt/
[root@lvm /]#  grub2-mkconfig -o /boot/grub2/grub.cfg

Generating grub configuration file ...
Found linux image: /boot/vmlinuz-3.10.0-862.2.3.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-862.2.3.el7.x86_64.img
done
[root@lvm /]# cd /boot ; for i in `ls initramfs-*img`; do dracut -v $i `echo $i|sed "s/initramfs-//g;
> s/.img//g"` --force; done
*** Creating image file done ***
*** Creating initramfs image file '/boot/initramfs-3.10.0-862.2.3.el7.x86_64.img' done ***

[root@lvm boot]# vi /boot/grub2/grub.cfg 
[root@lvm vagrant]# reboot
```
__после перезгрузки удаляем радел и уменьшаем его размер до 8Гб__
```
[vagrant@lvm ~]$ lsblk
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   40G  0 disk 
├─sda1                    8:1    0    1M  0 part 
├─sda2                    8:2    0    1G  0 part /boot
└─sda3                    8:3    0   39G  0 part 
  ├─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
  └─VolGroup00-LogVol00 253:2    0 37.5G  0 lvm  
sdb                       8:16   0   10G  0 disk 
└─new_root-lv_root      253:0    0   10G  0 lvm  /
sdc                       8:32   0    2G  0 disk 
sdd                       8:48   0    1G  0 disk 
sde                       8:64   0    1G  0 disk 

[root@lvm vagrant]# lvremove /dev/VolGroup00/LogVol00
Do you really want to remove active logical volume VolGroup00/LogVol00? [y/n]: y
  Logical volume "LogVol00" successfully removed
[root@lvm vagrant]# llsblk

NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   40G  0 disk 
├─sda1                    8:1    0    1M  0 part 
├─sda2                    8:2    0    1G  0 part /boot
└─sda3                    8:3    0   39G  0 part 
  └─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
sdb                       8:16   0   10G  0 disk 
└─new_root-lv_root      253:0    0   10G  0 lvm  /
sdc                       8:32   0    2G  0 disk 
sdd                       8:48   0    1G  0 disk 
sde                       8:64   0    1G  0 disk 

[root@lvm vagrant]# lvcreate -n VolGroup00/LogVol00 -L 8G /dev/VolGroup00
WARNING: xfs signature detected on /dev/VolGroup00/LogVol00 at offset 0. Wipe it? [y/n]: y
  Wiping xfs signature on /dev/VolGroup00/LogVol00.
  Logical volume "LogVol00" created.

[root@lvm vagrant]# lvcreate -n VolGroup00/LogVol00 -L 8G /dev/VolGroup00

NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   40G  0 disk 
├─sda1                    8:1    0    1M  0 part 
├─sda2                    8:2    0    1G  0 part /boot
└─sda3                    8:3    0   39G  0 part 
  ├─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
  └─VolGroup00-LogVol00 253:2    0    8G  0 lvm  
sdb                       8:16   0   10G  0 disk 
└─new_root-lv_root      253:0    0   10G  0 lvm  /
sdc                       8:32   0    2G  0 disk 
sdd                       8:48   0    1G  0 disk 
sde                       8:64   0    1G  0 disk 
```
__Создаем файловую систему, монтируем, переносим данные, обновляем загрузчик__
```
[root@lvm vagrant]# mkfs.xfs /dev/VolGroup00/LogVol00
[root@lvm vagrant]# mount /dev/VolGroup00/LogVol00 /mnt/

[root@lvm vagrant]# xfsdump -J - /dev/VolGroup00/LogVol00 | xfsrestore -J - /mnt
xfsdump: Dump Status: SUCCESS
xfsrestore: restore complete: 28 seconds elapsed
xfsrestore: Restore Status: SUCCESS

[root@lvm vagrant]# for i in /proc/ /sys/ /dev/ /run/ /boot/; do mount --bind $i /mnt/$i; done
[root@lvm vagrant]# chroot /mnt/
[root@lvm /]# grub2-mkconfig -o /boot/grub2/grub.cfg
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-3.10.0-862.2.3.el7.x86_64
Found initrd image: /boot/initramfs-3.10.0-862.2.3.el7.x86_64.img
done

[root@lvm /]# cd /boot ; for i in `ls initramfs-*img`; do dracut -v $i `echo $i|sed "s/initramfs-//g;
> s/.img//g"` --force; done

*** Creating image file done ***
*** Creating initramfs image file '/boot/initramfs-3.10.0-862.2.3.el7.x86_64.img' done ***
[root@lvm boot]# lsblk
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   40G  0 disk 
├─sda1                    8:1    0    1M  0 part 
├─sda2                    8:2    0    1G  0 part /boot
└─sda3                    8:3    0   39G  0 part 
  ├─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
  └─VolGroup00-LogVol00 253:2    0    8G  0 lvm  /
sdb                       8:16   0   10G  0 disk 
└─new_root-lv_root      253:0    0   10G  0 lvm  
sdc                       8:32   0    2G  0 disk 
sdd                       8:48   0    1G  0 disk 
sde                       8:64   0    1G  0 disk 
```
### 2.Перенос каталога /home
__Создаем раздел__
```
[root@lvm boot]# pvcreate /dev/sdc /dev/sdd
  Physical volume "/dev/sdc" successfully created.
  Physical volume "/dev/sdd" successfully created.

[root@lvm boot]# vgcreate vg_var /dev/sdc dev/sdd
  Volume group "vg_var" successfully created

[root@lvm boot]# lsblk
NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                       8:0    0   40G  0 disk 
├─sda1                    8:1    0    1M  0 part 
├─sda2                    8:2    0    1G  0 part /boot
└─sda3                    8:3    0   39G  0 part 
  ├─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
  └─VolGroup00-LogVol00 253:2    0    8G  0 lvm  /
sdb                       8:16   0   10G  0 disk 
└─new_root-lv_root      253:0    0   10G  0 lvm  
sdc                       8:32   0    2G  0 disk 
sdd                       8:48   0    1G  0 disk 
sde                       8:64   0    1G  0 disk 

[root@lvm boot]# lvcreate -L 950M -m1 -n lv_var vg_var
  Rounding up size to full physical extent 952.00 MiB
  Logical volume "lv_var" created.

[root@lvm boot]# lvcreate -L 950M -m1 -n lv_var vg_var

NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                        8:0    0   40G  0 disk 
├─sda1                     8:1    0    1M  0 part 
├─sda2                     8:2    0    1G  0 part /boot
└─sda3                     8:3    0   39G  0 part 
  ├─VolGroup00-LogVol01  253:1    0  1.5G  0 lvm  [SWAP]
  └─VolGroup00-LogVol00  253:2    0    8G  0 lvm  /
sdb                        8:16   0   10G  0 disk 
└─new_root-lv_root       253:0    0   10G  0 lvm  
sdc                        8:32   0    2G  0 disk 
├─vg_var-lv_var_rmeta_0  253:3    0    4M  0 lvm  
│ └─vg_var-lv_var        253:7    0  952M  0 lvm  
└─vg_var-lv_var_rimage_0 253:4    0  952M  0 lvm  
  └─vg_var-lv_var        253:7    0  952M  0 lvm  
sdd                        8:48   0    1G  0 disk 
├─vg_var-lv_var_rmeta_1  253:5    0    4M  0 lvm  
│ └─vg_var-lv_var        253:7    0  952M  0 lvm  
└─vg_var-lv_var_rimage_1 253:6    0  952M  0 lvm  
  └─vg_var-lv_var        253:7    0  952M  0 lvm  
sde                        8:64   0    1G  0 disk 

[root@lvm boot]# mkfs.ext4 /dev/vg_var/lv_var
Writing superblocks and filesystem accounting information: 0/8 done
```
__Монтируем и переносим данные с var__
```
[root@lvm boot]# mount /dev/vg_var/lv_var /mnt/

[root@lvm boot]# cp -aR/var/* /mnt/
```
__Удаляем старый каталог__
```
[root@lvm boot]# mkdir /tmp/oldvar && mv /var/* /tmp/oldvar
[root@lvm boot]# umount /mnt
[root@lvm boot]# ls -l /var/
total 0

[root@lvm boot]# umount /mnt
```
__монтируем ноый каталог__
```
[root@lvm boot]#  mount /dev/vg_var/lv_var /var
[root@lvm vagrant]#ls -la /var/
total 84
drwxr-xr-x. 19 root root  4096 Feb 18 08:23 [0m[38;5;27m.
drwxr-xr-x. 18 root root   239 Feb 18 08:16 [38;5;27m..[0m
drwxr-xr-x.  2 root root  4096 Apr 11  2018 [38;5;27madm[0m
drwxr-xr-x.  5 root root  4096 May 12  2018 [38;5;27mcache[0m
drwxr-xr-x.  3 root root  4096 May 12  2018 [38;5;27mdb[0m
drwxr-xr-x.  3 root root  4096 May 12  2018 [38;5;27mempty[0m
drwxr-xr-x.  2 root root  4096 Apr 11  2018 [38;5;27mgames[0m
drwxr-xr-x.  2 root root  4096 Apr 11  2018 [38;5;27mgopher[0m
drwxr-xr-x.  3 root root  4096 May 12  2018 [38;5;27mkerberos[0m
drwxr-xr-x. 28 root root  4096 Feb 18 08:16 [38;5;27mlib[0m
drwxr-xr-x.  2 root root  4096 Apr 11  2018 [38;5;27mlocal[0m
lrwxrwxrwx.  1 root root    11 Feb 18 08:16 [38;5;51mlock[0m -> [38;5;27m../run/lock[0m
drwxr-xr-x.  8 root root  4096 Feb 18 08:11 [38;5;27mlog[0m
drwx------.  2 root root 16384 Feb 18 08:22 [38;5;27mlost+found[0m
lrwxrwxrwx.  1 root root    10 Feb 18 08:16 [38;5;51mmail[0m -> [38;5;27mspool/mail[0m
drwxr-xr-x.  2 root root  4096 Apr 11  2018 [38;5;27mnis[0m
drwxr-xr-x.  2 root root  4096 Apr 11  2018 [38;5;27mopt[0m
drwxr-xr-x.  2 root root  4096 Apr 11  2018 [38;5;27mpreserve[0m
lrwxrwxrwx.  1 root root     6 Feb 18 08:16 [38;5;51mrun[0m -> [38;5;27m../run[0m
drwxr-xr-x.  8 root root  4096 May 12  2018 [38;5;27mspool[0m
drwxrwxrwt.  4 root root  4096 Feb 18 08:19 [48;5;10;38;5;16mtmp[0m
drwxr-xr-x.  2 root root  4096 Apr 11  2018 [38;5;27myp[0m
[root@lvm boot]# echo "`blkid | grep var: | awk '{print $2}'` /var ext4 defaults 0 0" >> /etc/fstab
```
__Удаляем временный том созданный при уменьшении основного рут раздела__
```
[root@lvm boot]# reboot
[root@lvm vagrant]# lvremove /dev/vg_root/lv_root
Do you really want to remove active logical volume new_root/lv_root? [y/n]: y
  Logical volume "lv_root" successfully removed

[root@lvm vagrant]# lsblk
NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                        8:0    0   40G  0 disk 
├─sda1                     8:1    0    1M  0 part 
├─sda2                     8:2    0    1G  0 part /boot
└─sda3                     8:3    0   39G  0 part 
  ├─VolGroup00-LogVol00  253:0    0    8G  0 lvm  /
  └─VolGroup00-LogVol01  253:1    0  1.5G  0 lvm  [SWAP]
sdb                        8:16   0   10G  0 disk 
sdc                        8:32   0    2G  0 disk 
├─vg_var-lv_var_rmeta_0  253:2    0    4M  0 lvm  
│ └─vg_var-lv_var        253:6    0  952M  0 lvm  /var
└─vg_var-lv_var_rimage_0 253:3    0  952M  0 lvm  
  └─vg_var-lv_var        253:6    0  952M  0 lvm  /var
sdd                        8:48   0    1G  0 disk 
├─vg_var-lv_var_rmeta_1  253:4    0    4M  0 lvm  
│ └─vg_var-lv_var        253:6    0  952M  0 lvm  /var
└─vg_var-lv_var_rimage_1 253:5    0  952M  0 lvm  
  └─vg_var-lv_var        253:6    0  952M  0 lvm  /var
sde                        8:64   0    1G  0 disk 

[root@lvm vagrant]# vgremove /dev/new_root
  Volume group "new_root" successfully removed

[root@lvm vagrant]# vgremove /dev/new_root
lsblk
NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                        8:0    0   40G  0 disk 
├─sda1                     8:1    0    1M  0 part 
├─sda2                     8:2    0    1G  0 part /boot
└─sda3                     8:3    0   39G  0 part 
  ├─VolGroup00-LogVol00  253:0    0    8G  0 lvm  /
  └─VolGroup00-LogVol01  253:1    0  1.5G  0 lvm  [SWAP]
sdb                        8:16   0   10G  0 disk 
sdc                        8:32   0    2G  0 disk 
├─vg_var-lv_var_rmeta_0  253:2    0    4M  0 lvm  
│ └─vg_var-lv_var        253:6    0  952M  0 lvm  /var
└─vg_var-lv_var_rimage_0 253:3    0  952M  0 lvm  
  └─vg_var-lv_var        253:6    0  952M  0 lvm  /var
sdd                        8:48   0    1G  0 disk 
├─vg_var-lv_var_rmeta_1  253:4    0    4M  0 lvm  
│ └─vg_var-lv_var        253:6    0  952M  0 lvm  /var
└─vg_var-lv_var_rimage_1 253:5    0  952M  0 lvm  
  └─vg_var-lv_var        253:6    0  952M  0 lvm  /var
sde                        8:64   0    1G  0 disk 

[root@lvm vagrant]# vgs
  VG         #PV #LV #SN Attr   VSize   VFree  
  VolGroup00   1   2   0 wz--n- <38.97g <29.47g
  vg_var       2   1   0 wz--n-   2.99g   1.12g

[root@lvm vagrant]# lvs
  LV       VG         Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  LogVol00 VolGroup00 -wi-ao----   8.00g                                                    
  LogVol01 VolGroup00 -wi-ao----   1.50g                                                    
  lv_var   vg_var     rwi-aor--- 952.00m                                    100.00          

[root@lvm vagrant]# pvs
  PV         VG         Fmt  Attr PSize    PFree  
  /dev/sda3  VolGroup00 lvm2 a--   <38.97g <29.47g
  /dev/sdb              lvm2 ---    10.00g  10.00g
  /dev/sdc   vg_var     lvm2 a--    <2.00g   1.06g
  /dev/sdd   vg_var     lvm2 a--  1020.00m  64.00m

[root@lvm vagrant]#  pvremove /dev/sdb
  Labels on physical volume "/dev/sdb" successfully wiped.

[root@lvm vagrant]#  pvremove /dev/sdb
pvs
  PV         VG         Fmt  Attr PSize    PFree  
  /dev/sda3  VolGroup00 lvm2 a--   <38.97g <29.47g
  /dev/sdc   vg_var     lvm2 a--    <2.00g   1.06g
  /dev/sdd   vg_var     lvm2 a--  1020.00m  64.00m
```
__Создание снапшота с директории home__
__Создаем новыцй раздел и монтируем home__
```
[root@lvm vagrant]# lvcreate -n LogVol_Home -L 2G /dev/VolGroup00
  Logical volume "LogVol_Home" created.

[root@lvm vagrant]# lvs
  LV          VG         Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  LogVol00    VolGroup00 -wi-ao----   8.00g                                                    
  LogVol01    VolGroup00 -wi-ao----   1.50g                                                    
  LogVol_Home VolGroup00 -wi-a-----   2.00g                                                    
  lv_var      vg_var     rwi-aor--- 952.00m                                    100.00          

[root@lvm vagrant]# mkfs.xfs /dev/VolGroup00/LogVol_Home
meta-data=/dev/VolGroup00/LogVol_Home isize=512    agcount=4, agsize=131072 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=524288, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0

[root@lvm vagrant]# mount /dev/VolGroup00/LogVol_Home /mnt/
[root@lvm vagrant]# cp -aR /home/* /mnt/ 
[root@lvm vagrant]# ls -l /home/
total 0
drwx------. 3 vagrant vagrant 95 Feb 18 08:01

[root@lvm vagrant]# rm -rf /home/*

[root@lvm vagrant]#ls -l /home/
total 0

[root@lvm vagrant]# umount /mnt

[root@lvm vagrant]# mount /dev/VolGroup00/LogVol_Home /home/
[root@lvm vagrant]# echo "`blkid | grep Home | awk '{print $2}'` /home xfs defaults 0 0" >> /etc/fstab
```
__Создаем файлы, делаем снапшот, удаляем данные, восстанавливаем__
```
[root@lvm vagrant]# touch /home/file{1..40}
[root@lvm vagrant]#ls -la /home/
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file1
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file10
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file11
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file12
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file13
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file14
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file15
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file16
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file17
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file18
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file19
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file2
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file20
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file21
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file22
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file23
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file24
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file25
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file26
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file27
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file28
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file29
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file3
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file30
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file31
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file32
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file33
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file34
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file35
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file36
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file37
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file38
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file39
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file4
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file40
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file5
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file6
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file7
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file8
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file9

[root@lvm vagrant]# lvs
  LV          VG         Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  LogVol00    VolGroup00 -wi-ao----   8.00g                                                    
  LogVol01    VolGroup00 -wi-ao----   1.50g                                                    
  LogVol_Home VolGroup00 -wi-ao----   2.00g                                                    
  lv_var      vg_var     rwi-aor--- 952.00m                                    100.00          
```
__Создаем снапшот__
```
[root@lvm vagrant]#  lvcreate -L 100MB -s -n home_snap /dev/VolGroup00/LogVol_Home
  Rounding up size to full physical extent 128.00 MiB
  Logical volume "home_snap" created.

[root@lvm vagrant]#  lvcreate -L 100MB -s -n home_snap /dev/VolGroup00/LogVol_Home
[root@lvm vagrant]#lvs
  LV          VG         Attr       LSize   Pool Origin      Data%  Meta%  Move Log Cpy%Sync Convert
  LogVol00    VolGroup00 -wi-ao----   8.00g                                                         
  LogVol01    VolGroup00 -wi-ao----   1.50g                                                         
  LogVol_Home VolGroup00 owi-aos---   2.00g                                                         
  home_snap   VolGroup00 swi-a-s--- 128.00m      LogVol_Home 0.00                                   
  lv_var      vg_var     rwi-aor--- 952.00m                                         100.00          
```
__Удаляем файлы__
```
[root@lvm vagrant]#  rm -f /home/file{11..40}
[root@lvm vagrant]#ls -l /home/
total 0
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file1
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file10
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file2
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file3
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file4
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file5
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file6
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file7
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file8
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file9
[root@lvm vagrant]#lvs
  LV          VG         Attr       LSize   Pool Origin      Data%  Meta%  Move Log Cpy%Sync Convert
  LogVol00    VolGroup00 -wi-ao----   8.00g                                                         
  LogVol01    VolGroup00 -wi-ao----   1.50g                                                         
  LogVol_Home VolGroup00 owi-aos---   2.00g                                                         
  home_snap   VolGroup00 swi-a-s--- 128.00m      LogVol_Home 0.02                                   
  lv_var      vg_var     rwi-aor--- 952.00m                                         100.00          
[root@lvm vagrant]# umount /home
[root@lvm vagrant]#  lvconvert --merge /dev/VolGroup00/home_snap
  Merging of volume VolGroup00/home_snap started.
  VolGroup00/LogVol_Home: Merged: 100.00%
```
__Восстанавливаем фанные из снапшота__
```
[root@lvm vagrant]# umount /home

[root@lvm vagrant]# lvconvert --merge /dev/VolGroup00/home_snap
  LV          VG         Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  LogVol00    VolGroup00 -wi-ao----   8.00g                                                    
  LogVol01    VolGroup00 -wi-ao----   1.50g                                                    
  LogVol_Home VolGroup00 -wi-ao----   2.00g                                                    
  lv_var      vg_var     rwi-aor--- 952.00m                                    100.00          
[root@lvm vagrant] mount /home/
[root@lvm vagrant] ls -l /home/

total 0
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file1
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file10
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file11
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file12
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file13
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file14
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file15
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file16
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file17
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file18
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file19
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file2
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file20
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file21
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file22
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file23
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file24
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file25
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file26
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file27
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file28
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file29
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file3
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file30
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file31
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file32
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file33
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file34
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file35
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file36
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file37
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file38
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file39
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file4
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file40
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file5
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file6
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file7
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file8
-rw-r--r--. 1 root    root     0 Feb 18 09:40 file9
