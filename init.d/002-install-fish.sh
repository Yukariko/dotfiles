#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi

        brew install fish
        # install omf
	if [ -d "$HOME/.local/share/omf" ]; then 
	    echo "Oh-my-fish is already installed. Skip."
        exit 0
	fi
	fish -c omf &> /dev/null || curl -L https://get.oh-my.fish | fish
        ;;
    clean)
        fish -c omf &> /dev/null && fish -c omf -- destroy
        command -v fish &> /dev/null && brew uninstall fish
        ;;
esac
