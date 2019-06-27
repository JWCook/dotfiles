#!/usr/bin/env bash

# Install compile dependencies for building vim from source on Fedora 30
# For other Fedora-based distros/ releases:
# https://www.rpmfind.net/linux/rpm2html/search.php?query=vim-enhanced
sudo dnf builddep -y vim-enhanced

# Set LDFLAGS: https://github.com/vim/vim/issues/1080#issuecomment-269920486
eval $(rpmbuild --eval '%{configure}' | egrep '^\s*[A-Z]+=')
