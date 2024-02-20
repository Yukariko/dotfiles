#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        brew install tmux
        confpath="$(git rev-parse --show-toplevel)/conf.d"
        ln -sF "$confpath/.tmux.conf" ~/.tmux.conf || true
        ;;
    clean)
        brew uninstall tmux
        rm -rf ~/.tmux.conf
        ;;
esac
