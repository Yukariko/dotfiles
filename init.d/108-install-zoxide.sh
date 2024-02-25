#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        brew install zoxide

        confpath="$(git rev-parse --show-toplevel)/conf.d"
        for conf in "zoxide"; do
            echo $conf
            ln -sF "$confpath/$conf.fish" ~/.config/fish/conf.d/$conf.fish || true
        done
        ;;
    clean)
        rm ~/.config/fish/conf.d/zoxide.fish
        brew uninstall zoxide
        ;;
esac
