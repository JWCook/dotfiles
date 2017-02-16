#!/usr/bin/env bash

# Install compile dependencies for building vim from source on Fedora 25
# For other Fedora-based distros/ releases:
# https://www.rpmfind.net/linux/rpm2html/search.php?query=vim-enhanced
DEP_RPM=/tmp/vim-deps.rpm

wget  http://vault.centos.org/7.2.1511/os/Source/SPackages/vim-7.4.160-1.el7.src.rpm
wget -O $DEP_RPM /tmp/ ftp://195.220.108.108/linux/fedora/linux/updates/25/x86_64/v/vim-enhanced-8.0.160-1.fc25.x86_64.rpm
sudo dnf builddep -y $DEP_RPM
rm $DEP_RPM
