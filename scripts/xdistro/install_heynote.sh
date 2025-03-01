#!/usr/bin/env bash
set -o nounset
source utils/install_appimage.sh
install-appimage \
    https://github.com/heyman/heynote/releases/latest/download/Heynote_1.8.0_x86_64.AppImage \
    heynote

# Disable AppImage sandbox restrictions for Ubuntu 24.04
# See: https://github.com/arduino/arduino-ide/issues/2429#issuecomment-2099775010
sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
