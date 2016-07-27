install: install-bash install-postgres install-vim install-fonts iinstall-grc nstall-htop install-pep8 install-terminator

install-bash:
	rm -rf ~/.bashrc
	rm -rf ~/.bashrc_style
	rm -rf ~/.bash_profile
	rm -rf ~/.bash_logout
	ln -s `pwd`/bash/bashrc ~/.bashrc
	ln -s `pwd`/bash/bashrc_style ~/.bashrc_style
	ln -s `pwd`/bash/bash_profile ~/.bash_profile
	ln -s `pwd`/bash/bash_logout ~/.bash_logout

install-postgres:
	rm -rf ~/.psqlrc
	ln -s `pwd`/postgres/psqlrc ~/.psqlrc

install-vim:
	rm -rf ~/.vim
	rm -rf ~/.vimrc
	ln -s `pwd`/vim/vimrc  ~/.vimrc
	ln -s `pwd`/vim/vim  ~/.vim

install-fonts:
	echo 'Installing Powerline-patched fonts...'
	mkdir -p ~/.fonts
	wget -P ~/.fonts https://github.com/powerline/fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf
	wget -P ~/.fonts https://raw.githubusercontent.com/powerline/fonts/master/DejaVuSansMono/fonts.dir
	wget -P ~/.fonts https://raw.githubusercontent.com/powerline/fonts/master/DejaVuSansMono/fonts.scale
	xset +fp ~/.fonts
	fc-cache -vf ~/.fonts/
	echo 'Done. Set terminal font to DejaVuSansMono'

install-grc:
	rm -rf ~/.grc
	ln -s `pwd`/grc ~/.grc

install-htop:
	rm -rf ~/.config/htop
	ln -s `pwd`/htop ~/.config/htop

install-pep8:
	rm -rf ~/.config/pep8
	rm -rf ~/.config/flake8
	ln -s `pwd`/pep8/pep8  ~/.config/pep8
	ln -s `pwd`/pep8/flake8  ~/.config/flake8

install-terminator:
	rm -rf ~/.config/terminator
	ln -s `pwd`/terminator ~/.config/terminator
