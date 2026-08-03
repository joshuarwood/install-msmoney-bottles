#!/bin/bash

bottlename=$1

path=~/.var/app/com.usebottles.bottles/data/bottles/bottles/${bottlename}
file="${path}/drive_c/windows/syswow64/comctl32.dll"

printf "\nPatching comctl32.dll...\n\n"

if [ ! -f "$file" ]; then
    printf "ERROR: ${file} does not exist.\n"
    printf "       Check bottle named ${bottlename}.\n\n"
    exit 0
fi

backup="${file}.bak"
if [ ! -f "$backup" ]; then
    printf "Creating backup...\n\n"
    cp -v "${file}" "${backup}"
    printf "\n"
fi

printf "Updating...\n\n"
cp -v comctl32.dll "${file}"
printf "\n"

printf "Done.\n"
