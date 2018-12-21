#!/usr/bin/env bash


# Package categories
PKGS_APPS='
    chromium
    dnf-automatic
    dnf-plugins-core
    duplicity
    duply
    figlet
    gedit
    gimp
    git
    htop
    inkscape
    keepassxc
    nmap
    ntp
    ntpdate
    p7zip
    proxychains-ng
    pv
    telnet
    terminator
    the_silver_searcher
    tig
    tree
    tmux
    wget'
PKGS_DEV='
    lua-devel
    npm
    php-devel
    ruby-devel
    rubygems
    java-1.8.0-openjdk'
PKGS_LIBS='
    automake
    bash-completion
    cmake
    ctags
    gcc
    gcc-c++
    jq
    kernel-devel
    libffi-devel
    libxml2-devel
    libxslt-devel
    libX11-devel
    ncurses-devel
    ntfsprogs
    openssl-devel
    rpm-build
    redhat-rpm-config
    tcl-devel
    xdg-utils
    xz-libs
    zlib-devel
    bzip2-devel'
PKGS_MEDIA='
    vlc
    vlc-extras
    x265
    gstreamer-plugins-base
    gstreamer-plugins-good
    gstreamer-plugins-bad-free
    gstreamer-plugins-bad-nonfree'
PKGS_PYTHON='
    python-devel
    python3-devel
    python3-wheel'
PKGS_OTHER='
    fortune-mod
    toilet'

# Desktop environment-specific packages
PKGS_GNOME='
    alacarte
    shutter
    dconf-editor
    gnome-tweak-tool
    gnome-shell-browser-plugin
    gnome-shell-extension-user-theme
    gnome-shell-extension-workspace-indicator
    gnome-shell-extension-screenshot-window-sizer
    gnome-shell-extension-auto-move-windows
    gnome-shell-extension-drive-menu'
PKGS_GNOME_EXTRAS='
    f21-backgrounds-extras-gnome
    f22-backgrounds-extras-gnome
    f23-backgrounds-extras-gnome
    f24-backgrounds-extras-gnome
    f25-backgrounds-extras-gnome
    f26-backgrounds-extras-gnome
    f27-backgrounds-extras-gnome
    f28-backgrounds-extras-gnome'


# Install packages
sudo dnf update -y
sudo dnf install -y $PKGS_APPS $PKGS_PYTHON $PKGS_DEV $PKGS_LIBS
sudo dnf install -y $PKGS_MEDIA
sudo dnf install -y $PKGS_GNOME $PKGS_GNOME_EXTRAS $PKGS_OTHER

# Ensure pip is installed for all python interpreters. Some base repo versions (like python3.5-pip) may be broken.
curl https://bootstrap.pypa.io/get-pip.py | sudo python
curl https://bootstrap.pypa.io/get-pip.py | sudo python3

sudo activate-global-python-argcomplete
