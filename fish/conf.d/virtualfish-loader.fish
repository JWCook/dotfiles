set -g VIRTUALFISH_VERSION 2.5.1
set -g VIRTUALFISH_PYTHON_EXEC /home/jcook/.pyenv/shims/python
set VF_SITE_PACKAGES ~/.local/lib/python3.9/site-packages/virtualfish
source $VF_SITE_PACKAGES/virtual.fish
source $VF_SITE_PACKAGES/compat_aliases.fish
source $VF_SITE_PACKAGES/global_requirements.fish
source $VF_SITE_PACKAGES/projects.fish
emit virtualfish_did_setup_plugins
