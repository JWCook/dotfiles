#!/bin/bash

REPO_DIR=/usr/local/src/xfce-superkey
REPO_URL=https://github.com/JixunMoe/xfce-superkey.git

sudo git -C $REPO_DIR pull || sudo git clone $REPO_URL $REPO_DIR
cd $REPO_DIR
sudo make
sudo make install
