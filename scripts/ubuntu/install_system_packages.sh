#!/usr/bin/env bash
set -o nounset

# Options:
# -r: Install apt repositories
# -g: Install graphical applications
# -n: Install packages for Gnome


# Repositories
# --------------------

# Install repos for some additional applications not in the base repo(s)
# (or newer versions than base repo versions)
function install_repos() {
    echo 'Installing apt repositories'
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    curl -fsSL https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -
    apt-add-repository ppa:fish-shell/release-3
    apt-add-repository ppa:neovim-ppa/stable
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    add-apt-repository \
        "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"
}


# Package categories
# --------------------

# Terminal applications
PKGS_APPS='
    curl
    figlet
    fish
    fzf
    git
    htop
    jq
    ncdu
    neovim
    net-tools
    nmap
    ntp
    ntpdate
    p7zip-full
    pv
    qpdf
    silversearcher-ag
    ssh
    telnet
    tig
    tmux
    toilet
    traceroute
    tree
    wget
    xclip
    xsel
'
# Graphical applications
PKGS_GUI_APPS='
    atom
    chromium-browser
    gimp
    guake
    keepassxc
    terminator
'
# Libraries, mostly needed for compiling other applications
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
# Image processing libraries
PKGS_IMG='
    exempi
    exiv2
    libexiv2-dev
    libexiv2-doc
    libimage-exiftool-perl
'
PKGS_SERVER='
    containerd.io
    docker-ce
    docker-ce-cli
'
PKGS_MEDIA='
    gstreamer1.0-plugins-base
    gstreamer1.0-plugins-good
    libdvdcss2
    vlc
    x265
'
# Desktop environment-specific packages
PKGS_GNOME='
    gnome-tweak-tool
    gconf-editor
'
PKGS_SNAP='ffmpeg'


# Installation
# --------------------

# Determine packages to install based on shell arguments
PACKAGES_TO_INSTALL="$PKGS_APPS $PKGS_SERVER $PKGS_LIBS $PKGS_IMG"
while getopts "rg" option; do
    case "${option}" in
        r) install_repos;;
        g) PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $PKGS_GUI_APPS $PKGS_MEDIA";;
        n) PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $PKGS_GNOME";;
    esac
done

# Install packages
apt-get update
apt-get upgrade -y
apt-get install -y $PACKAGES_TO_INSTALL
snap install $PKGS_SNAP
