#!/usr/bin/env fish
set dl_url https://developers.yubico.com/yubioath-flutter/Releases/yubico-authenticator-latest-linux.tar.gz
set dl_temp /tmp/yubico.tar.gz
set install_dir ~/.local/share/yubico-auth

# Download and extract
echo 'Installing Yubico Authenticator'
curl -SsL $dl_url -o $dl_temp
tar xf /tmp/yubico.tar.gz --directory=$HOME/.local/share/
set app_dirname (ls ~/.local/share | grep '^yubico-' | head -n 1)
rm -rf $install_dir
mv ~/.local/share/$app_dirname $install_dir
rm $dl_temp

# Symlink and install desktop file
rm ~/.local/bin/yubico-auth
ln -s $install_dir/authenticator ~/.local/bin/yubico-auth
$install_dir/desktop_integration.sh --install
