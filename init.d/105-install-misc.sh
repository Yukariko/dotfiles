#!/bin/bash

case "$1" in
    init)
        if [[ "$OSTYPE" == "darwin"* ]]; then
            brew install bottom
        else
            brew install ClementTsang/bottom/bottom
        fi
        brew install ripgrep
        brew install fzf
        brew install lsd
        ;;
    clean)
        brew uninstall bottom
        brew uninstall lsd
        brew uninstall ripgrep
        brew uninstall fzf
        ;;
esac
