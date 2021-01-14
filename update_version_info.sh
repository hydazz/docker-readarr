#!/bin/bash

OVERLAY_VERSION=$(curl -sX GET "https://raw.githubusercontent.com/hydazz/docker-baseimage-alpine-arr/main/version_info.json" | jq -r .overlay_version)

OLD_OVERLAY_VERSION=$(jq <version_info.json -r .overlay_version)
OLD_READARR_RELEASE=$(jq <version_info.json -r .readarr_release)

sed -i \
	-e "s/${OLD_OVERLAY_VERSION}/${OVERLAY_VERSION}/g" \
	-e "s/${OLD_READARR_RELEASE}/${READARR_RELEASE}/g" \
	README.md

NEW_VERSION_INFO="overlay_version|readarr_release
${OVERLAY_VERSION}|${READARR_RELEASE}"

jq -Rn '
( input  | split("|") ) as $keys |
( inputs | split("|") ) as $vals |
[[$keys, $vals] | transpose[] | {key:.[0],value:.[1]}] | from_entries
' <<<"$NEW_VERSION_INFO" >version_info.json
