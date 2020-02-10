# Home task otus linux
## lesson 1
### Обновление ядра базовой системы.
__ДЗ выплнено на уровень__ ```*```

_Собран образ_ __Centos7__ _с собранным из исходников ядра_ __5.5.1__

__Детальный листинг:__

__Обновление системы + установка всякого Очень нужного для дальнейдшего билда ядра__
```bash
    sudo yum update -y
    sudo yum groupinstall "Develoment tools"
    sudo yum install yum-utils ncurses-devel make kernel-devel bc gcc openssl-devel flex bison libssl-dev pkg-config ncurses-devel libncurses-dev openssl-devel elfutils-libelf-devel perl wget -y
```

__Получение исходников ядра + распаковка__
```bash
    sudo mkdir /usr/src/kernel_sources
    cd /usr/src/kernel_sources
    sudo wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.5.1.tar.xz
    sudo tar xf linux*
    cd linux*
```
__Подготовка к билду:__

_копирование настроек из конфига для старого ядра_
```bash
    sudo cp /boot/config-`uname -r` /usr/src/kernel_sources/linux-5.5.1/.config
```
_тоже копирование (возможно и не понадобилось) на всяк случай)_
```bash
    sudo yes "" | make oldconfig
```
__Билдим ядро и модули - распаралеливаем на 4 потока моего проца Intel i3__
```bash
    sudo make -j 5 && make -j 5 modules
```

__Инсталируем модули и ядро__
```bash
    sudo make -j 5 modules_install && sudo make -j 5 install
```
__Обновляем конфиг загрузчика grub добавляя новое собранное ядро__
```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```
__Указываем новое ядро дефолтным.__
```bash
    sudo grub2-set-default 0
```
__Готово....__

__Ребутим машину и выполняем очистку и упаковку образа для vagrant__
```bash
    sudo reboot
```
__Удаляем старые ядра, оставив только свеже-собранное__
```bash
    sudo package-cleanup --oldkernels --count=1 -y
```
__Чистим систему__
```bash
    yum clean all
    sudo yum grouremove "Development tools"
    sudo yum remove ncurces-devel kernel-devel gcc openssl-devel flex bison libssl-dev pkg-config ncurces-devel libcurces-dev
```
__Пакуем образ vagrant.__
__Далее тестируем образ.__