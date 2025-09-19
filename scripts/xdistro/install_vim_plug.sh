#!/bin/bash
# Bootstrap installer for (vanilla) vim plugin manager
PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fsSL $PLUG_URL --create-dirs -o vim/vim/autoload/plug.vim
test -x /usr/bin/vim && /usr/bin/vim +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qall
