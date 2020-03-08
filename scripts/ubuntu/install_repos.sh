#!/usr/bin/env bash
# Install additional repos for Ubuntu

sudo apt-add-repository ppa:fish-shell/release-3
# Docker CE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

