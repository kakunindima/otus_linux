# Home task otus linux
## lesson 1
### Обновление ядра базовой системы.
_ДЗ выплнено на уровень *_
__Собран образ _Centos7_ с собранным из исходников ядра _5.5.1_ __

_Детальный листинг:_

_Обновление системы + установка всякого Очень нужного для дальнейдшего билда ядра_
```bash
    sudo yum update -y
    sudo yum groupinstall "Develoment tools"
    sudo yum install yum-utils ncurses-devel make kernel-devel bc gcc openssl-devel flex bison libssl-dev pkg-config ncurses-devel libncurses-dev openssl-devel elfutils-libelf-devel perl wget -y
```

_Получение исходников ядра + распаковка_
```bash
    sudo mkdir /usr/src/kernel_sources
    cd /usr/src/kernel_sources
    sudo wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.5.1.tar.xz
    sudo tar xf linux*
    cd linux*
```
_Подготовка к билду:_
__копирование настроек из конфига для старого ядра__
```bash
    sudo cp /boot/config-`uname -r` /usr/src/kernel_sources/linux-5.5.1/.config
```
__тоже копирование (возможно и не понадобилось) на всяк случай)__
```bash
    sudo yes "" | make oldconfig
```
_Билдим ядро и модули - распаралеливаем на 4 потока моего проца Intel i3_
```bash
    sudo make -j 5 && make -j 5 modules
```

_Инсталируем модули и ядро_
```bash
    sudo make -j 5 modules_install && sudo make -j 5 install
```
_Обновляем конфиг загрузчика grub добавляя новое собранное ядро_
```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```
_Указываем новое ядро дефолтным._
```bash
    sudo grub2-set-default 0
```
_Готово...._
_Ребутим машину и выполняем очистку и упаковку образа для vagrant_
```bash
    sudo reboot
```
_Удаляем старые ядра, оставив только свеже-собранное_
```bash
    sudo package-cleanup --oldkernels --count=1 -y
```
_Чистим систему_
```bash
    yum clean all
    sudo yum grouremove "Development tools"
    sudo yum remove ncurces-devel kernel-devel gcc openssl-devel flex bison libssl-dev pkg-config ncurces-devel libcurces-dev
```
_Пакуем образ vagrant._
_Далее тестируем образ.