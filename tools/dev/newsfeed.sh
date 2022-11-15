#!/bin/bash

if [ ! -s ~/.newsfeed ]; then
  #help!
  echo;
  exit 1;
else
  amountOfSubscriptions=$(cat ~/.newsfeed | wc -l);
  i=1;
  while [ $i -le $amountOfSubscriptions ]; do
    newsfeedLine=$(sed -n "${i}p" ~/.newsfeed);
    nameOfSubscription=$(echo $newsfeedLine | cut -d ";" -f 1);
    rssLink=$(echo $newsfeedLine | cut -d ";" -f 2);
    if [ "$1" ] && ([ "$1" = "--list" ] || [ "$1" = "--check" ]); then
      echo -e "${i}. ${nameOfSubscription}";
    elif [ "$1" ] && [ "$1" = "--check" ]; then
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
          amountOfNews=$(sed 's/<\/title>/\n/g' /tmp/newsfeed_${i}.xml | sed 's/<item>/\n/g' | grep '<title>' | wc -l)
        fi
        notify-send "$nameOfSubscription" "New $amountOfNews newses" --icon=applications-internet;
      fi
    fi
    i=$((i + 1));
  done
  if [ "$1" ] && [ "$1" = "--show" ] && [ "$2" ] && [ $2 -gt 0 ]; then
      sed 's/<\/title>/\n/g' /tmp/newsfeed_${2}.xml | sed 's/<item>/\n/g' | grep '<title>' | sed -n '2,$p' | sed 's/<title>//' | cat -n | less;
      echo $2 > /tmp/lastShowedNewsFeed;
  elif [ "$1" ] && [ "$1" = "--open" ] && [ "$2" ] && [ $2 -gt 0 ]; then
      subscriptionNumber=$(cat /tmp/lastShowedNewsFeed);
      link=$(sed 's/<\/link>/\n/g' /tmp/newsfeed_${subscriptionNumber}.xml | sed 's/<\/title>/\n/g' | grep '<link>' | sed -n '2,$p' | sed 's/<link>//g' | sed -n "${2}p")
      exo-open --launch WebBrowser "$link";
  fi
fi
