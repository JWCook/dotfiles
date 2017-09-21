#!/usr/bin/env bash

# Install Postgres 9.6 for CentOS 7; for other distros, see https://yum.postgresql.org/repopackages.php

PG_REPO='https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm'
PG_PKGS='postgresql96-devel postgresql96-server postgis2_96-devel freetds-devel unixODBC-devel'

sudo yum install -y $PG_REPO
sudo yum update -y
sudo yum install -y $PG_PKGS
