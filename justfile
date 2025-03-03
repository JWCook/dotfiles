default:
    @just --list
    @echo "\nDistro: {{distro}}"

# Detect distro or WSL
distro := `uname -r | grep -q microsoft && echo 'wsl' || (. /etc/os-release && echo $ID)`
config_dir := env_var_or_default("XDG_CONFIG_HOME", "~/.config")

# Run install scripts for the current distro
install:
    ./scripts/install_bootstrap_packages.sh
    @just install-conf
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
configs := "bash dbcli figlet fish git grc guake harlequin htop ipython neofetch pdb postgres ranger terminator tmux vim"
install-conf:
    @for conf in {{configs}}; do \
        just install-$conf-conf || true; \
    done

install-gnome-conf: install-gnome-terminal-conf
    ./scripts/configure_gnome.sh

install-albert-conf:
    @just symlink albert/albert.conf {{config_dir}}/albert/albert.conf

install-atuin-conf:
    @just symlink atuin/config.toml {{config_dir}}/atuin/config.toml

install-bash-conf:
    @just symlink bash/bashrc       ~/.bashrc
    @just symlink bash/bashrc_style ~/.bashrc_style
    @just symlink bash/bash_profile ~/.bash_profile
    @just symlink bash/bash_logout  ~/.bash_logout
    scripts/install_bash_completion.sh

install-dbcli-conf:
    @just symlink dbcli/litecli_config {{config_dir}}/litecli/config
    @just symlink dbcli/pgcli_config   {{config_dir}}/pgcli/config

