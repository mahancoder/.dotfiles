#!/bin/sh
sudo pacman -Syu &&
sudo pacman -S --needed - < ./package_list_pacman &&
git clone https://aur.archlinux.org/yay.git &&
cd yay &&
makepkg -si &&
cd .. &&
sudo rm -r yay &&
yay -S --needed - < ./package_list_aur &&

