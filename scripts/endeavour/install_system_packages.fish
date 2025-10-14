#!/usr/bin/env fish

# Package categories
# --------------------

# Main terminal applications & coreutils replacements
set PKGS_TERM '
    atuin
    bat
    bottom
    choose
    difftastic
    duf
    dust
    eza
    fd
    fish
    fzf
    gping
    pik
    procs
    pv
    ripgrep
    starship
    tmux
    yazi
    zoxide
'

# Other CLI/TUI tools
set PKGS_TOOLS '
    curl
    fastfetch
    feh
    figlet
    git
    git-delta
    github-cli
    glow
    hyperfine
    jq
    lolcat
    ncdu
    neovim
    qpdf
    rink
    rsync
    shellcheck
    sqlite
    tidy
    tig
    tldr
    toilet
    tree
    tree-sitter-cli
    unzip
    valgrind
    vim
    wget
    zathura
    yq
'

# Network tools
set PKGS_NET '
    freerdp
    inetutils
    iwd
    net-tools
    nmap
    ntp
    openssh
    traceroute
    whois
'

# System utilities, drivers, etc.
set PKGS_SYS '
    cups
    cups-pdf
    fontconfig
    smartmontools
    thermald
    xclip
    xsel
'

# Compilers, libraries for compiling other applications, optional features, etc.
set PKGS_LIBS '
    7zip
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
    libwebp
    perl-image-exiftool
'

# Graphical applications
set PKGS_DESKTOP '
    audacity
    discord
    gimp
    guake
    keepassxc
    kicad
    libreoffice-fresh
    nextcloud-client
    obsidian
    rapid-photo-downloader
    rawtherapee
    signal-desktop
    wezterm
'

# KDE applications
set PKGS_KDE '
    ark
    kate
    kcalc
    kdeconnect
    okular
    partitionmanager
    plasma-systemmonitor
    spectacle
'

# Gaming-related appllications and drivers
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

# Media players and codecs
set PKGS_MEDIA '
    ffmpeg
    flac
    gst-plugins-base
    gst-plugins-good
    lame
    vlc
    vlc-plugin-ffmpeg
    x264
    x265
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
    rustdesk-bin
    sublime-text-4
    ventoy-bin
    visual-studio-code-bin
    yubico-authenticator-bin
    winboat-bin
    xnviewmp
'

# Packages to remove after system setup
set PKGS_REMOVE '
    eos-apps-info
    eos-breeze-sddm
    eos-packagelist
    eos-qogir-icons
    eos-quickstart
    eos-settings-plasma
    welcome
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

set ALL_PACKAGES "
    $PKGS_TERM
    $PKGS_TOOLS
    $PKGS_NET
    $PKGS_SYS
    $PKGS_LIBS
    $PKGS_IMG
    $PKGS_DESKTOP
    $PKGS_GAMES
    $PKGS_MEDIA
    $PKGS_KDE
    $PKGS_DOCKER
"

# Update mirrors using reflector (EndeavourOS uses reflector instead of pacman-mirrors)
echo -e "Updating mirrors with reflector\n--------------------\n"
sudo reflector --country 'United States' --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Install pacman packages
update-repos
sudo pacman -Syu --noconfirm
echo -e "Installing packages from official repos\n--------------------\n"
echo $ALL_PACKAGES | xargs sudo pacman -S --needed --noconfirm

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

# Remove some pre-installed packages
sudo pacman -R --noconfirm $PKGS_REMOVE
