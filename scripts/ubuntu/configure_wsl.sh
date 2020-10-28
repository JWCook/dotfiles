#!/bin/bash -
WORKSPACE=/mnt/d/Workspace

ln -s $WORKSPACE ~/workspace
sudo apt-get install -y xfce4-terminal


echo 'Configuring SSH for git'
cat << EOF >> ~/.ssh/config

Host github
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_rsa

EOF
