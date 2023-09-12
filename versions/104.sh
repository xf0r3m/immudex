#!/bin/bash

ARCH=$(dpkg --print-architecture);
cd
if [ -x /usr/bin/git ]; then git clone https://git.morketsmerke.org/git/immudex;
else apt install git && git clone https://git.morketsmerke.org/git/immudex
fi
source ~/immudex/versions/template.sh;

update_packages;

if [ $ARCH = "amd64" ]; then
  wget https://ftp.morketsmerke.org/immudex/stable/software/librewolf/librewolf-117.0-1.en-US.linux-x86_64.tar.bz2;
  tar -xf librewolf-117.0-1.en-US.linux-x86_64.tar.bz2 -C /usr/lib;
  rm librewolf-117.0-1.en-US.linux-x86_64.tar.bz2;
else
  wget https://ftp.morketsmerke.org/immudex/stable/software/librewolf/librewolf-117.0-1.en-US.linux-i686.tar.bz2;
  tar -xf librewolf-117.0-1.en-US.linux-i686.tar.bz2 -C /usr/lib;
  rm librewolf-117.0-1.en-US.linux-i686.tar.bz2;
fi
ln -s /usr/lib/librewolf/librewolf /usr/bin/librewolf;

cp -vv ~/immudex/files/${VERSION}/LibreWolf\ \(Firejailed\).desktop /etc/skel/Pulpit;
rm -v /etc/skel/Pulpit/Firefox.desktop;

cp -vv ~/immudex/files/${VERSION}/terminalrc /etc/skel/.config/xfce4/terminal;
cp -vv ~/immudex/files/${VERSION}/librewolf.desktop /usr/share/applications;
cp -vv ~/immudex/files/${VERSION}/gtk-main.css /usr/share/xfce4-notes-plugin/gtk-3.0;
tar -xf ~/immudex/files/${VERSION}/librewolf.tgz -C /etc/skel;

cp -vv ~/immudex/tools/${VERSION}/secured-firefox /usr/local/bin;

cp -vv ~/immudex/images/${VERSION}/lightdm_wallpaper.jpg /usr/share/images/desktop-base;
sed -i 's/abandoned_hospital_bower.png/lightdm_wallpaper.jpg/' /etc/lightdm/lightdm-gtk-greeter.conf;
rm -v /usr/share/images/desktop-base/abandoned_hospital_bower.png;
rm -v /usr/share/images/desktop-base/lofi_girl.jpg;
rm -v /usr/share/images/dektop-base/notes-background.jpg;
recreate_users;

set_mime;

tidy;

