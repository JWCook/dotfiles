#!/usr/bin/env bash

echo 'Installing Haroopad...'
wget -P /tmp/ https://bitbucket.org/rhiokim/haroopad-download/downloads/haroopad-v0.13.1-x64.tar.gz
mkdir /tmp/haroopad
tar -xzf /tmp/haroopad-v0.13.1-x64.tar.gz -C /tmp/haroopad
sudo tar -xvf /tmp/haroopad/data.tar.gz -C /
tar -xzf /tmp/haroopad/control.tar.gz -C /tmp/haroopad/
chmod 755 /tmp/haroopad/postinst
sudo /tmp/haroopad/postinst
rm -rf /tmp/haroopad
rm /tmp/haroopad-v0.13.1-x64.tar.gz

# Fix icon
sudo sed -i "s/Icon=.*/Icon=\/usr\/share\/icons\/hicolor\/128x128\/apps\/haroopad.png/" /usr/share/applications/Haroopad.desktop
