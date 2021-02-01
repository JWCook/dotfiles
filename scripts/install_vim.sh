#!/usr/bin/env bash
# TODO: manage multiple versions with alternatives
# TODO: distro-specific python config dirs

# Ubuntu
PYTHON3_CONFIG_DIR=/usr/lib/python3.8/config-3.8-x86_64-linux-gnu/
# Fedora
# PYTHON3_CONFIG_DIR=/usr/lib64/python3.8/config-3.8m-x86_64-linux-gnu/

REPO=https://github.com/vim/vim
REPO_DIR=/usr/local/src/vim

# Clone to a new directory if installing for the first time, or otherwise pull if it's already cloned
sudo mkdir -p $REPO_DIR
sudo git -C $REPO_DIR pull || sudo git clone $REPO $REPO_DIR
cd $REPO_DIR

echo 'Building vim...'
deactivate
sudo make distclean
sudo ./configure \
--with-features=huge \
--enable-fail-if-missing \
--with-tlib=ncurses \
--enable-python3interp=dynamic \
--with-python3-config-dir=$PYTHON3_CONFIG_DIR \
--with-x \
--enable-gui=auto \
--with-compiledby=jordan.cook \
--with-vim-name=vim8  # To keep separate from main vim
# --enable-pythoninterp=dynamic \
# --with-python-config-dir=$PYTHON_CONFIG_DIR \
# --enable-luainterp=dynamic \
# --enable-perlinterp=dynamic \
# --enable-rubyinterp=dynamic

sudo make
sudo make install
