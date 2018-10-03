#!/usr/bin/env bash

# Install Postgres 9.6 for Fedora 28
# PG_REPO='https://download.postgresql.org/pub/repos/yum/9.6/fedora/fedora-28-x86_64/pgdg-fedora96-9.6-4.noarch.rpm'
# PG_PKGS='postgresql96-devel postgresql96-server postgis2_96-devel freetds-devel unixODBC-devel'

# Install Postgres 10 for Fedora 28; for other distros, see https://yum.postgresql.org/repopackages.php
PG_REPO='https://download.postgresql.org/pub/repos/yum/10/fedora/fedora-28-x86_64/pgdg-fedora10-10-4.noarch.rpm'
PG_PKGS='postgresql10-devel postgresql10-server postgis24_10-devel freetds-devel unixODBC-devel'
# PG_PKGS='postgresql-devel postgresql-server postgis-devel freetds-devel unixODBC-devel'

sudo dnf install -y $PG_REPO
sudo dnf update -y
sudo dnf install -y $PG_PKGS
