#!/usr/bin/env bash
# For when the local python environments are messed up beyond repair
# Run install_python_tools.sh afterward

python scripts/bootstrap/install-poetry.py --uninstall
rm -f ~/.local/bin/{poetry,uv,uvx}
rm -rf ~/.local/share/{pypoetry,uv}
rm -rf ~/.cache/{pip,pypoetry,uv}
rm -rf ~/.poetry
rm -rf ~/.pyenv
rm -rf ~/.miniconda
rm -rf ~/.virtualenvs
