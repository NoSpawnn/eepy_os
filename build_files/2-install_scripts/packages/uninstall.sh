#!/usr/bin/env bash

# Packages to uninstall

set -euxo pipefail

PACKAGES=(
    firefox firefox-langpacks
    nvtop # WE ARE AN AMD HOUSEHOLD
    toolbox # Using distrobox instead
)

dnf5 remove -y ${PACKAGES[@]}
