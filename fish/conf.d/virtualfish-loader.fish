set -g VIRTUALFISH_VERSION 2.5.5
set -g VIRTUALFISH_PYTHON_EXEC /home/jcook/.pyenv/shims/python
set VF_SITE_PACKAGES ~/.local/lib/python3.11/site-packages/virtualfish
# set VF_SITE_PACKAGES ~/.pyenv/versions/3.11.0/lib/python3.11/site-packages/virtualfish
# set VF_SITE_PACKAGES ~/.pyenv/versions/3.10.8/lib/python3.10/site-packages/virtualfish
function source-file
    test -f $1 && source $argv
end
source-file $VF_SITE_PACKAGES/virtual.fish
source-file $VF_SITE_PACKAGES/compat_aliases.fish
source-file $VF_SITE_PACKAGES/global_requirements.fish
source-file $VF_SITE_PACKAGES/projects.fish

