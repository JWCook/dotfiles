#!/usr/bin/env fish
# Display fish shell colors

function _show_color
    set color_name $argv[1]
    set color_hex (_strip_color $argv[2])

    printf "%-8s   %s " $color_name $color_hex

    # Print colored block using the hex color
    set_color -b $color_hex
    printf "        "
    set_color normal

    # Print text sample in that color
    printf " "
    set_color $color_hex
    printf "Sample Text"
    set_color normal

    printf "\n"
end

function _strip_color -a color
    echo -n $color | sed 's/--background=//g' | sed 's/--bold//g' | sed 's/--italics//g'
end

function palette_test
    echo "Fish Palette Test"
    echo "=========================================="
    echo

    _show_color fish_color_normal            $fish_color_normal
    _show_color fish_color_command           $fish_color_command
    _show_color fish_color_keyword           $fish_color_keyword
    _show_color fish_color_quote             $fish_color_quote
    _show_color fish_color_redirection       $fish_color_redirection
    _show_color fish_color_end               $fish_color_end
    _show_color fish_color_option            $fish_color_option
    _show_color fish_color_error             $fish_color_error
    _show_color fish_color_param             $fish_color_param
    _show_color fish_color_comment           $fish_color_comment
    _show_color fish_color_selection         $fish_color_selection
    _show_color fish_color_search_match      $fish_color_search_match
    _show_color fish_color_operator          $fish_color_operator
    _show_color fish_color_escape            $fish_color_escape
    _show_color fish_color_autosuggestion    $fish_color_autosuggestion
end
