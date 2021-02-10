# TODO: prompt for distro & window manager?

#############################################
# Grouped Pakcages & Config: Cross-Platform #
#############################################

install-conf: \
    install-albert-conf \
    install-atom-conf \
    install-bash-conf \
    install-figlet-conf \
    install-fish-conf \
    install-git-conf \
    install-gnome-terminal-conf \
    install-grc-conf \
    install-guake-conf \
    install-htop-conf \
    install-ipython-conf \
    install-pep8-conf \
    install-postgres-conf \
    install-terminator-conf \
    install-vim-conf \
    install-xfce-conf

install-portable-packages: \
    install-fonts \
    install-grc \
    install-miniconda \
    install-npm-packages \
    install-poetry \
    install-pyenv \
    install-python-packages \
    install-ruby-gems

update: \
    update-npm \
    update-python \
    update-ruby \
    update-grc
    # update-vim


##############################################
# Grouped Pakcages & Config: Distro-Specific #
##############################################

install-fedora: \
    install-system-packages-fedora-xfce \
    install-portable-packages \
    install-conf \
    install-chrome-fedora \
    install-neovim-fedora \
    install-retroterm-fedora \
    install-ssh-agent-systemd
    # install-vim-fedora

update-fedora: update
	sudo dnf upgrade -y

install-ubuntu: \
    install-system-packages-ubuntu \
    install-portable-packages \
    install-conf \
    install-chrome-ubuntu \
    install-flux-ubuntu \
    install-vim-ubuntu

install-ubuntu-wsl: \
    install-system-packages-ubuntu-wsl \
    install-portable-packages \
    install-conf \
    init-ssh-conf \
    configure-fonts-wsl \
    configure-sudoers
	rm -f ~/.bashrc_wsl
	ln -s `pwd`/bash/bashrc_wsl ~/.bashrc_wsl
	test -d /mnt/c/Workspace && ln -s /mnt/c/Workspace ~/workspace
	test -d /mnt/d/Workspace && ln -s /mnt/d/Workspace ~/workspace
	test -d /mnt/d/NextCloud  && ln -s /mnt/d/NextCloud/ ~/NextCloud/
	scripts/init_gnome_keyring.sh
	# See: https://github.com/dnschneid/crouton/wiki/Fix-error-while-loading-shared-libraries:-libQt5Core.so.5
	sudo strip --remove-section=.note.ABI-tag  /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
	# WIP: Set up host Firefox to allow opening browser from links in WSL
	# sudo update-alternatives --install "/bin/host_firefox" "firefox" '/mnt/c/Program Files/Mozilla Firefox/firefox.exe' 1

update-ubuntu: update
	sudo apt-get update && sudo apt-get upgrade -y


#########################
# Runtime Configuration #
#########################

configure-fonts-wsl:
	scripts/configure_fonts_wsl.sh

configure-gnome:
	scripts/configure_gnome.sh

configure-ntp:
	scripts/configure_ntp.sh

configure-sudoers:
	sudo scripts/configure_sudoers.sh

# WIP
init-ssh-conf:
	mkdir -p ~/.ssh
	cp ssh/config ~/.ssh/
	source bash/bashrc && ssh-set-permissions

install-albert-conf:
	rm -f ~/.config/albert/albert.conf
	mkdir -p ~/.config/albert
	ln -s `pwd`/albert/albert.conf ~/.config/albert/albert.conf

install-atom-conf:
	rm -f ~/.atom/config.cson
	rm -f ~/.atom/keymap.cson
	rm -f ~/.atom/packages.cson
	rm -f ~/.atom/snippets.cson
	rm -f ~/.atom/init.coffee
	rm -f ~/.atom/styles.less
	mkdir -p ~/.atom
	ln -s `pwd`/atom/config.cson    ~/.atom/config.cson
	ln -s `pwd`/atom/keymap.cson    ~/.atom/keymap.cson
	ln -s `pwd`/atom/packages.cson  ~/.atom/packages.cson
	ln -s `pwd`/atom/snippets.cson  ~/.atom/snippets.cson
	ln -s `pwd`/atom/init.coffee    ~/.atom/init.coffee
	ln -s `pwd`/atom/styles.less    ~/.atom/styles.less
	- apm install package-sync

install-bash-conf:
	rm -f ~/.bashrc
	rm -f ~/.bashrc_style
	rm -f ~/.bash_profile
	rm -f ~/.bash_logout
	ln -s `pwd`/bash/bashrc         ~/.bashrc
	ln -s `pwd`/bash/bashrc_style   ~/.bashrc_style
	ln -s `pwd`/bash/bash_profile   ~/.bash_profile
	ln -s `pwd`/bash/bash_logout    ~/.bash_logout
	scripts/install_bash_completion.sh

