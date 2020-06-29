# Otus-linux hometask
## less33
### Mysql innodb cluster

### ДЗ представлено готовым стендом с развернутым в docker-compose innodb cluster

__Стенд состоит из 5 контейнеров:__

* __mysql-shell__ - консоль mysqlsh для управления кластером
* __mysql-router__ - обеспечивает маршрутизацию соединений к серверам MySQL в кластере для повышения производительности и надежности, при настройке роутера указывается главная нода (Primary instance), чтобы он увидел все существующие ноды в кластере
* __node1__ - 1-я нода кластера (Primary instance, в режиме R/W)
* __node2__ - 2-я нода кластера (Secondary instance, в режиме R/O)
* __node3__ - 3-я нода кластера (Secondary instance, в режиме R/O)

__На всех серверах: логин: root, пароль: mysql__

__Порты для соединений:__

* mysql-router: 6446
* mysql-shell, node1,node2,node3: 3306.
* соединениемежду контейнерами происходит по порту 33060

__Непосредственно конфиги и docker-compose.yml доступен в репозитории по [ссылке](https://github.com/kakunindima/sources/tree/master/less33)__

__Запуск стенда:__

```
    vagrant up

    vagrant ssh
```

_Конфиги клатера и docker-compose располгаются в_ ```/opt/souces/less33/```

_После запуска стенда рекомендую подождать +- 5 минут для окончания развертыванияч кластера_

__Для проверки предлагаю несколько шагов:__

__1. Проверка состояния контейнеров__

```
    docker ps
```
__Результат проверки:__

![img](https://github.com/kakunindima/otus_linux/blob/master/less33/img/status.png)

_Дополнительно можно просмотреть логи_

```
    docker-compose logs
```
__2.Заливаем дамп базы bet на кластер:__

```
    docker exec -i less33_mysql-router_1 mysql -uroot -pmysql -e "CREATE DATABASE bet;"
    docker exec -i less33_mysql-router_1 mysql -uroot -pmysql bet < ./script/bet.dmp
```
__Соединения в кластере будет принимать mysql-router на порту 6446. Роутер будет перенаправлять все запросы на главную ноду, остальные ноды - это реплика. Если главная нода стала недоступной, то в процессе перевыборов назначается новая главная нода.__

__3. Смотрим наличие таблиц на 3х нодах:__

```
    docker exec -i less33_mysql-router_1 mysql -uroot -pmysql -e "USE bet; SHOW TABLES;"
    docker exec -i less33_mysql-router_2 mysql -uroot -pmysql -e "USE bet; SHOW TABLES;"
    docker exec -i less33_mysql-router_3 mysql -uroot -pmysql -e "USE bet; SHOW TABLES;"
```

__Результат:__

![img](https://github.com/kakunindima/otus_linux/blob/master/less33/img/tables_check.png)

__4. Тестируем отказоустойчивоть: стопаем node1__

```
    docker-compose stop node1
```
__Узнаем ip-адрес mysql-router__

```
    docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
```
__Результат__

![img](https://github.com/kakunindima/otus_linux/blob/master/less33/img/n1_down.png)

__Проверяем доступность БД bet, подключившись к mysql-router со стенда и создав новую запись test в таблице bookmaker:__

```
    mysql -h 172.18.0.6 -u root -pmysql -P 6446
    use bet; show tables;
    insert into bookmaker (bookmaker_name) value ('test');
    select * from bookmaker;
```

__Результат:__

![img](https://github.com/kakunindima/otus_linux/blob/master/less33/img/test1.png)

![img](https://github.com/kakunindima/otus_linux/blob/master/less33/img/test2.png)

__Проверяем, что запись test создалась на работающих нодах node2 и node3:__

_node3_

```
    mysql -h 172.18.0.2 -u root -pmysql -P 3306 -e "USE bet; select * from bookmaker;"
```

_node2_

```
    mysql -h 172.18.0.4 -u root -pmysql -P 3306 -e "USE bet; select * from bookmaker;"
```

__Результат:__

![img](https://github.com/kakunindima/otus_linux/blob/master/less33/img/check.png)

__5.Проверка статуса кластера__

_Запускаем консоль mysqlsh в контейнере mysql-shell:_

```
    docker exec -ti less33_mysql-shell_1 bash
```
_Делаем запрос к 1-й ноде (может быть выбрана 2-я и 3-я)_

```
    mysqlsh --uri root@node1
```

_Проверяем статус кластера_

```
    dba.getCluster().status()
```

__Запустить консоль mysql в контейнере mysql-shell можно так:

```
    docker exec -ti less33_mysql-shell_1 bash
    mysql -u root -pmysql__
```

__Результат__

![img](https://github.com/kakunindima/otus_linux/blob/master/less33/img/cluster_stat.png)