#!/bin/bash

pacman -S sed reflector

# Руссификация консоли
loadkeys ru
setfont cyr-sun16

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

export LANG=ru_RU.UTF-8

timedatectl set-ntp true
timedatectl status

# Разбивка диска
fdisk -l
cfdisk -z /dev/sda

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

# Настройка Зеркал
reflector --country Russia --country Kazakhstan --age 6 --sort rate --save mirrorlist

# Установка Arch
pacstrap -i /mnt base base-devel

genfstab -L -p -P /mnt >> /mnt/etc/fstab

arch-chroot /mnt

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
pacman -S gdm networkmanager
pacman -S cinnamon cinnamon-translations
systemctl enable sddm
systemctl enable NetworkManager

# Установка pacaur
sudo pacman -Syu
pacman -S git
mkdir -p /tmp/pacaur_install
cd /tmp/pacaur_install
git clone https://aur.archlinux.org/auracle-git.git
cd auracle-git
makepkg -si
cd ..
git clone https://aur.archlinux.org/pacaur.git
cd pacaur
makepkg -si
cd ../..
rm -rf pacaur_install

packman -S xdg-user-dirs

exit
umount -R /mnt
reboot
