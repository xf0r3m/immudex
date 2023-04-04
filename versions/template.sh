#!/bin/bash

function update_packages() {
  dhclient;
  sudo apt update;
  sudo apt upgrade -y;
}

function install_packages() {
  sudo apt install $@ -y;
}

function get_immudex_project() {
  if [ ! -d ~/immudex ]; then
    cd;
    git clone https://github.com/xf0r3m/immudex.git;
  fi
}

function recreate_users() {
  sudo userdel -r user;
  sudo userdel -r xf0r3m;
  sudo useradd -m -s /bin/bash user;
  sudo useradd -m -s /bin/bash xf0r3m;
  echo 'user:user1' | sudo chpasswd user;
  echo 'xf0r3m:xf0r3m1' | sudo chpasswd xf0r3m;
  sudo usermod -aG libvirt,libvirt-qemu user;
  sudo usermod -aG libvirt,libvirt-qemu xf0r3m;
}

function tidy() {
  sudo apt autoremove -y;
  sudo apt autoclean;
  sudo apt-get clean;
  sudo apt-get clean;
  sudo rm -rf ~/immudex;
  echo > ~/.bash_history;
  history -c
}

function set_notifier_packages() {
  cp -vv ~/immudex/files/011/Notifier\ -\ packages.desktop /home/xf0r3m/.config/autostart;
  chown xf0r3m:xf0r3m /home/xf0r3m/.config/autostart/Notifier\ -\ packages.desktop;
}

VERSION=$(echo $0 | cut -d "." -f 1);
if [ ! $VERSION ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi


