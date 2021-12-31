#!/bin/bash

install_pacman_packages() {
    sudo pacman -Syu &&
    sudo pacman -S --needed - < ./package_list_pacman 
}

install_yay() {
    git clone https://aur.archlinux.org/yay.git &&
    cd yay &&
    makepkg -si &&
    cd .. &&
    sudo rm -r yay
}

install_yay_packages() {
    yay -S --needed - < ./package_list_aur
}

deploy_configs() {
    files=($(find -type f -not -path "./.git/*" -printf "\"%p\"\n" | tr '\n' ' '))
    delete=('"./deploy.sh"' '"./package_list_pacman"' '"./package_list_aur"')

    for del in ${delete[@]}
    do
        files=("${files[@]/$del}")
    done

    for file in ${files[@]}
    do
	actual_path=$(echo $file | sed 's|"./|"/|g' | sed "s|/home/user|/home/$(whoami)|g")
	sudo mkdir -p $(echo $actual_path | sed 's|\/[^\/]*$|"|g' | sed 's/"//g')
	sudo rm $(echo $actual_path | sed 's/"//g')
	sudo ln -sf $(readlink -f $(echo $file | sed 's/"//g')) $(echo $actual_path | sed 's/"//g')
    done
}

install_patched_dmenu() {
    git clone https://github.com/mahancoder/dmenu-xyw-lineheight.git &&
    cd dmenu-xyw-lineheight &&
    make clean &&
    make -j &&
    sudo make install &&
    cd .. &&
    sudo rm -r dmenu-xyw-lineheight
}

install_adobe_connect() {
    curl "https://github.com/mahancoder/Adobe-Connect-Linux/releases/download/v1.0/v1.0.tar.gz" -o connect.tar.gz &&
    tar -xzf connect.tar.gz &&
    cd connect &&
    ./install.sh &&
    cd .. &&
    sudo rm -r connect
    sudo rm connect.tar.gz
}

install_dmenu_power() {
    git clone https://github.com/mahancoder/dmenu-power-options.git
    cd dmenu-power-options &&
    ./install.sh &&
    cd .. &&
    sudo rm -r dmenu-power-options
}

post_install() {
    echo "Enabling SystemD services..."
    sudo systemctl enable systemd-resolved
    sudo systemctl enable NetworkManager
    sudo systemctl enable lightdm

    echo "Installing patched Dmenu..."
    install_patched_dmenu

    echo "Installing dmenu power options..."
    install_dmenu_power

    echo "Installing Adobe Connect..."
    install_adobe_connect
}

echo "Installing pacman packages..." &&
install_pacman_packages &&

echo "Installing yay..." &&	
install_yay &&

echo "Installing yay packages..." &&
install_yay_packages &&

echo "Deploying config files..." &&
deploy_configs &&

echo "Running post-install jobs..." &&
post_install &&

echo "Deployment Successful"
