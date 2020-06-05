#################
# ❰❰ Plugins ❱❱ #
#################

fundle plugin 'fishpkg/fish-git-util'
fundle init
source ~/.config/fish/style.fish
vf install compat_aliases


##########################
# ❰❰ Helper Functions ❱❱ #
##########################
# Misc utils to help with other shell functions

# Return the first non-null argument
function coalesce
    for var in $argv
        if test -n "$var"
            echo $var
            return 0
        end
    end
    return -1
end

# Set and argument to current dir if not specified
function default-pwd
    coalesce "$argv" '.'
end

# Set and argument to current dir if not specified
function default-pwd-base
    coalesce "$argv" (pwd-base)
end

# Test if a command/alias/function exists
function cmd-exists
    type -a $argv > /dev/null 2>&1
end

# Append to path, without duplicates
function pathadd
    set -U fish_user_paths $argv $fish_user_paths
end

# Prompt for confirmation before continuing
function prompt-confirm
    read -P " Continue? [Y/N]" -n 1 _input
    if string match -qi "$_input" "Y"
        return 0
    else
        return 1
    end
end

# Source a file, if it exists
function source-file
    [[ -f $1 ]] && source $argv
end

# Source an executable, if it exists on path
function source-bin
    cmd-exists $argv && source (which $argv)
end

# Safe tput, only for TTY sessions
alias ttput='tty -s && tput'


#####################
# ❰❰ Environment ❱❱ #
#####################

# Paths
pathadd ~/.local/bin
pathadd ~/.poetry/bin
pathadd ~/bin
pathadd ~/scripts
pathadd /usr/local/bin
pathadd /usr/local/sbin

set -x DOTFILES ~/dotfiles
# [ -z "$DOTFILES_EXTRA" ] && set DOTFILES_EXTRA=~/dotfiles-extra
set -x WORKSPACE ~/workspace
alias cw='cd $WORKSPACE'

set -gx PYTHONPATH ~/.local/lib/python3.7/site-packages:~/.local/lib/python3.6/site-packages

set -x IGNORE_PATTERNS '*.pyc|*.sw*|.cache|.git|__pycache__'


#########################
# ❰❰ General Aliases ❱❱ #
#########################

set -gx EDITOR /usr/bin/nvim

# Simple Command/App Aliases
abbr term-code terminator -mfl code \&
abbr term-dev terminator -mfl 6-split \&
abbr term-start terminator -l start \&
abbr retroterm /usr/local/src/retro-term/cool-retro-term \&
abbr lw sudo logwatch \| less
abbr ta type -a
complete -c ta -w type
abbr top htop
abbr tt tig
abbr vim nvim
abbr vimdiff nvim -d
abbr weather curl -4 http://wttr.in/~50266


################
# ❰❰ Search ❱❱ #
################

# fd() { find ${2:-.} -name "$1" -prune -type d; }        # Recursive search (lit, dirs)
# ff() { find ${2:-.} -name "$1" -type f; }               # Recursive search (lit, files)
# ge() { env | grep ${1:-""}; }                           # Search environment variables
# gr() { grep -r "$1" ${@:2}; }                           # Recursive search
# grr() { grep -r "$1" $(pwd-base) test; }                # Recursive search default src and test dirs
# newest() {                                              # Find most recent file w/ pattern
#     find ${2:-.} -type f -name $1 -print0 |\
#     xargs -0 ls -t | head -n1
# }


###############################
# ❰❰ File & Directory Info ❱❱ #
###############################

# Recursive folder size
abbr du /usr/bin/du -Sh $argv \| sort -hr \| color-filesize \| more
alias ll 'ls -Alhv --group-directories-first'
# lt() { tree $@ | color-filesize; }                      # Colored folder tree
# lt2() { tree -L 2 $@ | color-filesize; }                # Colored folder tree (depth 2)
# md() { mkdir -p "$@" && cd "$@"; }                      # Create a dir and enter it
# mode() { stat -c "%a %n" {$argv:-*}; }                  # Get octal file permissions
abbr pwd-base basename \(pwd\)                       # Base name of the current working dir
abbr pwd-src basename \(pwd\) \| sed 's/-/_/g'       # Guess name of project src dir
abbr tailf tail -f -n 50                             # Tail -f w/ defaults
abbr tailc tailf $argv \| grcat conf.logfile         # Tail -f w/ generic syntax highlighting
abbr tree /usr/bin/tree -CAFah --du --dirsfirst --prune -I \""$IGNORE_PATTERNS"\"


