#!/usr/bin/env fish
# Install lazygit from source
#
set clone_dir $HOME/workspace/@forks/lazygit
set install_dir $HOME/.local/bin

mkdir -p (dirname $clone_dir)
mkdir -p $install_dir

if test -d "$clone_dir/.git"
    cd $clone_dir
    git pull
else
    git clone https://github.com/jesseduffield/lazygit.git $clone_dir
    cd $clone_dir
end

set lg_version (git describe --tags --abbrev=0 | string replace 'v' '')
set commit (git rev-parse HEAD)
set build_date (date -u +%Y-%m-%dT%H:%M:%SZ)

go build \
    -o lazygit \
    -ldflags "\
        -X main.version=$lg_version \
        -X main.commit=$commit \
        -X main.date=$build_date \
        -X main.buildSource=local \
    " \
    .

mv lazygit $install_dir/lazygit
echo "Installed to $install_dir/lazygit"
$install_dir/lazygit --version
