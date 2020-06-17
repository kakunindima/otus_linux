# Otus-linux hometask
## Less23
### DNS BIND

__Результат выполнения дз представлен готовым стендом__

__Для проверки необходимо выполнить следующие действия:__

1. Запустить vagrant-стенд

``` vagrant up
```

1. Проверить client1/client2 dns resolution
```
  vagrant ssh client1

  dig web1.dns.lab
  dig web2.dns.lab
  dig www.newdns.lab
  dig -x 192.168.50.16

  dig @192.168.50.11 web1.dns.lab
  dig @192.168.50.11 web2.dns.lab
  dig @192.168.50.11 www.newdns.lab
  dig @192.168.50.11 -x 192.168.50.16
```
