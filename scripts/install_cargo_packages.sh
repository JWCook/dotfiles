#!/usr/bin/env bash
cargo install -f bottom
cargo install -f exa
cargo install -f fd-find
cargo install -f procs

# Generate command completion files
procs --completion bash
mv procs.bash ~/.config/bash/completions/
procs --completion fish
mv procs.fish ~/.config/fish/completions/
