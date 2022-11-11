#!/bin/bash

version=$(echo $0 | cut -d "." -f 1);
if [ ! $version ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi

dhclient;
sudo apt update;
sudo apt upgrade -y;

sudo apt install -y libssl-dev libbz2-dev libnss3-dev libgdbm-dev libncurses5-dev libffi-dev libreadline-dev libsqlite3-dev zlib1g-dev build-essential

sudo apt install --no-install-recommends software-properties-common -y

sudo ln -s /etc/libvirt/qemu/networks/default.xml /etc/libvirt/qemu/networks/autostart/default.xml;

cd;
sudo wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tar.xz -O Python-3.11.0.tar.xz;
sudo tar -xvf Python-3.11.0.tar.xz;
cd Python-3.11.0;

sudo ./configure --prefix=/usr/local --enable-optimizations
sudo make
sudo make altinstall

sudo sed -i '26s/1/0/' /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml;
sudo sed -i '64i\\t<property name="disable-struts" type="bool" value="false"/>' /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml;

echo 'alias ytstream="mpv --ytdl-format=best[height=480]"' >> /etc/bash.bashrc;

sudo userdel -r user;
sudo userdel -r xf0r3m;
sudo useradd -m -s /bin/bash user;
sudo useradd -m -s /bin/bash xf0r3m;
echo 'user:user1' | sudo chpasswd user;
echo 'xf0r3m:xf0r3m1' | sudo chpasswd xf0r3m;
sudo usermod -aG libvirt,libvirt-qemu user;
sudo usermod -aG libvirt,libvirt-qemu xf0r3m;

if [ ! -d ~/immudex ]; then
  cd;
  git clone https://github.com/xf0r3m/immudex;
fi

sudo cp -vv ~/immudex/tools/${version}/protected /usr/local/bin;
chmod +x /usr/local/bin/protected;

rm -rf ~/immudex;
rm -rf ~/Python*;
sudo apt remove -y libssl-dev libbz2-dev libnss3-dev libgdbm-dev libncurses5-dev libffi-dev libreadline-dev libsqlite3-dev zlib1g-dev build-essential software-properties-common;
sudo apt autoclean;
sudo apt-get clean;
sudo apt-get clean;
echo > ~/.bash_history;
history -c
