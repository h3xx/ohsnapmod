#!/bin/sh
for font in $(xlsfonts |grep ohsnapmod |uniq); do
	xterm \
		-fn "$font" \
		-geometry 64x10 \
		-e "echo $font ; cat test.txt ; read" || exit
done
