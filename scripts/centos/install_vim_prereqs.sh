#!/usr/bin/env bash

# Install compile dependencies for building vim from source on Centos 7
# For other Fedora-based distros/ releases:
# https://www.rpmfind.net/linux/rpm2html/search.php?query=vim-enhanced
wget -p /tmp/ http://vault.centos.org/7.2.1511/os/Source/SPackages/vim-7.4.160-1.el7.src.rpm
sudo yum-builddep -y /tmp/vim-7.4.160-1.el7.src.rpm
rm /tmp/vim-7.4.160-1.el7.src.rpm
sudo git clone https://github.com/vim/vim /usr/local/src/vim
