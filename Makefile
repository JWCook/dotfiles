# TODO: prompt for distro & window manager
# Cross-platform packages & config

install-conf: install-bash-conf \
	          install-figlet-conf \
	          install-git-conf \
	          install-grc-conf \
	          install-htop-conf \
	          install-ipython-conf \
	          install-pep8-conf \
	          install-postgres-conf \
	          install-terminator-conf \
	          install-vim-conf

install-pkgs: install-fonts \
	          install-haroopad \
	          install-grc \
	          install-ruby-gems \
	          install-js-packages

update: update-python update-ruby update-vim

# Distro-specific packages

install-pkgs-centos: install-system-packages-centos \
	                 install-vim-centos\
	                 install-chrome-centos \
	                 install-retroterm-centos \
	                 install-pkgs

update-centos: update\
		update-system-packages-centos

install-pkgs-ubuntu: install-system-packages-ubuntu \
	                 install-chrome-ubuntu \
	                 install-vim-ubuntu \
	                 install-pkgs

update-ubuntu: update\
		update-system-packages-ubuntu


#########################
# Runtime Configuration #
#########################

install-bash-conf:
	rm -rf ~/.bashrc
	rm -rf ~/.bashrc_style
	rm -rf ~/.bash_profile
	rm -rf ~/.bash_logout
	ln -s `pwd`/bash/bashrc       ~/.bashrc
	ln -s `pwd`/bash/bashrc_style ~/.bashrc_style
	ln -s `pwd`/bash/bash_profile ~/.bash_profile
	ln -s `pwd`/bash/bash_logout  ~/.bash_logout

install-figlet-conf:
	rm -rf ~/.figlet
	ln -s `pwd`/figlet ~/.figlet

install-git-conf:
	rm -rf ~/.gitconfig
	ln -s `pwd`/git/gitconfig ~/.gitconfig

install-grc-conf:
	rm -rf ~/.grc
	ln -s `pwd`/grc ~/.grc

install-htop-conf:
	rm -rf ~/.config/htop
	ln -s `pwd`/htop ~/.config/htop

install-ipython-conf:
	mkdir -p ~/.ipython/profile_default
	rm -rf ~/.ipython/profile_default/ipython_config.py
	rm -rf ~/.ipython/profile_default/startup
	ln -s `pwd`/ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py
	ln -s `pwd`/ipython/profile_default/startup           ~/.ipython/profile_default/startup

install-pep8-conf:
	rm -rf ~/.config/pep8
	rm -rf ~/.config/flake8
	ln -s `pwd`/pep8/pep8    ~/.config/pep8
	ln -s `pwd`/pep8/flake8  ~/.config/flake8

install-postgres-conf:
	rm -rf ~/.psqlrc
	ln -s `pwd`/postgres/psqlrc ~/.psqlrc

install-terminator-conf:
	rm -rf ~/.config/terminator
	ln -s `pwd`/terminator ~/.config/terminator

install-vim-conf:
	rm -rf ~/.vim
	rm -rf ~/.vimrc
	ln -s `pwd`/vim/vimrc  ~/.vimrc
	ln -s `pwd`/vim/vim  ~/.vim


#####################
# Packages: General #
#####################

install-fonts:
	scripts/install_fonts.sh

install-haroopad:
	scripts/install_haroopad.sh

install-grc:
	scripts/install_grc.sh

install-js-packages:
	scripts/install_js_packages.sh

install-ruby-gems:
	sudo gem install -g scripts/Gemfile

update-python:
	sudo -H pip install -Ur scripts/requirements-global.txt

update-ruby:
	sudo gem update

update-vim:
	scripts/install_vim.sh


####################
# Packages: CentOS #
####################

install-system-packages-centos:
	scripts/centos/install_system_packages.sh

install-vim-centos:
	scipts/centos/install_vim_prereqs.sh
	scripts/install_vim.sh
	scripts/install_vim_plug.sh

install-chrome-centos:
	scripts/centos/install_chrome.sh

install-retroterm-centos:
	scripts/centos/install_retroterm.sh

update-system-packages-centos:
	sudo yum update -y


#####################
# Packages: Ubuntu #
#####################

install-system-packages-ubuntu:
	scripts/ubuntu/install_system_packages.sh

install-vim-ubuntu:
	scripts/ubuntu/install_vim_prereqs.sh
	scripts/install_vim.sh
	scripts/install_vim_plug.sh

install-chrome-ubuntu:
	scripts/ubuntu/install_chrome.sh

update-system-packages-ubuntu:
	sudo apt update && sudo apt upgrade -y
