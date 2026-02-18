#!/usr/bin/env bash
# Run containerized setup script tests

cd ~/dotfiles
docker build -t test-setup-debian -f tests/Dockerfile-debian .
docker run --rm test-setup-debian
docker build -t test-setup-ubuntu -f tests/Dockerfile-ubuntu .
docker run --rm test-setup-ubuntu
# docker build -t test-setup-fedora -f tests/Dockerfile-fedora .
# docker run --rm test-setup-fedora
