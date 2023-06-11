#!/bin/bash


version=$(echo $0 | cut -d "." -f 1);
if [ ! "$version" ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi;

dhclient
sudo apt update;
sudo apt upgrade -y;
sudo apt install -y chirp mpv youtube-dl;

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

if [ ! -d ~/immudex ]; then
  cd;
  git clone https://github.com/xf0r3m/immudex;
fi

sudo cp ~/immudex/tools/${version}/motd2 /usr/local/bin
sudo cp ~/immudex/tools/${version}/padlock /usr/local/bin
sudo cp ~/immudex/tools/${version}/import_gpgkeys /usr/local/bin
sudo cp ~/immudex/tools/${version}/shoutcasts /usr/local/bin
sudo cp ~/immudex/tools/${version}/ytaudio /usr/local/bin
sudo cp ~/immudex/tools/immudex_install /usr/local/bin

chmod +x /usr/local/bin/*

sudo sed -i -e 's/chirpw/sudo chirpw/' -e 's/false/true/' /usr/share/applications/chirp.desktop;

rm -rf ~/immudex;
sudo apt-get clean;
echo > ~/.bash_history;
history -c;
