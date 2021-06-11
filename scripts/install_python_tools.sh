#!/bin/bash -
FISH_COMPLETE_DEST=~/.config/fish/completions/poetry.fish
BASH_COMPLETE_DEST=~/.config/bash/completions/poetry.bash-completion
BOOTSTRAPS=scripts/bootstrap
DEFAULT_PYTHON=3.9.5
source bash/bashrc
source bash/bashrc_style

# Use -u (upgrade) to only install new python versions if missing
PYENV_OPTS='-f'
UPDATE_ONLY=
while getopts "u" option; do
    case "${option}" in
        u)
            PYENV_OPTS='-s'
            UPDATE_ONLY='true';;
    esac
done


# Download bootstrap scripts
if test -z $UPDATE_ONLY; then
    print-title 'Downloading install scripts'
    mkdir -p $BOOTSTRAPS
    curl -L https://bootstrap.pypa.io/get-pip.py -o $BOOTSTRAPS/get-pip.py
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer -o $BOOTSTRAPS/get-pyenv.sh
    curl -L https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py -o $BOOTSTRAPS/install-poetry.py
    curl -L http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o $BOOTSTRAPS/get-miniconda.sh
fi

# Ensure we have the latest pip (usually only necessary if current pip is broken)
print-title 'Installing/updating pip'
python $BOOTSTRAPS/get-pip.py

# Install pyenv
print-title 'Installing/updating pyenv'
if cmd-exists pyenv; then
    pyenv update
else
    python $BOOTSTRAPS/get-pyenv.sh
fi
pathadd ~/.pyenv/bin/
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Install python versions
pyenv install $PYENV_OPTS 3.6.12
pyenv install $PYENV_OPTS 3.7.10
pyenv install $PYENV_OPTS 3.8.10
pyenv install $PYENV_OPTS 3.9.5
pyenv install $PYENV_OPTS 3.10.0b1
pyenv global $DEFAULT_PYTHON

# Install poetry
print-title 'Installing/updating poetry'
if cmd-exists poetry; then
    poetry self update
else
    python $BOOTSTRAPS/install-poetry.py
    poetry config virtualenvs.path ~/.virtualenvs
fi

# Install poetry shell completions
mkdir -p $(dirname $BASH_COMPLETE_DEST)
mkdir -p $(dirname $FISH_COMPLETE_DEST)
bash -c "poetry completions bash > $BASH_COMPLETE_DEST"
fish -c "poetry completions fish > $FISH_COMPLETE_DEST"

# Install miniconda
print-title 'Installing/updating miniconda'
if cmd-exists conda; then
    conda update --yes conda conda-build python
else
    bash $BOOTSTRAPS/get-miniconda.sh -b -p ~/.miniconda
    pathadd ~/.miniconda/bin
    conda update --yes conda python
    conda install -y conda-build
fi

# Install some tools in user-level site-packages
print-title 'Installing/updating user packages'
pip install --user -Ur scripts/requirements-user.txt

# Make virtualenv for neovim
if ! lsvirtualenv | grep -q nvim; then
    source $(which virtualenvwrapper.sh)
    mkvirtualenv nvim
    pip install -U pip jedi pynvim vim-vint
    deactivate
fi
