# Otus-linux hometask
## Less 20
### Trafic-filtter

__Исходная схема сети:__

```
    centralServer ------ centralRouter ------ inetRouter -> |Inet|
				    |
				     ------ inet2Router
```

__В ДЗ выполнено 2 задания:__

__Часть1 Настройка dnat__

__По заданию необходимо сделать проброс порта 8080 при доступе извне на inet2Router, на centralServer:80 - для отображения страницы nginx__

__данное задание выполнено двойным пробросом через centralRouter, по схеме:__

```
8080:inet2Router -> 8080:centralRouter -> 80:centralServer 
```

__для проверки необходимо:__

__1.зайти по ssh на inet2Router ```vagrant ssh inet2Router```__

__2.выполнить команду ```ip a | grep eth2``` - что выведет нам ip-адресс интерфейса (в настройках vagrant он настроен как host-only в режиме dhcp)__

__3.открыть веб-браузер и перейти по сслыке http://XXX.XXX.XXX.XXX:8080 - где XXX.XXX.XXX.XXX - ip-adress полученый в ходе выполнения пункта 2__

__4. В результате должна отобразиться html страница__


__Часть2 Port knocking__

__Суть задачи: организовать доступ по ssh с centralRouter -> inetRouter при помощи port knocking__

__данная возможность реализована при помощи правил iptables. доступ предоставляется после перебора утилитой netmap последовательности портов - для чего сощдан скрипт.__

__для проверки необходимо:__

__1. зайти по ssh на centralRouter ```vagrant ssh centralRouter```__

__2. перейти в директорию sources/less20/task1/ ```cd /sources/less20/task1/ ```__

__3. выполнить скрипт с параметрами: ./knock.sh $host $port1 $portN, в нашем случае: хост: 1.1.1.1, последовательность портов: 8881 7777 9991__

```./knock.sh 1.1.1.1 8881 7777 9991```

__4. в тесении 30 сек произвести логин по ssh hosh 1.1.1.1, user - test, passwd - 1.__

```ssh test@1.1.1.1 ```

__5.набрав в консоли команду ```hostname```  убеждаемся что подключились на inetRouter__
