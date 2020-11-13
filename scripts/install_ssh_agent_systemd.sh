#!/bin/bash
USER_SYSTEMD_DIR=~/.config/systemd/user/

mkdir -p $USER_SYSTEMD_DIR
cp ssh/ssh-agent.service $USER_SYSTEMD_DIR/
systemctl --user enable ssh-agent
systemctl --user start ssh-agent

# Add to bashrc or other startup script:
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
