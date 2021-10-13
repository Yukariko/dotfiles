#!/bin/bash

case "$1" in
    init)
        brew install rust
        ;;
    clean)
        brew uninstall rust
        ;;
esac
