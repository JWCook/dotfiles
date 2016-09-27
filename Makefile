install: install-bash install-fonts install-git install-grc install-htop install-ipython install-pep8 install-postgres install-terminator install-vim

install-bash:
	rm -rf ~/.bashrc
	rm -rf ~/.bashrc_style
	rm -rf ~/.bash_profile
	rm -rf ~/.bash_logout
	ln -s `pwd`/bash/bashrc       ~/.bashrc
	ln -s `pwd`/bash/bashrc_style ~/.bashrc_style
	ln -s `pwd`/bash/bash_profile ~/.bash_profile
	ln -s `pwd`/bash/bash_logout  ~/.bash_logout

install-fonts:
	echo 'Installing patched fonts...'
	mkdir -p ~/.fonts
	wget -P ~/.fonts https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.ttf
	wget -P ~/.fonts https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20for%20Powerline%20Nerd%20Font%20Complete.otf
	xset +fp ~/.fonts
	fc-cache -vf ~/.fonts
	echo 'Done. Set terminal font to DejaVuSansMono'

install-git:
	rm -rf ~/.gitconfig
	ln -s `pwd`/git/gitconfig ~/.gitconfig

install-grc:
	rm -rf ~/.grc
	ln -s `pwd`/grc ~/.grc

install-htop:
	rm -rf ~/.config/htop
	ln -s `pwd`/htop ~/.config/htop

install-ipython:
	mkdir -p ~/.ipython/profile_default
	rm -rf ~/.ipython/profile_default/ipython_config.py
	rm -rf ~/.ipython/profile_default/startup
	ln -s `pwd`/ipython/profile_default/ipython_config.py  ~/.ipython/profile_default/ipython_config.py
	ln -s `pwd`/ipython/profile_default/startup            ~/.ipython/profile_default/startup

install-pep8:
	rm -rf ~/.config/pep8
	rm -rf ~/.config/flake8
	ln -s `pwd`/pep8/pep8    ~/.config/pep8
	ln -s `pwd`/pep8/flake8  ~/.config/flake8

install-postgres:
	rm -rf ~/.psqlrc
	ln -s `pwd`/postgres/psqlrc ~/.psqlrc

install-terminator:
	rm -rf ~/.config/terminator
	ln -s `pwd`/terminator ~/.config/terminator

install-vim:
	rm -rf ~/.vim
	rm -rf ~/.vimrc
	ln -s `pwd`/vim/vimrc  ~/.vimrc
	ln -s `pwd`/vim/vim  ~/.vim
