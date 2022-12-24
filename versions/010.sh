#!/bin/bash

version=$(echo $0 | cut -d "." -f 1);
if [ ! $version ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi

sudo dhclient;
sudo apt update;
sudo apt upgrade -y;
sudo apt install grub-efi-ia32-bin -y;

if [ ! -d ~/immudex ]; then
  cd;
  git clone https://github.com/immudex/immudex.git;
fi

sudo cp -vv ~/immudex/tools/${version}/immudex_install /usr/local/bin;
chmod +x /usr/local/bin;

rm -rf ~/immudex;
sudo apt autoremove -y;
sudo apt autoclean;
sudo apt-get clean;
sudo apt-get clean;
echo > ~/.bash_history;
history -c

