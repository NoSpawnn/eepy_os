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

dnf5 install -y ${PACKAGES[@]}
