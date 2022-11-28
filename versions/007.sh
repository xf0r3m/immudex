#!/bin/bash

version=$(echo 0 | cut -d "." -f 1);
if [ ! $version ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi

sudo dhclient;
sudo apt update;
sudo apt upgrade -y;

sudo apt install transmission-gtk;


sudo cp -vv ~/immudex/tools/${version}/ytplay /usr/local/bin;
chmod +x /usr/local/bin;



sudo apt remove -y libssl-dev libbz2-dev libnss3-dev libgdbm-dev libncurses5-dev libffi-dev libreadline-dev libsqlite3-dev zlib1g-dev build-essential software-properties-common;
sudo apt autoremove -y;
