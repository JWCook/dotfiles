#!/usr/bin/env bash
set -o nounset

# Options:
# -r: Install dnf repositories
# -g: Install graphical applications
# -n: Install packages for Gnome
# -x: Install packages for Xfce


# Repositories
# --------------------

# Repos for some additional applications not in the base repo(s)
# (or newer versions than base repo versions)
RELEASEVER=$(rpm -E %fedora)
REPO_RPM_URIS="
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${RELEASEVER}.noarch.rpm
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${RELEASEVER}.noarch.rpm
"
REPO_CONFIG_URIS="
    https://download.docker.com/linux/fedora/docker-ce.repo
    https://repo.vivaldi.com/archive/vivaldi-fedora.repo
"
RPM_KEYS='
    https://packages.microsoft.com/keys/microsoft.asc
'

function install_repos() {
    dnf install -y $REPO_RPM_URIS
    rpm --import $RPM_KEYS
    for uri in $REPO_CONFIG_URIS; do
        dnf config-manager --add-repo $uri
    done
    printf "[vscode]\nname=packages.microsoft.com\nbaseurl=https://packages.microsoft.com/yumrepos/vscode/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nmetadata_expire=1h" | tee -a /etc/yum.repos.d/vscode.repo
}


# Package categories
# --------------------

# RPMs not contained in a repo (or newer versions than base repo versions)
RPM_URIS="
    https://github.com/duplicati/duplicati/releases/download/v2.0.6.3-2.0.6.3_beta_2021-06-17/duplicati-2.0.6.3-2.0.6.3_beta_20210617.noarch.rpm
    https://zoom.us/client/latest/zoom_x86_64.rpm
"
# Terminal applications
PKGS_APPS='
    bat
    cargo
    copyq
    dnf-automatic
    dnf-plugins-core
    docker-ce
    docker-compose-plugin
    feh
    figlet
    fish
    git
    htop
    nmap
    jq
    neofetch
    neovim
    npm
    p7zip
    proxychains-ng
    pv
    qpdf
    rpmconf
    snapd
    telnet
    the_silver_searcher
    tig
    tldr
    tmux
    toilet
    tree
    vim-enhanced
    wget
    wl-clipboard
    xclip
    xmlstarlet
    xsel
'
# Graphical applications
PKGS_GUI_APPS='
    chromium
    code
    firefox
    firefox-wayland
    gimp
    guake
    inkscape
    keepassxc
    terminator
    vivaldi-stable
    xfce4-terminal
'
# Libraries, mostly needed for compiling other applications
PKGS_LIBS='
    automake
    bash-completion
    bzip2-devel
    cmake
    ctags
    gcc
    gcc-c++
    graphviz-devel
    java-latest-openjdk
    kernel-devel
    libX11-devel
    libappindicator-sharp
    libffi-devel
    libxml2-devel
    libxslt-devel
    libX11-devel
    libXtst-devel
    lua-devel
    mono-devel
    ncurses-devel
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
    xz-devel
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
# Image processing packages
PKGS_IMG='
    exempi
    exiv2
    exiv2-devel
    perl-Image-ExifTool
'
# Packages for Gnome desktop environment
PKGS_GNOME='
    alacarte
    dconf-editor
    gnome-shell-extension-gsconnect
    gnome-tweak-tool
    gnome-shell-extension-user-theme
    gnome-shell-extension-workspace-indicator
    gnome-shell-extension-screenshot-window-sizer
    gnome-shell-extension-auto-move-windows
    f30-backgrounds-extras-gnome
    f31-backgrounds-extras-gnome
    f32-backgrounds-extras-gnome
    f33-backgrounds-extras-gnome
    f34-backgrounds-extras-gnome
    f35-backgrounds-extras-gnome
    f36-backgrounds-extras-gnome
'
# Packages for Xfce desktop environment
PKGS_XFCE='
    @xfce-desktop-environment
    albert
    kde-connect
    redshift-gtk
    xfce4-hardware-monitor-plugin
    xfce4-whiskermenu-plugin
'


# Installation
# --------------------

# Determine packages to install based on shell arguments
PACKAGES_TO_INSTALL="$RPM_URIS $PKGS_APPS $PKGS_LIBS $PKGS_MEDIA $PKGS_IMG"
while getopts "rgnx" option; do
    case "${option}" in
        r) install_repos;;
        g) PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $PKGS_GUI_APPS $PKGS_MEDIA";;
        n) PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $PKGS_GNOME";;
        x) PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $PKGS_XFCE";;
    esac
done

# If needed, remove older versions of docker before installing docker-ce
# dnf remove docker \
#    docker-client \
#    docker-client-latest \
#    docker-common \
#    docker-latest \
#    docker-latest-logrotate \
#    docker-logrotate \
#    docker-selinux \
#    docker-engine-selinux \
#    docker-engine

# Install packages
dnf update -y
dnf install -y $PACKAGES_TO_INSTALL

activate-global-python-argcomplete

# Install snap packages
ln -s /var/lib/snapd/snap /snap
service snapd start
sleep 1
snap install nextcloud-desktop-client

# Disable cgroupsv2; see https://github.com/docker/cli/issues/297#issuecomment-547022631
grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"

# Enable docker service
systemctl enable docker
systemctl start docker
groupadd docker
usermod -aG docker $USER

# Enable automatic updates; edit /etc/dnf/automatic.conf for settings
systemctl enable --now dnf-automatic.timer
systemctl start dnf-automatic.timer
systemctl list-timers *dnf-*

echo 'Done. System restart required.'
