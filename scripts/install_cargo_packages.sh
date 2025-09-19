#!/usr/bin/env bash

# Install rust
command -v rustup &> /dev/null || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
rustup default stable

# Install crates
cat scripts/deps/cargo_crates.txt | xargs cargo install

# Generate command completion files
export PATH=$PATH:$CARGO_HOME:~/.cargo/bin
atuin gen-completions --shell bash > ~/.config/bash/completions/atuin.bash
atuin gen-completions --shell fish > ~/.config/fish/completions/atuin.fish
procs --gen-completion-out bash > ~/.config/bash/completions/procs.bash
procs --gen-completion-out fish > ~/.config/fish/completions/procs.fish
just --completions fish > ~/.config/fish/completions/just.fish
just --completions bash > ~/.config/bash/completions/just.bash

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
