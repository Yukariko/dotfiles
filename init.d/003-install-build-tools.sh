#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
        brew install gcc
        gccpath=$(command -v gcc-13)
        gpppath=$(command -v g++-13)
        ln -sF ./gcc-13 ${gccpath%-13} || true
        ln -sF ./g++-13 ${gpppath%-13} || true
        ;;
    clean)
        rm -rf $(command -v gcc)
        rm -rf $(command -v g++)
        brew uninstall gcc
        ;;
esac
