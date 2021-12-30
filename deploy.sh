#!/bin/sh

sudo pacman -Syu &&
sudo pacman -S --needed - < ./package_list_pacman &&

git clone https://aur.archlinux.org/yay.git &&
cd yay &&
makepkg -si &&
cd .. &&
sudo rm -r yay &&

yay -S --needed - < ./package_list_aur &&

files=($(find . -type f -printf "\"%p\"\n" | tr '\n' ' '))
delete=(deploy.sh deploy.py package_list_pacman package_list_aur path.json)

for del in ${delete[@]}
do
    files=("${array[@]/$del}")
done

for file in $files
do
    sudo cp -a $file $(echo $file | sed 's|"./|"/|g' | sed "s|/home/user|/home/$(whoami)|g")
done

./post-install.sh
