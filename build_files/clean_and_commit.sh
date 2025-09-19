#!/usr/bin/env bash

# Thanks https://github.com/ublue-os/bazzite/blob/main/build_files/cleanup

set -eoux pipefail

dnf5 clean all
rm -rf /tmp/* || true

ostree container commit
