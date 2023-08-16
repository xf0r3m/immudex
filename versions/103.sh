#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex.git;
else apt install git && git clone https://github.com/xf0r3m/immudex.git;
fi
source ~/immudex/versions/template.sh;

update_packages;
apt purge -y xpra;

cp -vv ~/immudex/tools/${VERSION}/pl /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/idle-clic /usr/local/bin;

wget https://github.com/yt-dlp/yt-dlp/releases/download/2023.07.06/yt-dlp -O /usr/bin/yt-dlp;

cp -vv ~/immudex/files/${VERSION}/xfce4-keyboard-shortcuts.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml;
cp -vv ~/immudex/files/${VERSION}/xfwm4.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml;

recreate_users;

set_mime;

tidy;

