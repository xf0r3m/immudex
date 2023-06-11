#!/bin/bash

#0.0.1:
#	bash-completion
#	etherwake
#	wakeonlan
# cifs-utils
# wget
# figlet

version=$(echo $0 | cut -d "." -f 1);
if [ ! "$version" ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi;

dhclient
sudo apt update
sudo apt upgrade -y

sudo apt install -y bash-completion etherwake wakeonlan cifs-utils wget figlet;

if [ ! -d ~/immudex ]; then
  cd;
  git clone https://github.com/xf0r3m/immudex;
fi

sudo cp -v ~/immudex/tools/${version}/immudex_crypt /usr/local/bin;
sudo cp -v ~/immudex/tools/${version}/immudex_upgrade /usr/local/bin;
sudo cp -v ~/immudex/tools/${version}/import_sshkeys /usr/local/bin;
sudo cp -v ~/immudex/tools/${version}/motd /usr/local/bin;
sudo cp -v ~/immudex/tools/${version}/motd2 /usr/local/bin;
sudo cp -v ~/immudex/tools/${version}/padlock /usr/local/bin;

sudo chmod +x /usr/local/bin/*;

sudo cp -rv ~/immudex/launchers/${version}/launcher-29 /etc/skel/.config/xfce4/panel;
sudo cp -v ~/immudex/files/${version}/xfce4-panel.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml;
sudo cp -v ~/immudex/images/${version}/* /usr/share/images/desktop-base;

sudo echo "/usr/local/bin/motd2" >> /etc/bash.bashrc;

sudo userdel -r user;
sudo userdel -r xf0r3m;
useradd -m -s /bin/bash user;
useradd -m -s /bin/bash xf0r3m;
echo "user:user1" | sudo chpasswd;
echo "xf0r3m:xf0r3m1" | sudo chpasswd;

rm -rf ~/immudex;
apt-get clean;
echo > ~/.bash_history;
history -c   
