# Otus-Linux Hometask
## Lesson 7
### SystemV-SystemD
__ДЗ состоит из 3х частей, сделана только основная часть__

__Для выполнения проверки необходимо скачать репозиторий перейти в папку и запустить vagrant-стенд__

```
    git clone https://github.com/kakunindima/otus_linux.git
    cd /otus_linux/less7/
    vagrant up
```
__________________________________________________________________

__Задание1:__

__Написать сервис, который будет раз в 30 секунд мониторить лог на
предмет наличие ключевого слова. Файл и слово должно задаваться в
/etc/sysconfig__

_Скрипт /opt/watchlog.sh_

_Unit файлы: /etc/systemd/system/watchlog.timer, /etc/systemd/system/watchlog.service,_

_Config /etc/sysconfig/watchlog_

_Log /var/log/watchlog.log_

__Для првоерки работы сервиса необходимо запустить сервис(если вдруг не стартанул при запуске стенда по умолчанию сервис стартует автоматически через shell provisioning)__

```
    sudo systemctl start watchlog.service
    sudo systemctl start watchlog.timer
```
__Далее результат выполнения скрипта просмотреть выполнив команду__

```
     tail -f /var/log/messages
```
__Как результат в сообщениях будет запись что в логе найдено проверочное слово test__

__________________________________________________________________

__Задание2:__

__Два сервиса httpd работающие на разных портах__

__Создано 2 сервиса httpd-first порт 80, httpd-second порт 8081__

__Проверить состояние сервиса можно командой__

```
    systemctl status httpd-first
    systemctl status httpd-second
```
__________________________________________________________________

__Задание3:__

__Сервис Jira запущенный и ограниченый по памяти и еще нескольким ресурсам, настроеный ресет сервиса__

__Сервис ограничен по памяти до 500M параметром MemoryLimit__

__Процесс ограничен по 4 параметрам LimitCPU, LimitDATA, LimitNOFILE, LimitNPROC__

__Статус сервиса Jira можно просмотреть командой__

```
    systemctl status jira
```