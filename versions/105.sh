#!/bin/bash

ARCH=$(dpkg --print-architecture);
cd
if [ -x /usr/bin/git ]; then git clone https://git.morketsmerke.org/git/immudex;
else apt install git && git clone https://git.morketsmerke.org/git/immudex
fi
source ~/immudex/versions/template.sh;

update_packages;

if [ $ARCH = "amd64" ]; then
  wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-118.0.1-1.en-US.linux-x86_64.tar.bz2;
  tar -xf -C /usr/lib;
  rm ;
else
  wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-118.0.1-1.en-US.linux-i686.tar.bz2;
  tar -xf librewolf-118.0.1-1.en-US.linux-i686.tar.bz2 -C /usr/lib;
  rm librewolf-118.0.1-1.en-US.linux-i686.tar.bz2;
fi
ln -s /usr/lib/librewolf/librewolf /usr/bin/librewolf;

tar -xf ~/immudex/files/${VERSION}/librewolf.tgz -C /etc/skel;

cp -vv ~/immudex/tools/${VERSION}/library.sh /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/motd2 /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/newsfeed /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/sync.sh /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/unlock-ds /usr/local/bin;

set_mime;

tidy;

