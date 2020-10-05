#!/bin/bash -
# Install Node.js and npm
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs
node -v && npm -v
sudo npm install -g npm@latest