############################
# ❰❰ Disk & Device Info ❱❱ #
############################

# Readable disk usage
function df -w /usr/bin/df
    # /usr/bin/df -khT $argv | color-filesize
    /usr/bin/df -khT $argv
end

# Get a single metric for a single device (or a directory's device)
function df-single-metric -a metric device
    set device (default-pwd $device)
    /usr/bin/df --block-size=1 --output="$metric" "$device" | /usr/bin/tail -1
end

# Shortcuts for individual metrics
function df-device; df-single-metric "source" "$argv"; end
function df-type;   df-single-metric "fstype" "$argv"; end
function df-size;   df-single-metric "size"   "$argv"; end
function df-use;    df-single-metric "used"   "$argv"; end
function df-free;   df-single-metric "avail"  "$argv"; end
function df-mount;  df-single-metric "target" "$argv"; end


#################
# ❰❰ Network ❱❱ #
#################

abbr listen lsof -P -i -n \| grcat conf.nmap
function local-ip
    ifconfig | awk "/inet/ { print $argv[2] } " | sed -e s/addr://
end
abbr public-ip curl v4.ifconfig.co
abbr netconn netstat -pan --inet
abbr tracert traceroute
abbr unproxy unset http_proxy https_proxy ftp_proxy no_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY
abbr scan-local nmap -v -sT localhost
abbr scan-syn sudo nmap -v -sS localhost
abbr ssh-exit ssh -O exit
abbr ssh-refresh nullify ssh -O exit $argv \; ssh $argv

# Mount a network share
function mount-share -a remote_share local_mountpoint creds_file
    if not mountpoint "$local_mountpoint" > /dev/null 2>&1
        sudo mkdir -p "$local_mountpoint"
        sudo mount -v -t cifs -o credentials="$creds_file" "$remote_share" "$local_mountpoint"
    else
        echo 'Already mounted'
    end
end


#####################
# ❰❰ System Info ❱❱ #
#####################

abbr date-update sudo ntpdate $NTP_SERVER
abbr lu column -ts: /etc/passwd \| sort                                  # Formatted local user list
abbr lu-current w -hs \| cut -d \" \" -f1 \| sort \| uniq                  # Currently logged on users
alias path='echo -e {$PATH//:/\\n}  | lc-gradient --seed=8'                 # List/format items on PATH
alias psu='ps -u $USER -o pid,%cpu,%mem,bsdtime,command'                    # List user processes
function distinfo                                                           # Distribution info
    cat /etc/os-release; lsb_release -a
end

# Hardware
alias cdrom-info='cat /proc/sys/dev/cdrom/info'
alias pci-info='lspci -vnn'
alias usb-info='lsusb -v'

# Combined system information
function sysinfo
    echo -e "\n{$RED}Host information:$NOCOLOR " ; uname -a | lc-gradient -S 60
    echo -e "\n{$RED}Distro information:$NOCOLOR " ; distinfo | lc-gradient -S 60
    echo -e "\n{$RED}Users logged on:$NOCOLOR " ; lu-current | lc-gradient -S 60
    echo -e "\n{$RED}Current date :$NOCOLOR " ; date | lc-gradient -S 60
    echo -e "\n{$RED}Machine stats :$NOCOLOR " ; uptime | lc-gradient -S 60
    echo -e "\n{$RED}Memory stats :$NOCOLOR " ; free | lc-gradient -S 60
    echo -e "\n{$RED}Diskspace :$NOCOLOR " ; df
    echo -e "\n{$RED}Local IP Address :$NOCOLOR" ; local-ip | lc-gradient -S 60
    echo -e "\n{$RED}Public IP Address :$NOCOLOR" ; public-ip | lc-gradient -S 60
    echo -e "\n{$RED}Open connections :$NOCOLOR "; netconn;
    echo
