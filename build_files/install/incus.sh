#!/usr/bin/env bash

# At the time of writing, the incus-agent binary in the DNF repos is broken due to dynamic linking,
# so install it manually for now
# - https://bugzilla.redhat.com/show_bug.cgi?id=2389081

set -euxo pipefail

source $UTILS_SH

dnf5 install -y incus incus-agent qemu qemu-system-x86

TEMP=$(mktemp -d)

INCUS_PATH=$(which incus)
rm $INCUS_PATH
get_file_from_github "lxc/incus" "latest" "bin.linux.incus.x86_64" "$TEMP/incus"
mv $TEMP/incus $INCUS_PATH
chmod 0755 $INCUS_PATH

INCUS_AGENT_PATH=$(which incus-agent)
rm $INCUS_AGENT_PATH
get_file_from_github "lxc/incus" "latest" "bin.linux.incus-agent.x86_64" "$TEMP/incus-agent"
mv $TEMP/incus-agent $INCUS_AGENT_PATH
chmod 0755 $INCUS_AGENT_PATH

# Also install ssh2inucus - https://github.com/mobydeck/ssh2incus
get_file_from_github "mobydeck/ssh2incus" "latest" ".*x86_64\.rpm" "$TEMP/ssh2incus.rpm"
dnf install -y $TEMP/ssh2incus.rpm

rm -r $TEMP

systemctl enable incus.service
systemctl enable ssh2incus.service
