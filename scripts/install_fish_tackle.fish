#!/usr/bin/env fish
set CONF_DIR ~/.config/fish
set FISH_PROMPT $CONF_DIR/functions/fish_prompt.fish
set FISH_KEYBINDS $CONF_DIR/functions/fish_user_key_bindings.fish
set ATUIN_KEYBINDS $CONF_DIR/functions/atuin_key_bindings.fish

# First remove any previous symlinks and create parent dirs
rm -f $CONF_DIR/{config.fish,style.fish} $FISH_PROMPT $FISH_KEYBINDS $ATUIN_KEYBINDS $VF_LOADER 2> /dev/null
mkdir -p $CONF_DIR/{completions,conf.d,functions}

# Symlink main files
ln -s (pwd)/fish/config.fish $CONF_DIR/config.fish
ln -s (pwd)/fish/style.fish  $CONF_DIR/style.fish
ln -s (pwd)/fish/functions/fish_prompt.fish $FISH_PROMPT
ln -s (pwd)/fish/functions/atuin_key_bindings.fish $FISH_KEYBINDS
ln -s (pwd)/fish/functions/fish_user_key_bindings.fish $ATUIN_KEYBINDS

# Copy over completions
cp fish/completions/* $CONF_DIR/completions/

# Install Fisher package manager + packages
mkdir -p scripts/bootstrap
curl -sSL https://git.io/fisher -o scripts/bootstrap/get-fisher.fish
source scripts/bootstrap/get-fisher.fish
fisher install jorgebucaran/fisher
fisher install jorgebucaran/nvm.fish
fisher install re3turn/fish-git-util
fisher install PatrickF1/fzf.fish

# Set fish as default shell
sudo chsh -s /usr/bin/fish
