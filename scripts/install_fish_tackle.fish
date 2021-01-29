#!/usr/bin/env fish

# First remove any previous symlinks and create parent dirs
rm -f ~/.config/fish/{config.fish,style.fish,completions,functions} 2> /dev/null
mkdir -p ~/.config/fish/{completions,functions}

# Symlink main config files
ln -s (pwd)/fish/config.fish ~/.config/fish/config.fish
ln -s (pwd)/fish/style.fish  ~/.config/fish/style.fish

# Copy over completions and functions
cp fish/completions/* ~/.config/fish/completions/
cp fish/functions/*   ~/.config/fish/functions/

# Install Fisher package manager + packages
curl -sL https://git.io/fisher | source
fisher install jorgebucaran/fisher
fisher install re3turn/fish-git-util
fisher install PatrickF1/fzf.fish