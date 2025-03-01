#!/usr/bin/env bash
REPO_DIR=/usr/local/src/retro-term
REPO_URL=https://github.com/Swordfish90/cool-retro-term.git
set -o nounset

git -C "$REPO_DIR" pull ||  git clone --recursive "$REPO_URL" "$REPO_DIR"
cd $REPO_DIR || exit
qmake-qt5 || qmake
make
