# Otus-linux hometask
## less28
### WEB

__Простая защита от DDOS__

__В ДЗ реализована базовая часть задания. проверка выполняется__

__Создан Docker image, проверено на развернутом контейнере__

__Написана конфигурация для nginx которая даёт доступ клиенту только с определенной cookie.__

__Если у клиента её нет, нужно выполнить редирект на location, в котором кука будет добавлена, после чего клиент будет обратно отправлен (редирект) на запрашиваемый ресурс.__

__Проверка выполнялась по предложенному сценарию:__

__Самопроверка:__
```
 docker run -p 80:80 pengwinn/web:latest 
 
 сurl http://localhost/otus.txt
```
__В результате получаем ошибку__

__Открыв в браузере [http://localhost/otus.txt](http://localhost/otus.txt) видим Docker репозиторий__

__Результат тестирования приложен на скриншоте__

![img](https://github.com/kakunindima/otus_linux/blob/master/less28/web.png)

__Ccылка на [Docker repo](https://hub.docker.com/repository/docker/pengwinn/web)__