#!/bin/bash

#0.0.1:
#	bash-completion
#	etherwake
#	wakeonlan
# cifs-utils
# wget
# figlet

sudo apt install bash-completion etherwake wakeonlan cifs-utils wget figlet;

if [ ! -d ~/immudex ]; then
  cd;
  git clone https://github.com/xf0r3m/immudex;
fi

sudo cp -v ~/immudex/tools/immudex_crypt /usr/local/bin;
sudo cp -v ~/immudex/tools/immudex_upgrade /usr/local/bin;
sudo cp -v ~/immudex/tools/import_sshkeys /usr/local/bin;
sudo cp -v ~/immudex/tools/motd /usr/local/bin;
sudo cp -v ~/immudex/tools/motd2 /usr/local/bin;
sudo cp -v ~/immudex/tools/padlock /usr/local/bin;

sudo chmod +x /usr/local/bin/*;

sudo cp -rv ~/immudex/launchers/launcher-29 /etc/skel/.config/xfce4/panel;
sudo cp -v ~/immudex/images/* /usr/share/images/desktop-base

sudo echo "/usr/local/bin/motd2" >> /etc/bash.bashrc;

sudo userdel -r user;
sudo userdel -r xf0r3m;
useradd -m -s /bin/bash user;
useradd -m -s /bin/bash xf0r3m;
echo "user:user1" | sudo chpasswd;
echo "xf0r3m:xf0r3m1" | sudo chpasswd;   
