#!/usr/bin/env bash

set -euxo pipefail

SYSTEM_UNITS_ENABLED=(
    tailscaled.service
    incus.service
    incus.socket
    ssh2incus.service
)

for unit in ${SYSTEM_UNITS_ENABLED[@]}; do
    systemctl enable "$unit"
done
