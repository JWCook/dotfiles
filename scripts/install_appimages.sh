#!/usr/bin/env bash
APPIMAGE_DIR=/usr/appimage
APP_BIN_DIR=/usr/bin

# Download and symlink an AppImage
install-appimage() {
    url=$1
    dest_path=${APPIMAGE_DIR}/$(basename $url)
    symlink_path=${APP_BIN_DIR}/$(basename $url .appimage)

    sudo mkdir -p $APPIMAGE_DIR
    sudo curl -L $url -o $dest_path
    sudo chmod +x $dest_path

    # Symlink to binary dir; backup file if it already exists
    [ -f $symlink_path ] && sudo mv -v $symlink_path $symlink_path.old
    sudo ln -sv $dest_path $symlink_path
}


# Install neovim + its own virtualenv
install-appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
python3 -m venv ~/.virtualenvs/nvim
