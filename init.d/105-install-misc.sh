#!/bin/bash

case "$1" in
    init)
        brew install btm
        brew install lsd
        ;;
    clean)
        brew uninstall btm
        brew uninstall lsd
        ;;
esac
