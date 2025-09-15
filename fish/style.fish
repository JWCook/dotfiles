#########################
# ❰❰ Terminal Colors ❱❱ #
#########################

# Terminal Control Characters (mainly for bash script compatibility)
set -xg BLACK '\033[0;30;29m'
set -xg RED '\033[0;31;29m'
set -xg GREEN '\033[0;32;29m'
set -xg YELLOW '\033[0;33;29m'
set -xg BLUE '\033[0;34;29m'
set -xg MAGENTA '\033[0;35;29m'
set -xg CYAN '\033[0;36;29m'
set -xg WHITE '\033[0;37;29m'
set -xg BOLD_BLACK '\033[1;30;29m'
set -xg BOLD_RED '\033[1;31;29m'
set -xg BOLD_GREEN '\033[1;32;29m'
set -xg BOLD_YELLOW '\033[1;33;29m'
set -xg BOLD_BLUE '\033[1;34;29m'
set -xg BOLD_MAGENTA '\033[1;35;29m'
set -xg BOLD_CYAN '\033[1;36;29m'
set -xg BOLD_WHITE '\033[1;37;29m'
set -xg DIM_BLACK '\033[2;30;29m'
set -xg DIM_RED '\033[2;31;29m'
set -xg DIM_GREEN '\033[2;32;29m'
set -xg DIM_YELLOW '\033[2;33;29m'
set -xg DIM_BLUE '\033[2;34;29m'
set -xg DIM_MAGENTA '\033[2;35;29m'
set -xg DIM_CYAN '\033[2;36;29m'
set -xg DIM_WHITE '\033[2;37;29m'
set -xg NOCOLOR '\033[0m'

# Determine how many times a string can fit in the current terminal width
function string-fit -a text
    test -z "$text" && return 1
    math --scale=0 $COLUMNS / (string length -- $text)
end

# Repeat a string n times (defaults to fit terminal)
function repeat-str -a text length
    test -z "$text" && return 1
    set -l length (coalesce $length (string-fit $text))
    string repeat -n $length -- $text
end

function printc -a color text
    printf "%b%b$NOCOLOR\n" "$color" "$text"
end

function print-title
    set HRULE (repeat-str '=')
    printc $CYAN "$HRULE"
    printc $BLUE "$argv"
    printc $CYAN "$HRULE"
end


############################
# ❰❰ Colorized Commands ❱❱ #
############################

# Bash commands using GRC
set -x GRC (which grc)
if [ "$TERM" != "dumb" ] && ! test -z "$GRC" && test -e "$GRC"
    alias colorize="$GRC -es --colour=auto"
    alias as='colorize as'
    alias configure='colorize ./configure'
    alias diff='colorize diff'
    alias dig='colorize dig'
    alias gas='colorize gas'
    alias gcc='colorize gcc'
    alias g++='colorize g++'
    alias head='colorize head'
    alias ld='colorize ld'
    alias make='colorize make'
    alias mount='colorize mount'
    alias mtr='colorize mtr'
    alias netstat='colorize netstat'
    alias nmap='colorize nmap'
    alias ping='colorize ping'
    alias ps='colorize ps'
    alias traceroute='colorize traceroute'
    alias tail='colorize tail'
end

# Man pages
# set -x LESS_TERMCAP_mb '\E[0;103m'
# set -x LESS_TERMCAP_md '\E[04;34m'
# set -x LESS_TERMCAP_me '\E[0m'
# set -x LESS_TERMCAP_se '\E[0m'
# set -x LESS_TERMCAP_so (tty -s && tput bold; tty -s && tput setaf 8; tty -s && tput setab 3)
# set -x LESS_TERMCAP_ue '\E[0m'
# set -x LESS_TERMCAP_us '\E[04;36m'
# set -x LESS_TERMCAP_mr (tty -s && tput rev)
# set -x LESS_TERMCAP_mh (tty -s && tput dim)
# set -x LESS_TERMCAP_ZN (tty -s && tput ssubm)
# set -x LESS_TERMCAP_ZV (tty -s && tput rsubm)
# set -x LESS_TERMCAP_ZO (tty -s && tput ssupm)
# set -x LESS_TERMCAP_ZW (tty -s && tput rsupm)

# Other Commands
set -x LS_COLORS "di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
function color-filesize
    sed -r\
        "s/([0-9\.]+K)/$(set_color green)\1$(set_color normal)/g;\
        s/([0-9\.]+M)/$(set_color cyan)\1$(set_color normal)/g;\
        s/([0-9\.]+G)/$(set_color --bold red)\1$(set_color normal)/g"
end


####################
# ❰❰ Psql Pager ❱❱ #
####################

