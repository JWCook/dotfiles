#!/usr/bin/env fish
CONF_DIR=$CONF_DIR
FISH_PROMPT=$CONF_DIR/functions/fish_prompt.fish
VF_REQUIREMENTS=~/.virtualenvs/global-requirements.txt
VF_LOADER=$CONF_DIR/conf.d/virtualfish-loader.fish

# First remove any previous symlinks and create parent dirs
rm -f $CONF_DIR/{config.fish,style.fish} $FISH_PROMPT, $VF_REQUIREMENTS $VF_LOADER 2> /dev/null
mkdir -p $CONF_DIR/{completions,conf.d,functions}

# Symlink main config files
ln -s (pwd)/fish/config.fish $CONF_DIR/config.fish
ln -s (pwd)/fish/style.fish  $CONF_DIR/style.fish
ln -s (pwd)/fish/functions/fish_prompt.fish $FISH_PROMPT

# Symlink virtualfish config
ln -s (pwd)/fish/conf.d/virtualfish-loader.fish $VF_LOADER
ln -s (pwd)/scripts/requirements-virtualenvs.txt $VF_REQUIREMENTS

# Copy over completions
cp fish/completions/* $CONF_DIR/completions/

# Install Fisher package manager + packages
curl -sSL https://git.io/fisher -o scripts/get-fisher.sh
source scripts/get-fisher.sh
fisher install jorgebucaran/fisher
fisher install re3turn/fish-git-util
fisher install PatrickF1/fzf.fish
