#!/bin/bash

sed -i -E \
	-e "s/readarr-.*?-blue/readarr-${APP_VERSION}-blue/g" \
	README.md
