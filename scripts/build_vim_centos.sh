#!/usr/bin/env bash

# Install compile dependencies for Centos 7. For other releases:
# https://www.rpmfind.net/linux/rpm2html/search.php?query=vim-enhanced
wget -p /tmp/ http://vault.centos.org/7.2.1511/os/Source/SPackages/vim-7.4.160-1.el7.src.rpm
sudo yum-builddep -y /tmp/vim-7.4.160-1.el7.src.rpm
rm /tmp/vim-7.4.160-1.el7.src.rpm

sudo git clone https://github.com/vim/vim /usr/local/src/vim

# TODO: Replace below with call to update script; but first make generic format for build-update scripts?
pushd /usr/local/src/vim/src/
deactivate

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
