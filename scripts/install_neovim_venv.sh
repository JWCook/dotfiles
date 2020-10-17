#!/usr/bin/env bash
# Install neovim python dependencies in their own virtualenv

python3 -m venv ~/.virtualenvs/nvim
source ~/.virtualenvs/nvim/bin/activate
pip install -U pip jedi pynvim vim-vint
deactivate
