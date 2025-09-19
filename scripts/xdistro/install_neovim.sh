#!/usr/bin/env bash
# Install latest neovim from GitHub releases
# Use -d flag to install nightly (dev) version

DIST_URL_STABLE='https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz'
DIST_URL_DEV='https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz'
DL_PATH=/tmp/nvim.tar.gz

if [[ "$1" == '-d' ]]; then
    DIST_URL=$DIST_URL_DEV
    echo "Installing neovim nightly build"
else
    DIST_URL=$DIST_URL_STABLE
    echo "Installing neovim stable build"
fi

curl -fL "$DIST_URL" -o "$DL_PATH"
rm -rf /opt/nvim /usr/bin/nvim
tar -vC /opt -xzf "$DL_PATH"
mv /opt/nvim-linux-x86_64 /opt/nvim
ln -s /opt/nvim/bin/nvim /usr/bin/nvim
rm "$DL_PATH"
nvim --version
