#!/usr/bin/env bash
# For when the local python environments are messed up beyond repair
# Run install_python_tools.sh afterward

python scripts/bootstrap/install-poetry.py --uninstall
rm -rf ~/.local/share/pypoetry
rm -f ~/.local/bin/poetry
rm -rf ~/.poetry
rm -rf ~/.pyenv
rm -rf ~/.miniconda
rm -rf ~/.virtualenvs
