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
        else
            fish -c omf &> /dev/null || curl -L https://get.oh-my.fish | fish
        fi

        confpath="$(git rev-parse --show-toplevel)/conf.d"
        for conf in "prompt" "alias" "brew"; do
            echo $conf
            ln -sF "$confpath/$conf.fish" ~/.config/fish/conf.d/$conf.fish || true
        done
        ;;
    clean)
        fish -c omf &> /dev/null && fish -c omf -- destroy
        command -v fish &> /dev/null && brew uninstall fish
        ;;
esac
