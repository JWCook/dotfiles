#!/bin/bash

curl -fLo vim/vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qall
test -x /usr/bin/vim && \
    /usr/bin/vim +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qall
test -x //usr/local/bin/vim8 && \
    /usr/local/bin/vim8 +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qall
