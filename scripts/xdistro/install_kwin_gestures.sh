#!/usr/bin/env bash
set -o nounset

REPO_URL=https://github.com/taj-ny/kwin-gestures
REPO_DIR=/usr/local/src/kwin-gestures

apt install -y extra-cmake-modules gettext kwin-dev kwin-wayland qt6-tools-dev \
    libkf6configwidgets-dev libkf6kcmutils-dev libyaml-cpp-dev libxkbcommon-dev
git -C $REPO_DIR pull || sudo git clone --depth 1 $REPO_URL $REPO_DIR
cd $REPO_DIR
rm -rf build && mkdir build && cd build
cmake ../ -DCMAKE_INSTALL_PREFIX=/usr
make && make install
