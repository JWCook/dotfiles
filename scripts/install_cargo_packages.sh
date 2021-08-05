#!/usr/bin/env bash
cargo install -f bottom
cargo install -f du-dust
cargo install -f hyperfine
cargo install -f exa
cargo install -f fd-find
cargo install -f git-delta
cargo install -f gping
cargo install -f procs
# cargo install --git https://github.com/ogham/dog dog

# Generate command completion files
~/.cargo/bin/procs --completion bash
mv procs.bash ~/.config/bash/completions/
~/.cargo/bin/procs --completion fish
mv procs.fish ~/.config/fish/completions/
