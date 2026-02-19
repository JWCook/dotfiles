default:
    @just --list
    @echo "\nDistro: {{distro}}"

# Detect distro or WSL
distro := `uname -r | grep -q microsoft && echo 'wsl' || (. /etc/os-release && echo $ID)`

config_dir := env_var_or_default("XDG_CONFIG_HOME", "~/.config")
pwd := justfile_directory()

# Run install scripts for the current distro
install:
    ./scripts/install_bootstrap_packages.sh
    @just install-conf
    @just install-{{distro}}

# Run update scripts for the current distro
update:
    @just update-{{distro}}


##########
# Config #
##########

# Install config for all terminal applications
configs := "atuin bash dbcli fastfetch figlet fish gh git grc guake harlequin htop ipython llm nvim pdb postgres starship tmux vim wezterm yazi"
# "albert kitty ghostty ranger terminator xfce"

install-conf:
    @for conf in {{configs}}; do \
        just install-$conf-conf || true; \
    done

install-gnome-conf: install-gnome-terminal-conf
    ./scripts/configure_gnome.sh

install-aider-conf:
    @just symlink llm/aider.conf.yml ~/.aider.conf.yml

install-albert-conf:
    @just symlink albert/albert.conf {{config_dir}}/albert/albert.conf

install-atuin-conf:
    @just symlink atuin/config.toml {{config_dir}}/atuin/config.toml

install-claude-conf:
    @just symlink llm/AGENTS.md ~/.claude/CLAUDE.md
    @just symlink llm/claude/settings.json ~/.claude/settings.json
    @just symlink llm/claude/commands ~/.claude/commands

install-bash-conf:
    @just symlink bash/bashrc       ~/.bashrc
    @just symlink bash/bashrc_style ~/.bashrc_style
    @just symlink bash/bash_profile ~/.bash_profile
    @just symlink bash/bash_logout  ~/.bash_logout
    scripts/install_bash_completion.sh

install-dbcli-conf:
    @just symlink dbcli/litecli_config {{config_dir}}/litecli/config
    @just symlink dbcli/pgcli_config   {{config_dir}}/pgcli/config

install-fastfetch-conf:
    @just symlink fastfetch/config.jsonc {{config_dir}}/fastfetch/config.jsonc

