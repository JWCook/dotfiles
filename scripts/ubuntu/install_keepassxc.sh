#!/bin/bash
DEB_FILE=/tmp/keepassxc.deb
wget -O $DEB_FILE https://github.com/magkopian/keepassxc-debian/releases/download/2.2.1-1/keepassxc_2.2.1-1_amd64_ubuntu_16.04_xenial.deb
sudo apt-get install -y $DEB_FILE
rm $DEB_FILE
