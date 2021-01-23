#!/usr/bin/env bash
# Install neovim python dependencies in their own virtualenv

source ~/.bashrc
mkvirtualenv nvim
pip install -U pip jedi pynvim vim-vint
deactivate
