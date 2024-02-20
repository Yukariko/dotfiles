#!/bin/bash

case "$1" in
    init)
        confpath="$(git rev-parse --show-toplevel)/conf.d"
	ln -sF "$confpath/.gitconfig" ~/.gitconfig || true
    ;;
    clean)
        rm ~/.gitconfig
        ;;
esac
