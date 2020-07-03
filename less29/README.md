# Otus-linux hometask
## less 29
### Postgres

__ДЗ выполнено в соответствии с заданием:__

__Настроить hot_standby репликацию с использованием слотов__

__Настроить правильное резервное копирование__

__Результат представлен готовым к работе vagrant-стендом__

__в ansible-roles приложены postgresql.conf, pg_hba.conf и recovery.conf а так же конфиг barman__

### Проверка стенда

__Запуск стенда__
```
    vagrant up
```

__Проверка streaming__

```
    vagrant ssh backup
    sudo barman switch-wal --force --archive master.local
```

__Результат:__

![img](https://github.com/kakunindima/otus_linux/blob/master/less29/img/streaming.png)

__Проверка конфигов barman__

```
    vagrant ssh backup
    sudo barman check master.local
```

__Результат:__

![img](https://github.com/kakunindima/otus_linux/blob/master/less29/img/barman.png)

__Создание БД__
```
    vagrant ssh master
    sudo su postgres
    psql
    CREATE DATABASE "test";
    \c test
    CREATE TABLE users (id serial PRIMARY KEY, name VARCHAR (255) UNIQUE NOT NULL);
    INSERT INTO users (name) values ('kdv');
```

__Результат__

![img](https://github.com/kakunindima/otus_linux/blob/master/less29/img/db.png)


![img](https://github.com/kakunindima/otus_linux/blob/master/less29/img/pg_test.png)