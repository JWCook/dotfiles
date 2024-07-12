#!/usr/bin/env bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

rm -f ~/.config/tmux/tmux.conf
mkdir -p ~/.config/tmux
ln -s `pwd`/tmux/tmux.conf ~/.config/tmux/tmux.conf

ln -s `pwd`/neovim/init.lua ~/.config/nvim/init.lua
ln -s `pwd`/neovim/lua ~/.config/nvim/lua
