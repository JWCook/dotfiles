#!/usr/bin/env bash -
# Create a gnome-keyring init file
echo `dbus-launch --sh-syntax` > ~/.gnome-keyring
gnome-keyring-daemon >> ~/.gnome-keyring