# set -x PG_LESS "-ieMSKx4FXR"
# PG_PAGER="sed \"s/\([[:space:]]\+[0-9.\-]\+\)$/$(pg-color $CYAN)\1$(pg-color $NOCOLOR)/;"
# PG_PAGER+="s/\([[:space:]]\+[0-9.\-]\+[[:space:]]\)/$(pg-color $CYAN)\1$(pg-color $NOCOLOR)/g;"
# PG_PAGER+="s/\([[:space:]]\+¤[[:space:]]\)/$(pg-color $MAGENTA)\1$(pg-color $NOCOLOR)/g;"
# PG_PAGER+="s/\([[:space:]]\+[a-f0-9\-]\{36\}[[:space:]]\)/$(pg-color $GREEN)\1$(pg-color $NOCOLOR)/g;"
# # PAGER+="s/\(\s[a-f_]\+\s\)/${BOLD_MAGENTA}\1${NOCOLOR}/g;"
# PG_PAGER+="s/\([|│]\)/$(pg-color $BLUE)\1$(pg-color $NOCOLOR)/g;s/^\([-+─┌┐├┬┼┴┤└┘]\+\)/$(pg-color $BLUE)\1$(pg-color $NOCOLOR)/\" 2>/dev/null | less"
# export PG_PAGER


#############################
# ❰❰ ✈ ✈ ✈ ✈ ✈ ✈ ✈ ✈ ✈ ✈ ❱❱ #
#############################

# Lolcat
alias lolcat-q='lolcat 2> /dev/null'
alias lc-gradient='lolcat-q --spread=100 --freq=0.08 2> /dev/null'
alias lc-hgradient='lolcat-q --spread=0.1 --freq=0.005 2> /dev/null'
alias lc-gradient-delay='lc-gradient --animate --speed 250'
alias lc-hgradient-delay='lc-hgradient --animate --speed 250'
alias lc-loop='lolcat-q --animate --duration=99999999'
alias lc-flash='lc-loop --speed=50 --spread=1 --freq=1'

# Print text in rainbow ASCII art
function figlol -a text font
    set font (coalesce $font ~/.figlet/univers.flf)
    figlet -w 270 -f $font "$text" | lolcat -a -d 1
end

# Print text in rainbow ASCII art for each font available
function figlet-all
    set fonts (ls ~/.figlet/*.flf)
    for font in $fonts
        basename $font
        figlol $argv $font
    end
end
# alias fabulous='figlol ~/.figlet/alligator.flf'
# alias faabulous='figlol ~/.figlet/starwars.flf'
# alias faaabulous='figlol ~/.figlet/univers.flf'
# alias faaaabulous='figlol ~/.figlet/roman.flf'
# alias faaaaabulous='figlol ~/.figlet/contessa.flf'
# alias faaaaaabulous='figlol ~/.figlet/cybermedium.flf'
# alias faaaaaaabulous='figlol ~/.figlet/cosmic.flf'

# Misc string coloring/formatting
alias ratelimit 'pv -qL80k'
function randombit
    shuf -i 0-1 -n 1 -z  | tr "\0" " "
end
# function randomchars
#     grep -o --binary-files=text "[[:alpha:]]" /dev/urandom |\
#         tr -d "[a-zA-Z]" |\
#         xargs -n ((($COLUMNS*80)/100)) |\
#         tr -d " "
# end
# function charbar
#     python -c "print('$argv[1]' * $(($COLUMNS*2)))"
# end
# function charbar2
#     python -c "print('$argv[1] ' * $(($COLUMNS)))"; }  # Extra spacing for wide chars
# end
# function charbarf
#     charbar $argv[1] | lc-loop -p $argv[2]
# end
# function charbarf2
#     charbar2 $argv[1] | lc-loop -p $argv[2]
# end
# function color-bit
#     printf "\e[$(echo $argv[1]|tr 01 20);32;29m$argv[1]\e[0m"
# end
# function color-bar
#     printf "\x1b[48;5;$argv[1]m\n"
# end
# function color-str
#     printf "\e[38;5;$(($(od -d -N 2 -A n /dev/urandom)%$(tty -s && tput colors)))m$argv[1]\e[0m"
# end
#
# # Print loops
# alias hex-barf='cat /dev/urandom | hexdump -C | grep "b1 05"'
# alias bin-barf='while true; do color-bit $(randombit); done'
# alias term-barf-1='while true; do color-str •; done'
# alias term-barf-2='yes "$(seq 231 -1 16)" | while read i; do color-bar $i; sleep .02; done'
# alias term-barf-3='randomchars | lolcat -f | ratelimit'
# alias term-barf-4='randomchars | figlet -w 120 | lolcat -f | ratelimit'
# alias term-barf-5a='charbarf '•' 2'
# alias term-barf-5b='charbarf '¤' 4'
# alias term-barf-5c='charbarf '●' 55'
# alias term-barf-5d='charbarf '◤' 60'
# alias term-barf-5e='charbarf '█' 1'
# alias term-barf-5f='charbarf '▉' 65'
# alias term-barf-5f='charbarf ― 2'
# alias term-barf-6a='charbarf2 ⬛️ 0.5'
# alias term-barf-6b='charbarf2 🔲 2'
# alias term-barf-6c='charbarf2 💩 10'
#
# # More colorized commands
# alias fortune='fortune | lolcat -a'
# alias fabulous-syslog='syslog | lolcat -a'
# alias fabulous-ls='ll | lolcat -a'
# alias fabulous-netstat='while true; do netconn | lolcat -a; done'
# alias fabulous-ps='psu | lolcat -a'
