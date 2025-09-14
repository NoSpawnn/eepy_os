#/usr/bin/env bash
# https://docs.fedoraproject.org/en-US/quick-docs/fonts/

set -euox pipefail

TEMP=$(mktemp -d)

curl -fLs https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip -o $TEMP/0xproto.zip
unzip $TEMP/0xproto.zip -d $TEMP

mkdir /usr/share/fonts/0xproto
cp $TEMP/*.ttf /usr/share/fonts/0xproto/
chown -R root: /usr/share/fonts/0xproto
chmod 644 /usr/share/fonts/0xproto/*
restorecon -vFr /usr/share/fonts/0xproto

rm -r $TEMP
