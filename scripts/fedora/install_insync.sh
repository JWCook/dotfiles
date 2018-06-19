#!/usr/bin/env bash

RPM_KEY='https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key'

cat << EOF > /etc/yum.repos.d/insync.repo
[insync]
name=insync repo
baseurl=http://yum.insynchq.com/fedora/\$releasever/
gpgcheck=1
gpgkey=$RPM_KEY
enabled=1
metadata_expire=120m
EOF
rpm --import $RPM_KEY
dnf install -y insync
