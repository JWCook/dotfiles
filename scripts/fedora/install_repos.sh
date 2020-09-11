#!/usr/bin/env bash

# Install additional repos for Fedora
# IUS https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-28.noarch.rpm

RELEASEVER=$(rpm -E %fedora)

read -d '' REPO_RPMS << EOF
    https://rpmfind.net/linux/fedora/linux/releases/$RELEASEVER/Everything/x86_64/os/Packages/g/gdouros-symbola-fonts-10.24-4.fc$RELEASEVER.noarch.rpm
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASEVER.noarch.rpm
    https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASEVER.noarch.rpm
    https://download.postgresql.org/pub/repos/yum/reporpms/F-32-x86_64/pgdg-fedora-repo-latest.noarch.rpm
EOF

sudo dnf install -y $REPO_RPMS

# Repo for Albert application launcher
sudo rpm --import https://build.opensuse.org/projects/home:manuelschneid3r/public_key
dnf config-manager --add-repo https://download.opensuse.org/repositories/home:manuelschneid3r/Fedora_32/home:manuelschneid3r.repo

# At some point, the EPEL repo had a typo
# sudo sed -i 's/mirrorlist/metalink/g' /etc/yum.repos.d/epel.repo
