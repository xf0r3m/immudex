#!/bin/bash

dhclient;
cd;
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex.git;
else apt install git -y && git clone https://github.com/xf0r3m/immudex.git;
fi

source ~/immudex/versions/template.sh;

upgrade_packages;
install_packages thunderbird gimp;

sudo cp -vv ~/immudex/tools/${VERSION}/* /usr/local/bin;
sudo chmod +x /usr/local/bin/*;

sudo cp -rvv ~/immudex/files/${VERSION}/launcher-33 /etc/skel/.config/xfce4/panel;
sudo cp -vv ~/immudex/files/${VERSION}/xfce4-panel.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml;

recreate_users;
set_notifier_packages;

tidy;
