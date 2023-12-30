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
  wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-121.0-1.en-US.linux-x86_64.tar.bz2;
  tar -xf librewolf-121.0-1.en-US.linux-x86_64.tar.bz2 -C /usr/lib;
  rm librewolf-121.0-1.en-US.linux-x86_64.tar.bz2;
else
  wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-121.0-1.en-US.linux-i686.tar.bz2;
  tar -xf librewolf-121.0-1.en-US.linux-i686.tar.bz2 -C /usr/lib;
  rm librewolf-121.0-1.en-US.linux-i686.tar.bz2;
fi

update-alternatives --remove x-www-browser /usr/bin/firefox-esr;
update-alternatives --install /usr/bin/x-www-browser x-www-browser /usr/lib/librewolf/librewolf 70;

set_mime;

tidy;

