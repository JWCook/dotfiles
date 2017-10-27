#!/usr/bin/env bash

# Package categories
PKGS_APPS="\
    chromium-browser \
    curl \
    figlet \
    fortune \
    gedit \
    gimp \
    git \
    htop \
    logwatch \
    ncdu \
    net-tools \
    nmap \
    ntp \
    ntpdate \
    p7zip-full \
    pv \
    silversearcher-ag \
    ssh \
    shutter \
    telnet \
    terminator \
    tig \
    toilet \
    tree \
    tmux \
    wget"
PKGS_DEV="\
    npm \
    ruby-dev"
PKGS_LIBS="\
    build-essential \
    exuberant-ctags \
    libffi-dev \
    libgpgme11-dev \
    libssl-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    ncurses-dev"
PKGS_MEDIA="\
    vlc \
    ffmpeg \
    libdvdcss2 \
    x265 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly"
PKGS_PYTHON="\
    python-dev \
    python-pip \
    python-cffi \
    python-setuptools \
    python3-dev \
    python3-pip \
    python3-setuptools"

# Desktop environment-specific packages
PKGS_GNOME="\
    gnome-tweak-tool \
    gconf-editor"
PKGS_UNITY="ubuntu-tweak"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y $PKGS_APPS $PKGS_DEV $PKGS_LIBS $PKGS_MEDIA $PKGS_PYTHON
