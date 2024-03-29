#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        brew install vim
        confpath="$(git rev-parse --show-toplevel)/conf.d"
        ln -sF "$confpath/.vimrc" ~/.vimrc || true
        ;;
    clean)
        brew uninstall vim
        rm -rf ~/.vimrc
        ;;
esac
