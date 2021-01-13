#!/bin/bash
RPM_URL='https://github.com/duplicati/duplicati/releases/download/v2.0.5.1-2.0.5.1_beta_2020-01-18/duplicati-2.0.5.1-2.0.5.1_beta_20200118.noarch.rpm'

sudo dnf install -y mono-devel libappindicator-sharp
sudo dnf install -y $RPM_URL
