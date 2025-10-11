#!/usr/bin/env fish

# Package categories
# --------------------

# Terminal applications
set PKGS_TOOLS '
    atuin
    bat
    bottom
    curl
    difftastic
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
    glow
    gping
    htop
    hyperfine
    inetutils
    jq
    lolcat
    ncdu
    neovim
    net-tools
    nmap
    openssh
    p7zip
    procs
    pv
    qpdf
    rink
    ripgrep
    rsync
    rustup
    shellcheck
    smartmontools
    sqlite
    the_silver_searcher
    tidy
    tig
    tldr
    tmux
    toilet
    traceroute
    tree
    tree-sitter-cli
    unzip
    valgrind
    vim
    wget
    yazi
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
    ntfs-3g
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
    discord
    gimp
    guake
    keepassxc
    kicad
    nextcloud-client
    obsidian
    rapid-photo-downloader
    rustdesk-bin
    rawtherapee
    signal-desktop
    wezterm
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
set PKGS_AUR '
    claude-desktop-bin
    duplicati-beta-bin
    etcher-bin
    fritzing
    librewolf-bin
    localsend-bin
    pdfsam
    pik
    sublime-text-4
    ventoy-bin
    visual-studio-code-bin
    yubico-authenticator-bin
    winboat-bin
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
update-repos

# Update mirrors using reflector (EndeavourOS uses reflector instead of pacman-mirrors)
echo -e "Updating mirrors with reflector\n--------------------\n"
sudo reflector --country 'United States' --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo pacman -Syu --noconfirm
echo -e "Installing packages from official repos\n--------------------\n"
echo $PACKAGES_TO_INSTALL | xargs sudo pacman -S --needed --noconfirm

# Install AUR packages
init-gpg
install-paru
echo -e "Installing AUR packages\n--------------------\n"
echo $PKGS_AUR | xargs paru -S --needed --noconfirm

# Configure Docker
sudo systemctl enable --now docker.service
sudo systemctl enable --now containerd.service
sudo usermod -aG docker $USER

# Enable SSH agent
systemctl --user enable --now ssh-agent.service
systemctl enable --now pcscd

# Enable IWD (if using it instead of wpa_supplicant)
# sudo systemctl enable --now iwd.service

# Set fish as default shell
if type -q fish
    chsh -s (which fish)
    echo "Default shell set to fish"
end
