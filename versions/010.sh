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
  echo > ~/.bash_history;
  history -c
}

VERSION=$(echo $0 | cut -d "." -f 1);
if [ ! $VERSION ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi

update_packages;
install_packages grub-efi-ia32-bin irssi;

get_immudex_project;

sudo cp -vv ~/immudex/tools/${VERSION}/create_media /usr/local/bin
sudo cp -vv ~/immudex/tools/${VERSION}/immudex_install /usr/local/bin;
chmod +x /usr/local/bin;

sudo cp -rvv ~/immudex/files/${VERSION}/libreoffice /etc/skel/.config;
sudo cp -rvv ~/immudex/files/${VERSION}/.irssi /etc/skel;

recreate_users;

sudo cp -vv ~/immudex/files/${VERSION}/irssi.desktop /home/xf0r3m/.config/autostart;
sudo chown -R 1001:1001 /home/xf0r3m;

tidy;
