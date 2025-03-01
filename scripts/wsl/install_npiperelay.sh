#!/usr/bin/env bash
set -o nounset

tmp_path=/tmp/npiperelay.zip
# install_path=$(wslpath "C:/Program Files/npiperelay")
install_path=$(wslpath "C:/npiperelay")
curl -Lf 'https://github.com/jstarks/npiperelay/releases/latest/download/npiperelay_windows_amd64.zip' \
    -o $tmp_path
unzip -o $tmp_path -d "$install_path" && rm $tmp_path
