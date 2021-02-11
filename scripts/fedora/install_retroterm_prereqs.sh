#!/usr/bin/env bash
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
sudo dnf install -y $PKGS_QT
