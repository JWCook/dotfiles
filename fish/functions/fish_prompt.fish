set -x HOST_ICON (hostnamectl 2>/dev/null | sed -n 's/\s*Chassis: \w*\s*\(.*\)/\1/p')

function fish_prompt
    set last_cmd_status $status
    set -U fish_prompt_bg_1 (_strip_color $fish_color_selection)
    set -U fish_prompt_bg_2 $fish_color_comment
    set -U fish_prompt_bg_3 (_strip_color $fish_color_selection)
    set -U fish_prompt_bg_4 $fish_color_comment
    set -U fish_color_cwd $fish_color_quote
    set -U fish_color_cwd_sep $fish_color_keyword
    set -U fish_color_cwd_root red
    set -U fish_color_user $fish_color_normal
    set -U fish_color_branch $fish_color_end
    set -U fish_color_venv $fish_color_operator
    set -U fish_prompt_error $fish_color_error
    set -U fish_prompt_pwd_dir_length 3
    set prompt_symbol_color (_get_cmd_color $last_cmd_status)

    echo -s \
        (set_color -b $fish_prompt_bg_1) \
        (_get_user)"@"(_get_hostname) (set_color -b $fish_prompt_bg_2 $fish_prompt_bg_1) \
        (_get_cwd) (set_color -b $fish_prompt_bg_3 $fish_prompt_bg_2) \
        (_get_branch) (set_color -b $fish_prompt_bg_4 $fish_prompt_bg_3) \
        (_get_virtualenv) (set_color -b $prompt_symbol_color $fish_prompt_bg_4) \
        (set_color -b black $prompt_symbol_color)' '\
        (set_color normal)
end

function _strip_color -a color
    echo -n $color | sed 's/--background=//g'
end


# Format user
function _get_user
    echo -n -s (set_color $fish_color_user) "$USER" (set_color $fish_color_cwd_sep)
end

# Format hostname
function _get_hostname
    set _hostname (string replace "localhost" "🏠" (prompt_hostname))
    set _hostname (string replace "$USER-" "" "$_hostname")
    set _hostname (string replace -- "-7500" "" "$_hostname")
    set _hostname {$_hostname}$HOST_ICON
    echo -n -s (set_color $fish_color_user) "$_hostname"
end

# Format current working directory
function _get_cwd
    # Change color if running as root
    if [ $USER = "root" ]
        set color_cwd $fish_color_cwd_root
    else
        set color_cwd $fish_color_cwd
    end

    echo -n -s (set_color $color_cwd) (prompt_pwd)
end

# Format current git branch (if any)
function _get_branch
    set branch (git_branch_name)
    if test -n "$branch"
        echo -n -s (set_color $fish_color_branch) "$branch"
    end
end

# Format current python virtualenv (if any)
function _get_virtualenv
    if set -q VIRTUAL_ENV
        set venv_name (basename "$VIRTUAL_ENV")
        echo -n -s (set_color $fish_color_venv) " $venv_name"
    end
end

# Color prompt symbol if last command failed
function _get_cmd_color -a last_cmd_status
    if test $last_cmd_status -eq 0
        echo -n -s $fish_prompt_bg_2
    else
        echo -n -s $fish_prompt_error
    end
end
