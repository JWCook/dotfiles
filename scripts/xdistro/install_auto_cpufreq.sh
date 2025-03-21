#!/usr/bin/env bash
set -o nounset

REPO=https://github.com/AdnanHodzic/auto-cpufreq.git
REPO_DIR=/usr/local/src/auto-cpufreq

sudo git -C $REPO_DIR pull || sudo git clone --depth 1 $REPO $REPO_DIR
cd $REPO_DIR && sudo ./auto-cpufreq-installer
