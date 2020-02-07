Home task otus linux
lesson 1
Обновление ядра базовой системы.
ДЗ выплнено на уровень *
Собран образ Centos7 с собранным из исходников ядра 5.5.1

Детальный листинг:

Обновление системы + установка всякого Очень нужного для дальнейдшего билда ядра
sudo yum update -y
sudo yum groupinstall "Develoment tools"
sudo yum install yum-utils ncurses-devel make kernel-devel bc gcc openssl-devel flex bison libssl-dev pkg-config ncurses-devel libncurses-dev openssl-devel elfutils-libelf-devel perl wget -y

Получение исходников ядра + распаковка
sudo mkdir /usr/src/kernel_sources
cd /usr/src/kernel_sources
sudo wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.5.1.tar.xz
sudo tar xf linux*
cd linux*

Подготовка к билду:
копирование настроек из конфига для старого ядра
sudo cp /boot/config-`uname -r` /usr/src/kernel_sources/linux-5.5.1/.config
тоже копирование (возможно и не понадобилось) на всяк случай)
sudo yes "" | make oldconfig

Билдим ядро и модули - распаралеливаем на 4 потока моего проца Intel i3 
sudo make -j 5 && make -j 5 modules

Инсталируем модули и ядро
sudo make -j 5 modules_install && sudo make -j 5 install

Обновляем конфиг загрузчика grub добавляя новое собранное ядро
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

Указываем новое ядро дефолтным.
sudo grub2-set-default 0

Готово....
Ребутим машину и выполняем очистку и упаковку образа для vagrant
sudo reboot

Удаляем старые ядра, оставив только свеже-собранное
sudo package-cleanup --oldkernels --count=1 -y

Чистим систему
yum clean all
sudo yum grouremove "Development tools"
sudo yum remove ncurces-devel kernel-devel gcc openssl-devel flex bison libssl-dev pkg-config ncurces-devel libcurces-dev

Пакуем образ vagrant.

Далее тестируем образ.