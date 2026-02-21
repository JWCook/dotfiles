#!/usr/bin/env fish
set script_dir (dirname (dirname (status filename)))
source $script_dir/debian/deb_utils.fish

# Options:
# -g: Install graphical (desktop) applications
# -n: Install packages for Gnome
# -k: Install packages for KDE
# -w: Install packages for WSL
# -x: Install packages for xfce


# Package categories
# --------------------

# Terminal applications
set PKGS_TOOLS '
    bat
    curl
    duf
    fastfetch
    feh
    ffmpeg
    figlet
    fish
    git
    htop
    jq
    lolcat
    nala
    ncdu
    p7zip-full
    pv
    qpdf
    ripgrep
    rsync
    shellcheck
    sqlite3
    starship
    tidy
    tig
    tldr
    tmux
    toilet
    tree
    unzip
    valgrind
    vim
    wget
    zathura
'

# Network tools
set PKGS_NET '
    iwd
    net-tools
    network-manager-openvpn
    nmap
    ntp
    ntpdate
    socat
    ssh
    telnet
    traceroute
    whois
'

# System utilities, drivers, etc.
set PKGS_SYS '
    fontconfig
    thermald
    ubuntu-drivers-common
    xclip
    xsel
'

# Compilers, libraries for compiling other applications, optional features, etc.
set PKGS_LIBS '
    bash-completion
    bubblewrap
    build-essential
    cifs-utils
    cmake
    exuberant-ctags
    extrepo
    golang
    gpg
    graphviz-dev
    libbz2-dev
    libffi-dev
    libffi8
    libgnutls28-dev
    libgpgme11-dev
    libreadline-dev
    liblzma-dev
    libsqlite3-dev
    libssl-dev
    libx11-dev
    libxpm-dev
    libxt-dev
    libatomic1
    luarocks
    odt2txt
    openjdk-21-jdk
    pandoc
    ncurses-dev
    protobuf-compiler
    python3-dev
    ruby-dev
    rustup
'

# Image processing libraries
set PKGS_IMG '
    exempi
    exiv2
    imagemagick
    libexiv2-dev
    libexiv2-doc
    libimage-exiftool-perl
'

# Graphical applications
set PKGS_DESKTOP '
    gimp
    guake
    keepassxc
    nextcloud-desktop
'

# Media players and codecs
set PKGS_MEDIA '
    gstreamer1.0-plugins-base
    gstreamer1.0-plugins-good
    vlc
    x265
'

# Packages for Gnome desktop environment
set PKGS_GNOME '
    copyq
    gnome-tweak-tool
    gconf-editor
'

# Packages for KDE Plasma desktop environment
set PKGS_KDE '
'

# Packages for Xfce desktop environment
set PKGS_XFCE '
'

# Additional packages for WSL
set PKGS_WSL '
    dbus-x11
'

# Snap packages
set PKGS_SNAP '
    discord
'

command -v check-language-support >/dev/null 2>&1 \
    && set PKGS_LANG $(check-language-support -l en)

# Helper functions
# --------------------

# Docker packages
set PKGS_DOCKER \
    containerd.io \
    docker-ce \
    docker-ce-cli \
    docker-buildx-plugin \
    docker-compose-plugin
function install-docker
    type -q docker && exit 0
    echo -e "Installing docker\n--------------------\n"

    install-gpg "https://download.docker.com/linux/ubuntu/gpg" "/etc/apt/keyrings/docker.gpg"
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $VERSION_CODENAME stable" \
      > /etc/apt/sources.list.d/docker.list
    apt update && apt install -y $PKGS_DOCKER
end

# Mirrors used by nala for parallel downloads
# alternatively:
# sudo nala fetch --country US
set NALA_MIRRORS \
    http://mirror.siena.edu/ubuntu/ \
    https://mirrors.wikimedia.org/ubuntu/ \
    https://mirror.vcu.edu/pub/gnu+linux/ubuntu/ \
    http://mirrors.cmich.edu/ubuntu/ \
    http://mirror.metrocast.net/ubuntu/
function install-mirrors
    echo -e "Installing repo mirrors\n--------------------\n"
    rm /etc/apt/sources.list.d/nala-sources.list
    for mirror in $NALA_MIRRORS
        echo "deb $mirror $VERSION_CODENAME main restricted universe multiverse" \
            >> /etc/apt/sources.list.d/nala-sources.list
    end
    nala update
end


# Installation
# --------------------

# Determine packages to install based on shell arguments
set PACKAGES_TO_INSTALL "$PKGS_TOOLS $PKGS_NET $PKGS_SYS $PKGS_LIBS $PKGS_IMG $PKGS_LANG"
argparse 'g' 'n' 'k' 'w' 'x' -- $argv
or begin
    exit 1
end
if set -q _flag_g
    set PACKAGES_TO_INSTALL "$PACKAGES_TO_INSTALL $PKGS_DESKTOP $PKGS_MEDIA"
end
if set -q _flag_n
    set PACKAGES_TO_INSTALL "$PACKAGES_TO_INSTALL $PKGS_GNOME"
end
if set -q _flag_k
    set PACKAGES_TO_INSTALL "$PACKAGES_TO_INSTALL $PKGS_KDE"
end
if set -q _flag_w
    set PACKAGES_TO_INSTALL "$PACKAGES_TO_INSTALL $PKGS_WSL"
end
if set -q _flag_x
    set PACKAGES_TO_INSTALL "$PACKAGES_TO_INSTALL $PKGS_XFCE"
end

# Install packages
apt update && apt upgrade -y
echo $PACKAGES_TO_INSTALL | xargs apt install -y --ignore-missing
install -m 0755 -d /etc/apt/keyrings
install-extras
install-docker
if set -q _flag_g
    install-extras-gui
    snap install "$PKGS_SNAP"
end
install-mirrors
ubuntu-drivers install

usermod -aG docker "$USER"
systemctl enable --now iwd
chsh -s (which fish)
