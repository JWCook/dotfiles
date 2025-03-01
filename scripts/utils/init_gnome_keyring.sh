#!/usr/bin/env bash
# Create a gnome-keyring init file
dbus-launch --sh-syntax > ~/.gnome-keyring
gnome-keyring-daemon >> ~/.gnome-keyring
