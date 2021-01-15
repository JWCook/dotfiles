#!/usr/bin/env bash

# Additional repos
RELEASEVER=$(rpm -E %fedora)
REPO_RPM_URIS="
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${RELEASEVER}.noarch.rpm
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${RELEASEVER}.noarch.rpm
    https://download.postgresql.org/pub/repos/yum/reporpms/F-${RELEASEVER}-x86_64/pgdg-fedora-repo-latest.noarch.rpm
    https://rpmfind.net/linux/fedora/linux/releases/${RELEASEVER}/Everything/x86_64/os/Packages/g/gdouros-symbola-fonts-10.24-4.fc${RELEASEVER}.noarch.rpm
"
REPO_CONFIG_URIS="
    https://download.docker.com/linux/fedora/docker-ce.repo
    https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_${RELEASEVER}/home:manuelschneid3r.repo
    scripts/fedora/atom.repo
"
RPM_KEYS='
    https://build.opensuse.org/projects/home:manuelschneid3r/public_key
    https://packagecloud.io/AtomEditor/atom/gpgkey
'

# RPMs not contained in a repo
RPM_URIS="
    https://github.com/duplicati/duplicati/releases/download/v2.0.5.1-2.0.5.1_beta_2020-01-18/duplicati-2.0.5.1-2.0.5.1_beta_20200118.noarch.rpm
    https://zoom.us/client/latest/zoom_x86_64.rpm
"

# Package categories
PKGS_APPS='
    atom
    chromium
    docker-ce
    dnf-automatic
    dnf-plugins-core
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
    nextcloud-client
    nmap
    ntp
    ntpdate
    p7zip
    proxychains-ng
    pv
    qpdf
    rpmconf
    telnet
    terminator
    the_silver_searcher
    tig
    tldr
    tmux
    tree
    vim-enhanced
    wget
    wl-clipboard
    xclip
    xmlstarlet
    xsel
'
PKGS_LIBS='
    automake
    bash-completion
    bzip2-devel
    cmake
    ctags
    gcc
    gcc-c++
    java-latest-openjdk
    jq
    kernel-devel
    libX11-devel
    libappindicator-sharp
    libffi-devel
    libxml2-devel
    libxslt-devel
    lua-devel
    mono-devel
    ncurses-devel
    npm
    ntfsprogs
    openssl-devel
    perl-devel
    php-devel
    python3-devel
    python3-wheel
    readline-devel
    redhat-rpm-config
    rpm-build
    ruby-devel
    rubygems
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
    f33-backgrounds-extras-gnome
'
PKGS_XFCE='
    @xfce-desktop-environment
    albert
    kde-connect
    redshift-gtk
    xfce4-hardware-monitor-plugin
    xfce4-whiskermenu-plugin
'

# Install repos
sudo dnf install -y $REPO_RPM_URIS
sudo rpm --import $RPM_KEYS
for uri in $REPO_CONFIG_URIS; do
    sudo dnf config-manager --add-repo $uri
done

# Install packages
sudo dnf update -y
sudo dnf install -y $RPM_URIS $PKGS_APPS $PKGS_LIBS $PKGS_MEDIA $PKGS_IMG $PKGS_XFCE
# Optional packages
# sudo dnf install -y $PKGS_POSTGRES $PKGS_GNOME $PKGS_OTHER

sudo activate-global-python-argcomplete

# Disable cgroupsv2; see https://github.com/docker/cli/issues/297#issuecomment-547022631
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"

# Enable docker service
sudo systemctl enable docker
sudo systemctl start docker
sudo groupadd docker
sudo usermod -aG docker $USER

# Enable automatic updates; edit /etc/dnf/automatic.conf for settings
sudo systemctl enable --now dnf-automatic.timer
sudo systemctl start dnf-automatic.timer
sudo systemctl list-timers *dnf-*

echo 'Done. System restart required.'
