function fish_prompt
    set last_cmd_status $status
    set -U fish_prompt_bg_1 3d5c5c
    set -U fish_prompt_bg_2 527a7a
    set -U fish_prompt_bg_3 669999
    set -U fish_color_cwd 00cc66
    set -U fish_color_cwd_root red
    set -U fish_color_user 99e600
    set -U fish_color_branch 4d4dff
    set -U fish_color_venv 5200cc
    set -U fish_prompt_pwd_dir_length 3

    echo -n -s (set_color -b $fish_prompt_bg_1) (_get_user)"@"(_get_hostname) (set_color -b $fish_prompt_bg_2 $fish_prompt_bg_1)
    echo -n -s (_get_cwd) (set_color -b $fish_prompt_bg_3 $fish_prompt_bg_2)
    echo -n (_get_branch) (_get_virtualenv)(set_color -b black $fish_prompt_bg_3)
    echo (_get_prompt_symbol $last_cmd_status)
end

# Format current user
function _get_user
    echo -n -s (set_color $fish_color_user) "$USER"
end

# Format current hostname
function _get_hostname
    set _hostname (string replace "localhost" "🏠" (prompt_hostname))
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

# Format prompt symbol
function _get_prompt_symbol
    # Change prompt symbol if running as root
    if [ $USER = "root" ]
        set prompt_symbol '#'
    else
        set prompt_symbol '$'
    end

    # Color prompt symbol if last command failed
    if [ $argv = 0 ]
        set prompt_symbol_color normal
    else
        set prompt_symbol_color red
    end

    echo -n -s (set_color $prompt_symbol_color) ' ' $prompt_symbol ' ' (set_color normal)
end
