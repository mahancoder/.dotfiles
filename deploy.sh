#!/bin/sh

insatll_pacman_packages() {
    sudo pacman -Syu &&
    sudo pacman -S --needed - < ./package_list_pacman &&
}

inatall_yay() {
    git clone https://aur.archlinux.org/yay.git &&
    cd yay &&
    makepkg -si &&
    cd .. &&
    sudo rm -r yay &&
}

install_yay_packages() {
    yay -S --needed - < ./package_list_aur &&
}

deploy_configs() {
    files=($(find . -type f -printf "\"%p\"\n" | tr '\n' ' '))
    delete=(deploy.sh package_list_pacman package_list_aur)

    for del in ${delete[@]}
    do
        files=("${array[@]/$del}")
    done

    for file in $files
    do
        sudo cp -a $file $(echo $file | sed 's|"./|"/|g' | sed "s|/home/user|/home/$(whoami)|g")
    done
}

post_insatll() {

}

install_pacman_packages &&
install_yay &&
install_yay_packages &&
deploy_configs &&
post_install &&
echo "Deployment Successful"
