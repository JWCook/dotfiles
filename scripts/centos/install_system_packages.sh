#!/usr/bin/env bash

# Repos
read -d '' REPO_RPMS << EOF
    http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
    http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
    ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/KAMiKAZOW:/Fedora/CentOS_7/noarch/gdouros-symbola-fonts-8.00-5.1.noarch.rpm
    https://centos7.iuscommunity.org/ius-release.rpm
    epel-release
EOF

# Package categories
PKGS_APPS='figlet fortune gedit gimp git htop inkscape nmap ntp p7zip pv ssh shutter telnet terminator tig toilet tree tmux wget'
PKGS_DEV='npm ruby-devel rubygems java-1.8.0-openjdk'
PKGS_LIBS='gcc gcc-c++ libffi-devel libxml2-devel libxslt-devel libX11-devel ncurses-devel ntfsprogs openssl-develphp-devel xdg-utils xz-libs zlib-devel bzip2-devel yum-utils'
PKGS_MEDIA='vlc libdvdcss x265 gstreamer-ffmpeg gstreamer-plugins-base gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly'
PKGS_PYTHON='python-pip python-devel python3-devel python3-pip python3-wheel python35u-devel python35u-libs'

# Desktop environment-specific packages
PKGS_GNOME='gnome-tweak-tool gnome-shell-extension-user-theme gnome-shell-browser-plugin alacarte'

# Install packages
sudo rpm --import $REPO_KEYS
sudo yum install -y $REPO_RPMS
sudo yum update -y
sudo yum install -y $PKGS_APPS $PKGS_MEDIA $PKGS_PYTHON $PKGS_DEV $PKGS_LIBS
sudo yum install -y $PKGS_GNOME

# Install pip3 (base repo version of python3.5-pip is broken)
curl https://bootstrap.pypa.io/get-pip.py | sudo python3.5
