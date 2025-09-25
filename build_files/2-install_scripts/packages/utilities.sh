#!/usr/bin/env bash

set -euxo pipefail

PACKAGES=(
    tailscale
    fastfetch
    waypipe
    just
    dmidecode
)

dnf5 install -y ${PACKAGES[@]}
