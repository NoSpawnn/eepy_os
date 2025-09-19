#!/usr/bin/env bash

set -euxo pipefail

PACKAGES=(
    zsh
    zsh-autosuggestions
    tailscale
    fastfetch
    flatpak
    neovim
)

for package in ${PACKAGES[@]}; do
    dnf5 install -y "$package"
done
