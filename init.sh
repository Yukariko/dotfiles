#!/bin/bash

RED='\033[0;31m'
LGREEN='\033[1;32m'
NC='\033[0m'

# run preinit scripts
for file in ./init.d/0*; do
    echo -e "run ${LGREEN}$(basename "$file")${NC}"
    if $file "init"; then
        echo -e "${LGREEN}done.${NC}"
    else
        echo -e "${RED}failed.${NC}"
        exit 1
    fi
done

# source brew environment after preinit
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# run init scripts
for file in ./init.d/[1-9]*; do
    echo -e "run ${LGREEN}$(basename "$file")${NC}"
    if $file "init"; then
        echo -e "${LGREEN}done.${NC}"
    else
        echo -e "${RED}failed.${NC}"
    fi
done
