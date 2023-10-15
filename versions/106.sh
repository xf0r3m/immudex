#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex.git;
else apt install git && git clone https://github.com/xf0r3m/immudex.git;
fi
source ~/immudex/versions/template.sh;

update_packages;

cp -vv ~/immudex/files/${VERSION}/vimrc /etc/skel/.vimrc;

recreate_users;

set_mime;

tidy;

