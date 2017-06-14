#!/usr/bin/env bash
# GNOME settings

gsettings set org.gnome.desktop.lockdown disable-lock-screen false                          # Make sure screen lock is enabled
gsettings set org.gnome.desktop.session idle-delay 600                                      # Screen black: 10m
gsettings set org.gnome.desktop.screensaver lock-delay 1200                                 # Screen lock: 20m
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'         # Suspend when power button is pressed
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'      # Inactive on AC: do nothing
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1800   # Battery inactivity period: 30m
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend' # Inactive on battery: suspend
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'              # Default to list view in file browser
gsettings set org.gnome.nautilus.preferences search-view 'list-view'                        # Same, but for search results
gsettings set org.gnome.nautilus.preferences default-sort-order 'name'                      # Sort files by name
gsettings set org.gnome.nautilus.preferences show-hidden-files true                         # Show hidden files by default
gsettings set org.gnome.nautilus.list-view default-visible-columns "['name', 'size', 'type', 'owner', 'permissions', 'date_modified']"
