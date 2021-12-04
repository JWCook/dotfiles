#!/usr/bin/env bash
set -o nounset


PACKAGES='
curl
git
libatlas-base-dev
python3-dev
npm
tig
'

apt-get update
apt-get upgrade -y
apt-get install -y $PACKAGES

sudo snap install nvim --classic