end


#######################
# ❰❰ Configuration ❱❱ #
#######################

# Commonly used config files
 set BASH_CONF "$DOTFILES/bash/bashrc"
 set BASH_CONF_ALL "$DOTFILES/bash/bashrc* $DOTFILES_EXTRA/bash/bashrc*"
 set FISH_CONF $DOTFILES/fish/config.fish
 set FISH_FUNCS $DOTFILES/fish/functions/*
 set GIT_CONF "$DOTFILES/git/gitconfig"
 set PIP_CONF ~/.config/pip/pip.conf
 set PG_CONF "$DOTFILES/postgres/psqlrc ~/.auth/pgpass"
 set SETUP_CONF "$DOTFILES/Makefile $DOTFILES_EXTRA/Makefile"
 set SSH_CONF "$DOTFILES_EXTRA/ssh/config"
 set VIM_CONF "$DOTFILES/vim/vimrc"
 set VIM_CONF_ALL "$VIM_CONF $DOTFILES/vim/README.md"

# Editor shortcuts
function sb; echo "reloading fish config..."; source $FISH_CONF; end
abbr vb "$EDITOR $BASH_CONF"
abbr vbb "$EDITOR -O2 $BASH_CONF_ALL $FISH_CONF"
abbr vg "$EDITOR $GIT_CONF"
abbr vv "$EDITOR $VIM_CONF"
abbr vvv "$EDITOR -O2 $VIM_CONF_ALL"
abbr vc "$EDITOR -O2 $BASH_CONF_ALL $FISH_CONF $FISH_FUNCS $VIM_CONF_ALL $GIT_CONF $PG_CONF $SSH_CONF $SETUP_CONF"
abbr svim "sudo -E $EDITOR"

# Append a line to user crontab, excluding duplicates
# crontab-append() {
#     if ! [[ $(crontab -l) =~ "$1" ]]; then
#         (crontab -l 2>/dev/null; echo "$1") | crontab -
#         echo "Updated crontab:"
#     else
#         echo "Already in crontab:"
#     fi
#     crontab -l
# }
#
# # Append a line to root crontab, excluding duplicates
# scrontab-append() {
#     sudo bash -c "source $HOME/.bashrc; crontab-append '$1'";
# }
#
# # Append a line to arbitrary user's, excluding duplicates
# crontab-append-user() {
#     sudo -u $2 bash -c "source $HOME/.bashrc; crontab-append '$1'";
# }


#############
# ❰❰ Git ❱❱ #
#############

# General
abbr gf git fetch --all
abbr ggr git grep
abbr gp git pull
abbr gpr git pull --rebase
abbr gpush git push
abbr gfpush git push --force
abbr gstash git stash
abbr gpop git stash pop
abbr gremote git remote \| head -n 1
abbr groot cd \(git rev-parse --show-toplevel\)
abbr gs git status
abbr gsv git status -vv
abbr gss git status --short
abbr gstlist git stash list \; git stash show

function gadd
    git add (default-pwd $argv)
    git status --short --branch
end

function gpr
    git stash
    git pull --rebase
    git stash pop
end

function grm
    rm "$argv"
    git rm "$argv"
    git status
end

# Commits
abbr gc git commit --verbose
abbr gcm git commit -m
abbr gfirst git rev-parse --short \(git rev-list --max-parents=0 HEAD\)
abbr gmend git commit --amend
abbr gmendc git commit --amend --no-edit
abbr gpatch git add --patch
abbr gunstage git reset HEAD
abbr grevise git add --all \; git commit --amend --no-edit
abbr grecommit git commit -c ORIG_HEAD --no-edit
abbr guncommit git reset --soft HEAD~1

# Fix a branch from a detatched HEAD state, starting with a specified commit
function git-head-transplant
    git checkout -b transplant $argv
    git branch -f master transplant
    git checkout master
    git branch -d transplant
    git push origin master
end

# Log
set -xg GLOG_FORMAT "%C(blue)%h  %C(cyan)%ad  %C(reset)%s%C(green) [%cn] %C(yellow)%d"
abbr glog git log --pretty=format:\"$GLOG_FORMAT\" --decorate --date=short
abbr glog-branch glog master..HEAD
abbr glog-remote git fetch \; glog HEAD..origin/master
abbr glol glog \| lc-gradient-delay
abbr gcstat git shortlog --summary --numbered
abbr gcstat-all git rev-list --count HEAD

# Tags
function gmv-tag
    git tag $2 $1
    git tag -d $1
    git push origin :refs/tags/$1
    git push --tags
end

# Branches
set -x GREF_FORMAT "%(align:60,left)%(color:blue)%(refname:short)%(end) \
%(color:cyan)%(committerdate:short) %(color:green)[%(authorname)]"
abbr gbranches git branch -vv
abbr gbranch git rev-parse --abbrev-ref HEAD
abbr gbmv git branch -m
abbr gbprune git fetch --prune
abbr grebase-upstream git fetch upstream \; git rebase --interactive upstream/master
abbr gcontinue git rebase --continue
abbr gskip git rebase --skip
abbr gscontinue git stash \; git rebase --continue \; git stash pop

# List all remote branches
function gball
    git for-each-ref --sort=-committerdate --format=\"$GREF_FORMAT\" refs/remotes/
end

# Overwrite local branch with remote
function gbreset
    set _remote (gremote)
    set _branch (gbranch)
    git fetch $_remote $_branch
    git status
    printf "Resetting branch to $_remote/$_branch."
    prompt-confirm && git reset --hard $_remote/$_branch
end

# Pull if repo is alredy cloned, otherwise clone
# gpclone() {
#     repo_dir=${2:-$(basename $1)}
#     echo $repo_dir
#     if [ -d "$repo_dir" ]; then
#         git -C $repo_dir pull
#     else
#         git clone $1 $repo_dir
#     fi
# }

# Delete local and remote branch
function grm-branch -a branch -w git-branch
    printf "Deleting local and remote branch $branch."
    if prompt-confirm
        git branch -D $branch
        git push origin --delete $branch
    end
end
# type -a __git_complete > /dev/null 2>&1 && __git_complete grm-branch _git_branch


##############
# ❰❰ Tmux ❱❱ #
##############

abbr tls tmux ls
abbr trm tmux kill-session -t

# Create new session, or attach if it already exists
function tnew -a session_name start_dir
    tmux new-session -A -s $session_name -c (coalesce $start_dir ~)
end


################
# ❰❰ Python ❱❱ #
################

abbr bb black --target-version py37 --line-length 100 --skip-string-normalization
abbr lsv lsvirtualenv -b

# Get all directories currently on the python site path
function pypath
    python -c "import sys; print('\n'.join(sys.path))"
end

# Get site-packages directory of currently active interpreter (e.g., within a virtualenv)
function py-site-packages
    python -c\
    "from distutils.sysconfig import get_python_lib;\
    print(get_python_lib())"
end
abbr vsp py-site-packages

# Determine if we are running in a virtualenv
function in-env
    python -c\
    "import sys;\
    sys.exit(0 if hasattr(sys, \"real_prefix\") else 1)"
end

# Pip install a package, temporarily disabling any extra indexes or other config
# pip-install-default() {
#     swap $PIP_CONF ${PIP_CONF}.bak
#     pip install "$@"
#     swap $PIP_CONF ${PIP_CONF}.bak
# }

# Install python packages from a specific requirements file
function pip-install-req -a req_file
    echo; print-title "Installing $req_file..."
    test -e $req_file && pip install -Ur $req_file | lc-gradient --seed=100
end

# Install python packages from all available requirements files
function pipr
    for _file in (ls requirements*.txt 2> /dev/null | sort -V)
        pip-install-req $_file
    end
end

# Install/update global python packages, if specified in dotfiles
function update-python
    echo; print-title "Updating python packages..."
    make -C $DOTFILES update-python | lc-gradient-delay
    make -C $DOTFILES_EXTRA update-python | lc-gradient-delay
end

# Pytest shortcut, if not already defined
# cmd-exists pt || pt() {
#     py-cleanup
#     py.test ${1:-./test}
# }

# New virtual environment, with paths and packages (optionally with name, otherwise use dirname)
function mkv -a env_name
    mkvirtualenv -p python3 -a . (default-pwd-base $env_name)
    set -e PYTHONPATH
    add2virtualenv .
    py-cleanup
    pip install -U pip setuptools wheel
    pip install -Ue '.[all]'
    pipr
end

# Clean up leftover junk
function py-cleanup
    set _dir (default-pwd $argv)
    find $_dir -name "*.pyc" -type f -delete -printf "%h/%f\n"
    find $_dir -name "__pycache__" -prune -type d -printf "%h/%f\n" -exec rm -rf '{}' \; 2> /dev/null
end
function vim-cleanup
    set _dir (default-pwd $argv)
    find $_dir -name "*.sw[a-z]" -type f -delete -printf "%h/%f\n"
end

# Run py.test with ludicrous verbosity
function ptv -a path
    set path (coalesce $path ./test)
    py-cleanup
    vim-cleanup
    py.test -vvv -rwrs --capture=no --full-trace $path
end

# Generate HTML py.test coverage report
function ptc -a test_path src_path
    set test_path (coalesce $test_path ./test)
    set src_path (coalesce $src_path (pwd-src))
    py-cleanup
    vim-cleanup
    py.test --junit-xml=test-reports/py.test-latest.xml\
            --cov $src_path\
            --cov-report html $test_path
    set idx_file htmlcov/index.html
    test -e $idx_file && xdg-open $idx_file &
end

function _pyc_file -a module
    python -c "import $module; print($module.__file__)"
end

# Print source path of python module(s)
function pyfile
    for _module in $argv
        _pyc_file $_module | sed 's/\.pyc/\.py/'
    end
end
abbr pf pyfile

# Print source dir of python module(s)
function pydir
    for _module in $argv
        _pyc_file $_module | xargs dirname
    end
end
abbr pd pydir

# Open source file of python module(s)
function vpyfile
    set _paths (pyfile $argv)
    if test -n $_paths[1]
        $EDITOR $_paths
    end
end
abbr vpf vpyfile

# Cat source file of a python module
function catpyfile
    set pf_path (pyfile $argv)
    test -e $pf_path && cat $pf_path
end
abbr cpf cpyfile

# Edit virtualenv path extensions
function vvpathext
    $EDITOR (py-site-packages)/_virtualenv_path_extensions.pth
end
abbr vvp vvpathext

# Workon & cd/deactivate a virtualenv (with autocomplete)
function wo -a env_name
    if test -n $env_name
        workon $env_name
        set -x _VIRT_ENV_PREV_PWD $PWD
        set -e PYTHONPATH
        cd $WORKSPACE/$env_name
    else
        deactivate
        cd $_VIRT_ENV_PREV_PWD
        source $FISH_CONF
    end
end
complete -c wo --wraps=workon

# Misc shortcuts for python apps & scripts
function flask-run
    export FLASK_APP=(pwd-src)/runserver.py
    export FLASK_APP_ENV=LOCAL
    export FLASK_DEBUG=1
    flask run
end


################
# ❰❰ Sphinx ❱❱ #
################

function sphinx-build-current
    # Use 'all' target, if it exists
    make -C docs all | lc-gradient --seed=26
    # If it doesn't exist (make error code 2), use 'html' target
    if [ $PIPESTATUS -eq 2 ]; then
        make -C docs clean html | lc-gradient --seed=26
    end
end

function sphinx-build-project -a env_name
    workon $env_name
    pushd $WORKSPACE/$env_name
    sphinx-build-current
    popd
end

# sphinx-autobuild-current() {
#     sphinx-autobuild docs/ docs/_build/html/ -i *.sw* -z $(pwd-src)
# }
#
# sphinx-autobuild-project() {
#     wo $1
#     sphinx-autobuild docs/ docs/_build/html/ -i *.sw* -z ${1/-/_}
# }
#
# alias sphinx-open-docs='xdg-open docs/_build/html/index.html'
# alias sp-open='sphinx-open-docs'
# alias sp-doc='sphinx-build-current'
# alias spdo='sphinx-build-current && sphinx-open-docs'
# alias sp-autodoc='sphinx-autobuild-current'


##########################
# ❰❰ Distro-Specific ❱❱ #
#########################

# TODO: Separate .bashrc_$distro files, if/when needed

# Tests
# system-is-rpm() {
#     /usr/bin/rpm -q -f /usr/bin/rpm >/dev/null 2>&1
# }
# system-is-debian() { [ -f "/etc/debian_version" ]; }

# Fedora-based
function update-dnf
    print-title "Updating system packages..."
    sudo dnf check
    sudo dnf update -y --skip-broken | lc-hgradient-delay
end
abbr suspend-systemd systemctl suspend
abbr hibernate-systemd systemctl hibernate

# Kernel utils
function ls-kernels
    print-title "All installed kernels:"
    rpm -qa kernel\* | sort -V
end
abbr lsk ls-kernels

function ls-old-kernels -a n_keep
    set n_keep (coalesce $n_keep 2)
    print-title "Current kernel packages (latest $n_keep versions):"
    dnf repoquery --installonly --latest-limit=$n_keep -q
    print-title "Older kernel packages:"
    dnf repoquery --installonly --latest-limit=-$n_keep -q
end
abbr lsko ls-old-kernels

# rm-old-kernels() {
#     n_keep=${1:-2}
#     ls-kernels-old $n_keep
#     echo
#     sudo dnf remove $(dnf repoquery --installonly --latest-limit=-$n_keep -q)
# }

# Debian-based
function update-apt
    print-title "Updating system packages..."
    sudo apt-get update
    sudo apt-get -y --allow-unauthenticated\
        dist-upgrade | lc-hgradient-delay
end

function update-apt-unattended
    print-title "Updating system packages..."
    sudo apt-get update
    sudo apt-get -y --allow-unauthenticated\
        -o Dpkg::Options::="--force-confdef"\
        -o Dpkg::Options::="--force-confnew"\
        dist-upgrade | lc-hgradient-delay
end

abbr suspend-pm pm-suspend
abbr hibernate-pm pm-hibernate

# Install a .deb file from url
# install-deb() {
#     deb_tempfile=$(mktemp --suffix=.deb)
#     wget -O $deb_tempfile $1
#     sudo apt-get install -y $deb_tempfile
#     sleep 1
#     rm $deb_tempfile
# }


##########################
# ❰❰ Proxied Commands ❱❱ #
##########################

# Proxychains executable varies by distro
if type -a proxychains4 >/dev/null 2>&1
    alias proxychains='proxychains4'
end
alias px 'proxychains -q'
abbr -a pxs sudo proxychains -q -f ~/.proxychains/proxychains.conf

# Git
alias gp-px='px git pull'
alias gfpush-px='px git push --force'
alias gpush-px='px git push'
alias gf-px='px git fetch --all'
# gbreset-px() {
#     REMOTE="$(gremote)"
#     BRANCH="$(gbranch)"
#     px git fetch $REMOTE $BRANCH
#     px git status
#     printf "Resetting branch to $REMOTE/$BRANCH."
#     px prompt-confirm && git reset --hard $REMOTE/$BRANCH
# }


# Python
abbr pip-install-px proxychains pip install
# pipr-px() {
#     for f in $(ls requirements*.txt 2> /dev/null | sort -V); do
#         echo; print-title "Installing $f..."
#         px pip install -Ur $f | lc-gradient --seed=100
#     done
# }
# mkv-px() {
#     swap $PIP_CONF ${PIP_CONF}.bak
#     mkvirtualenv -p python3 -a . ${1:-$(pwd-base)}
#     swap $PIP_CONF ${PIP_CONF}.bak
#     add2virtualenv .
#     pipr-px
# }
# function mkv-basic-px
#     swap $PIP_CONF ${PIP_CONF}.bak
#     mkvirtualenv -p python3 ${1:-$(pwd-base)}
#     swap $PIP_CONF ${PIP_CONF}.bak
# end
