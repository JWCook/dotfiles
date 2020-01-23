#!/usr/bin/env bash

# Package categories
PKGS_APPS='
    chromium
    dnf-automatic
    dnf-plugins-core
    duplicity
    duply
    figlet
    firefox
    firefox-wayland
    fish
    fzf
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
    rpmconf
    telnet
    terminator
    the_silver_searcher
    tig
    tldr
    tree
    tmux
    wget
    wl-clipboard
    xclip
    xsel
    xmlstarlet
'
PKGS_DEV='
    lua-devel
    npm
    php-devel
    python-devel
    python3-devel
    python3-wheel
    ruby-devel
    rubygems
    java-1.8.0-openjdk
'
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
    bzip2-devel
'
PKGS_MEDIA='
    vlc
    vlc-extras
    x265
    gstreamer-plugins-base
    gstreamer-plugins-good
    gstreamer-plugins-bad-free
    gstreamer-plugins-bad-nonfree
'
PKGS_POSTGRES='
    postgresql10-devel
    postgresql10-server
    postgis30_10-devel
    freetds-devel
    unixODBC-devel
'
PKGS_OTHER='
    fortune-mod
    toilet
'
# Image processing packages
PKGS_IMG='
    exempi
    exiv2
    exiv2-devel
    perl-Image-ExifTool
'
# Desktop environment-specific packages
PKGS_GNOME='
    alacarte
    dconf-editor
    gnome-tweak-tool
    gnome-shell-extension-user-theme
    gnome-shell-extension-workspace-indicator
    gnome-shell-extension-screenshot-window-sizer
    gnome-shell-extension-auto-move-windows
'
PKGS_GNOME_EXTRAS='
    f21-backgrounds-extras-gnome
    f22-backgrounds-extras-gnome
    f23-backgrounds-extras-gnome
    f24-backgrounds-extras-gnome
    f25-backgrounds-extras-gnome
    f26-backgrounds-extras-gnome
    f27-backgrounds-extras-gnome
    f28-backgrounds-extras-gnome
    f29-backgrounds-extras-gnome
    f30-backgrounds-extras-gnome
'


# Install packages
sudo dnf update -y
sudo dnf install -y $PKGS_APPS $PKGS_DEV $PKGS_LIBS
sudo dnf install -y $PKGS_MEDIA
# Optional packages
# sudo dnf install -y $PKGS_IMG $PKGS_POSTGRES $PKGS_GNOME $PKGS_GNOME_EXTRAS $PKGS_OTHER

sudo activate-global-python-argcomplete
