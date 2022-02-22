#!/usr/bin/env bash
# TODO: better method of handling global npm packages?

BOOTSTRAPS=scripts/bootstrap
NVM_SCRIPT_URL='https://raw.githubusercontent.com/creationix/nvm/master/install.sh'
NODE_VERSION=16

PKGS_JS='
    neovim
    @vue/cli
    yarn
'
    # doctoc
    # inherits
    # instant-markdown-d


mkdir -p $BOOTSTRAPS
curl -L $NVM_SCRIPT_URL -o $BOOTSTRAPS/install-nvm.sh
bash $BOOTSTRAPS/install-nvm.sh
source ~/.nvm/nvm.sh

nvm install $NODE_VERSION
sudo npm install -g npm@latest
sudo npm install -g $PKGS_JS
