#!/bin/bash

source bash/bashrc

type -a pyenv &> /dev/null || curl https://pyenv.run | bash
eval "$(~/.pyenv/bin/pyenv init -)"
eval "$(~/.pyenv/bin/pyenv virtualenv-init -)"

pathadd ~/.pyenv/bin/
pyenv install 3.6.12
pyenv install 3.7.9
pyenv install 3.8.6
pyenv install 3.9.0
pyenv global 3.8.6
