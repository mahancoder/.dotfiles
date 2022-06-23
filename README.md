# Mahancoder's dotfiles

## Description
This repo is the collection of all my config files for all my Linux programs, along with the list of installed packages and a deployment script to copy them all to their appropriate directories. Everything is intended for use on Arch Linux, however, config files should be compatible with any distro

## Usage
To deploy the config, clone the repo to your home directory and run `./deploy.sh` as your regular user.

## Behind the scenes
The script does these tasks in order:

* Symlink the package list files
* Install all native packages
* Install yay
* Install all AUR packages
* Install all pip packages
* Copy and symlink the configs to proper directories
* Install some other apps manually
* Configure the shell to be ZSH

## Configs
Some main app configs in these repo include:

* Qtile
* Vim
* NeoVim
* ZSH
* Bash
* Picom
* Alacritty
* Fontconfig
* GTK
* Etc.
