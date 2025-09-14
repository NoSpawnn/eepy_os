#/usr/bin/env bash
# https://docs.fedoraproject.org/en-US/quick-docs/fonts/

set -euox pipefail

TEMP=$(mktemp -d)
FONT_DIR=/var/usrlocal/share/fonts/0xproto

curl -fLs https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip -o $TEMP/0xproto.zip
unzip $TEMP/0xproto.zip -d $TEMP

mkdir -p $FONT_DIR
cp $TEMP/*.ttf $FONT_DIR/
chown -R root: $FONT_DIR
chmod 644 $FONT_DIR/*
restorecon -vFr $FONT_DIR

rm -r $TEMP
