#!/usr/bin/env bash
GIT_COMPLETION_SCRIPT=https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

echo "Installing git bash completion..."
source bash/bashrc
mkdir -p $BASH_COMPLETIONS
curl -fsSL $GIT_COMPLETION_SCRIPT -o $BASH_COMPLETIONS/git-completion.bash
