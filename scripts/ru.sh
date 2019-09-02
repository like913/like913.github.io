#!/bin/bash

pacman -Sy sed --noconfirm 

echo "Russification..."
loadkeys ru
setfont cyr-sun16

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

export LANG=ru_RU.UTF-8
