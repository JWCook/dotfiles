#!/usr/bin/env bash
FONT_REPO='https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts'
echo 'Installing patched fonts...'
mkdir -p ~/.fonts
mkfontdir ~/.fonts

wget -P ~/.fonts ${FONT_REPO}/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf
# wget -P ~/.fonts ${FONT_REPO}/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Windows%20Compatible.ttf
wget -P ~/.fonts ${FONT_REPO}/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf
# wget -P ~/.fonts ${FONT_REPO}/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Windows%20Compatible.ttf
xset +fp ~/.fonts
fc-cache -vf ~/.fonts
echo 'Done. Set terminal font to DejaVuSansMono'

