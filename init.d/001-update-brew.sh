#!/bin/bash

set -euo pipefail

install_brew () {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
}

case "$1" in
    init)
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            [ -d /home/linuxbrew/.linuxbrew/bin ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi

        command -v brew &> /dev/null || install_brew
        brew update || true
        brew upgrade
        ;;
    clean)
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
        ;;
esac
