#!/bin/bash

sudo apt update;
sudo apt upgrade -y;

lineNumber=$(cat -n /etc/bash.bashrc | grep 'motd2' | awk '{printf $1}');
if [ "$lineNumber" ]; then
  sed -i "${lineNumber}d" /etc/bash.bashrc;
fi

echo "if [ ! -f /tmp/.motd ]; then" >> /etc/bash.bashrc;
echo "  /usr/local/bin/motd2;" >> /etc/bash.bashrc;
echo "  touch /tmp/.motd;" >> /etc/bash.bashrc;
echo "fi;" >> /etc/bash.bashrc;

sudo usermod -aG libvirt,libvirt-qemu user;
sudo usermod -aG libvirt,libvirt-qemu xf0r3m;

sudo chmod u+s /usr/bin/ping

sudo cp ~/immudex/tools/002/motd2 /usr/local/bin
sudo cp ~/immudex/tools/002/import_gpgkeys /usr/local/bin
sudo cp ~/immudex/tools/002/shoutcasts /usr/local/bin

chmod +x /usr/local/bin/*

sudo apt install chirp;

sudo apt-get clean;
echo > ~/.bash_history;
history -c;
