#!/usr/bin/env bash

# At the time of writing, the incus-agent binary in the DNF repos is broken due to dynamic linking,
# so install it manually for now
# - https://bugzilla.redhat.com/show_bug.cgi?id=2389081

set -euox pipefail

dnf5 install -y incus incus-agent qemu qemu-system-x86

TEMP=$(mktemp -d)

INCUS_PATH=$(which incus)
rm $INCUS_PATH
curl -fLs https://github.com/lxc/incus/releases/latest/download/bin.linux.incus.x86_64 -o $TEMP/incus
mv $TEMP/incus $INCUS_PATH
chmod 0755 $INCUS_PATH

INCUS_AGENT_PATH=$(which incus-agent)
rm $INCUS_AGENT_PATH
curl -fLs https://github.com/lxc/incus/releases/latest/download/bin.linux.incus-agent.x86_64 -o $TEMP/incus-agent
mv $TEMP/incus-agent $INCUS_AGENT_PATH
chmod 0755 $INCUS_AGENT_PATH

rm -r $TEMP

systemctl enable incus.service
