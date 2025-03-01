#!/usr/bin/env bash
# Install KiTTY Terminal: https://sw.kovidgoyal.net/kitty/binary
SHORTCUT=~/.local/share/applications/kitty.desktop

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
cp ~/.local/kitty.app/share/applications/kitty.desktop $SHORTCUT
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" $SHORTCUT
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" $SHORTCUT
