#!/usr/bin/env bash
PKGS_QT='
    build-essential
    qmlscene
    qt5-qmake
    qt5-default
    qtdeclarative5-dev
    qtdeclarative5-controls-plugin
    qtdeclarative5-qtquick2-plugin
    libqt5qml-graphicaleffects
    qtdeclarative5-dialogs-plugin
    qtdeclarative5-localstorage-plugin
    qtdeclarative5-window-plugin
'

sudo apt-get install -y $PKGS_QT
