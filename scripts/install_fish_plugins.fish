#!/usr/bin/env fish
# Install Fisher package manager + packages
mkdir -p scripts/bootstrap
curl -sSL https://git.io/fisher -o scripts/bootstrap/get-fisher.fish
source scripts/bootstrap/get-fisher.fish
fisher install jorgebucaran/fisher
fisher install jorgebucaran/nvm.fish
fisher install re3turn/fish-git-util
fisher install PatrickF1/fzf.fish
