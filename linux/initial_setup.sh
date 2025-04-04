#!/bin/bash
sudo apt install && sudo apt upgrade && sudo apt autoremove
sudo apt-get update && sudo apt-get upgrade
sudo apt install unzip
curl -s https://ohmyposh.dev/install.sh | bash -s
git clone https://github.com/JanDeDobbeleer/oh-my-posh.git ~/oh-my-posh
cp .profile ~/.profile
cp .bash_aliases ~/.bash_aliases
if [ -n "$1" -a "$1" == "wsl" ]; then
    echo Copying wsl.conf to /etc/wsl.conf
    sudo cp wsl.conf /etc/wsl.conf
fi
