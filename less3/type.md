[root@lvm vagrant]# mount /dev/sde /mnt/sde
[root@lvm vagrant]# mount /dev/sdd /mnt/sdd


[root@lvm vagrant]# btrfs subvolume create /mnt/sdd/subv_1
[root@lvm vagrant]# btrfs subvolume create /mnt/sdd/subv_2
    Create subvolume '/mnt/sdd/subv_1'
    Create subvolume '/mnt/sdd/subv_2'

[root@lvm vagrant]# btrfs subvolume create /mnt/sde/subv_2
    Create subvolume '/mnt/sde/subv_2'

[root@lvm vagrant]# btrfs subvolume list /mnt/sdd
ID 256 gen 11 top level 5 path subv_1
ID 257 gen 12 top level 5 path subv_2

[root@lvm vagrant]# btrfs subvolume list /mnt/sde
ID 256 gen 8 top level 5 path subv_2
ID 257 gen 9 top level 5 path subv_1

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

[root@lvm vagrant]# btrfs subvolume snapshot /mnt/sdd/subv_1 /mnt/sdd/subv_2
Create a snapshot of '/mnt/sdd/subv_1' in '/mnt/sdd/subv_2/subv_1'

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

[root@lvm /]# rm -rf /mnt/sdd/subv_1/file{1..5} 
ls -l /mnt/sdd/subv_1
total 0
-rw-r--r--. 1 root root 0 Feb 20 07:53 file6
-rw-r--r--. 1 root root 0 Feb 20 07:53 file7
-rw-r--r--. 1 root root 0 Feb 20 07:53 file8
-rw-r--r--. 1 root root 0 Feb 20 07:53 file9
-rw-r--r--. 1 root root 0 Feb 20 07:53 file10

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