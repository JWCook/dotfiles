#!/usr/bin/env bash
set -o nounset

# Package categories
# --------------------

# Terminal applications
PKGS_CLI_APPS='
bat
cargo
fish
fzf
git
grc
htop
jq
just
lolcat
neovim
pv
ripgrep
tig
tmux
traceroute
tree
wget
'
# Graphical applications
PKGS_GUI_APPS='
code
keepassxc
kitty
nextcloud-client
vivaldi
vlc
'
# General libraries, mostly needed for compiling other applications
PKGS_LIBS='
cmake
gcc
python3
pandoc
'
# Image processing libraries
PKGS_IMG='
exiv2
imagemagick
perl-image-exiftool
'
pacman -Sy --noconfirm $PKGS_CLI_APPS $PKGS_GUI_APPS $PKGS_LIBS $PKGS_IMG
