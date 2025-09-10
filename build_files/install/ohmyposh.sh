#!/usr/bin/env bash

set -euox pipefail

TEMP=$(mktemp -d)

curl -s https://ohmyposh.dev/install.sh -o $TEMP/install.sh

bash $TEMP/install.sh -d /usr/bin

rm -r $TEMP