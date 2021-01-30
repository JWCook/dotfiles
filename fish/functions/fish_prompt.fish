function fish_prompt
    set last_cmd_status $status
    set -U fish_prompt_bg_1 293d3d
    set -U fish_prompt_bg_2 334d4d
    set -U fish_prompt_bg_3 4b1b4b
    set -U fish_prompt_bg_4 330d00
    set -U fish_color_cwd 8cff66
    set -U fish_color_cwd_sep 40ff00
    set -U fish_color_cwd_root red
    set -U fish_color_user 99e600
    set -U fish_color_branch 1aff8c
    set -U fish_color_venv 1ad1ff
    set -U fish_prompt_pwd_dir_length 3

    echo -s \
        (set_color -b $fish_prompt_bg_1) \
        (_get_user)"@"(_get_hostname) (set_color -b $fish_prompt_bg_2 $fish_prompt_bg_1) \
        (_get_cwd) (set_color -b $fish_prompt_bg_3 $fish_prompt_bg_2) \
        (_get_branch) (set_color -b $fish_prompt_bg_4 $fish_prompt_bg_3) \
        (_get_virtualenv) (set_color -b black $fish_prompt_bg_4) \
        (_get_prompt_symbol $last_cmd_status)
end

# Format current user
function _get_user
    echo -n -s (set_color $fish_color_user) "$USER" (set_color $fish_color_cwd_sep)
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
