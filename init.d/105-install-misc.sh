#!/bin/bash

case "$1" in
    init)
        brew install bottom
        brew install lsd
        ;;
    clean)
        brew uninstall bottom
        brew uninstall lsd
        ;;
esac
