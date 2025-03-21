#!/usr/bin/env fish
# Move a subset of files/dirs out of $HOME based on suggestions from xdg-ninja

function safe_mv -a old_path -a xdg_path
    # Variable for XDG path not set
    if test -z $xdg_path || test -z $old_path
        echo "Missing XDG path for $old_path"
    # Old path doesn't exist
    else if ! test -e $old_path
        echo "Skipping $old_path (does not exist)"
    # Both old and new paths exist
    else if test -e $old_path && test -e $xdg_path
        rm -rfv $old_path
    # Only old path exists
    else if test -e $old_path && ! test -e $xdg_path
        mkdir -p (dirname $xdg_path)
        mv -v $old_path $xdg_path
    end
end

safe_mv ~/.bash_history $HISTFILE
safe_mv ~/.cargo $CARGO_HOME
safe_mv ~/.gnupg $GNUPGHOME
safe_mv ~/.gtkrc-2.0 $GTK2_RC_FILES
safe_mv ~/.dotnet $DOTNET_CLI_HOME
safe_mv ~/.ipython $XDG_CONFIG_HOME/ipython
safe_mv ~/.nvm $NVM_DIR
safe_mv ~/.psqlrc $PSQLRC
safe_mv ~/.rustup $RUSTUP_HOME
safe_mv ~/.tig_history $XDG_DATA_HOME/tig/history


# TODO
# -----------

# [npm]: /home/jcook/.npm
#
#   Export the following environment variables:
#
#     export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
#     export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
#     export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm
#
# [nss]: /home/jcook/.pki
#
#   Disclaimer: XDG is supported, but directory may be created again by some
#   programs.
#
#   XDG is supported out-of-the-box, so we can simply move directory to
#   "$XDG_DATA_HOME"/pki.
#
#   Note: some apps (chromium, for example) hardcode path to "$HOME"/.pki, so
#   directory may appear again, see
#   https://bugzilla.mozilla.org/show_bug.cgi?id=818686#c11
#   https://bugzilla.mozilla.org/show_bug.cgi?id=818686#c11.
#
# [tmux]: /home/jcook/.tmux
#   Set this in your tmux.conf:
#
#    set-environment -g TMUX_PLUGIN_MANAGER_PATH '~/.local/share/tmux/plugins'
#
#   Then update the path to tpm to:
#
#    run '~/.local/share/tmux/plugins/tpm/tpm'
#
#   Now move .tmux to XDG_DATA_HOME/tmux.
#
# [vim]: /home/jcook/.vimrc
#
#   Supported since 9.1.0327 vim will search for  $XDG_CONFIG_HOME /vim/vimrc if no
#   other configuration file is found in  $HOME  or  $HOME/.vim .
#   To migrate to use  $XDG_CONFIG_HOME/vim/  directory, move  ~/.vimrc  and
#   ~/.vim/vimrc  file.
#
#   Otherwise, since 7.3.1178 vim will search for ~/.vim/vimrc if ~/.vimrc is not
#   found.
#
#   "$XDG_CONFIG_HOME"/vim/vimrc
#
#     set runtimepath^=$XDG_CONFIG_HOME/vim
#     set runtimepath+=$XDG_DATA_HOME/vim
#     set runtimepath+=$XDG_CONFIG_HOME/vim/after
#
#     set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
#     set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after
#
#     let g:netrw_home = $XDG_DATA_HOME."/vim"
#     call mkdir($XDG_DATA_HOME."/vim/spell", 'p')
#
#     set backupdir=$XDG_STATE_HOME/vim/backup | call mkdir(&backupdir, 'p')
#     set directory=$XDG_STATE_HOME/vim/swap   | call mkdir(&directory, 'p')
#     set undodir=$XDG_STATE_HOME/vim/undo     | call mkdir(&undodir,   'p')
#     set viewdir=$XDG_STATE_HOME/vim/view     | call mkdir(&viewdir,   'p')
#
#     if !has('nvim') | set viminfofile=$XDG_STATE_HOME/vim/viminfo | endif
#
#   ~/.profile
#
#     export GVIMINIT='let $MYGVIMRC="$XDG_CONFIG_HOME/vim/gvimrc" | source
#   $MYGVIMRC'
#     export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
#
#   [G]VIMINIT environment variable will also affect Neovim. If separate configs for
#   Vim and Neovim are desired then the following will be a better choice:
#
#     export GVIMINIT='let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc"
#   : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
#     export VIMINIT='let $MYVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/vimrc" :
#   "$XDG_CONFIG_HOME/nvim/init.vim" | so $MYVIMRC'
#
#   Additional information:
#   https://jorengarenar.github.io/blog/vim-xdg
#   https://jorengarenar.github.io/blog/vim-xdg
#   https://tlvince.com/vim-respect-xdg https://tlvince.com/vim-respect-xdg
#
# [vim]: /home/jcook/.viminfo
#
#   See help for .vimrc
#
# [vim]: /home/jcook/.vim
#
#   See help for .vimrc
