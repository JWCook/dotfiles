#!/usr/bin/env bash
source scripts/install_appimage.sh

install-appimage https://github.com/webcamoid/webcamoid/releases/download/8.7.1/webcamoid-8.7.1-x86_64.AppImage
sudo dnf install -y v4l-utils v4l2ucp

# Install v4l2loopback
# sudo dnf copr enable -y danielkza/v4l2loopback
# sudo dnf install -y v4l2loopback

# Clone to a new directory if installing for the first time, or otherwise pull if it's already cloned
REPO=https://github.com/umlaeute/v4l2loopback
REPO_DIR=/usr/local/src/v4l2loopback
sudo mkdir -p $REPO_DIR
sudo git -C $REPO_DIR pull || sudo git clone $REPO $REPO_DIR
cd $REPO_DIR

sudo make && sudo make install
sudo depmod -a
sudo modprobe v4l2loopback
