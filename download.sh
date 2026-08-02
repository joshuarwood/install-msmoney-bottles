#!/bin/bash

printf "\nDownloading files...\n\n"

for entry in \
    "https://archive.org/download/ie7-windowsxp-x86-enu_202603/ie7-windowsxp-x86-enu.exe 3f3e6315efda6316ae04640516d060ed" \
    "https://archive.org/download/MSMoneySunset/USMoneyDlxSunset.exe f810ab18bb4347f86ba21410ddbcc11a"; do

    # split string into url and checksum components
    set -- $entry
    url=$1
    checksum=$2

    # download with wget
    wget $url

    # validate checksums to ensure files haven't been tampered with
    path="$(echo ${url:7} | rev | cut -d/ -f 1 | rev)"
    thischecksum=`md5sum $path | cut -d' ' -f 1`
    if [ $checksum = $thischecksum ]; then
        printf "Successfully downloaded ${path}\n"
	printf "   GOOD md5sum ${checksum} == ${thischecksum}\n\n"
    else
	printf "ERROR: Removing ${path} due to failed checksum\n"
	printf "    BAD md5sum ${checksum} != ${thischecksum}\n\n"
	rm ${path}
	exit 0
    fi
done

