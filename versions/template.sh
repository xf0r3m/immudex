#!/bin/bash

function update_packages() {
  dhclient; 
  apt update;
  apt upgrade -y;
}

function install_packages() {
  apt install $@ -y;
}

function recreate_users() {
  userdel -r user;
  userdel -r xf0r3m;

  useradd -m -s /bin/bash user;
  cp -rvv /etc/skel/.??* /home/user;
  cp -rvv /etc/skel/?* /home/user;
  mkdir /home/user/.local;
  tar -xvf ~/immudex/files/${VERSION}/local_user.tar -C /home/user/.local;
  rm /home/user/.face;
  cp /usr/share/images/desktop-base/immudex_xfce_greeter_logo.png /home/user/.face;
  chown -R user:user /home/user;
  echo "user:user1" | chpasswd;

  useradd -m -s /bin/bash xf0r3m;
  cp -rvv /etc/skel/.??* /home/xf0r3m;
  cp -rvv /etc/skel/?* /home/xf0r3m;
  mkdir /home/xf0r3m/.local;
  tar -xvf ~/immudex/files/${VERSION}/local_xf0r3m.tar -C /home/xf0r3m/.local;
  rm /home/xf0r3m/.face;
  cp /usr/share/images/desktop-base/immudex_xfce_greeter_logo.png /home/xf0r3m/.face;
  chown -R xf0r3m:xf0r3m /home/xf0r3m;
  echo "xf0r3m:xf0r3m1" | chpasswd;

  usermod -aG libvirt,libvirt-qemu xf0r3m;
  usermod -aG libvirt,libvirt-qemu user;

  echo "root:toor" | chpasswd;
}

function tidy() {
  apt-get clean;
  apt-get clean;
  apt-get autoremove -y;
  apt-get autoclean;
  rm -rf ~/immudex;
  if [ -d ~/xfcedebian ]; then rm -rf ~/xfcedebian; fi
  rm /var/cache/apt/*.bin;
  echo > ~/.bash_history;
  history -c   
}

function set_default_wallpaper() {
  rm /usr/share/images/desktop-base/default;
  ln -s /usr/share/images/desktop-base/$1 /usr/share/images/desktop-base/default;
}

function set_notifier_packages() {
  cp -vv ~/immudex/files/${VERSION}/Notifier\ -\ packages.desktop /home/xf0r3m/.config/autostart;
  chown xf0r3m:xf0r3m /home/xf0r3m/.config/autostart/Notifier\ -\ packages.desktop;
}

function set_xfce4_notes_autostart() {
  cp -vv ~/immudex/files/${VERSION}/autostart-x4notes.desktop /home/xf0r3m/.config/autostart;
  chown xf0r3m:xf0r3m /home/xf0r3m/.config/autostart/autostart-x4notes.desktop;
}

