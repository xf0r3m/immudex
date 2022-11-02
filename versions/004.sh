#!/bin/bash

version=$(echo $0 | cut -d "." -f 1);
if [ ! $version ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi;

dhclient;
sudo apt update;
sudo apt upgrade -y;
sudo apt install vim-gtk3

if [ ! -d ~/immudex ]; then
  cd;
  git clone https://github.com/xf0r3m/immudex;
fi

sudo cp -vv ~/immudex/launchers/${version}/16674118881.desktop /etc/skel/.config/xfce4/panel/launcher-32
sudo rm /etc/skel/.confg/xfce4/panel/launcher-32/16608177609.desktop
sudo cp -vv ~/immudex/files/${version}/xfce4-panel.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

sudo userdel -r user;
sudo userdel -r xf0r3m;
sudo useradd -m -s /bin/bash user;
sudo useradd -m -s /bin/bash xf0r3m;
echo "user:user1" | sudo chpasswd;
echo "xf0r3m:xf0r3m1" | sudo chpasswd;
sudo usermod -aG libvirt,libvirt-qemu user;
sudo usermod -aG libvirt,libvirt-qemu xf0r3m;

rm -rf ~/immudex;
sudo apt-get clean;
echo > ~/.bash_history;
history -c;
