#!/usr/bin/env bash
PYTHON_VERSIONS='
    3.13
    3.12
    3.11
    3.10
    3.9
    3.8
    3.7
    pypy3.9
    pypy3.10
'
pyenv global "$PYTHON_VERSIONS"
