#!/bin/bash

version=$(echo $0 | cut -d "." -f 1);
if [ ! $version ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi;

dhclient;
sudo apt update;
sudo apt upgrade -y;

sudo cp /usr/bin/youtube-dl /usr/bin/youtube-dl-orig;
sudo wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/bin/youtube-dl;
sudo chmod +x /usr/bin/youtube-dl;

if [ ! -d ~/immudex ]; then
  cd;
  git clone https://github.com/xf0r3m/immudex;
fi

sudo cp -vv ~/immudex/tools/${version}/immudex_crypt /usr/local/bin;
sudo rm /usr/local/bin/ytaudio;
sudo cp -vv ~/immudex/tools/${version}/ytplay /usr/local/bin;
sudo cp -vv ~/immudex/tools/${version}/immudex_install /usr/local/bin;

sudo chmod +x /usr/local/bin;

echo "alias chhome=\"export HOME=\"\$(pwd)\"\"" >> /etc/bash.bashrc

rm -rf ~/immudex;
sudo apt-get clean;
echo > ~/.bash_history;
history -c;
