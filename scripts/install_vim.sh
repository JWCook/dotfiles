#!/usr/bin/env bash
# TODO: manage multiple versions with alternatives

PYTHON_CONFIG_DIR=/usr/lib/python2.7/config-x86_64-linux-gnu/
PYTHON3_CONFIG_DIR=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/
# PYTHON_CONFIG_DIR=/usr/lib64/python2.7/config/
# PYTHON3_CONFIG_DIR=/usr/lib64/python3.5/config/

cd /usr/local/src/vim/
deactivate
sudo git pull

echo 'Building vim...'
sudo make distclean
sudo ./configure \
--with-features=huge \
--enable-pythoninterp=dynamic \
--with-python-config-dir=$PYTHON_CONFIG_DIR \
--enable-python3interp=dynamic \
--with-python3-config-dir=$PYTHON3_CONFIG_DIR \
--enable-luainterp=dynamic \
--enable-perlinterp=dynamic \
--enable-rubyinterp=dynamic \
--with-x \
--enable-gui=auto \
--with-compiledby=jordan.cook \
--with-vim-name=vim8  # To keep separate from base repo vim

sudo make
sudo make install
