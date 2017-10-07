#!/usr/bin/env bash

cat << EOF > /etc/yum.repos.d/insync.repo
[insync]
name=insync repo
baseurl=http://yum.insynchq.com/fedora/25/
gpgcheck=1
gpgkey=https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key
enabled=1
metadata_expire=120m
EOF
rpm --import https://d2t3ff60b2tol4.cloudfront.net/repomd.xml.key
yum install -y insync
