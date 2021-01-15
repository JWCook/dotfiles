#!/usr/bin/env bash

FONT_NAMES='
    3270
    DejaVuSansMono
    DroidSansMono
    FiraCode
    HeavyData
    Hermit
    InconsolataLGC
    Iosevka
    JetBrainsMono
    Mononoki
    OpenDyslexic
    ProggyClean
    Terminus
'
RELEASE_VER='v2.1.0'
RELEASE_BASE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${RELEASE_VER}"
FONT_DIR='~/.local/share/fonts/NerdFonts'
DOWNLOAD_DIR='~/.local/share/fonts/Downloads'

echo 'Downloading patched fonts...'

mkdir -p  $DOWNLOAD_DIR $FONT_DIR
for font_name in $FONT_NAMES; do
    filename=${font_name}.zip
    if ! test -f ${DOWNLOAD_DIR}/${filename}; then
        wget -NP $DOWNLOAD_DIR ${RELEASE_BASE_URL}/${filename}
    fi
done


echo 'Installing fonts...'
unzip "${DOWNLOAD_DIR}/*.zip" -d $FONT_DIR
fc-cache -vf $FONT_DIR
