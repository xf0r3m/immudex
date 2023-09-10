#!/bin/bash

ARCH=$(dpkg --print-architecture);
dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex.git;
else apt install git && git clone https://github.com/xf0r3m/immudex.git;
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
rm -v /etc/skel/Pulpit/Frefox.desktop;

recreate_users;

set_mime;

tidy;

