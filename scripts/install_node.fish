#!/usr/bin/env fish
# Install node tools and versions
set NODE_VERSIONS 18 20 22 24 latest
set DEFAULT_NODE_VERSION 24

# Install nvm (bash)
mkdir -p bootstrap
curl -fsSL 'https://raw.githubusercontent.com/creationix/nvm/master/install.sh' \
    -o bootstrap/install-nvm.sh
bash bootstrap/install-nvm.sh

# Install nvm (fish)
fisher install jorgebucaran/nvm.fish

# Install node versions
for node_version in $NODE_VERSIONS
    nvm install "$node_version"
end

# Set default node version
bash -c "source ~/.nvm/nvm.sh && nvm alias default $DEFAULT_NODE_VERSION"
set -U nvm_default_version $DEFAULT_NODE_VERSION

# Install NPM pacakges
npm install -g npm@latest
npm install -g neovim yarn
