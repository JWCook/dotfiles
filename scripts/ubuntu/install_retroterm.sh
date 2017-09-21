#!/usr/bin/env bash

# Retro Term
PKGS_GTK='build-essential qmlscene qt5-qmake qt5-default qtdeclarative5-dev qtdeclarative5-controls-plugin qtdeclarative5-qtquick2-plugin libqt5qml-graphicaleffects qtdeclarative5-dialogs-plugin qtdeclarative5-localstorage-plugin qtdeclarative5-window-plugin'
REPO_DIR=/usr/local/src/retro-term

sudo apt-get install -y $PKGS_GTK
sudo git -C $REPO_DIR pull || sudo git clone --recursive https://github.com/Swordfish90/cool-retro-term.git $REPO_DIR
cd $REPO_DIR
sudo qmake
sudo make
