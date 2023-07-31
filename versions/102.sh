#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex.git;
else apt install git && git clone https://github.com/xf0r3m/immudex.git;
fi
source ~/immudex/versions/template.sh;

update_packages;

cp -vv ~/immudex/tools/${VERSION}/create_media /usr/local/bin; 
cp -vv ~/immudex/tools/${VERSION}/pl /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/immudex_hostname /usr/local/bin;

cp -vv ~/immudex/files/${VERSION}/xfce4-keyboard-shortcuts.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml;
cp -vv ~/immudex/files/${VERSION}/whiskermenu-1.rc /etc/skel/.config/xfce4/panel;
recreate_users;

set_default_wallpaper altai_1920x1080.png;

set_mime;

tidy;

