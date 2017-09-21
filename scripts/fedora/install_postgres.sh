#!/usr/bin/env bash

# Install Postgres 9.6 for Fedora 25; for other distros, see https://yum.postgresql.org/repopackages.php

PG_REPO='https://download.postgresql.org/pub/repos/yum/9.6/fedora/fedora-25-x86_64/pgdg-fedora96-9.6-3.noarch.rpm'
PG_PKGS='postgresql96-devel postgresql96-server postgis2_96-devel freetds-devel unixODBC-devel'

sudo dnf install -y $PG_REPO
sudo dnf update -y
sudo dnf install -y $PG_PKGS
