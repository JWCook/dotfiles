#!/usr/bin/env bash

# Replace me
ZM_DB_PASS=zmpass
ZM_DIR=/media/zoneminder

# DOCS
####################

# https://github.com/ZoneMinder/zoneminder/blob/master/distros/redhat/readme/README.Fedora
# https://zoneminder.readthedocs.io/en/stable/installationguide/redhat.html
# https://zoneminder.readthedocs.io/en/stable/installationguide/ubuntu.html
# https://wiki.zoneminder.com/Debian_9_64-bit_with_Zoneminder_1.30.4_the_Easy_Way
# http://www.linuxandubuntu.com/home/creating-virtual-disks-using-linux-command-line
# Note: Zoneminder needs a dedicated partition that it can fill up (see create_virtual_partition.sh)


# Packages
####################

# Requires RPMFusion (should already be installed)
sudo dnf install -y zoneminder mod-ssl mariadb-server mariadb v4l-utils
# Should already be installed, but just in case:
sudo dnf install -y httpd httpd-tools php php-common php-mysqlnd vlc


# Config
####################

cp-bak() {
    sudo cp -v "$1"{,.bak} 2> /dev/null
}

# Copy/link config files
# Set "ZM_DB_PASS=$ZM_DB_PASS" in /etc/zm/conf.d/00-auth.conf
cp-bak zoneminder/00-auth.conf /etc/zm/conf.d/00-auth.conf
cp-bak zoneminder/01-system-paths.conf /etc/zm/conf.d/01-system-paths.conf
cp-bak zoneminder/my.cnf /etc/my.cnf
cp-bak apache/00-mpm.conf /etc/httpd/conf.modules.d/00-mpm.conf
cp-bak apache/15-php.conf /etc/httpd/conf.modules.d/15-php.conf
sudo ln -s /etc/zm/www/zoneminder.conf /etc/httpd/conf.d/zoneminder.conf

# File permissions
sudo chmod 640 /etc/zm/*.conf
sudo chown root:apache /etc/zm/*.conf
sudo chmod 640 /etc/zm/conf.d/*.conf
sudo chown root:apache /etc/zm/conf.d/*.conf
sudo chmod 644 /etc/httpd/conf.modules.d/
sudo chown root:root /etc/httpd/conf.modules.d/
sudo chown root:apache $ZM_DIR
sudo chown -R apache:apache $ZM_DIR/events/
sudo chown -R apache:apache $ZM_DIR/images/

# Set PHP timezone
sudo sed -i "s/date\.timezone.*=.*/date\.timezone = \"America\/Chicago\"/" /etc/php.ini

# Disable SELinux (ZoneMinder has no SELinux profile)
sudo setenforce 0
sudo sed -i "s/^SELINUX=.*/SELINUX=disabled/" /etc/selinux/config

# Set Apache to only listen on localhost
# sudo sed -i "s/^Listen 80.*/Listen 127.0.0.1:80/" /etc/httpd/conf/httpd.conf
# sudo sed -i "s/^Listen 443.*/Listen 127.0.0.1:443 https/" /etc/httpd/conf.d/ssl.conf


# Database
####################

sudo systemctl start mariadb
sudo systemctl enable mariadb
mysql_secure_installation

mysql -u root < /usr/share/zoneminder/db/zm_create.sql
mysql -u root -e "GRANT ALL PRIVILEGES ON zm.* to zmuser@'localhost' IDENTIFIED BY $ZM_DB_PASS;"
mysqladmin -u root reload

## DB Backup
####################

# mysqldump -u root zm > zm_backup.sql
# mysql -u root -D zm < zm_backup.sql


# Schedule Run States
####################

source ~/.bashrc
scrontab-append "0 7 30 * 1-5 /usr/bin/zmpkg.pl stop"
scrontab-append "0 18 * * 1-5 /usr/bin/zmpkg.pl mocap"


# Systemd
####################

sudo cp zoneminder/zoneminder.service /usr/lib/systemd/system/zoneminder.service
sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl enable zoneminder
sudo systemctl start zoneminder
xdg-open https://localhost/zm


# Troubleshooting
####################

# Configuration is apparently corruptible?
# mysql -u root -D zm -e "DELETE FROM Config;"
# restore from backup


# TODO
####################

# * Apache security/remote access
# * Dockerize this stuff

docker pull quantumobject/docker-zoneminder
