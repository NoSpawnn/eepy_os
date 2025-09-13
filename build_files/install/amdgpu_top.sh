#!/usr/bin/env bash

set -euox pipefail

TEMP=$(mktemp -d)

curl -fLs https://github.com/Umio-Yasuno/amdgpu_top/releases/latest/download/amdgpu_top-0.11.0-1.x86_64.rpm -o $TEMP/amdgpu_top.rpm

dnf5 install $TEMP/amdgpu_top.rpm -y

rm -r $TEMP
