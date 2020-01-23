#!/usr/bin/env bash

# Package categories
PKGS_APPS='
    chromium-browser
    curl
    figlet
    fish
    fzf
    gimp
    git
    htop
    keepassxc
    ntp
    ntpdate
    p7zip-full
    pv
    silversearcher-ag
    ssh
    terminator
    tig
    toilet
    traceroute
    tree
    tmux
    wget
    xclip
    xsel
'
PKGS_SERVER='
    logwatch
    ncdu
    net-tools
    nmap
    telnet
'
PKGS_DEV='
    npm
    python3-dev
    ruby-dev
'
PKGS_LIBS='
    build-essential
    cmake
    exuberant-ctags
    libffi-dev
    libgpgme11-dev
    libssl-dev
    libx11-dev
    libxpm-dev
    libxt-dev
    ncurses-dev
'
PKGS_MEDIA='
    vlc
    libdvdcss2
    x265
    gstreamer1.0-plugins-base
    gstreamer1.0-plugins-good
    gstreamer1.0-plugins-bad
    gstreamer1.0-plugins-ugly
'
# Image processing packages
PKGS_IMG='
    exempi
    exiv2
    libexiv2-dev
    libexiv2-doc
    libimage-exiftool-perl
'
# Desktop environment-specific packages
PKGS_GNOME='
    gnome-tweak-tool
    gconf-editor
'
PKGS_UNITY='ubuntu-tweak'
PKGS_SNAP='ffmpeg'

# Install packages
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y $PKGS_APPS $PKGS_LIBS $PKGS_MEDIA
# Optional packages
# sudo apt-get install -y $PKGS_DEV $PKGS_IMG $PKGS_GNOME $PKGS_UNITY
sudo snap install $PKGS_SNAP
