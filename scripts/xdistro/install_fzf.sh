#!/usr/bin/env bash
set -o nounset

REPO=https://github.com/junegunn/fzf.git
REPO_DIR=/usr/local/src/fzf

sudo git -C "$REPO_DIR" pull || sudo git clone --depth 1 "$REPO" "$REPO_DIR"
sudo chown -R "$USER" "$REPO_DIR"
cd $REPO_DIR|| exit
./install --bin
