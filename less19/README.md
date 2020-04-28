# Otus-linux Hometask
## Less 19
### Network-Architecture

__1Part__

__Теоритичееское задание__

__Расчет подсетей__

__1.1 Office1__

```
192.168.2.0/26 - host.min: 192.168.2.1 host.max: 192.168.2.63 broadcast: 192.168.2.63
192.168.2.64/26 - host.min: 192.168.2.65 host.max: 192.168.2.127 broadcast: 192.168.2.127
192.168.2.128/26 - host.min: 192.168.2.129 host.max: 192.168.2.63 broadcast: 192.168.2.191
192.168.2.192/26 - host.min: 192.168.2.193 host.max: 192.168.2.255 broadcast: 192.168.2.255
```

__1.2 Office2__

```
192.168.1.0/25 - host.min: 192.168.1.1 host.max: 192.168.1.127 broadcast: 192.168.1.127
192.168.1.128/26 - host.min: 192.168.1.129 host.max: 192.168.1.191 broadcast: 192.168.1.191
192.168.1.192/26 - host.min: 192.168.1.193 host.max: 192.168.1.255 broadcast: 192.168.1.255
```

__1.3 Central__

```
192.168.0.0/28 - host.min: 192.168.0.1 host.max: 192.168.0.15 broadcast: 192.168.0.15
_192.168.0.16/28 - host.min: 192.168.0.17 host.max: 192.168.0.31 broadcast: 192.168.0.31_ - FREE
192.168.0.32/28 - host.min: 192.168.0.33 host.max: 192.168.0.47 broadcast: 192.168.0.47
_192.168.0.48/26 - host.min: 192.168.0.49 host.max: 192.168.0.63 broadcast: 192.168.0.63_ - FREE
192.168.0.64/26 - host.min: 192.168.0.65 host.max: 192.168.0.127 broadcast: 192.168.0.127
_192.168.0.128/25 - host.min: 192.168.0.129 host.max: 192.168.0.255 broadcast: 192.168.0.255_ - FREE
```

__Построение сети__

__В тестируемой сети присутствуют 4 роутера, 3 сервера.__

__Configs__

__ROUTERS__

__inetRouter__

```
eth0 -> to inet
eth1 -> 1.1.1.1/30
```

__centralRouter__

```
eth1 -> 1.1.1.2/30 - link to inetRouter
eth2 -> 192.168.0.1/28
eth3 -> 192.168.0.33/28
eth4 -> 192.168.0.65/26
```

__office1Router__

```
eth1 -> 192.168.0.35/28 - link to centralRouter
eth2 -> 192.168.2.1/26
eth3 -> 192.168.2.65/26
eth4 -> 192.168.2.128/26
eth5 -> 192.168.2.192/26
```

__office2Router__

```
eth1 -> 192.168.0.36/28 - link to centralRouter
eth2 -> 192.168.1.1/25
eth3 -> 192.168.1.129/25
eth4 -> 192.168.2.193/26
```

__SERVERS__

__centralServer__

```
eth1 -> 192.168.0.40/28 - link to centralRouter
```

__of1Server__

```
eth1 -> 192.168.2.66/26 - link to office1Router
```

__of2Server__

```
eth1 -> 192.168.1.129/26 - link to office2Router
```

__Тестирование сети__

__План проерки__

__From office1Server (192.168.2.66)__

```
    vagrant ssh of1Server
```
```
of1Server -> of2Server ping 192.168.2.66
of1Server -> centralServer ping 192.168.0.40
of1Server -> office1Router ping (192.168.2.65 or 192.168.0.35)
of1Server -> office2Router ping (192.168.1.129 or 192.168.0.36)
of1Server -> centralRouter ping (192.168.0.33 or 1.1.1.2)
of1Server -> inetRouter ping 1.1.1.1
of1Server -> google ping 8.8.8.8
```

__Для проверки работоспособности сети этого достаточно. дополнительно при желании можно проверить с других хостов__