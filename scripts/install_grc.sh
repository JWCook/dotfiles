#!/usr/bin/env bash
# Install/update Generic Colouriser

REPO=https://github.com/garabik/grc.git
REPO_DIR=/usr/local/src/grc
echo 'Installing generic colouriser...'
sudo git -C $REPO_DIR pull || sudo git clone $REPO $REPO_DIR
cd $REPO_DIR
sudo ./install.sh
