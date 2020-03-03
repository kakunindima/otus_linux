# Otus-linux HOMETASK
## Lesson 5
### Working with process
__Скрипт для вывода информации о процессах - интерпритация команды PS__

__Скрипт выводит информацию о запущенных процессах в системе в формате:__
__PID	PPID	STATUS	NICE	COMMAND__

__PID-идентификатор процесса__

__PPID-идентификатор родитеслького процесса__

__STATUS-состояние процесса__

R-running

D-waiting in uninterruptible disk sleep

Z-zombie

T-stopped

t-tracing stop

W-paging

X-dead

x-dead

K-wakekill

W-waking

P-parked

__NICE-priority of process__

__COMMAND-исполняемый процесс__

Для запуска проверки необходимо:

Вариант 1. Проверка скрипта на локальной машине
Скачать репозиторий, перейти в папку otus_linux/less5/
запустить скрипт ps.sh

Варимант 2. Проверка скрипта на vagrant стенде

2.1 Скачать репозиторий, перейти в папку и запустить vagrantfile
```
    vagrant up
```
2.2 Залогиниться на виртуальной машине 
```
    vagrant ssh
```
2.3 Перейти в папку 
```
    /srv/scripts/otus_linux/less5/
```
2.4 Запустить скрипт
```
    ./ps.sh
```
