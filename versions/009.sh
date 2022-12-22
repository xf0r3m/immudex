#!/bin/bash

version=$(echo $0 | cut -d "." -f 1);
if [ ! $version ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi

sudo dhclient;
sudo apt update;
sudo apt upgrade -y;

sudo apt autoremove -y;
sudo apt autoclean;
sudo apt-get clean;
sudo apt-get clean;
echo > ~/.bash_history;
history -c

