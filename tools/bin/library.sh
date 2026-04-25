#!/bin/bash


#function help() {
#  echo "This script does noting. It's a collection of functions uses by";
#  echo "other tools, by import this file into it self. Man page for this script";
#  echo "can be usefull for describe above mentioned functions.";
#  echo;
#  echo "Notes:";
#  echo -e " get_debian_branch()   Can be used for convert Debian codename for Debian branch name\n";
#  echo -e " get_machine_arch()    Used for getting information is this 32 or 64-bit architecture.\n";
#  echo -e " check_distro_commit()   Is used for decide that you use a latest version immudex if there are commit ahead your image, this script returns 0, otherwise 1.\n";
#  echo -e " ascii_colors()        Prints immudex name in ASCII manuali.\n";
#  echo;
#  echo "Usage: source /usr/local/bin/library.sh";
#  echo;
#  echo "Options:";
#  echo "  There is no options...    Function help and version are used only for generate man page file and will be comment out after this.";
#  echo;
#  echo "Report bugs to <xf0r3m@gmail.com>";  
#}

#function version(){
#  echo "library.sh 1.0";
#  echo;
#  echo "Copyright (C) 2026 morketsmerke.org";
#  echo "This is free software; see the source for copying conditions.  There is NO";
#  echo "warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.";
#  echo;
#  echo "Written by xf0r3m.";
#}


function get_debian_branch() {
  if grep -q 'trixie' /etc/os-release; then
    echo "testing";
  elif grep -q 'bookworm' /etc/os-release; then
    echo "stable";
  else
    echo "oldstable";
  fi
}

function get_machine_arch() {
  arch=$(uname -m);
  if [ "$arch" = "i686" ]; then
    echo "32";
  else
    echo "64";
  fi
}

function check_distro_commit() {
  versionFile="/run/live/medium/live/version";
  if [ -f $versionFile ]; then
    localVersion=$(cat $versionFile);
    if [ -d /tmp/immudex ]; then
      $(cd /tmp/immudex && git pull -q);
    else
      git clone -q https://github.com/xf0r3m/immudex /tmp/immudex;
    fi
    latestVersion=$(cd /tmp/immudex && git log --pretty=oneline | head -1 | cut -d " " -f 1);
    if [ "$1" ] && [ "$1" == "--print" ]; then
      echo "$(cd /tmp/immudex && git log ${localVersion}..${latestVersion})";
    fi
    if [ "$localVersion" = "$latestVersion" ]; then
      return 0;
    else
      return 1;
    fi
  else
    return 255;
  fi
}

function ascii_colors() {

  BLUE="\e[1;94m";
  RED="\e[1;91m";
  CYAN="\e[1;96m";
  ENDCOLOR="\e[0m";

  echo -e "${BLUE} _                           ${RED}    _      ${CYAN}      ${ENDCOLOR}";
  echo -e "${BLUE}(_)_ __ ___  _ __ ___  _   _ ${RED} __| | ___${CYAN}__  __${ENDCOLOR}";
  echo -e "${BLUE}| | '_ \` _ \| '_ \` _ \| | | |${RED}/ _\` |/ _ \\\\${CYAN} \/ /${ENDCOLOR}";
  echo -e "${BLUE}| | | | | | | | | | | | |_| |${RED} (_| |  __/${CYAN}>  < ${ENDCOLOR}";
  echo -e "${BLUE}|_|_| |_| |_|_| |_| |_|\__,_|${RED}\__,_|\___/${CYAN}_/\_\\";
  echo -e "${ENDCOLOR}";

}

#if [ "$1" ]; then
#  if [ "$1" = "--help" ]; then
#    help;
#    exit 0;
#  elif [ "$1" = "--version" ]; then
#    version;
#    exit 0;
#  fi
#fi
