#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
        brew install locale
        brew install gcc
        gccpath=$(command -v gcc-11)
        gpppath=$(command -v g++-11)
        ln -s ./gcc-11 ${gccpath%-11} || true
        ln -s ./g++-11 ${gpppath%-11} || true
        ;;
    clean)
        rm -rf $(command -v gcc)
        rm -rf $(command -v g++)
        brew uninstall gcc
        brew uninstall locale
        ;;
esac
