#!/bin/bash

bottlename=$1

path=~/.var/app/com.usebottles.bottles/data/bottles/bottles/${bottlename}
ie7installer="ie7-windowsxp-x86-enu.exe"
system="${path}/drive_c/windows/syswow64"

printf "Copying ie7 to ${path}\n"
if [ -d $path ]; then
    printf "\n"
    #cabextract -d ie7-windowsxp-x86-enu $ie7installer

    if [ -d $system ]; then
        printf "GOOD: ${system} exists.\n\n"
    else
        printf "\nERROR: ${system} does not exist.\n"
	exit 0
    fi

    #cp -v ie7-windowsxp-x86-enu/* $system
    #mv -v $system/iexplore.exe $system/iexplore.exe.bak
    cp -v ie7dlls.reg $system
    cp -v ie7cmds.cmd $system

    printf "\nDone.\n"
else
    printf "    ERROR: Could not locate directory. Check path and ensure a bottle exists for ${bottlename}.\n"
fi
