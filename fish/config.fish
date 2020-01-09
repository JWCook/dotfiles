#################
# ❰❰ Plugins ❱❱ #
#################

fundle plugin 'fishpkg/fish-git-util'
fundle init

eval (python -m virtualfish compat_aliases)


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
    coalesce $argv[1] '.'
end

# Set and argument to current dir if not specified
function default-pwd-base
    set _pwd (pwd-base)
    coalesce $argv[1] "$_pwd"
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
pathadd ~/bin
pathadd ~/scripts
pathadd /usr/local/bin
pathadd /usr/local/sbin
set -x DOTFILES ~/dotfiles
# [ -z "$DOTFILES_EXTRA" ] && set DOTFILES_EXTRA=~/dotfiles-extra
set -x WORKSPACE ~/workspace
alias cw='cd $WORKSPACE'

set -gx PYTHONPATH ~/.local/lib/python3.7/site-packages
set -x IGNORE_PATTERNS '*.pyc|*.sw*|.cache|.git|__pycache__'


#########################
# ❰❰ General Aliases ❱❱ #
#########################

set -gx EDITOR /usr/bin/nvim

# Simple Command/App Aliases
abbr -a term-code terminator -mfl code \&
abbr -a term-dev terminator -mfl 6-split \&
abbr -a term-start terminator -l start \&
abbr -a retroterm /usr/local/src/retro-term/cool-retro-term \&
abbr -a lw sudo logwatch \| less
abbr -a ta type -a
complete -c ta -w type
abbr -a top htop
abbr -a tt tig
abbr -a vim nvim
abbr -a vimdiff nvim -d
abbr -a weather curl -4 http://wttr.in/~50266


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
abbr -a du /usr/bin/du -Sh $argv \| sort -hr \| color-filesize \| more
abbr -a ll ls -Alhv --group-directories-first           # Can't live without it
# lt() { tree $@ | color-filesize; }                      # Colored folder tree
# lt2() { tree -L 2 $@ | color-filesize; }                # Colored folder tree (depth 2)
# md() { mkdir -p "$@" && cd "$@"; }                      # Create a dir and enter it
# mode() { stat -c "%a %n" {$argv:-*}; }                  # Get octal file permissions
abbr -a pwd-base basename \(pwd\)                       # Base name of the current working dir
abbr -a pwd-src basename \(pwd\) \| sed 's/-/_/g'       # Guess name of project src dir
abbr -a tailf tail -f -n 50                             # Tail -f w/ defaults
abbr -a tailc tailf $argv \| grcat conf.logfile         # Tail -f w/ generic syntax highlighting
abbr -a tree /usr/bin/tree -CAFah --du --dirsfirst --prune -I \""$IGNORE_PATTERNS"\"


############################
# ❰❰ Disk & Device Info ❱❱ #
############################

# Readable disk usage
function df
    # /usr/bin/df -khT $argv | color-filesize
    /usr/bin/df -khT $argv | less
end

# Get a single metric for a single device (or a directory's device)
# Usage: df-single-metric device [metric]
function df-single-metric
    set _dir (default-pwd $argv)
    /usr/bin/df --block-size=1 --output="$argv[2]" "$_dir" | /usr/bin/tail -1
end

# Shortcuts for individual metrics
function df-device; df-single-metric "$argv[1]" "source"; end
function df-type;   df-single-metric "$argv[1]" "fstype"; end
function df-size;   df-single-metric "$argv[1]" "size"; end
function df-use;    df-single-metric "$argv[1]" "used"; end
function df-free;   df-single-metric "$argv[1]" "avail"; end
function df-mount;  df-single-metric "$argv[1]" "target"; end


#################
# ❰❰ Network ❱❱ #
#################

abbr -a listen lsof -P -i -n \| grcat conf.nmap
function local-ip
    ifconfig | awk "/inet/ { print $argv[2] } " | sed -e s/addr://
end
abbr -a public-ip curl v4.ifconfig.co
abbr -a netconn netstat -pan --inet
abbr -a tracert traceroute
abbr -a unproxy unset http_proxy https_proxy ftp_proxy no_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY
abbr -a scan-local nmap -v -sT localhost
abbr -a scan-syn sudo nmap -v -sS localhost
abbr -a ssh-exit ssh -O exit
abbr -a ssh-refresh nullify ssh -O exit $argv \; ssh $argv

