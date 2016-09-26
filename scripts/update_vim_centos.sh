#!/usr/bin/env bash

pushd /usr/local/src/vim/src/
deactivate
sudo git pull

sudo make distclean
sudo ./configure \
--with-features=huge \
--enable-pythoninterp=dynamic \
--with-python-config-dir=/usr/lib64/python2.7/config/ \
--enable-luainterp=dynamic \
--enable-perlinterp=dynamic \
--enable-rubyinterp=dynamic \
--with-x \
--enable-gui=auto \
--with-compiledby=jordan.cook
# --with-vim-name=vim7  # To keep separate from base repo vim

sudo make
sudo make install
popd
