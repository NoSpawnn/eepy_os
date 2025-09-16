#!/usr/bin/env bash

set -euxo pipefail

source $UTILS_SH

TEMP=$(mktemp -d)

get_file_from_github "Umio-Yasuno/amdgpu_top" "latest" "amdgpu_top-0.11.0-1.x86_64.rpm" "$TEMP/amdgpu_top.rpm"

dnf5 install $TEMP/amdgpu_top.rpm -y

rm -r $TEMP
