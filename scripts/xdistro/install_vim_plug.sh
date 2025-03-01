#!/bin/bash
PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fsSL $PLUG_URL --create-dirs -o vim/vim/autoload/plug.vim
curl -fsSL $PLUG_URL --create-dirs -o ~/.local/share/nvim/site/autoload/plug.vim
nvim +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qall
test -x /usr/bin/vim && /usr/bin/vim +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qall
