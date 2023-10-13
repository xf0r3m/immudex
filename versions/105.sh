#!/bin/bash

ARCH=$(dpkg --print-architecture);
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex;
else apt install git && git clone https://github.com/xf0r3m/immudex;
fi
source ~/immudex/versions/template.sh;

update_packages;

if [ $ARCH = "amd64" ]; then
  wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-118.0.1-1.en-US.linux-x86_64.tar.bz2;
  tar -xf librewolf-118.0.1-1.en-US.linux-x86_64.tar.bz2 -C /usr/lib;
  rm librewolf-118.0.1-1.en-US.linux-x86_64.tar.bz2;
else
  wget https://ftp.morketsmerke.org/immudex/testing/software/librewolf/librewolf-118.0.1-1.en-US.linux-i686.tar.bz2;
  tar -xf librewolf-118.0.1-1.en-US.linux-i686.tar.bz2 -C /usr/lib;
  rm librewolf-118.0.1-1.en-US.linux-i686.tar.bz2;
fi
#ln -s /usr/lib/librewolf/librewolf /usr/bin/librewolf;

tar -xf ~/immudex/files/${VERSION}/librewolf.tgz -C /etc/skel;

cp -vv ~/immudex/tools/${VERSION}/library.sh /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/motd2 /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/newsfeed /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/sync.sh /usr/local/bin;
chmod +x /usr/local/bin/*

recreate_users;
set_mime;

tidy;

