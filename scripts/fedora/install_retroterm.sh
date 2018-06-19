#!/usr/bin/env bash

# Retro Term
PKGS_GTK='qt5-qtbase qt-devel qt5-qtbase-devel qt5-qtdeclarative qt5-qtdeclarative-devel qt5-qtgraphicaleffects qt5-qtquickcontrols redhat-rpm-config'
REPO_DIR=/usr/local/src/retro-term

sudo mkdir -p $REPO_DIR
sudo dnf install -y $PKGS_GTK
sudo git -C $REPO_DIR pull || sudo git clone --recursive https://github.com/Swordfish90/cool-retro-term.git $REPO_DIR
cd $REPO_DIR
qmake-qt5 || qmake
sudo make
