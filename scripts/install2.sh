#!/bin/bash

sudo pacman -Syu

# Установка pacaur
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

pacaur -S aic94xx-firmware wd719x-firmware

sudo mkinitcpio -p linux
