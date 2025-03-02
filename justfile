default:
    @just --list
    @echo "\nDistro: {{distro}}"

# Detect distro or WSL
distro := `uname -r | grep -q microsoft && echo 'wsl' || (. /etc/os-release && echo $ID)`

# Run install scripts for the current distro
install:
    ./scripts/install_bootstrap_packages.sh
    @just install-conf install-fonts
    @just install-{{distro}}
    @just install-xdistro

# Run update scripts for the current distro
update:
    @just update-{{distro}}
    @just update-xdistro


##########
# Config #
##########

# Install config for all terminal applications
install-conf:
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

install-gnome-conf: install-gnome-terminal-conf
    ./scripts/configure_gnome.sh

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

# Download and install selected monospace fonts
install-fonts:
    ./scripts/install_fonts.sh

install-git-conf:
    rm -f ~/.gitconfig
    @just symlink git/config ~/.config/git/config
    @just symlink git/ignore ~/.config/git/ignore

install-grc-conf:
    @just symlink grc ~/.grc

install-ghostty-conf:
    @just symlink ghostty ~/.config/ghostty

install-gnome-terminal-conf:
    - dconf dump /org/gnome/terminal/ > ~/dotfiles/gnome-terminal/gnome-terminal-settings
export-gnome-terminal-conf:
    dconf load /org/gnome/terminal/ < ~/dotfiles/gnome-terminal/gnome-terminal-settings

install-guake-conf:
    - guake --restore-preferences guake/guake_settings
export-guake-conf:
    guake --save-preferences ~/dotfiles/guake/guake_settings

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
    ./scripts/xdistro/install_vim_plug.sh

install-wezterm-conf:
    @just symlink wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

install-wsl-conf:
    @just symlink bash/bashrc_wsl ~/.bashrc_wsl
    @just symlink fish/config_wsl.fish ~/.config/fish/config_wsl.fish

install-xfce-conf:
    @just symlink xfce/terminal/accels.scm ~/.config/xfce4/terminal/accels.scm
    @just symlink xfce/terminal/terminalrc ~/.config/xfce4/terminal/terminalrc


#############################
# Packages: Distro-specific #
#############################

install-debian:
    sudo ./scripts/debian/install_system_packages.sh
update-debian:
    @sudo -v
    sudo nala upgrade -y &

install-ubuntu:
    sudo ./scripts/ubuntu/install_system_packages.fish -g -k
    @just install-fzf
update-ubuntu: update-debian
    @just install-fzf

install-wsl:
    @just install-wsl-conf
    sudo ./scripts/ubuntu/install_system_packages.fish -w
    ./scripts/wsl/configure_fonts.sh
update-wsl: update-ubuntu

install-fedora:
    sudo ./scripts/fedora/install_system_packages.sh -r -g -n
    @just install-ssh-agent-systemd
update-fedora:
    @sudo -v
    sudo dnf upgrade -y &

install-arch:
    sudo ./scripts/arch/install_system_packages.sh
update-arch:
    sudo pacman -Syu


##########################
# Packages: Cross-Distro #
##########################

# Install all cross-distro packages
install-xdistro:
    @just install-cargo-packages &
    @just install-python-tools install-node install-grc
# Update all cross-distro packages
update-xdistro:
    @just update-cargo &
    @just update-python update-nvim-plugins update-tldr update-repos
    -which -s snap && sudo snap refresh

# Package collections
# -------------------

install-cargo-packages:
    ./scripts/install_cargo_packages.sh
update-cargo: install-cargo-packages

install-node:
    ./scripts/install_node.fish
update-npm:
    npm update -g

install-python-tools:
    ./scripts/install_python_tools.fish
update-python:
    ./scripts/install_python_tools.fish -u

update-repos:
    -@just update-repo ~/dotfiles
    -@just update-repo ~/dotfiles-local
    -@just update-repo ~/workspace/@scripts

# Individual packages
# -------------------
# Note: Most of these are only necessary in cases where the base repo is far behind

install-fzf:
    ./scripts/xdistro/install_fzf.sh
install-grc:
    ./scripts/xdistro/install_grc.sh
install-kitty:
    ./scripts/xdistro/install_kitty.sh
install-ssh-agent-systemd:
    ./scripts/install_ssh_agent_systemd.sh
update-nvim-plugins:
    nvim +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qall
update-tldr:
    - tldr --update


####################
# Helper Functions #
####################

# Symlink a file or directory, with sanity checks
symlink src dest:
    @just _symlink $(realpath {{src}}) {{dest}}
_symlink src dest:
    @test -e "{{src}}" && test -n "{{dest}}" \
        || (echo "invalid symlink: {{src}} -> {{dest}}" && exit 1)
    @rm -f "{{dest}}"
    @mkdir -p "$(dirname {{dest}})"
    ln -s "{{src}}" "{{dest}}"

[no-exit-message]
update-repo REPO_DIR:
    @test -d {{REPO_DIR}} \
        || (echo "{{REPO_DIR}} does not exist" && exit 1)
    @git -C {{REPO_DIR}} fetch --all
    @git -C {{REPO_DIR}} stash
    git -C {{REPO_DIR}} pull --rebase
    @git -C {{REPO_DIR}} stash pop
