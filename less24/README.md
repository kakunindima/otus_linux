# Otus-Linux hometask
## Less 24
### VPN

__Дз состоит из 2х частей:__

__Часть1:__

__Тестирование vpn в режимах tun/tap__

__режим tun__

__[Ссылка на конфиги](https://github.com/kakunindima/otus_linux/tree/master/less24/tun)__

__Тестирование скорости канала при помощи iperf3__

__![Результат](https://github.com/kakunindima/otus_linux/blob/master/less24/tun/tun.png)__

__режим tap__

__[Ссылка на конфиги](https://github.com/kakunindima/otus_linux/tree/master/less24/tap)__

__Тестирование скорости канала при помощи iperf3__

__![Результат](https://github.com/kakunindima/otus_linux/blob/master/less24/tap/tap.png)__

__Как результат видим что для UDP протокола скорость передачи выше а потери меньше при режиме tap__

__Режим tap - L3 уровень__

__Режим tun - L2 уровень__

__Часть2:__

__Настройка RAS на базе openvpn__

__Был создан стенд конфигурируемый при помощи Ansible__

__Результат работы:__

__![RAS](https://github.com/kakunindima/otus_linux/blob/master/less24/RAS.png)__

__На скриншот е видим статус сервера и клиента а также таблицы маршрутизации__

__Для проверки необходимо:__

__1.Склонировать [репоиторий](https://github.com/kakunindima/otus_linux.git)__

__2.Перейти в директорию с ДЗ (less24)__

```
    cd otus_linux/less24/
```

__3.Запустить стенд__

```
    vagrant up
```

__4.Залогиниться на сервер r1 просмотреть статус openvpn@server и табл маршрутизации__

```
    systemctl status openvpn@server

    ip ro li

```

__5.Залогиниться на клиент r2 просмотреть статус openvpn@client и табл маршрутизации__


```
    systemctl status openvpn@client

    ip ro li

```

__6.Пропинговать тонель и сервер__

```
    ping 10.10.10.1 - тонель
    ping 192.168.10.1 - сервер
```