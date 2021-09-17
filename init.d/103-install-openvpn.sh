#!/bin/bash

set -euo pipefail

[[ "$OSTYPE" == "linux-gnu"* ]] || {
    echo "OpenVPN has a gui application. You can download it from the link below."
    echo "https://openvpn.net/community-downloads/"
    exit 0
}

case "$1" in
    init)
        brew install openvpn
        ;;
    clean)
        brew uninstall openvpn
        ;;
esac
