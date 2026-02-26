#!/usr/bin/env fish
set BOOTSTRAPS ./bootstrap
set FISH_COMPLETE_DEST ~/.config/fish/completions/poetry.fish
set BASH_COMPLETE_DEST ~/.config/bash/completions/poetry.bash-completion
set PYTHON_VERSIONS \
    3.13 \
    3.12 \
    3.11 \
    3.10 \
    3.9 \
    3.8 \
    3.7 \
    pypy3.9 \
    pypy3.10


# Read arguments
argparse u/update -- $argv
set UPDATE_ONLY (set -q _flag_update && echo true || echo false)

# Boostrap scripts
# ----------------------------------------

if not $UPDATE_ONLY
    echo "Downloading install scripts"
    mkdir -p $BOOTSTRAPS
    curl -fsSL https://install.python-poetry.org/install-poetry.py -o $BOOTSTRAPS/install-poetry.py
    curl -fsSL https://astral.sh/uv/install.sh -o $BOOTSTRAPS/install-uv.sh
    chmod +x $BOOTSTRAPS/*
end

# uv
# ----------------------------------------

echo "Installing/updating uv"
if type -q uv
    uv self update
else
    sh $BOOTSTRAPS/install-uv.sh

    # Install python interpreters
    uv python install $PYTHON_VERSIONS
    uv python install --preview $PYTHON_VERSIONS[1]
    set default_python "~/.local/bin/python{$PYTHON_VERSIONS[1]}"
    test -f $default_python \
        && rm -f ~/.local/bin/python \
        && ln -s $default_python ~/.local/bin/python
end

# poetry
# ----------------------------------------

echo "Installing/updating poetry"
if type -q poetry
    poetry self update
else
    $BOOTSTRAPS/install-poetry.py
    poetry config virtualenvs.path ~/.virtualenvs
    poetry config virtualenvs.create false
    poetry self add poetry-plugin-export@latest
end

# Install poetry shell completions
mkdir -p (dirname $BASH_COMPLETE_DEST)
mkdir -p (dirname $FISH_COMPLETE_DEST)
bash -c "poetry completions bash > $BASH_COMPLETE_DEST"
fish -c "poetry completions fish > $FISH_COMPLETE_DEST"

# CLI tools
# ----------------------------------------

# Install or update some python CLI tools with uv
echo "Installing/updating CLI tools"
if not $UPDATE_ONLY
    while read -l package
        echo $package | xargs uv tool install
    end <scripts/deps/py-tools.txt
    # optional:
    # ~/.local/share/uv/tools/aider-chat/bin/python -m playwright install --with-deps chromium
else
    uv tool upgrade --all
end

# Neovim virtualenv
# ----------------------------------------

echo "Installing packages for neovim plugins"
mkdir -p ~/.virtualenvs
set NVIM_VENV ~/.virtualenvs/nvim
if ! test -d "$NVIM_VENV"
    uv run python -m venv "$NVIM_VENV"
end
source "$NVIM_VENV/bin/activate.fish"
uv run python -m pip install -U pip jedi pynvim vim-vint
