#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi

        brew install fish
        # install omf
        fish -c omf &> /dev/null || curl -L https://get.oh-my.fish | fish
        ;;
    clean)
        fish -c omf &> /dev/null && fish -c omf -- destroy
        command -v fish &> /dev/null && brew uninstall fish
        ;;
esac
