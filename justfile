default:
    @just --choose

distro := `. /etc/os-release && echo $ID`


########################
# ❰❰ Grouped Scripts ❱❱ #
########################

# Install config for terminal applications
install:
    @just \
    install-bash-conf \
    install-dbcli-conf \
    install-figlet-conf \
    install-fish-conf \
    install-git-conf \
    install-grc-conf \
    install-guake-conf \
    install-harlequin-config \
    install-htop-conf \
    install-ipython-conf \
    install-neofetch-conf \
    install-pdb-conf \
    install-postgres-conf \
    install-ranger-conf \
    install-terminator-conf \
    install-tmux-conf \
    install-vim-conf \
    install-vim-plug

install-gnome-conf: configure-gnome install-gnome-terminal-conf

install-extras: configure-locale configure-ntp configure-sudoers install-fonts

# Install WSL-specific config
install-wsl:
    @just \
    install-conf \
    install-conf-wsl \
    install-fonts \
    configure-fonts-wsl \
    install-xfce-conf


###########################
# ❰❰ Individual Scripts ❱❱ #
###########################

configure-gnome:
    scripts/configure_gnome.sh

configure-locale:
    sudo locale-gen 'en_US.UTF-8'
    echo 'LANG=en_US.UTF-8' | sudo tee /etc/default/locale

configure-ntp:
    sudo chkconfig ntpd on
    sudo ntpdate pool.ntp.org
    sudo service ntpd start

configure-sudoers:
    sudo scripts/configure_sudoers.sh

install-albert-conf:
    @just symlink albert/albert.conf ~/.config/albert/albert.conf

install-atuin-conf:
    @just symlink atuin/config.toml ~/.config/atuin/config.toml

install-bash-conf:
    @just symlink bash/bashrc       ~/.bashrc
    @just symlink bash/bashrc_style ~/.bashrc_style
    @just symlink bash/bash_profile ~/.bash_profile
    @just symlink bash/bash_logout  ~/.bash_logout
    scripts/install_bash_completion.sh

install-dbcli-conf:
    @just symlink dbcli/litecli_config ~/.config/litecli/config
    @just symlink dbcli/pgcli_config ~/.config/pgcli/config

install-fish-conf:
    @just symlink fish/config.fish                           ~/.config/fish/config.fish
    @just symlink fish/style.fish                            ~/.config/fish/style.fish
    @just symlink fish/functions/fish_prompt.fish            ~/.config/fish/functions/fish_prompt.fish
    @just symlink fish/functions/atuin_key_bindings.fish     ~/.config/fish/functions/fish_user_key_bindings.fish
    @just symlink fish/functions/fish_user_key_bindings.fish ~/.config/fish/functions/atuin_key_bindings.fish
    mkdir -p ~/.config/fish/completions
    cp fish/completions/*                                    ~/.config/fish/completions/
    scripts/install_fish_plugins.fish

install-figlet-conf:
    @just symlink figlet ~/.figlet

install-fonts:
    scripts/install_fonts.sh

install-git-conf:
    rm -f ~/.gitconfig
    @just symlink git/config ~/.config/git/config
    @just symlink git/ignore ~/.config/git/ignore

install-grc-conf:
    @just symlink grc ~/.grc


install-ghostty-conf:
    @just symlink ghostty ~/.config/ghostty

# To export settings:
# dconf load /org/gnome/terminal/ < ~/dotfiles/gnome-terminal/gnome-terminal-settings
install-gnome-terminal-conf:
    - dconf dump /org/gnome/terminal/ > ~/dotfiles/gnome-terminal/gnome-terminal-settings

# To export settings:
# guake --save-preferences ~/dotfiles/guake/guake_settings
install-guake-conf:
    - guake --restore-preferences guake/guake_settings

install-harlequin-config:
    @just symlink harlequin/harlequin.toml ~/.config/harlequin/harlequin.toml

install-htop-conf:
    @just symlink htop/htoprc ~/.config/htop/htoprc

install-ipython-conf:
    @just symlink ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py
    @just symlink ipython/profile_default/startup           ~/.ipython/profile_default/startup

install-kitty-conf:
    @just symlink kitty/kitty.conf ~/.config/kitty/kitty.conf
    @just symlink kitty/open-actions.conf ~/.config/kitty/open-actions.conf

install-neofetch-conf:
    @just symlink neofetch/config.conf ~/.config/neofetch/config.conf

install-pdb-conf:
    @just symlink pdb/pdbrc.py ~/.pdbrc

install-postgres-conf:
    @just symlink postgres/psqlrc ~/.psqlrc

install-ranger-conf:
    @just symlink ranger ~/.config/ranger

install-terminator-conf:
    @just symlink terminator ~/.config/terminator

install-tmux-conf:
    - git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    @just symlink tmux/tmux.conf ~/.config/tmux/tmux.conf

install-vim-conf:
    @just symlink vim/vimrc             ~/.vimrc
    @just symlink vim/vim               ~/.vim
    @just symlink vim/vimrc             ~/.config/nvim/init.vim
    @just symlink vim/coc-settings.json ~/.config/nvim/coc-settings.json

install-vim-plug:
    scripts/install_vim_plug.sh

install-wezterm-conf:
    @just symlink wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

install-conf-wsl:
    @just symlink bash/bashrc_wsl ~/.bashrc_wsl
    @just symlink fish/config_wsl.fish ~/.config/fish/config_wsl.fish

configure-fonts-wsl:
    scripts/configure_fonts_wsl.sh

install-xfce-conf:
    @just symlink xfce/terminal/accels.scm ~/.config/xfce4/terminal/accels.scm
    @just symlink xfce/terminal/terminalrc ~/.config/xfce4/terminal/terminalrc


##########################
# ❰❰ Helper Functions ❱❱ #
##########################

symlink src dest:
    @just _symlink $(realpath {{src}}) {{dest}}

_symlink src dest:
    @test -e "{{src}}" && test -n "{{dest}}" \
        || (echo "invalid symlink: {{src}} -> {{dest}}" && exit 1)
    @rm -f "{{dest}}"
    @mkdir -p "$(dirname {{dest}})"
    ln -s "{{src}}" "{{dest}}"
