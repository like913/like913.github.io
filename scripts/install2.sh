#!/bin/bash

sudo pacman -Syu
sudo pacman -S git --noconfirm

echo "Установка pacaur"
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

echo "Установка микрокода ядра"
pacaur -S aic94xx-firmware wd719x-firmware

sudo mkinitcpio -p linux

echo "Установка wine"
sudo pacman -S wine wine-mono wine_gecko winetricks --noconfirm
pacaur -S d9vk-bin dxvk-bin
winecfg
setup_d9vk install
setup_dxvk install
sudo pacman -S vkd3d lib32-vkd3d --noconfirm
