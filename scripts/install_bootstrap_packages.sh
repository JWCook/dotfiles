#!/usr/bin/env bash
# Install common packages needed for subsequent setup steps for all (personally used) distros
source /etc/os-release
DISTRO=$NAME
PACKAGES='curl fish git jq ssh'

# install packages
case $DISTRO in
    "Ubuntu" | "Debian GNU/Linux")
        sudo apt-get update
        sudo apt-get install -y $PACKAGES;;
    "Fedora")
        sudo dnf install -y $PACKAGES;;
    "Arch Linux")
        sudo pacman -Sy --noconfirm $PACKAGES;;
    *)
        echo "Unsupported platform" && exit 1;;
esac

# install just
if ! type -a just &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to "$HOME/.local/bin"
    export PATH=$PATH:~/.local/bin
    just --version
fi
