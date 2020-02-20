# Otus-linux Hometask
## Less3 additional hometask *
### Установка btrfs
btrfs будем устанавливать на доступные диски - sdb,sdc,sdd,sde
выводим список:
``` [vagrant@lvm ~]$ lsblk

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

[root@lvm vagrant]# df -l
Filesystem                      1K-blocks   Used Available Use% Mounted on
/dev/mapper/VolGroup00-LogVol00  39269648 778048  38491600   2% /
devtmpfs                           110948      0    110948   0% /dev
tmpfs                              120692      0    120692   0% /dev/shm
tmpfs                              120692   4600    116092   4% /run
tmpfs                              120692      0    120692   0% /sys/fs/cgroup
/dev/sda2                         1038336  64076    974260   7% /boot
tmpfs                               24140      0     24140   0% /run/user/1000
[root@lvm vagrant]# df -l[Kmkdir /mnt/sdb
[root@lvm vagrant]# mount /dev/sdb/ [K[K /mnt/sdb/
[root@lvm vagrant]# mount /dev/sdb /mnt/sdb/[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Kdf -h
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00   38G  760M   37G   2% /
devtmpfs                         109M     0  109M   0% /dev
tmpfs                            118M     0  118M   0% /dev/shm
tmpfs                            118M  4.5M  114M   4% /run
tmpfs                            118M     0  118M   0% /sys/fs/cgroup
/dev/sda2                       1014M   63M  952M   7% /boot
tmpfs                             24M     0   24M   0% /run/user/1000
/dev/sdb                          10G   17M  8.0G   1% /mnt/sdb
[root@lvm vagrant]# btrfa devicce [K[K[Ke add /dev/sdc / [Kmnr[Kt/sdb/
bash: btrfa: command not found
[root@lvm vagrant]# btrfa device add /dev/sdc /mnt/sdb/[1P[1@s
/dev/sdc appears to contain an existing filesystem (btrfs).
ERROR: use the -f option to force overwrite of /dev/sdc
]0;root@lvm:/home/vagrant[root@lvm vagrant]# btrfs device add /dev/sdc /mnt/sdb/ -f
]0;root@lvm:/home/vagrant[root@lvm vagrant]# df -h
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00   38G  760M   37G   2% /
devtmpfs                         109M     0  109M   0% /dev
tmpfs                            118M     0  118M   0% /dev/shm
tmpfs                            118M  4.5M  114M   4% /run
tmpfs                            118M     0  118M   0% /sys/fs/cgroup
/dev/sda2                       1014M   63M  952M   7% /boot
tmpfs                             24M     0   24M   0% /run/user/1000
/dev/sdb                          12G   17M   10G   1% /mnt/sdb
]0;root@lvm:/home/vagrant[root@lvm vagrant]# lsblk
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
]0;root@lvm:/home/vagrant[root@lvm vagrant]# btrfs devce stats /n[Kmnt/sdb/
btrfs: unknown token 'devce'
usage: btrfs [--help] [--version] <group> [<group>...] <command> [<args>]

    btrfs subvolume create [-i <qgroupid>] [<dest>/]<name>
        Create a subvolume
    btrfs subvolume delete [options] <subvolume> [<subvolume>...]
        Delete subvolume(s)
    btrfs subvolume list [options] [-G [+|-]value] [-C [+|-]value] [--sort=gen,ogen,rootid,path] <path>
        List subvolumes (and snapshots)
    btrfs subvolume snapshot [-r] [-i <qgroupid>] <source> <dest>|[<dest>/]<name>
        Create a snapshot of the subvolume
    btrfs subvolume get-default <path>
        Get the default subvolume of a filesystem
    btrfs subvolume set-default <subvolid> <path>
        Set the default subvolume of a filesystem
    btrfs subvolume find-new <path> <lastgen>
        List the recently modified files in a filesystem
    btrfs subvolume show <subvol-path>
        Show more information of the subvolume
    btrfs subvolume sync <path> [<subvol-id>...]
        Wait until given subvolume(s) are completely removed from the filesystem.

    btrfs filesystem df [options] <path>
        Show space usage information for a mount point
    btrfs filesystem du [options] <path> [<path>..]
        Summarize disk usage of each file.
    btrfs filesystem show [options] [<path>|<uuid>|<device>|label]
        Show the structure of a filesystem
    btrfs filesystem sync <path>
        Force a sync on a filesystem
    btrfs filesystem defragment [options] <file>|<dir> [<file>|<dir>...]
        Defragment a file or a directory
    btrfs filesystem resize [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>
        Resize a filesystem
    btrfs filesystem label [<device>|<mount_point>] [<newlabel>]
        Get or change the label of a filesystem
    btrfs filesystem usage [options] <path> [<path>..]
        Show detailed information about internal filesystem usage .

    btrfs balance start [options] <path>
        Balance chunks across the devices
    btrfs balance pause <path>
        Pause running balance
    btrfs balance cancel <path>
        Cancel running or paused balance
    btrfs balance resume <path>
        Resume interrupted balance
    btrfs balance status [-v] <path>
        Show status of running or paused balance

    btrfs device add [options] <device> [<device>...] <path>
        Add a device to a filesystem
    btrfs device delete <device>|<devid> [<device>|<devid>...] <path>
    btrfs device remove <device>|<devid> [<device>|<devid>...] <path>
        Remove a device from a filesystem
    btrfs device scan [(-d|--all-devices)|<device> [<device>...]]
        Scan devices for a btrfs filesystem
    btrfs device ready <device>
        Check device to see if it has all of its devices in cache for mounting
    btrfs device stats [options] <path>|<device>
        Show device IO error statistics
    btrfs device usage [options] <path> [<path>..]
        Show detailed information about internal allocations in devices.

    btrfs scrub start [-BdqrRf] [-c ioprio_class -n ioprio_classdata] <path>|<device>
        Start a new scrub. If a scrub is already running, the new one fails.
    btrfs scrub cancel <path>|<device>
        Cancel a running scrub
    btrfs scrub resume [-BdqrR] [-c ioprio_class -n ioprio_classdata] <path>|<device>
        Resume previously canceled or interrupted scrub
    btrfs scrub status [-dR] <path>|<device>
        Show status of running or finished scrub

    btrfs check [options] <device>
        Check structural integrity of a filesystem (unmounted).

    btrfs rescue chunk-recover [options] <device>
        Recover the chunk tree by scanning the devices one by one.
    btrfs rescue super-recover [options] <device>
        Recover bad superblocks from good copies
    btrfs rescue zero-log <device>
        Clear the tree log. Usable if it's corrupted and prevents mount.

    btrfs restore [options] <device> <path> | -l <device>
        Try to restore files from a damaged filesystem (unmounted)

    btrfs inspect-internal inode-resolve [-v] <inode> <path>
        Get file system paths for the given inode
    btrfs inspect-internal logical-resolve [-Pv] [-s bufsize] <logical> <path>
        Get file system paths for the given logical address
    btrfs inspect-internal subvolid-resolve <subvolid> <path>
        Get file system paths for the given subvolume ID.
    btrfs inspect-internal rootid <path>
        Get tree ID of the containing subvolume of path.
    btrfs inspect-internal min-dev-size [options] <path>
        Get the minimum size the device can be shrunk to. The
    btrfs inspect-internal dump-tree [options] device
        Dump tree structures from a given device
    btrfs inspect-internal dump-super [options] device [device...]
        Dump superblock from a device in a textual form
    btrfs inspect-internal tree-stats [options] <device>
        Print various stats for trees

    btrfs property get [-t <type>] <object> [<name>]
        Gets a property from a btrfs object.
    btrfs property set [-t <type>] <object> <name> <value>
        Sets a property on a btrfs object.
    btrfs property list [-t <type>] <object>
        Lists available properties with their descriptions for the given object.

    btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]
        Send the subvolume(s) to stdout.
    btrfs receive [options] <mount>
btrfs receive --dump [options]
        Receive subvolumes from a stream

    btrfs quota enable <path>
        Enable subvolume quota support for a filesystem.
    btrfs quota disable <path>
        Disable subvolume quota support for a filesystem.
    btrfs quota rescan [-sw] <path>
        Trash all qgroup numbers and scan the metadata again with the current config.

    btrfs qgroup assign [options] <src> <dst> <path>
        Assign SRC as the child qgroup of DST
    btrfs qgroup remove <src> <dst> <path>
        Remove a child qgroup SRC from DST.
    btrfs qgroup create <qgroupid> <path>
        Create a subvolume quota group.
    btrfs qgroup destroy <qgroupid> <path>
        Destroy a quota group.
    btrfs qgroup show [options] <path>
        Show subvolume quota groups.
    btrfs qgroup limit [options] <size>|none [<qgroupid>] <path>
        Set the limits a subvolume quota group.

    btrfs replace start [-Bfr] <srcdev>|<devid> <targetdev> <mount_point>
        Replace device of a btrfs filesystem.
    btrfs replace status [-1] <mount_point>
        Print status and progress information of a running device replace
    btrfs replace cancel <mount_point>
        Cancel a running device replace operation.

    btrfs help [--full]
        Display help information
    btrfs version
        Display btrfs-progs version

Use --help as an argument for information on a specific group or command.
]0;root@lvm:/home/vagrant[root@lvm vagrant]# btrfs devce stats /mnt/sdb/[1@i
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
]0;root@lvm:/home/vagrant[root@lvm vagrant]# btrfs filesystem show --mounted
Label: none  uuid: a8383377-ba69-40fe-b6c0-c0c862eed531
	Total devices 2 FS bytes used 384.00KiB
	devid    1 size 10.00GiB used 2.02GiB path /dev/sdb
	devid    2 size 2.00GiB used 0.00B path /dev/sdc

]0;root@lvm:/home/vagrant[root@lvm vagrant]# btrfs filesystem show --mounted[3Pdevice stats /mnt/sdb/[1P[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Clsblk[Kdf -h
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00   38G  760M   37G   2% /
devtmpfs                         109M     0  109M   0% /dev
tmpfs                            118M     0  118M   0% /dev/shm
tmpfs                            118M  4.5M  114M   4% /run
tmpfs                            118M     0  118M   0% /sys/fs/cgroup
/dev/sda2                       1014M   63M  952M   7% /boot
tmpfs                             24M     0   24M   0% /run/user/1000
/dev/sdb                          12G   17M   10G   1% /mnt/sdb
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /mnt/sdb/
total 0
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /mnt/sdb/[Ca /mnt/sdb/
total 16
drwxr-xr-x. 1 root root  0 Feb 19 09:11 [0m[38;5;27m.[0m
drwxr-xr-x. 3 root root 17 Feb 19 09:12 [38;5;27m..[0m
]0;root@lvm:/home/vagrant[root@lvm vagrant]# [K[root@lvm vagrant]# [K[root@lvm vagrant]# ls -la /mnt/sdb/[K[K[root@lvm vagrant]# [K[root@lvm vagrant]# иек[K[K[Kbtrfs[K[K[K[K[K,[Kmkfs.btrfs [K[K[K[K[K[K[K[K[K[K[Kls -l /var/opt/
total 0
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /var/opt/[Kmkdir /dev/sdb/opt
mkdir: cannot create directory ‘/dev/sdb/opt’: Not a directory
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mkdir /dev/sdb/opt[C[C[K[K[K[K[K[K[K[K[K[K[Kmnt/sdb/opt
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mount /var/opt/ /mnt/[K[K[K[Kdev/sdb [K/oo[Kp[Kpt
mount: mount point /dev/sdb/opt is not a directory
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mount /var/opt/ /dev/sdb/opt[1P/opt[1P/opt[1P/opt[1Popt[1P/opt[1P/opt[1P/opt[1Popt[1P/opt[1Popt[1P/opt[1P/opt[1P/opt[1Popt[1P/opt[1P/opt[1P/opt[1Popt[1P/opt[1P/opt[1P/opt[1P/opt[1Popt[1Ppt[1Pt[1Pt[1Pt[Kumount /n[Kmnt/
umount: /mnt/: not mounted
]0;root@lvm:/home/vagrant[root@lvm vagrant]# umount /mnt/sdb/
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mount /var/opt/ /dev/sdb
mount:  /var/opt is not a block device
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mount /var/opt/ /dev/sdb[1P /dev/sdb[1P /dev/sdb[1P /dev/sdb[1P /dev/sdb[1P /dev/sdb[1P /dev/sdb[1P /dev/sdb[1P /dev/sdb[1P /dev/sdb[1P/dev/sdb[C[C[C[C[C[C[C[C[C /var/opt/
]0;root@lvm:/home/vagrant[root@lvm vagrant]# df -h
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00   38G  760M   37G   2% /
devtmpfs                         109M     0  109M   0% /dev
tmpfs                            118M     0  118M   0% /dev/shm
tmpfs                            118M  4.5M  114M   4% /run
tmpfs                            118M     0  118M   0% /sys/fs/cgroup
/dev/sda2                       1014M   63M  952M   7% /boot
tmpfs                             24M     0   24M   0% /run/user/1000
/dev/sdb                          12G   17M   10G   1% /var/opt
]0;root@lvm:/home/vagrant[root@lvm vagrant]# cd [K[K[Ktouch file {}1}/}/}[1P}[1P}.}.}2}0}[C /var/opt/
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /var/opt/
total 0
drwxr-xr-x. 1 root root 0 Feb 19 11:05 [0m[38;5;27mopt[0m
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /var/opt/a /var/opt/
total 16
drwxr-xr-x.  1 root root   6 Feb 19 11:09 [0m[38;5;27m.[0m
drwxr-xr-x. 18 root root 254 Feb 19 09:06 [38;5;27m..[0m
drwxr-xr-x.  1 root root   0 Feb 19 11:05 [38;5;27mopt[0m
]0;root@lvm:/home/vagrant[root@lvm vagrant]# cd /var/opt/
]0;root@lvm:/var/opt[root@lvm opt]# ll
total 0
drwxr-xr-x. 1 root root 0 Feb 19 11:05 [0m[38;5;27mopt[0m
]0;root@lvm:/var/opt[root@lvm opt]# cd opt/
]0;root@lvm:/var/opt/opt[root@lvm opt]# ll
total 0
]0;root@lvm:/var/opt/opt[root@lvm opt]# llcd opt/ll[Kcd /var/opt/[4@ls -la[C[C[C[C[C[C[C[C[C[C[1P /var/opt/a /var/opt/[4Pcd[C[C[C[C[C[C[C[C[C[Cll[Kcd opt/ll[K[Kcd ..
]0;root@lvm:/var/opt[root@lvm opt]# ll
total 0
drwxr-xr-x. 1 root root 0 Feb 19 11:05 [0m[38;5;27mopt[0m
]0;root@lvm:/var/opt[root@lvm opt]# touch file{}1}.}.}2}0}
]0;root@lvm:/var/opt[root@lvm opt]# ll
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
drwxr-xr-x. 1 root root 0 Feb 19 11:05 [0m[38;5;27mopt[0m
]0;root@lvm:/var/opt[root@lvm opt]# [K[root@lvm opt]# [K[root@lvm opt]# fd -f
bash: fd: command not found
]0;root@lvm:/var/opt[root@lvm opt]# fd -f[1P -f[1P -fd -ff -f
df: invalid option -- 'f'
Try 'df --help' for more information.
]0;root@lvm:/var/opt[root@lvm opt]# df -f[Kh
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00   38G  760M   37G   2% /
devtmpfs                         109M     0  109M   0% /dev
tmpfs                            118M     0  118M   0% /dev/shm
tmpfs                            118M  4.5M  114M   4% /run
tmpfs                            118M     0  118M   0% /sys/fs/cgroup
/dev/sda2                       1014M   63M  952M   7% /boot
tmpfs                             24M     0   24M   0% /run/user/1000
/dev/sdb                          12G   17M   10G   1% /var/opt
]0;root@lvm:/var/opt[root@lvm opt]# lslsblk
bash: lslsblk: command not found
]0;root@lvm:/var/opt[root@lvm opt]# lslsblk[1Plsblk[1Psblk
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
]0;root@lvm:/var/opt[root@lvm opt]# btrfs subbvoolume [1P[C[C[C[C[C[C[C[Clist
btrfs: unknown token 'subvoolume'
usage: btrfs [--help] [--version] <group> [<group>...] <command> [<args>]

    btrfs subvolume create [-i <qgroupid>] [<dest>/]<name>
        Create a subvolume
    btrfs subvolume delete [options] <subvolume> [<subvolume>...]
        Delete subvolume(s)
    btrfs subvolume list [options] [-G [+|-]value] [-C [+|-]value] [--sort=gen,ogen,rootid,path] <path>
        List subvolumes (and snapshots)
    btrfs subvolume snapshot [-r] [-i <qgroupid>] <source> <dest>|[<dest>/]<name>
        Create a snapshot of the subvolume
    btrfs subvolume get-default <path>
        Get the default subvolume of a filesystem
    btrfs subvolume set-default <subvolid> <path>
        Set the default subvolume of a filesystem
    btrfs subvolume find-new <path> <lastgen>
        List the recently modified files in a filesystem
    btrfs subvolume show <subvol-path>
        Show more information of the subvolume
    btrfs subvolume sync <path> [<subvol-id>...]
        Wait until given subvolume(s) are completely removed from the filesystem.

    btrfs filesystem df [options] <path>
        Show space usage information for a mount point
    btrfs filesystem du [options] <path> [<path>..]
        Summarize disk usage of each file.
    btrfs filesystem show [options] [<path>|<uuid>|<device>|label]
        Show the structure of a filesystem
    btrfs filesystem sync <path>
        Force a sync on a filesystem
    btrfs filesystem defragment [options] <file>|<dir> [<file>|<dir>...]
        Defragment a file or a directory
    btrfs filesystem resize [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>
        Resize a filesystem
    btrfs filesystem label [<device>|<mount_point>] [<newlabel>]
        Get or change the label of a filesystem
    btrfs filesystem usage [options] <path> [<path>..]
        Show detailed information about internal filesystem usage .

    btrfs balance start [options] <path>
        Balance chunks across the devices
    btrfs balance pause <path>
        Pause running balance
    btrfs balance cancel <path>
        Cancel running or paused balance
    btrfs balance resume <path>
        Resume interrupted balance
    btrfs balance status [-v] <path>
        Show status of running or paused balance

    btrfs device add [options] <device> [<device>...] <path>
        Add a device to a filesystem
    btrfs device delete <device>|<devid> [<device>|<devid>...] <path>
    btrfs device remove <device>|<devid> [<device>|<devid>...] <path>
        Remove a device from a filesystem
    btrfs device scan [(-d|--all-devices)|<device> [<device>...]]
        Scan devices for a btrfs filesystem
    btrfs device ready <device>
        Check device to see if it has all of its devices in cache for mounting
    btrfs device stats [options] <path>|<device>
        Show device IO error statistics
    btrfs device usage [options] <path> [<path>..]
        Show detailed information about internal allocations in devices.

    btrfs scrub start [-BdqrRf] [-c ioprio_class -n ioprio_classdata] <path>|<device>
        Start a new scrub. If a scrub is already running, the new one fails.
    btrfs scrub cancel <path>|<device>
        Cancel a running scrub
    btrfs scrub resume [-BdqrR] [-c ioprio_class -n ioprio_classdata] <path>|<device>
        Resume previously canceled or interrupted scrub
    btrfs scrub status [-dR] <path>|<device>
        Show status of running or finished scrub

    btrfs check [options] <device>
        Check structural integrity of a filesystem (unmounted).

    btrfs rescue chunk-recover [options] <device>
        Recover the chunk tree by scanning the devices one by one.
    btrfs rescue super-recover [options] <device>
        Recover bad superblocks from good copies
    btrfs rescue zero-log <device>
        Clear the tree log. Usable if it's corrupted and prevents mount.

    btrfs restore [options] <device> <path> | -l <device>
        Try to restore files from a damaged filesystem (unmounted)

    btrfs inspect-internal inode-resolve [-v] <inode> <path>
        Get file system paths for the given inode
    btrfs inspect-internal logical-resolve [-Pv] [-s bufsize] <logical> <path>
        Get file system paths for the given logical address
    btrfs inspect-internal subvolid-resolve <subvolid> <path>
        Get file system paths for the given subvolume ID.
    btrfs inspect-internal rootid <path>
        Get tree ID of the containing subvolume of path.
    btrfs inspect-internal min-dev-size [options] <path>
        Get the minimum size the device can be shrunk to. The
    btrfs inspect-internal dump-tree [options] device
        Dump tree structures from a given device
    btrfs inspect-internal dump-super [options] device [device...]
        Dump superblock from a device in a textual form
    btrfs inspect-internal tree-stats [options] <device>
        Print various stats for trees

    btrfs property get [-t <type>] <object> [<name>]
        Gets a property from a btrfs object.
    btrfs property set [-t <type>] <object> <name> <value>
        Sets a property on a btrfs object.
    btrfs property list [-t <type>] <object>
        Lists available properties with their descriptions for the given object.

    btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]
        Send the subvolume(s) to stdout.
    btrfs receive [options] <mount>
btrfs receive --dump [options]
        Receive subvolumes from a stream

    btrfs quota enable <path>
        Enable subvolume quota support for a filesystem.
    btrfs quota disable <path>
        Disable subvolume quota support for a filesystem.
    btrfs quota rescan [-sw] <path>
        Trash all qgroup numbers and scan the metadata again with the current config.

    btrfs qgroup assign [options] <src> <dst> <path>
        Assign SRC as the child qgroup of DST
    btrfs qgroup remove <src> <dst> <path>
        Remove a child qgroup SRC from DST.
    btrfs qgroup create <qgroupid> <path>
        Create a subvolume quota group.
    btrfs qgroup destroy <qgroupid> <path>
        Destroy a quota group.
    btrfs qgroup show [options] <path>
        Show subvolume quota groups.
    btrfs qgroup limit [options] <size>|none [<qgroupid>] <path>
        Set the limits a subvolume quota group.

    btrfs replace start [-Bfr] <srcdev>|<devid> <targetdev> <mount_point>
        Replace device of a btrfs filesystem.
    btrfs replace status [-1] <mount_point>
        Print status and progress information of a running device replace
    btrfs replace cancel <mount_point>
        Cancel a running device replace operation.

    btrfs help [--full]
        Display help information
    btrfs version
        Display btrfs-progs version

Use --help as an argument for information on a specific group or command.
]0;root@lvm:/var/opt[root@lvm opt]# btrfs subvoolume list /mnt
btrfs: unknown token 'subvoolume'
usage: btrfs [--help] [--version] <group> [<group>...] <command> [<args>]

    btrfs subvolume create [-i <qgroupid>] [<dest>/]<name>
        Create a subvolume
    btrfs subvolume delete [options] <subvolume> [<subvolume>...]
        Delete subvolume(s)
    btrfs subvolume list [options] [-G [+|-]value] [-C [+|-]value] [--sort=gen,ogen,rootid,path] <path>
        List subvolumes (and snapshots)
    btrfs subvolume snapshot [-r] [-i <qgroupid>] <source> <dest>|[<dest>/]<name>
        Create a snapshot of the subvolume
    btrfs subvolume get-default <path>
        Get the default subvolume of a filesystem
    btrfs subvolume set-default <subvolid> <path>
        Set the default subvolume of a filesystem
    btrfs subvolume find-new <path> <lastgen>
        List the recently modified files in a filesystem
    btrfs subvolume show <subvol-path>
        Show more information of the subvolume
    btrfs subvolume sync <path> [<subvol-id>...]
        Wait until given subvolume(s) are completely removed from the filesystem.

    btrfs filesystem df [options] <path>
        Show space usage information for a mount point
    btrfs filesystem du [options] <path> [<path>..]
        Summarize disk usage of each file.
    btrfs filesystem show [options] [<path>|<uuid>|<device>|label]
        Show the structure of a filesystem
    btrfs filesystem sync <path>
        Force a sync on a filesystem
    btrfs filesystem defragment [options] <file>|<dir> [<file>|<dir>...]
        Defragment a file or a directory
    btrfs filesystem resize [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>
        Resize a filesystem
    btrfs filesystem label [<device>|<mount_point>] [<newlabel>]
        Get or change the label of a filesystem
    btrfs filesystem usage [options] <path> [<path>..]
        Show detailed information about internal filesystem usage .

    btrfs balance start [options] <path>
        Balance chunks across the devices
    btrfs balance pause <path>
        Pause running balance
    btrfs balance cancel <path>
        Cancel running or paused balance
    btrfs balance resume <path>
        Resume interrupted balance
    btrfs balance status [-v] <path>
        Show status of running or paused balance

    btrfs device add [options] <device> [<device>...] <path>
        Add a device to a filesystem
    btrfs device delete <device>|<devid> [<device>|<devid>...] <path>
    btrfs device remove <device>|<devid> [<device>|<devid>...] <path>
        Remove a device from a filesystem
    btrfs device scan [(-d|--all-devices)|<device> [<device>...]]
        Scan devices for a btrfs filesystem
    btrfs device ready <device>
        Check device to see if it has all of its devices in cache for mounting
    btrfs device stats [options] <path>|<device>
        Show device IO error statistics
    btrfs device usage [options] <path> [<path>..]
        Show detailed information about internal allocations in devices.

    btrfs scrub start [-BdqrRf] [-c ioprio_class -n ioprio_classdata] <path>|<device>
        Start a new scrub. If a scrub is already running, the new one fails.
    btrfs scrub cancel <path>|<device>
        Cancel a running scrub
    btrfs scrub resume [-BdqrR] [-c ioprio_class -n ioprio_classdata] <path>|<device>
        Resume previously canceled or interrupted scrub
    btrfs scrub status [-dR] <path>|<device>
        Show status of running or finished scrub

    btrfs check [options] <device>
        Check structural integrity of a filesystem (unmounted).

    btrfs rescue chunk-recover [options] <device>
        Recover the chunk tree by scanning the devices one by one.
    btrfs rescue super-recover [options] <device>
        Recover bad superblocks from good copies
    btrfs rescue zero-log <device>
        Clear the tree log. Usable if it's corrupted and prevents mount.

    btrfs restore [options] <device> <path> | -l <device>
        Try to restore files from a damaged filesystem (unmounted)

    btrfs inspect-internal inode-resolve [-v] <inode> <path>
        Get file system paths for the given inode
    btrfs inspect-internal logical-resolve [-Pv] [-s bufsize] <logical> <path>
        Get file system paths for the given logical address
    btrfs inspect-internal subvolid-resolve <subvolid> <path>
        Get file system paths for the given subvolume ID.
    btrfs inspect-internal rootid <path>
        Get tree ID of the containing subvolume of path.
    btrfs inspect-internal min-dev-size [options] <path>
        Get the minimum size the device can be shrunk to. The
    btrfs inspect-internal dump-tree [options] device
        Dump tree structures from a given device
    btrfs inspect-internal dump-super [options] device [device...]
        Dump superblock from a device in a textual form
    btrfs inspect-internal tree-stats [options] <device>
        Print various stats for trees

    btrfs property get [-t <type>] <object> [<name>]
        Gets a property from a btrfs object.
    btrfs property set [-t <type>] <object> <name> <value>
        Sets a property on a btrfs object.
    btrfs property list [-t <type>] <object>
        Lists available properties with their descriptions for the given object.

    btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]
        Send the subvolume(s) to stdout.
    btrfs receive [options] <mount>
btrfs receive --dump [options]
        Receive subvolumes from a stream

    btrfs quota enable <path>
        Enable subvolume quota support for a filesystem.
    btrfs quota disable <path>
        Disable subvolume quota support for a filesystem.
    btrfs quota rescan [-sw] <path>
        Trash all qgroup numbers and scan the metadata again with the current config.

    btrfs qgroup assign [options] <src> <dst> <path>
        Assign SRC as the child qgroup of DST
    btrfs qgroup remove <src> <dst> <path>
        Remove a child qgroup SRC from DST.
    btrfs qgroup create <qgroupid> <path>
        Create a subvolume quota group.
    btrfs qgroup destroy <qgroupid> <path>
        Destroy a quota group.
    btrfs qgroup show [options] <path>
        Show subvolume quota groups.
    btrfs qgroup limit [options] <size>|none [<qgroupid>] <path>
        Set the limits a subvolume quota group.

    btrfs replace start [-Bfr] <srcdev>|<devid> <targetdev> <mount_point>
        Replace device of a btrfs filesystem.
    btrfs replace status [-1] <mount_point>
        Print status and progress information of a running device replace
    btrfs replace cancel <mount_point>
        Cancel a running device replace operation.

    btrfs help [--full]
        Display help information
    btrfs version
        Display btrfs-progs version

Use --help as an argument for information on a specific group or command.
]0;root@lvm:/var/opt[root@lvm opt]# btrfs subvoolume list /mnt[K[K[K[K[K[K[K[K[Kcreate /dev/sdd
btrfs: unknown token 'subvoolume'
usage: btrfs [--help] [--version] <group> [<group>...] <command> [<args>]

    btrfs subvolume create [-i <qgroupid>] [<dest>/]<name>
        Create a subvolume
    btrfs subvolume delete [options] <subvolume> [<subvolume>...]
        Delete subvolume(s)
    btrfs subvolume list [options] [-G [+|-]value] [-C [+|-]value] [--sort=gen,ogen,rootid,path] <path>
        List subvolumes (and snapshots)
    btrfs subvolume snapshot [-r] [-i <qgroupid>] <source> <dest>|[<dest>/]<name>
        Create a snapshot of the subvolume
    btrfs subvolume get-default <path>
        Get the default subvolume of a filesystem
    btrfs subvolume set-default <subvolid> <path>
        Set the default subvolume of a filesystem
    btrfs subvolume find-new <path> <lastgen>
        List the recently modified files in a filesystem
    btrfs subvolume show <subvol-path>
        Show more information of the subvolume
    btrfs subvolume sync <path> [<subvol-id>...]
        Wait until given subvolume(s) are completely removed from the filesystem.

    btrfs filesystem df [options] <path>
        Show space usage information for a mount point
    btrfs filesystem du [options] <path> [<path>..]
        Summarize disk usage of each file.
    btrfs filesystem show [options] [<path>|<uuid>|<device>|label]
        Show the structure of a filesystem
    btrfs filesystem sync <path>
        Force a sync on a filesystem
    btrfs filesystem defragment [options] <file>|<dir> [<file>|<dir>...]
        Defragment a file or a directory
    btrfs filesystem resize [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>
        Resize a filesystem
    btrfs filesystem label [<device>|<mount_point>] [<newlabel>]
        Get or change the label of a filesystem
    btrfs filesystem usage [options] <path> [<path>..]
        Show detailed information about internal filesystem usage .

    btrfs balance start [options] <path>
        Balance chunks across the devices
    btrfs balance pause <path>
        Pause running balance
    btrfs balance cancel <path>
        Cancel running or paused balance
    btrfs balance resume <path>
        Resume interrupted balance
    btrfs balance status [-v] <path>
        Show status of running or paused balance

    btrfs device add [options] <device> [<device>...] <path>
        Add a device to a filesystem
    btrfs device delete <device>|<devid> [<device>|<devid>...] <path>
    btrfs device remove <device>|<devid> [<device>|<devid>...] <path>
        Remove a device from a filesystem
    btrfs device scan [(-d|--all-devices)|<device> [<device>...]]
        Scan devices for a btrfs filesystem
    btrfs device ready <device>
        Check device to see if it has all of its devices in cache for mounting
    btrfs device stats [options] <path>|<device>
        Show device IO error statistics
    btrfs device usage [options] <path> [<path>..]
        Show detailed information about internal allocations in devices.

    btrfs scrub start [-BdqrRf] [-c ioprio_class -n ioprio_classdata] <path>|<device>
        Start a new scrub. If a scrub is already running, the new one fails.
    btrfs scrub cancel <path>|<device>
        Cancel a running scrub
    btrfs scrub resume [-BdqrR] [-c ioprio_class -n ioprio_classdata] <path>|<device>
        Resume previously canceled or interrupted scrub
    btrfs scrub status [-dR] <path>|<device>
        Show status of running or finished scrub

    btrfs check [options] <device>
        Check structural integrity of a filesystem (unmounted).

    btrfs rescue chunk-recover [options] <device>
        Recover the chunk tree by scanning the devices one by one.
    btrfs rescue super-recover [options] <device>
        Recover bad superblocks from good copies
    btrfs rescue zero-log <device>
        Clear the tree log. Usable if it's corrupted and prevents mount.

    btrfs restore [options] <device> <path> | -l <device>
        Try to restore files from a damaged filesystem (unmounted)

    btrfs inspect-internal inode-resolve [-v] <inode> <path>
        Get file system paths for the given inode
    btrfs inspect-internal logical-resolve [-Pv] [-s bufsize] <logical> <path>
        Get file system paths for the given logical address
    btrfs inspect-internal subvolid-resolve <subvolid> <path>
        Get file system paths for the given subvolume ID.
    btrfs inspect-internal rootid <path>
        Get tree ID of the containing subvolume of path.
    btrfs inspect-internal min-dev-size [options] <path>
        Get the minimum size the device can be shrunk to. The
    btrfs inspect-internal dump-tree [options] device
        Dump tree structures from a given device
    btrfs inspect-internal dump-super [options] device [device...]
        Dump superblock from a device in a textual form
    btrfs inspect-internal tree-stats [options] <device>
        Print various stats for trees

    btrfs property get [-t <type>] <object> [<name>]
        Gets a property from a btrfs object.
    btrfs property set [-t <type>] <object> <name> <value>
        Sets a property on a btrfs object.
    btrfs property list [-t <type>] <object>
        Lists available properties with their descriptions for the given object.

    btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]
        Send the subvolume(s) to stdout.
    btrfs receive [options] <mount>
btrfs receive --dump [options]
        Receive subvolumes from a stream

    btrfs quota enable <path>
        Enable subvolume quota support for a filesystem.
    btrfs quota disable <path>
        Disable subvolume quota support for a filesystem.
    btrfs quota rescan [-sw] <path>
        Trash all qgroup numbers and scan the metadata again with the current config.

    btrfs qgroup assign [options] <src> <dst> <path>
        Assign SRC as the child qgroup of DST
    btrfs qgroup remove <src> <dst> <path>
        Remove a child qgroup SRC from DST.
    btrfs qgroup create <qgroupid> <path>
        Create a subvolume quota group.
    btrfs qgroup destroy <qgroupid> <path>
        Destroy a quota group.
    btrfs qgroup show [options] <path>
        Show subvolume quota groups.
    btrfs qgroup limit [options] <size>|none [<qgroupid>] <path>
        Set the limits a subvolume quota group.

    btrfs replace start [-Bfr] <srcdev>|<devid> <targetdev> <mount_point>
        Replace device of a btrfs filesystem.
    btrfs replace status [-1] <mount_point>
        Print status and progress information of a running device replace
    btrfs replace cancel <mount_point>
        Cancel a running device replace operation.

    btrfs help [--full]
        Display help information
    btrfs version
        Display btrfs-progs version

Use --help as an argument for information on a specific group or command.
]0;root@lvm:/var/opt[root@lvm opt]# btrfs subvoolume create /dev/sdd[1P
ERROR: target path already exists: /dev/sdd
]0;root@lvm:/var/opt[root@lvm opt]# btrfs subvolume create /dev/sdd/subvol1
ERROR: cannot access /dev/sdd/subvol1: Not a directory
]0;root@lvm:/var/opt[root@lvm opt]# btrfs subvolume create /dev/sdd/subvol1[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Kbtrfs subvolume create /dev/sdd/subvol1[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Kmount /dev/sdd /mnt/sdd
mount: mount point /mnt/sdd does not exist
]0;root@lvm:/var/opt[root@lvm opt]# mount /dev/sdd /mnt/sdd[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Kmkdir /mnt.[K/d[Ksdd
]0;root@lvm:/var/opt[root@lvm opt]# mkdir /mnt/sdd[Ke
]0;root@lvm:/var/opt[root@lvm opt]# mkdir /mnt/sded[9@ount /dev/sdd[C[C[C[C[C[C[C[C[C
mount: wrong fs type, bad option, bad superblock on /dev/sdd,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
]0;root@lvm:/var/opt[root@lvm opt]# mount /dev/sdd /mnt/sdd/
mount: wrong fs type, bad option, bad superblock on /dev/sdd,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
]0;root@lvm:/var/opt[root@lvm opt]# mount /dev/sdd /mnt/sdd/[1P /mnt/sdd/e /mnt/sdd/[C[C[C[C[C[C[C[Ced/ed/[1P/[1P/[K
mount: /dev/sde is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on /dev/sde,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
]0;root@lvm:/var/opt[root@lvm opt]# mount /dev/sde /mnt/sde[1P /mnt/sde[1P /mnt/sde[1P /mnt/sde[1P /mnt/sde[1P /mnt/sde[1P /mnt/sde[1P /mnt/sdem /mnt/sden /mnt/sdet /mnt/sde/ /mnt/sdes /mnt/sded /mnt/sded /mnt/sde[C[C[1Pnt/sde[1Pt/sde[1P/sded/sdee/sdev/sde[C[C[C[Kd
mount:  /mnt/sdd is not a block device
]0;root@lvm:/var/opt[root@lvm opt]# mount /mnt/sdd /dev/sdddev/sde /mnt/sde[K[K[K
mount: /dev/sde is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on /dev/sde,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
]0;root@lvm:/var/opt[root@lvm opt]# dmesg -T
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys cpuset
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys cpu
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys cpuacct
[Wed Feb 19 09:05:46 2020] Linux version 3.10.0-862.2.3.el7.x86_64 (builder@kbuilder.dev.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-28) (GCC) ) #1 SMP Wed May 9 18:05:47 UTC 2018
[Wed Feb 19 09:05:46 2020] Command line: BOOT_IMAGE=/vmlinuz-3.10.0-862.2.3.el7.x86_64 root=/dev/mapper/VolGroup00-LogVol00 ro no_timer_check console=tty0 console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 elevator=noop crashkernel=auto rd.lvm.lv=VolGroup00/LogVol00 rd.lvm.lv=VolGroup00/LogVol01 rhgb quiet
[Wed Feb 19 09:05:46 2020] e820: BIOS-provided physical RAM map:
[Wed Feb 19 09:05:46 2020] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[Wed Feb 19 09:05:46 2020] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[Wed Feb 19 09:05:46 2020] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[Wed Feb 19 09:05:46 2020] BIOS-e820: [mem 0x0000000000100000-0x000000000ffeffff] usable
[Wed Feb 19 09:05:46 2020] BIOS-e820: [mem 0x000000000fff0000-0x000000000fffffff] ACPI data
[Wed Feb 19 09:05:46 2020] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[Wed Feb 19 09:05:46 2020] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[Wed Feb 19 09:05:46 2020] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[Wed Feb 19 09:05:46 2020] NX (Execute Disable) protection: active
[Wed Feb 19 09:05:46 2020] SMBIOS 2.5 present.
[Wed Feb 19 09:05:46 2020] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[Wed Feb 19 09:05:46 2020] Hypervisor detected: KVM
[Wed Feb 19 09:05:46 2020] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[Wed Feb 19 09:05:46 2020] e820: remove [mem 0x000a0000-0x000fffff] usable
[Wed Feb 19 09:05:46 2020] e820: last_pfn = 0xfff0 max_arch_pfn = 0x400000000
[Wed Feb 19 09:05:46 2020] MTRR default type: uncachable
[Wed Feb 19 09:05:46 2020] MTRR variable ranges disabled:
[Wed Feb 19 09:05:46 2020] PAT configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- UC  
[Wed Feb 19 09:05:46 2020] CPU MTRRs all blank - virtualized system.
[Wed Feb 19 09:05:46 2020] found SMP MP-table at [mem 0x0009fff0-0x0009ffff] mapped at [ffffffffff200ff0]
[Wed Feb 19 09:05:46 2020] Base memory trampoline at [ffff8cc380099000] 99000 size 24576
[Wed Feb 19 09:05:46 2020] BRK [0x08a2e000, 0x08a2efff] PGTABLE
[Wed Feb 19 09:05:46 2020] BRK [0x08a2f000, 0x08a2ffff] PGTABLE
[Wed Feb 19 09:05:46 2020] BRK [0x08a30000, 0x08a30fff] PGTABLE
[Wed Feb 19 09:05:46 2020] BRK [0x08a31000, 0x08a31fff] PGTABLE
[Wed Feb 19 09:05:46 2020] BRK [0x08a32000, 0x08a32fff] PGTABLE
[Wed Feb 19 09:05:46 2020] RAMDISK: [mem 0x0e21e000-0x0f1dbfff]
[Wed Feb 19 09:05:46 2020] Early table checksum verification disabled
[Wed Feb 19 09:05:46 2020] ACPI: RSDP 00000000000e0000 00024 (v02 VBOX  )
[Wed Feb 19 09:05:46 2020] ACPI: XSDT 000000000fff0030 0003C (v01 VBOX   VBOXXSDT 00000001 ASL  00000061)
[Wed Feb 19 09:05:46 2020] ACPI: FACP 000000000fff00f0 000F4 (v04 VBOX   VBOXFACP 00000001 ASL  00000061)
[Wed Feb 19 09:05:46 2020] ACPI: DSDT 000000000fff0470 022EA (v02 VBOX   VBOXBIOS 00000002 INTL 20190509)
[Wed Feb 19 09:05:46 2020] ACPI: FACS 000000000fff0200 00040
[Wed Feb 19 09:05:46 2020] ACPI: APIC 000000000fff0240 00054 (v02 VBOX   VBOXAPIC 00000001 ASL  00000061)
[Wed Feb 19 09:05:46 2020] ACPI: SSDT 000000000fff02a0 001CC (v01 VBOX   VBOXCPUT 00000002 INTL 20190509)
[Wed Feb 19 09:05:46 2020] ACPI: Local APIC address 0xfee00000
[Wed Feb 19 09:05:46 2020] No NUMA configuration found
[Wed Feb 19 09:05:46 2020] Faking a node at [mem 0x0000000000000000-0x000000000ffeffff]
[Wed Feb 19 09:05:46 2020] NODE_DATA(0) allocated [mem 0x0ffc9000-0x0ffeffff]
[Wed Feb 19 09:05:46 2020] crashkernel=auto resulted in zero bytes of reserved memory.
[Wed Feb 19 09:05:46 2020] kvm-clock: Using msrs 4b564d01 and 4b564d00
[Wed Feb 19 09:05:46 2020] kvm-clock: cpu 0, msr 0:ff79001, primary cpu clock
[Wed Feb 19 09:05:46 2020] kvm-clock: using sched offset of 8834457646 cycles
[Wed Feb 19 09:05:46 2020] Zone ranges:
[Wed Feb 19 09:05:46 2020]   DMA      [mem 0x00001000-0x00ffffff]
[Wed Feb 19 09:05:46 2020]   DMA32    [mem 0x01000000-0xffffffff]
[Wed Feb 19 09:05:46 2020]   Normal   empty
[Wed Feb 19 09:05:46 2020] Movable zone start for each node
[Wed Feb 19 09:05:46 2020] Early memory node ranges
[Wed Feb 19 09:05:46 2020]   node   0: [mem 0x00001000-0x0009efff]
[Wed Feb 19 09:05:46 2020]   node   0: [mem 0x00100000-0x0ffeffff]
[Wed Feb 19 09:05:46 2020] Initmem setup node 0 [mem 0x00001000-0x0ffeffff]
[Wed Feb 19 09:05:46 2020] On node 0 totalpages: 65422
[Wed Feb 19 09:05:46 2020]   DMA zone: 64 pages used for memmap
[Wed Feb 19 09:05:46 2020]   DMA zone: 21 pages reserved
[Wed Feb 19 09:05:46 2020]   DMA zone: 3998 pages, LIFO batch:0
[Wed Feb 19 09:05:46 2020]   DMA32 zone: 960 pages used for memmap
[Wed Feb 19 09:05:46 2020]   DMA32 zone: 61424 pages, LIFO batch:15
[Wed Feb 19 09:05:46 2020] ACPI: PM-Timer IO Port: 0x4008
[Wed Feb 19 09:05:46 2020] ACPI: Local APIC address 0xfee00000
[Wed Feb 19 09:05:46 2020] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[Wed Feb 19 09:05:46 2020] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[Wed Feb 19 09:05:46 2020] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[Wed Feb 19 09:05:46 2020] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[Wed Feb 19 09:05:46 2020] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[Wed Feb 19 09:05:46 2020] ACPI: IRQ0 used by override.
[Wed Feb 19 09:05:46 2020] ACPI: IRQ9 used by override.
[Wed Feb 19 09:05:46 2020] Using ACPI (MADT) for SMP configuration information
[Wed Feb 19 09:05:46 2020] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[Wed Feb 19 09:05:46 2020] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[Wed Feb 19 09:05:46 2020] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[Wed Feb 19 09:05:46 2020] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[Wed Feb 19 09:05:46 2020] e820: [mem 0x10000000-0xfebfffff] available for PCI devices
[Wed Feb 19 09:05:46 2020] Booting paravirtualized kernel on KVM
[Wed Feb 19 09:05:46 2020] setup_percpu: NR_CPUS:5120 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
[Wed Feb 19 09:05:46 2020] PERCPU: Embedded 35 pages/cpu @ffff8cc38fc00000 s104856 r8192 d30312 u2097152
[Wed Feb 19 09:05:46 2020] pcpu-alloc: s104856 r8192 d30312 u2097152 alloc=1*2097152
[Wed Feb 19 09:05:46 2020] pcpu-alloc: [0] 0 
[Wed Feb 19 09:05:46 2020] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes)
[Wed Feb 19 09:05:46 2020] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 64377
[Wed Feb 19 09:05:46 2020] Policy zone: DMA32
[Wed Feb 19 09:05:46 2020] Kernel command line: BOOT_IMAGE=/vmlinuz-3.10.0-862.2.3.el7.x86_64 root=/dev/mapper/VolGroup00-LogVol00 ro no_timer_check console=tty0 console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 elevator=noop crashkernel=auto rd.lvm.lv=VolGroup00/LogVol00 rd.lvm.lv=VolGroup00/LogVol01 rhgb quiet
[Wed Feb 19 09:05:46 2020] PID hash table entries: 1024 (order: 1, 8192 bytes)
[Wed Feb 19 09:05:46 2020] Memory: 221872k/262080k available (7324k kernel code, 392k absent, 39816k reserved, 6305k data, 1832k init)
[Wed Feb 19 09:05:46 2020] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[Wed Feb 19 09:05:46 2020] x86/pti: Unmapping kernel while in userspace
[Wed Feb 19 09:05:46 2020] Hierarchical RCU implementation.
[Wed Feb 19 09:05:46 2020] 	RCU restricting CPUs from NR_CPUS=5120 to nr_cpu_ids=1.
[Wed Feb 19 09:05:46 2020] NR_IRQS:327936 nr_irqs:256 0
[Wed Feb 19 09:05:46 2020] Console: colour VGA+ 80x25
[Wed Feb 19 09:05:46 2020] console [tty0] enabled
[Wed Feb 19 09:05:46 2020] console [ttyS0] enabled
[Wed Feb 19 09:05:46 2020] allocated 1048576 bytes of page_cgroup
[Wed Feb 19 09:05:46 2020] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[Wed Feb 19 09:05:46 2020] tsc: Detected 2127.172 MHz processor
[Wed Feb 19 09:05:46 2020] Calibrating delay loop (skipped) preset value.. 4254.34 BogoMIPS (lpj=2127172)
[Wed Feb 19 09:05:46 2020] pid_max: default: 32768 minimum: 301
[Wed Feb 19 09:05:46 2020] Security Framework initialized
[Wed Feb 19 09:05:46 2020] SELinux:  Initializing.
[Wed Feb 19 09:05:46 2020] SELinux:  Starting in permissive mode
[Wed Feb 19 09:05:46 2020] Yama: becoming mindful.
[Wed Feb 19 09:05:46 2020] Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
[Wed Feb 19 09:05:46 2020] Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
[Wed Feb 19 09:05:46 2020] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
[Wed Feb 19 09:05:46 2020] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes)
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys memory
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys devices
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys freezer
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys net_cls
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys blkio
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys perf_event
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys hugetlb
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys pids
[Wed Feb 19 09:05:46 2020] Initializing cgroup subsys net_prio
[Wed Feb 19 09:05:46 2020] CPU: Physical Processor ID: 0
[Wed Feb 19 09:05:46 2020] mce: CPU supports 0 MCE banks
[Wed Feb 19 09:05:46 2020] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[Wed Feb 19 09:05:46 2020] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
[Wed Feb 19 09:05:46 2020] tlb_flushall_shift: 6
[Wed Feb 19 09:05:46 2020] FEATURE SPEC_CTRL Not Present
[Wed Feb 19 09:05:46 2020] FEATURE IBPB_SUPPORT Not Present
[Wed Feb 19 09:05:46 2020] Spectre V2 : Vulnerable: Retpoline without IBPB
[Wed Feb 19 09:05:46 2020] Freeing SMP alternatives: 24k freed
[Wed Feb 19 09:05:46 2020] ACPI: Core revision 20130517
[Wed Feb 19 09:05:46 2020] ACPI: All ACPI Tables successfully acquired
[Wed Feb 19 09:05:46 2020] ftrace: allocating 28047 entries in 110 pages
[Wed Feb 19 09:05:46 2020] Enabling x2apic
[Wed Feb 19 09:05:46 2020] Enabled x2apic
[Wed Feb 19 09:05:46 2020] Switched APIC routing to physical x2apic.
[Wed Feb 19 09:05:46 2020] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[Wed Feb 19 09:05:46 2020] smpboot: CPU0: Intel(R) Core(TM) i3 CPU       M 330  @ 2.13GHz (fam: 06, model: 25, stepping: 02)
[Wed Feb 19 09:05:46 2020] APIC calibration not consistent with PM-Timer: 174ms instead of 100ms
[Wed Feb 19 09:05:46 2020] APIC delta adjusted to PM-Timer: 6313037 (11008319)
[Wed Feb 19 09:05:46 2020] Performance Events: unsupported p6 CPU model 37 no PMU driver, software events only.
[Wed Feb 19 09:05:46 2020] KVM setup paravirtual spinlock
[Wed Feb 19 09:05:46 2020] Brought up 1 CPUs
[Wed Feb 19 09:05:46 2020] smpboot: Max logical packages: 1
[Wed Feb 19 09:05:46 2020] smpboot: Total of 1 processors activated (4254.34 BogoMIPS)
[Wed Feb 19 09:05:46 2020] devtmpfs: initialized
[Wed Feb 19 09:05:46 2020] EVM: security.selinux
[Wed Feb 19 09:05:46 2020] EVM: security.ima
[Wed Feb 19 09:05:46 2020] EVM: security.capability
[Wed Feb 19 09:05:46 2020] atomic64 test passed for x86-64 platform with CX8 and with SSE
[Wed Feb 19 09:05:46 2020] pinctrl core: initialized pinctrl subsystem
[Wed Feb 19 09:05:46 2020] RTC time:  9:05:46, date: 02/19/20
[Wed Feb 19 09:05:46 2020] NET: Registered protocol family 16
[Wed Feb 19 09:05:46 2020] ACPI: bus type PCI registered
[Wed Feb 19 09:05:46 2020] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[Wed Feb 19 09:05:46 2020] PCI: Using configuration type 1 for base access
[Wed Feb 19 09:05:46 2020] ACPI: Added _OSI(Module Device)
[Wed Feb 19 09:05:46 2020] ACPI: Added _OSI(Processor Device)
[Wed Feb 19 09:05:46 2020] ACPI: Added _OSI(3.0 _SCP Extensions)
[Wed Feb 19 09:05:46 2020] ACPI: Added _OSI(Processor Aggregator Device)
[Wed Feb 19 09:05:46 2020] ACPI: EC: Look up EC in DSDT
[Wed Feb 19 09:05:46 2020] ACPI: Executed 1 blocks of module-level executable AML code
[Wed Feb 19 09:05:46 2020] ACPI: Interpreter enabled
[Wed Feb 19 09:05:46 2020] ACPI: (supports S0 S5)
[Wed Feb 19 09:05:46 2020] ACPI: Using IOAPIC for interrupt routing
[Wed Feb 19 09:05:46 2020] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[Wed Feb 19 09:05:46 2020] ACPI: Enabled 2 GPEs in block 00 to 07
[Wed Feb 19 09:05:46 2020] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[Wed Feb 19 09:05:46 2020] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[Wed Feb 19 09:05:46 2020] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[Wed Feb 19 09:05:46 2020] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[Wed Feb 19 09:05:46 2020] PCI host bridge to bus 0000:00
[Wed Feb 19 09:05:46 2020] pci_bus 0000:00: root bus resource [bus 00-ff]
[Wed Feb 19 09:05:46 2020] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[Wed Feb 19 09:05:46 2020] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[Wed Feb 19 09:05:46 2020] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[Wed Feb 19 09:05:46 2020] pci_bus 0000:00: root bus resource [mem 0x10000000-0xfdffffff window]
[Wed Feb 19 09:05:46 2020] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[Wed Feb 19 09:05:46 2020] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[Wed Feb 19 09:05:46 2020] pci 0000:00:01.1: [8086:7111] type 00 class 0x01018a
[Wed Feb 19 09:05:46 2020] pci 0000:00:01.1: reg 0x20: [io  0xd000-0xd00f]
[Wed Feb 19 09:05:46 2020] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[Wed Feb 19 09:05:46 2020] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[Wed Feb 19 09:05:46 2020] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[Wed Feb 19 09:05:46 2020] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[Wed Feb 19 09:05:46 2020] pci 0000:00:02.0: [80ee:beef] type 00 class 0x030000
[Wed Feb 19 09:05:46 2020] pci 0000:00:02.0: reg 0x10: [mem 0xe0000000-0xe0ffffff pref]
[Wed Feb 19 09:05:46 2020] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[Wed Feb 19 09:05:46 2020] pci 0000:00:03.0: reg 0x10: [mem 0xf0000000-0xf001ffff]
[Wed Feb 19 09:05:46 2020] pci 0000:00:03.0: reg 0x18: [io  0xd010-0xd017]
[Wed Feb 19 09:05:46 2020] pci 0000:00:04.0: [80ee:cafe] type 00 class 0x088000
[Wed Feb 19 09:05:46 2020] pci 0000:00:04.0: reg 0x10: [io  0xd020-0xd03f]
[Wed Feb 19 09:05:46 2020] pci 0000:00:04.0: reg 0x14: [mem 0xf0400000-0xf07fffff]
[Wed Feb 19 09:05:46 2020] pci 0000:00:04.0: reg 0x18: [mem 0xf0800000-0xf0803fff pref]
[Wed Feb 19 09:05:46 2020] pci 0000:00:05.0: [8086:2415] type 00 class 0x040100
[Wed Feb 19 09:05:46 2020] pci 0000:00:05.0: reg 0x10: [io  0xd100-0xd1ff]
[Wed Feb 19 09:05:46 2020] pci 0000:00:05.0: reg 0x14: [io  0xd200-0xd23f]
[Wed Feb 19 09:05:46 2020] pci 0000:00:07.0: [8086:7113] type 00 class 0x068000
[Wed Feb 19 09:05:46 2020] pci 0000:00:07.0: quirk: [io  0x4000-0x403f] claimed by PIIX4 ACPI
[Wed Feb 19 09:05:46 2020] pci 0000:00:07.0: quirk: [io  0x4100-0x410f] claimed by PIIX4 SMB
[Wed Feb 19 09:05:46 2020] pci 0000:00:08.0: [8086:100e] type 00 class 0x020000
[Wed Feb 19 09:05:46 2020] pci 0000:00:08.0: reg 0x10: [mem 0xf0820000-0xf083ffff]
[Wed Feb 19 09:05:46 2020] pci 0000:00:08.0: reg 0x18: [io  0xd240-0xd247]
[Wed Feb 19 09:05:46 2020] pci 0000:00:0d.0: [8086:2829] type 00 class 0x010601
[Wed Feb 19 09:05:46 2020] pci 0000:00:0d.0: reg 0x10: [io  0xd248-0xd24f]
[Wed Feb 19 09:05:46 2020] pci 0000:00:0d.0: reg 0x14: [io  0xd250-0xd253]
[Wed Feb 19 09:05:46 2020] pci 0000:00:0d.0: reg 0x18: [io  0xd258-0xd25f]
[Wed Feb 19 09:05:46 2020] pci 0000:00:0d.0: reg 0x1c: [io  0xd260-0xd263]
[Wed Feb 19 09:05:46 2020] pci 0000:00:0d.0: reg 0x20: [io  0xd270-0xd27f]
[Wed Feb 19 09:05:46 2020] pci 0000:00:0d.0: reg 0x24: [mem 0xf0840000-0xf0841fff]
[Wed Feb 19 09:05:46 2020] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 9 10 *11)
[Wed Feb 19 09:05:46 2020] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 9 *10 11)
[Wed Feb 19 09:05:46 2020] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 *9 10 11)
[Wed Feb 19 09:05:46 2020] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 9 10 *11)
[Wed Feb 19 09:05:46 2020] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[Wed Feb 19 09:05:46 2020] vgaarb: loaded
[Wed Feb 19 09:05:46 2020] vgaarb: bridge control possible 0000:00:02.0
[Wed Feb 19 09:05:46 2020] SCSI subsystem initialized
[Wed Feb 19 09:05:46 2020] ACPI: bus type USB registered
[Wed Feb 19 09:05:46 2020] usbcore: registered new interface driver usbfs
[Wed Feb 19 09:05:46 2020] usbcore: registered new interface driver hub
[Wed Feb 19 09:05:46 2020] usbcore: registered new device driver usb
[Wed Feb 19 09:05:46 2020] EDAC MC: Ver: 3.0.0
[Wed Feb 19 09:05:46 2020] PCI: Using ACPI for IRQ routing
[Wed Feb 19 09:05:46 2020] PCI: pci_cache_line_size set to 64 bytes
[Wed Feb 19 09:05:46 2020] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[Wed Feb 19 09:05:46 2020] e820: reserve RAM buffer [mem 0x0fff0000-0x0fffffff]
[Wed Feb 19 09:05:46 2020] NetLabel: Initializing
[Wed Feb 19 09:05:46 2020] NetLabel:  domain hash size = 128
[Wed Feb 19 09:05:46 2020] NetLabel:  protocols = UNLABELED CIPSOv4
[Wed Feb 19 09:05:46 2020] NetLabel:  unlabeled traffic allowed by default
[Wed Feb 19 09:05:46 2020] amd_nb: Cannot enumerate AMD northbridges
[Wed Feb 19 09:05:46 2020] Switched to clocksource kvm-clock
[Wed Feb 19 09:05:46 2020] pnp: PnP ACPI init
[Wed Feb 19 09:05:46 2020] ACPI: bus type PNP registered
[Wed Feb 19 09:05:46 2020] pnp 00:00: Plug and Play ACPI device, IDs PNP0303 (active)
[Wed Feb 19 09:05:46 2020] pnp 00:01: Plug and Play ACPI device, IDs PNP0f03 (active)
[Wed Feb 19 09:05:46 2020] pnp: PnP ACPI: found 2 devices
[Wed Feb 19 09:05:46 2020] ACPI: bus type PNP unregistered
[Wed Feb 19 09:05:46 2020] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[Wed Feb 19 09:05:46 2020] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[Wed Feb 19 09:05:46 2020] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[Wed Feb 19 09:05:46 2020] pci_bus 0000:00: resource 7 [mem 0x10000000-0xfdffffff window]
[Wed Feb 19 09:05:46 2020] NET: Registered protocol family 2
[Wed Feb 19 09:05:46 2020] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[Wed Feb 19 09:05:46 2020] TCP bind hash table entries: 2048 (order: 3, 32768 bytes)
[Wed Feb 19 09:05:46 2020] TCP: Hash tables configured (established 2048 bind 2048)
[Wed Feb 19 09:05:46 2020] TCP: reno registered
[Wed Feb 19 09:05:46 2020] UDP hash table entries: 256 (order: 1, 8192 bytes)
[Wed Feb 19 09:05:46 2020] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[Wed Feb 19 09:05:46 2020] NET: Registered protocol family 1
[Wed Feb 19 09:05:46 2020] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[Wed Feb 19 09:05:46 2020] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[Wed Feb 19 09:05:46 2020] pci 0000:00:02.0: Boot video device
[Wed Feb 19 09:05:46 2020] PCI: CLS 0 bytes, default 64
[Wed Feb 19 09:05:46 2020] Unpacking initramfs...
[Wed Feb 19 09:05:46 2020] Freeing initrd memory: 16120k freed
[Wed Feb 19 09:05:46 2020] platform rtc_cmos: registered platform RTC device (no PNP device found)
[Wed Feb 19 09:05:46 2020] sha1_ssse3: Using SSSE3 optimized SHA-1 implementation
[Wed Feb 19 09:05:46 2020] sha256_ssse3: Using SSSE3 optimized SHA-256 implementation
[Wed Feb 19 09:05:46 2020] futex hash table entries: 256 (order: 2, 16384 bytes)
[Wed Feb 19 09:05:46 2020] Initialise system trusted keyring
[Wed Feb 19 09:05:46 2020] audit: initializing netlink socket (disabled)
[Wed Feb 19 09:05:46 2020] type=2000 audit(1582103156.507:1): initialized
[Wed Feb 19 09:05:46 2020] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[Wed Feb 19 09:05:46 2020] zpool: loaded
[Wed Feb 19 09:05:46 2020] zbud: loaded
[Wed Feb 19 09:05:46 2020] VFS: Disk quotas dquot_6.5.2
[Wed Feb 19 09:05:46 2020] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[Wed Feb 19 09:05:46 2020] msgmni has been set to 464
[Wed Feb 19 09:05:46 2020] Key type big_key registered
[Wed Feb 19 09:05:46 2020] SELinux:  Registering netfilter hooks
[Wed Feb 19 09:05:46 2020] NET: Registered protocol family 38
[Wed Feb 19 09:05:46 2020] Key type asymmetric registered
[Wed Feb 19 09:05:46 2020] Asymmetric key parser 'x509' registered
[Wed Feb 19 09:05:46 2020] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[Wed Feb 19 09:05:46 2020] io scheduler noop registered (default)
[Wed Feb 19 09:05:46 2020] io scheduler deadline registered
[Wed Feb 19 09:05:46 2020] io scheduler cfq registered
[Wed Feb 19 09:05:46 2020] io scheduler mq-deadline registered
[Wed Feb 19 09:05:46 2020] io scheduler kyber registered
[Wed Feb 19 09:05:46 2020] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[Wed Feb 19 09:05:46 2020] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[Wed Feb 19 09:05:46 2020] ACPI: AC Adapter [AC] (on-line)
[Wed Feb 19 09:05:46 2020] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[Wed Feb 19 09:05:46 2020] ACPI: Power Button [PWRF]
[Wed Feb 19 09:05:46 2020] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[Wed Feb 19 09:05:46 2020] ACPI: Sleep Button [SLPF]
[Wed Feb 19 09:05:46 2020] ACPI: Battery Slot [BAT0] (battery present)
[Wed Feb 19 09:05:46 2020] GHES: HEST is not enabled!
[Wed Feb 19 09:05:46 2020] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[Wed Feb 19 09:05:46 2020] Non-volatile memory driver v1.3
[Wed Feb 19 09:05:46 2020] Linux agpgart interface v0.103
[Wed Feb 19 09:05:46 2020] crash memory driver: version 1.1
[Wed Feb 19 09:05:46 2020] rdac: device handler registered
[Wed Feb 19 09:05:46 2020] hp_sw: device handler registered
[Wed Feb 19 09:05:46 2020] emc: device handler registered
[Wed Feb 19 09:05:46 2020] alua: device handler registered
[Wed Feb 19 09:05:46 2020] libphy: Fixed MDIO Bus: probed
[Wed Feb 19 09:05:46 2020] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[Wed Feb 19 09:05:46 2020] ehci-pci: EHCI PCI platform driver
[Wed Feb 19 09:05:46 2020] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[Wed Feb 19 09:05:46 2020] ohci-pci: OHCI PCI platform driver
[Wed Feb 19 09:05:46 2020] uhci_hcd: USB Universal Host Controller Interface driver
[Wed Feb 19 09:05:46 2020] usbcore: registered new interface driver usbserial
[Wed Feb 19 09:05:46 2020] usbcore: registered new interface driver usbserial_generic
[Wed Feb 19 09:05:46 2020] usbserial: USB Serial support registered for generic
[Wed Feb 19 09:05:46 2020] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[Wed Feb 19 09:05:46 2020] serio: i8042 KBD port at 0x60,0x64 irq 1
[Wed Feb 19 09:05:46 2020] serio: i8042 AUX port at 0x60,0x64 irq 12
[Wed Feb 19 09:05:46 2020] mousedev: PS/2 mouse device common for all mice
[Wed Feb 19 09:05:46 2020] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[Wed Feb 19 09:05:46 2020] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[Wed Feb 19 09:05:46 2020] rtc_cmos rtc_cmos: alarms up to one day, 114 bytes nvram
[Wed Feb 19 09:05:46 2020] cpuidle: using governor menu
[Wed Feb 19 09:05:46 2020] hidraw: raw HID events driver (C) Jiri Kosina
[Wed Feb 19 09:05:46 2020] usbcore: registered new interface driver usbhid
[Wed Feb 19 09:05:46 2020] usbhid: USB HID core driver
[Wed Feb 19 09:05:46 2020] drop_monitor: Initializing network drop monitor service
[Wed Feb 19 09:05:46 2020] TCP: cubic registered
[Wed Feb 19 09:05:46 2020] Initializing XFRM netlink socket
[Wed Feb 19 09:05:46 2020] NET: Registered protocol family 10
[Wed Feb 19 09:05:46 2020] NET: Registered protocol family 17
[Wed Feb 19 09:05:46 2020] mpls_gso: MPLS GSO support
[Wed Feb 19 09:05:46 2020] microcode: CPU0 sig=0x20652, pf=0x4, revision=0x616
[Wed Feb 19 09:05:46 2020] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[Wed Feb 19 09:05:46 2020] PM: Hibernation image not present or could not be loaded.
[Wed Feb 19 09:05:46 2020] Loading compiled-in X.509 certificates
[Wed Feb 19 09:05:46 2020] Loaded X.509 cert 'CentOS Linux kpatch signing key: ea0413152cde1d98ebdca3fe6f0230904c9ef717'
[Wed Feb 19 09:05:46 2020] Loaded X.509 cert 'CentOS Linux Driver update signing key: 7f421ee0ab69461574bb358861dbe77762a4201b'
[Wed Feb 19 09:05:46 2020] Loaded X.509 cert 'CentOS Linux kernel signing key: 666ef031933f5127062372832ce9ba8a49005c8f'
[Wed Feb 19 09:05:46 2020] registered taskstats version 1
[Wed Feb 19 09:05:46 2020] Key type trusted registered
[Wed Feb 19 09:05:46 2020] Key type encrypted registered
[Wed Feb 19 09:05:46 2020] IMA: No TPM chip found, activating TPM-bypass! (rc=-19)
[Wed Feb 19 09:05:46 2020]   Magic number: 8:867:70
[Wed Feb 19 09:05:46 2020]  memory: hash matches
[Wed Feb 19 09:05:46 2020] rtc_cmos rtc_cmos: setting system clock to 2020-02-19 09:05:46 UTC (1582103146)
[Wed Feb 19 09:05:46 2020] Freeing unused kernel memory: 1832k freed
[Wed Feb 19 09:05:46 2020] Write protecting the kernel read-only data: 12288k
[Wed Feb 19 09:05:46 2020] Freeing unused kernel memory: 856k freed
[Wed Feb 19 09:05:46 2020] Freeing unused kernel memory: 684k freed
[Wed Feb 19 09:05:46 2020] random: systemd: uninitialized urandom read (16 bytes read)
[Wed Feb 19 09:05:46 2020] random: systemd: uninitialized urandom read (16 bytes read)
[Wed Feb 19 09:05:46 2020] random: systemd: uninitialized urandom read (16 bytes read)
[Wed Feb 19 09:05:46 2020] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[Wed Feb 19 09:05:46 2020] systemd[1]: Detected virtualization kvm.
[Wed Feb 19 09:05:46 2020] systemd[1]: Detected architecture x86-64.
[Wed Feb 19 09:05:46 2020] systemd[1]: Running in initial RAM disk.
[Wed Feb 19 09:05:46 2020] systemd[1]: Set hostname to <localhost.localdomain>.
[Wed Feb 19 09:05:46 2020] systemd[1]: Initializing machine ID from KVM UUID.
[Wed Feb 19 09:05:46 2020] random: systemd: uninitialized urandom read (16 bytes read)
[Wed Feb 19 09:05:46 2020] random: systemd: uninitialized urandom read (16 bytes read)
[Wed Feb 19 09:05:46 2020] random: systemd: uninitialized urandom read (16 bytes read)
[Wed Feb 19 09:05:46 2020] random: systemd: uninitialized urandom read (16 bytes read)
[Wed Feb 19 09:05:46 2020] random: systemd: uninitialized urandom read (16 bytes read)
[Wed Feb 19 09:05:46 2020] random: systemd: uninitialized urandom read (16 bytes read)
[Wed Feb 19 09:05:46 2020] random: systemd: uninitialized urandom read (16 bytes read)
[Wed Feb 19 09:05:46 2020] systemd[1]: Reached target Timers.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting Timers.
[Wed Feb 19 09:05:46 2020] systemd[1]: Created slice Root Slice.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting Root Slice.
[Wed Feb 19 09:05:46 2020] systemd[1]: Reached target Local File Systems.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting Local File Systems.
[Wed Feb 19 09:05:46 2020] systemd[1]: Listening on Journal Socket.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting Journal Socket.
[Wed Feb 19 09:05:46 2020] systemd[1]: Listening on udev Kernel Socket.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting udev Kernel Socket.
[Wed Feb 19 09:05:46 2020] systemd[1]: Listening on udev Control Socket.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting udev Control Socket.
[Wed Feb 19 09:05:46 2020] systemd[1]: Reached target Sockets.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting Sockets.
[Wed Feb 19 09:05:46 2020] systemd[1]: Created slice System Slice.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting System Slice.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting dracut cmdline hook...
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting Setup Virtual Console...
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting Apply Kernel Variables...
[Wed Feb 19 09:05:46 2020] systemd[1]: Reached target Slices.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting Slices.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting Journal Service...
[Wed Feb 19 09:05:46 2020] systemd[1]: Reached target Swap.
[Wed Feb 19 09:05:46 2020] systemd[1]: Starting Swap.
[Wed Feb 19 09:05:47 2020] systemd[1]: Started Create list of required static device nodes for the current kernel.
[Wed Feb 19 09:05:47 2020] systemd[1]: Starting Create Static Device Nodes in /dev...
[Wed Feb 19 09:05:47 2020] psmouse serio1: alps: Unknown ALPS touchpad: E7=10 00 64, EC=10 00 64
[Wed Feb 19 09:05:47 2020] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[Wed Feb 19 09:05:47 2020] systemd[1]: Started Create Static Device Nodes in /dev.
[Wed Feb 19 09:05:47 2020] systemd[1]: Started Apply Kernel Variables.
[Wed Feb 19 09:05:47 2020] systemd[1]: Started Journal Service.
[Wed Feb 19 09:05:47 2020] device-mapper: uevent: version 1.0.3
[Wed Feb 19 09:05:47 2020] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
[Wed Feb 19 09:05:47 2020] tsc: Refined TSC clocksource calibration: 2127.402 MHz
[Wed Feb 19 09:05:48 2020] libata version 3.00 loaded.
[Wed Feb 19 09:05:48 2020] ata_piix 0000:00:01.1: version 2.13
[Wed Feb 19 09:05:48 2020] scsi host0: ata_piix
[Wed Feb 19 09:05:48 2020] scsi host1: ata_piix
[Wed Feb 19 09:05:48 2020] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 irq 14
[Wed Feb 19 09:05:48 2020] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xd008 irq 15
[Wed Feb 19 09:05:48 2020] ahci 0000:00:0d.0: version 3.0
[Wed Feb 19 09:05:48 2020] ahci 0000:00:0d.0: SSS flag set, parallel bus scan disabled
[Wed Feb 19 09:05:48 2020] ahci 0000:00:0d.0: AHCI 0001.0100 32 slots 30 ports 3 Gbps 0x3fffffff impl SATA mode
[Wed Feb 19 09:05:48 2020] ahci 0000:00:0d.0: flags: 64bit ncq stag only ccc 
[Wed Feb 19 09:05:48 2020] scsi host2: ahci
[Wed Feb 19 09:05:48 2020] scsi host3: ahci
[Wed Feb 19 09:05:48 2020] scsi host4: ahci
[Wed Feb 19 09:05:48 2020] scsi host5: ahci
[Wed Feb 19 09:05:48 2020] scsi host6: ahci
[Wed Feb 19 09:05:48 2020] scsi host7: ahci
[Wed Feb 19 09:05:48 2020] scsi host8: ahci
[Wed Feb 19 09:05:48 2020] scsi host9: ahci
[Wed Feb 19 09:05:48 2020] scsi host10: ahci
[Wed Feb 19 09:05:48 2020] scsi host11: ahci
[Wed Feb 19 09:05:48 2020] scsi host12: ahci
[Wed Feb 19 09:05:48 2020] scsi host13: ahci
[Wed Feb 19 09:05:48 2020] scsi host14: ahci
[Wed Feb 19 09:05:48 2020] scsi host15: ahci
[Wed Feb 19 09:05:48 2020] scsi host16: ahci
[Wed Feb 19 09:05:48 2020] scsi host17: ahci
[Wed Feb 19 09:05:48 2020] scsi host18: ahci
[Wed Feb 19 09:05:48 2020] scsi host19: ahci
[Wed Feb 19 09:05:48 2020] scsi host20: ahci
[Wed Feb 19 09:05:48 2020] scsi host21: ahci
[Wed Feb 19 09:05:48 2020] scsi host22: ahci
[Wed Feb 19 09:05:48 2020] scsi host23: ahci
[Wed Feb 19 09:05:48 2020] scsi host24: ahci
[Wed Feb 19 09:05:48 2020] scsi host25: ahci
[Wed Feb 19 09:05:48 2020] scsi host26: ahci
[Wed Feb 19 09:05:48 2020] scsi host27: ahci
[Wed Feb 19 09:05:48 2020] scsi host28: ahci
[Wed Feb 19 09:05:48 2020] scsi host29: ahci
[Wed Feb 19 09:05:48 2020] scsi host30: ahci
[Wed Feb 19 09:05:48 2020] scsi host31: ahci
[Wed Feb 19 09:05:48 2020] ata3: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840100 irq 21
[Wed Feb 19 09:05:48 2020] ata4: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840180 irq 21
[Wed Feb 19 09:05:48 2020] ata5: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840200 irq 21
[Wed Feb 19 09:05:48 2020] ata6: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840280 irq 21
[Wed Feb 19 09:05:48 2020] ata7: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840300 irq 21
[Wed Feb 19 09:05:48 2020] ata8: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840380 irq 21
[Wed Feb 19 09:05:48 2020] ata9: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840400 irq 21
[Wed Feb 19 09:05:48 2020] ata10: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840480 irq 21
[Wed Feb 19 09:05:48 2020] ata11: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840500 irq 21
[Wed Feb 19 09:05:48 2020] ata12: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840580 irq 21
[Wed Feb 19 09:05:48 2020] ata13: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840600 irq 21
[Wed Feb 19 09:05:48 2020] ata14: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840680 irq 21
[Wed Feb 19 09:05:48 2020] ata15: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840700 irq 21
[Wed Feb 19 09:05:48 2020] ata16: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840780 irq 21
[Wed Feb 19 09:05:48 2020] ata17: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840800 irq 21
[Wed Feb 19 09:05:48 2020] ata18: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840880 irq 21
[Wed Feb 19 09:05:48 2020] ata19: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840900 irq 21
[Wed Feb 19 09:05:48 2020] ata20: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840980 irq 21
[Wed Feb 19 09:05:48 2020] ata21: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840a00 irq 21
[Wed Feb 19 09:05:48 2020] ata22: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840a80 irq 21
[Wed Feb 19 09:05:48 2020] ata23: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840b00 irq 21
[Wed Feb 19 09:05:48 2020] ata24: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840b80 irq 21
[Wed Feb 19 09:05:48 2020] ata25: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840c00 irq 21
[Wed Feb 19 09:05:48 2020] ata26: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840c80 irq 21
[Wed Feb 19 09:05:48 2020] ata27: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840d00 irq 21
[Wed Feb 19 09:05:48 2020] ata28: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840d80 irq 21
[Wed Feb 19 09:05:48 2020] ata29: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840e00 irq 21
[Wed Feb 19 09:05:48 2020] ata30: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840e80 irq 21
[Wed Feb 19 09:05:48 2020] ata31: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840f00 irq 21
[Wed Feb 19 09:05:48 2020] ata32: SATA max UDMA/133 abar m8192@0xf0840000 port 0xf0840f80 irq 21
[Wed Feb 19 09:05:48 2020] ata1.01: NODEV after polling detection
[Wed Feb 19 09:05:48 2020] ata1.00: ATA-6: VBOX HARDDISK, 1.0, max UDMA/133
[Wed Feb 19 09:05:48 2020] ata1.00: 83886080 sectors, multi 128: LBA 
[Wed Feb 19 09:05:48 2020] ata1.00: configured for UDMA/33
[Wed Feb 19 09:05:48 2020] scsi 0:0:0:0: Direct-Access     ATA      VBOX HARDDISK    1.0  PQ: 0 ANSI: 5
[Wed Feb 19 09:05:48 2020] ata3: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:48 2020] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[Wed Feb 19 09:05:48 2020] ata4.00: ATA-6: VBOX HARDDISK, 1.0, max UDMA/133
[Wed Feb 19 09:05:48 2020] ata4.00: 20971520 sectors, multi 128: LBA48 NCQ (depth 31/32)
[Wed Feb 19 09:05:48 2020] ata4.00: configured for UDMA/133
[Wed Feb 19 09:05:48 2020] scsi 3:0:0:0: Direct-Access     ATA      VBOX HARDDISK    1.0  PQ: 0 ANSI: 5
[Wed Feb 19 09:05:49 2020] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[Wed Feb 19 09:05:49 2020] ata5.00: ATA-6: VBOX HARDDISK, 1.0, max UDMA/133
[Wed Feb 19 09:05:49 2020] ata5.00: 4194304 sectors, multi 128: LBA48 NCQ (depth 31/32)
[Wed Feb 19 09:05:49 2020] ata5.00: configured for UDMA/133
[Wed Feb 19 09:05:49 2020] scsi 4:0:0:0: Direct-Access     ATA      VBOX HARDDISK    1.0  PQ: 0 ANSI: 5
[Wed Feb 19 09:05:49 2020] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[Wed Feb 19 09:05:49 2020] ata6.00: ATA-6: VBOX HARDDISK, 1.0, max UDMA/133
[Wed Feb 19 09:05:49 2020] ata6.00: 2097152 sectors, multi 128: LBA48 NCQ (depth 31/32)
[Wed Feb 19 09:05:49 2020] ata6.00: configured for UDMA/133
[Wed Feb 19 09:05:49 2020] scsi 5:0:0:0: Direct-Access     ATA      VBOX HARDDISK    1.0  PQ: 0 ANSI: 5
[Wed Feb 19 09:05:49 2020] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[Wed Feb 19 09:05:49 2020] ata7.00: ATA-6: VBOX HARDDISK, 1.0, max UDMA/133
[Wed Feb 19 09:05:49 2020] ata7.00: 2097152 sectors, multi 128: LBA48 NCQ (depth 31/32)
[Wed Feb 19 09:05:49 2020] ata7.00: configured for UDMA/133
[Wed Feb 19 09:05:49 2020] scsi 6:0:0:0: Direct-Access     ATA      VBOX HARDDISK    1.0  PQ: 0 ANSI: 5
[Wed Feb 19 09:05:50 2020] ata8: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:50 2020] ata9: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:50 2020] ata10: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:51 2020] ata11: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:51 2020] ata12: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:51 2020] ata13: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:51 2020] ata14: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:52 2020] ata15: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:52 2020] ata16: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:52 2020] ata17: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:53 2020] ata18: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:53 2020] ata19: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:53 2020] ata20: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:54 2020] ata21: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:54 2020] ata22: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:54 2020] ata23: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:55 2020] ata24: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:55 2020] ata25: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:55 2020] ata26: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:55 2020] ata27: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:56 2020] ata28: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:56 2020] ata29: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:56 2020] ata30: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:57 2020] ata31: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:57 2020] ata32: SATA link down (SStatus 0 SControl 300)
[Wed Feb 19 09:05:57 2020] sd 0:0:0:0: [sda] 83886080 512-byte logical blocks: (42.9 GB/40.0 GiB)
[Wed Feb 19 09:05:57 2020] sd 0:0:0:0: [sda] Write Protect is off
[Wed Feb 19 09:05:57 2020] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[Wed Feb 19 09:05:57 2020] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[Wed Feb 19 09:05:57 2020]  sda: sda1 sda2 sda3
[Wed Feb 19 09:05:57 2020] sd 0:0:0:0: [sda] Attached SCSI disk
[Wed Feb 19 09:05:57 2020] sd 3:0:0:0: [sdb] 20971520 512-byte logical blocks: (10.7 GB/10.0 GiB)
[Wed Feb 19 09:05:57 2020] sd 3:0:0:0: [sdb] Write Protect is off
[Wed Feb 19 09:05:57 2020] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[Wed Feb 19 09:05:57 2020] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[Wed Feb 19 09:05:57 2020] sd 4:0:0:0: [sdc] 4194304 512-byte logical blocks: (2.14 GB/2.00 GiB)
[Wed Feb 19 09:05:57 2020] sd 4:0:0:0: [sdc] Write Protect is off
[Wed Feb 19 09:05:57 2020] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[Wed Feb 19 09:05:57 2020] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[Wed Feb 19 09:05:57 2020] sd 4:0:0:0: [sdc] Attached SCSI disk
[Wed Feb 19 09:05:57 2020] sd 3:0:0:0: [sdb] Attached SCSI disk
[Wed Feb 19 09:05:57 2020] sd 5:0:0:0: [sdd] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
[Wed Feb 19 09:05:57 2020] sd 5:0:0:0: [sdd] Write Protect is off
[Wed Feb 19 09:05:57 2020] sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[Wed Feb 19 09:05:57 2020] sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[Wed Feb 19 09:05:57 2020] sd 6:0:0:0: [sde] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
[Wed Feb 19 09:05:57 2020] sd 6:0:0:0: [sde] Write Protect is off
[Wed Feb 19 09:05:57 2020] sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
[Wed Feb 19 09:05:57 2020] sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[Wed Feb 19 09:05:57 2020] sd 6:0:0:0: [sde] Attached SCSI disk
[Wed Feb 19 09:05:57 2020] sd 5:0:0:0: [sdd] Attached SCSI disk
[Wed Feb 19 09:05:57 2020] random: fast init done
[Wed Feb 19 09:05:58 2020] random: crng init done
[Wed Feb 19 09:05:58 2020] SGI XFS with ACLs, security attributes, no debug enabled
[Wed Feb 19 09:05:58 2020] XFS (dm-0): Mounting V5 Filesystem
[Wed Feb 19 09:05:58 2020] XFS (dm-0): Ending clean mount
[Wed Feb 19 09:05:58 2020] systemd-journald[87]: Received SIGTERM from PID 1 (systemd).
[Wed Feb 19 09:05:58 2020] type=1404 audit(1582103158.379:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
[Wed Feb 19 09:05:58 2020] SELinux: 2048 avtab hash slots, 106591 rules.
[Wed Feb 19 09:05:58 2020] SELinux: 2048 avtab hash slots, 106591 rules.
[Wed Feb 19 09:05:58 2020] SELinux:  8 users, 14 roles, 5015 types, 310 bools, 1 sens, 1024 cats
[Wed Feb 19 09:05:58 2020] SELinux:  97 classes, 106591 rules
[Wed Feb 19 09:05:58 2020] SELinux:  Completing initialization.
[Wed Feb 19 09:05:58 2020] SELinux:  Setting up existing superblocks.
[Wed Feb 19 09:05:58 2020] type=1403 audit(1582103158.638:3): policy loaded auid=4294967295 ses=4294967295
[Wed Feb 19 09:05:58 2020] systemd[1]: Successfully loaded SELinux policy in 277.396ms.
[Wed Feb 19 09:05:59 2020] ip_tables: (C) 2000-2006 Netfilter Core Team
[Wed Feb 19 09:05:59 2020] systemd[1]: Inserted module 'ip_tables'
[Wed Feb 19 09:05:59 2020] systemd[1]: Relabelled /dev and /run in 35.181ms.
[Wed Feb 19 09:05:59 2020] systemd-journald[500]: Received request to flush runtime journal from PID 1
[Wed Feb 19 09:06:00 2020] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[Wed Feb 19 09:06:00 2020] input: Video Bus as /devices/LNXSYSTM:00/device:00/PNP0A03:00/LNXVIDEO:00/input/input4
[Wed Feb 19 09:06:01 2020] piix4_smbus 0000:00:07.0: SMBus Host Controller at 0x4100, revision 0
[Wed Feb 19 09:06:01 2020] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[Wed Feb 19 09:06:01 2020] e1000: Copyright (c) 1999-2006 Intel Corporation.
[Wed Feb 19 09:06:01 2020] sd 0:0:0:0: Attached scsi generic sg0 type 0
[Wed Feb 19 09:06:01 2020] sd 3:0:0:0: Attached scsi generic sg1 type 0
[Wed Feb 19 09:06:01 2020] sd 4:0:0:0: Attached scsi generic sg2 type 0
[Wed Feb 19 09:06:01 2020] sd 5:0:0:0: Attached scsi generic sg3 type 0
[Wed Feb 19 09:06:01 2020] sd 6:0:0:0: Attached scsi generic sg4 type 0
[Wed Feb 19 09:06:01 2020] input: PC Speaker as /devices/platform/pcspkr/input/input5
[Wed Feb 19 09:06:01 2020] ppdev: user-space parallel port driver
[Wed Feb 19 09:06:01 2020] XFS (sda2): Mounting V5 Filesystem
[Wed Feb 19 09:06:01 2020] Adding 1572860k swap on /dev/mapper/VolGroup00-LogVol01.  Priority:-1 extents:1 across:1572860k FS
[Wed Feb 19 09:06:02 2020] XFS (sda2): Ending clean mount
[Wed Feb 19 09:06:02 2020] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:c9:c7:04
[Wed Feb 19 09:06:02 2020] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[Wed Feb 19 09:06:02 2020] type=1305 audit(1582103162.342:4): audit_pid=605 old=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:auditd_t:s0 res=1
[Wed Feb 19 09:06:02 2020] RPC: Registered named UNIX socket transport module.
[Wed Feb 19 09:06:02 2020] RPC: Registered udp transport module.
[Wed Feb 19 09:06:02 2020] RPC: Registered tcp transport module.
[Wed Feb 19 09:06:02 2020] RPC: Registered tcp NFSv4.1 backchannel transport module.
[Wed Feb 19 09:06:04 2020] snd_intel8x0 0000:00:05.0: measure - unreliable DMA position..
[Wed Feb 19 09:06:04 2020] snd_intel8x0 0000:00:05.0: measure - unreliable DMA position..
[Wed Feb 19 09:06:05 2020] snd_intel8x0 0000:00:05.0: measure - unreliable DMA position..
[Wed Feb 19 09:06:05 2020] snd_intel8x0 0000:00:05.0: clocking to 48000
[Wed Feb 19 09:06:06 2020] e1000 0000:00:08.0 eth1: (PCI:33MHz:32-bit) 08:00:27:b8:7d:ca
[Wed Feb 19 09:06:06 2020] e1000 0000:00:08.0 eth1: Intel(R) PRO/1000 Network Connection
[Wed Feb 19 09:06:06 2020] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[Wed Feb 19 09:06:06 2020] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[Wed Feb 19 09:06:06 2020] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[Wed Feb 19 09:06:06 2020] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[Wed Feb 19 09:06:08 2020] e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[Wed Feb 19 09:06:08 2020] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[Wed Feb 19 09:11:16 2020] xor: measuring software checksum speed
[Wed Feb 19 09:11:16 2020]    prefetch64-sse: 44552.000 MB/sec
[Wed Feb 19 09:11:16 2020]    generic_sse: 66464.000 MB/sec
[Wed Feb 19 09:11:16 2020] xor: using function: generic_sse (66464.000 MB/sec)
[Wed Feb 19 09:11:16 2020] raid6: sse2x1   gen()  5941 MB/s
[Wed Feb 19 09:11:16 2020] raid6: sse2x2   gen()  7570 MB/s
[Wed Feb 19 09:11:16 2020] raid6: sse2x4   gen()  6890 MB/s
[Wed Feb 19 09:11:16 2020] raid6: using algorithm sse2x2 gen() (7570 MB/s)
[Wed Feb 19 09:11:16 2020] raid6: using ssse3x2 recovery algorithm
[Wed Feb 19 09:11:16 2020] Btrfs loaded, crc32c=crc32c-intel
[Wed Feb 19 09:11:16 2020] BTRFS: device fsid a8383377-ba69-40fe-b6c0-c0c862eed531 devid 1 transid 5 /dev/sdb
[Wed Feb 19 09:11:23 2020] BTRFS: device fsid 38f786d4-c0b5-40eb-977b-d957bbebad5d devid 2 transid 5 /dev/sdd
[Wed Feb 19 09:11:23 2020] BTRFS: device fsid 38f786d4-c0b5-40eb-977b-d957bbebad5d devid 1 transid 5 /dev/sdc
[Wed Feb 19 09:12:45 2020] BTRFS info (device sdb): disk space caching is enabled
[Wed Feb 19 09:12:45 2020] BTRFS info (device sdb): has skinny extents
[Wed Feb 19 09:12:45 2020] BTRFS info (device sdb): flagging fs with big metadata feature
[Wed Feb 19 09:12:45 2020] BTRFS info (device sdb): creating UUID tree
[Wed Feb 19 09:14:14 2020] BTRFS info (device sdb): disk added /dev/sdc
[Wed Feb 19 09:38:11 2020] e1000: eth1 NIC Link is Down
[Wed Feb 19 09:38:13 2020] e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[Wed Feb 19 11:08:04 2020] BTRFS info (device sdc): disk space caching is enabled
[Wed Feb 19 11:08:04 2020] BTRFS info (device sdc): has skinny extents
[Wed Feb 19 11:56:44 2020] BTRFS info (device sdd): disk space caching is enabled
[Wed Feb 19 11:56:44 2020] BTRFS info (device sdd): has skinny extents
[Wed Feb 19 11:56:44 2020] BTRFS info (device sdd): flagging fs with big metadata feature
[Wed Feb 19 11:56:44 2020] BTRFS error (device sdd): failed to read chunk tree: -5
[Wed Feb 19 11:56:44 2020] BTRFS: open_ctree failed
[Wed Feb 19 11:56:57 2020] BTRFS info (device sdd): disk space caching is enabled
[Wed Feb 19 11:56:57 2020] BTRFS info (device sdd): has skinny extents
[Wed Feb 19 11:56:57 2020] BTRFS info (device sdd): flagging fs with big metadata feature
[Wed Feb 19 11:56:57 2020] BTRFS error (device sdd): failed to read chunk tree: -5
[Wed Feb 19 11:56:57 2020] BTRFS: open_ctree failed
]0;root@lvm:/var/opt[root@lvm opt]# exit
exit
]0;vagrant@lvm:~[vagrant@lvm ~]$ btrfsmbtrfskbtrfsfbtrfssbtrfs.btrfs[C[C[C[C[C /dev/sdd
btrfs-progs v4.9.1
See http://btrfs.wiki.kernel.org for more information.

probe of /dev/sdd failed, cannot detect existing filesystem.
ERROR: use the -f option to force overwrite of /dev/sdd
]0;vagrant@lvm:~[vagrant@lvm ~]$ mkfs.btrfs /dev/sdd -f
btrfs-progs v4.9.1
See http://btrfs.wiki.kernel.org for more information.

ERROR: mount check: cannot open /dev/sdd: Permission denied
ERROR: cannot check mount status of /dev/sdd: Permission denied
]0;vagrant@lvm:~[vagrant@lvm ~]$ mkfs.btrfs /dev/sdd -f[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Kmkfs.btrfs /dev/sdd -f[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Ksudo -s 
]0;root@lvm:/home/vagrant[?1034h[root@lvm vagrant]# exitdmesg -T[4Pexit[Kmkfs.br[Ktrfs /dev/sdd
btrfs-progs v4.9.1
See http://btrfs.wiki.kernel.org for more information.

/dev/sdd appears to contain an existing filesystem (btrfs).
ERROR: use the -f option to force overwrite of /dev/sdd
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mkfs.btrfs /dev/sdd[Kmkfs.btrfs /dev/sddexit[Kdmesg -Tmount /dev/sde /mnt/mnt/sdd /dev/sdd[3Pdev/sde /mnt/[K/sde
mount: /dev/sde is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on /dev/sde,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mount /dev/sde /mnt/sde[1P /mnt/sdeb /mnt/sde[C[C[C[C[C[C[C[C[C[K[Kdb
]0;root@lvm:/home/vagrant[root@lvm vagrant]# df -g[Kh
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00   38G  760M   37G   2% /
devtmpfs                         109M     0  109M   0% /dev
tmpfs                            118M     0  118M   0% /dev/shm
tmpfs                            118M  4.5M  114M   4% /run
tmpfs                            118M     0  118M   0% /sys/fs/cgroup
/dev/sda2                       1014M   63M  952M   7% /boot
tmpfs                             24M     0   24M   0% /run/user/1000
/dev/sdb                          12G   17M   10G   1% /var/opt
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /mnt/d[Ksd
sdb/ sdd/ sde/ 
[root@lvm vagrant]# ls -l /mnt/sd
sdb/ sdd/ sde/ 
[root@lvm vagrant]# ls -l /mnt/sdb
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
drwxr-xr-x. 1 root root 0 Feb 19 11:05 [0m[38;5;27mopt[0m
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /mnt/sdb[9Pdf -hmount /dev/sdb /mnt/sdb[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Cdf -h[Kls -l /mnt/sdb[Kls -l /mnt/sdb[9Pdf -h
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00   38G  760M   37G   2% /
devtmpfs                         109M     0  109M   0% /dev
tmpfs                            118M     0  118M   0% /dev/shm
tmpfs                            118M  4.5M  114M   4% /run
tmpfs                            118M     0  118M   0% /sys/fs/cgroup
/dev/sda2                       1014M   63M  952M   7% /boot
tmpfs                             24M     0   24M   0% /run/user/1000
/dev/sdb                          12G   17M   10G   1% /var/opt
]0;root@lvm:/home/vagrant[root@lvm vagrant]# df -hls -l /mnt/sdb[9Pdf -hmount /dev/sdb /mnt/sdbe /mnt/sde[4Pkfs.btrfs /dev/sddount /dev/sde /mnt/sde[1P /mnt/sded /mnt/sde[C[C[C[C[C[C[C[C[C[Kd
mount: wrong fs type, bad option, bad superblock on /dev/sdd,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mount /dev/sdd /mnt/sdd[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Cdf -h[Kls -l /mnt/sdb[9Pdf -hmount /dev/sdb /mnt/sdbe /mnt/sde[4Pkfs.btrfs /dev/sddount /dev/sde /mnt/sdeb /mnt/sdb[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Cdf -h[Kls -l /mnt/sdb[K[K[K[K[K[K[K[K[K[K[K[K[K[K,kdir [K[K[K[K[K[Kmkdir /test/
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mkdir /test/ount /dev/sdd /mnt/sdd[K[K[K[K[K[K[Ktrst[K[K[Kest/
mount: wrong fs type, bad option, bad superblock on /dev/sdd,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mount /dev/sdd /test/[9Pkdir[C[C[C[C[C[C[Count /dev/sdd /mnt/sdd[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Cdf -h[Kls -l /mnt/sdb[9Pdf -hmount /dev/sdb /mnt/sdbe /mnt/sde[4Pkfs.btrfs /dev/sddexit[Kmkfs.btrfs /dev/sdd -f
btrfs-progs v4.9.1
See http://btrfs.wiki.kernel.org for more information.

Label:              (null)
UUID:               a0303891-fac6-4145-9f61-2f76c0fd2f11
Node size:          16384
Sector size:        4096
Filesystem size:    1.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP              51.19MiB
  System:           DUP               8.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1     1.00GiB  /dev/sdd

]0;root@lvm:/home/vagrant[root@lvm vagrant]# mkfs.btrfs /dev/sdd -f[1Pount /dev/sdd /test/
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mount /dev/sdd /test/kfs.btrfs /dev/sdd -f[1P -fc -f
btrfs-progs v4.9.1
See http://btrfs.wiki.kernel.org for more information.

ERROR: /dev/sdc is mounted
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mkfs.btrfs /dev/sdc -f[1P -fe -f
btrfs-progs v4.9.1
See http://btrfs.wiki.kernel.org for more information.

Label:              (null)
UUID:               5f463209-96bb-4164-83eb-281f5825b3b5
Node size:          16384
Sector size:        4096
Filesystem size:    1.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         DUP              51.19MiB
  System:           DUP               8.00MiB
SSD detected:       no
Incompat features:  extref, skinny-metadata
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1     1.00GiB  /dev/sde

]0;root@lvm:/home/vagrant[root@lvm vagrant]# mkfs.btrfs /dev/sde -fc[C[C[C[1Pount /dev/sdd /test/kfs.btrfs /dev/sdc -fe[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[Kumount /test/
]0;root@lvm:/home/vagrant[root@lvm vagrant]# umount /test/mkfs.btrfs /dev/sde -fc[C[C[C[1Pount /dev/sdd /test/[K[K[K[K[Kmnt/sdd
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mount /dev/sdd /mnt/sdd[1P /mnt/sddc /mnt/sdd[C[C[C[C[C[C[C[C[C[Kc
mount: mount point /mnt/sdc does not exist
]0;root@lvm:/home/vagrant[root@lvm vagrant]# mount /dev/sdc /mnt/sdc[1P /mnt/sdce /mnt/sdc[C[C[C[C[C[C[C[Cec[K
]0;root@lvm:/home/vagrant[root@lvm vagrant]# df -h
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00   38G  760M   37G   2% /
devtmpfs                         109M     0  109M   0% /dev
tmpfs                            118M     0  118M   0% /dev/shm
tmpfs                            118M  4.5M  114M   4% /run
tmpfs                            118M     0  118M   0% /sys/fs/cgroup
/dev/sda2                       1014M   63M  952M   7% /boot
tmpfs                             24M     0   24M   0% /run/user/1000
/dev/sdb                          12G   17M   10G   1% /var/opt
/dev/sdd                         1.0G   17M  905M   2% /mnt/sdd
/dev/sde                         1.0G   17M  905M   2% /mnt/sde
]0;root@lvm:/home/vagrant[root@lvm vagrant]# [K[root@lvm vagrant]# [K[root@lvm vagrant]# [K[root@lvm vagrant]# [K[root@lvm vagrant]# touch file{}1}.}.}1}0}0}[C /dev/sdd
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /dev/sdd
brw-rw----. 1 root disk 8, 48 Feb 19 13:53 [0m[48;5;232;38;5;11m/dev/sdd[0m
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /dev/sdd/
ls: cannot access /dev/sdd/: Not a directory
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /dev/sdd/[K/[K[K[K[K[K[K[K[Kmnt/sdd
total 0
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /mnt/sdddev/sdd/[K[13@touch file{1..100}[C[C[C[C[C[C[C[C[C[1P/sdd[1P/sdd[1P/sddm/sddn/sddt/sdd
]0;root@lvm:/home/vagrant[root@lvm vagrant]# touch file{1..100} /mnt/sdd[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[13Pls -l[C[C[C[C[C[C[C[C[C
total 0
]0;root@lvm:/home/vagrant[root@lvm vagrant]# ls -l /mnt/sdda /mnt/sdd
total 16
drwxr-xr-x. 1 root root  0 Feb 19 13:53 [0m[38;5;27m.[0m
drwxr-xr-x. 5 root root 39 Feb 19 11:56 [38;5;27m..[0m
]0;root@lvm:/home/vagrant[root@lvm vagrant]# cd /[K[K[K[Cd /mnr[K\t[K[Kt/sdd
]0;root@lvm:/mnt/sdd[root@lvm sdd]# ll
total 0
]0;root@lvm:/mnt/sdd[root@lvm sdd]# touch file [K{}1}.}.}1}0}0}
]0;root@lvm:/mnt/sdd[root@lvm sdd]# ll
total 0
-rw-r--r--. 1 root root 0 Feb 19 13:54 file1
-rw-r--r--. 1 root root 0 Feb 19 13:54 file10
-rw-r--r--. 1 root root 0 Feb 19 13:54 file100
-rw-r--r--. 1 root root 0 Feb 19 13:54 file11
-rw-r--r--. 1 root root 0 Feb 19 13:54 file12
-rw-r--r--. 1 root root 0 Feb 19 13:54 file13
-rw-r--r--. 1 root root 0 Feb 19 13:54 file14
-rw-r--r--. 1 root root 0 Feb 19 13:54 file15
-rw-r--r--. 1 root root 0 Feb 19 13:54 file16
-rw-r--r--. 1 root root 0 Feb 19 13:54 file17
-rw-r--r--. 1 root root 0 Feb 19 13:54 file18
-rw-r--r--. 1 root root 0 Feb 19 13:54 file19
-rw-r--r--. 1 root root 0 Feb 19 13:54 file2
-rw-r--r--. 1 root root 0 Feb 19 13:54 file20
-rw-r--r--. 1 root root 0 Feb 19 13:54 file21
-rw-r--r--. 1 root root 0 Feb 19 13:54 file22
-rw-r--r--. 1 root root 0 Feb 19 13:54 file23
-rw-r--r--. 1 root root 0 Feb 19 13:54 file24
-rw-r--r--. 1 root root 0 Feb 19 13:54 file25
-rw-r--r--. 1 root root 0 Feb 19 13:54 file26
-rw-r--r--. 1 root root 0 Feb 19 13:54 file27
-rw-r--r--. 1 root root 0 Feb 19 13:54 file28
-rw-r--r--. 1 root root 0 Feb 19 13:54 file29
-rw-r--r--. 1 root root 0 Feb 19 13:54 file3
-rw-r--r--. 1 root root 0 Feb 19 13:54 file30
-rw-r--r--. 1 root root 0 Feb 19 13:54 file31
-rw-r--r--. 1 root root 0 Feb 19 13:54 file32
-rw-r--r--. 1 root root 0 Feb 19 13:54 file33
-rw-r--r--. 1 root root 0 Feb 19 13:54 file34
-rw-r--r--. 1 root root 0 Feb 19 13:54 file35
-rw-r--r--. 1 root root 0 Feb 19 13:54 file36
-rw-r--r--. 1 root root 0 Feb 19 13:54 file37
-rw-r--r--. 1 root root 0 Feb 19 13:54 file38
-rw-r--r--. 1 root root 0 Feb 19 13:54 file39
-rw-r--r--. 1 root root 0 Feb 19 13:54 file4
-rw-r--r--. 1 root root 0 Feb 19 13:54 file40
-rw-r--r--. 1 root root 0 Feb 19 13:54 file41
-rw-r--r--. 1 root root 0 Feb 19 13:54 file42
-rw-r--r--. 1 root root 0 Feb 19 13:54 file43
-rw-r--r--. 1 root root 0 Feb 19 13:54 file44
-rw-r--r--. 1 root root 0 Feb 19 13:54 file45
-rw-r--r--. 1 root root 0 Feb 19 13:54 file46
-rw-r--r--. 1 root root 0 Feb 19 13:54 file47
-rw-r--r--. 1 root root 0 Feb 19 13:54 file48
-rw-r--r--. 1 root root 0 Feb 19 13:54 file49
-rw-r--r--. 1 root root 0 Feb 19 13:54 file5
-rw-r--r--. 1 root root 0 Feb 19 13:54 file50
-rw-r--r--. 1 root root 0 Feb 19 13:54 file51
-rw-r--r--. 1 root root 0 Feb 19 13:54 file52
-rw-r--r--. 1 root root 0 Feb 19 13:54 file53
-rw-r--r--. 1 root root 0 Feb 19 13:54 file54
-rw-r--r--. 1 root root 0 Feb 19 13:54 file55
-rw-r--r--. 1 root root 0 Feb 19 13:54 file56
-rw-r--r--. 1 root root 0 Feb 19 13:54 file57
-rw-r--r--. 1 root root 0 Feb 19 13:54 file58
-rw-r--r--. 1 root root 0 Feb 19 13:54 file59
-rw-r--r--. 1 root root 0 Feb 19 13:54 file6
-rw-r--r--. 1 root root 0 Feb 19 13:54 file60
-rw-r--r--. 1 root root 0 Feb 19 13:54 file61
-rw-r--r--. 1 root root 0 Feb 19 13:54 file62
-rw-r--r--. 1 root root 0 Feb 19 13:54 file63
-rw-r--r--. 1 root root 0 Feb 19 13:54 file64
-rw-r--r--. 1 root root 0 Feb 19 13:54 file65
-rw-r--r--. 1 root root 0 Feb 19 13:54 file66
-rw-r--r--. 1 root root 0 Feb 19 13:54 file67
-rw-r--r--. 1 root root 0 Feb 19 13:54 file68
-rw-r--r--. 1 root root 0 Feb 19 13:54 file69
-rw-r--r--. 1 root root 0 Feb 19 13:54 file7
-rw-r--r--. 1 root root 0 Feb 19 13:54 file70
-rw-r--r--. 1 root root 0 Feb 19 13:54 file71
-rw-r--r--. 1 root root 0 Feb 19 13:54 file72
-rw-r--r--. 1 root root 0 Feb 19 13:54 file73
-rw-r--r--. 1 root root 0 Feb 19 13:54 file74
-rw-r--r--. 1 root root 0 Feb 19 13:54 file75
-rw-r--r--. 1 root root 0 Feb 19 13:54 file76
-rw-r--r--. 1 root root 0 Feb 19 13:54 file77
-rw-r--r--. 1 root root 0 Feb 19 13:54 file78
-rw-r--r--. 1 root root 0 Feb 19 13:54 file79
-rw-r--r--. 1 root root 0 Feb 19 13:54 file8
-rw-r--r--. 1 root root 0 Feb 19 13:54 file80
-rw-r--r--. 1 root root 0 Feb 19 13:54 file81
-rw-r--r--. 1 root root 0 Feb 19 13:54 file82
-rw-r--r--. 1 root root 0 Feb 19 13:54 file83
-rw-r--r--. 1 root root 0 Feb 19 13:54 file84
-rw-r--r--. 1 root root 0 Feb 19 13:54 file85
-rw-r--r--. 1 root root 0 Feb 19 13:54 file86
-rw-r--r--. 1 root root 0 Feb 19 13:54 file87
-rw-r--r--. 1 root root 0 Feb 19 13:54 file88
-rw-r--r--. 1 root root 0 Feb 19 13:54 file89
-rw-r--r--. 1 root root 0 Feb 19 13:54 file9
-rw-r--r--. 1 root root 0 Feb 19 13:54 file90
-rw-r--r--. 1 root root 0 Feb 19 13:54 file91
-rw-r--r--. 1 root root 0 Feb 19 13:54 file92
-rw-r--r--. 1 root root 0 Feb 19 13:54 file93
-rw-r--r--. 1 root root 0 Feb 19 13:54 file94
-rw-r--r--. 1 root root 0 Feb 19 13:54 file95
-rw-r--r--. 1 root root 0 Feb 19 13:54 file96
-rw-r--r--. 1 root root 0 Feb 19 13:54 file97
-rw-r--r--. 1 root root 0 Feb 19 13:54 file98
-rw-r--r--. 1 root root 0 Feb 19 13:54 file99
]0;root@lvm:/mnt/sdd[root@lvm sdd]# exit
exit
]0;vagrant@lvm:~[vagrant@lvm ~]$ ^C
]0;vagrant@lvm:~[vagrant@lvm ~]$ btrfs subvolume snapshot /source /destination[C[C[C[C[C[C[1P[1P[1P[1P[1P[1P[1P[1P[1P[1P[C[C[C[C[C[C[C[C[C[C[C[1P[1P[1P[1P[1P[1P /destinationd /destinatione /destinationv /destination/ /destinations /destinationd /destinationd /destination[C[C[1Pestination[1Pstination[1Ptination[1Pination[1Pnation[1Pation[1Ption[1Pion[1Pon[1Pn[Kdev/sdc[Ke
btrfs: unknown token 'snapshot'
usage: btrfs [--help] [--version] <group> [<group>...] <command> [<args>]

    btrfs subvolume create [-i <qgroupid>] [<dest>/]<name>
        Create a subvolume
    btrfs subvolume delete [options] <subvolume> [<subvolume>...]
        Delete subvolume(s)
    btrfs subvolume list [options] [-G [+|-]value] [-C [+|-]value] [--sort=gen,ogen,rootid,path] <path>
        List subvolumes (and snapshots)
    btrfs subvolume snapshot [-r] [-i <qgroupid>] <source> <dest>|[<dest>/]<name>
        Create a snapshot of the subvolume
    btrfs subvolume get-default <path>
        Get the default subvolume of a filesystem
    btrfs subvolume set-default <subvolid> <path>
        Set the default subvolume of a filesystem
    btrfs subvolume find-new <path> <lastgen>
        List the recently modified files in a filesystem
    btrfs subvolume show <subvol-path>
        Show more information of the subvolume
    btrfs subvolume sync <path> [<subvol-id>...]
        Wait until given subvolume(s) are completely removed from the filesystem.

    btrfs filesystem df [options] <path>
        Show space usage information for a mount point
    btrfs filesystem du [options] <path> [<path>..]
        Summarize disk usage of each file.
    btrfs filesystem show [options] [<path>|<uuid>|<device>|label]
        Show the structure of a filesystem
    btrfs filesystem sync <path>
        Force a sync on a filesystem
    btrfs filesystem defragment [options] <file>|<dir> [<file>|<dir>...]
        Defragment a file or a directory
    btrfs filesystem resize [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>
        Resize a filesystem
    btrfs filesystem label [<device>|<mount_point>] [<newlabel>]
        Get or change the label of a filesystem
    btrfs filesystem usage [options] <path> [<path>..]
        Show detailed information about internal filesystem usage .

    btrfs balance start [options] <path>
        Balance chunks across the devices
    btrfs balance pause <path>
        Pause running balance
    btrfs balance cancel <path>
        Cancel running or paused balance
    btrfs balance resume <path>
        Resume interrupted balance
    btrfs balance status [-v] <path>
        Show status of running or paused balance

    btrfs device add [options] <device> [<device>...] <path>
        Add a device to a filesystem
    btrfs device delete <device>|<devid> [<device>|<devid>...] <path>
    btrfs device remove <device>|<devid> [<device>|<devid>...] <path>
        Remove a device from a filesystem
    btrfs device scan [(-d|--all-devices)|<device> [<device>...]]
        Scan devices for a btrfs filesystem
    btrfs device ready <device>
        Check device to see if it has all of its devices in cache for mounting
    btrfs device stats [options] <path>|<device>
        Show device IO error statistics
    btrfs device usage [options] <path> [<path>..]
        Show detailed information about internal allocations in devices.

    btrfs scrub start [-BdqrRf] [-c ioprio_class -n ioprio_classdata] <path>|<device>
        Start a new scrub. If a scrub is already running, the new one fails.
    btrfs scrub cancel <path>|<device>
        Cancel a running scrub
    btrfs scrub resume [-BdqrR] [-c ioprio_class -n ioprio_classdata] <path>|<device>
        Resume previously canceled or interrupted scrub
    btrfs scrub status [-dR] <path>|<device>
        Show status of running or finished scrub

    btrfs check [options] <device>
        Check structural integrity of a filesystem (unmounted).

    btrfs rescue chunk-recover [options] <device>
        Recover the chunk tree by scanning the devices one by one.
    btrfs rescue super-recover [options] <device>
        Recover bad superblocks from good copies
    btrfs rescue zero-log <device>
        Clear the tree log. Usable if it's corrupted and prevents mount.

    btrfs restore [options] <device> <path> | -l <device>
        Try to restore files from a damaged filesystem (unmounted)

    btrfs inspect-internal inode-resolve [-v] <inode> <path>
        Get file system paths for the given inode
    btrfs inspect-internal logical-resolve [-Pv] [-s bufsize] <logical> <path>
        Get file system paths for the given logical address
    btrfs inspect-internal subvolid-resolve <subvolid> <path>
        Get file system paths for the given subvolume ID.
    btrfs inspect-internal rootid <path>
        Get tree ID of the containing subvolume of path.
    btrfs inspect-internal min-dev-size [options] <path>
        Get the minimum size the device can be shrunk to. The
    btrfs inspect-internal dump-tree [options] device
        Dump tree structures from a given device
    btrfs inspect-internal dump-super [options] device [device...]
        Dump superblock from a device in a textual form
    btrfs inspect-internal tree-stats [options] <device>
        Print various stats for trees

    btrfs property get [-t <type>] <object> [<name>]
        Gets a property from a btrfs object.
    btrfs property set [-t <type>] <object> <name> <value>
        Sets a property on a btrfs object.
    btrfs property list [-t <type>] <object>
        Lists available properties with their descriptions for the given object.

    btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]
        Send the subvolume(s) to stdout.
    btrfs receive [options] <mount>
btrfs receive --dump [options]
        Receive subvolumes from a stream

    btrfs quota enable <path>
        Enable subvolume quota support for a filesystem.
    btrfs quota disable <path>
        Disable subvolume quota support for a filesystem.
    btrfs quota rescan [-sw] <path>
        Trash all qgroup numbers and scan the metadata again with the current config.

    btrfs qgroup assign [options] <src> <dst> <path>
        Assign SRC as the child qgroup of DST
    btrfs qgroup remove <src> <dst> <path>
        Remove a child qgroup SRC from DST.
    btrfs qgroup create <qgroupid> <path>
        Create a subvolume quota group.
    btrfs qgroup destroy <qgroupid> <path>
        Destroy a quota group.
    btrfs qgroup show [options] <path>
        Show subvolume quota groups.
    btrfs qgroup limit [options] <size>|none [<qgroupid>] <path>
        Set the limits a subvolume quota group.

    btrfs replace start [-Bfr] <srcdev>|<devid> <targetdev> <mount_point>
        Replace device of a btrfs filesystem.
    btrfs replace status [-1] <mount_point>
        Print status and progress information of a running device replace
    btrfs replace cancel <mount_point>
        Cancel a running device replace operation.

    btrfs help [--full]
        Display help information
    btrfs version
        Display btrfs-progs version

Use --help as an argument for information on a specific group or command.
]0;vagrant@lvm:~[vagrant@lvm ~]$ btrfs snapshot /dev/sdd /dev/sde[C[1@s[1@u[1@b[1@v[1@o[1@ [1@l[1@u[1@m[1@e[C[C[C[C
ERROR: not a subvolume: /dev/sdd
]0;vagrant@lvm:~[vagrant@lvm ~]$ [K[vagrant@lvm ~]$ [K[vagrant@lvm ~]$ htop
-bash: htop: command not found
]0;vagrant@lvm:~[vagrant@lvm ~]$ exi
-bash: exi: command not found
]0;vagrant@lvm:~[vagrant@lvm ~]$ exit
logout
Connection to 127.0.0.1 closed.
]0;root@pengwinn-home: /home/pengwinn/Project/otus-linux/stands-03-lvmroot@pengwinn-home:/home/pengwinn/Project/otus-linux/stands-03-lvm# exit
exit

Script done on 2020-02-19 17:09:10+02:00 [COMMAND_EXIT_CODE="127"]
```