# Mount a network share (remote_share, local_mountpoint, creds_file)
function mount-share
    if not mountpoint "$argv[2]" > /dev/null 2>&1
        sudo mkdir -p "$argv[2]"
        sudo mount -v -t cifs -o credentials="$argv[3]" "$argv[1]" "$argv[2]"
    else
        echo 'Already mounted'
    end
end


#####################
# ❰❰ System Info ❱❱ #
#####################

abbr -a date-update sudo ntpdate $NTP_SERVER
abbr -a lu column -ts: /etc/passwd \| sort                                  # Formatted local user list
abbr -a lu-current w -hs \| cut -d \" \" -f1 \| sort \| uniq                  # Currently logged on users
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
abbr -a vb "$EDITOR $BASH_CONF"
abbr -a vbb "$EDITOR -O2 $BASH_CONF_ALL"
abbr -a vg "$EDITOR $GIT_CONF"
abbr -a vv "$EDITOR $VIM_CONF"
abbr -a vvv "$EDITOR -O2 $VIM_CONF_ALL"
abbr -a vc "$EDITOR -O2 $BASH_CONF_ALL $FISH_CONF $FISH_FUNCS $VIM_CONF_ALL $GIT_CONF $PG_CONF $SSH_CONF $SETUP_CONF"
abbr -a svim "sudo -E $EDITOR"

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
abbr -a gf git fetch --all
abbr -a ggr git grep
abbr -a gp git pull
abbr -a gpr git pull --rebase
abbr -a gpush git push
abbr -a gfpush git push --force
abbr -a gstash git stash
abbr -a gpop git stash pop
abbr -a gremote git remote \| head -n 1
abbr -a groot cd \(git rev-parse --show-toplevel\)
abbr -a gs git status
abbr -a gsv git status -vv
abbr -a gss git status --short
abbr -a gstlist git stash list \; git stash show

function gadd
    set _paths (default-pwd $argv)
    git add "$_paths"
end

function gpr
    git stash
    git pull --rebase
    git stash pop
end

function grm
    rm "$argv"
    git rm "$argv"
end

# Commits
abbr -a gc git commit --verbose
abbr -a gcm git commit -m
abbr -a gfirst git rev-parse --short \(git rev-list --max-parents=0 HEAD\)
abbr -a gmend git commit --amend
abbr -a gmendc git commit --amend --no-edit
abbr -a gpatch git add --patch
abbr -a gunstage git reset HEAD
abbr -a grevise git add --all \; git commit --amend --no-edit
abbr -a grecommit git commit -c ORIG_HEAD --no-edit
abbr -a guncommit git reset --soft HEAD~1

# Fix a branch from a detatched HEAD state, starting with a specified commit
function git-head-transplant
    git checkout -b transplant $argv
    git branch -f master transplant
    git checkout master
    git branch -d transplant
    git push origin master
end

# Log
export GLOG_FORMAT="%C(blue)%h  %C(cyan)%ad  %C(reset)%s%C(green) [%cn] %C(yellow)%d"
abbr -a glog git log --pretty=format:\"$GLOG_FORMAT\" --decorate --date=short
abbr -a glog-branch glog master..HEAD
abbr -a glog-remote git fetch \; glog HEAD..origin/master
abbr -a glol glog \| lc-gradient-delay
abbr -a gcstat git shortlog --summary --numbered
abbr -a gcstat-all git rev-list --count HEAD

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
abbr -a gbranches git branch -vv
abbr -a gbranch git rev-parse --abbrev-ref HEAD
abbr -a gbmv git branch -m
abbr -a gball git for-each-ref --sort=-committerdate --format=\"$GREF_FORMAT\" refs/remotes/
abbr -a gbprune git fetch --prune
abbr -a grebase-upstream git fetch upstream \; git rebase --interactive upstream/master
abbr -a gcontinue git rebase --continue
abbr -a gskip git rebase --skip
abbr -a gscontinue git stash \; git rebase --continue \; git stash pop

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
# grm-branch() {
#     printf "Deleting branch $1."
#     if prompt-confirm; then
#         git branch -D $1
#         git push origin --delete $1
#     fi
# }
# type -a __git_complete > /dev/null 2>&1 && __git_complete grm-branch _git_branch


