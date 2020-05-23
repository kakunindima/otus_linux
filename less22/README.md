# Otus-linux Hometask
## Less 22
### Dynamic routing OSPF
![Иллюстрация к проекту](https://github.com/jon/coolproject/raw/master/image/image.png)
__Часть1__

__Проверка ассимметричного роутинга__

__Все манипуляции проводим с роутера R1__

__Запустим пинг на R3 (10.10.3.1) и смотрим пакеты на интерфейсах__

__Смотрим табл маршрутизации R1__

```
[root@r1 vagrant]# vtysh

Hello, this is Quagga (version 0.99.22.4)
Copyright 1996-2005 Kunihiro Ishiguro, et al.

r1# sh ip os ro

============ OSPF network routing table ============
N    1.1.1.0/24            [30] area: 0.0.0.0
                           via 1.1.3.2, eth3
N    1.1.2.0/24            [20] area: 0.0.0.0
                           via 1.1.3.2, eth3
N    1.1.3.0/24            [10] area: 0.0.0.0
                           directly attached to eth3
N    10.10.1.1/32          [10] area: 0.0.0.0
                           directly attached to lo
N    10.10.2.1/32          [30] area: 0.0.0.0
                           via 1.1.3.2, eth3
N    10.10.3.1/32          [20] area: 0.0.0.0
                           via 1.1.3.2, eth3

============ OSPF router routing table =============

============ OSPF external routing table ===========
```

__Смотрим tcpdump__

```
[root@r1 vagrant]# tcpdump -i eth2 icmp
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth2, link-type EN10MB (Ethernet), capture size 262144 bytes

0 packets captured
0 packets received by filter
0 packets dropped by kernel

[root@r1 vagrant]# tcpdump -i eth3 icmp
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth3, link-type EN10MB (Ethernet), capture size 262144 bytes
18:18:29.814147 IP r1 > 10.10.3.1: ICMP echo request, id 7884, seq 316, length 64
18:18:29.814699 IP 10.10.3.1 > r1: ICMP echo reply, id 7884, seq 316, length 64
18:18:30.816155 IP r1 > 10.10.3.1: ICMP echo request, id 7884, seq 317, length 64
18:18:30.816619 IP 10.10.3.1 > r1: ICMP echo reply, id 7884, seq 317, length 64
18:18:31.817115 IP r1 > 10.10.3.1: ICMP echo request, id 7884, seq 318, length 64
18:18:31.817798 IP 10.10.3.1 > r1: ICMP echo reply, id 7884, seq 318, length 64
18:18:32.818937 IP r1 > 10.10.3.1: ICMP echo request, id 7884, seq 319, length 64
18:18:32.819610 IP 10.10.3.1 > r1: ICMP echo reply, id 7884, seq 319, length 64
18:18:33.820764 IP r1 > 10.10.3.1: ICMP echo request, id 7884, seq 320, length 64
18:18:33.821273 IP 10.10.3.1 > r1: ICMP echo reply, id 7884, seq 320, length 64

10 packets captured
10 packets received by filter
0 packets dropped by kernel
```
__Результат: трафик ходит по маршрутам с наименьшим cost - ассиметричный трафик__

__Часть2__

__Проверка симметричного трафика - отключаем "дешевый" интерфейс__

__Отключаем eth3 (по дефолту у нас на нем cost 10), трафик должен пойти через eth2 (cost 1000)__
```
[root@r1 vagrant]# ip link set eth3 down

[root@r1 vagrant]# tcpdump -i eth2 icmp
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth2, link-type EN10MB (Ethernet), capture size 262144 bytes
18:18:50.846448 IP one.one.one.one > 10.10.3.1: ICMP echo request, id 7884, seq 337, length 64
18:18:50.848047 IP 10.10.3.1 > one.one.one.one: ICMP echo reply, id 7884, seq 337, length 64
18:18:51.847855 IP one.one.one.one > 10.10.3.1: ICMP echo request, id 7884, seq 338, length 64
18:18:51.848939 IP 10.10.3.1 > one.one.one.one: ICMP echo reply, id 7884, seq 338, length 64
18:18:52.849270 IP one.one.one.one > 10.10.3.1: ICMP echo request, id 7884, seq 339, length 64
18:18:52.850187 IP 10.10.3.1 > one.one.one.one: ICMP echo reply, id 7884, seq 339, length 64
18:18:53.850793 IP one.one.one.one > 10.10.3.1: ICMP echo request, id 7884, seq 340, length 64
18:18:53.852124 IP 10.10.3.1 > one.one.one.one: ICMP echo reply, id 7884, seq 340, length 64

8 packets captured
8 packets received by filter
0 packets dropped by kernel
```
__Смотрим табл маршрутизации__

```
[root@r1 vagrant]# vtysh

Hello, this is Quagga (version 0.99.22.4).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

r1# sh ip os ro
============ OSPF network routing table ============
N    1.1.1.0/24            [1000] area: 0.0.0.0
                           directly attached to eth2
N    1.1.2.0/24            [2000] area: 0.0.0.0
                           via 1.1.1.2, eth2
N    1.1.3.0/24            [3000] area: 0.0.0.0
                           via 1.1.1.2, eth2
N    10.10.1.1/32          [10] area: 0.0.0.0
                           directly attached to lo
N    10.10.2.1/32          [1010] area: 0.0.0.0
                           via 1.1.1.2, eth2
N    10.10.3.1/32          [2010] area: 0.0.0.0
                           via 1.1.1.2, eth2

============ OSPF router routing table =============

============ OSPF external routing table ===========
```
__Мы видим что cost маршрутов именились__
```
[root@r1 vagrant]# ping 10.10.3.1
PING 10.10.3.1 (10.10.3.1) 56(84) bytes of data.
64 bytes from 10.10.3.1: icmp_seq=1 ttl=63 time=1.16 ms
64 bytes from 10.10.3.1: icmp_seq=2 ttl=63 time=0.952 ms
64 bytes from 10.10.3.1: icmp_seq=3 ttl=63 time=0.909 ms

[root@r1 vagrant]# ping 10.10.2.1
PING 10.10.2.1 (10.10.2.1) 56(84) bytes of data.
64 bytes from 10.10.2.1: icmp_seq=1 ttl=64 time=0.453 ms
64 bytes from 10.10.2.1: icmp_seq=2 ttl=64 time=0.520 ms
64 bytes from 10.10.2.1: icmp_seq=3 ttl=64 time=0.789 ms

[root@r1 vagrant]# ip ro li
default via 10.0.2.2 dev eth0 proto dhcp metric 100
1.1.1.0/24 dev eth2 proto kernel scope link src 1.1.1.1 metric 102
1.1.2.0/24 via 1.1.1.2 dev eth2 proto zebra metric 2000
1.1.3.0/24 via 1.1.1.2 dev eth2 proto zebra metric 3000
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
10.10.2.1 via 1.1.1.2 dev eth2 proto zebra metric 1010
10.10.3.1 via 1.1.1.2 dev eth2 proto zebra metric 2010
172.16.10.0/24 dev eth1 proto kernel scope link src 172.16.10.10 metric 101
```
__Мы проверили доступность через "дорогой маршрут"__

__Возвращаем все на место и проверяем__
```
[root@r1 vagrant]# ip link set eth3 up ip ro li
[root@r1 vagrant]# ip ro li
default via 10.0.2.2 dev eth0 proto dhcp metric 100
1.1.1.0/24 dev eth2 proto kernel scope link src 1.1.1.1 metric 102
1.1.2.0/24 via 1.1.3.2 dev eth3 proto zebra metric 20
1.1.3.0/24 dev eth3 proto kernel scope link src 1.1.3.1 metric 103
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 metric 100
10.10.2.1 via 1.1.3.2 dev eth3 proto zebra metric 30
10.10.3.1 via 1.1.3.2 dev eth3 proto zebra metric 20
172.16.10.0/24 dev eth1 proto kernel scope link src 172.16.10.10 metric 101
```