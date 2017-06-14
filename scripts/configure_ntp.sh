#!/usr/bin/env bash

sudo chkconfig ntpd on
sudo ntpdate pool.ntp.org
sudo service ntpd start
