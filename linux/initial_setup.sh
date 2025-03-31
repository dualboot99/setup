#!/bin/bash
sudo apt install && sudo apt upgrade && sudo apt autoremove
sudo apt-get update && sudo apt-get upgrade
sudo apt install unzip
curl -s https://ohmyposh.dev/install.sh | bash -s
git clone https://github.com/JanDeDobbeleer/oh-my-posh.git
cp .profile ~/.profile
cp .bash_aliases ~/.bash_aliases
sudo cp wsl.conf /etc/wsl.conf
