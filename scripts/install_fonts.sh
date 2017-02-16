#!/usr/bin/env bash

	echo 'Installing patched fonts...'
	mkdir -p ~/.fonts
	mkfontdir ~/.fonts
	wget -P ~/.fonts https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.ttf
	wget -P ~/.fonts https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf
	xset +fp ~/.fonts
	fc-cache -vf ~/.fonts
	echo 'Done. Set terminal font to DejaVuSansMono'

