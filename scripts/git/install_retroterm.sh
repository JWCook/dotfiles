#!/usr/bin/env bash
REPO_DIR=/usr/local/src/retro-term
REPO_URL=https://github.com/Swordfish90/cool-retro-term.git

sudo git -C $REPO_DIR pull || sudo git clone --recursive $REPO_URL $REPO_DIR
cd $REPO_DIR
sudo qmake-qt5 || sudo qmake
sudo make
