status is-interactive || exit 0

function atuin_key_bindings
    bind \cr _atuin_search
    bind -k up _atuin_bind_up
    bind \eOA _atuin_bind_up
    bind \e\[A _atuin_bind_up
    if bind -M insert >/dev/null 2>&1
        bind -M insert \cr _atuin_search
        bind -M insert -k up _atuin_bind_up
        bind -M insert \eOA _atuin_bind_up
        bind -M insert \e\[A _atuin_bind_up
    end
end
