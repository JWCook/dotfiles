###################
# Grouped Scripts #
###################

# Config for terminal applications
install-conf: \
    install-bash-conf \
    install-figlet-conf \
    install-fish-conf \
    install-git-conf \
    install-grc-conf \
	install-harlequin-config \
    install-htop-conf \
    install-ipython-conf \
    install-neofetch-conf \
    install-pdb-conf \
    install-pep8-conf \
    install-postgres-conf \
    install-ranger-conf \
    install-vim-conf \
    install-vim-plug \
	configure-locale

# Config for GUI applications
install-gui-conf: \
    install-guake-conf \
    install-sublimetext-conf \
    install-terminator-conf
    #install-albert-conf \

install-gnome-conf: \
    install-gui-conf \
    configure-gnome \
    install-gnome-terminal-conf

# Extra bits that require sudo access
install-extras: \
    configure-ntp \
    configure-sudoers \
    install-fonts

# WSL-specific config
install-wsl: \
    install-conf \
    install-conf-wsl \
    install-fonts \
    configure-fonts-wsl \
    install-xfce-conf

configure-locale:
	sudo locale-gen 'en_US.UTF-8'
	echo 'LANG=en_US.UTF-8' | sudo tee /etc/default/locale

######################
# Individual Scripts #
######################

configure-gnome:
	scripts/configure_gnome.sh

configure-ntp:
	scripts/configure_ntp.sh

configure-sudoers:
	sudo scripts/configure_sudoers.sh

init-ssh-conf:
	mkdir -p ~/.ssh
	cp ssh/config ~/.ssh/
	source bash/bashrc && ssh-set-permissions

install-albert-conf:
	rm -f ~/.config/albert/albert.conf
	mkdir -p ~/.config/albert
	ln -s `pwd`/albert/albert.conf ~/.config/albert/albert.conf

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

install-fonts:
	scripts/install_fonts.sh

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

install-harlequin-config:
	rm -rf ~/.config/harlequin
	mkdir -p ~/.config/harlequin
	ln -s `pwd`/harlequin/harlequin.toml ~/.config/harlequin/harlequin.toml

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

install-kitty-conf:
	mkdir -p ~/.config/kitty
	rm -f ~/.config/kitty/kitty.conf
	rm -f ~/.config/kitty/open-actions.conf
	ln -s `pwd`/kitty/kitty.conf ~/.config/kitty/kitty.conf
	ln -s `pwd`/kitty/open-actions.conf ~/.config/kitty/open-actions.conf

install-neofetch-conf:
	rm -rf ~/.config/neofetch
	mkdir -p ~/.config/neofetch
	ln -s `pwd`/neofetch/config.conf ~/.config/neofetch/config.conf

install-pdb-conf:
	rm -f ~/.pdbrc
	ln -s `pwd`/pdb/pdbrc ~/.pdbrc

install-pep8-conf:
	mkdir -p ~/.config
	rm -rf ~/.config/pep8
	rm -rf ~/.config/flake8
	ln -s `pwd`/pep8/pep8    ~/.config/pep8
	ln -s `pwd`/pep8/flake8  ~/.config/flake8

install-postgres-conf:
	rm -rf ~/.psqlrc
	ln -s `pwd`/postgres/psqlrc ~/.psqlrc

install-ranger-conf:
	rm -rf ~/.config/ranger
	ln -s `pwd`/ranger ~/.config/ranger

install-sublimetext-conf:
	mkdir -p ~/.config/sublime-text/Packages
	rm -rf ~/.config/sublime-text/Packages/User
	ln -s ~/Nextcloud/Data/Config/SublimeText ~/.config/sublime-text/Packages/User

install-terminator-conf:
	rm -rf ~/.config/terminator
	ln -s `pwd`/terminator ~/.config/terminator

install-vim-conf:
	rm -rf ~/.vim
	rm -rf ~/.vimrc
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/nvim/coc-settings.json
	mkdir -p ~/.config/nvim
	ln -s `pwd`/vim/vimrc  ~/.vimrc
	ln -s `pwd`/vim/vim  ~/.vim
	ln -s `pwd`/vim/vimrc ~/.config/nvim/init.vim
	ln -s `pwd`/vim/coc-settings.json ~/.config/nvim/coc-settings.json
	# Sync vim sessions, if sync folder exists
	- [ -d ~/Nextcloud/Data/vim-sessions ] && ln -s ~/Nextcloud/Data/vim-sessions `pwd`/vim/vim/session

install-vim-plug:
	scripts/install_vim_plug.sh


# WSL-specific bits

install-conf-wsl:
	rm -f ~/.bashrc_wsl
	ln -s `pwd`/bash/bashrc_wsl ~/.bashrc_wsl
	rm -f ~/.config/fish/config_wsl.fish
	ln -s `pwd`/fish/config_wsl.fish ~/.config/fish/config_wsl.fish
	test -d /mnt/c/Workspace && ln -s /mnt/c/Workspace ~/workspace
	test -d /mnt/d/Workspace && ln -s /mnt/d/Workspace ~/workspace
	test -d /mnt/d/NextCloud  && ln -s /mnt/d/NextCloud/ ~/NextCloud/
	test -d /mnt/e/Downloads && rmdir ~/Downloads && ln -s /mnt/e/Downloads ~/Downloads

configure-fonts-wsl:
	scripts/configure_fonts_wsl.sh

install-xfce-conf:
	rm -rf ~/.config/xfce4/terminal
	mkdir -p ~/.config/xfce4/terminal
	ln -s `pwd`/xfce/terminal/accels.scm ~/.config/xfce4/terminal/accels.scm
	ln -s `pwd`/xfce/terminal/terminalrc ~/.config/xfce4/terminal/terminalrc
