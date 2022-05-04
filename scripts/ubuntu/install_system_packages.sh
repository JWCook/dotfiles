#!/usr/bin/env bash
set -o nounset

# Options:
# -r: Install apt repositories
# -g: Install graphical applications
# -n: Install packages for Gnome
# -w: Install packages for WSL
# -x: Install packages for Xfce (not yet added)


# Repositories
# --------------------

# Install repos for some additional applications not in the base repo(s)
# (or newer versions than base repo versions)
function install_repos() {
    echo 'Installing apt repositories'
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    #curl -fsSL https://packagecloud.io/AtomEditor/atom/gpgkey | apt-key add -
    apt-add-repository ppa:fish-shell/release-3
    add-apt-repository ppa:phoerious/keepassxc
    add-apt-repository ppa:nextcloud-devs/client
    echo \
 	"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
}

# sudo apt-get install ranger odt2txt zathura


# Package categories
# --------------------
# Terminal applications
PKGS_APPS='
    bat
    cargo
    copyq
    curl
    feh
    figlet
    fish
    git
    htop
    jq
    ncdu
    net-tools
    nmap
    neofetch
    npm
    ntp
    ntpdate
    p7zip-full
    pv
    qpdf
    ranger
    silversearcher-ag
    sqlite3
    ssh
    telnet
    tig
    tldr
    tmux
    toilet
    traceroute
    tree
    valgrind
    wget
    xclip
    xsel
'
# Graphical applications
PKGS_GUI_APPS='
    chromium-browser
    gimp
    grub-customizer
    guake
    keepassxc
    nextcloud-client
    terminator
'
# Libraries, mostly needed for compiling other applications
PKGS_LIBS='
    bash-completion
    build-essential
    cmake
    exuberant-ctags
    graphviz-dev
    libbz2-dev
    libffi-dev
    libffi7
    libgnutls28-dev
    libgpgme11-dev
    libreadline-dev
    liblzma-dev
    libsqlite3-dev
    libssl-dev
    libx11-dev
    libxpm-dev
    libxt-dev
    odt2txt
    pandoc
    ncurses-dev
    python3-dev
    python3-pip
    python3-venv
    ruby-dev
    zathura
'
# Image processing libraries
PKGS_IMG='
    exempi
    exiv2
    imagemagick
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
# Packages for Gnome desktop environment
PKGS_GNOME='
    gnome-tweak-tool
    gconf-editor
'
# Packages for Xfce desktop environment
PKGS_XFCE='
'
PKGS_SNAP='
    discord
    duf
    ffmpeg
'
PKGS_SNAP_CLASSIC='
    atom
    code
    nvim
'
#pycharm-community
# Additional packages for WSL
PKGS_WSL='
    dbus-x11
    gnome-keyring
    keepassxc
    xfce4-terminal
'


# Installation
# --------------------

# Determine packages to install based on shell arguments
PACKAGES_TO_INSTALL="$PKGS_APPS $PKGS_SERVER $PKGS_LIBS $PKGS_IMG"
while getopts "rgnwx" option; do
    case "${option}" in
        r) install_repos;;
        g) PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $PKGS_GUI_APPS $PKGS_MEDIA";;
        n) PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $PKGS_GNOME";;
        w) PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $PKGS_WSL";;
        x) PACKAGES_TO_INSTALL="$PACKAGES_TO_INSTALL $PKGS_XFCE";;
    esac
done

# Install packages
apt-get update
apt-get upgrade -y
apt-get install -y $PACKAGES_TO_INSTALL

sudo snap install $PKGS_SNAP
for pkg in $PKGS_SNAP_CLASSIC; do
    sudo snap install $pkg --classic
done

