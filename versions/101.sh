#!/bin/bash

dhclient;
cd
if [ -x /usr/bin/git ]; then git clone https://github.com/xf0r3m/immudex.git;
else apt install git && git clone https://github.com/xf0r3m/immudex.git;
fi
source ~/immudex/versions/template.sh;

update_packages;
install_packages mutt;

cp -vv ~/immudex/tools/${VERSION}/immudex_branch /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/import_gpgkeys /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/library.sh /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/immudex_hostname /usr/local/bin;
cp -vv ~/immudex/tools/${VERSION}/newsfeed /usr/local/bin; 
cp -vv ~/immudex/tools/${VERSION}/pl /usr/local/bin;

apt remove thunderbird;
rm -vf /etc/skel/Pulpit/Klient\ poczty\ Thunderbird.desktop;
rm -vf /usr/local/bin/run-thunderbird;
recreate_users;

set_mime;

tidy;

