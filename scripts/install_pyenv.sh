#!/bin/bash

source bash/bashrc

type -a pyenv || curl https://pyenv.run | bash
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pyenv install 3.6.12
pyenv install 3.7.9
pyenv install 3.8.6
pyenv install 3.9.0
