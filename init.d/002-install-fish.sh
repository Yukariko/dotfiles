#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi

        brew install fish

        confpath="$(git rev-parse --show-toplevel)/conf.d"
        if [ -e "$confpath/prompt.fish" ]; then
            ln -s "$confpath/prompt.fish" ~/.config/fish/conf.d/prompt.fish || true
        fi

        if [ -e "$confpath/alias.fish" ]; then
            ln -s "$confpath/alias.fish" ~/.config/fish/conf.d/alias.fish || true
        fi

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
