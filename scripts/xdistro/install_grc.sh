#!/usr/bin/env bash
# Install/update Generic Colouriser
set -o nounset

REPO=https://github.com/garabik/grc.git
REPO_DIR=/usr/local/src/grc

sudo git -C "$REPO_DIR" pull || sudo git clone "$REPO" "$REPO_DIR"
cd $REPO_DIR || exit
sudo ./install.sh
