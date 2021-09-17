#!/bin/bash

RED='\033[0;31m'
LGREEN='\033[1;32m'
NC='\033[0m'
for file in ./init.d/0*; do
    echo -e "run ${LGREEN}$(basename "$file")${NC}"
    if $file "init"; then
        echo -e "${LGREEN}done.${NC}"
    else
        echo -e "${RED}failed.${NC}"
        exit 1
    fi
done

for file in ./init.d/[1-9]*; do
    echo -e "run ${LGREEN}$(basename "$file")${NC}"
    if $file "init"; then
        echo -e "${LGREEN}done.${NC}"
    else
        echo -e "${RED}failed.${NC}"
    fi
done
