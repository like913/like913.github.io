#!/bin/bash

pacman -Sy sed reflector --noconfirm 

echo "Russification..."
loadkeys ru
setfont cyr-sun16

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

export LANG=ru_RU.UTF-8

echo "Синхронизация времени"
timedatectl set-ntp true
timedatectl status

echo "Форматирование диска"
fdisk -l
#cfdisk -z /dev/sda

mkswap /dev/sda1 -L swap
swapon /dev/sda1

mkfs.ext4 /dev/sda3 -L Arch
mount /dev/sda3 /mnt

mkfs.fat -F32 /dev/sda2 -n EFI
mkdir -p /mnt/boot
mount /dev/sda2 /mnt/boot

#mkfs.ext4 /dev/sda4 -L soft
#mkdir -p /mnt/opt
#mount /dev/sda4 /mnt/opt

mkfs.ext4 /dev/sda4 -L home
mkdir -p /mnt/home
mount /dev/sda4 /mnt/home

#mkfs.ext4 /dev/sda6 -L public
#mkdir -p /mnt/mnt/public
#mount /dev/sda6 /mnt/mnt/public

echo "Настройка Зеркал"
reflector --country Russia --country Kazakhstan --age 12 --sort rate --save /etc/pacman.d/mirrorlist

echo "Установка Arch"
pacstrap -i /mnt base base-devel

echo "Hacтройка точек монтирования"
genfstab -L -p -P /mnt >> /mnt/etc/fstab

echo "Установка"
arch-chroot /mnt sh install.sh

echo "Перезагрузка"
umount -R /mnt
reboot
