#!/usr/bin/env bash
YCM_DIR=~/.vim/plugged/YouCompleteMe
git -C $YCM_DIR submodule sync --recursive
git -C $YCM_DIR submodule update --init --recursive
sudo python3 $YCM_DIR/install.py
