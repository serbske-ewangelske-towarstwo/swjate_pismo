#!/bin/bash

rm -rf 03_out
mkdir -p 03_out

for i in $(find 02_out/ -name "*.txt" | sort); do
	echo $i;
	perl ./03_replace_spelling.pl $i $(echo $i | sed -e s/02_out/03_out/)
done
