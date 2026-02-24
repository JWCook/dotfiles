#!/bin/bash
USER_SYSTEMD_DIR=~/.config/systemd/user/

mkdir -p $USER_SYSTEMD_DIR
cp scripts/ssh-agent.service $USER_SYSTEMD_DIR/
systemctl --user enable ssh-agent
systemctl --user start ssh-agent

mkdir -p ~/.config/environment.d
echo 'SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket' > ~/.config/environment.d/ssh-agent.conf

# And/or add to bashrc or other startup script:
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
