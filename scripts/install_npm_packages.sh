#!/usr/bin/env bash
# TODO: better method of handling global npm packages?

PKGS_JS='
    neovim
    @vue/cli
    yarn
'
    # doctoc
    # inherits
    # instant-markdown-d
sudo npm install -g npm@latest
sudo npm install -g $PKGS_JS
