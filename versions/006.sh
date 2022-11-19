#!/bin/bash

version=$(echo $0 | cut -d "." -f 1);
if [ ! $version ]; then echo -e "\e[31mUpdate failed!\e[0m"; exit 1; fi

sudo cp -vv ~/immudex/files/${version}/rss.png /usr/share/icons;
sudo cp -vv ~/immudex/tools/${version}/newsfeed /usr/local/bin;
sudo chmod +x /usr/local/bin/newsfeed;
