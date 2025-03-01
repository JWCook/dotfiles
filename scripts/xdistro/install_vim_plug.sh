#!/bin/bash
PLUG_URL=https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo vim/vim/autoload/plug.vim --create-dirs $PLUG_URL
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs $PLUG_URL
nvim +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qall
test -x /usr/bin/vim && /usr/bin/vim +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qall
