#!/bin/bash

source bash/bashrc

if cmd-exists pyenv; then
    echo hi
else
    type -a pyenv || curl https://pyenv.run | bash
fi

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pyenv install 3.6.12
pyenv install 3.7.9
pyenv install 3.9.0rc1
