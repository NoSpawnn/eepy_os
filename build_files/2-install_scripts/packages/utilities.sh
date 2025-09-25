#!/usr/bin/env bash

set -euxo pipefail

PACKAGES=(
    zsh
    tailscale
    fastfetch
    neovim
    waypipe
)

dnf5 install -y ${PACKAGES[@]}
