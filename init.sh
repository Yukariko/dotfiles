#!/bin/bash

RED='\033[0;31m'
LGREEN='\033[1;32m'
NC='\033[0m'
for file in ./init.d/*; do
    echo -e "run ${LGREEN}$(basename "$file")${NC}"
    $file "init"
    if [ $? -ne 0 ]; then
        echo -e "${RED}failed.${NC}"
    else
        echo -e "${LGREEN}done.${NC}"
    fi
done
