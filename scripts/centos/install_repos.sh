#!/usr/bin/env bash

# Install additional repos for CentOS 7
# Nux: http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm

read -d '' REPO_RPMS << EOF
    ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/KAMiKAZOW:/Fedora/CentOS_7/noarch/gdouros-symbola-fonts-8.00-5.1.noarch.rpm
    http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm
    https://centos7.iuscommunity.org/ius-release.rpm
    epel-release
EOF

sudo yum install -y $REPO_RPMS
