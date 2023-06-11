#!/bin/bash

version=$(echo $0 | cut -d "." -f 1);
if [ ! $version ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi

sudo dhclient;
sudo apt update;

sudo apt autoremove -y;

sudo apt upgrade -y;

if [ ! -d ~/immudex ]; then
  cd;
  git clone https://github.com/xf0r3m/immudex;
fi

sudo cp -vv ~/immudex/images/${version}/rss.png /usr/share/icons;
sudo cp -vv ~/immudex/tools/${version}/newsfeed /usr/local/bin;
sudo cp -vv ~/immudex/tools/${version}/immudex_crypt /usr/local/bin;
sudo cp -vv ~/immudex/tools/${version}/padlock /usr/local/bin;

sudo chmod +x /usr/local/bin/*;

sudo apt-get clean;
sudo apt-get clean;
sudo apt-get autoremove -y;
sudo apt-get autoclean;
rm -rf ~/immudex;
echo > ~/.bash_history
history -c
