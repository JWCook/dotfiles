#!/usr/bin/env bash
# TODO: manage multiple versions with alternatives
# TODO: distro-specific python config dirs

# Centos
# PYTHON_CONFIG_DIR=/usr/lib/python2.7/config-x86_64-linux-gnu/
# PYTHON3_CONFIG_DIR=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/
# Ubuntu
# PYTHON_CONFIG_DIR=/usr/lib64/python2.7/config/
# PYTHON3_CONFIG_DIR=/usr/lib64/python3.5/config/
# Fedora
PYTHON_CONFIG_DIR=/usr/lib64/python2.7/config/
PYTHON3_CONFIG_DIR=/usr/lib64/python3.5/config-3.5m/
REPO_DIR=/usr/local/src/vim

sudo git -C $REPO_DIR pull || sudo git clone https://github.com/vim/vim $REPO_DIR
cd $REPO_DIR

echo 'Building vim...'
deactivate
sudo make distclean
sudo ./configure \
--with-features=huge \
--with-tlib=ncurses \
--enable-pythoninterp=dynamic \
--with-python-config-dir=$PYTHON_CONFIG_DIR \
--enable-python3interp=dynamic \
--with-python3-config-dir=$PYTHON3_CONFIG_DIR \
--enable-luainterp=dynamic \
--enable-perlinterp=dynamic \
--enable-rubyinterp=dynamic \
--with-x \
--enable-gui=auto \
--with-compiledby=jordan.cook
#--with-vim-name=vim8  # To keep separate from base repo vim

sudo make
sudo make install
