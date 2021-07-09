#!/usr/bin/env bash
cargo install -f bottom
cargo install -f exa
cargo install -f fd-find
cargo install -f procs

# Generate command completion files
~/.cargo/bin/procs --completion bash
mv procs.bash ~/.config/bash/completions/
~/.cargo/bin/procs --completion fish
mv procs.fish ~/.config/fish/completions/
