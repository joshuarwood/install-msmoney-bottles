#!/bin/bash

bottlename=$1

path=~/.var/app/com.usebottles.bottles/data/bottles/bottles/${bottlename}
file="${path}/drive_c/windows/syswow64/comctl32.dll"
backup="${file}.bak"

printf "\nRestoring comctl32.dll...\n\n"

if [ ! -f "$file" ]; then
    printf "ERROR: ${file} does not exist.\n"
    printf "       Check bottle named ${bottlename}.\n\n"
    exit 0
fi

cp -v "${backup}" "${file}"
printf "\n"

printf "Done.\n"
