# Otus-linux Hometask
## Less25
### Vlan && Bonding

__Общая схема стенда__

![sheme](https://github.com/kakunindima/otus_linux/blob/master/less25/img/less25_vlan.jpg)

__ДЗ представлено в 2х частях__

__1. Настройка/тестирование bonding между роутерами iR - cR__

__для проверки работоспособности резервирования линков интерфейса bond0 выпоняем следующие действия:__

__1.1 Устанавливаем link eth2 -> down на роутерах iR & cR__

__1.2 Проверяем доступность интерфейса при помощи ping__

![sheme](https://github.com/kakunindima/otus_linux/blob/master/less25/img/bond_down.png)

__1.3 Устанавливаем link eth2 -> up на роутерах iR & cR__

__1.4 Прверяем состояние интерфейса__

![sheme](https://github.com/kakunindima/otus_linux/blob/master/less25/img/bond_down.png)

__2. Настройка/тестирование vlan в общей local_N сети__

__Проверяем доступность локальной сети__

![sheme](https://github.com/kakunindima/otus_linux/blob/master/less25/img/local_n.png)

__По условию ДЗ мы должны разнести по отдельным vlan сервера и клиенты с одинаковой адрессацией__

__В локальной ссети сконфигурировано 2 vlan__

__tc1 - vlan10 - ts1__

__tc2 - vlan110 - ts2__

__Прверяем доступность серверов/коиентов внутри каждого из vlan__

__vlan10__

![sheme](https://github.com/kakunindima/otus_linux/blob/master/less25/img/vlan10.png)

__vlan110__

![sheme](https://github.com/kakunindima/otus_linux/blob/master/less25/img/vlan110.png)

__Для проверки ДЗ необходимо склонировать [репозиторий](https://github.com/kakunindima/otus_linux.git)__ 

__Перейти в директорию c дз и запустить стенд__

```
    cd otus_linux/less25
    vagrant up
```