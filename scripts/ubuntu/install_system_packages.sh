#!/usr/bin/env bash

# Additional repos for fish shell, neovim, and docker CE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
curl -fsSL https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -
apt-add-repository ppa:fish-shell/release-3
apt-add-repository ppa:neovim-ppa/stable
add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
add-apt-repository \
    "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"

# Package categories
# fzf
PKGS_APPS='
    curl
    figlet
    fish
    git
    htop
    jq
    neovim
    nmap
    ntp
    ntpdate
    p7zip-full
    pv
    qpdf
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
    atom
    chromium-browser
    gimp
    guake
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
PKGS_LIBS='
    build-essential
    cmake
    exuberant-ctags
    libffi-dev
    libgpgme11-dev
    libsqlite3-dev
    libssl-dev
    libx11-dev
    libxpm-dev
    libxt-dev
    ncurses-dev
    npm
    python3-dev
    python3-pip
    python3-venv
    ruby-dev
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
PKGS_SNAP='ffmpeg'

# Install packages
apt-get update
apt-get upgrade -y
apt-get install -y $PKGS_APPS $PKGS_LIBS $PKGS_DEV $PKGS_IMG \
  $PKGS_MEDIA $PKGS_GUI_APPS $PKGS_GNOME
# apt-get install -y $PKGS_MEDIA $PKGS_GUI_APPS $PKGS_ADMIN $PKGS_GNOME
# snap install $PKGS_SNAP
