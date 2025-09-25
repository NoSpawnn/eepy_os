#!/usr/bin/env bash

set -euxo pipefail

PACKAGES=(
    zsh
    tailscale
    fastfetch
    neovim
)

dnf5 install -y ${PACKAGES[@]}
