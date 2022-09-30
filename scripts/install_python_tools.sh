#!/usr/bin/env bash
FISH_COMPLETE_DEST=~/.config/fish/completions/poetry.fish
BASH_COMPLETE_DEST=~/.config/bash/completions/poetry.bash-completion
BOOTSTRAPS=scripts/bootstrap

# Python versions to install and activate with pyenv
# Note: The first version in list will be used as the default 'python3' version
PYTHON_VERSIONS='
    3.10.4
    3.6.15
    3.7.13
    3.8.13
    3.9.12
    3.11.0rc2
'

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
    curl -L https://install.python-poetry.org/install-poetry.py -o $BOOTSTRAPS/install-poetry.py
    curl -L http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o $BOOTSTRAPS/get-miniconda.sh
fi

# Ensure we have the latest pip (usually only necessary if current pip is broken)
print-title 'Installing/updating pip'
python3 $BOOTSTRAPS/get-pip.py

# Install pyenv
print-title 'Installing/updating pyenv'
if cmd-exists pyenv; then
    pyenv update
else
    bash $BOOTSTRAPS/get-pyenv.sh
fi
pathadd ~/.pyenv/bin/
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Install pyenv-virtualenvwrapper plugin from source
# git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper

# Install python versions
for version in $PYTHON_VERSIONS; do
    pyenv install $PYENV_OPTS $version
done
pyenv global $PYTHON_VERSIONS
python3 --version

# Install poetry
print-title 'Installing/updating poetry'
if cmd-exists poetry; then
    poetry self update
else
    python $BOOTSTRAPS/install-poetry.py --preview
    poetry config virtualenvs.path ~/.virtualenvs
    poetry config virtualenvs.create false
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

# Install some user-level site-packages
print-title 'Installing/updating user packages'
python3.10 -m pip install --user -Ur scripts/requirements-user.txt

# Install or update some python CLI tools with pipx
if test -z $UPDATE_ONLY; then
    while read package; do
        pipx install $package
    done < scripts/requirements-pipx.txt
else
    pipx upgrade-all
fi


# Make virtualenv for neovim
if ! lsvirtualenv | grep -q nvim; then
    source $(which virtualenvwrapper.sh)
    mkvirtualenv nvim
    pip install -U pip jedi pynvim vim-vint
    deactivate
fi
