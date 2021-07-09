set -g VIRTUALFISH_VERSION 2.5.1
set -g VIRTUALFISH_PYTHON_EXEC /home/jcook/.pyenv/shims/python
set VF_SITE_PACKAGES ~/.local/lib/python3.9/site-packages/virtualfish
# set VF_SITE_PACKAGES ~/.pyenv/versions/3.9.6/lib/python3.9/site-packages/virtualfish
function source-file
    test -f $1 && source $argv
end
source-file $VF_SITE_PACKAGES/virtual.fish
source-file $VF_SITE_PACKAGES/compat_aliases.fish
source-file $VF_SITE_PACKAGES/global_requirements.fish
source-file $VF_SITE_PACKAGES/projects.fish
emit virtualfish_did_setup_plugins
