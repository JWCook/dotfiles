#!/usr/bin/env bash
# TODO: use pyenv to manage multiple python versions

# Package categories
PKGS_APPS='chromium duplicity duply figlet gedit gimp git htop inkscape keepassxc nmap ntp p7zip pv telnet terminator the_silver_searcher tig tree tmux wget'
PKGS_DEV='lua-devel npm php-devel ruby-devel rubygems java-1.8.0-openjdk'
PKGS_LIBS='ctags gcc gcc-c++ jq kernel-devel libffi-devel libxml2-devel libxslt-devel libX11-devel ncurses-devel ntfsprogs openssl-devel rpm-build redhat-rpm-config tcl-devel xdg-utils xz-libs zlib-devel bzip2-devel yum-utils'
PKGS_MEDIA='vlc x265 gstreamer-plugins-base gstreamer-plugins-good gstreamer-plugins-bad-free gstreamer-plugins-bad-nonfree gstreamer-plugins-ugly'
PKGS_PYTHON='python-devel python3-devel python3-wheel'
PKGS_OTHER='fortune fortune-mod toilet'

# Desktop environment-specific packages
PKGS_GNOME='alacarte shutter dconf-editor gnome-tweak-tool gnome-shell-browser-plugin gnome-shell-extension-user-theme gnome-shell-extension-workspace-indicator gnome-shell-extension-screenshot-window-sizer gnome-shell-extension-auto-move-windows gnome-shell-extension-drive-menu'

# Install packages
sudo yum update -y
sudo yum install -y $PKGS_APPS $PKGS_MEDIA $PKGS_PYTHON $PKGS_DEV $PKGS_LIBS
sudo yum install -y $PKGS_GNOME $PKGS_OTHER

# Ensure pip is installed for all python interpreters. Some base repo versions (like python3.5-pip) may be broken.
curl https://bootstrap.pypa.io/get-pip.py | sudo python
curl https://bootstrap.pypa.io/get-pip.py | sudo python3
# curl https://bootstrap.pypa.io/get-pip.py | sudo python3.5

sudo activate-global-python-argcomplete
