#!/bin/bash

pacman -Sy sed --noconfirm

echo "Russification..."
loadkeys ru
setfont cyr-sun16
echo -e "KEYMAP=ru\nFONT=cyr-sun16\n" > /etc/vconsole.conf

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
export LANG=ru_RU.UTF-8

echo "Настройка времени"
timedatectl set-ntp true
hwclock --systohc --utc
timedatectl status

echo "Имя компьютера"
echo "E5-576G" > /etc/hostname
echo -e "127.0.0.1 localhost\n::1 localhost\n" > /etc/hosts

echo "Собираем ядро"
mkinitcpio -p linux

# Настройка администратора и создание пользователя like
echo "Пароль root"
passwd
useradd -G wheel -s /bin/bash -m like
echo "Пароль пользователя"
passwd like

echo "Настройка прав администратора"
sed -i 's/#%wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers
sed -i 's/#Color/Color/g' /etc/pacman.conf

echo "Разблокировка x32 библиотек"
echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf

pacman -Syy

echo "Установка GRUB"
pacman -S grub efibootmgr --noconfirm #для mbr удалить efibootmgr
#pacman -S amd-ucode --noconfirm #раскомментировать строку для AMD процессора
#pacman -S intel-ucode --noconfirm #раскомментировать строку для AMD процессора
grub-install /dev/sda
echo "Настройка GRUB"
grub-mkconfig -o /boot/grub/grub.cfg

echo "Установка xorg и mesa" 
pacman -S xorg xorg-xinit mesa --noconfirm

echo "Установка драйверов"
#cd /etc/X11/xorg.conf.d/

#echo "Тачпад"
#pacman -S xf86-input-synaptics --noconfirm
#wget "https://like913.github.io/confug/10-synaptics.conf"

#echo "Видеокарта"
#echo "intel"
#pacman -S xf86-video-intel --noconfirm
#wget "https://like913.github.io/confug/20-intel.conf"
#echo "Настрока DRM"
#sed -i 's/MODULES=()/MODULES=(i915)/g' /etc/mkinitcpio.conf

#echo "nvidia"
#pacman -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings --noconfirm
## После перезагрузки выполнить sudo nvidia-xconfig для настройки видеокары
## sudo nvidia-xconfig --prime необходимо для конфигурирования драйвера в совместимом режиме с картой intel
#echo "Настрока DRM"
#sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/g' /etc/mkinitcpio.conf
# Настройка SDDM для nVidia PRIME
#echo "xrandr --setprovideroutputsource modesetting NVIDIA-0" >> /usr/share/sddm/scripts/Xsetup
#echo "xrandr --auto" >> /usr/share/sddm/scripts/Xsetup

#echo "AMD" #Установка и настройка AMD не тестировалось
#pacman -S xf86-video-amdgpu --noconfirm

echo "VirtualBox"
pacman -S virtualbox-guest-utils --noconfirm

echo "Установка Display Manager" # раскомментировать блок SDDM или LXDM
#echo "Установка sddm"
#pacman -S sddm --noconfirm
#systemctl enable sddm

echo "Установка lxdm"
pacman -S lxdm --noconfirm
systemctl enable lxdm

echo "Установка настройки сети"
pacman -S networkmanager --noconfirm
systemctl enable NetworkManager

echo "Установка Desktop Environment"
echo "Cinnamon"
pacman -S cinnamon cinnamon-translations --noconfirm

#echo "Deepin"
#pacman -S deepin --noconfirm

#echo "KDE Plasma"
#pacman -Sy plasma-meta kdebase --noconfirm

#echo "XFCE"
#pacman -S xfce4 xfce4-goodies --noconfirm

echo 'Ставим шрифты'
pacman -S ttf-liberation ttf-dejavu --noconfirm 

echo "Собрать ядро"
mkinitcpio -p linux

echo "Настройка папок пользователя"
packman -S xdg-user-dirs

exit
