#!/usr/bin/env bash

set -exo pipefail

if [[ -z "$1" ]]; then
    echo "coprs.sh requires an argument, one of: --enable --disable"
    exit 1
fi

if [[ "$1" =~ ^- && ! "$1" == "--" ]]; then case "$1" in
  --enable )
    ACTION="enable"
    ;;
  --disable )
    ACTION="disable"
    ;;
esac; fi
shift

COPRS=(
    "bazzite-org/bazzite"
    "bazzite-org/bazzite-multilib"
    "ublue-os/staging"
)

for copr in ${COPRS[@]}; do
    dnf5 -y copr "$ACTION" "$copr"
    if [[ "$ACTION" == "enable" ]]; then
        dnf5 -y config-manager setopt copr:copr.fedorainfracloud.org:${copr////:}.priority=98
    fi
done
