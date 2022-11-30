#!/bin/bash

version=$(echo 0 | cut -d "." -f 1);
if [ ! $version ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi

sudo dhclient;
sudo apt update;
sudo apt upgrade -y;

sudo apt install -y transmission-gtk;


sudo cp -vv ~/immudex/tools/${version}/ytplay /usr/local/bin;
sudo cp -vv ~/immudex/tools/${version}/immudex_crypt /usr/local/bin;
chmod +x /usr/local/bin;

sudo rm -rf /etc/skel/.mozilla;
sudo tar -xzvf ~/immudex/files/${version}/mozilla.tgz -C /etc/skel
sudo chown -R root:root /etc/skel/.mozilla

sudo sed -i 's/80x24/100x30/' /etc/skel/.config/xfce4/terminal/terminalrc

sudo apt remove -y libssl-dev libbz2-dev libnss3-dev libgdbm-dev libncurses5-dev libffi-dev libreadline-dev libsqlite3-dev zlib1g-dev build-essential software-properties-common;
sudo apt autoremove -y;

sudo userdel -r user;
sudo userdel -r xf0r3m;
sudo useradd -m -s /bin/bash user;
sudo useradd -m -s /bin/bash xf0r3m;
echo 'user:user1' | sudo chpasswd user;
echo 'xf0r3m:xf0r3m1' | sudo chpasswd xf0r3m;
sudo usermod -aG libvirt,libvirt-qemu user;
sudo usermod -aG libvirt,libvirt-qemu xf0r3m;

rm -rf ~/immudex;
sudo apt autoclean;
sudo apt-get clean;
sudo apt-get clean;
echo > ~/.bash_history;
history -c

