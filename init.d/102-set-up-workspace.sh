#!/bin/bash

set -euo pipefail

case "$1" in
    init)
        mkdir ~/git || true
        git clone git@github.com:Yukariko/ps_env.git ~/git/code
        ;;
    clean)
        rm -rf ~/git
        ;;
esac
