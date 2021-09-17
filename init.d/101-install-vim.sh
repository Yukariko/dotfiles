#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        brew install vim
        confpath="$(git rev-parse --show-toplevel)/conf.d"
        if [ -e "$confpath/.vimrc" ]; then
            ln -s $confpath/.vimrc ~/.vimrc
        fi
        ;;
    clean)
        brew uninstall vim
        rm -rf ~/.vimrc
        ;;
esac
