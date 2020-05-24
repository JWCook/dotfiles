# TODO: prompt for distro & window manager?

#############################################
# Grouped Pakcages & Config: Cross-Platform #
#############################################

install-conf: install-bash-conf \
              install-fish-conf \
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
              install-grc \
              install-neovim \
              install-ruby-gems \
              install-poetry \
              update-python
              # install-js-packages \

install-optional: configure-gnome \
                  configure-ntp \
                  configure-sudoers \
                  install-haroopad

update: update-python \
        update-ruby \
        update-grc
        # update-vim
        # update-ycm


##############################################
# Grouped Pakcages & Config: Distro-Specific #
##############################################

install-fedora: install-conf \
                install-system-packages-fedora \
                install-docker-fedora \
                install-chrome-fedora \
                install-retroterm-fedora \
                install-pkgs
                # install-vim-fedora

update-fedora: update
	sudo dnf upgrade -y

install-ubuntu: install-system-packages-ubuntu \
                install-conf \
                install-chrome-ubuntu \
                install-flux-ubuntu \
                install-pkgs
                # install-vim-ubuntu \

install-ubuntu-wsl: install-system-packages-ubuntu \
                install-conf \
                install-pkgs \
                configure-sudoers
	rm ~/.bashrc_wsl
	ln -s `pwd`/bash/bashrc_wsl ~/.bashrc_wsl
	# scripts/ubuntu/configure_wsl.sh
	sudo apt-get install -y xfce4-terminal
	source bash/bashrc && ssh-set-permissions

update-ubuntu: update
	sudo apt-get update && sudo apt-get upgrade -y


#########################
# Runtime Configuration #
#########################

configure-gnome:
	scripts/configure_gnome.sh

configure-ntp:
	scripts/configure_ntp.sh

configure-sudoers:
	sudo scripts/configure_sudoers.sh

install-bash-completion:
	`pwd`/scripts/install_bash_completion.sh

install-bash-conf: install-bash-completion
	rm -rf ~/.bashrc
	rm -rf ~/.bashrc_style
	rm -rf ~/.bash_profile
	rm -rf ~/.bash_logout
	ln -s `pwd`/bash/bashrc       ~/.bashrc
	ln -s `pwd`/bash/bashrc_style ~/.bashrc_style
	ln -s `pwd`/bash/bash_profile ~/.bash_profile
	ln -s `pwd`/bash/bash_logout  ~/.bash_logout

install-fish-conf:
	mkdir -p ~/.config/fish/
	rm -rf ~/.config/fish/config.fish
	rm -rf ~/.config/fish/style.fish
	rm -rf ~/.config/fish/functions
	ln -s `pwd`/fish/config.fish ~/.config/fish/config.fish
	ln -s `pwd`/fish/style.fish ~/.config/fish/style.fish
	ln -s `pwd`/fish/functions ~/.config/fish/functions
	[ ! -e  ~/.config/fish/completions ] && ln -sf `pwd`/fish/completions ~/.config/fish/completions
	wget https://git.io/fundle -O `pwd`/fish/functions/fundle.fish
	fish -c 'fundle install'

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
	mkdir -p ~/.config
	rm -rf ~/.config/htop
	ln -s `pwd`/htop ~/.config/htop

install-ipython-conf:
	mkdir -p ~/.ipython/profile_default
	rm -rf ~/.ipython/profile_default/ipython_config.py
	rm -rf ~/.ipython/profile_default/startup
	ln -s `pwd`/ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py
	ln -s `pwd`/ipython/profile_default/startup           ~/.ipython/profile_default/startup

install-pep8-conf:
	mkdir -p ~/.config
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
	rm -rf ~/.config/nvim/init.vim
	ln -s `pwd`/vim/vimrc  ~/.vimrc
	ln -s `pwd`/vim/vim  ~/.vim
	mkdir -p ~/.config/nvim
	ln -s `pwd`/vim/vimrc ~/.config/nvim/init.vim
	# Sync vim sessions, if sync folder exists
	[ -d ~/Nextcloud/Data/vim-sessions ] && ln -s ~/Nextcloud/Data/vim-sessions `pwd`/vim/vim/session


############################
# Packages: Cross-Platform #
############################

install-fonts:
	scripts/install_fonts.sh

install-haroopad:
	scripts/install_haroopad.sh

install-grc:
	scripts/install_grc.sh

install-js-packages:
	scripts/install_npm_packages.sh

install-neovim:
	scripts/install_neovim.sh

install-poetry:
	scripts/install_poetry.sh

install-ruby-gems:
	# scripts/install_rvm.sh
	gem install -g scripts/Gemfile

install-vim:
	scripts/install_vim.sh
	scripts/install_vim_plug.sh

update-grc:
	scripts/install_grc.sh

update-python:
	pip3 install --user -Ur scripts/requirements-user.txt
	which poetry && poetry self update

update-ruby:
	sudo gem update

update-ycm:
	scripts/update_ycm.sh

update-vim:
	scripts/install_vim.sh


####################
# Packages: Fedora #
####################

install-system-packages-fedora:
	scripts/fedora/install_repos.sh
	scripts/fedora/install_system_packages.sh

install-docker-fedora:
	scripts/fedora/install_docker.sh

install-vim-fedora:
	scripts/fedora/install_vim_prereqs.sh
	scripts/install_vim.sh
	scripts/install_vim_plug.sh

install-chrome-fedora:
	sudo scripts/fedora/install_chrome.sh

install-insync-fedora:
	sudo scripts/fedora/install_insync.sh

install-retroterm-fedora:
	scripts/fedora/install_retroterm.sh


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
	sudo scripts/ubuntu/install_chrome.sh

install-flux-ubuntu:
	sudo scripts/ubuntu/install_flux.sh
