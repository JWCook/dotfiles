#!/bin/bash -
FISH_COMPLETE_DEST=~/.config/fish/completions/poetry.fish
BASH_COMPLETE_DEST=/etc/bash_completion.d/poetry.bash-completion

curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
fish -c "poetry completions fish > $FISH_COMPLETE_DEST"
poetry completions bash > poetry.bash-completion
sudo mv poetry.bash-completion $BASH_COMPLETE_DEST
sudo chown root:root $BASH_COMPLETE_DEST
