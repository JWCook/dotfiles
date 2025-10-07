#!/usr/bin/env fish

# Package categories
# --------------------

# Terminal applications
set PKGS_TOOLS '
    atuin
    bat
    bottom
    curl
    delta
    duf
    dust
    eza
    fastfetch
    fd
    feh
    ffmpeg
    figlet
    fish
    freerdp
    fzf
    git
    git-delta
    htop
    hyperfine
    jq
    lolcat
    neovim
    ncdu
    net-tools
    nmap
    p7zip
    procs
    pv
    qpdf
    ripgrep
    rsync
    rustup
    shellcheck
    the_silver_searcher
    sqlite
    openssh
    inetutils
    tidy
    tig
    tldr
    tmux
    toilet
    traceroute
    tree
    unzip
    valgrind
    vim
    wget
    zathura
    zoxide
'

# System utilities, drivers, etc.
set PKGS_SYS '
    fontconfig
    iwd
    networkmanager-openvpn
    ntp
    thermald
    xclip
    xsel
'

# Libraries, mostly needed for compiling other applications
set PKGS_LIBS '
    base-devel
    bash-completion
    bzip2
    cifs-utils
    cmake
    ctags
    gnupg
    gnutls
    go
    gpgme
    graphviz
    jre21-openjdk
    libffi
    libx11
    libxpm
    libxt
    luarocks
    ncurses
    odt2txt
    openssl
    pandoc
    protobuf
    python
    readline
    ruby
    rustup
    sqlite
    wl-clipboard
    xz
'

# Image processing libraries
set PKGS_IMG '
    exempi
    exiv2
    imagemagick
    perl-image-exiftool
'

# Graphical applications
set PKGS_GUI_APPS '
    gimp
    guake
    keepassxc
    kicad
    nextcloud-client
    rawtherapee
'

set PKGS_GAMES '
    steam
    gamemode
    lizardbyte/sunshine
    mesa
    vulkan-radeon
    lib32-gamemode
    lib32-mesa
    lib32-vulkan-radeon
'

set PKGS_MEDIA '
    gst-plugins-base
    gst-plugins-good
    vlc
    x265
'

# Packages for KDE Plasma desktop environment
set PKGS_KDE '
    copyq
    plasma-systemmonitor
    spectacle
    kdeconnect
'

# Docker packages
set PKGS_DOCKER '
    docker
    docker-buildx
    docker-compose
    containerd
'

# AUR packages (installed via paru)
set PKGS_AUR_CLI '
    difftastic
    glow
    gping
    pik
    rink
    tree-sitter-cli
    yazi
'

set PKGS_AUR_GUI '
    claude-desktop-bin
    discord
    duplicati-beta-bin
    etcher-bin
    fritzing
    librewolf-bin
    localsend-bin
    obsidian
    pdfsam
    rapid-photo-downloader
    signal-desktop
    sublime-text-4
    ventoy-bin
    visual-studio-code-bin
    winboat-bin
    wezterm
    xnviewmp
'

# Helper functions
# --------------------

function init-gpg
    echo -e "Initializing GPG\n--------------------\n"
    mkdir -p ~/.local/share/gnupg
    chmod 700 ~/.local/share/gnupg
    gpg --list-keys > /dev/null 2>&1 || true
    gpg-connect-agent --dirmngr /bye > /dev/null 2>&1 || true
end

function install-paru
    type -q paru && return 0
    rustup default stable
    echo -e "Installing paru\n--------------------\n"
    set temp_dir (mktemp -d) && cd $temp_dir
    cd $temp_dir && git clone https://aur.archlinux.org/paru.git
    cd paru && makepkg -si --noconfirm
    cd ~ && rm -rf $temp_dir
end

# Add/update pacman repos
function update-repos
    # Enable multilib for 32-bit libraries
    if not grep -q "^\[multilib\]" /etc/pacman.conf
        sudo sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
    end

    # Add LizardByte repo
    if not grep -q "^\[lizardbyte\]" /etc/pacman.conf
        sudo printf '%s\n' '' \
        '[lizardbyte]' \
        'SigLevel = Optional' \
        'Server = https://github.com/LizardByte/pacman-repo/releases/latest/download' \
        | sudo tee -a /etc/pacman.conf
    end
end

# Installation
# --------------------

set PACKAGES_TO_INSTALL "$PKGS_TOOLS $PKGS_SYS $PKGS_LIBS $PKGS_IMG $PKGS_GUI_APPS $PKGS_GAMES $PKGS_MEDIA $PKGS_KDE $PKGS_DOCKER"
set AUR_PACKAGES "$PKGS_AUR_CLI $PKGS_AUR_GUI"

update-repos
sudo pacman-mirrors --country United_States --api --protocol https
sudo pacman -Syu --noconfirm
echo -e "Installing packages from official repos\n--------------------\n"
echo $PACKAGES_TO_INSTALL | xargs sudo pacman -S --needed --noconfirm

# Install AUR packages
init-gpg
install-paru
echo -e "Installing AUR packages\n--------------------\n"
echo $AUR_PACKAGES | xargs paru -S --needed --noconfirm

# Configure Docker
sudo systemctl enable --now docker.service
sudo systemctl enable --now containerd.service
sudo usermod -aG docker $USER

# Enable SSH agent
systemctl --user enable --now ssh-agent.service

# Enable IWD (if using it instead of wpa_supplicant)
# sudo systemctl enable --now iwd.service
#
# Set fish as default shell
if type -q fish
    chsh -s (which fish)
    echo "Default shell set to fish"
end

# Install hardware drivers (Manjaro's hardware detection)
if type -q mhwd
    echo "Installing hardware drivers..."
    sudo mhwd -a pci free 0300  # Install free graphics drivers
    sudo mhwd -a pci nonfree 0300  # Install proprietary graphics drivers if needed
end
