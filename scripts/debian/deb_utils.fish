#!/usr/bin/env fish
# Install scrips common to Debian-based systems

# Helper functions
# --------------------

function release-var -a key
    grep "^$key=" /etc/os-release | cut -d '=' -f 2-
end
set NAME (release-var NAME)
set VERSION_ID (release-var VERSION_ID)
set VERSION_CODENAME (release-var VERSION_CODENAME)

# Install a signing key (GPG)
function install-gpg -a url -a path
    echo "Installing key: $url"
    curl -sSL "$url" | gpg --dearmor > "$path"
    chmod a+r "$path"
end

# Install a signing key (ASC)
function install-asc -a url -a path
    echo "Installing key: $url"
    curl -fsSL "$url" -o "$path"
    chmod a+r "$path"
end

# Install a deb file from a URL
function install-deb -a url
    echo "Installing $url"
    set deb_tempfile $(mktemp --suffix=.deb)
    curl -L $url -o $deb_tempfile
    apt install -y --fix-broken $deb_tempfile \
    && sleep 1 && rm -v $deb_tempfile
end

# Get URL of latest release deb file from GitHub releases (assumes tag-based releases)
function gh-latest-release -a repo
    curl -s "https://api.github.com/repos/$repo/releases/latest" \
    | jq -r '.assets[] | select(.name | test("\\\\.deb")) | .browser_download_url' \
    | head -n 1
end


# Third-party repos & deb packages
# --------------------------------

function install-sublime-text
    type -q subl && exit 0
    echo -e "Installing Sublime Text\n--------------------\n"

    install-gpg "https://download.sublimetext.com/sublimehq-pub.gpg" "/etc/apt/trusted.gpg.d/sublimehq-archive.gpg"
    echo "deb https://download.sublimetext.com/ apt/stable/" \
        > /etc/apt/sources.list.d/sublime-text.list
    apt update && apt install -y sublime-text
end

function install-duplicati
    type -q duplicati && exit 0
    echo -e "Installing Duplicati\n--------------------\n"

    # Find latest version of Duplicati
    set -l DEB_URL $(
        curl -s "https://updates.duplicati.com/stable/latest-v2.json" \
        | jq -r '."linux-x64-gui.deb".url' )
    if ! set -q DEB_URL
        echo "Error: Could not find latest Duplicati release"
        exit 1
    end

    echo "Installing $DEB_URL"
    install-deb "$DEB_URL"
end

function install-ghostty
    type -q ghostty && exit 0
    echo -e "Installing ghostty\n--------------------\n"

    set -l ARCH $(dpkg --print-architecture)
    set -l FILENAME_PATTERN "ghostty_[^\s/_]+_{$ARCH}_{$VERSION_ID}.deb"
    set -l DEB_URL $(
        curl -s "https://api.github.com/repos/mkasberg/ghostty-ubuntu/releases/latest" \
        | grep -oP "https://github.com/mkasberg/ghostty-ubuntu/releases/download/[^\s/]+/$FILENAME_PATTERN"
    )
    if ! set -q DEB_URL
        echo "Error: Could not find latest Ghostty release"
        exit 1
    end
    install-deb $DEB_URL
end

function install-glow
    type -q glow && exit 0
    echo -e "Installing glow\n--------------------\n"

    install-gpg "https://repo.charm.sh/apt/gpg.key" "/etc/apt/keyrings/charm.gpg"
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" \
        > /etc/apt/sources.list.d/charm.list
    apt update && apt install -y glow
end

function install-localsend
    type -q localsend && exit 0
    echo -e "Installing Localsend\n--------------------\n"

    # appindicator package name varies by distro
    apt install -y libayatana-appindicator || apt install -y libayatana-appindicator3-1
    install-deb "$(gh-latest-release localsend/localsend)"
end

function install-neovim
    # TODO: Use stable release when v0.10+ is available for 24.04
    # add-apt-repository -ny ppa:neovim-ppa/stable
    add-apt-repository -ny ppa:neovim-ppa/unstable
    apt update && apt install -y neovim
end

function install-signal
    type -q signal-desktop && exit 0
    echo -e "Installing Signal\n--------------------\n"

    install-gpg "https://updates.signal.org/desktop/apt/keys.asc" "/usr/share/keyrings/signal-desktop-keyring.gpg"
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main" \
        > /etc/apt/sources.list.d/signal.list
    apt update && apt install -y signal-desktop
end

function install-vivaldi
    type -q vivaldi && exit 0
    echo -e "Installing Vivaldi\n--------------------\n"

    # Find latest version of Vivaldi
    curl -sSLO https://repo.vivaldi.com/archive/deb/dists/stable/main/binary-amd64/Packages
    set -l v_latest $(tac Packages | grep -m1 Version | cut -d " " -f2)
    rm Packages
    echo "Installing Vivaldi $v_latest"
    install-deb "https://repo.vivaldi.com/archive/deb/pool/main/vivaldi-stable_$v_latest_amd64.deb"
end

function install-vscode
    install-deb "https://update.code.visualstudio.com/latest/linux-deb-x64/stable"
end

function install-wezterm
    type -q wezterm && exit 0
    echo -e "Installing Wezterm\n--------------------\n"
    install-gpg "https://apt.fury.io/wez/gpg.key" "/usr/share/keyrings/wezterm-fury.gpg"
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' \
        > /etc/apt/sources.list.d/wezterm.list
    apt update && apt install -y wezterm
end

function install-extras
    install-glow
    install-neovim
end

function install-extras-gui
    install-duplicati
    install-localsend
    install-signal
    install-sublime-text
    install-vivaldi
    install-vscode
    install-wezterm
    # install-ghostty
end
