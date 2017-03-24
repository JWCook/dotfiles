#!/usr/bin/env bash
# TODO: use pyenv to manage multiple python versions

# Package categories
PKGS_APPS='chromium duplicity duply figlet fortune gedit gimp git htop inkscape keepassx nmap ntp p7zip pv shutter telnet terminator tig toilet tree tmux wget'
PKGS_DEV='lua-devel npm php-devel ruby-devel rubygems java-1.8.0-openjdk'
PKGS_LIBS='ctags gcc gcc-c++ libffi-devel libxml2-devel libxslt-devel libX11-devel ncurses-devel ntfsprogs openssl-devel rpm-build redhat-rpm-config tcl-devel xdg-utils xz-libs zlib-devel bzip2-devel yum-utils'
PKGS_MEDIA='vlc x265 gstreamer-ffmpeg gstreamer-plugins-base gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly'
PKGS_PYTHON='python-devel python3-devel python3-wheel python35u-devel python36u-devel'
PKGS_OTHER='fortune fortune-mod toilet'

# Desktop environment-specific packages
PKGS_GNOME='dconf-editor gnome-tweak-tool gnome-shell-extension-user-theme gnome-shell-browser-plugin alacarte'

# Install packages
sudo yum update -y
sudo yum install -y $PKGS_APPS $PKGS_MEDIA $PKGS_PYTHON $PKGS_DEV $PKGS_LIBS
sudo yum install -y $PKGS_GNOME

# Ensure pip is installed for all python interpreters. Some base repo versions (like python3.5-pip) may be broken.
curl https://bootstrap.pypa.io/get-pip.py | sudo python
curl https://bootstrap.pypa.io/get-pip.py | sudo python3
curl https://bootstrap.pypa.io/get-pip.py | sudo python3.5
curl https://bootstrap.pypa.io/get-pip.py | sudo python3.6

sudo activate-global-python-argcomplete
