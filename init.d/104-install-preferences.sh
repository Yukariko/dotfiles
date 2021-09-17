#!/bin/bash

set -euo pipefail


case "$1" in
    init)
        git clone git@github.com:Yukariko/preferences.git ~/preferences || {
            cd ~/preferences
            git pull
        }
        ~/preferences/install.sh
        ;;
    clean)
        rm -rf ~/preferences
        ;;
esac
