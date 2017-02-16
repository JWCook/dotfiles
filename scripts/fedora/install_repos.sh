#!/usr/bin/env bash

# Install additional repos for Fedora 25
# Nux: http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm

read -d '' REPO_RPMS << EOF
    ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/KAMiKAZOW:/Fedora/CentOS_7/noarch/gdouros-symbola-fonts-8.00-5.1.noarch.rpm
    https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-25.noarch.rpm
    http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
    https://rhel7.iuscommunity.org/ius-release.rpm
EOF

sudo yum install -y $REPO_RPMS
