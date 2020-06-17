# Otus-linux Hometask
## less32
### MYSQL Replication

__Задание:__

__Развернуть дамп и настроить репликацию__

__В качестве решения приложен готовый стенд__

__Запускаем стенд__

    ```
    vagrant up
    ```

__Проверка работоспособности репликации__
```
vagrant ssh master
mysql -uroot -p'Dlj[yjdtybt1' -D 'bet' -e 'INSERT INTO bookmaker (id,bookmaker_name) VALUES(1,"1xbet");'
exit

vagrant ssh slave
mysql -uroot -p'Dlj[yjdtybt1' -D 'bet' -e 'SELECT * FROM bookmaker;'
exit
```

__Результат:__

![img](https://github.com/kakunindima/otus_linux/blob/master/less32/mysql.png)