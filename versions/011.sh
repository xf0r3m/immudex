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

VERSION=$(echo $0 | cut -d "." -f 1);
if [ ! $VERSION ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi

update_packages;
install_packages openvpn netselect-apt debootstrap squashfs-tools xorriso isolinux syslinux-efi grub-pc-bin grub-efi-amd64-bin mtools dosfstools solaar chrony;

get_immudex_project;

sudo cp -vv ~/immudex/tools/${VERSION}/secured-firefox /usr/local/bin;
sudo cp -vv ~/immudex/tools/${VERSION}/immudex_upgrade /usr/local/bin;
sudo cp -vv ~/immudex/tools/${VERSION}/library.sh /usr/local/bin;
sudo cp -vv ~/immudex/tools/${VERSION}/motd2 /usr/local/bin;
sudo chmod +x /usr/local/bin/*;

sudo cp -vv ~/immudex/files/${VERSION}/16608166085.desktop /etc/skel/.config/xfce4/panel/launcher-19/16608166085.desktop;
sudo cp -vv ~/immudex/files/${VERSION}/firejail.config /etc/firejail;
sudo cp -vv ~/immudex/files/${VERSION}/Notifier\ -\ distro.desktop /etc/skel/.config/autostart;
sudo cp -vv ~/immudex/files/${VERSION}/config /etc/skel/.irssi;

sudo rm -rf /etc/skel/.mozilla;
sudo tar -xzvf ~/immudex/files/${VERSION}/mozilla.tgz -C /etc/skel;

cp -vv ~/immudex/images/${VERSION}/apply.png /usr/share/icons;

sudo apt install pip -y
sudo pip install yt-dlp
sudo rm /usr/bin/youtube-dl
sudo ln -s /usr/local/bin/yt-dlp /usr/bin/youtube-dl

recreate_users;

cp -vv ~/immudex/files/${VERSION}/Notifier\ -\ packages.desktop /home/xf0r3m/.config/autostart;
chown xf0r3m:xf0r3m /home/xf0r3m/.config/autostart/Notifier\ -\ packages.desktop;

tidy;
