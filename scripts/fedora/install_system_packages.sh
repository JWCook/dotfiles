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
    guake
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
    tmux
    tree
    wget
    wl-clipboard
    xclip
    xmlstarlet
    xsel
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
    bzip2-devel
    cmake
    ctags
    gcc
    gcc-c++
    jq
    kernel-devel
    libX11-devel
    libffi-devel
    libxml2-devel
    libxslt-devel
    ncurses-devel
    ntfsprogs
    openssl-devel
    readline-devel
    redhat-rpm-config
    rpm-build
    sqlite-devel
    tcl-devel
    xdg-utils
    xz-libs
    zlib-devel
'
PKGS_MEDIA='
    gstreamer1
    gstreamer1-plugins-bad-free
    gstreamer1-plugins-good
    gstreamer1-plugins-good-extras
    vlc
    vlc-extras
    x265
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
    gpaste
    gnome-shell-extension-gpaste
    gnome-shell-extension-gsconnect
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
    f31-backgrounds-extras-gnome
    f32-backgrounds-extras-gnome
'


# Install packages
sudo dnf update -y
sudo dnf install -y $PKGS_APPS $PKGS_DEV $PKGS_LIBS
sudo dnf install -y $PKGS_MEDIA
# Optional packages
# sudo dnf install -y $PKGS_IMG $PKGS_POSTGRES $PKGS_GNOME $PKGS_GNOME_EXTRAS $PKGS_OTHER

sudo activate-global-python-argcomplete

# https://github.com/docker/cli/issues/297#issuecomment-547022631
# @ThaSami current version of Fedora 31 switched to using cgroupsV2 by default, which is not yet supported by the
# container runtimes (and kubernetes); work is in progress on this, but not yet complete, and not yet production ready.
# To disable v2 cgroups, run this and restart your machine afterward:
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"

# Enable automatic updates; edit /etc/dnf/automatic.conf for settings
sudo systemctl enable --now dnf-automatic.timer
