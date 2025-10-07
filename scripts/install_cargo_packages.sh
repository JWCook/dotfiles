#!/usr/bin/env bash

# Install crates
cat scripts/deps/cargo_crates.txt | xargs cargo install

# TODO: move this somewhere else

# Download git-delta themes
curl -fsSL \
    https://raw.githubusercontent.com/dandavison/delta/main/themes.gitconfig \
    -o ~/.config/themes.gitconfig

# Install bash pre-exec (for atuin support)
curl -fsSL https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh \
    -o ~/.config/bash/preexec.sh

# Install yazi plugins
ya pkg add yazi-rs/plugins:full-border || echo
ya pkg add yazi-rs/plugins:git || echo
