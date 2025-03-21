#!/usr/bin/env bash
REPO_URL=https://github.com/b3nj5m1n/xdg-ninja
REPO_DIR=/tmp/xdg-ninja
git -C $REPO_DIR pull || git clone $REPO_URL $REPO_DIR
cd $REPO_DIR
./xdg-ninja.sh run --skip-unsupported
