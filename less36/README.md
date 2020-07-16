# Otus linux hometask
## less36 
### NFS

__Запуск стенда:__

```vagrant up```

__Проверка:__

__Входин на client__

```
    vagrant ssh client
```

__Монтируем шару__

```
    [root@client vagrant]# mount -t nfs
    server:/stor on /share type nfs (rw,relatime,vers=3,rsize=65536,wsize=65536,namlen=255,hard,proto=tcp,timeo=14,retrans=2,sec=sys,mountaddr=192.168.10.150,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=192.168.10.150)

    [root@client vagrant]# showmount -e server
    Export list for server:
    /stor client
```

__Создаем файл в смонтированой директории__

```
    [root@client vagrant]# echo 'nfs_share' > /share/upload/test.txt

    [root@client vagrant]# cat /share/upload/test.txt 
    nfs_share
```

__Входим на сервер и проверяем наличие созданного на шаре файла__

```
    vagrant ssh server
    [root@server vagrant]# cat /stor/upload/test.txt 
    nfs_share
```

__Состояние firewalld__

```
    [root@server vagrant]# firewall-cmd --state
    running

    [root@server vagrant]# firewall-cmd --list-all
    public (active)
    target: default
    icmp-block-inversion: no
    interfaces: eth0 eth1
      sources: 
      services: ssh dhcpv6-client nfs mountd rpc-bind
      ports: 
      protocols: 
      masquerade: no
      forward-ports: 
      source-ports: 
      icmp-blocks: 
      rich rules: 
```
