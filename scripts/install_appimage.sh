#!/usr/bin/env bash
APPIMAGE_DIR=/usr/appimage
APP_BIN_DIR=/usr/bin

# Download and symlink an AppImage
install-appimage() {
    url=$1
    filename=$(basename $url | tr '[:upper:]' '[:lower:]')
    dest_path=${APPIMAGE_DIR}/$filename
    symlink_path=${APP_BIN_DIR}/$(basename $filename .appimage)

    sudo mkdir -p $APPIMAGE_DIR
    sudo curl -L $url -o $dest_path
    sudo chmod +x $dest_path

    # Symlink to binary dir; backup file if it already exists
    [ -f $symlink_path ] && sudo mv -v $symlink_path $symlink_path.old
    sudo ln -sv $dest_path $symlink_path
}