install-fish-conf:
    # @just symlink fish/functions/fish_prompt.fish            {{config_dir}}/fish/functions/fish_prompt.fish
    @just symlink fish/config.fish                           {{config_dir}}/fish/config.fish
    @just symlink fish/style.fish                            {{config_dir}}/fish/style.fish
    @just symlink fish/functions/atuin_key_bindings.fish     {{config_dir}}/fish/functions/fish_user_key_bindings.fish
    @just symlink fish/functions/fish_user_key_bindings.fish {{config_dir}}/fish/functions/atuin_key_bindings.fish
    mkdir -p {{config_dir}}/fish/completions
    cp fish/completions/*                                    {{config_dir}}/fish/completions/
    scripts/install_fish_plugins.fish

install-figlet-conf:
    @just symlink figlet ~/.figlet

install-gh-conf:
    @just symlink gh/config.yml ~/.config/gh/config.yml

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

install-llm-conf:
    @just symlink llm/aliases.json ~/.config/io.datasette.llm/aliases.json
    @just symlink llm/default_model.txt ~/.config/io.datasette.llm/default_model.txt

install-nvim-conf:
    @just symlink nvim {{config_dir}}/nvim

install-pdb-conf:
    @just symlink pdb/pdbrc.py ~/.pdbrc

install-postgres-conf:
    rm -f ~/.psqlrc
    @just symlink postgres/psqlrc ~/.config/pg/.psqlrc

install-ranger-conf:
    @just symlink ranger {{config_dir}}/ranger

install-starship-conf:
    @just symlink starship/starship.toml ~/.config/starship.toml

install-terminator-conf:
    @just symlink terminator {{config_dir}}/terminator

install-tmux-conf:
    - git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    @just symlink tmux/tmux.conf {{config_dir}}/tmux/tmux.conf

install-vim-conf:
    @just symlink vim/vimrc             ~/.vimrc
    @just symlink vim/vim               ~/.vim

install-wezterm-conf:
    @just symlink wezterm/wezterm.lua {{config_dir}}/wezterm/wezterm.lua

install-wsl-conf:
    @just symlink bash/bashrc_wsl ~/.bashrc_wsl
    @just symlink fish/config_wsl.fish {{config_dir}}/fish/config_wsl.fish

install-xfce-conf:
    @just symlink xfce/terminal/accels.scm {{config_dir}}/xfce4/terminal/accels.scm
    @just symlink xfce/terminal/terminalrc {{config_dir}}/xfce4/terminal/terminalrc

install-yazi-conf:
    @just symlink yazi/init.lua {{config_dir}}/yazi/init.lua
    @just symlink yazi/yazi.toml {{config_dir}}/yazi/yazi.toml
    @just symlink yazi/keymap.toml {{config_dir}}/yazi/keymap.toml
    @just symlink yazi/theme.toml {{config_dir}}/yazi/theme.toml

install-completions:
    - command -v atuin >/dev/null 2>&1 \
        && atuin gen-completions --shell bash > ~/.config/bash/completions/atuin.bash \
        && atuin gen-completions --shell fish > ~/.config/fish/completions/atuin.fish
    - command -v procs >/dev/null 2>&1 \
        && procs --gen-completion-out bash > ~/.config/bash/completions/procs.bash \
        && procs --gen-completion-out fish > ~/.config/fish/completions/procs.fish
    - command -v just  >/dev/null 2>&1 \
        &&just --completions fish > ~/.config/fish/completions/just.fish \
        && just --completions bash > ~/.config/bash/completions/just.bash


#############################
# Packages: Distro-specific #
#############################

install-debian:
    sudo ./scripts/debian/install_system_packages.fish
    @just install-xdistro
update-debian:
    @sudo -v
    sudo nala upgrade -y
    @just update-xdistro

install-ubuntu:
    sudo ./scripts/ubuntu/install_system_packages.fish -g -k
    @just install-xdistro
    @just install-fzf
update-ubuntu: update-debian
    @just install-fzf

install-wsl:
    @just install-wsl-conf
    sudo ./scripts/ubuntu/install_system_packages.fish -w
    sudo ./scripts/wsl/configure_fonts.sh
    @just install-xdistro
update-wsl: update-ubuntu

install-fedora:
    sudo ./scripts/fedora/install_system_packages.sh -r -g -n
    @just install-xdistro
    @just install-ssh-agent-systemd
update-fedora:
    @sudo -v
    sudo dnf upgrade -y
    @just update-xdistro

install-arch:
    sudo ./scripts/arch/install_system_packages.sh
update-arch:
    sudo pacman -Syu

install-endeavouros:
    @just install-node install-rust  # required for subsequent steps
    ./scripts/endeavour/install_system_packages.fish
    @just install-python-tools install-fonts
    @just install-completions install-grc install-yubico-auth
update-endeavouros:
    sudo pacman -Syu --noconfirm
    paru -Sua
    @just update-python update-rust update-nvim-plugins update-repos update-tldr update-auto-cpufreq


##########################
# Packages: Cross-Distro #
##########################

# Install all cross-distro packages
install-xdistro:
    @just _parallel install-rust install-cargo-packages install-python-tools install-fonts
    @just install-completions install-grc install-node install-yubico-auth
    # @just install-auto-cpufreq
# Update all cross-distro packages
update-xdistro:
    @just _parallel update-rust update-cargo update-python
    @just update-nvim-plugins update-repos update-tldr update-auto-cpufreq
    @if command -v snap >/dev/null 2>&1; then sudo snap refresh; fi

# Package collections
# -------------------

# Download and install selected monospace fonts
install-fonts:
    ./scripts/install_fonts.sh

install-cargo-packages:
    ./scripts/install_cargo_packages.sh
update-cargo: install-cargo-packages

install-go:
    sudo ./scripts/xdistro/install_go.sh

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

install-rust:
    command -v rustup >/dev/null 2>&1 \
        || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    . "$HOME/.cargo/env" && rustup update
    . "$HOME/.cargo/env" && rustup default stable
update-rust: install-rust

install-auto-cpufreq:
    # TODO: only install for laptops/other battery-powered devices?
    sudo ./scripts/xdistro/install_auto_cpufreq.sh --install
    @just symlink auto-cpufreq/auto-cpufreq.conf {{config_dir}}/auto-cpufreq/auto-cpufreq.conf
update-auto-cpufreq:
    - command -v auto-cpufrequ && sudo auto-cpufreq --update
install-claude-code:
    curl -fsSL https://claude.ai/install.sh | bash
    npm install -g @anthropic-ai/sandbox-runtime
install-fzf:
    ./scripts/xdistro/install_fzf.sh
install-grc:
    ./scripts/xdistro/install_grc.sh
install-kitty:
    ./scripts/xdistro/install_kitty.sh
install-kwin-gestures:
    sudo ./scripts/xdistro/install_kwin_gestures.sh
update-nvim-plugins:
    nvim --headless -c "Lazy sync" -c "qa"
install-ssh-agent-systemd:
    ./scripts/install_ssh_agent_systemd.sh
install-vim-plug:
    ./scripts/xdistro/install_vim_plug.sh
update-vim-plugins:
    test -x /usr/bin/vim && /usr/bin/vim +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qall
install-yubico-auth:
    ./scripts/xdistro/install_yubico_auth.fish
update-tldr:
    - tldr --update


####################
# Helper Functions #
####################

xdg-ninja:
    - ./scripts/xdg_ninja.sh

xdg-relocate:
    ./scripts/xdg_relocate.fish

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
