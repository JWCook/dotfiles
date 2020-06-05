#!/usr/bin/env bash

# Additional repos for fish shell and docker CE
sudo apt-add-repository ppa:fish-shell/release-3
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Package categories
# fzf
PKGS_APPS='
    curl
    figlet
    fish
    git
    htop
    jq
    nmap
    ntp
    ntpdate
    p7zip-full
    pv
    silversearcher-ag
    ssh
    tig
    tmux
    toilet
    traceroute
    tree
    wget
    xclip
    xsel
'
PKGS_GUI_APPS='
    chromium-browser
    gimp
    keepassxc
    terminator
'
PKGS_SERVER='
    containerd.io
    docker-ce
    docker-ce-cli
    ncdu
    net-tools
    telnet
'
PKGS_ADMIN='
    logwatch
'
PKGS_DEV='
    python3-dev
    python3-pip
    python3-venv
    npm
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
sudo apt-get install -y $PKGS_APPS $PKGS_LIBS $PKGS_DEV $PKGS_IMG
# sudo apt-get install -y $PKGS_MEDIA $PKGS_GUI_APPS $PKGS_ADMIN $PKGS_GNOME $PKGS_UNITY
# sudo snap install $PKGS_SNAP
