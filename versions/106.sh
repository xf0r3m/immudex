#!/bin/bash

ARCH=$(dpkg --print-architecture)
dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex.git;
else apt install git && git clone https://github.com/xf0r3m/immudex.git;
fi
source ~/immudex/versions/template.sh;

update_packages;

if [ $ARCH = "amd64" ]; then
  wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-119.0.1-1.en-US.linux-x86_64.tar.bz2;
  tar -xf librewolf-119.0.1-1.en-US.linux-x86_64.tar.bz2 -C /usr/lib;
  rm librewolf-119.0.1-1.en-US.linux-x86_64.tar.bz2;
else
  wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-119.0.1-1.en-US.linux-i686.tar.bz2;
  tar -xf librewolf-119.0.1-1.en-US.linux-i686.tar.bz2 -C /usr/lib;
  rm librewolf-119.0.1-1.en-US.linux-i686.tar.bz2;
fi

tar -xf ~/immudex/files/${VERSION}/librewolf.tgz -C /etc/skel;

update-alternatives --remove x-www-browser /usr/bin/firefox-esr;
update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/lib/librewolf/librewolf 70;

cp -vv ~/immudex/files/${VERSION}/vimrc /etc/skel/.vimrc;

cp -vv ~/immudex/tools/${VERSION}/newsfeed /usr/local/bin;
chmod +x /usr/local/bin/newsfeed;

recreate_users;

set_mime;

tidy;