install-fish-conf:
	scripts/install_fish_tackle.fish

install-figlet-conf:
	rm -rf ~/.figlet
	ln -s `pwd`/figlet ~/.figlet

install-git-conf:
	rm -f ~/.gitconfig
	ln -s `pwd`/git/gitconfig ~/.gitconfig

install-grc-conf:
	rm -rf ~/.grc
	ln -s `pwd`/grc ~/.grc

install-gnome-terminal-conf:
	- dconf dump /org/gnome/terminal/ > ~/dotfiles/gnome-terminal/gnome-terminal-settings
	# To export settings:
	#dconf load /org/gnome/terminal/ < ~/dotfiles/gnome-terminal/gnome-terminal-settings

install-guake-conf:
	- guake --restore-preferences guake/guake_settings
	# To export settings:
	# guake --save-preferences ~/dotfiles/guake/guake_settings

install-htop-conf:
	rm -rf ~/.config/htop
	mkdir -p ~/.config/htop
	ln -s `pwd`/htop ~/.config/htop

install-ipython-conf:
	mkdir -p ~/.ipython/profile_default
	rm -f ~/.ipython/profile_default/ipython_config.py
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
	rm -f ~/.config/nvim/init.vim
	ln -s `pwd`/vim/vimrc  ~/.vimrc
	ln -s `pwd`/vim/vim  ~/.vim
	mkdir -p ~/.config/nvim
	ln -s `pwd`/vim/vimrc ~/.config/nvim/init.vim
	# Sync vim sessions, if sync folder exists
	- [ -d ~/Nextcloud/Data/vim-sessions ] && ln -s ~/Nextcloud/Data/vim-sessions `pwd`/vim/vim/session

install-xfce-conf:
	rm -rf ~/.config/xfce4/terminal
	mkdir -p ~/.config/xfce4/terminal
	ln -s `pwd`/xfce/terminal/accels.scm ~/.config/xfce4/terminal/accels.scm
	ln -s `pwd`/xfce/terminal/terminalrc ~/.config/xfce4/terminal/terminalrc


############################
# Packages: Cross-Platform #
############################

install-fonts:
	scripts/install_fonts.sh

install-grc:
	scripts/install_grc.sh

install-npm-packages:
	scripts/install_npm_packages.sh

install-miniconda:
	scripts/install_miniconda.sh

install-poetry:
	scripts/install_poetry.sh

install-pyenv:
	scripts/install_pyenv.sh

install-python-packages:
	pip install --user -U pip setuptools wheel
	pip install --user -Ur scripts/requirements-user.txt
	- poetry self update

install-ruby-gems:
	# scripts/install_rvm.sh
	sudo gem install -g scripts/Gemfile

install-ssh-agent-systemd:
	scripts/install_ssh_agent_systemd.sh

install-vim:
	scripts/install_vim.sh
	scripts/install_vim_plug.sh

update-grc: install-grc

update-npm: install-npm-packages

update-python: install-python-packages

update-ruby:
	sudo gem update

update-vim:
	scripts/install_vim.sh


####################
# Packages: Fedora #
####################

install-system-packages-fedora-gnome:
	sudo scripts/fedora/install_system_packages.sh -r -g -n

install-system-packages-fedora-xfce:
	sudo scripts/fedora/install_system_packages.sh -r -g -x

install-system-packages-fedora-headless:
	sudo scripts/fedora/install_system_packages.sh -r

reinstall-system-packages-fedora:
	sudo scripts/fedora/install_system_packages.sh

install-neovim-fedora:
	scripts/fedora/install_neovim.sh
	scripts/install_vim_plug.sh
	scripts/install_neovim_venv.sh

install-vim-fedora:
	scripts/fedora/install_vim_prereqs.sh
	scripts/install_vim.sh
	scripts/install_vim_plug.sh

install-chrome-fedora:
	sudo scripts/fedora/install_chrome.sh

install-retroterm-fedora:
	scripts/fedora/install_retroterm.sh


#####################
# Packages: Ubuntu #
#####################

install-system-packages-ubuntu:
	sudo scripts/ubuntu/install_system_packages.sh -r -g

install-system-packages-ubuntu-wsl:
	sudo scripts/ubuntu/install_system_packages.sh -r -w

reinstall-system-packages-ubuntu:
	sudo scripts/ubuntu/install_system_packages.sh

install-vim-ubuntu:
	scripts/ubuntu/install_vim_prereqs.sh
	scripts/install_vim.sh
	scripts/install_vim_plug.sh

install-chrome-ubuntu:
	sudo scripts/ubuntu/install_chrome.sh

install-flux-ubuntu:
	sudo scripts/ubuntu/install_flux.sh
