#!/usr/bin/env bash
# Install Docker CE for Fedora

sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce
sudo systemctl enable docker
sudo systemctl start docker

# Add group + membership, if not already set up; must logout and back in to take effect
sudo groupadd docker
sudo usermod -aG docker $USER
