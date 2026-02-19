#!/usr/bin/env fish
set script_dir (dirname (dirname (status filename)))
source $script_dir/debian/deb_utils.fish


# Package categories
# --------------------

set PKGS_TOOLS '
    bat
    ca-certificates
    curl
    duf
    fish
    fzf
    git
    htop
    jq
    lolcat
    nala
    neovim
    parted
    pv
    ripgrep
    rsync
    sqlite3
    socat
    ssh
    tidy
    tig
    tmux
    tree
    unzip
    vim
    wget
'
set PKGS_LIBS '
    build-essential
    extrepo
    fontconfig
    gpg
    network-manager-openvpn
'

# Graphical applications
set PKGS_DESKTOP '
    gimp
    guake
    keepassxc
    nextcloud-desktop
    sublime-text
'

# Helper functions
# --------------------

# Docker packages
set PKGS_CONTAINER '
    bubblewrap
    containerd.io
    docker-ce
    docker-ce-cli
    docker-buildx-plugin
    docker-compose-plugin
'
function install-docker
    type -q docker && exit 0
    echo -e "Installing docker\n--------------------\n"

    set DOCKER_KEY /etc/apt/keyrings/docker.asc
    install-asc "https://download.docker.com/linux/debian/gpg" "$DOCKER_KEY"

    echo "deb [arch=amd64 signed-by=$DOCKER_KEY] https://download.docker.com/linux/debian $VERSION_CODENAME stable" \
      > /etc/apt/sources.list.d/docker.list
    apt update && echo $PKGS_CONTAINER | xargs apt install -y
end

# Mirrors used by nala for parallel downloads
set NALA_MIRRORS \
    http://ftp.us.debian.org/debian/ \
    https://mirrors.wikimedia.org/debian/ \
    https://mirror.dal.nexril.net/debian/ \
    http://mirror.siena.edu/debian/ \
    https://mirrors.bloomu.edu/debian/
function install-mirrors
    echo -e "Installing repo mirrors\n--------------------\n"
    rm /etc/apt/sources.list.d/nala-sources.list
    for mirror in $NALA_MIRRORS
        echo "deb $mirror $VERSION_CODENAME main" >> /etc/apt/sources.list.d/nala-sources.list
    end
    nala update
end

# Installation
# --------------------

# Determine packages to install based on shell arguments
set PACKAGES_TO_INSTALL $PKGS_TOOLS
argparse 'g' -- $argv
if set -q _flag_g
    set PACKAGES_TO_INSTALL "$PACKAGES_TO_INSTALL $PKGS_DESKTOP $PKGS_LIBS"
end

# Install packages
apt update && apt upgrade -y
echo $PACKAGES_TO_INSTALL | xargs apt install -y --ignore-missing
install -m 0755 -d /etc/apt/keyrings
install-docker
install-glow
install-mirrors
if set -q _flag_g
    install-extras-gui
end
chsh -s (which fish)
