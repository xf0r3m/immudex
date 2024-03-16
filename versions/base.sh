#!/bin/bash

set -e

DEBVER="$1";
ARCH=$(dpkg --print-architecture);

if [ $ARCH = "amd64" ]; then
  KARCH="amd64";
else
  KARCH="686-pae";
fi

cd;
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex;
else apt install git -y && git clone https://github.com/xf0r3m/immudex;

fi
source ~/immudex/versions/template.sh;

echo "deb http://deb.debian.org/debian/ ${DEBVER} main" > /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ ${DEBVER} main" >> /etc/apt/sources.list;
echo "deb http://security.debian.org/debian-security ${DEBVER}-security main" >> /etc/apt/sources.list;
echo "deb-src http://security.debian.org/debian-security ${DEBVER}-security main" >> /etc/apt/sources.list;
echo "deb http://deb.debian.org/debian/ ${DEBVER}-updates main" >> /etc/apt/sources.list;
echo "deb-src http://deb.debian.org/debian/ ${DEBVER}-updates main" >> /etc/apt/sources.list;
update_packages;


install_packages --no-install-recommends linux-image-${KARCH} live-boot systemd-sysv -y;

install_packages tzdata locales keyboard-configuration console-setup;

dpkg-reconfigure tzdata;
dpkg-reconfigure locales;
dpkg-reconfigure keyboard-configuration;
dpkg-reconfigure console-setup;

install_packages task-desktop task-xfce-desktop;

install_packages firejail ufw cryptsetup lsof extlinux grub-efi-amd64 efibootmgr bash-completion etherwake wakeonlan cifs-utils wget figlet mpv vim-gtk3 redshift irssi nmap nfs-common remmina python3-pip ffmpeg debootstrap squashfs-tools xorriso syslinux-efi grub-pc-bin grub-efi-amd64-bin mtools dosfstools chrony python3-venv isolinux rsync mutt gimp openvpn netselect-apt gvfs-backends dnsutils lolcat;

#Missing packages
if [ $DEBVER = "testing" ]; then
  install_packages xfce4-notes-plugin yt-dlp;
  head -1 /etc/apt/sources.list | sed "s/${DEBVER}/stable/" > /etc/apt/sources.list.d/stable.list;
  apt update;
  install_packages newsboat;
  rm /etc/apt/sources.list.d/stable.list;
  apt update;
else
  install_packages newsboat;
  head -1 /etc/apt/sources.list | sed "s/${DEBVER}/testing/" > /etc/apt/sources.list.d/testing.list;
  apt update;
  install_packages xfce4-notes-plugin yt-dlp;
  rm /etc/apt/sources.list.d/testing.list;
  apt update;
fi
if [ -f /usr/bin/youtube-dl ]; then rm /usr/bin/youtube-dl; fi
ln -s /usr/bin/yt-dlp /usr/bin/youtube-dl;

cd;

git clone https://github.com/xf0r3m/xfcedebian;
cd xfcedebian;
bash install.sh;

cd;

cp -vv ~/immudex/tools/bin/immudex-autostart-x4notes /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-branch /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-import-gpgkeys /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-import-sshkeys /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-meteo /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-morketsmerke /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-motd2 /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-padlock /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-pl /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-secured-firefox /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-shoutcasts /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-version /usr/local/bin;
cp -vv ~/immudex/tools/bin/immudex-ytplay /usr/local/bin;
cp -vv ~/immudex/tools/bin/library.sh /usr/local/bin;
cp -vv ~/immudex/tools/bin/idle-clic /usr/local/bin;
cp -vv ~/immudex/tools/bin/sync.sh /usr/local/bin;
chmod +x /usr/local/bin/*;

cp -vv ~/immudex/tools/sbin/immudex-create-media /usr/local/sbin;
cp -vv ~/immudex/tools/sbin/immudex-crypt /usr/local/sbin;
cp -vv ~/immudex/tools/sbin/immudex-hostname /usr/local/sbin;
cp -vv ~/immudex/tools/sbin/immudex-install /usr/local/sbin;
cp -vv ~/immudex/tools/sbin/immudex-upgrade /usr/local/sbin;
chown root:root /usr/local/sbin/*;
chmod 544 /usr/local/sbin/*;

mkdir /etc/skel/.irssi

cp -vv ~/immudex/files/config /etc/skel/.irssi;
cp -vv ~/immudex/files/default.theme /etc/skel/.irssi;
cp -rvv ~/immudex/files/libreoffice /etc/skel/.config;
cp -vv ~/immudex/files/firejail.config /etc/firejail;
cp -vv ~/immudex/files/redshift.conf /etc/skel/.config;
cp -vv ~/immudex/files/redshift.desktop /etc/skel/.config/autostart;

cp -rvv ~/immudex/files/sync.sh /usr/share;
cp -vv ~/immudex/files/gtk-main.css /usr/share/xfce4-notes-plugin/gtk-3.0/;
if [ -f /usr/share/applications/qmmp.desktop ]; then
  ln -s /usr/share/applications/qmmp.desktop /usr/share/applications/qmmp-1.desktop;
fi
cp -vv ~/immudex/files/immudex_hostname.service /etc/systemd/system;

tar -xf ~/immudex/files/mozilla.tgz -C /etc/skel;

cp -vv ~/immudex/launchers/16844254192.desktop /etc/skel/.config/xfce4/panel/launcher-5;

systemctl enable immudex_hostname.service;

cat >> /etc/bash.bashrc << EOL
if [ ! -f /tmp/.motd ]; then
/usr/local/bin/immudex-motd2
touch /tmp/.motd;
fi
EOL

echo "alias immudex-chhome='export HOME=\$(pwd)'" >> /etc/bash.bashrc;
echo "alias immudex-changelogs='immudex-upgrade --check --print'" >> /etc/bash.bashrc;
echo "alias immudex-version='immudex-upgrade --myversion'" >> /etc/bash.bashrc;

chmod u+s /usr/bin/ping;

/usr/sbin/ufw default deny incoming;
/usr/sbin/ufw default allow outgoing;
#/usr/sbin/ufw enable;
sed -i '/^ENABLED=/s/ENABLED=no/ENABLED=yes/' /etc/ufw/ufw.conf

echo "immudex" > /etc/hostname;
echo "127.0.1.1   immudex" >> /etc/hosts;

# Zmiany można umieścić również tutaj jeśli dotyczą one użytkowników lub ich
# plików konfiguracyjnych

echo -n "Username: ";
read username;
useradd -m -s /bin/bash $username;
cp -r /etc/skel/.??* /home/${username};
chown -R ${username}:${username} /home/${username};
passwd $username;
usermod -aG sudo $username;


dd if=/dev/random bs=1M of=random count=1;
rootPassword=$(md5sum random | awk '{printf $1}');
rm random;
echo "root:${rootPassword}" | chpasswd;
usermod -L root;

# Miejsce na twoje zmiany, przed poleceniem 'tidy'
tidy;
