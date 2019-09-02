#!/bin/bash

pacman -Sy sed

# Руссификация консоли
loadkeys ru
setfont cyr-sun16
echo -e "KEYMAP=ru\nFONT=cyr-sun16\n" > /etc/vconsole.conf

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

echo 'LANG="ru_RU.UTF-8"' > /etc/locale.conf
export LANG=ru_RU.UTF-8

# Настройка времени
timedatectl set-ntp true
hwclock --systohc --utc
timedatectl status

# Имя компьютера
echo "E5-576G" > /etc/hostname
echo -e "127.0.0.1 localhost\n::1 localhost\n" > /etc/hosts

# Собираем ядро
mkinitcpio -p linux

# Настройка администратора и создание пользователя like 
passwd
useradd -G wheel -s /bin/bash -m like
passwd like

sed -i 's/#%wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers
sed -i 's/#Color/Color/g' /etc/pacman.conf
echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf

pacman -Syy

# Устонавливаем загрузчик
pacman -S grub #efibootmgr
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# Ставим X и cinnamon
pacman -S xorg xorg-xinit mesa
pacman -S xf86-video-vesa
pacman -S lightdm networkmanager
pacman -S cinnamon cinnamon-translations
systemctl enable lightdm.service
systemctl enable NetworkManager

mkinitcpio -p linux

packman -S xdg-user-dirs

exit
