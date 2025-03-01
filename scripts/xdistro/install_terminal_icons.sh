#!/usr/bin/env bash
set -o nounset

REPO=https://github.com/sebastiencs/icons-in-terminal.git
REPO_DIR=/usr/local/src/icons-in-terminal

sudo git -C "$REPO_DIR" pull || sudo git clone "$REPO" "$REPO_DIR"
cd $REPO_DIR || exit
sudo ./install.sh
./install-autodetect.sh
