#!/usr/bin/env bash

# Packages to uninstall

set -euxo pipefail

PACKAGES=(
    toolbox
)

dnf5 remove -y ${PACKAGES[@]}
