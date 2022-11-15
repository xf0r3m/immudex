#!/bin/bash

if [ -e ~/.newsfeed ] && [ -s ~/.newsfeed ]; then
  amountOfSubscriptions=$(cat ~/.newsfeed | wc -l);
  i=1;
  while [ $i -le $amountOfSubscriptions ]; do
    newsfeedLine=$(sed -n "${i}p" ~/.newsfeed);
    nameOfSubscription=$(echo $newsfeedLine | cut -d ";" -f 1);
    rssLink=$(echo $newsfeedLine | cut -d ";" -f 2);
    echo -e "${i}. ${nameOfSubscription}\n\t${rssLink}";
    echo -n "Getting news feed...";
    wget $rssLink -O /tmp/new_newsfeed_${i}.xml 2>/dev/null;
    if [ $? -eq 0 ]; then echo "[ OK ]"; fi
    if [ -e /tmp/newsfeed_${i}.xml ] && [ -s /tmp/newsfeed_${i}.xml ]; then
      echo;
    else
      mv /tmp/new_newsfeed_${i}.xml /tmp/newsfeed_${i}.xml;
      amountOfNews=$(grep 'title' /tmp/newsfeed_${i}.xml | sed -n '2,$p' | wc -l);
      if [ $amountOfNews -eq 0 ]; then
        compressed=1;
        amountOfNews=$(sed 's/<\/title>/\n/g' /tmp/newsfeed_${i}.xml | sed 's/<item>/\n/g' | grep 'title' | wc -l)
      fi
      notify-send "$nameOfSubscription" "New $amountOfNews newses" --icon=applications-internet;
    fi
    i=$((i + 1));
  done
else
  echo "There is no file with news feed links";
fi
