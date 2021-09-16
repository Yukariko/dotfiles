#!/bin/bash

tmpPath="/tmp/colemak"

git clone https://github.com/ColemakMods/mod-dh.git "$tmpPath"

cp -r "$tmpPath/macOS/Colemak DH.bundle" ~/Library/Keyboard\ Layouts/

rm -rf "$tmpPath"
