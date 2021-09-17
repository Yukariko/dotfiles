#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        brew install tmux
        confpath="$(git rev-parse --show-toplevel)/conf.d"
        if [ -e "$confpath/.tmux.conf" ]; then
            ln -s $confpath/.tmux.conf ~/.tmux.conf
        fi
        ;;
    clean)
        brew uninstall tmux
        rm -rf ~/.tmux.conf
        ;;
esac