install-fish-conf:
    @just symlink fish/config.fish                           {{config_dir}}/fish/config.fish
    @just symlink fish/style.fish                            {{config_dir}}/fish/style.fish
    @just symlink fish/functions/fish_prompt.fish            {{config_dir}}/fish/functions/fish_prompt.fish
    @just symlink fish/functions/atuin_key_bindings.fish     {{config_dir}}/fish/functions/fish_user_key_bindings.fish
    @just symlink fish/functions/fish_user_key_bindings.fish {{config_dir}}/fish/functions/atuin_key_bindings.fish
    mkdir -p {{config_dir}}/fish/completions
    cp fish/completions/*                                    {{config_dir}}/fish/completions/
    scripts/install_fish_plugins.fish

install-figlet-conf:
    @just symlink figlet ~/.figlet

# Download and install selected monospace fonts
install-fonts:
    ./scripts/install_fonts.sh

install-git-conf:
    rm -f ~/.gitconfig
    @just symlink git/config {{config_dir}}/git/config
    @just symlink git/ignore {{config_dir}}/git/ignore

install-grc-conf:
    @just symlink grc ~/.grc

install-ghostty-conf:
    @just symlink ghostty {{config_dir}}/ghostty

install-gnome-terminal-conf:
    - dconf dump /org/gnome/terminal/ > ~/dotfiles/gnome-terminal/gnome-terminal-settings
export-gnome-terminal-conf:
    dconf load /org/gnome/terminal/ < ~/dotfiles/gnome-terminal/gnome-terminal-settings

install-guake-conf:
    - guake --restore-preferences guake/guake_settings
export-guake-conf:
    guake --save-preferences ~/dotfiles/guake/guake_settings

install-harlequin-conf:
    @just symlink harlequin/harlequin.toml {{config_dir}}/harlequin/harlequin.toml

install-htop-conf:
    @just symlink htop/htoprc {{config_dir}}/htop/htoprc

install-ipython-conf:
    @just symlink ipython/profile_default/ipython_config.py ~/.ipython/profile_default/ipython_config.py
    @just symlink ipython/profile_default/startup           ~/.ipython/profile_default/startup

install-kitty-conf:
    @just symlink kitty/kitty.conf {{config_dir}}/kitty/kitty.conf
    @just symlink kitty/open-actions.conf {{config_dir}}/kitty/open-actions.conf

install-neofetch-conf:
    @just symlink neofetch/config.conf {{config_dir}}/neofetch/config.conf

install-pdb-conf:
    @just symlink pdb/pdbrc.py ~/.pdbrc

install-postgres-conf:
    @just symlink postgres/psqlrc ~/.psqlrc

install-ranger-conf:
    @just symlink ranger {{config_dir}}/ranger

install-terminator-conf:
    @just symlink terminator {{config_dir}}/terminator

install-tmux-conf:
    - git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    @just symlink tmux/tmux.conf {{config_dir}}/tmux/tmux.conf

install-vim-conf:
    @just symlink vim/vimrc             ~/.vimrc
    @just symlink vim/vim               ~/.vim
    @just symlink vim/vimrc             {{config_dir}}/nvim/init.vim
    @just symlink vim/coc-settings.json {{config_dir}}/nvim/coc-settings.json

install-wezterm-conf:
    @just symlink wezterm/wezterm.lua {{config_dir}}/wezterm/wezterm.lua

install-wsl-conf:
    @just symlink bash/bashrc_wsl ~/.bashrc_wsl
    @just symlink fish/config_wsl.fish {{config_dir}}/fish/config_wsl.fish

install-xfce-conf:
    @just symlink xfce/terminal/accels.scm {{config_dir}}/xfce4/terminal/accels.scm
    @just symlink xfce/terminal/terminalrc {{config_dir}}/xfce4/terminal/terminalrc


#############################
# Packages: Distro-specific #
#############################

install-debian:
    sudo ./scripts/debian/install_system_packages.fish
update-debian:
    @sudo -v
    sudo nala upgrade -y

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
    sudo dnf upgrade -y

install-arch:
    sudo ./scripts/arch/install_system_packages.sh
update-arch:
    sudo pacman -Syu


##########################
# Packages: Cross-Distro #
##########################

# Install all cross-distro packages
install-xdistro:
    @just _parallel install-cargo-packages install-python-tools install-fonts
    @just install-grc install-node install-vim-plug
# Update all cross-distro packages
update-xdistro:
    @just _parallel update-cargo update-python
    @just update-tldr update-vim-plugins update-repos
    @if command -v snap &> /dev/null; then sudo snap refresh; fi

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

repos := "~/dotfiles ~/dotfiles-local ~/workspace/@scripts"
update-repos:
    @for repo in {{repos}}; do \
        just _update-repo $repo || true; \
    done

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
install-vim-plug:
    ./scripts/xdistro/install_vim_plug.sh
update-vim-plugins:
    nvim +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qall
update-tldr:
    - tldr --update


####################
# Helper Functions #
####################

# Run containerized setup script tests
test-setup:
    ./tests/run-tests.sh

# Symlink a file or directory, with sanity checks
symlink src dest:
    @just _symlink $(realpath {{src}}) {{dest}}
_symlink src dest:
    @test -e "{{src}}" && test -n "{{dest}}" \
        || (echo "invalid symlink: {{src}} -> {{dest}}" && exit 1)
    @rm -f "{{dest}}"
    @mkdir -p "$(dirname {{dest}})"
    ln -s "{{src}}" "{{dest}}"

# Update a local git repository, with sanity checks
[no-exit-message]
_update-repo REPO_DIR:
    #!/usr/bin/env bash
    REPO="{{REPO_DIR}}"
    test -d "$REPO" && cd "$REPO" || (echo "❌ $REPO does not exist" && exit 1)

    # Check for uncommitted changes
    if ! git diff --quiet || ! git diff --quiet --cached; then
        echo "⚠️ Repository has uncommitted changes, stashing..."
        git stash save -q "auto-stash" || exit 1
        STASHED=1
    fi

    # Fetch and merge updates, and reapply any stashed changes
    git fetch -q --all --prune
    git pull -q --rebase && echo "✅ Updated $(basename $REPO)"
    if test -n "$STASHED"; then git stash pop -q; fi

# Run multiple jobs in parallel
_parallel *COMMANDS:
    #!/usr/bin/env bash
    set -e
    pids=()
    for cmd in {{COMMANDS}}; do
        echo "Starting: $cmd"
        eval "just $cmd" & pids+=($!)
    done

    # Wait for all processes and check return codes
    for pid in "${pids[@]}"; do
        if ! wait $pid; then
            echo "Command with PID $pid failed"
            exit 1
        fi
    done

_test-parallel:
    @just _parallel _test1 _test2
_test1:
    @echo "Test 1 start"
    @sleep 0.2
    @echo "Test 1 end"
_test2:
    @echo "Test 2"
