#!/bin/bash

set -e;

if [ "$1" = "64" ]; then
  apt install --no-install-recommends linux-image-amd64 live-boot systemd-sysv -y;
else
  apt install --no-install-recommends linux-image-686-pae live-boot systemd-sysv -y;
fi

apt install -y tzdata locales keyboard-configuration console-setup
dpkg-reconfigure tzdata;
dpkg-reconfigure locales;
dpkg-reconfigure keyboard-configuration;
dpkg-reconfigure console-setup;
apt install -y task-desktop task-xfce-desktop;
apt install -y git vim firejail ufw cryptsetup lsof extlinux grub-efi-amd64 efibootmgr;
cd;
git clone https://github.com/xf0r3m/xfcedebian.git;
cd xfcedebian;
chmod +x install.sh;
bash install.sh;
cd;
git clone https://github.com/xf0r3m/immudex.git;
cd immudex;
tar -xzvf mozilla.tgz -C /etc/skel;
chown -R root:root /etc/skel/.mozilla;
cp tools/immudex_install /usr/local/bin;
cp tools/protected /usr/local/bin;
chmod +x /usr/local/bin/*;
cp launchers/16608166085.desktop /etc/skel/.config/xfce4/panel/launcher-19/
ufw default deny incoming;
ufw default allow outgoing;
ufw enable;
useradd -m -s /bin/bash xf0r3m;
echo "xf0r3m:xf0r3m1" | chpasswd;
useradd -m -s /bin/bash user;
echo "user:user1" | chpasswd;
echo "xf0r3m ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "root:toor" | chpasswd;
usermod -aG libvirt,libvirt-qemu xf0r3m;
usermod -aG libvirt,libvirt-qemu user;
echo "immudex" > /etc/hostname;
echo "127.0.1.1    immudex" >> /etc/hosts;
echo "deb http://ftp.icm.edu.pl/pub/Linux/debian/ bullseye main" > /etc/apt/sources.list;
echo "deb-src http://ftp.icm.edu.pl/pub/Linux/debian/ bullseye main" >> /etc/apt/sources.list;
echo "deb http://security.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list;
echo "deb-src http://security.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list;
echo "deb http://ftp.icm.edu.pl/pub/Linux/debian/ bullseye-updates main" >> /etc/apt/sources.list;
echo "deb-src http://ftp.icm.edu.pl/pub/Linux/debian/ bullseye-updates main" >> /etc/apt/sources.list;
apt update;
apt upgrade -y;
cd;
rm -rf immudex/
rm -rf xfcedebian/
apt-get clean
echo > ~/.bash_history
history -c
