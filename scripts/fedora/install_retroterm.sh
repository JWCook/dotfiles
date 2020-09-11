#!/usr/bin/env bash

# Retro Term
PKGS_QT='
    qt5-qtbase
    qt-devel
    qt5-qtbase-devel
    qt5-qtdeclarative
    qt5-qtdeclarative-devel
    qt5-qtgraphicaleffects
    qt5-qtquickcontrols
    redhat-rpm-config
'
REPO_DIR=/usr/local/src/retro-term
REPO_URL=https://github.com/Swordfish90/cool-retro-term.git

sudo dnf install -y $PKGS_QT

sudo mkdir -p $REPO_DIR
sudo git -C $REPO_DIR pull || sudo git clone --recursive $REPO_URL $REPO_DIR
cd $REPO_DIR
qmake-qt5 || qmake
sudo make
