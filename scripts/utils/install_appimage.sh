#!/usr/bin/env bash
set -e
set -o nounset
APPIMAGE_DIR=/usr/appimage
APP_BIN_DIR=/usr/bin

# Download and symlink an AppImage
install-appimage() {
    url="$1"
    default_filename="$(basename --suffix .appimage --suffix .AppImage $url | tr '[:upper:]' '[:lower:]')"
    filename=${2:-$default_filename}
    dest_path="${APPIMAGE_DIR}/$filename.appimage"
    symlink_path="${APP_BIN_DIR}/$filename"

    echo "Downloading ${url}"
    sudo mkdir -p "$APPIMAGE_DIR"
    sudo curl -L "$url" -o "$dest_path"
    sudo chmod +x "$dest_path"

    # Symlink to binary dir; backup (non-symlink) file if it already exists
    test -e "$symlink_path" && sudo mv -v "$symlink_path" "${symlink_path}.old"
    sudo rm -f "$symlink_path"
    sudo ln -sv "$dest_path" "$symlink_path"
    echo "Installed to $symlink_path"
}
