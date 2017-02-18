#!/bin/bash

HEADLESS=0
DEV=0

function ask {
  Q=$1
  VAR=$2
  while true ; do
    echo "${Q} [y/n]"
    read -sn 1 a
    if [ "y" == "${a}" ] ; then
      eval $VAR=1
      break
    fi
    if [ "n" == "${a}" ] ; then
      eval $VAR=0
      break
    fi
  done 
}

ask "Is this machine headless?" HEADLESS
ask "Is this a dev machine ?" DEV

sudo apt-get update
sudo apt-get dist-upgrade -y
echo "set -o vi" >> ~/.bashrc
echo "export EDITOR=vi" >> ~/.bashrc

if [ ${DEV} -eq 1 ] ; then
  sudo apt-get install -y tmux git 
  
  git config --global user.email "manzato@gmail.com"
  git config --global user.name "Guillermo Manzato"

  if [ ${HEADLESS} -eq 0 ] ; then
    wget https://atom.io/download/deb -O /tmp/atom.deb
    sudo dpkg -i /tmp/atom.deb
    sudo apt-get install -f
  fi
fi

if [ ${HEADLESS} -eq 0 ] ; then
  sudo apt-get install -y indicator-multiload indicator-cpufreq
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
  sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
  sudo apt-get install -f
fi

