#!/usr/bin/env bash

set -euox pipefail

curl -fLs --create-dirs https://raw.githubusercontent.com/wiiznokes/fan-control/master/res/linux/60-fan-control.rules \
    -o /usr/lib/udev/rules.d/60-fan-control.rules
