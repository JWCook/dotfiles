#!/usr/bin/env bash
set -o nounset

REPO=https://github.com/hackerb9/lsix
REPO_DIR=/usr/local/src/lsix
BIN_PATH=/usr/local/bin/lsix

sudo git -C $REPO_DIR pull || sudo git clone --depth 1 $REPO $REPO_DIR
sudo cp $REPO_DIR/lsix $BIN_PATH
sudo chmod +x $BIN_PATH
