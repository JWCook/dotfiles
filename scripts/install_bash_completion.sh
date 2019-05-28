#!/usr/bin/env bash

GIT_COMPLETION_SCRIPT=https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

echo "Installing git bash completion..."
curl $GIT_COMPLETION_SCRIPT -o ~/.git-completion.bash
