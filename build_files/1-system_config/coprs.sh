#!/usr/bin/env bash

COPRS_ENABLED=(
    "bazzite-org:bazzite"
    "bazzite-org:bazzite-multilib"
    "ublue-os:staging"
)

for copr in ${COPRS_ENABLED[@]}; do
    dnf5 -y copr enable "$copr"
done