##############
# ❰❰ Tmux ❱❱ #
##############

alias tls='tmux ls'
alias trm='tmux kill-session -t'
# Create new session, or attach if it already exists
# function tnew
#     tmux new-session -A -s $1 -c ${2:-~}
# end


################
# ❰❰ Python ❱❱ #
################

abbr -a bb black --target-version py37 --line-length 100 --skip-string-normalization
abbr -a lsv lsvirtualenv -b

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
abbr -a vsp py-site-packages

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
# pip-install-req() {
#     echo; print-title "Installing $1..."
#     [[ -f $1 ]] && pip install -Ur $1 | lc-gradient --seed=100
# }

# Install python packages from all available requirements files
# pipr() {
#     for f in $(ls requirements*.txt 2> /dev/null | sort -V); do
#         pip-install-req $f
#     done
# }

# Install/update global python packages, if specified in dotfiles
function update-python
    echo; print-title "Updating python packages..."
    make -C $DOTFILES update-python #| lc-gradient-delay
    make -C $DOTFILES_EXTRA update-python #| lc-gradient-delay
end

# Pytest shortcut, if not already defined
# cmd-exists pt || pt() {
#     py-cleanup
#     py.test ${1:-./test}
# }

# New virtual environment, with paths and packages (optionally with name, otherwise use dirname)
function mkv
    set _dir (default-pwd-base $argv)
    mkvirtualenv -p python3 -a . "$_dir"
    add2virtualenv .
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
# ptv(){
#     py-cleanup
#     vim-cleanup
#     py.test -vvv -rwrs --capture=no --full-trace ${1:-./test}
# }

# Generate HTML py.test coverage report
# ptc() {
#     py-cleanup
#     vim-cleanup
#     py.test --junit-xml=test-reports/py.test-latest.xml\
#             --cov ${1:-$(pwd-src)}\
#             --cov-report html ./test
#     [[ -f htmlcov/index.html ]] && xdg-open htmlcov/index.html &
# }

function _pyc_file
    python -c "import $argv[1]; print($argv[1].__file__)"
end

# Print source path of python module(s)
function pyfile
    for _module in $argv
        _pyc_file $_module | sed 's/\.pyc/\.py/'
    end
end
abbr -a pf pyfile

# Print source dir of python module(s)
function pydir
    for _module in $argv
        _pyc_file $_module | xargs dirname
    end
end
abbr -a pd pydir

# Open source file of python module(s)
function vpyfile
    set _paths (pyfile $argv)
    if test -n $_paths[1]
        $EDITOR $_paths
    end
end
abbr -a vpf vpyfile

# Cat source file of a python module
# cpyfile() {
#     pf_path=$(pyfile $@)
#     [[ -f $pf_path ]] && cat $pf_path
# }
# alias cpf='cpyfile'

# Edit virtualenv path extensions
function vvpathext
    $EDITOR (py-site-packages)/_virtualenv_path_extensions.pth
end
abbr -a vvp vvpathext

# Workon & cd/deactivate a virtualenv (with autocomplete)
function wo
    if test -n $argv
        workon $argv
        set -x _VIRT_ENV_PREV_PWD $PWD
        cd $WORKSPACE/$argv
    else
        deactivate
        cd $_VIRT_ENV_PREV_PWD
    end
end
complete -c wo --wraps=workon

# Misc shortcuts for python apps & scripts
# alias flask-run='export FLASK_APP=$(pwd-src)/runserver.py;\
#                  export FLASK_APP_ENV=LOCAL;\
#                  export FLASK_DEBUG=1;\
#                  flask run'
#

################
# ❰❰ Sphinx ❱❱ #
################

# sphinx-build-current() {
#     # Use 'all' target, if it exists
#     make -C docs all | lc-gradient --seed=26
#     # If it doesn't exist (make error code 2), use 'html' target
#     if [ $PIPESTATUS -eq 2 ]; then
#         make -C docs clean html | lc-gradient --seed=26
#     fi
# }
#
# sphinx-build-project() {
#     workon $1
#     pushd $WORKSPACE/$1
#     sphinx-build-current
#     popd
# }
#
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
