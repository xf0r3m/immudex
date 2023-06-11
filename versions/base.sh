#!/bin/bash

dhclient;
cd;
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex;
else apt install git -y && git clone https://github.com/xf0r3m/immudex;

fi
export VERSION=100;
source ~/immudex/versions/template.sh;

echo "deb http://deb.debian.org/debian/ stable main" > /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ stable main" >> /etc/apt/sources.list;
echo "deb http://security.debian.org/debian-security stable-security main" >> /etc/apt/sources.list;
echo "deb-src http://security.debian.org/debian-security stable-security main" >> /etc/apt/sources.list;
echo "deb http://deb.debian.org/debian/ stable-updates main" >> /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ stable-updates main" >> /etc/apt/sources.list;
update_packages;


if [ $(uname -m) = "x86_64" ]; then
install_packages --no-install-recommends linux-image-amd64 live-boot systemd-sysv -y;
else
install_packages --no-install-recommends linux-image-686-pae live-boot systemd-sysv -y;
fi

install_packages tzdata locales keyboard-configuration console-setup;

dpkg-reconfigure tzdata;
dpkg-reconfigure locales;
dpkg-reconfigure keyboard-configuration;
dpkg-reconfigure console-setup;

install_packages task-desktop task-xfce-desktop;

install_packages firejail ufw cryptsetup lsof extlinux grub-efi-amd64 efibootmgr bash-completion etherwake wakeonlan cifs-utils wget figlet mpv youtube-dl vim-gtk3 redshift irssi nmap nfs-common remmina python3-pip ffmpeg debootstrap squashfs-tools xorriso syslinux-efi grub-pc-bin grub-efi-amd64-bin mtools dosfstools chrony python3-venv isolinux rsync thunderbird gimp openvpn netselect-apt gvfs-backends;

head -1 /etc/apt/sources.list | tee /etc/apt/sources.list.d/xfce4-notes-plugin.list;
sed -i 's/stable/experimental/' /etc/apt/sources.list.d/xfce4-notes-plugin.list;
apt update;
apt install xfce4-notes-plugin -y;
rm /etc/apt/sources.list.d/xfce4-notes-plugin.list;
apt update;

cd;

git clone https://github.com/xf0r3m/xfcedebian;
cd xfcedebian;
bash install.sh;

cd;

cp -vv ~/immudex/tools/${VERSION}/* /usr/local/bin;
chmod +x /usr/local/bin/*;

mkdir /etc/skel/.irssi

cp -vv ~/immudex/files/${VERSION}/config /etc/skel/.irssi;
cp -vv ~/immudex/files/${VERSION}/default.theme /etc/skel/.irssi;
cp -rvv ~/immudex/files/${VERSION}/libreoffice /etc/skel/.config;
cp -vv ~/immudex/files/${VERSION}/firejail.config /etc/firejail;
cp -vv ~/immudex/files/${VERSION}/Notifier\ -\ distro.desktop /etc/skel/.config/autostart;
cp -vv ~/immudex/files/${VERSION}/redshift.conf /etc/skel/.config;
cp -vv ~/immudex/files/${VERSION}/redshift.desktop /etc/skel/.config/autostart;
cp -vv ~/immudex/files/${VERSION}/Klient\ poczty\ Thunderbird.desktop /etc/skel/Pulpit;
cp -vv ~/immudex/files/${VERSION}/terminalrc /etc/skel/.config/xfce4/terminal;
cp -vv ~/immudex/files/${VERSION}/mimeapps.list /etc/skel/.config;
cp -vv ~/immudex/files/${VERSION}/conkyrc /etc/skel/.conkyrc;
cp -vv ~/immudex/files/${VERSION}/gtk-main.css /usr/share/xfce4-notes-plugin/gtk-3.0/;
cp -vv ~/immudex/files/${VERSION}/immudex_hostname.service /etc/systemd/system;

tar -xzvf ~/immudex/files/${VERSION}/mozilla.tgz -C /etc/skel;
cp -vv ~/immudex/images/${VERSION}/apply.png /usr/share/icons;
cp -vv ~/immudex/images/${VERSION}/rss.png /usr/share/icons;
cp -vv ~/immudex/images/${VERSION}/notes-background.jpg /usr/share/images/desktop-base;

rm /usr/share/images/desktop-base/no_trespass_abandon.jpeg;
systemctl enable immudex_hostname.service;

cat >> /etc/bash.bashrc << EOL
if [ ! -f /tmp/.motd ]; then
/usr/local/bin/motd2
touch /tmp/.motd;
fi
EOL

echo "alias chhome='export HOME=\\\$(pwd)'" >> /etc/bash.bashrc;
echo "alias ytstream='mpv --ytdl-format=best[heigth=480]'" >> /etc/bash.bashrc;

chmod u+s /usr/bin/ping;

/usr/sbin/ufw default deny incoming;
/usr/sbin/ufw default allow outgoing;
/usr/sbin/ufw enable;

echo "immudex" > /etc/hostname;
echo "127.0.1.1   immudex" >> /etc/hosts;

recreate_users;
echo "user ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
echo "xf0r3m ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers;
set_notifier_packages;
set_xfce4_notes_autostart;

tidy;
