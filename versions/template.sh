#!/bin/bash

function update_packages() {
  apt update;
  apt upgrade -y;
}

function install_packages() {
  apt install $@ -y;
}

function set_xfce4_notes_autostart() {
  cp -vv ~/immudex/files/autostart-x4notes.desktop /home/xf0r3m/.config/autostart;
  chown xf0r3m:xf0r3m /home/xf0r3m/.config/autostart/autostart-x4notes.desktop;
}


function recreate_users() {
  useradd -m -s /bin/bash user;
  cp -rvv /etc/skel/.??* /home/user;
  chown -R user:user /home/user;
  echo "user:user1" | chpasswd;

  useradd -m -s /bin/bash xf0r3m;
  cp -rvv /etc/skel/.??* /home/xf0r3m;
  chown -R xf0r3m:xf0r3m /home/xf0r3m;
  echo "xf0r3m:xf0r3m1" | chpasswd;
  set_xfce4_notes_autostart

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

function make_changelog_file() {
  ARCH=$1;
  DEBVER=$debver;
  COMPILATION_DATE=$(date);
  COMMIT=$(cd ${HOME}/immudex && git log --pretty=oneline | head -1);
  ADDONS=$(grep 'bash ~/immudex/addons' ${HOME}/immudex/versions/base.sh | grep -v '^#' | cut -d "/" -f4 | sed 's/;//g' | awk '{printf $1" "}');

  echo "ARCH=\"${ARCH}\"" > $FILE;
  echo "DEBVER=\"${DEBVER}\"" >> $FILE;
  if [ "$cname" ]; then
    echo "CANONICAL_NAME=\"${cname}\"" >> $FILE;
  fi
  if [ "$version" ]; then
    echo "VERSION=\"${version}\"" >> $FILE;
  fi
  echo "COMPILATION_DATE=\"${COMPILATION_DATE}\"" >> $FILE;
  echo "COMMIT=\"${COMMIT}\"" >> $FILE;
  echo "ADDONS=\"${ADDONS}\"" >> $FILE;
  echo "-== Diffrences in version file ==-" >> $FILE;
  (cd ${HOME}/immudex; git diff versions/base.sh) >> $FILE;
}
