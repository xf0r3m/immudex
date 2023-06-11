#!/bin/bash

dhclient;
cd;
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex.git;
else apt install git -y && git clone https://github.com/xf0r3m/immudex.git;
fi

source ~/immudex/versions/template.sh;

update_packages;
install_packages rsync;

sudo cp -vv ~/immudex/tools/${VERSION}/* /usr/local/bin;
sudo chmod +x /usr/local/bin/*;

sudo cp -rvv ~/immudex/files/${VERSION}/meteo /usr/share;
sudo cp -rvv ~/immudex/files/${VERSION}/sync.sh /usr/share;

sudo cp -vv ~/immudex/files/${VERSION}/mimeapps.list /etc/skel/.config;

recreate_users;
set_notifier_packages;

tidy;
