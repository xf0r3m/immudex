#!/bin/bash

function help() {
  echo "newsfeed - fetch and browse news feed from rss and atom channels";
  echo "morketsmerke.net; COPYLEFT 2022";
  echo "Options:";
  echo "  --list - shows numbered list of names, saved in ~/.newsfeed names na URL of rrs channels";
  echo "  --check - fetching new rss channel file from source";
  echo "  --show <number_of_channel> - shows numbered list of news titles. Number of channel you can get from --list option.";
  echo "  --open <number_of_title> - open web browser on link, which are under titles of news on rss channel. Number of title you can get from --show option. This option based on the last showed rss channel feed.";
  echo "The ~/.newsfeed file:";
  echo "This file is simple csv (semicolon separated values) database which store rss channels in one line. One by one. The one line contains: name and URL of rss feed.";
} 
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
    if [ "$1" ] && [ "$1" = "--list" ]; then
      echo -e "${i}. ${nameOfSubscription}";
    elif [ "$1" ] && [ "$1" = "--check" ]; then
      echo -e "${i}. ${nameOfSubscription}";
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
    
    #Parsing
    #Thanks to the linuxhint.com for command:
    #sed 's/^[[:space]]*//g'
    #https://linuxhint.com/trim_string_bash

      if grep -q 'CDATA' /tmp/newsfeed_${2}.xml; then
        sed 's/<\/title>/\n/g' /tmp/newsfeed_${2}.xml | \
        sed 's/<item>/\n/g' | grep '<title>' | sed -n '2,$p' | \
        sed 's/<title>//' | sed 's/&quot;/"/g' | \
        sed 's/<!\[CDATA\[//g' | sed 's/\]\]>//g' | \
        sed 's/^[[:space:]]*//g' | nl | less;
      else 
        sed 's/<\/title>/\n/g' /tmp/newsfeed_${2}.xml | \
        sed 's/<item>/\n/g' | grep '<title>' | sed -n '2,$p' | \
        sed 's/<title>//' | sed 's/&quot;/"/g' | \
        sed 's/^[[:space:]]*//g' | nl | less;
      fi
      echo $2 > /tmp/lastShowedNewsFeed;
  elif [ "$1" ] && [ "$1" = "--open" ] && [ "$2" ] && [ $2 -gt 0 ]; then
      subscriptionNumber=$(cat /tmp/lastShowedNewsFeed);
      link=$(sed 's/<\/link>/\n/g' /tmp/newsfeed_${subscriptionNumber}.xml | sed 's/<\/title>/\n/g' | grep '<link>' | sed -n '2,$p' | sed 's/<link>//g' | sed -n "${2}p")
      exo-open --launch WebBrowser "$link";
  fi
fi
