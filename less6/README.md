# Otus-linux Hometask
## Lesson 6
### Boot
__Дз состояло из 3х частей (выполнена основная часть)__
__________________________________________________________________

__Часть1:__

__Вход в систему без пароля разными способами__

__Тестировал разные методы, на вирт машине с установленной ubuntu-19.04__

__Из 3х методов представленных в методичке сработал только один - первый, при котором необходимо выполнить последовательность действий:__

__1. В строке с linux (часть где прописывается загрузчик) добавить  ``` init=/bin/sh ```, жмем ctrl+x грузимся в систему__

__2. Перемонтируем рут ФС в режим чтения/записи ```mount -o remount,rw /```__

__3. Далее меняем пароль рута__

__Часть1: дополнение - тестирование методов на системе Centos7__

_В связи с тем что первоначально проверял данные методы при помощи vagrant-стенда, не совсем корректно все работало._

__После запуска отдельной VM с Centos7 протестировал все три метода смены пароля root__

__Наиболее простой и быстрый способ - вариант3: выбираем редактирование строки агрузчика и меняем монтирование в редиме чтения/запись и грузимся ```rw init=/sysroot/bin/sh``` далее уже просто меняем паоль__

__Способ 2 - с использованием rd.break - требует больше манипуляций но в итоге он наиболее эффетивный при смене пароля__
__________________________________________________________________

__Часть2:__

__Установить систему на lvm после чего сменить название Volume Group__

__Ниже представлен листинг утилиты script - основные шаги__

__Смотрим название vg в системе__
```
    [root@localhost pengwinn]# vgs
	VG     #PV #LV #SN Attr   VSize  VFree
	centos   1   2   0 wz--n- <7.00g    0
```
__Меняем название и проверяем__

```
    [root@localhost pengwinn]# vgrename centos pengwinn
	Volume group "centos" successfully renamed to "pengwinn"

    [root@localhost pengwinn]# vgs
	VG       #PV #LV #SN Attr   VSize  VFree
	pengwinn   1   2   0 wz--n- <7.00g    0
```

__Правим название vg в /etc/fstab, /etc/default/grub, /boot/grub2/grub.cfg__

```
    [root@localhost pengwinn]# vi /etc/fstab
    [root@localhost pengwinn]# vi /etc/default/grub
    [root@localhost pengwinn]# vi /boot/grub2/grub.cfg
```

__Пересоздаем initrd image__
```
    [root@localhost pengwinn]# mkinitrd -v /boot/initramfs-$(uname -r).img $(uname -r)
    *** Creating initramfs image file '/boot/initramfs-3.10.0-1062.el7.x86_64.img' done ***
```

__Перезагружаемся и проверяем название vg__
```
    [root@localhost pengwinn]# vgs
	VG       #PV #LV #SN Attr   VSize  VFree
	pengwinn   1   2   0 wz--n- <7.00g    0
```
__Готово__
__________________________________________________________________

__Часть3:__

__Добавить модуль в initrd__

__Согласно методичке выполнил пункты:__

__1. Создаем папку с именем модуля и помещаем туда два скрипта__

```
mkdir /usr/lib/dracut/modules.d/01test
```

_Репозиторий с кодом для [module-setup.sh](https://gist.github.com/lalbrekht/e51b2580b47bb5a150bd1a002f16ae85)_

```
touch module-setup.sh

```
_Репозиторий с кодом для [test.sh](https://gist.github.com/lalbrekht/ac45d7a6c6856baea348e64fac43faf0)_

```
touch test.sh
```
__2.Пересобираю initrd__
```
 mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)
```
__Проверяем установлен ли наш модуль__
```
lsinitrd -m /boot/initramfs-$(uname -r).img | grep test
[root@localhost ~]# lsinitrd -m /boot/initramfs-$(uname -r).img | grep test
test
```
__3.Правим grub.cfg - убираем опции rghb,quiet__

__Ребутимся...__

__В итоге при загрузке наблюдаем пингвина)__
```
Hello! You are in dracut module!
 ___________________
< I'm dracut module >
 -------------------
   \
    \
        .--.
       |o_o |
       |:_/ |
      //   \ \
     (|     | )
    /'\_   _/`\
    \___)=(___/
msgend
sleep 10
echo " continuing...."
```
