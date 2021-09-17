#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        command -v fish &> /dev/null && {
            echo "Fish is already installed. Skip."
            exit 0
        }
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi

        brew install fish
        # install omf
        curl -L https://get.oh-my.fish | fish
        ;;
    clean)
        command -v fish &> /dev/null && brew uninstall fish
        command -v omf &> /dev/null && omf destroy
        ;;
esac
