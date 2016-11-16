#!/usr/bin/env bash

# Retro Term
PKGS_GTK='qt5-qtbase qt5-qtbase-devel qt5-qtdeclarative qt5-qtdeclarative-devel qt5-qtgraphicaleffects qt5-qtquickcontrols redhat-rpm-config'

sudo yum install -y $PKGS_GTK
sudo git clone --recursive https://github.com/Swordfish90/cool-retro-term.git /usr/local/src/retro-term
sudo chown cookjo:cookjo /usr/local/src/retro-term
cd /usr/local/src/retro-term
qmake
sudo make
