#!/usr/bin/env bash
# Install neovim + its own virtualenv

source install_appimage.sh
install-appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
python3 -m venv ~/.virtualenvs/nvim
