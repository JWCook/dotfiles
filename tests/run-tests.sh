#!/usr/bin/env bash
# Run containerized tests for setup scripts

run_test() {
    distro=$1
    image="test-setup-$distro"
    dockerfile="~/dotfiles/tests/Dockerfile-$distro"
    docker build -t "$image" -f $dockerfile ~/dotfiles \
        && docker run --rm "$image" \
        && docker image rm -f "$image"
}

run_test endeavouros
run_test debian
run_test ubuntu
# run_test fedora
