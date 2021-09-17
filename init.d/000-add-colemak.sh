#!/bin/bash

tmpPath="/tmp/colemak"

[[ "$OSTYPE" == "darwin"* ]] || {
    echo "This script can only be run on macOS yet. Skip."
    exit 0
}

set -euo pipefail

case "$1" in
    init)
        [ -d ~/Library/Keyboard\ Layouts/Colemak\ DH.bundle ] && {
            echo "Colemak aleady installed. Skip."
            exit 0
        }
        git clone https://github.com/ColemakMods/mod-dh.git "$tmpPath"
        cp -R "$tmpPath/macOS/Colemak DH.bundle" ~/Library/Keyboard\ Layouts/ || {
            rm -rf "$tmpPath"
            exit 1
        }
        rm -rf "$tmpPath"
        read -p "You need to update your keyboard layout in settings. [Enter]" yn
        ;;
    clean)
        read -p "You need to remove your colemak keyboard layout in settings. [Enter]" yn
        rm -rf ~/Library/Keyboard\ Layouts/Colemak\ DH.bundle
        ;;
esac
