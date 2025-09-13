#/usr/bin/env bash

set -euox pipefail

TEMP=$(mktemp -d)

curl -fLs https://github.com/0xType/0xProto/releases/download/2.500/0xProto_2_500.zip-o $TEMP/0xproto.zip
unzip $TEMP/0xproto.zip

mkdir -p /usr/share/0xproto
cp $TEMP/*.ttf /usr/share/0xproto/

rm -r $TEMP
